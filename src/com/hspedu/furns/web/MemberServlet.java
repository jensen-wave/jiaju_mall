package com.hspedu.furns.web;

import com.google.gson.Gson;
import com.hspedu.furns.entity.Member;
import com.hspedu.furns.service.MemberService;
import com.hspedu.furns.service.impl.MemberServiceImpl;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import static com.google.code.kaptcha.Constants.KAPTCHA_SESSION_KEY;

public class MemberServlet extends BasicServlet {

    private MemberService memberService = new MemberServiceImpl(); // ★ 創建 MemberService 實例，提供使用者業務邏輯服務

    /**
     * 處理檢查用戶名是否已存在的請求
     * 返回 JSON 格式資料，例如：{"isExist": false}
     */
    protected void isExistUserName(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // ★ 從請求參數中獲取用戶名
        String username = req.getParameter("username");

        // ★ 調用業務層方法，檢查用戶名是否存在
        boolean isExistsUsername = memberService.isExistsUsername(username);

        // ★ 創建一個 Map 物件，用於存放 JSON 資料
        Map<String, Object> resultMap = new HashMap<>();
        resultMap.put("isExist", isExistsUsername); // ★ 將檢查結果存入 Map

        // ★ 使用 Gson 庫將 Map 轉換為 JSON 字串
        Gson gson = new Gson();
        String resultJson = gson.toJson(resultMap);

        // ★ 通過 HttpServletResponse 將 JSON 資料返回給前端
        resp.getWriter().write(resultJson);
    }

    //    @Override
//    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//
//        String action = request.getParameter("action");
//
//        if ("login".equals(action)) {
//            login(request, response); // 調用 login 方法
//
//        }else if ("register".equals(action)){
//            register(request, response); // 調用 register 方法
//
//        }else {
//            response.getWriter().write("請求錯誤");
//        }
//
//
//    }

    protected void login(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 從請求中獲取使用者輸入的帳號和密碼
        String username = request.getParameter("user-name");
        String userpassword = request.getParameter("user-password");

        // 將輸入的帳號密碼封裝到 Member 物件中，準備進行驗證
        Member member = new Member(null, username, userpassword, "");

        // 調用服務層 `memberService` 進行用戶驗證，返回登錄的 `Member` 對象
        Member loginMember = memberService.login(member);

        if (loginMember != null) { // 如果 `loginMember` 不為 null，代表用戶驗證成功
            // 將登入的用戶資訊存入 Session，方便後續權限驗證
            request.getSession().setAttribute("loginMember", loginMember);

            // 判斷當前登入的用戶是否是管理員（帳號為 "admin"）
            if ("admin".equals(loginMember.getUsername())) {
                // 如果是管理員，則轉發到管理頁面 `/views/manage/manage_menu.jsp`
                request.getRequestDispatcher("/views/manage/manage_menu.jsp").forward(request, response);
            } else {
                // 如果是一般用戶，則轉發到普通用戶登入成功頁面 `/views/member/login_ok.jsp`
                request.getRequestDispatcher("/views/member/login_ok.jsp").forward(request, response);
            }
        } else { // 用戶驗證失敗
            // 設置錯誤提示資訊，告知用戶帳號或密碼錯誤
            request.setAttribute("msg", "姓名或密碼錯誤");
            // 記錄使用者輸入的帳號，以便登入頁面回填
            request.setAttribute("username", username);
            // 轉發到登入頁面 `/views/member/login.jsp`，讓用戶重新輸入帳號密碼
            request.getRequestDispatcher("/views/member/login.jsp").forward(request, response);
        }
    }


    protected void register(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 從表單中獲取用戶提交的數據
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String email = request.getParameter("email");
        String code = request.getParameter("code");
        String token = (String) request.getSession().getAttribute(KAPTCHA_SESSION_KEY);

        if (token != null && token.equalsIgnoreCase(code)) {


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

        } else { //驗證碼不正確
            request.setAttribute("msg", "驗證碼不正確~");
            //如果前端需要回顯某些資料
            request.setAttribute("username", username);
            request.setAttribute("email", email);
            //帶回一個資訊 要顯示到註冊選項頁
            request.setAttribute("active", "register");
            request.getRequestDispatcher("/views/member/login.jsp").forward(request, response);
        }
    }

    protected void logout(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        //銷毀當前用戶的session
        req.getSession().invalidate();
        //重定向到網站首頁-> 刷新首頁
        //req.getContextPath() => http://localhost:8080/jiaju_mall
        resp.sendRedirect(req.getContextPath());
    }
}



