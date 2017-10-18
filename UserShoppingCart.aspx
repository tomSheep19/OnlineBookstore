<%@ Page Language="C#" MasterPageFile="Master.Master" AutoEventWireup="true" CodeFile="UserShoppingCart.aspx.cs" Inherits="UserShoppingCart" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="css/UserShoppingCart.css" />
    <style type="text/css">
        .auto-style1 {
            position: relative;
            top: 0px;
            left: 0px;
            width: 1320px;
            height: 424px;
        }
         .cmdSCBuyNow{
            text-align:center;
            border-radius:5px;
    border-style:solid;
    height:30px;
    width:120px;
    border-width:0px;
    color:white;
    font-family:'Microsoft YaHei';
    font-weight:700;
    font-size:1em;
    background-color:#f4830e;
    position:absolute;
    left:1100px;
    top:920px;
        }
        .cmdSCBuyNow:hover{
        border-color: #f4830e;
        border-style: solid;
        border-width: 2px;
        background-color: white;
        color: #f4830e;
        transition: all .7s;
        -webkit-transition: all .7s;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:Panel ID="pnlShoppingCart" runat="server" CssClass="pnlShoppingCart">
        <asp:CheckBox ID="ckbChooseAll" runat="server" CssClass="ckbChooseAll" Text="               全选" AutoPostBack="True" OnCheckedChanged="ckbChooseAll_CheckedChanged" /><%--<asp:Label ID="lblChooseAll" runat="server" CssClass="lblChooseAll"></asp:Label>--%>
        <asp:Button ID="cmdDelete" runat="server" CssClass="cmdDelete" Text="批量删除" />
        <div id="divSCD" runat="server" class="divSCD">
            <%--购物车--%>
            <asp:GridView ID="gridview_ShoppingCart" GridLines="None" OnRowCommand="gridview_ShoppingCart_OnRowCommand" runat="server" AutoGenerateColumns="False" CssClass="grvShoppingCart" ShowHeader="False" >
                <Columns>
                    <asp:TemplateField HeaderText="SCBookPic" ShowHeader="False">
                        <ItemTemplate>
                            <asp:ScriptManagerProxy ID="ScriptManager1" runat="server"></asp:ScriptManagerProxy>
                            <%--待完善--该方法后期试试--%>
                           <%-- 异步刷新图书勾选框--%>
                            <asp:UpdatePanel ID="UpdatePanel_checkBoxState" UpdateMode="Conditional" runat="server">
                                <ContentTemplate>
                                     <asp:CheckBox ID="ckbSCBookChoose"  runat="server" CssClass="ckbChoose" />
                                </ContentTemplate>
                            </asp:UpdatePanel>
                           <%-- 异步刷新图书勾选框--%>
                            
                        </ItemTemplate>
                        <ItemStyle Width="20px" />
                    </asp:TemplateField>
                    <asp:TemplateField>
                        <ItemTemplate>
                            <%--图书图片--%>
                            <asp:ImageButton ID="icmdSCBookPic" ImageUrl='<%# Eval("Book.bookImageURL") %>' CssClass="icmdSCBookPic" runat="server" />
                        </ItemTemplate>
                        <ItemStyle Width="160px"/>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="SCBookInfo" ShowHeader="False">
                        <ItemTemplate>
                            <%--图书名字--%>
                            <asp:LinkButton Text='<%# Eval("Book.bookName") %>' ID="lcmdSCBookName" runat="server" CssClass="lcmdSCBookName" Font-Underline="false"></asp:LinkButton>
                        </ItemTemplate>
                        <ItemStyle Width="267px" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="SCBookPrice" ShowHeader="false">
                        <ItemTemplate>
                            <%--图书价格--%>
                            <asp:Label ID="lblSCBookPriceM" runat="server" Text="单价：" CssClass="lblSCBookPriceM"></asp:Label>
                            <asp:Label ID="lblSCBookPrice" Text='<%# Eval("Book.bookPrice") %>' runat="server" CssClass="lblSCBookPrice"></asp:Label>&nbsp;元                          
                        </ItemTemplate>
                        <ItemStyle Width="267px" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="SCBookNum" ShowHeader="false">
                        <ItemTemplate>
                            <asp:Panel ID="pnlSCBookNum" runat="server" CssClass="pnlSCBookNum">

                                <%--异步刷新图书数量--%>
                                <asp:UpdatePanel ID="UpdatePanel_BookAmount" UpdateMode="Conditional" runat="server">
                                    <ContentTemplate>
                                        <%--减少某本书的数量--%>
                                        <asp:Button ID="cmdSCBookNumReduce" CommandName="Reduce" CommandArgument="<%# ((GridViewRow) Container).RowIndex %>" CssClass="cmdSCBookNumReduce" Text="-" runat="server" Width="20px" Height="27px" />
                                        <asp:Label ID="lblSCBookNum" CssClass="lblSCBookNum" runat="server" Text='<%# Eval("bookAmount") %>' Height="27px" Width="25px"></asp:Label>
                                        <%--增加某本书的数量--%>
                                        <asp:Button ID="cmdSCBookNumAdd" CommandName="Plus" CommandArgument="<%# ((GridViewRow) Container).RowIndex %>" CssClass="cmdSCBookNumAdd" Text="+" runat="server" Width="20px" Height="27px" />
                                    </ContentTemplate>
                                </asp:UpdatePanel>

                            </asp:Panel>
                        </ItemTemplate>
                        <ItemStyle Width="300px" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="SCBookDelete" ShowHeader="false">
                        <ItemTemplate>
                            
                        <asp:Button ID="cmdSCBookDelete" CommandName="DeleteBook" CommandArgument="<%# ((GridViewRow) Container).RowIndex %>" Text="删除" runat="server" CssClass="cmdSCBookDelete" />
                            
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:TemplateField>

                </Columns>
                <RowStyle Height="210px" HorizontalAlign="Left" />
            </asp:GridView>
        </div>

        <asp:Image ID="iconShoppingCart" runat="server" />
        <asp:Button ID="ConfirmBuy" CssClass="cmdSCBuyNow" runat="server" OnClick="ConfirmBuy_Click" Text="确认购买" />
        <asp:Panel ID="pnlBookRecommend" runat="server" CssClass="pnlBookRecommend">
            <asp:GridView ID="grvBookRecommend" runat="server" AllowPaging="True" AutoGenerateColumns="False" CssClass="auto-style1" PageSize="1" ShowHeader="False">
                <Columns>
                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:ImageButton ID="icmdBookRecommend" CssClass="icmdBookRecommend" runat="server" /><br />
                            <asp:LinkButton ID="lcmdBookName" runat="server" CssClass="lcmdBookName" Font-Underline="false" />
                            <br />
                            <asp:Label ID="lblAuthor" runat="server" Text="作者" CssClass="lblAuthor"></asp:Label>
                            <asp:Label ID="lblAuthorName" runat="server" CssClass="lblAuthor"></asp:Label>
                            <br />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:ImageButton ID="ImageButton1" runat="server" CssClass="icmdBookRecommend" /><br />
                            <asp:LinkButton ID="lkbBookName" runat="server" CssClass="lcmdBookName" Font-Underline="false" />
                            <br />
                            <asp:Label ID="Label1" runat="server" Text="作者" CssClass="lblAuthor"></asp:Label>
                            <asp:Label ID="Label2" runat="server" CssClass="lblAuthor"></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:ImageButton ID="ImageButton2" runat="server" CssClass="icmdBookRecommend" /><br />
                            <asp:LinkButton ID="LinkButton1" runat="server" CssClass="lcmdBookName" Font-Underline="false" />
                            <br />
                            <asp:Label ID="Label3" runat="server" Text="作者" CssClass="lblAuthor"></asp:Label>
                            <asp:Label ID="Label4" runat="server" CssClass="lblAuthor"></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:ImageButton ID="ImageButton3" CssClass="icmdBookRecommend" runat="server" /><br />
                            <asp:LinkButton ID="LinkButton2" runat="server" CssClass="lcmdBookName" Font-Underline="false" />
                            <br />
                            <asp:Label ID="Label5" runat="server" Text="作者" CssClass="lblAuthor"></asp:Label>
                            <asp:Label ID="Label6" runat="server" CssClass="lblAuthor"></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:ImageButton ID="ImageButton4" runat="server" CssClass="icmdBookRecommend" /><br />
                            <asp:LinkButton ID="LinkButton3" runat="server" Text="花千骨" CssClass="lcmdBookName" Font-Underline="false" />
                            <br />
                            <asp:Label ID="Label7" runat="server" Text="作者" CssClass="lblAuthor"></asp:Label>
                            <asp:Label ID="Label8" runat="server" Text="唐七公子" CssClass="lblAuthor"></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:ImageButton ID="ImageButton5" runat="server" CssClass="icmdBookRecommend" /><br />
                            <asp:LinkButton ID="LinkButton4" runat="server" CssClass="lcmdBookName" Font-Underline="false" />
                            <br />
                            <asp:Label ID="Label9" runat="server" Text="作者" CssClass="lblAuthor"></asp:Label>
                            <asp:Label ID="Label10" runat="server" CssClass="lblAuthor"></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
                <PagerStyle HorizontalAlign="Center" />
                <RowStyle Height="380px" />

            </asp:GridView>
            
        </asp:Panel>
        <asp:Label ID="lblSCBookUlike" runat="server" CssClass="lblSCBookUlike" Text="      猜你喜欢"></asp:Label>
    </asp:Panel>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>

