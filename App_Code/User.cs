using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;

namespace OnlineBookStore.App_Code
{

    public class User
    {
        public enum Power
        {
            Customer, Manager
        }
        protected string name;
        protected string password;
        protected Power power;


        #region
        public string Name
        {
            set { name = value; }
            get { return name; }
        }

        public string Password
        {
            set { password = value; }
            get { return password; }
        }

        public Power Powers
        {
            set { power = value; }
            get { return power; }
        }
        #endregion

        public User()
        {

        }
        public User(string name, string password)
        {
            Name = name;
            Password = password;

        }

        /// <summary>
        /// 用户登录
        /// </summary>
        /// <returns>0：用户密码正确，账号未被冻结，并且提取相应的权限值</returns>
        /// <returns>1：用户密码错误</returns>
        /// <returns>2：用户尚未注册</returns>
        /// <returns>3：账号被冻结</returns>
        public int Login()
        {
            SqlConnection sql = DataBaseOperations.CreateConnection();
            string cmdText = "select * from Users where Name='" + Name + "'";
            SqlDataReader sqlDataReader = DataBaseOperations.GetSqlDataReader(cmdText, sql);
            //如果查询到该用户，匹配用户名/密码
            if (sqlDataReader.HasRows)//根据查询结果里面的行数判断是否有该用户
            {
                sqlDataReader.Close();//关闭sqlDataReader，必要操作
                SqlDataAdapter sqlDataAdapter = DataBaseOperations.GetSqlDataAdapter(cmdText, sql);
                DataSet dataSet = DataBaseOperations.GetDataSet(sqlDataAdapter);

                //对用户密码进行匹配
                if (dataSet.Tables[0].Rows[0]["Password"].ToString() == Password)
                {

                    string power = dataSet.Tables[0].Rows[0]["Power"].ToString();//获取数据库中用户权限（string）
                    //将string权限转换为Power类型
                    switch (power)
                    {
                        case "Customer":
                            Powers = Power.Customer;
                            break;
                        case "Manager":
                            Powers = Power.Manager;
                            break;
                    }
                    if (Convert.ToInt32(dataSet.Tables[0].Rows[0]["LegalityState"]) == 0)
                    {
                        sql.Close();//关闭sql连接
                        return 0; //用户密码正确，账号未被冻结，提示前台进行相应的操作
                    }
                    else
                    {
                        sql.Close();//关闭sql连接
                        return 3;//账号被冻结，提示前台进行相应的操作

                    }

                }
                else
                {
                    sql.Close();//关闭sql连接
                    return 1;//用户密码错误，提示前台进行相应的操作
                }
            }
            sql.Close();//关闭sql连接
            return 2;//用户名不存在，提示用户注册

        }

        /// <summary>
        /// 根据bookID查询图书
        /// </summary>
        /// <param name="bookID"></param>
        /// <returns></returns>
        public static Book QureyBookFromDbByBookID(string bookID)
        {
            List<Book> queryBook = QueryBookFromDb("bookID:" + bookID);
            if (queryBook.Count != 0)
                return queryBook[0];
            return null;
        }
        /// <summary>
        /// 根据用户输入的条件查询书籍
        /// </summary>
        /// <param name="queryConditions"></param>
        /// <returns>List-Book对象</returns>
        public static List<Book> QueryBookFromDb(string queryConditions)
        {
            List<Book> queryBooks = new List<Book>();
            string cmdText = null;
            SqlConnection sql = DataBaseOperations.CreateConnection();//连接数据库
            //判定queryConditions查询条件是否为空

            if (queryConditions != null)
            {
                cmdText = QueryBook.SqlCmdText(queryConditions);
            }

            DataSet data = DataBaseOperations.GetDataSet(cmdText, sql);//获取DataSet
            //遍历dataset，将图书添加到queryBooks列表中
            if (data != null)
            {
                for (int i = 0; i < data.Tables[0].Rows.Count; i++)
                {
                    Book book = new Book();
                    book.bookID = data.Tables[0].Rows[i][0].ToString();
                    book.bookName = data.Tables[0].Rows[i][1].ToString();
                    book.bookAuthor = data.Tables[0].Rows[i][2].ToString();
                    book.bookPrice = Convert.ToDecimal(data.Tables[0].Rows[i][3]);
                    book.bookPress = data.Tables[0].Rows[i][4].ToString();
                    book.bookDetail = data.Tables[0].Rows[i][5].ToString();
                    book.bookCategory = data.Tables[0].Rows[i][6].ToString();
                    book.bookImageURL = data.Tables[0].Rows[i][7].ToString();
                    book.Rating = Convert.ToInt32(data.Tables[0].Rows[i][8]);
                    book.Inventory = Convert.ToInt32(data.Tables[0].Rows[i][10]);

                    queryBooks.Add(book);//将图书添加到queryBooks列表中

                }
            }
            sql.Close();
            return queryBooks;
        }

