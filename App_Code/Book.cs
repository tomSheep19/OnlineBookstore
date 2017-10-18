namespace OnlineBookStore.App_Code
{
    public class Book
    {
        protected string bookid;
        protected string bookname;
        protected decimal bookprice;
        protected string bookcategory; 
        private string bookauthor;
        private string bookpress;
        private string bookdetail;
        private string bookimageurl;
        private int rating;
        private int inventory;
        private string shelvedate;

#region
        public string bookID
        {
            set { bookid = value; }
            get { return bookid; }
        }

        public string bookName
        {
            set { bookname = value; }
            get { return bookname; }
        }

        public string bookAuthor
        {
            set { bookauthor = value; }
            get { return bookauthor; }
        }
        public decimal bookPrice
        {
            set { bookprice = value; }
            get { return bookprice; }
        }

        public string bookPress
        {
            set { bookpress = value; }
            get { return bookpress; }
        }
        public string bookDetail
        {
            set { bookdetail = value; }
            get { return bookdetail; }
        }


        public string bookCategory
        {
            set { bookcategory = value; }
            get { return bookcategory; }
        }

        public string bookImageURL
        {
            set { bookimageurl = value; }
            get { return bookimageurl; }
        }

        public int Rating
        {
            set { rating = value; }
            get { return rating; }
        }

        public int Inventory
        {
            set { inventory = value;}
            get { return inventory;}
        }

        public string shelveDate
        {
            get { return shelvedate;}
        }
#endregion

        public Book()
        {
            
        }

        /// <summary>
        /// 向数据库中添加书籍的时候，将shelvedate指定为null
        /// 从数据库中读取书籍的时候，将shelvedate指定为数据库中的时间
        /// </summary>
        /// <param name="bookId"></param>
        /// <param name="bookName"></param>
        /// <param name="bookAuthor"></param>
        /// <param name="bookPrice"></param>
        /// <param name="bookPress"></param>
        /// <param name="bookDetail"></param>
        /// <param name="bookCategory"></param>
        /// <param name="bookImageURL"></param>
        /// <param name="inventory"></param>
        /// <param name="rating"></param>
        /// <param name="shelvedate"></param>
        public Book(string bookId,string bookName,string bookAuthor,decimal bookPrice,string bookPress,string bookDetail,string bookCategory,string bookImageURL,int inventory,int rating,string shelvedate)
        {
            bookid = bookId;
            bookname = bookName;
            bookauthor = bookAuthor;
            bookprice = bookPrice;
            bookpress = bookPress;
            bookdetail = bookDetail;
            bookcategory = bookCategory;
            bookimageurl = bookImageURL;
            this.inventory = inventory;
            this.rating = rating;
            this.shelvedate = shelvedate;

        }


    }
}