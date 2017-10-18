using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Register : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
            ViewState["retu"] = Request.UrlReferrer.ToString();
    }
    protected void Button_Back_Click(object sender, EventArgs e)
    {
        if (ViewState["retu"] != null)
            Response.Redirect(ViewState["retu"].ToString()); 
    }
}