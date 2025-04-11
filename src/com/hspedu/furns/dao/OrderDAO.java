package com.hspedu.furns.dao;

import com.hspedu.furns.entity.Order;

import java.util.List;


public interface OrderDAO {

    /**
     * 將傳入的order對象保存到資料表order表
     * @param order
     * @return
     */
    public int saveOrder(Order order);
    public List<Order> listOrder(int memberId);
}

