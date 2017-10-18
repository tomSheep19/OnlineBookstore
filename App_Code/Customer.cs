using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;

namespace OnlineBookStore.App_Code
{

    public class Customer:User
    {
        private int customersex;
        private string securityquestion;
        private string securityquestionanswer;
        private int legalitystate;
        private ShoppingCart shoppingcart;

        /// <summary>
        /// get/set
        /// </summary>
#region
        public int customerSex
        {
            set { customersex = value; }
            get { return customersex; }
        }

        public string securityQuestion
        {
            set { securityquestion = value; }
            get { return securityquestion; }
        }

        public string securityQuestionAnswer
        {
            set { securityquestionanswer = value; }
            get { return securityquestionanswer; }
        }

        public int legalityState
        {
            set { legalitystate = value; }
            get { return legalitystate; }
        }

        public ShoppingCart ShoppingCart
        {
            get { return shoppingcart;}
        }
#endregion

        public Customer()
        {
            
        }
        public Customer(string name):base(name,null)
        {
            shoppingcart = new ShoppingCart();
            
        }
        /// <summary>
        /// 带参构造方法
        /// </summary>
        /// <param name="name">用户名</param>
        /// <param name="password">密码</param>
        /// <param name="customersex">性别</param>
        /// <param name="securityquestion">安全问题</param>
        /// <param name="securityquestionanswer">安全问题答案</param>
        
        public Customer(string name, string password, int customersex, string securityquestion,
           string securityquestionanswer):base(name,password)
        {
            
            this.customersex = customersex;
            this.securityquestion = securityquestion;
            this.securityquestionanswer = securityquestionanswer;
            this.legalitystate = 0;
            this.Powers = Power.Customer;

        }

        /// <summary>
        /// 带参数构造方法
        /// 用于数据库返回时构造
        /// </summary>
        /// <param name="name"></param>
        /// <param name="password"></param>
        /// <param name="customersex"></param>
        /// <param name="securityquestion"></param>
        /// <param name="securityquestionanswer"></param>
        /// <param name="legalitystate"></param>
        public Customer(string name, string password, int customersex, string securityquestion,
           string securityquestionanswer, int legalitystate)
            : base(name, password)
        {

            this.customersex = customersex;
            this.securityquestion = securityquestion;
            this.securityquestionanswer = securityquestionanswer;
            this.legalitystate = legalitystate;
            this.Powers = Power.Customer;

        } 
        /// <summary>
        /// 用户注册
        /// 0：成功注册
        /// 1：用户已存在
        /// </summary>
        /// <param name="name"></param>
        /// <param name="password"></param>
        /// <param name="customersex"></param>
        /// <param name="securityquestion"></param>
        /// <param name="securityquestionanswer"></param>
        /// <returns></returns>
        public int Register()
        {
            SqlConnection sql = DataBaseOperations.CreateConnection();//建立数据库连接
            string cmdText="select * from Users where Name='"+Name+"'";
            SqlDataReader sqlDataReader = DataBaseOperations.GetSqlDataReader(cmdText, sql);//查询数据库中是否有该用户

            if (sqlDataReader.HasRows)//搜索结果中有数据，说明已经注册
            {
                sqlDataReader.Close();//关闭sqlDataReader(必要操作！！)
                sql.Close();//关闭sql连接
                return 1;//用户名已经存在，返回1，共前台使用
            }
            //将用户信息写入数据库
            else
            {
                sqlDataReader.Close();//关闭sqlDataReader(必要操作！！)
                //将用户信息写入User表
                cmdText = "insert into Users (Name,Password,Power,LegalityState) values ('" + Name + "','" + Password +
                          "','" + Powers + "','" + legalityState +"')";
                DataBaseOperations.ReviseDataToDataBase(cmdText, sql);

                //将用户信息写入Customer表
                cmdText =
                    "insert into Customer (Name,Password,CustomerSex,SecurityQuestion,SecurityQuestionAnswer,LegalityState) values('" +
                    Name + "','" + Password + "','" + customerSex + "','" +
                    securityQuestion + "','" + securityQuestionAnswer + "','" + legalityState +
                    "')";
                DataBaseOperations.ReviseDataToDataBase(cmdText, sql);//执行插入操作
                sql.Close();//关闭sql连接
                return 0;//操作成功返回0，供前台使用

            }
        }

