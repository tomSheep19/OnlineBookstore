<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="Master.Master" CodeFile="BookDetail.aspx.cs" Inherits="BookDetail" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link rel="stylesheet" type="text/css" href="css/BookDetails.css" />
    <link rel="stylesheet" type="text/css" href="css/Main.css" />


</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <br />

    <!-- 图书图片及基本介绍的版块-->
    <p class="p">
        <asp:Panel runat="server" CssClass="Panel1">
            <!--图书的图片-->
            <asp:ImageButton ID="Imagebtn_Picture" runat="server" CssClass="Imagebtn_Picture" />
            <!--图书的简介-->
            <asp:Panel ID="BookDetail1" runat="server" CssClass="BookDetail">

                <table class="table">
                    <tr>
                        <!--图书的名字-->
                        <td class="td1" colspan="2">
                            <asp:Label ID="Label_Name" runat="server" CssClass="Label_Name" Text="Label" Width="230px"></asp:Label>
                        </td>
                    </tr>
                    <tr>

                        <td class="td2">价格</td>
                        <!--图书的价格-->
                        <td class="td3">
                            <asp:Label ID="Label_Price" runat="server" CssClass="Label_Price" Style="z-index: 1; top: 74px; left: 111px;" Text="Label"></asp:Label>
                        </td>
                    </tr>
                    <!--图书的作者出版社库存-->

                    <tr>
                        <td class="td4">作者</td>
                        <td class="td6">
                            <asp:Label ID="Label_Author" runat="server" CssClass="Label_Author" Text="Label" /></td>
                    </tr>
                    <tr>
                        <td class="td4">出版社</td>
                        <td class="td6">
                            <asp:Label ID="Label_Number" runat="server" CssClass="Label_Number" Text="label" /></td>
                    </tr>
                    <tr>
                        <td class="td4">库存</td>
                        <td class="td6">
                            <asp:Label ID="Label_Press" runat="server" CssClass="Label_Press" Text="Label"></asp:Label></td>
                    </tr>
                    <tr>
                        <td class="td4">书号</td>
                        <td class="td6">
                            <asp:Label ID="Label_Stock" runat="server" CssClass="Label_Stock" Text="Label"></asp:Label></td>
                    </tr>
                    <!--图书的数量-->
                    <tr>
                        <td class="td5">数量</td>
                        <td>
                            <asp:TextBox ID="TextBox_Amount" runat="server" CssClass="TextBox_Amount" TextMode="Number"></asp:TextBox>
                            <br />
                        </td>
                    </tr>
                </table>

            </asp:Panel>
            <!--一键购买按钮-->
            <asp:LinkButton ID="Linkbtn_Quick" runat="server" CssClass="Quick" Text="一键购买" Style="top: 320px; left: 550px"></asp:LinkButton>
            <!--加入购物车按钮-->
            <asp:LinkButton ID="Linkbtn_Shoppingcart" runat="server" CssClass="Shoppingcar" Text="加入购物车" Style="top: 320px; left: 700px" OnClick="Linkbtn_Shoppingcart_Click"></asp:LinkButton>
        </asp:Panel>
    </p>

    <!--图书介绍以及评价版块-->
    <asp:Panel runat="server" CssClass="Panel2">
        <!--详细介绍按钮-->
        <asp:LinkButton ID="Linkbtn_detial" runat="server" CssClass="Detail" OnClick="DetailbtnClick">详细介绍</asp:LinkButton>
        <!--用户评价按钮-->
        <asp:LinkButton ID="Linkbtn_envaluation" runat="server" CssClass="Envaluation" OnClick="EnvaluatebtnClick">用户评价</asp:LinkButton>
        <!--详细介绍的版面-->
        <asp:Panel ID="Panel_Detail" runat="server" CssClass="Panel_Detail" Visible="False">
            <!--填写详细介绍的Textbox-->
            <asp:TextBox ID="TextBox_Detail" runat="server" Height="800px" Width="700px"></asp:TextBox>
        </asp:Panel>
        <!--用户评价的版面-->
        <asp:Panel ID="Panel_Evaluation" runat="server" CssClass="Panel_Evaluation">
            <!--评价的Gridview，一页五行，有分页功能，每一行上有一个填写用户名的Lable和一个填写用户评价的Lable，内容为数据绑定-->
            <asp:GridView ID="GridView1" runat="server" BackColor="White" AutoGenerateColumns="False" ShowHeader="False" CssClass="GridView1">
                <Columns>
                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:Label ID="lblUserName" runat="server" CssClass="Label_Username" Text="用户名"></asp:Label>
                            <br />
                            <asp:Label runat="server" ID="lblUserComment" CssClass="Label_Recommond" Text="评价内容"></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </asp:Panel>

    </asp:Panel>


    <!--书籍推荐版块-->
    <asp:Panel runat="server" CssClass="Panel_Recommond">
        <asp:ListView ID="ListView2" runat="server">



            <GroupTemplate>
                <tr id="itemPlaceholderContainer" runat="server">
                    <td id="itemPlaceholder" runat="server"></td>
                </tr>
            </GroupTemplate>
            <ItemTemplate>
                <td runat="server"
                    style="background-color: #FFFFFF">

                    <%--上新书籍的图片，书名及作者--%>
                    <asp:Image ID="imgBookNew0" runat="server" CssClass="imgBookNew0" />
                    <br />
                </td>
                <td runat="server"
                    style="background-color: #FFFFFF">
                    <asp:LinkButton ID="lkbNewBookName0" runat="server" CssClass="lkbBookName0" Font-Underline="false"></asp:LinkButton><br />
                    <br />
                    <%--“作者”及作者姓名展示，第二个label需绑定数据--%>
                    <asp:Label ID="lblBookNewName0" runat="server" CssClass="lblAuthorName00" Text="作者："></asp:Label>
                    <asp:Label ID="lblNewAuthorName0" runat="server" Text="" CssClass="lblAuthorName01"></asp:Label>
                    <br />
                    <br />
                    <br />
                    <%--新书籍立即购买及加入购物车按钮--%>
                         
                    &nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;<asp:Button ID="cmdNewBuyNow0" runat="server" CssClass="cmdBookOperation00" Text="立即购买" /><br />
                    &nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;<asp:Button ID="cmdNewAddShoppingCart0" runat="server" CssClass="cmdBookOperation01" Text="加入购物车" />

                </td>
            </ItemTemplate>
            <LayoutTemplate>
                <table runat="server">
                    <tr runat="server">
                        <td runat="server">
                            <table id="groupPlaceholderContainer" runat="server" border="1"
                                style="background-color: #FFFFFF; border-collapse: collapse; border-color: #999999; border-style: none; border-width: 1px; font-family: Verdana, Arial, Helvetica, sans-serif;">
                                <tr id="groupPlaceholder" runat="server">
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr runat="server" visible="false">
                        <td runat="server"
                            style="text-align: center; background-color: #5cacee; font-family: 'Microsoft YaHei'; color: #FFFFFF">
                            <asp:DataPager ID="DataPager1" runat="server" PageSize="6">
                                <Fields>
                                    <asp:TemplatePagerField>
                                        <PagerTemplate>
                                            <input type="button" id="cmdPagerApart4" runat="server" class="cmdPagerApart" />&nbsp;&nbsp;
                                            <input type="button" id="cmdPagerApart5" runat="server" class="cmdPagerApart" />

                                        </PagerTemplate>
                                    </asp:TemplatePagerField>
                                </Fields>
                            </asp:DataPager>
                        </td>
                    </tr>
                </table>
            </LayoutTemplate>
        </asp:ListView>
    </asp:Panel>


</asp:Content>

