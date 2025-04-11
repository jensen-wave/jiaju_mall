package com.hspedu.furns.web;

import com.hspedu.furns.entity.Furn;
import com.hspedu.furns.entity.Page;
import com.hspedu.furns.service.FurnService;
import com.hspedu.furns.service.impl.FurnServiceImpl;
import com.hspedu.furns.utils.DataUtils;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

public class CustomerFurnServlet extends BasicServlet {

    private FurnService furnService = new FurnServiceImpl();


    protected void page(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int pageNo = DataUtils.parseInt(req.getParameter("pageNo"), 1);
        int pageSize = DataUtils.parseInt(req.getParameter("pageSize"), Page.PAGE_SIZE);

        Page<Furn> page = furnService.page(pageNo, pageSize);
        req.setAttribute("page", page);
        req.getRequestDispatcher("/views/customer/index.jsp").forward(req, resp);
    }

    protected void pageByName(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int pageNo = DataUtils.parseInt(req.getParameter("pageNo"), 1);
        int pageSize = DataUtils.parseInt(req.getParameter("pageSize"), Page.PAGE_SIZE);
        //老師解讀
        //1.如果參數有name 帶上沒有值, 接收到的是""
        //2.如果name參數都沒有, 接收到的null
        //3.也就是說我們把 "" 和 null 業務邏輯合併在一起..

        // 獲取name參數，如果為null，則賦值為空字串
        String name = req.getParameter("name");
        if (null == name) {
            name = "";
        }
        //調用service方法, 獲取Page物件
        Page<Furn> page = furnService.pageByName(pageNo, pageSize, name);
        // 拼接分頁導航的URL，保留搜索條件
        StringBuilder url = new StringBuilder("customerFurnServlet?action=pageByName");
        if (!"".equals(name)) {//如name不為"", 則在拼接 name參數
            url.append("&name=").append(name);
        }
        page.setUrl(url.toString());
        //將page放入到request域
        req.setAttribute("page", page);
        //請求轉發到furn_manage.jsp
        req.getRequestDispatcher("/views/customer/index.jsp").forward(req, resp);
    }
}

