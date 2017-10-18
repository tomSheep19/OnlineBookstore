using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Runtime.CompilerServices;
using System.Web;

namespace OnlineBookStore.App_Code
{


    public class Manager : User
    {
        public enum Ranks
        {
            Ordinary, Advanced
        }
        private string truename;
        private Ranks rank;
        #region
        public string trueName
        {
            set { truename = value; }
            get { return truename; }
        }

        public Ranks Rank
        {
            set { rank = value; }
            get { return rank; }
        }
        #endregion

        public Manager(string name)
            : base(name, null)
        {

        }

        /// <summary>
        /// 更新图书信息
        /// </summary>
        /// <param name="prbook"></param>
        /// <param name="curbook"></param>
        /// <returns></returns>
        public int UpdateBook( Book curbook)
        {
            SqlConnection sql = DataBaseOperations.CreateConnection();
            string cmdText = "update Book set BookName='" + curbook.bookName +
                             "',BookAuthor='" + curbook.bookAuthor + "',BookPrice='" + curbook.bookPrice +
                             "',BookPress='" + curbook.bookPress + "',BookDetail='" + curbook.bookDetail +
                             "',BookCategory='" + curbook.bookCategory + "',BookImageURL='" + curbook.bookImageURL +
                             "',Rating='" + curbook.Rating + "',ShelveDate='" + GetCurrentTime() + "',Inventory='" +
                             curbook.Inventory + "' where BookID='"+curbook.bookID+"'" ;
            int state = DataBaseOperations.ReviseDataToDataBase(cmdText, sql);
            sql.Close();
            if (state == 1)
            {
                return 0;
            }

            return 1;

        }
        /// <summary>
        /// 将书籍添加到数据库
        /// 成功返回0
        /// 失败返回1
        /// </summary>
        /// <param name="book"></param>
        /// <returns></returns>
        public int AddBookToDB(Book book)
        {
            SqlConnection sql = DataBaseOperations.CreateConnection();
            string cmdText = "insert into Book values('" + book.bookID + "','" + book.bookName + "','" + book.bookAuthor +
                             "','" + book.bookPrice + "','" + book.bookPress + "','" + book.bookDetail + "','" +
                             book.bookCategory + "','" + book.bookImageURL + "','0','" + GetCurrentTime() + "','" +
                             book.Inventory + "')";
            int state = DataBaseOperations.ReviseDataToDataBase(cmdText, sql);
            sql.Close();
            if (state == 1)
            {
                return 0;
            }

            return 1;
        }

        /// <summary>
        /// 从数据库中删除某本书籍
        /// 成功返回0
        /// 失败返回1
        /// </summary>
        /// <param name="book"></param>
        /// <returns></returns>
        public int DeleteBookFromDB(Book book)
        {
            SqlConnection sql = DataBaseOperations.CreateConnection();
            string cmdText = "delete from Book where BookID='" + book.bookID + "'";
            int state = DataBaseOperations.ReviseDataToDataBase(cmdText, sql);
            sql.Close();
            if (state == 1)
            {
                return 0;
            }
            return 1;
        }

        /// <summary>
        /// 更新图书信息
        /// </summary>
        /// <param name="book"></param>
        /// <returns></returns>
        public int ReviseBookInformation(Book book)
        {
            return AddBookToDB(book);
        }

        /// <summary>
        /// 冻结/解冻用户账号
        /// </summary>
        /// <param name="customer">顾客</param>
        /// <param name="state">1：冻结 </param>
        /// <returns></returns>
        public int RestrictOrPermitCustomerLogin(string userName, int state)
        {
            string cmdText1, cmdText2;
            if (state == 1)
            {
                cmdText1 = "update Users set LegalityState=1 where Name='" + userName + "'";
                cmdText2 = "update Customer set LegalityState=1 where Name='" + userName + "'";
            }
            else
            {
                cmdText1 = "update Users set LegalityState=0 where Name='" + userName + "'";
                cmdText2 = "update Customer set LegalityState=0 where Name='" + userName + "'";
            }

            SqlConnection sql = DataBaseOperations.CreateConnection();
            int state1 = DataBaseOperations.ReviseDataToDataBase(cmdText1, sql);
            int state2 = DataBaseOperations.ReviseDataToDataBase(cmdText2, sql);
            sql.Close();
            if (state1 == 1 && state2 == 1)
            {
                return 0;
            }
            return 1;
        }

