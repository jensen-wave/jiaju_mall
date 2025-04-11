package com.hspedu.furns.entity;

import java.util.List;


//T表示泛型，因為將來分頁模型對應的資料類型是不確定的
public class Page<T> {

    //因為每頁顯示多少條記錄，是其它地方也可以使用
    //ctrl+shift+u => 切換大小寫
    public static  final  Integer PAGE_SIZE = 3;

    //表示顯示當前頁[顯示第幾頁]
    //前端頁面來的
    private Integer pageNo;
    //表示每頁顯示幾條記錄
    private Integer pageSize = PAGE_SIZE;
    //表示共有多少頁, 他是計算得到
    private Integer pageTotalCount;
    //表示的是共有多少條記錄 , 通過totalRow和pageSize
    //計算得到pageTotalCount
    //是可以同資料庫DB來的->DAO
    private Integer totalRow;
    //表示當前頁，要顯示的資料
    //從DB來的->DAO
    private List<T> items;
    //分頁導航的字串
    private String url;

    public Integer getPageNo() {
        return pageNo;
    }

    public void setPageNo(Integer pageNo) {
        this.pageNo = pageNo;
    }

    public Integer getPageSize() {
        return pageSize;
    }

    public void setPageSize(Integer pageSize) {
        this.pageSize = pageSize;
    }

    public Integer getPageTotalCount() {
        return pageTotalCount;
    }

    public void setPageTotalCount(Integer pageTotalCount) {
        this.pageTotalCount = pageTotalCount;
    }

    public Integer getTotalRow() {
        return totalRow;
    }

    public void setTotalRow(Integer totalRow) {
        this.totalRow = totalRow;
    }

    public List<T> getItems() {
        return items;
    }

    public void setItems(List<T> items) {
        this.items = items;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }
}

