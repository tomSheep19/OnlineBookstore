<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ManageSystem.aspx.cs" Inherits="ManageSystem" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link rel="stylesheet" type="text/css" href="css/ManagerEnter.css" />
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>



</head>
<body>
    <form id="form1" runat="server">

        <div class="div1">
            <asp:Image ID="imgTitle" runat="server" CssClass="imgTitle" ImageUrl="~/Image/EnterTitle.png" /><br />
            <asp:ImageButton ID="cmd1" runat="server" CssClass="cmd1" ImageUrl="~/Image/OrderManage.png" OnClick="cmd1_Click" />
            <asp:ImageButton ID="cmd2" runat="server" CssClass="cmd2" ImageUrl="~/Image/UserManage.png" OnClick="cmd2_Click" />
            <asp:ImageButton ID="cmd3" runat="server" CssClass="cmd3" ImageUrl="~/Image/BookManage.png" OnClick="cmd3_Click" />
        </div>


    </form>
</body>
</html>

