<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="Master.Master" CodeFile="BookShow.aspx.cs" Inherits="BookShow" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel='stylesheet' type='text/css' href="css/Category.css"/>
    <link rel='stylesheet' type='text/css' href="css/BookShow.css"/>
    <link rel="stylesheet" type="text/css" href="css/Main.css" />
    <style  type="text/css">
        body{
            height:1900px;
        }
        .pnlBookR{
    width:216px;
    height:405px;
}
        .imgBookR,.imgBookR:visited{
    width:196px;
    height:280px;
    margin-left:10px;
    margin-right:10px;
    margin-top:10px;
    margin-bottom:10px;
}
.imgBookR:hover{
    width:210px;
    height:300px;
    margin:0px 3px 0px 3px;
    transition:all .5s;
    -webkit-transition:all .5s;
    -moz-transition:all .5s;
    -o-transition:all .5s;
}
.pnlBookNewImg{
    height:213px;
    width:167px;
}
.PCategory{
    position:absolute;
    top:280px;
    left:5px;
    width:215px;
    height:560px;
}
.pnlBookRImg{
    width:216px;
    height:300px;
}
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <!--左侧分类栏-->
    <!--点击分类，显示对应分类书籍-->
    <asp:Panel ID="P_Category" runat="server" CssClass="PCategory">

        <asp:LinkButton ID="lbEducation" CommandName="Education" CommandArgument="Education" runat="server" OnCommand="Category_OnClick" CssClass="CateButton">教育</asp:LinkButton>
                    <asp:LinkButton ID="lbArt" runat="server" CommandName="Art" CommandArgument="Literature" OnCommand="Category_OnClick" CssClass="CateButton">文艺</asp:LinkButton>
                    <asp:LinkButton ID="lbScience" runat="server" CommandName="Science" CommandArgument="Science"  OnCommand="Category_OnClick" CssClass="CateButton" >科技</asp:LinkButton>
                    <asp:LinkButton ID="lbLife" runat="server" CommandName="Life" CommandArgument="Life"  OnCommand="Category_OnClick" CssClass="CateButton">生活</asp:LinkButton>
                    <asp:LinkButton ID="lbHumanity" runat="server" CommandName="Humantity" CommandArgument="Humanity" OnCommand="Category_OnClick" CssClass="CateButton">人文社科</asp:LinkButton>
                    <asp:LinkButton ID="lbJuvenile" runat="server" CommandName="Children" CommandArgument="Children" OnCommand="Category_OnClick" CssClass="CateButton">少儿读物</asp:LinkButton>
    </asp:Panel>

    <!--左侧广告位-->
    <asp:ImageButton ID="ImgAd" runat="server" CssClass="Advertice" AlternateText="广告位招租" />

    <!--书籍展示-->
    <asp:Panel ID="P_BookShow" runat="server" CssClass="P_BookShow">
        <!--显示当前位置：分类与具体条件-->
        当前&gt;<asp:Label ID="lblNowCategory" runat="server" Text="[当前分类]"></asp:Label>
        &gt;<asp:Label ID="lblNowCon" runat="server" Text="[当前条件]"></asp:Label><br />

        <!--书籍展示控件-->

        <asp:ListView ID="ListView1" OnItemCommand="ListView1_OnItemCommand" runat="server" 
            GroupItemCount="4">
            <GroupTemplate>
                <tr id="itemPlaceholderContainer" runat="server">
                    <td id="itemPlaceholder" runat="server"></td>
                </tr>
            </GroupTemplate>
            <ItemTemplate>
                <td runat="server" class="style1"
                    style="background-color: #FFFFFF; color: #284775;">
                    <asp:Panel ID="pnlBookR" runat="server" CssClass="pnlBookR">
                        <asp:Panel ID="pnlBookRImg" runat="server" CssClass="pnlBookRImg">
                        <asp:ImageButton ID="icmdBookRecommend" ImageUrl='<%# Eval("bookImageURL") %>' runat="server" CssClass="imgBookR" />
                                    <br /></asp:Panel>
                        <asp:Panel ID="pnlBookRLkbName" runat="server" CssClass="tdlkbBookName">
                                    &nbsp;&nbsp;<asp:LinkButton ID="lkbBookName" Text='<%# Eval("bookName") %>' runat="server" CssClass="lkbBookName"></asp:LinkButton>
                                    <br /></asp:Panel>
                                    &nbsp; &nbsp;<asp:Label ID="lblBookPrice" runat="server" CssClass="lblBookPrice" Text="¥"></asp:Label>&nbsp;<asp:Label ID="lblBookPriceIn"  runat="server" CssClass="lblBookPrice" Text=""></asp:Label><br/>
                                    &nbsp;&nbsp;<asp:Label ID="lblAuthor" Text="作者" runat="server" CssClass="lblAuthorName"></asp:Label>

                                    <asp:Label ID="lblAuthorName" Text='<%# Eval("bookAuthor") %>' runat="server" CssClass="lblAuthorName"></asp:Label>
                                    <br />
                        <br />
                        <asp:Panel ID="pnlBookOperation" runat="server" CssClass="tdcmdBookOperation">
                                    &nbsp;&nbsp;<asp:Button ID="cmdBuyNow" CommandName="BuyNow" CommandArgument='<%# Eval("BookID") %>' runat="server" CssClass="cmdBookOperation" Text="立即购买" />
                                    &nbsp;&nbsp;<asp:Button ID="cmdAddShoppingCart" CommandName="AddBookToShoppingCart" CommandArgument='<%# Eval("BookID") %>' runat="server" CssClass="cmdBookOperation" Text="加入购物车" /></asp:Panel>
                    </asp:Panel>
                </td>
            </ItemTemplate>
            <LayoutTemplate>
                <table runat="server">
                    <tr runat="server">
                        <td runat="server">
                            <table id="groupPlaceholderContainer" runat="server" border="1"
                                style="background-color: #FFFFFF; border-collapse: collapse; border-color: #999999; border-style: none; border-width: 1px; font-family: 'Microsoft YaHei'">
                                <tr id="groupPlaceholder" runat="server">
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr runat="server">
                        <td runat="server"
                            style="text-align: center; background-color: #5CACEE; font-family: 'Microsoft YaHei'; color: #FFFFFF; border-radius: 5px;">
                            <asp:DataPager ID="DataPager1" runat="server" PageSize="16">
                                <Fields>
                                    <%--<asp:NextPreviousPagerField ButtonType="Button" ShowFirstPageButton="True" 
                                        ShowLastPageButton="True" />--%>
                                    <asp:TemplatePagerField>
                                        <PagerTemplate>
                                            <input type="button" id="cmdPagerApart0" runat="server" class="cmdPagerApart" />&nbsp;&nbsp;&nbsp;
                                            <input type="button" id="cmdPagerApart1" runat="server" class="cmdPagerApart" />&nbsp;&nbsp;&nbsp;
                                            <input type="button" id="cmdPagerApart2" runat="server" class="cmdPagerApart" />&nbsp;&nbsp;&nbsp;
                                            <input type="button" id="cmdPagerApart3" runat="server" class="cmdPagerApart" />
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


    <!--右侧推荐-->
    <asp:Panel ID="P_Recommend" runat="server" CssClass="P_Recommend">

        <asp:Image ID="ImgRecommend" runat="server" Height="30px" Width="100px" CssClass="ImgRecommend" />
        <asp:ListView ID="ListView2" runat="server" >


            <GroupTemplate>
                <tr id="itemPlaceholderContainer" runat="server">
                    <td id="itemPlaceholder" runat="server"></td>
                </tr>
            </GroupTemplate>

             <ItemTemplate>
                <td runat="server"
                    style="background-color: #FFFFFF">

                    <%--上新书籍的图片，书名及作者--%>
                    <asp:Panel ID="pnlBookNewImg" runat="server" CssClass="pnlBookNewImg">
                    <asp:Image ID="imgBookNew0" runat="server" CssClass="imgBookNew0" /></asp:Panel>
                    <br />
                </td>
                <td runat="server"
                    style="background-color: #FFFFFF">
                    <asp:Panel ID="pnlBookNewLkbName" runat="server" CssClass="pnlBookNewLkbName">
                    <asp:LinkButton ID="lkbNewBookName0" runat="server" CssClass="lkbBookName0" Font-Underline="false"></asp:LinkButton><br />
                    <br /></asp:Panel>
                    &nbsp;<asp:Label ID="lblBookPrice0" runat="server" CssClass="lblBookPrice0" Text="¥"></asp:Label>&nbsp;<asp:Label ID="lblBookPriceIn0" runat="server" CssClass="lblBookPrice0" Text=""></asp:Label>    
                                <br />
                    <%--“作者”及作者姓名展示，第二个label需绑定数据--%>
                    <asp:Label ID="lblBookNewName0" runat="server" CssClass="lblAuthorName00" Text="作者："></asp:Label>
                    <asp:Label ID="lblNewAuthorName0" runat="server" Text="" CssClass="lblAuthorName01"></asp:Label>
                    <br />
                    <br />
           
                    <%--新书籍立即购买及加入购物车按钮--%>
                          <asp:Panel ID="pnlBookOperation0" runat="server" CssClass="pnlBookOperation0">
                    &nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;<asp:Button ID="cmdNewBuyNow0" runat="server" CssClass="cmdBookOperation00" Text="立即购买" /><br />
                    <br />
                       <br />
                    &nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;<asp:Button ID="cmdNewAddShoppingCart0" runat="server" CssClass="cmdBookOperation01" Text="加入购物车" />
                    </asp:Panel>
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
                            <asp:DataPager ID="DataPager1" runat="server" PageSize="7">
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
