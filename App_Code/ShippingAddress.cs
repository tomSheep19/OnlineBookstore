using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace OnlineBookStore.App_Code
{
    public class ShippingAddress
    {
        //收货地址格式：
        //收货人姓名-收货地址-邮编-联系方式
        private string address;
        private string remark;

        public string Address
        {
            get { return address; }
        }

        public string Remark
        {
            get { return remark; }
        }

        /// <summary>
        /// 带参构造方法
        /// </summary>
        /// <param name="address"></param>
        /// <param name="remark"></param>
        public ShippingAddress(string address, string remark)
        {
            this.address = address;
            this.remark = remark;
        }
        /// <summary>
        /// 带参构造方法
        /// </summary>
        /// <param name="name">收货人姓名</param>
        /// <param name="address">收货人地址</param>
        /// <param name="postcode">邮编</param>
        /// <param name="phonenum">收货人联系方式</param>
        public ShippingAddress(string name, string address, string postcode, string phonenum,string remark)
        {
            this.address = name + "-" + address + "-" + postcode + "-" + phonenum;
            this.remark = remark;
        }


    }
}