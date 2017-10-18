using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace OnlineBookStore.App_Code
{
    public class ShoppingCart
    {
        private List<BookItem> bookitemList;
        private decimal totalcost;//购物车中图书的总价格
        private List<string> bookcategory;//用户购买图书的种类（推荐图书）
        private List<Book> recomendBooks;

        public decimal totalCost
        {
            get { return totalcost; }
        }

        public List<string> bookCategory
        {
            get { return bookcategory; }
        }

        public List<BookItem> bookItemList
        {
            get { return bookitemList; }
        }

        public ShoppingCart()
        {
            bookitemList = new List<BookItem>();
            recomendBooks = new List<Book>();
            bookcategory = new List<string>();
        }



        /// <summary>
        /// 将图书添加到购物车中
        /// </summary>
        /// <param name="toAddBookItem"></param>
        public List<BookItem> AddBookItemToShoppingCart(BookItem toAddBookItem)
        {
            //查找图书是否已经加入到购物车中
            int index = bookitemList.FindIndex(x => x.Book.bookID == toAddBookItem.Book.bookID);
            if (index != -1)//已经在购物车中
            {
                bookitemList[index].AddBookToItem();
            }
            //图书未加入购物车
            else
            {
                bookitemList.Add(toAddBookItem);
                bookcategory.Add(toAddBookItem.Book.bookCategory);
            }

            return bookitemList;
        }

        /// <summary>
        /// 将图书从购物车中删除
        /// </summary>
        /// <param name="toDeleteBookItem"></param>
        /// <returns></returns>
        public List<BookItem> DeleteBookItemFromShoppingCart(BookItem toDeleteBookItem)
        {
            //为了保证安全，还是检测一下要删除的图书是否在购物车中
            int index = bookitemList.FindIndex(x => x.Book.bookID == toDeleteBookItem.Book.bookID);
            if (index != -1)
            {
                //如果购物车中图书数量大于1，数量-1
                if (bookitemList[index].bookAmount > 1)
                {
                    bookitemList[index].DeleteBookFromItem();
                }
                //如果购物车中图书数量小于1，那么删除该bookItem
                //else
                //{
                //    bookitemList.RemoveAt(index);
                //    bookcategory.Remove(toDeleteBookItem.Book.bookCategory);
                //}  
            }
            return bookitemList;
        }

        /// <summary>
        /// 删除购物车中的某本书
        /// </summary>
        /// <param name="toDeleteBookItem"></param>
        /// <returns></returns>
        public List<BookItem> DeleteBookItemFromShoppingCart_(BookItem toDeleteBookItem)
        {
            //为了保证安全，还是检测一下要删除的图书是否在购物车中
            int index = bookitemList.FindIndex(x => x.Book.bookID == toDeleteBookItem.Book.bookID);
            if (index != -1)
            {

                bookitemList.RemoveAt(index);
                bookcategory.Remove(toDeleteBookItem.Book.bookCategory);

            }
            return bookitemList;
        }

        /// <summary>
        /// 根据用户购买购买的书籍种类，推荐书籍
        /// </summary>
        /// <returns></returns>
        public List<Book> RecommendBook()
        {
            return recomendBooks;
        }
        /// <summary>
        /// 计算购物车中所有图书的价格
        /// </summary>
        private decimal ComputeTotalCost()
        {
            foreach (var bookItem in bookitemList)
            {
                decimal bookItemCost = bookItem.ComputeBookItemCost();
                totalcost += bookItemCost;
            }
            return totalcost;

        }
    }
}