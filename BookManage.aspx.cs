using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using OnlineBookStore.App_Code;

public partial class BookManage : System.Web.UI.Page
{
    
    List<Book> queryBooks = new List<Book>();//
    private List<Book> defaultBooks;
    private Manager manager;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["User"] != null)
        {
            manager = (Manager)Session["User"];
        }
        //根据销量查询书籍
        if (Session["DefaultBook"] == null)
        {
            defaultBooks = OnlineBookStore.App_Code.User.RecommendedBook(); //根据销量展示
            Session["DefaultBook"] = defaultBooks;//存储，减少数据库访问
        }
        //直接读取已经存储的书籍
        else
        {
            defaultBooks = (List<Book>)Session["DefaultBook"];
        }

        if (!IsPostBack)
        {
            GridVShowBook.DataSource = defaultBooks;
            GridVShowBook.DataBind();
        }

    }

    /// <summary>
    /// 搜索图书
    /// 按书名
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void BSearch_Click(object sender, EventArgs e)
    {
        string queryCondition = "bookName:" + TextBInputSearch.Text;//获取用户搜索条件
        List<Book> queryBooks = OnlineBookStore.App_Code.User.QueryBookFromDb(queryCondition);

        GridVShowBook.DataSource = queryBooks;//绑定用户查询的书籍
        GridVShowBook.DataBind();


    }

    //添加书籍
    protected void BAdd_Click(object sender, EventArgs e)
    {
        Response.Redirect("AddBook.aspx");
    }

    //设置公告栏
    protected void BAnnouncement_Click(object sender, EventArgs e)
    {

    }



    //高级搜索
    protected void BConSearch_Click(object sender, EventArgs e)
    {

    }



    //修改书籍信息
    protected void ImgBAlter_Click(object sender, EventArgs e)
    {
        Response.Redirect("AlterBook.aspx");
    }




    /// <summary>
    /// 高级搜索模块
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void BConSearchGo_OnClick(object sender, EventArgs e)
    {
        string bookId = TextBConBookID.Text;
        string bookCategory = lbCategory.Text;
        string bookAuthor = TextBConAuthor.Text;
        string bookPress = TextBConPress.Text;

        //组装查询语句，供生成数据库查询语句
        string queryCondition = null;
        if (bookCategory != "")
        {
            AddSpaceOrNot(queryCondition);
            queryCondition += "bookCategory:" + bookCategory;
        }

        if (bookId != "")
        {
            AddSpaceOrNot(queryCondition);
            queryCondition += "bookID:" + bookId;
        }
        if (bookAuthor != "")
        {
            AddSpaceOrNot(queryCondition);
            queryCondition += "bookAuthor:" + bookAuthor;
        }
        if (bookPress != "")
        {
            AddSpaceOrNot(queryCondition);
            queryCondition += "bookPress:" + bookPress;
        }

        List<Book> queryBookList = OnlineBookStore.App_Code.User.QueryBookFromDb(queryCondition);//获取到需要查询的书籍
        GridVShowBook.DataSource = queryBookList;//绑定用户查询的书籍
        GridVShowBook.DataBind();

    }

    /// <summary>
    /// 辅助函数
    /// </summary>
    /// <param name="queryConditon"></param>
    private void AddSpaceOrNot(string queryConditon)
    {
        if (queryConditon != null)
            queryConditon += " ";
    }

    /// <summary>
    /// 监听修改/删除按钮
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void GridVShowBook_OnRowCommand(object sender, GridViewCommandEventArgs e)
    {
        string bookId = e.CommandArgument.ToString();
        //修改书籍操作
        if (e.CommandName == "Alter")
        {
            Book book = OnlineBookStore.App_Code.User.QureyBookFromDbByBookID(bookId);//查找需要修改的图书
            Session["ToChangeBook"] = book;//存储要修改的书籍
            Response.Redirect("AlterBook.aspx");//跳转到修改图书页面
        }
        //删除书籍操作
        if (e.CommandName == "Delete")
        {
            Book book = OnlineBookStore.App_Code.User.QureyBookFromDbByBookID(bookId);
            int state = manager.DeleteBookFromDB(book);
            if (state == 0)
            {
                Response.Write("<script>alert('删除成功！');</script>");

            }
            else
            {
                Response.Write("<script>alert('删除失败，请重试');</script>");
            }


        }
    }
}