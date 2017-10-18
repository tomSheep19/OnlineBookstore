<%@ Page Language="C#" MasterPageFile="ManagerManage.Master" AutoEventWireup="true" CodeFile="OrderManage.aspx.cs" Inherits="OrderManage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" type="text/css" href="css/OrderManage_zero.css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!--搜索Panel-->
    <asp:Panel ID="P_Search" runat="server" CssClass="P_Search">
        <asp:Label ID="lbOID" runat="server" Text="订单号" CssClass="lbOID"></asp:Label>
        <!--搜索条件框-->
        <asp:TextBox ID="txtBookSearch" runat="server" CssClass="TBSearch"></asp:TextBox>
        <!--搜索button-->
        <asp:LinkButton ID="lbSearchOrder" runat="server" CssClass="SearchButton" OnClick="icmdOrderSearch_Click">搜索</asp:LinkButton>
        <!--所有订单button-->
        <asp:LinkButton ID="lbAllOrder" runat="server" CssClass="AllOrder" OnClick="cmdAllOrder_Click">所有订单</asp:LinkButton>
    </asp:Panel>



    <!--订单展示Panel-->
    <asp:Panel ID="P_OrderShow" runat="server" CssClass="P_OrderShow">
        <!--订单gridview-->
        <asp:GridView ID="grvOrderInfo" Height="320px" OnRowCommand="grvOrderInfo_OnRowCommand" runat="server" AllowPaging="True" AllowSorting="True" CssClass="GV_OrderShow" AutoGenerateColumns="False" HorizontalAlign="Center" PageSize="5">
            <Columns>
                <asp:BoundField HeaderText="订单号" SortExpression="订单号" HeaderStyle-CssClass="GV_Title1" ItemStyle-CssClass="GV_Item1" DataField="orderId">
                <HeaderStyle CssClass="GV_Title1" />
                <ItemStyle CssClass="GV_Item1" />
                </asp:BoundField>
                <asp:BoundField HeaderText="用户名" SortExpression="用户名" HeaderStyle-CssClass="GV_Title2" ItemStyle-CssClass="GV_Item2" DataField="userName">
                <HeaderStyle CssClass="GV_Title2" />
                <ItemStyle CssClass="GV_Item2" />
                </asp:BoundField>
                <asp:BoundField HeaderText="下单" SortExpression="下单时间" HeaderStyle-CssClass="GV_Title3" ItemStyle-CssClass="GV_Item3" DataField="orderDate">
                <HeaderStyle CssClass="GV_Title3" />
                <ItemStyle CssClass="GV_Item3" />
                </asp:BoundField>
                <asp:BoundField HeaderText="总价(元)" SortExpression="总价" HeaderStyle-CssClass="GV_Title4" ItemStyle-CssClass="GV_Item4" DataField="Price">
                <HeaderStyle CssClass="GV_Title4" />
                <ItemStyle CssClass="GV_Item4" />
                </asp:BoundField>
                <asp:BoundField HeaderText="有效" SortExpression="有效" HeaderStyle-CssClass="GV_Title5" ItemStyle-CssClass="GV_Item5" DataField="isValid">
                <HeaderStyle CssClass="GV_Title5" />
                <ItemStyle CssClass="GV_Item5" />
                </asp:BoundField>

                <asp:TemplateField ShowHeader="False" HeaderStyle-CssClass="GV_Title6" ItemStyle-CssClass="GV_Item6">
                    <ItemTemplate>
                        <!--选择button-->
                        <asp:LinkButton ID="BChoose" CommandName="Select" CommandArgument='<%# Eval("orderId") %>' runat="server" CssClass="ChooseButton" OnClick="cmdOrderChoose_Click">选择</asp:LinkButton>
                    </ItemTemplate>
                    <HeaderStyle CssClass="GV_Title6" />
                    <ItemStyle CssClass="GV_Item6" />
                </asp:TemplateField>
            </Columns>
            <EditRowStyle HorizontalAlign="Center" />
            <PagerStyle HorizontalAlign="Right" Font-Size="Medium" Height="16px" Wrap="True" />
            <RowStyle HorizontalAlign="Center" Height="60px"/>
                              

        </asp:GridView>

    </asp:Panel>


    <!--订单详情panel-->
    <asp:Panel ID="P_OrderDetail" runat="server" CssClass="P_OrderDetail">
        &nbsp;&nbsp;&nbsp;&nbsp;
        <asp:Label ID="lblOrderDetails" runat="server" Font-Size="X-Large" Text="订单详情："></asp:Label>

        <asp:Label ID="lblOrderID" runat="server" Text="订单号："></asp:Label>
        <!--订单号-->
        <asp:Label ID="OrderID" runat="server" Text="[OrderID]"></asp:Label>


        <br />
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:Label ID="lblRemark" runat="server" Text="备注："></asp:Label>
        <!--备注-->
        <asp:Label ID="Remark" runat="server" Text="[Remark]"></asp:Label>
        <br />
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

            <asp:Label ID="lblOrderAdress" runat="server" Text="运送地址："></asp:Label>
        <!--运送地址-->
        <asp:Label ID="OrderAdress" runat="server" Text="[OrderAdress]"></asp:Label>
        <!--订单详情gridview-->
        <asp:GridView ID="grvOrderDetails" runat="server" AllowPaging="True" AutoGenerateColumns="False" CssClass="GV_Detail" Font-Overline="False" HorizontalAlign="Center" PageSize="3">
            <Columns>
                <asp:BoundField HeaderText="书号" HeaderStyle-CssClass="GV_DTitle1" ItemStyle-CssClass="GV_DItem1" DataField="Book.bookID">
                <HeaderStyle CssClass="GV_DTitle1" />
                <ItemStyle CssClass="GV_DItem1" />
                </asp:BoundField>
                <asp:BoundField HeaderText="书名" HeaderStyle-CssClass="GV_DTitle2" ItemStyle-CssClass="GV_DItem2" DataField="Book.bookName">
                <HeaderStyle CssClass="GV_DTitle2" />
                <ItemStyle CssClass="GV_DItem2" />
                </asp:BoundField>
                <asp:BoundField HeaderText="单价" HeaderStyle-CssClass="GV_DTitle3" ItemStyle-CssClass="GV_DItem3" DataField="Book.bookPrice">
                <HeaderStyle CssClass="GV_DTitle3" />
                <ItemStyle CssClass="GV_DItem3" />
                </asp:BoundField>
                <asp:BoundField HeaderText="数量" HeaderStyle-CssClass="GV_DTitle4" ItemStyle-CssClass="GV_DItem4" DataField="bookAmount">
                <HeaderStyle CssClass="GV_DTitle4" />
                <ItemStyle CssClass="GV_DItem4" />
                </asp:BoundField>
            </Columns>
            <EditRowStyle HorizontalAlign="Center" />
            <PagerStyle Font-Size="Medium" Height="5px" HorizontalAlign="Right" Wrap="True" />
        </asp:GridView>

    </asp:Panel>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>

