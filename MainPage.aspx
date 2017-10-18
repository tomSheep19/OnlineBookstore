<%@ Page Language="C#" MasterPageFile="Master.Master" AutoEventWireup="true" CodeFile="MainPage.aspx.cs" Inherits="Main" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        /*中间轮转书籍的CSS*/
        #owl-demo {
            position: absolute;
            top: 60px;
            left: 210px;
            width: 750px;
            height: 500px;
            margin: 20px auto 0 auto;
        }

            #owl-demo .item {
                position: relative;
                display: block;
            }

            #owl-demo img {
                display: block;
                width: 750px;
                height: 500px;
            }

            #owl-demo b {
                position: absolute;
                left: 0;
                bottom: 0;
                width: 100%;
                height: 100px;
                background-color: #000;
                opacity: .5;
                filter: alpha(opacity=50);
            }

            #owl-demo span {
                position: absolute;
                left: 0;
                bottom: 37px;
                width: 100%;
                font: 24px/40px "微软雅黑","黑体";
                color: #fff;
                text-align: center;
            }

        .owl-pagination {
            position: absolute;
            left: 0;
            bottom: 10px;
            width: 100%;
            height: 22px;
            text-align: center;
        }

        .owl-page {
            display: inline-block;
            width: 10px;
            height: 10px;
            margin: 0 5px;
            background-image: url(images/bg15.png);
            *display: inline;
            *zoom: 1;
        }

        .owl-pagination .active {
            width: 25px;
            background-image: url(images/bg16.png);
        }

        .owl-buttons {
            display: none;
        }

            .owl-buttons div {
                position: absolute;
                top: 50%;
                width: 40px;
                height: 80px;
                margin-top: -40px;
                text-indent: -9999px;
            }

        .owl-prev {
            left: 0;
            background-image: url(/Picture/bg17.png);
        }

        .owl-next {
            right: 0;
            background-image: url(/Picture/bg18.png);
        }

        .owl-prev:hover {
            background-image: url(/Picture/bg19.png);
        }

        .owl-next:hover {
            background-image: url(/Picture/bg20.png);
        }

        .auto-style55 {
            position: absolute;
            top: 200px;
            width: 1141px;
        }
    </style>

    <link rel="stylesheet" href="css/owl.carousel.css" />

    <%--主页CSS--%>
    <link rel="stylesheet" href="css/MainUpdate.css" />

    <script type="text/javascript" src="js/jquery-1.8.3.min.js"></script>
    <script type="text/javascript" src="js/owl.carousel.js"></script>
    <script type="text/javascript">
        $(function () {
            $('#owl-demo').owlCarousel({
                items: 1,
                navigation: true,
                navigationText: ["上一个", "下一个"],
                autoPlay: true,
                stopOnHover: true
            }).hover(function () {
                $('.owl-buttons').show();
            }, function () {
                $('.owl-buttons').hide();
            });
        });
    </script>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <table class="auto-style55" runat="server">
        <tr>
            <td><%--分类的面板--%>
                <asp:Panel ID="Category" runat="server" CssClass="PCategory">
                    <%--六个分类的linkbutton--%>
                    <asp:LinkButton ID="lbEducation" CommandName="Education" CommandArgument="Education" runat="server" OnCommand="Category_OnClick" CssClass="CateButton">教育</asp:LinkButton>
                    <asp:LinkButton ID="lbArt" runat="server" CommandName="Art" CommandArgument="Literature" OnCommand="Category_OnClick" CssClass="CateButton">文艺</asp:LinkButton>
                    <asp:LinkButton ID="lbScience" runat="server" CommandName="Science" CommandArgument="Science"  OnCommand="Category_OnClick" CssClass="CateButton" >科技</asp:LinkButton>
                    <asp:LinkButton ID="lbLife" runat="server" CommandName="Life" CommandArgument="Life"  OnCommand="Category_OnClick" CssClass="CateButton">生活</asp:LinkButton>
                    <asp:LinkButton ID="lbHumanity" runat="server" CommandName="Humantity" CommandArgument="Humanity" OnCommand="Category_OnClick" CssClass="CateButton">人文社科</asp:LinkButton>
                    <asp:LinkButton ID="lbJuvenile" runat="server" CommandName="Children" CommandArgument="Children" OnCommand="Category_OnClick" CssClass="CateButton">少儿读物</asp:LinkButton>
                </asp:Panel>

            </td>
            <td>
               <%--中间轮转书籍界面，需要改链接地址，链接至书籍详情--%>
                <div id="owl-demo" class="owl-carousel">
                    <a class="item" href="BookDetail.aspx" target="_blank">
                        <img src="Picture/1边城.jpg" alt="" /><span>边城：这个人也许永远不回来了，也许”明天“回来!</span></a>
                    <a class="item" href="BookDetail.aspx" target="_blank">
                        <img src="Picture/2曾国藩家书.jpg" alt="" /><span>曾国藩家书：士人读书，第一要有志，第二要有识，第三要有恒</span></a>
                    <a class="item" href="BookDetail.aspx" target="_blank">
                        <img src="Picture/3航海日记.jpg" alt="" /><span>航海日记：能够生存下来的，是最能够适应变化的物种</span></a>
                    &nbsp;&nbsp;&nbsp;
	                <a class="item" href="BookDetail.aspx" target="_blank">
                        <img src="Picture/4教父.jpg" alt="" /><span>教父：不要憎恨你的敌人,那会影响你的判断力</span></a>
                    <a class="item" href="BookDetail.aspx" target="_blank">
                        <img src="Picture/5木偶奇遇记.jpg" alt="" /><span>木偶奇遇记：好孩子守则第一条：永远诚实</span></a>
                    <a class="item" href="BookDetail.aspx" target="_blank">
                        <img src="Picture/6全球通史.jpg" alt="" /><span>全球通史：用全球的视野来阐释历史</span></a>
                    <a class="item" href="BookDetail.aspx" target="_blank">
                        <img src="Picture/7小王子.jpg" alt="" /><span>小王子：所有的大人曾经都是小孩，然而只有少数人记得</span></a>
                </div>
                <%--书籍上新面板--%>
                <asp:Panel ID="pnlBookNew" runat="server" CssClass="pnlBookNew" >
                    <%-- 书籍上新标题--%>
                    <asp:Label ID="lblBookNew" runat="server"   CssClass="lblBookNew" Text="给力上新"></asp:Label><br />
                    <br />
                    <br />
                    <br />
                    <br />
                    <asp:ListView ID="ListView_NewBook" OnItemCommand="ListView_OnItemCommand" runat="server" OnSelectedIndexChanged="ListView_NewBook_SelectedIndexChanged">

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
                                <asp:Image ID="imgBookNew" ImageUrl='<%# Eval("bookImageURL") %>' runat="server" CssClass="imgBookNew0" />
                                <br />
                                    </asp:Panel>
                            </td>
                            <td runat="server"
                                style="background-color: #FFFFFF">
                                  <asp:Panel ID="pnlBookNewLkbName" runat="server" CssClass="pnlBookNewLkbName" style="width:230px;">
                                &nbsp;<asp:LinkButton ID="lkbNewBookName0" runat="server" CssClass="lkbBookName0" Font-Underline="false" style="width:225px;"></asp:LinkButton><br />
                                </asp:Panel>
                                     &nbsp;<asp:Label ID="lblBookPrice0" runat="server" CssClass="lblBookPrice" Text="¥"></asp:Label>&nbsp;<asp:Label ID="lblBookPriceIn"  runat="server" CssClass="lblBookPrice" Text=""></asp:Label><br/>
                                <br />
                                <%--“作者”及作者姓名展示，第二个label需绑定数据--%>
                    <%--&nbsp;<asp:Label ID="lblBookNewName" runat="server"  Text='<%# Eval("bookName") %>'  CssClass="lblAuthorName00"></asp:Label>--%>
                                &nbsp;<asp:Label ID="lblNewAuthorName" runat="server" Text='<%# Eval("bookAuthor") %>' CssClass="lblAuthorName01"></asp:Label>
                                <br />
                                <br />
                                <br />
                                <%--新书籍立即购买及加入购物车按钮--%>
                         <asp:Panel ID="pnlBookOperation0" runat="server" CssClass="pnlBookOperation0">
                          &nbsp; &nbsp; &nbsp; &nbsp;&nbsp; &nbsp;<asp:Button ID="cmdNewBuyNow" CommandName="NewBuyNow" CommandArgument='<%# Eval("BookID") %>' runat="server" CssClass="cmdBookOperation00" Text="立即购买" />
                                <br />
                             <br />
                                &nbsp; &nbsp; &nbsp; &nbsp;&nbsp; &nbsp;<asp:Button ID="cmdNewAddShoppingCart" CommandName="NewAddBookToShoppingCart" CommandArgument='<%# Eval("BookID") %>' runat="server" CssClass="cmdBookOperation01" Text="加入购物车" /></asp:Panel>

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
                                <tr runat="server">
                                    <td runat="server"
                                        style="text-align: center; background-color: #5D7B9D; font-family: Verdana, Arial, Helvetica, sans-serif; color: #FFFFFF">
                                        <asp:DataPager ID="DataPager1" runat="server" PageSize="8">
                                            <Fields>
                                                <asp:NextPreviousPagerField ButtonType="Button" ShowFirstPageButton="True"
                                                    ShowLastPageButton="True" />
                                            </Fields>
                                        </asp:DataPager>
                                    </td>
                                </tr>
                            </table>
                        </LayoutTemplate>
                    </asp:ListView>

                </asp:Panel>
            </td>
        </tr>
        <tr>
            <%--推荐书籍标题--%>
            <td>
                <asp:Label ID="lblBookRecommend" runat="server" CssClass="lblBookRecommend" Text="推荐书籍"></asp:Label>
                <%--推荐书籍总面板--<%--%>分面板及书籍图片、书名、作者姓名均按从左到右，从上到下的顺序从0编号--%>
                <asp:Panel ID="pnlBookRecommend" runat="server" CssClass="pnlBookRecommend">
                    <asp:ListView ID="ListView_Recommend" runat="server" OnItemCommand="ListView_OnItemCommand"
                        GroupItemCount="4">
                        <GroupTemplate>
                            <tr id="itemPlaceholderContainer" runat="server">
                                <td id="itemPlaceholder" runat="server"></td>
                            </tr>
                        </GroupTemplate>
                       <ItemTemplate>
                            <td runat="server" class="style1"
                                style="background-color: #FFFFFF; color: #284775;">
                                <asp:Panel ID="pnlBookR0" runat="server" CssClass="pnlBookR" Height="435px">
                                    <asp:Panel ID="pnlBookRImg" runat="server" CssClass="pnlBookRImg">
                                    <asp:ImageButton ID="icmdBookRecommend" ImageUrl='<%# Eval("bookImageURL") %>' runat="server" CssClass="imgBookR" />
                                    <br />
 </asp:Panel>
                                     <asp:Panel ID="pnlBookRLkbName" runat="server" CssClass="tdlkbBookName">
                                    &nbsp;<asp:LinkButton ID="lkbBookName" CommandName="BookDetail" CommandArgument='<%# Eval("bookID") %>' Text='<%# Eval("bookName") %>' runat="server" CssClass="lkbBookName"></asp:LinkButton>
                                    <br />
                                         </asp:Panel><br/>
                                    <asp:Panel ID="pnlBookPrice" runat="server" style="height:50px;width:225px;">
                                     &nbsp; &nbsp;<asp:Label ID="lblBookPrice" runat="server" CssClass="lblBookPrice" Text="¥"></asp:Label>&nbsp;<asp:Label ID="lblBookPriceIn"  runat="server" CssClass="lblBookPrice" Text=""></asp:Label><br/>
                                    &nbsp;<asp:Label ID="lblAuthorName" Text='<%# Eval("bookAuthor") %>' runat="server" CssClass="lblAuthorName"></asp:Label>
                                    </asp:Panel>
                                     <asp:Panel ID="pnlBookOperation" runat="server" CssClass="tdcmdBookOperation">
                                    &nbsp;<asp:Button ID="cmdBuyNow" CommandName="BuyNow" CommandArgument='<%# Eval("BookID") %>' runat="server" CssClass="cmdBookOperation" Text="立即购买" />
                                    &nbsp;<asp:Button ID="cmdAddShoppingCart" CommandName="AddBookToShoppingCart" CommandArgument='<%# Eval("BookID") %>' runat="server" CssClass="cmdBookOperation" Text="加入购物车" /></asp:Panel>
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
                                        <asp:DataPager ID="DataPager1" runat="server" PageSize="12">
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
            </td>
        </tr>
    </table>
</asp:Content>

