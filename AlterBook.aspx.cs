using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using OnlineBookStore.App_Code;


public partial class AlterBook : System.Web.UI.Page
{
    Book toAlterBook=new Book();
    private Manager manager;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["ToChangeBook"] != null)
        {
            toAlterBook = (Book) Session["ToChangeBook"];
        }
        if (Session["User"] != null)
        {
            manager = (Manager) Session["User"];
        }
        //绑定数据
        if (!IsPostBack)
        {
            TextBName.Text = toAlterBook.bookName;
            TextBID.Text = toAlterBook.bookID;
            TextAuthor.Text = toAlterBook.bookAuthor;
            TextPress.Text = toAlterBook.bookPress;
            TextPrice.Text = toAlterBook.bookPrice.ToString();
            TextInventory.Text = toAlterBook.Inventory.ToString();
            TextBDetail.Text = toAlterBook.bookDetail;
            ImgAlterCover.ImageUrl = toAlterBook.bookImageURL;
        }
    }



    //修改书籍封面
    protected void ImgAlterCover_Click(object sender, ImageClickEventArgs e)
    {

    }

    /// <summary>
    /// 取消编辑图书
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void lbCancel_OnClick(object sender, EventArgs e)
    {
        Response.Redirect("BookManage.aspx");//跳转到图书管理页面
    }

    /// <summary>
    /// 确定修改
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void lbSave_OnClick(object sender, EventArgs e)
    {
        string bookName = TextBName.Text;
        string bookId = TextBID.Text;
        string bookAuthor = TextAuthor.Text;
        string bookPress = TextPress.Text;
        decimal bookPrice = Convert.ToDecimal(TextPrice.Text);
        int Inventory = Convert.ToInt32(TextInventory.Text);
        string bookDetail = TextBDetail.Text;
        string bookImageURL = ImgAlterCover.ImageUrl;
        string bookCategory=null;
        if (DDLCategory.SelectedIndex != -1)
        {
            bookCategory = DDLCategory.SelectedValue;
        }
        //构造新的图书
        Book newBook = new Book(bookId, bookName, bookAuthor, bookPrice, bookPress, bookDetail, bookCategory,
            bookImageURL, Inventory, toAlterBook.Rating, null);

        int state= manager.UpdateBook(newBook);//更新图书信息
        if (state == 0)
        {
            Response.Write("<script>alert('修改成功！');</script>");
            Response.Redirect("BookManage.aspx");//跳转到图书管理页面
        }
        else
        {
            Response.Write("<script>alert('修改失败，请重试');</script>");
        }

    }
}