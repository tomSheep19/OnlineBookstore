using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using OnlineBookStore.App_Code;

public partial class Main : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

        if (!IsPostBack)
        {
            List<Book> newBook = OnlineBookStore.App_Code.User.NewBook();
            List<Book> recommendBooks = OnlineBookStore.App_Code.User.NewBook();
            Session["NewBooks"] = newBook;
            Session["RecommendBooks"] = recommendBooks;
            ListView_NewBook.DataSource = newBook;
            ListView_Recommend.DataSource = recommendBooks;
            ListView_NewBook.DataBind();
            ListView_Recommend.DataBind();
        }

    }

    /// <summary>
    /// 一键购买
    /// 添加到购物车
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void ListView_OnItemCommand(object sender, ListViewCommandEventArgs e)
    {
        //待完善
        if (e.CommandName == "BuyNow")
        {

        }

        if (e.CommandName == "BookDetail")
        {
            string bookID = e.CommandArgument.ToString();//获取书号
            Book book = OnlineBookStore.App_Code.User.QureyBookFromDbByBookID(bookID);//查询该图书
            Session["BookDetail"] = book;//存储该图书
            Response.Redirect("BookDetail.aspx");//跳转到图书详情页

        }


        if (e.CommandName == "AddBookToShoppingCart" || e.CommandName == "NewAddBookToShoppingCart")
        {
            List<Book> bookList = new List<Book>();

            if (e.CommandName == "AddBookToShoppingCart")
            {
                if (Session["RecommendBooks"] != null)
                {
                    bookList = (List<Book>)Session["RecommendBooks"]; //推荐书籍List
                }
            }
            else
            {
                if (Session["NewBooks"] != null)
                {
                    bookList = (List<Book>)Session["NewBooks"]; //推荐书籍List
                }
            }

            Book selectedBook = bookList.Find(x => x.bookID == e.CommandArgument.ToString());//查找用户选择的书籍
            if (Session["User"] != null)
            {
                Customer currentUser = (Customer)Session["User"];//读取当前用户信息
                BookItem bookItem = new BookItem(selectedBook);//创建一个bookItem

                //下面的逻辑有点乱
                //可以只通过读取User信息就好了
                if (Session["ShoppingCart"] != null)
                {
                    ShoppingCart shoppingCart = (ShoppingCart)Session["ShoppingCart"];
                    shoppingCart.AddBookItemToShoppingCart(bookItem);//将bookItem添加到shoppingCart中
                    Session["ShoppingCart"] = shoppingCart;//保存购物车
                }
                else
                {
                    currentUser.ShoppingCart.AddBookItemToShoppingCart(bookItem);//将bookItem添加到shoppingCart中
                    Session["ShoppingCart"] = currentUser.ShoppingCart;//保存购物车
                }

                //提醒用户已经添加到购物车
                Response.Write("<script>alert('成功添加到购物车中!')</script>");
            }

            else
            {
                Response.Write("<script>alert('登陆失效，请重新登陆!')</script>");
            }
        }


    }

    /// <summary>
    /// 分类查看书籍
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void Category_OnClick(object sender, CommandEventArgs e)
    {
        string queryCondition = "bookCategory:" + e.CommandArgument;//指定格式
        List<Book> ClassificationBook = OnlineBookStore.App_Code.User.QueryBookFromDb(queryCondition);//获取到书籍
        Session["ClassificationBook"] = ClassificationBook;//存储到session
        Session["FromWhichPage"] = 1;
        Response.Redirect("BookShow.aspx");



    }
    protected void ListView_NewBook_SelectedIndexChanged(object sender, EventArgs e)
    {

    }
}