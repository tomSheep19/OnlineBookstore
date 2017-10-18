using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using OnlineBookStore.App_Code;


public partial class OrderManage : System.Web.UI.Page
{
    private Manager manager;//全局
    List<Order> orderlList = new List<Order>();//全局
    protected void Page_Load(object sender, EventArgs e)
    {
        P_OrderDetail.Visible = false;

        if (Session["User"] != null)
        {
            manager = (Manager)Session["User"];//获取到当前管理员对象
        }

        orderlList = manager.QueryOrderInformation("null");//获取到所有用户订单信息
        Session["OrderList"] = orderlList;//存储订单信息，供选择时查看订单详情

        if (!IsPostBack)
        {
            grvOrderInfo.DataSource = orderlList;
            grvOrderInfo.DataBind();//绑定用户订单信息

        }
    }



    /// <summary>
    /// 查询所有订单
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void cmdAllOrder_Click(object sender, EventArgs e)
    {
        P_OrderDetail.Visible = false;
        orderlList = manager.QueryOrderInformation("null");//获取到所有用户订单信息
        Session["OrderList"] = orderlList;//存储订单信息，供选择时查看订单详情
        grvOrderInfo.DataSource = orderlList;//重新绑定
        grvOrderInfo.DataBind();
    }

    /// <summary>
    /// 根据订单号搜索订单
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>

    protected void icmdOrderSearch_Click(object sender, EventArgs e)
    {
        P_OrderDetail.Visible = false;
        string orderID = txtBookSearch.Text;
        List<Order> orderList = manager.QueryOrderInformation(orderID);//根据订单号查询订单
        grvOrderInfo.DataSource = orderList;//重新绑定
        grvOrderInfo.DataBind();
        Session["OrderList"] = orderList;//存储搜索结果

    }



    //订单选择button
    protected void cmdOrderChoose_Click(object sender, EventArgs e)
    {
        P_OrderDetail.Visible = true;
    }

    /// <summary>
    /// 监测订单选择按钮
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void grvOrderInfo_OnRowCommand(object sender, GridViewCommandEventArgs e)
    {
        string orderId = null;  
        List<Order> orderList=new List<Order>();
        if (Session["OrderList"] != null)
        {
            orderList = (List<Order>)Session["OrderList"];//获取到订单列表
        }
        if (e.CommandName == "Select")
        {
            orderId = e.CommandArgument.ToString();//获取订单号
            Order order= orderList.Find(x => x.orderId == orderId);
            OrderID.Text = orderId;//填写订单号
            Remark.Text = order.shippingAddress.Remark;//填写备注信息
            OrderAdress.Text = order.shippingAddress.Address;//填写收货地址
            grvOrderDetails.DataSource = order.bookItemList;
            grvOrderDetails.DataBind();//订单详情绑定图书信息
            P_OrderDetail.Visible = true;//显示订单详情

        }}


}
    
