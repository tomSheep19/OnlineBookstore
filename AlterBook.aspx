<%@ Page Language="C#" MasterPageFile="ManagerManage.Master" AutoEventWireup="true" CodeFile="AlterBook.aspx.cs" Inherits="AlterBook" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" type="text/css" href="CSS/BookManage_AddAlter.css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!--书籍修改Panel-->
    <asp:Panel ID="PanelAlterBook" runat="server" CssClass="PanelMain">
        <asp:Image ID="ImagTitleAlter" runat="server" AlternateText="书籍管理-书籍修改" CssClass="Title" ImageUrl="~/Image/BookManage_Alter.png" />
        <!--显示书籍封面，点击修改封面-->
        <asp:ImageButton ID="ImgAlterCover" runat="server" CssClass="Cover" AlternateText="点击修改封面" OnClick="ImgAlterCover_Click" />

        <table class="Table">
            <tr>
                <td class="Table0"></td>
                <td>
                    <asp:Label ID="LabBookName" runat="server" Text="书名:"></asp:Label>
                </td>
                <td>
                    <!--显示：书名，可修改-->
                    <asp:TextBox ID="TextBName" runat="server" CssClass="TableTb"></asp:TextBox></td>

            </tr>
            <tr>
                <td></td>
                <td>
                    <asp:Label ID="LabBookID" runat="server" Text="书号:"></asp:Label>
                </td>
                <td>
                    <!--显示：书号，可修改-->
                    <asp:TextBox ID="TextBID" runat="server" CssClass="TableTb"></asp:TextBox></td>
            </tr>
            <tr>
                <td></td>
                <td>
                    <asp:Label ID="LabAuthor" runat="server" Text="作者:"></asp:Label>
                </td>
                <td>
                    <!--显示：作者，可修改-->
                    <asp:TextBox ID="TextAuthor" runat="server" CssClass="TableTb"></asp:TextBox></td>
            </tr>
            <tr>
                <td></td>
                <td>
                    <asp:Label ID="LabPress" runat="server" Text="出版社:"></asp:Label>
                </td>
                <td>
                    <!--显示：出版社，可修改-->
                    <asp:TextBox ID="TextPress" runat="server" CssClass="TableTb"></asp:TextBox></td>
            </tr>
            <tr>
                <td></td>
                <td>
                    <asp:Label ID="LabCategory" runat="server" Text="分类:"></asp:Label></td>
                <td>
                    <!--显示：分类，可修改-->
                    <asp:DropDownList ID="DDLCategory" runat="server" CssClass="TableTb">
                        <asp:ListItem Value="Education">教育</asp:ListItem>
                        <asp:ListItem Value="Literature">文艺</asp:ListItem>
                        <asp:ListItem Value="Science">科技</asp:ListItem>
                        <asp:ListItem Value="Life">生活</asp:ListItem>
                        <asp:ListItem Value="Humanity">人文社科</asp:ListItem>
                        <asp:ListItem Value="Children">少儿读物</asp:ListItem>
                    </asp:DropDownList></td>
            </tr>
            <tr>
                <td></td>
                <td>
                    <asp:Label ID="LabPrice" runat="server" Text="价格(元):"></asp:Label></td>
                <td>
                    <!--显示：价格，可修改-->
                    <asp:TextBox ID="TextPrice" runat="server" CssClass="TableTb"></asp:TextBox></td>
            </tr>
            <tr>
                <td></td>
                <td>
                    <asp:Label ID="LabInventory" runat="server" Text="库存量"></asp:Label></td>
                <td>
                    <!--显示：库存量，可修改-->
                    <asp:TextBox ID="TextInventory" runat="server" CssClass="TableTb"></asp:TextBox>
                </td>
            </tr>
        </table>







        <asp:Label ID="LabDetail" runat="server" CssClass="lbDetail" Text="详细内容："></asp:Label>
        <!--显示：详细内容，可修改-->
        <asp:TextBox ID="TextBDetail" runat="server" CssClass="Detail" TextMode="MultiLine"></asp:TextBox>
        <!--取消与保存button-->
        <asp:LinkButton ID="lbCancel" runat="server" CssClass="ButtonN" OnClick="lbCancel_OnClick">取消</asp:LinkButton>
        <asp:LinkButton ID="lbSave" runat="server" CssClass="ButtonY" OnClick="lbSave_OnClick">确定</asp:LinkButton>
    </asp:Panel>
    <p>
    </p>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
