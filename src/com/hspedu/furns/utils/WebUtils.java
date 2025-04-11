package com.hspedu.furns.utils;

import javax.servlet.http.HttpServletRequest;

/**
 * Web 工具類，提供與 HTTP 請求相關的實用方法
 */
public class WebUtils {
    //定義一個檔上傳的路徑
    public static String  FURN_IMG_DIRECTORY = "assets/images/product-image";

    /**
     * 判斷當前請求是否為 AJAX 請求
     *
     * AJAX 請求通常會在請求頭中帶有 "X-Requested-With" 頭部，並且值為 "XMLHttpRequest"。
     * 通過檢查該頭部的值，可以判斷請求是否來自 AJAX。
     *
     * @param request HTTP 請求對象
     * @return 如果是 AJAX 請求，返回 true，否則返回 false
     */
    public static boolean isAjaxRequest(HttpServletRequest request) {
        // 獲取請求頭 "X-Requested-With"，如果值為 "XMLHttpRequest"，說明是 AJAX 請求
        return "XMLHttpRequest".equals(request.getHeader("X-Requested-With"));
    }
}

