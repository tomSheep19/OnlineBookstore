<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Register.aspx.cs" Inherits="Register" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
    <link rel="stylesheet" type="text/css" href="css/Register.css">
</head>
<body style="background-image: url(Image/气球背景6.jpg); background-repeat: no-repeat;">
    <form id="form1" runat="server">
    <div>
    
    </div>
        <!--注册界面-->
        <asp:Panel ID="Panel" runat="server" CssClass="Panel">
            <table class="Table">
                <tr>
                    <!--用户名输入-->
                    <td class="Td">用户名</td>
                    <td>
                        
                        <asp:TextBox ID="TextBox_Username" runat="server" CssClass="TextBox_Username" style="z-index: 1"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <!--密码输入-->
                    <td class="Td">密码</td>
                    <td>
                        <asp:TextBox ID="TextBox_Password" runat="server" TextMode="Password" CssClass="TextBox_Password" style="z-index: 1"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <!--密码确认-->
                    <td class="Td">确认密码</td>
                    <td>
                        <asp:TextBox ID="TextBox_AffirmPassword" runat="server" TextMode="Password" CssClass="TextBox_AffirmPassword" style="z-index: 1"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <!--安全问题-->
                    <td class="Td">安全问题</td>
                    <td>
                        <asp:TextBox ID="TextBox_SafeQuestion" runat="server" CssClass="TextBox_SafeQuestion" style="z-index: 1"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <!--安全问题答案-->
                    <td class="Td">安全问题答案</td>
                    <td>
                        <asp:TextBox ID="TextBox_Answer" runat="server" CssClass="TextBox_Answer" style="z-index: 1"></asp:TextBox>
                      </td>  
                </tr>
            </table>
            <!--注册按钮-->
             <asp:Button ID="Button2" runat="server" CssClass="Button_Login" Text="返回"  style="left:380px;" OnClick="Button_Back_Click"/>
            <asp:Button ID="Button_Login" runat="server" CssClass="Button_Login" Text="注册"  style="left:200px;"/>
                    
        </asp:Panel>
       
    </form>
</body>
</html>
