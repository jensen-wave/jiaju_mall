package com.hspedu.furns.test;

import com.hspedu.furns.dao.FurnDAO;
import com.hspedu.furns.dao.impl.FurnDAOImpl;
import com.hspedu.furns.entity.Furn;
import org.junit.jupiter.api.Test;

import java.math.BigDecimal;
import java.util.List;


public class FurnDAOTest {

    private FurnDAO furnDAO = new FurnDAOImpl();

    @Test
    public void queryFurns() {

        List<Furn> furns = furnDAO.queryFurns();
        for (Furn furn : furns) {
            System.out.println(furn);
        }
    }

    @Test
    public void addFurn() {
        Furn furn = new Furn(null, "寶寶", "ikea", new BigDecimal(100000), 1, 1, "assets/images/product-image/16.jpg");
        int i = furnDAO.addFurn(furn);
        System.out.println(i);
    }

    @Test
    public void deleteFurnById() {
        int i = furnDAO.deleteFurnById(38);
        System.out.println(i);
    }

    @Test
    public void getTotalRow() {

        System.out.println(furnDAO.getTotalRow());
    }

    @Test
    public void getPageItems() {

        List<Furn> pageItems = furnDAO.getPageItems(1, 3);
        for (Furn furn : pageItems) {
            System.out.println(furn);
        }
    }

    @Test
    public void getTotalRowByName() {
        int totalRowByName = furnDAO.getTotalRowByName("100");
        System.out.println(totalRowByName);
    }

    @Test
    public void getPageItemsByName() {
        List<Furn> pageItemsByName = furnDAO.getPageItemsByName(0, 5, "100");
        for (Furn furn : pageItemsByName) {
            System.out.println(furn);
        }
    }
}
