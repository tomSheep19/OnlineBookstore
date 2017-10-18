using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using OnlineBookStore.App_Code;

public partial class AddBook : System.Web.UI.Page
{
    private Manager manager;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["User"] != null)
        {
            manager = (Manager)Session["User"];
        }
    }



    //添加书籍封面
    protected void ImgAdCover_Click(object sender, ImageClickEventArgs e)
    {

    }



    /// <summary>
    /// 取消添加
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void Cancel_Click(object sender, EventArgs e)
    {
        Response.Redirect("BookManage.aspx");//跳转到书籍管理页面
    }

    /// <summary>
    /// 确认添加
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void Save_Click(object sender, EventArgs e)
    {
        string bookName = TextBName.Text;
        string bookId = TextBID.Text;
        string bookAuthor = TextAuthor.Text;
        string bookPress = TextPress.Text;
        decimal bookPrice = Convert.ToDecimal(TextPrice.Text);
        int Inventory = Convert.ToInt32(TextInventory.Text);
        string bookDetail = TextBDetail.Text;
        string bookImageURL = null;
        string bookCategory = null;
        if (DDLCategory.SelectedIndex != -1)
        {
            bookCategory = DDLCategory.SelectedValue;
        }
        //构造新的图书
        Book newBook = new Book(bookId, bookName, bookAuthor, bookPrice, bookPress, bookDetail, bookCategory,
            bookImageURL, Inventory,0,  null);

        int state = manager.AddBookToDB(newBook);//更新图书信息
        if (state == 0)
        {
            Response.Write("<script>alert('添加成功！');</script>");
            Response.Redirect("BookManage.aspx");//跳转到图书管理页面
        }
        else
        {
            Response.Write("<script>alert('添加失败，请重试');</script>");
        }
    }
}