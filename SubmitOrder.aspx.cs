using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using OnlineBookStore.App_Code;

public partial class SubmitOrder : System.Web.UI.Page
{
    List<BookItem> bookItems = new List<BookItem>();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
            ViewState["retu"] = Request.UrlReferrer.ToString();
        decimal totalCost = 0;
        if (Session["ConfirmToBuyBook"] != null)
        {
            bookItems = (List<BookItem>)Session["ConfirmToBuyBook"];
        }

        if (!IsPostBack)
        { 
            GridView1.DataSource = bookItems;
            GridView1.DataBind();

            foreach (var bookItem in bookItems)
            {
                totalCost += bookItem.ComputeBookItemCost();
            }
            Label_Money.Text = totalCost.ToString(CultureInfo.InvariantCulture);
        }
    }

    /// <summary>
    /// 提交订单
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void Button_SaveMessage_Click(object sender, EventArgs e)
    {
        
        Customer currentUser = null;    
        if (Session["User"] != null)
        {
            currentUser = (Customer)Session["User"];
        }
        else
        {
            Response.Write("<script>alert('登陆失效，请重新登陆')</script>");
        }
        string name = TextBox_Name.Text;
        string address = TextBox_Province.Text + Textbox_City.Text + Textbox_Area.Text + TextBox_Address.Text;
        string postcode = TextBox_Postcode.Text;
        string phone = TextBox_Phonenumber.Text;
        string remark = "remark";
        ShippingAddress shippingAddress=new ShippingAddress(name,address,postcode,phone,remark);
        Order order =new Order(currentUser.Name,shippingAddress,DateTime.Now, bookItems);
        int state=currentUser.SubmitOrder(order);
        if (state == 0)
        {
            Response.Write("<script>alert('购买成功，谢谢您的支持!')</script>");
            Response.Redirect("MainPage.aspx");//跳转到首页
        }
        else
        {
            Response.Redirect("<script>alert(‘购买失败，请稍后重试！')</script>");
        }        
    }

    protected void Button_Back_Click(object sender, EventArgs e)
    {
        if (ViewState["retu"] != null)
            Response.Redirect(ViewState["retu"].ToString()); 
    }
}