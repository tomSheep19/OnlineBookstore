using System;
using System.Collections.Generic;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Linq;
using System.Net.Sockets;
using System.Security.AccessControl;
using System.Web;

namespace OnlineBookStore.App_Code
{
    public class Order
    {
        private string orderid;
        private string username;
        private ShippingAddress shippingaddress;//收货地址
        private decimal price;//订单总价
        string  orderdate; //订单生成时间
        private List<BookItem> bookitemlist;//用户购买的图书
        private int isvalid;//订单状态 0：有效 1：无效

#region
        public string orderId
        {
            get { return orderid; }
        }

        public string userName
        {
            get { return username; }
        }

        public ShippingAddress shippingAddress
        {
            get { return shippingaddress; }
        }
        
        public decimal Price
        {
            get { return price; }
        }

        public string orderDate
        {
            get { return orderdate; }
        }

        public List<BookItem> bookItemList
        {
            get { return bookitemlist; }
            set { bookitemlist = value; }
        }

        public int isValid
        {
            get { return isvalid; }
        }

#endregion

        public Order()
        {
            bookitemlist = new List<BookItem>();
        }

        public void SetOrderInformation(string orderId, string userName, decimal Price, int Valid, string orderDate,
            ShippingAddress shippingAddress)
        {
            orderid = orderId;
            username = userName;
            price = Price;
            isvalid = Valid;
            orderdate = orderDate;
            shippingaddress = shippingAddress;
        }


        /// <summary>
        /// 构造方法
        /// </summary>
        /// <param name="username"></param>
        /// <param name="shippingaddress"></param>
        /// <param name="remark"></param>
        /// <param name="price"></param>
        /// <param name="orderdate"></param>
        /// <param name="bookitemlist"></param>
        public Order(string username, ShippingAddress shippingaddress, DateTime orderdate, List<BookItem> bookitemlist)
        {
            orderid = CreateOrderID(username);//订单号
            this.username = username;//用户名
            this.shippingaddress = shippingaddress;//收货地址 
            price = ComputeOrderPrice(bookitemlist);//图书价格
            this.orderdate = orderdate.Year+"-"+orderdate.Month+"-"+orderdate.Day;//订单时间
            this.bookitemlist = bookitemlist;//订单图书
            isvalid = 0;//订单状态

        }

        /// <summary>
        /// 生成订单号
        /// </summary>
        /// <param name="username">用户名</param>
        /// <returns></returns>
        private string CreateOrderID(string username)
        {

            DateTime time = DateTime.Now;
            string year = time.Year.ToString();
            string month = time.Month.ToString();
            string day = time.Day.ToString();
            string hour = time.Hour.ToString();
            string minute = time.Minute.ToString();
            string orderid = username + year + month + day + hour + minute;

            return orderid;

        }

        /// <summary>
        /// 计算订单中图书的总价格
        /// </summary>
        /// <param name="bookItems"></param>
        /// <returns></returns>
        private decimal ComputeOrderPrice(List<BookItem> bookItems)
        {
            decimal price=0;
            if (bookItems != null)
            {
                foreach (var bookItem in bookItems)
                {
                    price += bookItem.ComputeBookItemCost();
                }
            }
            
            return price;
        }
        /// <summary>
        /// 查询订单信息
        /// </summary>
        /// <param name="queryConditons"></param>
        /// <returns></returns>
        public List<Order> QueryOrder(string queryConditons)
        {
            List<Order> resultQueryOrder=new List<Order>();
            return resultQueryOrder;
        }
    }
}