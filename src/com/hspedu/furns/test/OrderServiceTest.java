package com.hspedu.furns.test;

import com.hspedu.furns.entity.Cart;
import com.hspedu.furns.entity.CartItem;
import com.hspedu.furns.service.OrderService;
import com.hspedu.furns.service.impl.OrderServiceImpl;
import org.junit.jupiter.api.Test;

import java.math.BigDecimal;


public class OrderServiceTest {

    private OrderService orderService = new OrderServiceImpl();

    @Test
    public void saveOrder() {

        //構建一個Cart物件
        Cart cart = new Cart();
        cart.addItem(new CartItem(1,"北歐風格小桌子",new BigDecimal(200.00), 2, new BigDecimal(400.00)));
        cart.addItem(new CartItem(2,"簡約風格小椅子",new BigDecimal(180.00), 1, new BigDecimal(180.00)));

        //驗證3張表是否變化正確.
        System.out.println(orderService.saveOrder(cart, 2));
    }
}