        /// <summary>
        /// 模糊查找用户订单
        /// </summary>
        /// <returns></returns>
        public List<Order> QueryOrderInformation(string orderId)
        {
            SqlConnection sql = DataBaseOperations.CreateConnection();
            string cmdText;
            string preOrderId = null;//上一个订单号
            string curOrderId;//当前订单号
            List<Order> orderList = new List<Order>();//订单列表
            Order order;//订单

            if (orderId == "null")
            {
                //查询所有订单
                cmdText =
                    "select a.OrderID,a.UserName,a.Address,a.Remark,a.Price,a.isValid,a.OrderDate,b.BookID,b.Amount,c.BookName,c.BookAuthor,c.BookPrice,c.BookPress,c.BookDetail,c.BookCategory,c.BookImageURL,c.ShelveDate,c.Inventory,c.Rating from [Order] a inner join [OrderDetail] b on a.OrderID=b.OrderID inner join [Book] c on b.BookID=c.BookID order by a.OrderID desc";
            }

            else
            {
                //根据订单号查询订单
                cmdText = "select a.OrderID,a.UserName,a.Address,a.Remark,a.Price,a.isValid,a.OrderDate,b.BookID,b.Amount,c.BookName,c.BookAuthor,c.BookPrice,c.BookPress,c.BookDetail,c.BookCategory,c.BookImageURL,c.ShelveDate,c.Inventory,c.Rating from [Order] a inner join [OrderDetail] b on a.OrderID=b.OrderID inner join [Book] c on b.BookID=c.BookID where a.OrderID='" + orderId + "' order by a.OrderID desc";
            }


            DataSet dataSet = DataBaseOperations.GetDataSet(cmdText, sql);
            if (dataSet != null)
            {

                for (int i = 0; i < dataSet.Tables[0].Rows.Count; i++)
                {

                    curOrderId = dataSet.Tables[0].Rows[i][0].ToString();//获取到当前订单id
                    ShippingAddress shippingAddress = new ShippingAddress(dataSet.Tables[0].Rows[i][2].ToString(), dataSet.Tables[0].Rows[i][3].ToString());//创建收货对象

                    //创建book对象
                    Book aBook = new Book(dataSet.Tables[0].Rows[i][7].ToString(),
                        dataSet.Tables[0].Rows[i][9].ToString(), dataSet.Tables[0].Rows[i][10].ToString(),
                        Convert.ToDecimal(dataSet.Tables[0].Rows[i][11]), dataSet.Tables[0].Rows[i][12].ToString(),
                        dataSet.Tables[0].Rows[i][13].ToString(), dataSet.Tables[0].Rows[i][14].ToString(),
                        dataSet.Tables[0].Rows[i][15].ToString(),
                        Convert.ToInt32(dataSet.Tables[0].Rows[i][17]), Convert.ToInt32(dataSet.Tables[0].Rows[i][18]), dataSet.Tables[0].Rows[i][16].ToString());
                    //创建bookItem对象（book对象，book的数量）
                    BookItem bookItem = new BookItem(aBook, Convert.ToInt32(dataSet.Tables[0].Rows[i][8]));

                    //图书来自不同的订单
                    if (!isFromSameOrder(preOrderId, curOrderId))
                    {
                        order = new Order();//新建订单，初始化bookItemList
                        //不同的订单需要设置 OrerId/userName/orderPrice/isValid/oderDate/shippingAddress
                        //相同订单的信息已经设置过了，不需要重新设置
                        order.SetOrderInformation(dataSet.Tables[0].Rows[i][0].ToString(),
                        dataSet.Tables[0].Rows[i][1].ToString(), Convert.ToDecimal(dataSet.Tables[0].Rows[i][4]),
                        Convert.ToInt32(dataSet.Tables[0].Rows[i][5]), dataSet.Tables[0].Rows[i]["OrderDate"].ToString(),
                        shippingAddress);
                    }
                    else
                    {

                        order = orderList[orderList.Count - 1];//获取到订单列表的最后一个订单
                        orderList.RemoveAt(orderList.Count - 1);//删除这个订单信息

                    }

                    order.bookItemList.Add(bookItem);//将bookItem添加到bookItemList中
                    orderList.Add(order);//将order添加到orderList中  
                    //设置订单的OrderID/UserName/价格/状态/OrderDate/ShippingAddres

                    preOrderId = curOrderId;//处理完一个订单后，将curOrderId赋值给preOrderId

                }
            }
            sql.Close();//关闭sql连接
            return orderList;

        }

        /// <summary>
        /// 查询用户信息
        /// </summary>
        /// <param name="userName"></param>
        /// <returns></returns>
        public static List<Customer> QueryUserInformation(string userName)
        {

            List<Customer> qureyUsers = new List<Customer>();
            SqlConnection sql = DataBaseOperations.CreateConnection();//数据库连接符
            string cmdText = null;
            if (userName == "null")
            {
                cmdText = "select * from [Customer]";//查询所有用户
            }
            else
            {
                cmdText = "select * from [Customer] where Name='" + userName + "'";//查询某个用户
            }

            DataSet data = DataBaseOperations.GetDataSet(cmdText, sql);
            for (int i = 0; i < data.Tables[0].Rows.Count; i++)
            {
                Customer user = new Customer(data.Tables[0].Rows[i]["Name"].ToString(),
                    data.Tables[0].Rows[i]["Password"].ToString(), Convert.ToInt32(data.Tables[0].Rows[i]["CustomerSex"]),
                    data.Tables[0].Rows[i]["SecurityQuestion"].ToString(),
                    data.Tables[0].Rows[i]["SecurityQuestionAnswer"].ToString(), Convert.ToInt32(data.Tables[0].Rows[i]["LegalityState"]));

                qureyUsers.Add(user);

            }
            return qureyUsers;

        }
        /// <summary>
        /// 获取系统当前时间
        /// </summary>
        /// <returns></returns>
        private static string GetCurrentTime()
        {
            DateTime time = DateTime.Now;
            string year = time.Year.ToString();
            string month = time.Month.ToString();
            string day = time.Day.ToString();
            string currentTime = year + "-" + month + "-" + day;
            return currentTime;
        }

    }
}