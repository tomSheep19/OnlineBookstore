<%@ Page Language="C#" MasterPageFile="ManagerManage.Master" AutoEventWireup="true" CodeFile="UserManage.aspx.cs" Inherits="UserManage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" type="text/css" href="css/UserManage_zero.css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!--搜索Panel-->
    <asp:Panel ID="P_Search" runat="server" CssClass="P_Search">
        <asp:Label ID="lbUID" runat="server" Text="用户名" CssClass="lbOID"></asp:Label>
        <!--搜索条件框-->
        <asp:TextBox ID="txtUserSearch" runat="server" CssClass="TBSearch"></asp:TextBox>
        <!--搜索button-->
        <asp:LinkButton ID="cmdUserSearch" runat="server" CssClass="SearchButton" OnClick="icmdOrderSearch_Click">搜索</asp:LinkButton>
        <!--所有用户button-->
        <asp:LinkButton ID="cmdAllUsers" runat="server" CssClass="AllOrder" OnClick="cmdAllOrder_Click">所有用户</asp:LinkButton>
    </asp:Panel>


    <!--用户管理Panel-->
    <asp:Panel ID="P_UserShow" runat="server" CssClass="P_UserShow">
        <!--用户管理gridview-->
        <asp:GridView ID="grvAllUser" runat="server" OnRowCommand="grvAllUser_OnRowCommand" AllowPaging="True" AutoGenerateColumns="False" CssClass="GV_UserShow" PageSize="9">
            <Columns>
                <asp:BoundField HeaderText="用户名" HeaderStyle-CssClass="GV_Title1" ItemStyle-CssClass="GV_Item1" DataField="Name" SortExpression="Name">
                <HeaderStyle CssClass="GV_Title1" />
                <ItemStyle CssClass="GV_Item1" />
                </asp:BoundField>
                <asp:BoundField HeaderText="密码" HeaderStyle-CssClass="GV_Title2" ItemStyle-CssClass="GV_Item2" DataField="Password" SortExpression="Password">
                <HeaderStyle CssClass="GV_Title2" />
                <ItemStyle CssClass="GV_Item2" />
                </asp:BoundField>
                <asp:BoundField HeaderText="安全问题" HeaderStyle-CssClass="GV_Title3" ItemStyle-CssClass="GV_Item3" DataField="securityQuestion" SortExpression="securityQuestion">
                <HeaderStyle CssClass="GV_Title3" />
                <ItemStyle CssClass="GV_Item3" />
                </asp:BoundField>
                <asp:BoundField HeaderText="安全问题回答" HeaderStyle-CssClass="GV_Title4" ItemStyle-CssClass="GV_Item4" DataField="securityQuestionAnswer" SortExpression="securityQuestionAnswer">
                <HeaderStyle CssClass="GV_Title4" />
                <ItemStyle CssClass="GV_Item4" />
                </asp:BoundField>
                <asp:BoundField HeaderText="登陆状态" HeaderStyle-CssClass="GV_Title5" ItemStyle-CssClass="GV_Item5" DataField="legalityState" DataFormatString="{0:限制登陆;;允许登陆}" SortExpression="legalityState">
                <HeaderStyle CssClass="GV_Title5" />
                <ItemStyle CssClass="GV_Item5" />
                </asp:BoundField>

                <asp:TemplateField HeaderStyle-CssClass="GV_Title6" ItemStyle-CssClass="GV_Item6">
                    <ItemTemplate>
                        <asp:LinkButton ID="LoginN" runat="server" CommandName="N" CommandArgument='<%# Eval("Name") %>' CssClass="LoginN" >限制登录</asp:LinkButton>

                        <asp:LinkButton ID="LoginY" runat="server" CssClass="LoginY" CommandName="Y" CommandArgument='<%# Eval("Name") %>' >解除限制</asp:LinkButton>
                    </ItemTemplate>

                    <HeaderStyle CssClass="GV_Title6" />
                    <ItemStyle CssClass="GV_Item6" />

                </asp:TemplateField>
            </Columns>
            <PagerStyle Height="20px" HorizontalAlign="Right" />
        </asp:GridView>





    </asp:Panel>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
