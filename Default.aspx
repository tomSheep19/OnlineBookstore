<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:ListView ID="ListView1" runat="server" DataSourceID="ObjectDataSource1" 
            GroupItemCount="4" OnItemCommand="ListView1_OnItemCommand">
                
            <EditItemTemplate>
                <td runat="server" style="background-color: #999999;">
                    Price:
                    <asp:TextBox ID="PriceTextBox" runat="server" Text='<%# Bind("Price") %>' />
                    <br />BookId:
                    <asp:TextBox ID="BookIdTextBox" runat="server" Text='<%# Bind("BookId") %>' />
                    <br />BookName:
                    <asp:TextBox ID="BookNameTextBox" runat="server" 
                        Text='<%# Bind("BookName") %>' />
                    <br />
                    <asp:Button ID="UpdateButton" runat="server" CommandName="Update" Text="更新" />
                    <br />
                    <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="取消" />
                    <br />
                </td>
            </EditItemTemplate>
            <EmptyDataTemplate>
                <table runat="server" 
                    style="background-color: #FFFFFF;border-collapse: collapse;border-color: #999999;border-style:none;border-width:1px;">
                    <tr>
                        <td>
                            未返回数据。</td>
                    </tr>
                </table>
            </EmptyDataTemplate>
            <EmptyItemTemplate>
<td runat="server" />
            </EmptyItemTemplate>
            <GroupTemplate>
                <tr ID="itemPlaceholderContainer" runat="server">
                    <td ID="itemPlaceholder" runat="server">
                    </td>
                </tr>
            </GroupTemplate>
            <InsertItemTemplate>
                <td runat="server" style="">
                    Price:
                    <asp:TextBox ID="PriceTextBox" runat="server" Text='<%# Bind("Price") %>' />
                    <br />BookId:
                    <asp:TextBox ID="BookIdTextBox" runat="server" Text='<%# Bind("BookId") %>' />
                    <br />BookName:
                    <asp:TextBox ID="BookNameTextBox" runat="server" 
                        Text='<%# Bind("BookName") %>' />
                    <br />
                    <asp:Button ID="InsertButton" runat="server" CommandName="Insert" Text="插入" />
                    <br />
                    <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="清除" />
                    <br />
                </td>
            </InsertItemTemplate>
            <ItemTemplate>
                <td runat="server" class="style1" 
                    style="background-color: #FFFFFF; color: #284775;">
                    书号:
                    <asp:Label ID="BookIdLabel" runat="server" Text='<%# Eval("BookId") %>' />
                    <br />
                    书名:
                    <asp:Label ID="BookNameLabel" runat="server" Text='<%# Eval("BookName") %>' />
                    <br />
                    价格:
                    <asp:Label ID="PriceLabel" runat="server" Text='<%# Eval("Price") %>'></asp:Label>
                    <br />
                    <asp:Button ID="Button2" runat="server" CommandArgument='<%# Eval("BookId") %>' 
                        CommandName="Add" Text="添加到购物车" />
                    <br />
                </td>
            </ItemTemplate>
            <LayoutTemplate>
                <table runat="server">
                    <tr runat="server">
                        <td runat="server">
                            <table ID="groupPlaceholderContainer" runat="server" border="1" 
                                style="background-color: #FFFFFF;border-collapse: collapse;border-color: #999999;border-style:none;border-width:1px;font-family: Verdana, Arial, Helvetica, sans-serif;">
                                <tr ID="groupPlaceholder" runat="server">
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr runat="server">
                        <td runat="server" 
                            style="text-align: center;background-color: #5D7B9D;font-family: Verdana, Arial, Helvetica, sans-serif;color: #FFFFFF">
                            <asp:DataPager ID="DataPager1" runat="server" PageSize="12">
                                <Fields>
                                    <asp:NextPreviousPagerField ButtonType="Button" ShowFirstPageButton="True" 
                                        ShowLastPageButton="True" />
                                </Fields>
                            </asp:DataPager>
                        </td>
                    </tr>
                </table>
            </LayoutTemplate>
            <SelectedItemTemplate>
                <td runat="server" 
                    style="background-color: #E2DED6;font-weight: bold;color: #333333;">
                    Price:
                    <asp:Label ID="PriceLabel" runat="server" Text='<%# Eval("Price") %>' />
                    <br />BookId:
                    <asp:Label ID="BookIdLabel" runat="server" Text='<%# Eval("BookId") %>' />
                    <br />BookName:
                    <asp:Label ID="BookNameLabel" runat="server" Text='<%# Eval("BookName") %>' />
                    <br />
                </td>
            </SelectedItemTemplate>
        </asp:ListView>
        <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" SelectMethod="RecommendedBook" TypeName="OnlineBookStore.App_Code.User"></asp:ObjectDataSource>
    </form>
</body>
</html>
