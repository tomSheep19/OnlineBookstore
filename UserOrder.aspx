<%@ Page Language="C#" MasterPageFile="Master.Master" AutoEventWireup="true" CodeFile="UserOrder.aspx.cs" Inherits="UserOrder" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="css/UserShoppingCart.css" />
    <style type="text/css">
        .pnlUserOrder {
            width: 1323px;
            height: 1638px;
            position: absolute;
            top: 227px;
            left: 14px;
            z-index: 1;
        }

        .pnlOrderDetails {
            width: 1284px;
            height: 1428px;
            position: absolute;
            top: 78px;
            left: 26px;
            z-index: 1;
        }

        .grvUserOrder {
            position: relative;
            top: 0px;
            left: 0px;
            width: 1264px;
            height: 1429px;
        }

        .grvOrderDetails {
            position: relative;
            top: 0px;
            left: 0px;
            width: 1264px;
        }



        .txtOrderSearch {
            border-radius: 8px;
            border-color: #5CACEE;
            background-color: white;
            border-width: 4px;
            width: 200px;
            height: 25px;
            padding-left: 8px;
            padding-top: 2px;
            text-align: left;
            font-family: 'Microsoft YaHei';
            font-size: 1em;
            background-image: url('../Images/sousuo.png');
            background-repeat: no-repeat;
        }

            .txtOrderSearch:hover, .txtOrderSearch:focus, .txtOrderSearch:active {
                color: white;
                font-weight: 900;
                border-color: #8DEEEE;
                background-color: #8DEEEE;
                transition: all 2s;
                -webkit-transition: all 2s;
            }

        .cmdOrderDelete {
            width: 116px;
            border-width: 2px;
            border-color: #5cacee;
            color: black;
            border-radius: 8px;
            font-family: 'Microsoft YaHei';
            font-size: 1em;
            font-weight: 400;
            background-color: white;
        }

            .cmdOrderDelete:hover {
                color: red;
                background-color: #5cacee;
                transition: all .3s;
                -webkit-transition: all .3s;
            }

        .ckbAllChoose {
            width: 60px;
            height: 20px;
            font-family: 'Microsoft YaHei';
            font-size: 1em;
            font-weight: 400;
            text-align: left;
            color: black;
        }

        .cmdOrderSearch {
            height: 30px;
            width: 60px;
            padding-top: 6px;
            border-width: 0px;
            border-radius: 5px;
            font-family: 'Microsoft YaHei';
            color: white;
            text-align: center;
            text-decoration-style: double;
            font-weight: 700;
            background-color: #5CACEE;
            font-size: 1em;
        }

            .cmdOrderSearch:hover, .cmdOrderSearch:focus {
                font-weight: 900;
                color: white;
                background-color: #8DEEEE;
                transition: all 1s;
                -webkit-transition: all 1s;
            }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:Panel ID="pnlUserOrder" runat="server" BorderWidth="0px" CssClass="pnlUserOrder">


        <asp:Panel ID="pnlOrderDetails" runat="server" CssClass="pnlOrderDetails" ScrollBars="Auto">
            <asp:GridView ID="grvUserOrder" runat="server" AutoGenerateColumns="False" CssClass="grvUserOrder" ShowHeader="False">
                <Columns>
                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:Panel ID="pnlOrderOperation" runat="server" Width="1264px" Height="20px" background-color="blue" Style="position: relative; top: 0px; left: 0px">
                                <asp:CheckBox ID="ckbUserOrder" Text="" runat="server" />
                                订单号：
                                <%--订单号，绑定数据--%>
                      <asp:Label ID="lblOrderNum" Text='<%# Eval("orderId") %>' runat="server" Width="500px"></asp:Label>
                            </asp:Panel>
                            <br />
                            <asp:GridView ID="grvOrderDetails" runat="server" CssClass="grvOrderDetails" ShowHeader="False" RowStyle-Height="200px" AutoGenerateColumns="False" CellPadding="4" ForeColor="#333333" GridLines="None" OnSelectedIndexChanged="grvOrderDetails_OnSelectedIndexChanged">
                                <AlternatingRowStyle BackColor="White" />
                                <Columns>
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <%--图书图片，绑定数据--%>
                                            <asp:ImageButton ID="icmdBookPic" ImageUrl='<%# Eval("Book.bookImageURL") %>' runat="server" CssClass="icmdSCBookPic" />
                                        </ItemTemplate>
                                        <ItemStyle Width="145px" />
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <%--图书名字，绑定数据--%>
                                            <asp:LinkButton Text='<%# Eval("Book.bookName") %>' ID="lcmdBookName" runat="server" CssClass="lcmdSCBookName" Font-Underline="false" Width="100px"></asp:LinkButton>
                                            <br />
                                            <br />
                                            <br />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <asp:Label ID="lblBookPriceM" runat="server" Text="单价：" CssClass="lblSCBookPriceM"></asp:Label>
                                            <%--图书单价，绑定数据--%>
                                            <asp:Label ID="lblBookPrice" Text='<%# Eval("Book.bookPrice") %>' runat="server" CssClass="lblSCBookPrice"></asp:Label>&nbsp;元
                     <br />
                                            <br />
                                            <asp:Panel ID="pnlBookNum" runat="server" CssClass="pnlSCBookNum">
                                                <%--图书数量，绑定数据--%>
                                                <asp:Label ID="lblBookNum" CssClass="lblSCBookNum" runat="server" Text='<%# Eval("bookAmount") %>' Height="27px" Width="25px"></asp:Label>
                                            </asp:Panel>
                                            <br />
                                            <br />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <asp:Label ID="lblBookPriceSum" runat="server" Text="总计：" CssClass="lblSCBookPriceM"></asp:Label>
                                            <%--图书总价，绑定数据--%>
                                            <asp:Label ID="lblBookSum" Text='<%# Eval("totalPrice") %>' runat="server" CssClass="lblSCBookPrice"></asp:Label>&nbsp;元
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Center" />
                                    </asp:TemplateField>
                                </Columns>
                                <FooterStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
                                <HeaderStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
                                <PagerStyle BackColor="#FFCC66" ForeColor="#333333" HorizontalAlign="Center" />
                                <RowStyle BackColor="#FFFBD6" Height="200px" ForeColor="#333333" />
                                <SelectedRowStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="Navy" />
                                <SortedAscendingCellStyle BackColor="#FDF5AC" />
                                <SortedAscendingHeaderStyle BackColor="#4D0000" />
                                <SortedDescendingCellStyle BackColor="#FCF6C0" />
                                <SortedDescendingHeaderStyle BackColor="#820000" />
                            </asp:GridView>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>


        </asp:Panel>
        <table class="auto-style38">
            <tr>
                <td>
                    <asp:Button ID="cmdOrderDelete0" runat="server" CssClass="cmdDelete" ForeColor="#CC0000" Text="删除所选订单" Style="position: absolute; top: 1560px; left: 35px" />
                </td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td>&nbsp;
                  <asp:TextBox runat="server" ID="txtOrderSearch" CssClass="txtOrderSearch" Text="" Width="198px" Height="18px"></asp:TextBox>
                    &nbsp;
                  <asp:Button runat="server" ID="cmdOrderSearch" CssClass="cmdOrderSearch" Text="搜索" />
                </td>
                <td>&nbsp;<asp:CheckBox runat="server" ID="ckbAllChoose" Text="全选" CssClass="ckbAllChoose" /></td>
                <td>&nbsp;<asp:Button runat="server" ID="cmdOrderDelete" Text="删除所选订单" CssClass="cmdOrderDelete" /></td>
            </tr>
            <tr>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
            </tr>
        </table>
    </asp:Panel>
</asp:Content>
