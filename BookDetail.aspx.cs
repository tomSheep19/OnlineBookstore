using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using OnlineBookStore.App_Code;

public partial class BookDetail : System.Web.UI.Page
{
    Book book=new Book();
    protected void Page_Load(object sender, EventArgs e)
    {
        Panel_Detail.Visible = false;
        Panel_Evaluation.Visible = false;
        
        if (Session["BookDetail"] != null)
        {
            book = (Book) Session["BookDetail"];
        }
        if (!IsPostBack)
        {
            Label_Name.Text = book.bookName;
            Label_Price.Text = book.bookPrice.ToString();
            Label_Author.Text = book.bookAuthor;
            Label_Press.Text = book.bookPress;
            Label_Number.Text = book.Inventory.ToString();
            Label_Number.Text = book.bookID;
            TextBox_Detail.Text = book.bookDetail;


        }
    }



    protected void DetailbtnClick(object sender, EventArgs e)
    {
        Panel_Detail.Visible = true;
        Panel_Evaluation.Visible = false;
    }

    protected void EnvaluatebtnClick(object sender, EventArgs e)
    {
        Panel_Detail.Visible = false;
        Panel_Evaluation.Visible = true;
    }

    /// <summary>
    /// 加入购物车
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void Linkbtn_Shoppingcart_Click(object sender, EventArgs e)
    {
        if (Session["User"] != null)
        {
            Customer currentUser = (Customer)Session["User"];//读取当前用户信息
            BookItem bookItem = new BookItem(book);//创建一个bookItem

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