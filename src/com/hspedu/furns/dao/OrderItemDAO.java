package com.hspedu.furns.dao;

import com.hspedu.furns.entity.OrderItem;

import java.util.List;

public interface OrderItemDAO {
    /**
     * 將傳入的orderItem保存到資料表orderItem
     * @param orderItem
     * @return
     */
    public int saveOrderItem(OrderItem orderItem);
    public List<OrderItem> listOrderItem(String orderId);
}

