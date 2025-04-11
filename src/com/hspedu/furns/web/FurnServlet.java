package com.hspedu.furns.web;

import com.hspedu.furns.entity.Furn;
import com.hspedu.furns.entity.Page;
import com.hspedu.furns.service.FurnService;
import com.hspedu.furns.service.impl.FurnServiceImpl;
import com.hspedu.furns.utils.DataUtils;
import com.hspedu.furns.utils.WebUtils;
import org.apache.commons.beanutils.BeanUtils;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.File;
import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.math.BigDecimal;
import java.util.List;
import java.util.UUID;

public class FurnServlet extends BasicServlet {
    private FurnService furnService = new FurnServiceImpl();

    protected void list(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Furn> furns = furnService.queryFurns();
        request.setAttribute("furns", furns);
        request.getRequestDispatcher("/views/manage/furn_manage.jsp").forward(request, response);
    }


    protected void add(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
//        String name = req.getParameter("name");
//        String maker = req.getParameter("maker");
//        String price = req.getParameter("price");
//        String sales = req.getParameter("sales");
//        String stock = req.getParameter("stock");
//我們可以
        //3. 若不想用規則運算式來驗證，以下可以示範轉換驗證（sales欄位）
//        try {
//            Integer.parseInt(sales);
//        } catch (NumberFormatException e) {
//            req.setAttribute("mes", "sales數據格式錯誤");
//            req.getRequestDispatcher("/views/manage/furn_add.jsp").forward(req, resp);
//            return;
//        }

//        在您的程式碼中，return; 的意圖是：
//
//        當捕獲異常時，停止執行後續代碼
//        如果輸入的 sales 格式非法，跳轉到錯誤提示頁面後直接退出，不執行添加操作。
//
//        控制程式的執行流
//        保證程式執行邏輯清晰，當遇到數據錯誤時，立刻停止該分支的執行，避免進一步執行無效操作。

//        Furn furn =
//                null;
//        try {
//            furn = new Furn(null, name, maker, new BigDecimal(price), new Integer(sales), new Integer(stock), "assets/images/product-image/default.jpg");
//        } catch (NumberFormatException e) {
//            req.setAttribute("mes", "數據格式錯誤");
//            req.getRequestDispatcher("/views/manage/furn_add.jsp").forward(req, resp);
//            return;
//        }
//        Furn furn = new Furn();
//
//        try {
//            BeanUtils.populate(furn,req.getParameterMap());
//        } catch (Exception e) {
//            throw new RuntimeException(e);
//        }
//        System.out.println(furn);

//自動將提交的資料，封裝到Furn物件
        Furn furn = DataUtils.copyParamToBean(req.getParameterMap(), new Furn());
        furnService.add(furn);

        //請求轉發到家居顯示頁面, 即需要重新走一下 FurnServlet-list方法
        //req.getRequestDispatcher("/manage/furnServlet?action=list").forward(req, resp);
        //
        //老師說明: 因為這裡使用請求轉發, 當使用者刷新頁面時, 會重新發出一次添加請求
        //就會造成資料重複提交： 解決方案使用 重定向即可.
        //因為重定向實際是讓流覽器重新發請求, 所以我們回送的url , 是一個完整url
//        req.getRequestDispatcher("/manage/furnServlet?action=list").forward(req,resp);
//        resp.sendRedirect(req.getContextPath() + "/manage/furnServlet?action=list");
        resp.sendRedirect(req.getContextPath() + "/manage/furnServlet?action=page&pageNo="+req.getParameter("pageNo"));
    }


    protected void delete(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // 獲取請求中的 "id" 參數
        String id = req.getParameter("id");

        // 將 "id" 轉換為整數，如果轉換失敗則預設值為 0
        int i = DataUtils.parseInt(id, 0);

        // 調用服務層方法刪除家居
        furnService.deleteFurnById(i);

        // 重定向到家居清單頁面，刷新資料
//        resp.sendRedirect(req.getContextPath() + "/manage/furnServlet?action=list");
        resp.sendRedirect(req.getContextPath() + "/manage/furnServlet?action=page&pageNo="+req.getParameter("pageNo"));

    }


    protected void showFurn(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int id = DataUtils.parseInt(req.getParameter("id"), 0);
        Furn furn = furnService.queryFurnById(id);
        //將furn放入到request域中
        req.setAttribute("furn", furn);
        //老師說明: 如果請求帶來的參數 pageNo=1 , 而且是請求轉發到下一個頁面, 在下一個頁面可以通過 param.pageNo
        //System.out.println("furn=>" + furn);
        //請求轉發到
        req.getRequestDispatcher("/views/manage/furn_update.jsp")
                .forward(req, resp);
    }

