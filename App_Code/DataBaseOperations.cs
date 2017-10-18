using System;
using System.Data;
using System.Data.SqlClient;
using System.Diagnostics;

namespace OnlineBookStore.App_Code
{
    public class DataBaseOperations
    {

        /// <summary>
        /// 建立与数据库连接
        /// </summary>
        /// <returns>connection处于未打开状态</returns>
        public static SqlConnection CreateConnection()
        {
            //云服务链接字符
            //string ConnectionString = "Server=211.87.230.77;Database=OnlineBookStore;User ID=sa;Password=123123123;Connection Timeout=30;";

            //本地数据库连接字符
            const string ConnectionString = "Server=ZHIHAO;Database=OnlineBookStore;Trusted_Connection=True;";//数据库实例-数据配置字符

            SqlConnection connection = new SqlConnection(ConnectionString);//建立与数据的连接
            return connection;
        }

        /// <summary>
        /// 执行查询语句(SqlDataReader)
        /// 调用前connection需要处于Open状态
        /// 调用得到SqlDataReader，使用后需要将connection关闭
        /// </summary>
        /// <param name="cmdText"></param>
        /// <param name="connection"></param>
        /// <returns>SqlDataReader</returns>

        public static SqlDataReader GetSqlDataReader(string cmdText, SqlConnection connection)
        {
            //判断调用本方法前，连接对象connection是否已经打开
            if (connection.State == ConnectionState.Closed)
            {
                connection.Open();//自动为其打开 
            }

            try
            {
                SqlCommand cmd = new SqlCommand(cmdText, connection);
                SqlDataReader reader = cmd.ExecuteReader(); //异步访问数据库
                return reader;
            }
            /////////异常处理/////////
            catch (SqlException ex)
            {
                Debug.WriteLine("Error ({0}): {1}", ex.Number, ex.Message);
                return null;
            }
            catch (InvalidOperationException ex)
            {
                Debug.WriteLine("Error: {0}", ex.Message);
                return null;
            }
            catch (Exception ex)
            {
                // You might want to pass these errors
                // back out to the caller.
                Debug.WriteLine("Error: {0}", ex.Message);
                return null;
            }
        }

        /// <summary>
        /// 数据库数据修改操作（插入、更新、删除等操作）
        /// 直接调用，自动处理connection相关状态
        /// 成功返回受影响的行
        /// 失败返回-1
        /// </summary>
        /// <param name="cmdText"></param>
        /// <param name="connection"></param>
        public static int ReviseDataToDataBase(string cmdText, SqlConnection connection)
        {
            SqlCommand cmd = new SqlCommand(cmdText, connection);
            if (connection.State == ConnectionState.Closed)
                connection.Open();//将与数据库的连接打开
            try
            {
                 return cmd.ExecuteNonQuery();//异步执行sql语句
                

            }
            /////////异常处理/////////
            catch (SqlException ex)
            {
                Debug.WriteLine("Error ({0}): {1}", ex.Number, ex.Message);
                return -1;

            }
            catch (InvalidOperationException ex)
            {
                Debug.WriteLine("Error: {0}", ex.Message);
                return -1;

            }
            catch (Exception ex)
            {
                // You might want to pass these errors
                // back out to the caller.
                Debug.WriteLine("Error: {0}", ex.Message);
                return -1;
            }

        }

        /// <summary>
        /// 获取SqlDataAdapter，供DataSet更新数据库使用
        /// </summary>
        /// <param name="cmdText"></param>
        /// <param name="connection"></param>
        /// <returns></returns>
        public static SqlDataAdapter GetSqlDataAdapter(string cmdText, SqlConnection connection)
        {
            //判断connection是否处于打开状态
            if (connection.State == ConnectionState.Closed)
            {
                connection.Open();
            }
            SqlDataAdapter adapter = new SqlDataAdapter(cmdText, connection);
            return adapter;
        }

        /// <summary>
        /// 获取DataSet，供DataSet更新数据库使用
        /// </summary>
        /// <param name="adapter"></param>
        /// <returns></returns>
        public static DataSet GetDataSet(SqlDataAdapter adapter)
        {
            DataSet dataSet = new DataSet();//创建数据内存缓存
            adapter.Fill(dataSet);
            return dataSet;
        }
        /// <summary>
        /// 获取DataSet用于绑定到主框体的DataGrid
        /// </summary>
        /// <param name="cmdText"></param>
        /// <param name="connection"></param>
        /// <returns></returns>
        public static DataSet GetDataSet(string cmdText, SqlConnection connection)
        {
            //判断connection是否处于打开状态
            if (connection.State == ConnectionState.Closed)
            {
                connection.Open();
            }
            //创建SqlDataAdapter，并填充于DataSet中
            try
            {
                SqlDataAdapter dataAdapter = new SqlDataAdapter(cmdText, connection);
                DataSet dataSet = new DataSet();//创建数据内存缓存
                dataAdapter.Fill(dataSet);
                return dataSet;
            }
            catch (Exception ex)
            {
                Debug.WriteLine("创建SqlDataAdapter，并填充于DataSet时发生异常");
                Debug.WriteLine(ex.Message);
                return null;
             }
        }

    }
}