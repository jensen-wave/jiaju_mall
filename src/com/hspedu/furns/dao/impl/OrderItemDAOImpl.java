package com.hspedu.furns.dao.impl;

import com.hspedu.furns.dao.BasicDAO;
import com.hspedu.furns.dao.OrderItemDAO;
import com.hspedu.furns.entity.OrderItem;

import java.util.List;


public class OrderItemDAOImpl extends BasicDAO<OrderItem> implements OrderItemDAO {
    @Override
    public int saveOrderItem(OrderItem orderItem) {

        String sql = "INSERT INTO `order_item`(`id`,`name`,`price`,`count`,`total_price`,`order_id`) " +
                "VALUES(?, ?,?,?,?,?) ";//sqlyoy
        return update(sql,orderItem.getId(),orderItem.getName(),orderItem.getPrice(),
                orderItem.getCount(),orderItem.getTotalPrice(),orderItem.getOrderId());
    }

    @Override
    public List<OrderItem> listOrderItem(String orderId) {
        String sql ="SELECT `id`,`name`,`price`,`count`,`total_price` AS totalPrice,`order_id` AS orderId FROM`order_item` WHERE`order_id`=?";
        return queryMulti(sql, OrderItem.class,orderId);
    }
}
