package com.hspedu.furns.filter;

import com.google.gson.Gson;
import com.hspedu.furns.entity.Member;
import com.hspedu.furns.utils.WebUtils;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 這是用於許可權驗證的篩檢程式, 對指定的 URL 進行驗證。
 * 如果用戶已登錄，則放行；如果未登錄，則重定向到登錄頁面。
 */

public class AuthFilter implements Filter {

    // 存放不需要進行身份驗證的 URL 列表
    private List<String> excludedUrls;

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // 從 Filter 配置參數中獲取無需攔截的 URL 列表（以逗號分隔的字串）
        String strExcludedUrls = filterConfig.getInitParameter("excludedUrls");

        // 將字串按逗號拆分成陣列，並轉換為 List 以便後續查詢
        String[] splitUrl = strExcludedUrls.split(",");
        excludedUrls = Arrays.asList(splitUrl);

        // 控制台列印 excludedUrls，便於調試
        System.out.println("Excluded URLs: " + excludedUrls);
    }

    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain)
            throws IOException, ServletException {

        // 將通用的 ServletRequest 轉換為 HttpServletRequest，以便使用 HTTP 相關方法
        HttpServletRequest request = (HttpServletRequest) servletRequest;

        // 獲取當前請求的 Servlet 路徑（不包含上下文路徑，如 "/admin/index.jsp"）
        String url = request.getServletPath();
        System.out.println("當前請求 URL: " + url); // 記錄訪問的路徑，便於調試

        // 判斷該請求 URL 是否在排除列表中，如果是，則直接放行
        if (!excludedUrls.contains(url)) {
            // 從 Session 中獲取已登錄的使用者資訊
            // 假設登錄成功後，"loginMember" 被存入 Session
            Member loginMember = (Member) request.getSession().getAttribute("loginMember");

            // 🚨 如果用戶未登錄（Session 中沒有 "loginMember"），則執行登錄跳轉邏輯
            if (loginMember == null) {

                // 🛠️ 判斷當前請求是否為 AJAX 請求
                if (!WebUtils.isAjaxRequest(request)) {
                    // 🖥️ 如果是普通請求（非 AJAX），使用 **請求轉發** 跳轉到 `login.jsp`
                    // `forward()` 方式不會改變流覽器位址，但會將請求轉發給 `login.jsp`
                    request.getRequestDispatcher("/views/member/login.jsp")
                            .forward(servletRequest, servletResponse);
                } else {
                    // 🌐 如果是 AJAX 請求，不能使用 `forward()` 或 `sendRedirect()`
                    // 需要返回 JSON 讓前端自行跳轉

                    // 創建一個 `Map` 結構用於存儲返回的 JSON 資料
                    Map<String, Object> resultMap = new HashMap<>();

                    // 在 JSON 資料中返回一個 `url` 欄位，指向登錄頁面
                    resultMap.put("url", "views/member/login.jsp");

                    // 使用 `Gson` 將 `Map` 轉換為 JSON 字串
                    Gson gson = new Gson();
                    String resultJson = gson.toJson(resultMap); // 轉換後的 JSON 示例：{"url": "views/member/login.jsp"}

                    // 返回 JSON 資料給前端
                    servletResponse.getWriter().write(resultJson);
                }

                // 🚫 終止方法，防止後續 `filterChain.doFilter()` 執行，避免未授權訪問受限資源
                return;
            }

        }

        // 如果用戶已登錄，或該 URL 在白名單中，則放行請求，繼續執行目標資源（如 JSP、Servlet）
        filterChain.doFilter(servletRequest, servletResponse);
    }

    @Override
    public void destroy() {
        // 在 Filter 被銷毀時執行的清理操作（此處無具體實現）
    }
}

