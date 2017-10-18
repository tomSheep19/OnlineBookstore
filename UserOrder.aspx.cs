using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using OnlineBookStore.App_Code;

public partial class UserOrder : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        List<Order> orderlList = new List<Order>();
        if (Session["User"] != null)
        {
            Customer currentCustomer = (Customer)Session["User"];
            orderlList = currentCustomer.QueryOrderInformation();//获取到用户订单信息
        }
        if (!IsPostBack)
        {
            grvUserOrder.DataSource = orderlList;
            grvUserOrder.DataBind();//父gridview绑定数据（订单号）
            for (int i = 0; i < grvUserOrder.Rows.Count; i++)
            {
                GridView gridView = (GridView)grvUserOrder.Rows[i].FindControl("grvOrderDetails");//查找子控件
                gridView.DataSource = orderlList[i].bookItemList;//绑定bookItem
                gridView.DataBind();
            }
        }

    }

    protected void cmdMySC_Click(object sender, EventArgs e)
    {
        Server.Transfer("ShoppingCart.aspx");
    }

    protected void cmdMyOrder_Click(object sender, EventArgs e)
    {

    }

    protected void grvOrderDetails_OnSelectedIndexChanged(object sender, EventArgs e)
    {
        throw new NotImplementedException();
    }
}