        /// <summary>
        /// 提交订单信息
        /// </summary>
        /// <param name="shippingAddress">收货地址</param>
        /// <param name="bookItems">用户购买的图书</param>
        /// <returns>0：成功 1：失败</returns>
        public int SubmitOrder(Order order)
        {
             
            //1.获取购物车中的图书 bookItems
            //2.生成订单号 orderid
            //3.将订单信息写入数据库 
            if (order != null)
            {
                SqlConnection sql = DataBaseOperations.CreateConnection();
                string cmdText = "insert into [Order] values('" + order.orderId + "','" + order.userName + "','" +
                             order.shippingAddress.Address + "','" + order.shippingAddress.Remark + "','" + order.Price +
                             "','" + order.isValid + "','"+order.orderDate+"')";
                DataBaseOperations.ReviseDataToDataBase(cmdText,sql);//将订单信息插入OrderID表中

                
                foreach (var bookitem in order.bookItemList)
                {
                    cmdText = "insert into [OrderDetail] values('"+order.orderId+"','"+bookitem.Book.bookID+"','"+bookitem.bookAmount+"')";
                    DataBaseOperations.ReviseDataToDataBase(cmdText, sql);//将订单信息插入OrderDetail表中
                    int bookRating = bookitem.Book.Rating + 1;
                    cmdText = "update [Book] set Rating='" + bookRating + "'where BookID='" + bookitem.Book.bookID + "'";
                    DataBaseOperations.ReviseDataToDataBase(cmdText, sql);//更新图书销量
                }
                sql.Close();
                return 0;
            }                
            return 1;
        }

        /// <summary>
        /// 查询订单信息（所有订单
        /// orderList->Order->bookItemList->Book ①
        /// 思路：
        /// 1.对比当前订单与之前订单的订单号
        /// 2.如果订单号相同，说明图书属于一个订单，获取订单列表中的最后一个订单，然后删除（删除是为了步骤5插入订单列表时方便操作）
        /// 3.如果订单号不同，说明图书不属于同一订单，则新建一个订单
        /// 4.获取到订单后，根据①创建订单对象
        /// 5.将订单插入到订单列表尾部
        /// </summary>
        /// <returns></returns>
        public List<Order> QueryOrderInformation()
        {
            SqlConnection sql = DataBaseOperations.CreateConnection();
            string preOrderId = null;//上一个订单号
            string curOrderId;//当前订单号
            List<Order> orderList = new List<Order>();//订单列表
            Order order;//订单

            //根据当前用户名查询订单
            string cmdText =
                "select a.OrderID,a.UserName,a.Address,a.Remark,a.Price,a.isValid,a.OrderDate,b.BookID,b.Amount,c.BookName,c.BookAuthor,c.BookPrice,c.BookPress,c.BookDetail,c.BookCategory,c.BookImageURL,c.ShelveDate,c.Inventory,c.Rating from [Order] a inner join [OrderDetail] b on a.OrderID=b.OrderID inner join [Book] c on b.BookID=c.BookID where a.UserName='"+name+"' order by a.OrderID desc";
            
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
                        Convert.ToInt32(dataSet.Tables[0].Rows[i][17]), Convert.ToInt32(dataSet.Tables[0].Rows[i][18]),dataSet.Tables[0].Rows[i][16].ToString());
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
                        Convert.ToInt32(dataSet.Tables[0].Rows[i][5]), dataSet.Tables[0].Rows[i][6].ToString(),
                        shippingAddress);
                    }
                    else
                    {
                        
                        order = orderList[orderList.Count-1];//获取到订单列表的最后一个订单
                        orderList.RemoveAt(orderList.Count-1);//删除这个订单信息
                        
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

       

    }
}