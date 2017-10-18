using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class ManageSystem : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }



    //跳转订单管理
    protected void cmd1_Click(object sender, ImageClickEventArgs e)
    {
        Response.Redirect("OrderManage.aspx");
    }



    //跳转用户管理
    protected void cmd2_Click(object sender, ImageClickEventArgs e)
    {
        Response.Redirect("UserManage.aspx");
    }



    //跳转书籍管理
    protected void cmd3_Click(object sender, ImageClickEventArgs e)
    {
        Response.Redirect("BookManage.aspx");
    }
}