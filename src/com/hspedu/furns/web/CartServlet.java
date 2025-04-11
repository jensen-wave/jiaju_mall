package com.hspedu.furns.web;

import com.google.gson.Gson;
import com.hspedu.furns.entity.Cart;
import com.hspedu.furns.entity.CartItem;
import com.hspedu.furns.entity.Furn;
import com.hspedu.furns.service.FurnService;
import com.hspedu.furns.service.impl.FurnServiceImpl;
import com.hspedu.furns.utils.DataUtils;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

public class CartServlet extends BasicServlet {

    //增加一個屬性
    private FurnService furnService = new FurnServiceImpl();



    protected void clear(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        //獲取session中的購物車
        Cart cart = (Cart) req.getSession().getAttribute("cart");
        if (null != cart) {
            cart.clear();
        }

        //返回清空購物車的頁面
        resp.sendRedirect(req.getHeader("Referer"));
    }


    protected void delItem(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        int id = DataUtils.parseInt(req.getParameter("id"), 0);
        //獲取到cart購物車
        Cart cart = (Cart) req.getSession().getAttribute("cart");
        if (null != cart) {
            cart.delItem(id);
        }
        //返回到請求刪除購物車的頁面
        resp.sendRedirect(req.getHeader("Referer"));
    }


    /**
     * 更新某個CartItem的數量, 即更新購物車
     *
     * @param req  HTTP請求對象，用於獲取參數和Session
     * @param resp HTTP回應物件，用於返回資料或頁面跳轉
     * @throws ServletException 可能拋出的Servlet異常
     * @throws IOException      可能拋出的IO異常
     */
    protected void updateCount(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // 1. 獲取請求中的商品id參數，並將其解析為整數，預設值為0
        int id = DataUtils.parseInt(req.getParameter("id"), 0);

        // 2. 獲取請求中的商品數量參數，並將其解析為整數，預設值為1
        // 根據業務需要可以設置預設值為1，表示最小購買數量
        int count = DataUtils.parseInt(req.getParameter("count"), 1);

        // 3. 從Session中獲取購物車對象
        Cart cart = (Cart) req.getSession().getAttribute("cart");

        // 4. 如果購物車物件存在，則調用Cart類的updateCount方法更新商品數量
        if (null != cart) {
            // 更新指定商品的數量和總價
            cart.updateCount(id, count);
        }

        // 5. 重定向到發起更新請求的頁面
        // 使用Referer頭部資訊返回到之前的頁面，保證使用者體驗不被打斷
        resp.sendRedirect(req.getHeader("Referer"));
    }

    protected void addItemByAjax(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        //得到添加家居的id
        int id = DataUtils.parseInt(req.getParameter("id"), 0);
        //獲取到到id對應的Furn
        Furn furn = furnService.queryFurnById(id);

        if (furn.getStock()==0) {
            req.setAttribute("msg", "商品無庫存");
            req.setAttribute("msgFurnId", furn.getId());
            req.getRequestDispatcher("/index.jsp").forward(req, resp);
            return;
        }
        //判斷
        //老師，先把正常的邏輯走完，再處理異常情況
        //todo

        //根據furn 構建 CartItem
        CartItem item =
                new CartItem(furn.getId(), furn.getName(), furn.getPrice(), 1, furn.getPrice());

        //從session中獲取cart對象
        Cart cart = (Cart) req.getSession().getAttribute("cart");

        if (null == cart) {//說明當前用戶的session沒有cart
            cart = new Cart();//創建了一個cart物件
            req.getSession().setAttribute("cart", cart);
        }

        //將cartItem 加入到cart
        cart.addItem(item);

// 添加完畢後，返回 JSON 數據給前端，讓前端可以局部刷新，而不是整頁重載
// 老師的思路：
// 1. 規定 JSON 格式，例如：{"cartTotalCount": 3}
// 2. 創建一個 Map 來存儲要返回的數據

// 創建 Map 來存儲返回給前端的數據
        Map<String, Object> resultMap = new HashMap<>();

// 把當前購物車內商品總數量放入 Map
        resultMap.put("cartTotalCount", cart.getTotalCount());

// 使用 Gson 庫將 Map 轉換為 JSON 字串
        Gson gson = new Gson();
        String resultJson = gson.toJson(resultMap); // 例如 {"cartTotalCount": 3}

// 將 JSON 數據寫入 HTTP 回應，發送給前端
        resp.getWriter().write(resultJson);


    }



    //增加一個添加家居資料到購物車的方法

    protected void addItem(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        //得到添加家居的id
        int id = DataUtils.parseInt(req.getParameter("id"), 0);
        //獲取到到id對應的Furn
        Furn furn = furnService.queryFurnById(id);

        if (furn.getStock()==0) {
            req.setAttribute("msg", "商品無庫存");
            req.setAttribute("msgFurnId", furn.getId());
            req.getRequestDispatcher("/index.jsp").forward(req, resp);
            return;
        }
        //判斷
        //老師，先把正常的邏輯走完，再處理異常情況
        //todo

        //根據furn 構建 CartItem
        CartItem item =
                new CartItem(furn.getId(), furn.getName(), furn.getPrice(), 1, furn.getPrice());

        //從session中獲取cart對象
        Cart cart = (Cart) req.getSession().getAttribute("cart");

        if (null == cart) {//說明當前用戶的session沒有cart
            cart = new Cart();//創建了一個cart物件
            req.getSession().setAttribute("cart", cart);
        }

        //將cartItem 加入到cart
        cart.addItem(item);
        System.out.println("cart=" + cart);
//添加完畢後，需要返回到添加家居的頁面
        String referer = req.getHeader("referer");
        resp.sendRedirect(referer);

    }


}

