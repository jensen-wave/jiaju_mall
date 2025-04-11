package com.hspedu.furns.web;

import com.hspedu.furns.entity.Member;
import com.hspedu.furns.service.MemberService;
import com.hspedu.furns.service.impl.MemberServiceImpl;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

public class LoginServlet extends HttpServlet {

    private MemberService memberService = new MemberServiceImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request,response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("user-name");
        String userpassword = request.getParameter("user-password");
        Member member = new Member(null,username,userpassword,"");

        Member loginMember = memberService.login(member);

        if (loginMember!=null){
            request.getRequestDispatcher("/views/member/login_ok.jsp").forward(request,response);
        }else {
            request.setAttribute("msg","姓名或密碼錯誤");
            request.setAttribute("username",username);
            request.getRequestDispatcher("/views/member/login.jsp").forward(request,response);

        }


    }
}

