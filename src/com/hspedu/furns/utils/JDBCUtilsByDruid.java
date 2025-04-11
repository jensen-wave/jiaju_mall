package com.hspedu.furns.utils;

import com.alibaba.druid.pool.DruidDataSourceFactory;

import javax.sql.DataSource;
import java.io.FileInputStream;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Properties;


public class JDBCUtilsByDruid {

    private static DataSource ds;
    //定義屬性ThreadLocal, 這裡存放一個Connection
    private static ThreadLocal<Connection> threadLocalConn = new ThreadLocal<>();

    //在靜態代碼塊完成 ds初始化
    static {
        Properties properties = new Properties();
        try {
            properties.load(JDBCUtilsByDruid.class.getClassLoader()
                    .getResourceAsStream("druid.properties"));
//            properties.load(new FileInputStream("src\\druid.properties"));
            ds = DruidDataSourceFactory.createDataSource(properties);
        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    //編寫getConnection方法
//    public static Connection getConnection() throws SQLException {
//        return ds.getConnection();
//    }

    /**
     * 從ThreadLocal獲取connection, 從而保證在同一個執行緒中，
     * 獲取的是同一個Connection
     *
     * @return
     * @throws SQLException
     */
    public static Connection getConnection() {

        Connection connection = threadLocalConn.get();
        if (connection == null) {//說明當前的threadLocalConn沒有連接
            //就從資料庫連接池中,取出一個連接放入, threadLocalConn
            try {
                connection = ds.getConnection();
                //將連接設置為手動提交, 即不要自動提交
                connection.setAutoCommit(false);
            } catch (SQLException throwables) {
                throwables.printStackTrace();
            }
            threadLocalConn.set(connection);

        }
        return connection;
    }

    /**
     * 提交事務, java基礎 mysql事務+執行緒+篩檢程式機制+ThreadLocal
     */
    public static  void commit() {

        Connection connection = threadLocalConn.get();
        if(connection != null) {//確保該連接是有效

            try {
                connection.commit();
            } catch (SQLException throwables) {
                throwables.printStackTrace();
            } finally {
                try {
                    connection.close();//關閉連接
                } catch (SQLException throwables) {
                    throwables.printStackTrace();
                }
            }
        }

        //老師說明
        //1. 當提交後，需要把connection從 threadLocalConn 清除掉
        //2. 不然，會造成 threadLocalConn 長時間持有該連接, 會影響效率
        //3. 也因為我們Tomcat底層使用的是執行緒池技術
        threadLocalConn.remove();

    }

    /**
     * 老師說明:  所謂回滾，是回滾/撤銷和 connection管理的操作刪掉，修改，添加
     */
    public static  void rollback() {

        Connection connection = threadLocalConn.get();
        if(connection != null) {//保證當前的連接是有效

            try {
                connection.rollback();
            } catch (SQLException throwables) {
                throwables.printStackTrace();
            } finally {
                try {
                    connection.close();
                } catch (SQLException throwables) {
                    throwables.printStackTrace();
                }
            }
        }

        threadLocalConn.remove();
    }

    //關閉連接, 老師再次強調： 在資料庫連接池技術中，close 不是真的斷掉連接
    //而是把使用的Connection物件放回連接池
    public static void close(ResultSet resultSet, Statement statement, Connection connection) {

        try {
            if (resultSet != null) {
                resultSet.close();
            }
            if (statement != null) {
                statement.close();
            }
            if (connection != null) {
                connection.close();
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}

