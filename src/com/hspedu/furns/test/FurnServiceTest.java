package com.hspedu.furns.test;

import com.hspedu.furns.entity.Furn;
import com.hspedu.furns.entity.Page;
import com.hspedu.furns.service.FurnService;
import com.hspedu.furns.service.impl.FurnServiceImpl;
import org.junit.jupiter.api.Test;

import java.math.BigDecimal;
import java.util.List;


public class FurnServiceTest {
    private FurnService furnService = new FurnServiceImpl();

    @Test
    public void queryFurns() {
        List<Furn> furns = furnService.queryFurns();
        for (Furn furn : furns) {
            System.out.println(furn);
        }
    }
    @Test
    public void add(){
        Furn furn = new Furn(null,"小羊","ikea",new BigDecimal(100000),1,1,"assets/images/product-image/16.jpg");
        int add = furnService.add(furn);
        System.out.println(add);
    }
    @Test
public void deleteFurnById(){
    int i = furnService.deleteFurnById(37);
    System.out.println(i);
}
@Test
public void queryFurnById(){
    System.out.println(furnService.queryFurnById(999));
}
@Test
public void updateFurn(){
    Furn furn = new Furn(48,"小小","ikea",new BigDecimal(100000),1,1,"assets/images/product-image/16.jpg");
    System.out.println(furnService.updateFurn(furn));
}
@Test
public void page(){
    Page<Furn> page = furnService.page(1, 3);
    System.out.println(page);
}
    @Test
    public void pageByName(){
        Page<Furn> page = furnService.pageByName(1, 3,"100");
        System.out.println(page);
    }
}
