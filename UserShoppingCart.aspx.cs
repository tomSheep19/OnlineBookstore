using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using OnlineBookStore.App_Code;

public partial class UserShoppingCart : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //var scriptManager= Page.FindControl("ScriptManager1");
        List<BookItem> bookItems = new List<BookItem>();
        //绑定用户购物车
        if (!IsPostBack)
        {
            if (Session["ShoppingCart"] != null)
            {
                bookItems = ((ShoppingCart)Session["ShoppingCart"]).bookItemList;
            }
            gridview_ShoppingCart.DataSource = bookItems;
            gridview_ShoppingCart.DataBind();
        }


    }

    /// <summary>
    /// 控件动作监听模块
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void gridview_ShoppingCart_OnRowCommand(object sender, GridViewCommandEventArgs e)
    {
        ShoppingCart shoppingCart = new ShoppingCart();
        //获取到用户购物车
        if (Session["ShoppingCart"] != null)
        {
            shoppingCart = (ShoppingCart)Session["ShoppingCart"];
        }

        if (e.CommandName == "Plus" || e.CommandName == "Reduce" || e.CommandName == "DeleteBook")
        {
            int index = Convert.ToInt32(e.CommandArgument);//获取到当前索引
            Label lbl_bookAmount = (Label)gridview_ShoppingCart.Rows[Convert.ToInt32(e.CommandArgument)].FindControl("lblSCBookNum");
            BookItem bookItem = shoppingCart.bookItemList[index];//获取需要变化数量的图书


            if (e.CommandName == "Plus")
            {

                lbl_bookAmount.Text = (Convert.ToInt32(lbl_bookAmount.Text) + 1).ToString();//增加label的值
                shoppingCart.AddBookItemToShoppingCart(bookItem);//将图书添加到购物车
            }

            if (e.CommandName == "Reduce")
            {
                if (bookItem.bookAmount > 1)
                {
                    lbl_bookAmount.Text = (Convert.ToInt32(lbl_bookAmount.Text) - 1).ToString();//减小label的值
                    shoppingCart.DeleteBookItemFromShoppingCart(bookItem);//将图书添加到购物车
                }
            }

            if (e.CommandName == "DeleteBook")
            {

                shoppingCart.DeleteBookItemFromShoppingCart_(bookItem);//删除选定的图书
                gridview_ShoppingCart.DataSource = shoppingCart.bookItemList;
                gridview_ShoppingCart.DataBind();//刷新购物车
            }

        }
    }


    /// <summary>
    /// 全选模块
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void ckbChooseAll_CheckedChanged(object sender, EventArgs e)
    {
        //如果选中
        if (ckbChooseAll.Checked)
        {
            //遍历gridview各行，设定checkbox状态
            for (int i = 0; i < gridview_ShoppingCart.Rows.Count; i++)
            {
                var row = gridview_ShoppingCart.Rows[i];
                var checkBox = row.FindControl("ckbSCBookChoose") as CheckBox;
                checkBox.Checked = true;
            }
        }
        //如果未选中
        else
        {
            for (int i = 0; i < gridview_ShoppingCart.Rows.Count; i++)
            {
                var row = gridview_ShoppingCart.Rows[i];
                var checkBox = row.FindControl("ckbSCBookChoose") as CheckBox;
                checkBox.Checked = false;
            }
        }

    }

    /// <summary>
    /// 确认购买模块
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void ConfirmBuy_Click(object sender, EventArgs e)
    {
        List<BookItem> confirmToBuyBook = new List<BookItem>();//确认购买的书籍
        ShoppingCart shoppingCart = new ShoppingCart();
        //读取购物车中的图书
        if (Session["ShoppingCart"] != null)
        {
            shoppingCart = (ShoppingCart)Session["ShoppingCart"];
        }

        for (int i = 0; i < gridview_ShoppingCart.Rows.Count; i++)
        {
            var row = gridview_ShoppingCart.Rows[i];
            var checkBox = row.FindControl("ckbSCBookChoose") as CheckBox;

            if (checkBox.Checked)
            {
                BookItem bookItem = shoppingCart.bookItemList[i];
                confirmToBuyBook.Add(bookItem);//从购物车中获取要购买的图书
            }
        }
        //删除购物车中要购买的书籍
        foreach (var book in confirmToBuyBook)
        {
            shoppingCart.bookItemList.Remove(book);
        }
        Session["ShoppingCart"] = shoppingCart;//重新储存购物车

        if (confirmToBuyBook.Count!=0)
        {
            Session["ConfirmToBuyBook"] = confirmToBuyBook;//存储要购买的图书，供确认订单使用
            Response.Redirect("SubmitOrder.aspx");//跳转到提交订单页面
        }
        else
        {
            Response.Write("<script>alert(‘请选择需要购买的图书')</script>");
        }

    }

}