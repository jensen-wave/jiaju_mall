package com.hspedu.furns.service;

import com.hspedu.furns.entity.Cart;
import com.hspedu.furns.entity.Order;
import com.hspedu.furns.entity.OrderItem;

import java.util.List;


public interface OrderService {

    //分析
    //1. 生成訂單
    //2. 訂單是根據cart來生成, cart物件在session,通過web層，傳入saveOrder
    //3. 訂單是和一個會員關聯
    public String saveOrder(Cart cart, int memberId);
    public List<Order> listOrder(int memberId);
    public List<OrderItem> listOrderItem(String orderId);
}