        /// <summary>
        /// 判断上一个图书与当前图书是否来自同一个订单
        /// </summary>
        /// <param name="preOrderId"></param>
        /// <param name="CurOrderId"></param>
        /// <returns></returns>
        protected bool isFromSameOrder(string preOrderId, string CurOrderId)
        {
            //第一次调用该方法是，preOrderId为空，返回false
            if (preOrderId == null)
            {
                return false;
            }

            if (preOrderId.Equals(CurOrderId))
            {
                return true;
            }

            else
            {
                return false;
            }


        }

        /// <summary>
        /// 推荐书籍
        /// 按照销量查询
        /// </summary>
        /// <returns></returns>
        public static List<Book> RecommendedBook()
        {
            List<Book> recommendedBook = new List<Book>();//推荐书籍List
            SqlConnection sql = DataBaseOperations.CreateConnection();//sql连接符
            string cmdText = "select top 12 * from Book order by Rating";//按照销量进行选择
            DataSet data = DataBaseOperations.GetDataSet(cmdText, sql);//获取数据
            sql.Close();//关闭连接符
            for (int i = 0; i < data.Tables[0].Rows.Count; i++)
            {
                Book tempBook = new Book(data.Tables[0].Rows[i]["BookID"].ToString(),
                    data.Tables[0].Rows[i]["BookName"].ToString(), data.Tables[0].Rows[i]["BookAuthor"].ToString(),
                    Convert.ToDecimal(data.Tables[0].Rows[i]["BookPrice"]),
                    data.Tables[0].Rows[i]["BookPress"].ToString(), data.Tables[0].Rows[i]["BookDetail"].ToString(),
                    data.Tables[0].Rows[i]["BookCategory"].ToString(), data.Tables[0].Rows[i]["BookImageURL"].ToString(),
                    Convert.ToInt32(data.Tables[0].Rows[i]["Inventory"].ToString()),
                    Convert.ToInt32(data.Tables[0].Rows[i]["Rating"]), data.Tables[0].Rows[i]["ShelveDate"].ToString());
                recommendedBook.Add(tempBook);
            }
            return recommendedBook;

            }

        public static List<Book> NewBook()
        {
            List<Book> newBook = new List<Book>();//推荐书籍List
            SqlConnection sql = DataBaseOperations.CreateConnection();//sql连接符
            string cmdText = "select * from Book order by ShelveDate desc ";//按照销量进行选择
            DataSet data = DataBaseOperations.GetDataSet(cmdText, sql);//获取数据
            sql.Close();//关闭连接符
            for (int i = 0; i < data.Tables[0].Rows.Count; i++)
            {
                Book tempBook = new Book(data.Tables[0].Rows[i]["BookID"].ToString(),
                    data.Tables[0].Rows[i]["BookName"].ToString(), data.Tables[0].Rows[i]["BookAuthor"].ToString(),
                    Convert.ToDecimal(data.Tables[0].Rows[i]["BookPrice"]),
                    data.Tables[0].Rows[i]["BookPress"].ToString(), data.Tables[0].Rows[i]["BookDetail"].ToString(),
                    data.Tables[0].Rows[i]["BookCategory"].ToString(), data.Tables[0].Rows[i]["BookImageURL"].ToString(),
                    Convert.ToInt32(data.Tables[0].Rows[i]["Inventory"].ToString()),
                    Convert.ToInt32(data.Tables[0].Rows[i]["Rating"]), data.Tables[0].Rows[i]["ShelveDate"].ToString());
                newBook.Add(tempBook);
            }
            return newBook;

        }

    }
}