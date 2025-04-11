package com.hspedu.furns.web;

import com.hspedu.furns.entity.Member;
import com.hspedu.furns.service.MemberService;
import com.hspedu.furns.service.impl.MemberServiceImpl;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

/**
 * 處理用戶註冊請求的 Servlet。
 * 主要功能：處理註冊表單提交，檢查用戶名是否存在，並將結果響應到對應的頁面。
 */
public class RegisterServlet extends HttpServlet {

    // 定義 MemberService，提供會員相關業務邏輯
    private MemberService memberService = new MemberServiceImpl();

    /**
     * 當使用 GET 請求訪問時，將請求轉發到 doPost 方法處理。
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

    /**
     * 處理用戶提交的註冊表單請求。
     * @param request  用戶的 HTTP 請求，包含表單數據
     * @param response 服務端的 HTTP 響應，用於返回結果
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 從表單中獲取用戶提交的數據
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String email = request.getParameter("email");

        // 檢查用戶名是否已存在
        if (!memberService.isExistsUsername(username)) {
            // 如果用戶名不存在，創建一個新的 Member 對象
            Member member = new Member(null, username, password, email);

            // 調用業務層的註冊方法進行註冊操作
            if (memberService.registerMember(member)) {
                // 註冊成功，轉發到註冊成功頁面
                request.getRequestDispatcher("/views/member/register_ok.jsp").forward(request, response);
            } else {
                // 註冊失敗，轉發到註冊失敗頁面
                request.getRequestDispatcher("/views/member/register_fail.jsp").forward(request, response);
            }
        } else {
            // 如果用戶名已存在，轉發到登錄頁面提示用戶登錄
            request.getRequestDispatcher("/views/member/login.jsp").forward(request, response);
        }

        // 列印日誌，方便開發時調試
        System.out.println("RegisterServlet調用");
    }
}

