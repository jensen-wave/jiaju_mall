package com.hspedu.furns.web;

import com.hspedu.furns.entity.Cart;
import com.hspedu.furns.entity.Member;
import com.hspedu.furns.entity.Order;
import com.hspedu.furns.entity.OrderItem;
import com.hspedu.furns.service.OrderService;
import com.hspedu.furns.service.impl.OrderServiceImpl;
import com.hspedu.furns.utils.JDBCUtilsByDruid;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

public class OrderServlet extends BasicServlet {

    // 定義 OrderService 屬性，用於處理訂單相關業務
    private OrderService orderService = new OrderServiceImpl();

    /**
     * 生成訂單邏輯
     *
     * @param req  請求對象
     * @param resp 響應物件
     * @throws ServletException
     * @throws IOException
     */
    protected void saveOrder(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // 從 Session 中獲取購物車對象
        Cart cart = (Cart) req.getSession().getAttribute("cart");

        // 如果購物車不存在或為空，說明用戶沒有添加商品，轉發到首頁
        //這裡我們需要補充一個邏輯, 購物車在sessoin, 但是沒有家居資料
        if (null == cart ||cart.isEmpty()) {
            req.getRequestDispatcher("/index.jsp").forward(req, resp);
            return; // 終止方法執行
        }

        // 從 Session 中獲取當前登錄的會員資訊
        Member loginMember = (Member) req.getSession().getAttribute("loginMember");
        if (null == loginMember) { // 如果會員未登錄
            // 轉發到登錄頁面
            req.getRequestDispatcher("/views/member/login.jsp").forward(req, resp);
            return; // 終止方法執行
        }

        // 調用 OrderService 保存訂單，並獲取生成的訂單號

        //1. 如果我們只是希望對orderService.saveOrder()進行事務控制
        //2. 我們可以不使用篩檢程式, 我們直接在這個位置，進行提交和回滾即可
//        String orderId = null;
//        try {
//            orderId = orderService.saveOrder(cart, loginMember.getId());
//            JDBCUtilsByDruid.commit();// 提交事務，確保訂單資料被成功寫入資料庫
//        } catch (Exception e) {
//            JDBCUtilsByDruid.rollback();// 如果發生異常，則回滾事務，確保數據不會產生錯誤影響
//            e.printStackTrace();
//        }
        String orderId = orderService.saveOrder(cart, loginMember.getId());
        // 將訂單號保存到 Session 中，用於後續頁面顯示
        req.getSession().setAttribute("orderId", orderId);

        // 使用重定向跳轉到訂單結算頁面
        resp.sendRedirect(req.getContextPath() + "/views/order/checkout.jsp");
    }

    protected void listOrder(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Member loginMember = (Member) req.getSession().getAttribute("loginMember");
        if (loginMember == null) {
            req.getRequestDispatcher("/views/member/login.jsp").forward(req,resp);
            return;
        }
        List<Order> orders = orderService.listOrder(loginMember.getId());

        req.getSession().setAttribute("orders",orders);

        resp.sendRedirect(req.getContextPath()+"/views/order/order.jsp");
    }


    // 定義 listOrderItem 方法，用於處理顯示指定訂單的訂單項目
    protected void listOrderItem(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        // 從請求中獲取訂單 ID（通過請求參數 "oid" 傳遞）
        String orderId = (String) req.getParameter("oid");

        // 調用服務層方法，根據訂單 ID 獲取訂單項目的清單
        List<OrderItem> orderItems = orderService.listOrderItem(orderId);

        // 將訂單 ID 存儲到 Session 中，供 JSP 頁面使用
        req.getSession().setAttribute("orderId", orderId);

        // 將訂單項目列表存儲到 Session 中，供 JSP 頁面使用
        req.getSession().setAttribute("orderItems", orderItems);

        // 重定向到訂單詳情頁面（order_detail.jsp）
        resp.sendRedirect(req.getContextPath() + "/views/order/order_detail.jsp");
    }

}

