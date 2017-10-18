using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class ManagerManage : System.Web.UI.MasterPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string currentURL = Request.Url.AbsolutePath;

        if (currentURL == "/BookManage.aspx")
        {
            P_BookCategory.Visible = true;
        }
        else
        {
            P_BookCategory.Visible = false;
        }

    }



    //点击回到首页
    protected void cimdBackMainPage_Click(object sender, EventArgs e)
    {

    }


    //点击退出管理员账号
    protected void Exit_Click(object sender, EventArgs e)
    {

    }



    //订单管理
    protected void lbOrderManage_Click(object sender, EventArgs e)
    {
        Response.Redirect("OrderManage.aspx");
    }



    //用户管理
    protected void lbUserManage_Click(object sender, EventArgs e)
    {
        Response.Redirect("UserManage.aspx");
    }


    //书籍管理
    protected void lbBookManage_Click(object sender, EventArgs e)
    {
        Response.Redirect("BookManage.aspx");

    }


    //书籍管理——分类：教育
    protected void lbEducation_Click(object sender, EventArgs e)
    {

    }


    //书籍管理——分类：文艺
    protected void lbArt_Click(object sender, EventArgs e)
    {

    }


    //书籍管理——分类：科技
    protected void lbScience_Click(object sender, EventArgs e)
    {

    }


    //书籍管理——分类：生活
    protected void lbLife_Click(object sender, EventArgs e)
    {

    }



    //书籍管理——分类：人文社科
    protected void lbHumanity_Click(object sender, EventArgs e)
    {

    }


    //书籍管理——分类：少儿读物
    protected void lbJuvenile_Click(object sender, EventArgs e)
    {

    }

}
