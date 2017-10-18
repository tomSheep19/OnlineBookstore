using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using OnlineBookStore.App_Code;


public partial class Master : System.Web.UI.MasterPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        ScriptManager1.RegisterAsyncPostBackControl(lkbQuit);//注册退出按钮，控制上方用户名/退出按钮异步刷新
        //更新首页上的用户名
        if (Session["User"] != null)
        {
            Customer customer = (Customer)Session["User"];
            lblNameInput.Text = customer.Name;
        }

    }

    protected void lkbGUp_Click(object sender, EventArgs e)
    {

    }

    protected void lkbGStart_Click(object sender, EventArgs e)
    {

    }

    /// <summary>
    /// 登陆模块
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void cmdLoginNow_OnClick(object sender, EventArgs e)
    {
        string userName = txtLoginName .Text;//读取用户名
        string password = txtLoginPwd .Text;//读取用户密码
        User user = new User(userName, password);//登陆
        int loginState = user.Login();
        //成功登陆
        if (loginState == 0)
        {

            if (user.Powers == 0)
            {
                Customer customer = new Customer(user.Name);//构造customer对象，初始化用户购物车
                Session["User"] = customer;//存储customer对象
                Response.Redirect(Request.Url.ToString());//跳转到首页
            }
            else
            {
                Manager manager=new Manager(user.Name);
                Session["User"] = manager;//存储user对象
                Response.Redirect("ManageSystem.aspx");//跳转到管理员界面
            }

        }
        else if (loginState == 1)
        {
            lblLoginState .Text = "用户密码错误，请重新输入密码";
        }
        else if (loginState == 2)
        {
            lblLoginState.Text = "该用户不存在！";
        }
        else
        {
            lblLoginState.Text = "该用户被冻结，请联系管理员！";
        } 
        
    }

    /// <summary>
    /// 退出模块
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void lkbQuit_OnClick(object sender, EventArgs e)
    {
        lblNameInput.Text = "";
        if (Session["User"] != null)
        {
            Session["User"] = null;//删除customer对象
        }

        string tempPage = Request.Url.LocalPath;//获取当前页的本地路径表示方法
        //如果当前页为首页，则刷新用户名
        if (tempPage == "/MainPage.aspx")
        {
            UpdatePanel_UserName.Update();//刷新用户名
            UpdatePanel_QuitButton.Update();//刷新退出Button
        }
        //如果不为首页，则跳转至首页
        else
        {
            Response.Redirect("MainPage.aspx");
        }
    }

    /// <summary>
    /// 搜索模块
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void cmdSearch_OnClick(object sender, EventArgs e)
    {
        string queryConditon = "bookName:" + txtSearch.Text;
        List<Book> bookList = User.QueryBookFromDb(queryConditon);
        Session["QueryBookList"] = bookList;//将查询到的bookList保存至Session中
        Session["FromWhichPage"] = 0;
        Response.Redirect("BookShow.aspx");
    }

    /// <summary>
    /// 高级搜索模块
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void lkbGStart_OnClick(object sender, EventArgs e)
    {
        string bookName = txtBookN.Text;
        string bookID = txtBookNo.Text;
        string bookAuthor = txtAuthorN.Text;
        string bookPress = txtPublisherN.Text;

        if (bookName == "" && bookID == "" & bookAuthor == ""&& bookPress == "")
        {
            lblSearchConditionSate.Text = "请至少输入一个搜索条件";
        }
        //组装查询语句，供生成数据库查询语句
        string queryCondition=null;
        if (bookName != "")
        {
            AddSpaceOrNot(queryCondition);
            queryCondition += "bookName:" + bookName;
        }

        if (bookID != "")
        {
            AddSpaceOrNot(queryCondition);
            queryCondition += "bookID:" + bookID;
        }
        if (bookAuthor != "")
        {
            AddSpaceOrNot(queryCondition);
            queryCondition += "bookAuthor:" + bookAuthor;
        }
        if (bookPress != "")
        {
            AddSpaceOrNot(queryCondition);
            queryCondition += "bookPress:" +bookPress;
        }

        List<Book> queryBookList = User.QueryBookFromDb(queryCondition);//获取到需要查询的书籍
        Session["QueryBookList"] = queryBookList;//将查询到的bookList保存至Session中
        Session["FromWhichPage"] = 0;
        Response.Redirect("BookShow.aspx");
    }

    private void AddSpaceOrNot(string queryConditon)
    {
        if (queryConditon != null)
            queryConditon += " ";
    }
    /// <summary>
    /// 跳转到购物车模块
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void lkbShoppingCart_Click(object sender, EventArgs e)
    {
        if (Session["User"] != null)
        {
            Response.Redirect("UserShoppingCart.aspx");
        }
        else
        {
            Response.Write("<script>alert('亲，登录后才可以查看哦~')</script>"); 
        }
    }

    /// <summary>
    /// 跳转到订单模块
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void lkbUserOrder_Click(object sender, EventArgs e)
    {
        if (Session["User"] != null)
        {
            Response.Redirect("UserOrder.aspx");
        }
        else
        {
            Response.Write("<script>alert('亲，登录后才可以查看哦~')</script>");
        }
    }

    /// <summary>
    /// 跳转到注册界面
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void lkbRegister_Click(object sender, EventArgs e)
    {
        Response.Redirect("Register.aspx");
    }
}
