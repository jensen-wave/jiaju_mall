package com.hspedu.furns.service.impl;

import com.hspedu.furns.dao.FurnDAO;
import com.hspedu.furns.dao.OrderDAO;
import com.hspedu.furns.dao.OrderItemDAO;
import com.hspedu.furns.dao.impl.FurnDAOImpl;
import com.hspedu.furns.dao.impl.OrderDAOImpl;
import com.hspedu.furns.dao.impl.OrderItemDAOImpl;
import com.hspedu.furns.entity.*;
import com.hspedu.furns.service.OrderService;

import java.util.*;


public class OrderServiceImpl implements OrderService {

    private OrderDAO orderDAO = new OrderDAOImpl();
    private OrderItemDAO orderItemDAO = new OrderItemDAOImpl();
    private FurnDAO furnDAO = new FurnDAOImpl();


    //老師說明: 這裡同學們應該感受javaee分層的好處 , 在service層, 通過組合多個dao的方法
    //完成某個業務, 慢慢體會好處.

    @Override
    public String saveOrder(Cart cart, int memberId) {

        //這裡的業務邏輯相對綜合
        //完成任務時將 cart購物車的資料->以order和 orderItem形式保存到db

        //老師說明：因為生成訂單會操作多表，因此會涉及到多表事務的問題 ThreadLocal+Mysql事務機制+篩檢程式
        //關於事務的處理，考慮的點比較多，老師後面專門處理

        //1. 通過cart對象, 構建對應的Order對象
        //先生成一個UUID, 表示當前的訂單號, 訂單號要保證是唯一
        String orderId = System.currentTimeMillis() + "" + memberId;
        Order order =
                new Order(orderId, new Date(), cart.getCartTotalPrice(), 0, memberId);
        //保存order到資料表.
        orderDAO.saveOrder(order);

        //2.通過cart對象 ,遍歷出CartItem, 構建OrderItem對象， 並保存到對應的表order_item

        //HashMap<Integer, CartItem> items = cart.getItems();
        //// java基礎遍歷hashmap
        //Set<Integer> keys = items.keySet();
        //for (Integer id : keys) {
        //    CartItem item = items.get(id);
        //    //通過cartItem對象構建了OrderItem
        //    OrderItem orderItem = new OrderItem(null,item.getName(),item.getPrice(),
        //            item.getCount(),item.getTotalPrice(),orderId);
        //
        //    //保存
        //    orderItemDAO.saveOrderItem(orderItem);
        //
        //    //更新一把furn表的sales銷量, stock存量
        //    //(1) 獲取到furn對象
        //    Furn furn = furnDAO.queryFurnById(id);
        //    //(2) 更新一下這個furn的sales銷量, stock存量
        //    furn.setSales(furn.getSales() + item.getCount());
        //    furn.setStock(furn.getStock() - item.getCount());
        //    //(3) 更新到資料表
        //    furnDAO.updateFurn(furn);
        //
        //}

        //=======通過entryset的方式遍歷items 取出CartItem===

        for (Map.Entry<Integer, CartItem> entry : cart.getItems().entrySet()) {
            CartItem item = entry.getValue();
            //通過cartItem對象構建了OrderItem
            OrderItem orderItem = new OrderItem(null, item.getName(), item.getPrice(),
                    item.getCount(), item.getTotalPrice(), orderId);

            //保存
            orderItemDAO.saveOrderItem(orderItem);

            //更新一把furn表的sales銷量, stock存量
            //(1) 獲取到furn對象
            Furn furn = furnDAO.queryFurnById(item.getId());
            //(2) 更新一下這個furn的sales銷量, stock存量
            furn.setSales(furn.getSales() + item.getCount());
            furn.setStock(furn.getStock() - item.getCount());
            //(3) 更新到資料表
            furnDAO.updateFurn(furn);

        }

        //清空購物車
        cart.clear();
        return orderId;
    }

    @Override
    public List<Order> listOrder(int memberId) {
        return orderDAO.listOrder(memberId);
    }

    @Override
    public List<OrderItem> listOrderItem(String orderId) {
        return orderItemDAO.listOrderItem(orderId);
    }
}