    /**
     * 處理更新家居資訊的請求，包含解析 multipart/form-data 表單中
     * 的文本資料及檔上傳（圖片），並更新資料庫中的家居資料
     *
     * @param req  HttpServletRequest 對象
     * @param resp HttpServletResponse 對象
     * @throws ServletException 異常處理
     * @throws IOException      輸入輸出異常處理
     */
    protected void update(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // 注意：如果表單使用 enctype="multipart/form-data"，直接使用 req.getParameter("id") 可能無法正確獲取資料
        int id = DataUtils.parseInt(req.getParameter("id"), 0);
        // 根據 id 從資料庫中查詢對應的家居資料 Furn
        Furn furn = furnService.queryFurnById(id);
        // TODO: 可加入判斷，若 furn 為 null 則不進一步處理

        // 檢查請求是否為檔上傳表單（multipart/form-data 格式）
        if (ServletFileUpload.isMultipartContent(req)) {
            // 創建 DiskFileItemFactory 對象，用以管理文件上傳過程中的暫存（緩存）機制
            DiskFileItemFactory diskFileItemFactory = new DiskFileItemFactory();
            // 創建 ServletFileUpload 對象，負責解析上傳的 multipart/form-data 請求
            ServletFileUpload servletFileUpload = new ServletFileUpload(diskFileItemFactory);
            // 設置字元編碼為 utf-8，避免檔案名或文本內容出現中文亂碼
            servletFileUpload.setHeaderEncoding("utf-8");

            try {
                // 將表單數據（包括普通文本及檔）解析為 FileItem 的集合
                List<FileItem> list = servletFileUpload.parseRequest(req);
                // 遍歷每個 FileItem，分別處理普通文本和檔數據
                for (FileItem fileItem : list) {
                    // 若該 FileItem 為普通表單欄位（非檔）
                    if (fileItem.isFormField()) {
                        // 根據欄位名稱判斷並設置 Furn 對象的相應屬性
                        if ("name".equals(fileItem.getFieldName())) { // 家居名稱
                            furn.setName(fileItem.getString("utf-8"));
                        } else if ("maker".equals(fileItem.getFieldName())) { // 製造商
                            furn.setMaker(fileItem.getString("utf-8"));
                        } else if ("price".equals(fileItem.getFieldName())) { // 價格，轉換為 BigDecimal
                            furn.setPrice(new BigDecimal(fileItem.getString()));
                        } else if ("sales".equals(fileItem.getFieldName())) { // 銷量，轉換為 Integer
                            furn.setSales(new Integer(fileItem.getString()));
                        } else if ("stock".equals(fileItem.getFieldName())) { // 庫存，轉換為 Integer
                            furn.setStock(new Integer(fileItem.getString()));
                        }
                    } else { // 處理檔欄位（例如上傳的圖片）
                        // 獲取上傳檔的原始檔案名
                        String name = fileItem.getName();
                        // 如果用戶有選擇新圖片（檔案名非空）
                        if (!"".equals(name)) {
                            // 1. 指定上傳圖片存放目錄，這裡使用 WebUtils.FURN_IMG_DIRECTORY 常量（如 "assets/images/furn"）
                            String filePath = "/" + WebUtils.FURN_IMG_DIRECTORY;
                            // 2. 取得該目錄在服務器上的真實路徑
                            String fileRealPath = req.getServletContext().getRealPath(filePath);
                            // 3. 創建一個 File 對象表示該目錄，若不存在則創建
                            File fileRealPathDirectory = new File(fileRealPath);
                            if (!fileRealPathDirectory.exists()) { // 檢查目錄是否存在
                                fileRealPathDirectory.mkdirs(); // 遞迴創建所有不存在的目錄
                            }

                            // 4. 處理檔案名：在原始檔案名前添加 UUID 與時間戳，確保檔案名唯一，避免衝突
                            name = UUID.randomUUID().toString() + "_" + System.currentTimeMillis() + "_" + name;
                            // 使用 fileRealPathDirectory 的 toString() 方法隱式轉換為字串，拼接生成完整檔路徑
                            String fileFullPath = fileRealPathDirectory + "/" + name;
                            // 將上傳的檔寫入指定位置，實際保存到磁碟上
                            fileItem.write(new File(fileFullPath));
                            // 關閉 fileItem 的輸出流，釋放資源
                            fileItem.getOutputStream().close();

                            // 更新 Furn 對象的圖片路徑屬性，使其指向新上傳的圖片
                            furn.setImgPath(WebUtils.FURN_IMG_DIRECTORY + "/" + name);
                            // TODO: 可以在此處添加刪除原有圖片的邏輯，避免磁碟空間浪費
                        }
                    }
                }
            } catch (Exception e) {
                // 捕捉並輸出異常資訊，有助於錯誤除錯
                e.printStackTrace();
            }
        } else {
            // 如果請求並非檔上傳表單，則輸出提示資訊
            System.out.println("不是檔表單...");
        }

        // 調用 FurnService 更新資料庫中對應的家居資料
        furnService.updateFurn(furn);
        // 更新完成後，請求轉發到更新成功頁面 update_ok.jsp
        req.getRequestDispatcher("/views/manage/update_ok.jsp").forward(req, resp);
    }

//    protected void update(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
//        Furn furn = DataUtils.copyParamToBean(req.getParameterMap(), new Furn());
//        furnService.updateFurn(furn);
//
////        resp.sendRedirect(req.getContextPath() + "/manage/furnServlet?action=list");
//        //這裡我們考慮分頁,並帶上pageNo, 老師理解: 這裡同學比較吃力.
//        resp.sendRedirect(req.getContextPath() + "/manage/furnServlet?action=page&pageNo="+req.getParameter("pageNo"));
//
//    }


    protected void page(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int pageNo = DataUtils.parseInt(req.getParameter("pageNo"), 1);
        int pageSize = DataUtils.parseInt(req.getParameter("pageSize"), Page.PAGE_SIZE);

        Page<Furn> page = furnService.page(pageNo, pageSize);
        req.setAttribute("page",page);
        req.getRequestDispatcher("/views/manage/furn_manage.jsp").forward(req,resp);



    }
}

