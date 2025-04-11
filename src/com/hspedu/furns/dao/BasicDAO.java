package com.hspedu.furns.dao;


import com.hspedu.furns.utils.JDBCUtilsByDruid;
import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanHandler;
import org.apache.commons.dbutils.handlers.BeanListHandler;
import org.apache.commons.dbutils.handlers.ScalarHandler;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;


public class BasicDAO<T> { //泛型指定具體類型

    private QueryRunner qr =  new QueryRunner();

    //開發通用的dml方法, 針對任意的表
    public int update(String sql, Object... parameters) {

        Connection connection = null;

        try {
            //這裡從資料庫連接池獲取connection
            //老師說明: 每次從連接池中取出Connection , 不能保證是同一個
            //1.我們目前已經是從當前執行緒關聯的ThreadLocal獲取的connection
            //2.所以我們可以保證是同一個連接(在同一個執行緒/同一個請求)
            connection = JDBCUtilsByDruid.getConnection();
            int update = qr.update(connection, sql, parameters);
            return  update;
        } catch (SQLException e) {
            throw  new RuntimeException(e); //將編譯異常->運行異常 ,拋出
        }

    }

    //返回多個對象(即查詢的結果是多行), 針對任意表

    /**
     *
     * @param sql sql 語句，可以有 ?
     * @param clazz 傳入一個類的Class物件 比如 Actor.class
     * @param parameters 傳入 ? 的具體的值，可以是多個
     * @return 根據Actor.class 返回對應的 ArrayList 集合
     */
    public List<T> queryMulti(String sql, Class<T> clazz, Object... parameters) {

        Connection connection = null;
        try {
            connection = JDBCUtilsByDruid.getConnection();
            return qr.query(connection, sql, new BeanListHandler<T>(clazz), parameters);

        } catch (SQLException e) {
            throw  new RuntimeException(e); //將編譯異常->運行異常 ,拋出
        }

    }

    //查詢單行結果 的通用方法
    public T querySingle(String sql, Class<T> clazz, Object... parameters) {

        Connection connection = null;
        try {
            connection = JDBCUtilsByDruid.getConnection();
            return  qr.query(connection, sql, new BeanHandler<T>(clazz), parameters);

        } catch (SQLException e) {
            throw  new RuntimeException(e); //將編譯異常->運行異常 ,拋出
        }
    }

    //查詢單行單列的方法,即返回單值的方法

    public Object queryScalar(String sql, Object... parameters) {

        Connection connection = null;
        try {
            connection = JDBCUtilsByDruid.getConnection();
            return  qr.query(connection, sql, new ScalarHandler(), parameters);

        } catch (SQLException e) {
            throw  new RuntimeException(e); //將編譯異常->運行異常 ,拋出
        }
    }

}

