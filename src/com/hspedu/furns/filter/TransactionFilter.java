package com.hspedu.furns.filter;

import com.hspedu.furns.utils.JDBCUtilsByDruid;

import javax.servlet.*;
import java.io.IOException;

public class TransactionFilter implements Filter {
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {

    }

    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
        try {
            //放行.
            filterChain.doFilter(servletRequest,servletResponse);
            JDBCUtilsByDruid.commit();//統一提交, 出現了異常
        } catch (Exception e) {
            //老師解讀: 只有在try{} 中出現了異常,才會進行catch{} 執行
            //, 才會進行回滾.
            JDBCUtilsByDruid.rollback();//回滾
            //拋出異常, 給tomcat, tomcat會根據errorpage 來顯示對應
            //這裡請體會: 異常機制是可以參與業務邏輯
            throw new RuntimeException(e); //拋出異常，讓 Tomcat 來處理錯誤並顯示 500 頁面
//            e.printStackTrace(); //錯誤僅在伺服器端 (console) 列印
        }

    }

    @Override
    public void destroy() {

    }
}

