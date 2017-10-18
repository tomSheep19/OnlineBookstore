<%@ Page Language="C#" MasterPageFile="Master.Master" AutoEventWireup="true" CodeFile="SubmitOrder.aspx.cs" Inherits="SubmitOrder" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" type="text/css" href="css/SubmitOder.css" />

    <style type="text/css">
        .body{
    background-color:#FFFFFF;
    height:2400px;
}
        .auto-style1 {
            width: 1100px;
            height: 710px;
            position: absolute;
            top: 840px;
            left: 120px;
            z-index: 1;
            background-color: rgba(246, 241, 241, 0.60);
            border: 1px groove #5cacee;
            border-radius: 10px;
            
        }
    </style>

</asp:Content>
<asp:Content ID="Content2"  ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <asp:Panel ID="pnlSubmitOder" runat="server" style="height:1800px;width:100%;">
    <!--确认收货地址-->
    <%--<asp:Label ID="Label_Address" runat="server"  CssClass="Label_Address" Text="确认收货地址"></asp:Label>--%>
    <!--已购买书籍的页面-->
    <asp:Panel ID="Panel_Show" BackColor="White" runat="server"   CssClass="auto-style1" ScrollBars="Auto" Wrap="False">
        
        <asp:GridView ID="GridView1" runat="server"  Width="1080px" AutoGenerateColumns="False" AllowPaging="True" GridLines="None"  HorizontalAlign="Center" PageSize="5"  BackColor="White">
            <Columns>
                <asp:TemplateField>
                    <ItemTemplate>
                        
                        <!--绑定书籍图片-->
                        <asp:ImageButton ID="ImageButton_Pictrue" runat="server" CssClass="ImageButton_Pictrue" ImageUrl='<%# Eval("Book.bookImageURL") %>' Style="z-index: 1" />
                        
                        
                    </ItemTemplate>
                    <ItemStyle Width="180px" HorizontalAlign="Center"/>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="宝贝" HeaderStyle-HorizontalAlign="Left">
                    <ItemTemplate>
                        <!--绑定图书名字-->
                        <asp:LinkButton ID="LinkButton_Name" runat="server" CssClass="LinkButton_Name" Text='<%# Eval("Book.bookName") %>'></asp:LinkButton>
                    </ItemTemplate>
                    <ItemStyle Width="300px" HorizontalAlign="Left" Font-Bold="True" Font-Names="Microsoft YaHei UI" Font-Size="Large"/>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="单价">
                    <ItemTemplate>
                       
                        <!--绑定图书单价-->
                        <asp:Label ID="Label_SinglePrice1" runat="server" CssClass="Label_SinglePrice1" Text='<%# Eval("Book.bookPrice") %>'></asp:Label>
                    </ItemTemplate>
                    <ItemStyle Width="150px" HorizontalAlign="Center" Font-Names="Microsoft YaHei UI" Font-Size="Medium"/>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="数量">
                    <ItemTemplate>
                        
                        <asp:TextBox ID="TextBox_SingleAmount" runat="server" Text='<%# Eval("bookAmount") %>' ReadOnly="True" CssClass="TextBox_SingleAmount" style="width:60px;height:30px;text-align:center;"></asp:TextBox>
                    </ItemTemplate>
                    <ItemStyle Width="150px" HorizontalAlign="Center" Font-Names="Microsoft YaHei UI" Font-Size="Medium"/>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="折扣">
                    <ItemTemplate>
                        
                        <!--绑定折扣-->
                        <asp:DropDownList ID="DropDownList_Discount" runat="server" CssClass="DropDownList_Discount" style="width:60px;height:30px;text-align:center;"></asp:DropDownList>
                    </ItemTemplate>
                    <ItemStyle Width="120px" HorizontalAlign="Center" Font-Names="Microsoft YaHei UI" Font-Size="Medium" />
                </asp:TemplateField>


                <asp:TemplateField HeaderText="小结">
                    <ItemTemplate>
                        
                        <!--绑定小结价格-->
                        <%--待拓展--%>
                        <asp:Label ID="Label_BriefSummary1" runat="server" Text="Label" CssClass="Label_BriefSummary1"></asp:Label>
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" Font-Names="Microsoft YaHei UI" Font-Size="Medium" />
                </asp:TemplateField>
            </Columns>
            <HeaderStyle Font-Names="Microsoft YaHei UI" Font-Size="X-Large" Height="50px" HorizontalAlign="Center" />
            <PagerStyle Height="20px" HorizontalAlign="Right" />
            <RowStyle Height="100px" />
        </asp:GridView>
            </asp:Panel>
        <asp:Label ID="Label_RealMoney" runat="server" CssClass="Label_RealMoney" Text="实付款"></asp:Label>
        <!--绑定实付款价格-->
        <asp:Label ID="Label_Money" runat="server" CssClass="Label_Money"></asp:Label>
    


<asp:Panel ID="Panel_UserMessage" runat="server" CssClass="Panel_UserMessage">
        <table align="left" class="Table">
            <tr>
                <td class="Td">所在地区</td>
                <!--所在省-->
                <td>省
                <asp:TextBox ID="TextBox_Province" runat="server" Width="88px"></asp:TextBox>
                    <!--所在市-->
                    市
                <asp:TextBox ID="Textbox_City" runat="server" Width="68px"></asp:TextBox>
                    <!--所在区-->
                    区
                <asp:TextBox ID="Textbox_Area" runat="server"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <!--用户详细地址-->
                <td class="Td">详细地址</td>
                <td>
                    <asp:TextBox ID="TextBox_Address" runat="server" Height="51px" Width="447px"></asp:TextBox></td>
            </tr>
            <tr>
                <!--邮编-->
                <td class="Td">邮编</td>
                <td>
                    <asp:TextBox ID="TextBox_Postcode" runat="server"></asp:TextBox></td>
            </tr>
            <tr>
                <!--收货人姓名-->
                <td class="Td">收货人姓名</td>
                <td>
                    <asp:TextBox ID="TextBox_Name" runat="server"></asp:TextBox></td>
            </tr>
            <tr>
                <!--收货人手机号-->
                <td class="Td">手机号</td>
                <td>
                    <asp:TextBox ID="TextBox_Phonenumber" runat="server"></asp:TextBox>

                </td>
            </tr>
        </table>
        <!--提交订单按钮-->
        <asp:Button ID="Button_Back" runat="server" CssClass="Button_SaveMessage" Text="返回" style="left:500px;" OnClick="Button_Back_Click" />
        <asp:Button ID="Button_SaveMessage" runat="server" OnClick="Button_SaveMessage_Click" CssClass="Button_SaveMessage" Text="提交订单" />
    </asp:Panel>
        </asp:Panel>
</asp:Content>