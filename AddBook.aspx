<%@ Page Language="C#" MasterPageFile="ManagerManage.Master" AutoEventWireup="true" CodeFile="AddBook.aspx.cs" Inherits="AddBook" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" type="text/css" href="css/BookManage_AddAlter.css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!--添加书籍Panel-->
    <asp:Panel ID="PanelAddBook" runat="server" CssClass="PanelMain">
        <asp:Image ID="ImagTitleAdd" runat="server" AlternateText="书籍管理-书籍添加" CssClass="Title" ImageUrl="~/Image/BookManage_Add.png" />
        <!--点击添加封面，添加后显示图片，再次点击可修改-->
        <asp:ImageButton ID="ImgAddrCover" runat="server" CssClass="Cover" ImageUrl="~/Image/AddBook.png" AlternateText="点击添加封面" OnClick="ImgAdCover_Click" />

        <table class="Table">
            <tr>
                <td class="Table0"></td>
                <td class="Table1">
                    <asp:Label ID="LabBookName" runat="server" Text="书名:"></asp:Label>
                </td>
                <td>
                    <!--输入：书名-->
                    <asp:TextBox ID="TextBName" runat="server" CssClass="TableTb"></asp:TextBox></td>
            </tr>
            <tr>
                <td></td>
                <td>
                    <asp:Label ID="LabBookID" runat="server" Text="书号:"></asp:Label>
                </td>


                <td>
                    <!--输入：书号-->
                    <asp:TextBox ID="TextBID" runat="server" CssClass="TableTb"></asp:TextBox></td>
            </tr>
            <tr>
                <td></td>

                <td>
                    <asp:Label ID="LabAuthor" runat="server" Text="作者:"></asp:Label>
                </td>
                <td>
                    <!--输入：作者-->
                    <asp:TextBox ID="TextAuthor" runat="server" CssClass="TableTb"></asp:TextBox></td>

            </tr>
            <tr>
                <td></td>
                <td>
                    <asp:Label ID="LabPress" runat="server" Text="出版社:"></asp:Label>
                </td>
                <td>
                    <!--输入：出版社-->
                    <asp:TextBox ID="TextPress" runat="server" CssClass="TableTb"></asp:TextBox></td>
            </tr>
            <tr>
                <td></td>
                <td>
                    <asp:Label ID="LabCategory" runat="server" Text="分类:"></asp:Label></td>
                <td>
                    <!--选择：分类-->
                    <asp:DropDownList ID="DDLCategory" runat="server" CssClass="TableTb">
                        <asp:ListItem>教育</asp:ListItem>
                        <asp:ListItem>文艺</asp:ListItem>
                        <asp:ListItem>科技</asp:ListItem>
                        <asp:ListItem>生活</asp:ListItem>
                        <asp:ListItem>人文社科</asp:ListItem>
                        <asp:ListItem>少儿读物</asp:ListItem>
                    </asp:DropDownList></td>
            </tr>
            <tr>
                <td></td>
                <td>
                    <asp:Label ID="LabPrice" runat="server" Text="价格(元):"></asp:Label></td>
                <td>
                    <!--输入：价格-->
                    <asp:TextBox ID="TextPrice" runat="server" CssClass="TableTb"></asp:TextBox></td>
            </tr>
            <tr>
                <td></td>
                <td>
                    <asp:Label ID="LabInventory" runat="server" Text="库存量:"></asp:Label></td>
                <td>
                    <!--输入：库存量-->
                    <asp:TextBox ID="TextInventory" runat="server" CssClass="TableTb"></asp:TextBox></td>
            </tr>
        </table>






        <asp:Label ID="LabDetail" runat="server" CssClass="lbDetail" Text="详细内容："></asp:Label>
        <!--详细内容-->
        <asp:TextBox ID="TextBDetail" runat="server" CssClass="Detail" TextMode="MultiLine"></asp:TextBox>
        <!--取消与保存button-->
        <asp:LinkButton ID="lbCancel" runat="server" CssClass="ButtonN" OnClick="Cancel_Click">取消</asp:LinkButton>
        <asp:LinkButton ID="lbSave" runat="server" CssClass="ButtonY" OnClick="Save_Click">确定</asp:LinkButton>
        <!--上架时间采用点击确定button时的系统时间，不使用管理员手动输入-->

    </asp:Panel>


</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
