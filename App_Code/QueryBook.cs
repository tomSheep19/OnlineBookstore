using System;
using System.Text;

namespace OnlineBookStore.App_Code
{
    //书名 书号 作者 种类
    //bookID:xx bookName:xx Author:xx Press:xx Category:xx Price:xx
    public class QueryBook
    {
        
        public static string  SqlCmdText(string queryConditionStrings)
        {
            Book queryBook = new Book();//用户查询的书籍
            var queryConditonsUnitString=SplitQueryConditionString(queryConditionStrings);//分割书籍查询条件
            int length = queryConditonsUnitString.Length / 2;//获取查询条件的个数
            //按照查询条件（0:condition 1:value）构造查询书籍
            for(int i1=0;i1<length;i1++){
                Protocols(queryConditonsUnitString[i1,0], queryConditonsUnitString[i1,1],queryBook);//组装查询书籍
            }

            StringBuilder sb = new StringBuilder(); 
            sb.Append("select * from Book where");

            int i2 = 1;
            if (queryBook.bookID !=null)
            {
                sb.Append(" BookID='" + queryBook.bookID + "'" + AddAndOrNot(i2, length));
                i2++;
            }
            if (queryBook.bookName !=null)
            {
                sb.Append(" BookName='" + queryBook.bookName + "'" + AddAndOrNot(i2, length));
                i2++;
            }

            if (queryBook.bookAuthor !=null)
            {
                sb.Append(" BookAuthor='" + queryBook.bookAuthor + "'" + AddAndOrNot(i2, length));
                i2++;
            }

            if (queryBook.bookPress !=null)
            {
                sb.Append(" BookPress='" + queryBook.bookPress + "'" + AddAndOrNot(i2, length));
                i2++;
            }

            if (queryBook.bookCategory !=null)
            {
                sb.Append(" BookCategory='" + queryBook.bookCategory + "'" + AddAndOrNot(i2, length));
                i2++;
            }

            if (queryBook.bookPrice != 0)
            {
                sb.Append(" BookPrice='" + queryBook.bookPrice + "'" + AddAndOrNot(i2, length));
                i2++;
            }
            return sb.ToString();

        }

        /// <summary>
        /// Sql查询语句后面是否追加"and"
        /// 即判断查询条件是否为最后一个
        /// </summary>
        /// <param name="i"></param>
        /// <param name="length"></param>
        /// <returns></returns>
        private static string AddAndOrNot(int i, int length)
        {
            if (i <length)
                return " and";
            return "";

        }

        /// <summary>
        /// 拆分搜索条件
        /// </summary>
        /// <param name="queryConditonStrings">搜索条件字符串 格式 bookName:xx Author:xx Press:xx Category:xx Price:xx</param>
        /// <returns>搜索条件二维数组
        ///          格式：0:bookName 1:value
        /// </returns>
        private static string [,] SplitQueryConditionString(string queryConditonStrings)
        {
            var queryConditonPartString = queryConditonStrings.Split(' '); //按照空格将搜索条件划分
            var queryConditonsUnitString = new string[queryConditonPartString.Length, 2]; //二维数组 条件名：条件值
            int i = 0;
            foreach (var unitString in queryConditonPartString)
            {
                var tempQueryConditionString = unitString.Split(':'); //将 条件名：条件值再次划分
                queryConditonsUnitString[i, 0] = tempQueryConditionString[0];
                queryConditonsUnitString[i, 1] = tempQueryConditionString[1];
                i++;
            }
            return queryConditonsUnitString;
        }

        /// <summary>
        /// 根据 查询条件:value构造查询的书籍
        /// </summary>
        /// <param name="condition">查询条件</param>
        /// <param name="value">条件值</param>
        private static void Protocols(string condition, string value, Book queryBook)
        {
            switch (condition)
            {
                case "bookID"://书号
                    queryBook.bookID = value;
                    break;
                case "bookName"://书名
                    queryBook.bookName = value;
                    break;
                case "bookAuthor"://作者
                    queryBook.bookAuthor = value;
                    break;
                case "bookPress"://出版社
                    queryBook.bookPress = value;
                    break;
                case "bookCategory"://种类
                    queryBook.bookCategory = value;
                    break;
                case "bookPrice"://价格
                    queryBook.bookPrice = Convert.ToDecimal(value);
                    break;
            }
        }
    }
}