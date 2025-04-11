package com.hspedu.furns.service.impl;

import com.hspedu.furns.dao.FurnDAO;
import com.hspedu.furns.dao.impl.FurnDAOImpl;
import com.hspedu.furns.entity.Furn;
import com.hspedu.furns.entity.Page;
import com.hspedu.furns.service.FurnService;

import java.util.List;

public class FurnServiceImpl implements FurnService {
    private FurnDAO furnDao = new FurnDAOImpl();

    @Override
    public List<Furn> queryFurns() {
        return furnDao.queryFurns();
    }

    @Override
    public int add(Furn furn) {
        return furnDao.addFurn(furn);
    }

    @Override
    public int deleteFurnById(int id) {
        return furnDao.deleteFurnById(id);
    }

    @Override
    public Furn queryFurnById(int id) {
        return furnDao.queryFurnById(id);
    }

    @Override
    public int updateFurn(Furn furn) {
        return furnDao.updateFurn(furn);
    }

    @Override
    public Page<Furn> page(int pageNo, int pageSize) {

        //先創建一個Page物件，然後根據實際情況填充屬性
        Page<Furn> page = new Page<>();

        ////因為每頁顯示多少條記錄，是其它地方也可以使用
        ////ctrl+shift+u => 切換大小寫
        //public static  final  Integer PAGE_SIZE = 3;
        //
        ////表示顯示當前頁[顯示第幾頁]
        ////前端頁面來的
        //private Integer pageNo;
        ////表示每頁顯示幾條記錄
        //private Integer pageSize = PAGE_SIZE;
        ////表示共有多少頁, 他是計算得到
        //private Integer pageTotalCount;
        ////表示的是共有多少條記錄 , 通過totalRow和pageSize
        ////計算得到pageTotalCount
        ////是可以同資料庫DB來的->DAO
        //private Integer totalRow;
        ////表示當前頁，要顯示的資料
        ////從DB來的->DAO
        //private List<T> items;
        ////分頁導航的字串
        //private String url;
        page.setPageNo(pageNo);
        page.setPageSize(pageSize);
        int totalRow = furnDao.getTotalRow();
        page.setTotalRow(totalRow);
        //pageTotalCount 是計算得到-> 一個小小的演算法
        //老師分析
        //比如 6 2  =》  6 / 2 = 3
        //比如 5 2  =》  5 / 2 = 2
        //驗證 7 3 =>
        //驗證 0 2 =>
        int pageTotalCount = totalRow / pageSize;
        if (totalRow % pageSize > 0) {
            pageTotalCount += 1;
        }

        page.setPageTotalCount(pageTotalCount);

        //private List<T> items
        //老師開始計算begin-> 小小演算法
        //驗證: pageNo = 1 pageSize = 3 => begin =0
        //驗證: pageNo = 3 pageSize = 2 => begin =4
        //OK => 但是注意這裡隱藏一個坑, 現在你看不到, 後面會暴露
        int begin = (pageNo - 1) * pageSize;
        List<Furn> pageItems = furnDao.getPageItems(begin, pageSize);
        page.setItems(pageItems);
        //還差一個url => 分頁導航，先放一放
        return page;
    }

    @Override
    public Page<Furn> pageByName(int pageNo, int pageSize,String name) {
        //先創建一個Page物件，然後根據實際情況填充屬性
        Page<Furn> page = new Page<>();

        ////因為每頁顯示多少條記錄，是其它地方也可以使用
        ////ctrl+shift+u => 切換大小寫
        //public static  final  Integer PAGE_SIZE = 3;
        //
        ////表示顯示當前頁[顯示第幾頁]
        ////前端頁面來的
        //private Integer pageNo;
        ////表示每頁顯示幾條記錄
        //private Integer pageSize = PAGE_SIZE;
        ////表示共有多少頁, 他是計算得到
        //private Integer pageTotalCount;
        ////表示的是共有多少條記錄 , 通過totalRow和pageSize
        ////計算得到pageTotalCount
        ////是可以同資料庫DB來的->DAO
        //private Integer totalRow;
        ////表示當前頁，要顯示的資料
        ////從DB來的->DAO
        //private List<T> items;
        ////分頁導航的字串
        //private String url;
        page.setPageNo(pageNo);
        page.setPageSize(pageSize);
        int totalRow = furnDao.getTotalRowByName(name);
        page.setTotalRow(totalRow);
        //pageTotalCount 是計算得到-> 一個小小的演算法
        //老師分析
        //比如 6 2  =》  6 / 2 = 3
        //比如 5 2  =》  5 / 2 = 2
        //驗證 7 3 =>
        //驗證 0 2 =>
        int pageTotalCount = totalRow / pageSize;
        if (totalRow % pageSize > 0) {
            pageTotalCount += 1;
        }

        page.setPageTotalCount(pageTotalCount);

        //private List<T> items
        //老師開始計算begin-> 小小演算法
        //驗證: pageNo = 1 pageSize = 3 => begin =0
        //驗證: pageNo = 3 pageSize = 2 => begin =4
        //OK => 但是注意這裡隱藏一個坑, 現在你看不到, 後面會暴露
        int begin = (pageNo - 1) * pageSize;
        List<Furn> pageItems = furnDao.getPageItemsByName(begin, pageSize,name);
        page.setItems(pageItems);
        //還差一個url => 分頁導航，先放一放
        return page;
    }
}

