#  Jiaju Mall 家具商城 - Java Web 後端專案

本專案為使用 Java EE 技術實作的家具商城後台系統，採用經典三層架構設計（MVC + Service + DAO），透過 Servlet、JSP 與 JDBC 完成會員註冊、商品管理、購物車與訂單處理功能。

此專案是訓練 Java Web 全端流程開發能力的實作案例，適合作為履歷作品展示。

---

##  專案亮點

-  採用 DAO + Service + Servlet 分層架構，職責分明
-  手寫 SQL，搭配 Druid 連線池，提高查詢效率
-  實作登入驗證、交易處理 Filter，強化安全性與邏輯控管
-  支援購物車動態增減與訂單統整計算
-  完整 MVC 分層，支援多功能模組與擴充彈性

---

##  技術棧（Tech Stack）

| 分類       | 技術                           |
|------------|--------------------------------|
| 語言       | Java 8+                        |
| 前端       | JSP + HTML                     |
| 後端       | Servlet + JDBC                 |
| 架構       | MVC（三層分離）                |
| 資料庫     | MySQL 5.7+                     |
| 連線池     | Druid                          |
| 開發工具   | IntelliJ IDEA + Tomcat         |
| 測試       | JUnit（DAO、Service 單元測試） |

---

##  專案目錄結構（部分）

```
jiaju_mall/
├── druid.properties                     # 資料庫連線設定
└── com/hspedu/furns/
    ├── dao/impl/                         # DAO 實作類別
    ├── service/impl/                     # Service 實作類別
    ├── entity/                           # 資料模型：Furn, Order, Member...
    ├── filter/                           # 登入/權限/交易 Filter
    ├── utils/                            # JDBC 與共用工具類
    ├── web/WEB-INF/                      # 前端 JSP 與 Servlet 設定
```

---

##  架構設計：MVC + 三層分離

### ➤ Controller 層（Servlet）
- 接收 HTTP 請求（如 /login, /register, /furn）
- 驗證輸入參數，調用 Service 方法
- 處理導頁、回傳 JSP 資料

### ➤ Service 層
- 管理商業邏輯（註冊、登入、交易、下單）
- 呼叫 DAO 操作資料庫
- 控制事務與業務資料轉換

### ➤ DAO 層（資料存取）
- 撰寫 SQL 查詢，進行 CRUD 操作
- 封裝 JDBC 操作，整合 Druid 連線池

### ➤ Entity 模型層
- 包含 Furn（商品）、Member（會員）、Order 等 POJO
- 對應資料表結構欄位

---

##  主要功能模組

-  會員註冊、登入驗證
-  商品 CRUD + 分頁查詢
-  購物車動態更新、總價計算
-  建立訂單並查詢明細
-  後台系統管理與權限控制（透過 Filter）

---

## ⚙ 環境部署與啟動

1. 將專案匯入 IntelliJ IDEA
2. 配置 MySQL，修改 `src/druid.properties` 中的帳密與連線資訊
3. 匯入 SQL 腳本建立資料表
4. 配置 Tomcat 並啟動
5. 在瀏覽器中輸入 `http://localhost:8080/jiaju_mall`

---



##  資料表與 ER 圖

> 資料表包含：`user`, `product`, `order`, `order_item`

![ER Diagram](./springboot-er.png.png)
