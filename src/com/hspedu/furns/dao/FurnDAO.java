package com.hspedu.furns.dao;

import com.hspedu.furns.entity.Furn;

import java.util.List;

public interface FurnDAO {

    public List<Furn> queryFurns();

    public int addFurn(Furn furn);

    public int deleteFurnById(int id);

    public Furn queryFurnById(int id);

    public int updateFurn(Furn furn);

    //老師分析：Page的哪些屬性是可以直接從資料庫中獲取
    //就把這個填充任務防在DAO層.
    public int getTotalRow();

    // 獲取當前頁要顯示的資料
    // begin : 表示從第幾條記錄開始獲取， 從0開始計算
    // pageSize : 表示取出多少條記錄
    // Mysql基礎..
    public List<Furn> getPageItems(int begin, int pageSize);

    public int getTotalRowByName(String name);

    public List<Furn> getPageItemsByName(int begin, int pageSize,String name);

}

