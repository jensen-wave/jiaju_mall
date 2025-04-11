package com.hspedu.furns.dao.impl;

import com.hspedu.furns.dao.BasicDAO;
import com.hspedu.furns.dao.FurnDAO;
import com.hspedu.furns.entity.Furn;

import java.util.List;

public class FurnDAOImpl extends BasicDAO<Furn> implements FurnDAO {
    @Override
    public List<Furn> queryFurns() {
        String sql = "SELECT `id` , `name` , `maker` , `price` , `sales` , `stock` , `img_path` imgpath FROM furn";
        return queryMulti(sql, Furn.class);
    }

    @Override
    public int addFurn(Furn furn) {
        String sql = "INSERT INTO furn(`id` , `name` , `maker` , `price` , `sales` , `stock` , `img_path`) \n" +
                "VALUES(NULL ,?,?,?,?,?,?);";
        return update(sql, furn.getName(), furn.getMaker(), furn.getPrice(), furn.getSales(), furn.getStock(), furn.getImgPath());
    }

    @Override
    public int deleteFurnById(int id) {
        String sql = "DELETE FROM `furn` WHERE id =?";
        return update(sql, id);
    }

    @Override
    public Furn queryFurnById(int id) {
        String sql = "SELECT `id` , `name` , `maker` , `price` , `sales` , `stock` , `img_path` imgpath FROM furn WHERE id =?";
      return querySingle(sql, Furn.class, id);
    }

    @Override
    public int updateFurn(Furn furn) {
        String sql="UPDATE `furn` SET `name` =?, `maker` = ?, `price` = ? , \n" +
                "`sales` = ? , `stock` = ? , `img_path` = ? \n" +
                "WHERE id = ?";
        return update(sql,furn.getName(),furn.getMaker(),furn.getPrice(),furn.getSales(),furn.getStock(),furn.getImgPath(),furn.getId());
    }

    @Override
    public int getTotalRow() {
        String sql="SELECT COUNT(*) FROM furn";
        return ((Number) queryScalar(sql)).intValue();
    }

    @Override
    public List<Furn> getPageItems(int begin, int pageSize) {
        String sql="SELECT `id`,`name`,`maker`,`price`,`sales`,`stock`,`img_path` imgPath FROM furn LIMIT ?,?";
        return queryMulti(sql, Furn.class,begin,pageSize);
    }

    @Override
    public int getTotalRowByName(String name) {
        String sql="SELECT COUNT(*) FROM `furn` WHERE NAME LIKE ?";
        return ((Number) queryScalar(sql,"%"+name+"%")).intValue();
    }

    @Override
    public List<Furn> getPageItemsByName(int begin, int pageSize,String name) {
        String sql="SELECT `id`, `name` , `maker`, `price`, `sales`, `stock`, \n" +
                "                `img_path` imgPath FROM furn WHERE `name` LIKE ? LIMIT ?, ?";
        return queryMulti(sql, Furn.class,"%"+name+"%",begin,pageSize);
    }

}

