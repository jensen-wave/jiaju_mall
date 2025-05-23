<%--jsp文件頭--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="x-ua-compatible" content="ie=edge"/>
    <title>家居網購</title>
    <base href="<%=request.getContextPath() + "/"%>">
    <!-- 移動端適配 -->
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no"/>
    <link rel="stylesheet" href="assets/css/vendor/vendor.min.css"/>
    <link rel="stylesheet" href="assets/css/plugins/plugins.min.css"/>
    <link rel="stylesheet" href="assets/css/style.min.css">
    <%--引入jquery--%>
    <script type="text/javascript" src="script/jquery-3.6.0.min.js"></script>
    <script>
        $(function () {
//綁定點擊事件
            $("a.deleteCss").click(function () {
                //獲取到要刪除的家居的名字
                var furnName = $(this).parent().parent().find("td:eq(1)").text();

                //老韓解讀
                //1. confirm方法會彈出一個確認視窗
                //2. 點擊確定，返回true
                //3. 點擊取消，返回false
                return confirm("你確定要刪除【" + furnName + "】?");
            })
        })
    </script>
</head>

<body>
<!-- Header Area start  -->
<div class="header section">
    <!-- Header Top  End -->
    <!-- Header Bottom  Start -->
    <div class="header-bottom d-none d-lg-block">
        <div class="container position-relative">
            <div class="row align-self-center">
                <!-- Header Logo Start -->
                <div class="col-auto align-self-center">
                    <div class="header-logo">
                        <a href="index.html"><img src="assets/images/logo/logo.png" alt="Site Logo"/></a>
                    </div>
                </div>
                <!-- Header Logo End -->

                <!-- Header Action Start -->
                <div class="col align-self-center">
                    <div class="header-actions">
                        <div class="header_account_list">
                            <a href="javascript:void(0)" class="header-action-btn search-btn"><i
                                    class="icon-magnifier"></i></a>
                            <div class="dropdown_search">
                                <form class="action-form" action="#">
                                    <input class="form-control" placeholder="Enter your search key" type="text">
                                    <button class="submit" type="submit"><i class="icon-magnifier"></i></button>
                                </form>
                            </div>
                        </div>
                        <!-- Single Wedge Start -->
                        <div class="header-bottom-set dropdown">
                            <a href="#">後臺管理</a>
                        </div>

                        <div class="header-bottom-set dropdown">
                            <a href="views/manage/furn_add.jsp?pageNo=${requestScope.page.pageNo}">添加家居</a>
                        </div>

                    </div>
                </div>
                <!-- Header Action End -->
            </div>
        </div>
    </div>
    <!-- Header Bottom  End -->
    <!-- Header Bottom  Start 手機端的header -->
    <div class="header-bottom d-lg-none sticky-nav bg-white">
        <div class="container position-relative">
            <div class="row align-self-center">
                <!-- Header Logo Start -->
                <div class="col-auto align-self-center">
                    <div class="header-logo">
                        <a href="index.html"><img width="280px" src="assets/images/logo/logo.png" alt="Site Logo"/></a>
                    </div>
                </div>
                <!-- Header Logo End -->
            </div>
        </div>
    </div>
    <!-- Main Menu Start -->
    <div style="width: 100%;height: 50px;background-color: black"></div>
    <!-- Main Menu End -->
</div>
<!-- Cart Area Start -->
<div class="cart-main-area pt-100px pb-100px">
    <div class="container">
        <h3 class="cart-page-title">家居後臺管理</h3>
        <div class="row">
            <div class="col-lg-12 col-md-12 col-sm-12 col-12">
                <form action="#">
                    <div class="table-content table-responsive cart-table-content">
                        <table>
                            <thead>
                            <tr>
                                <th>圖片</th>
                                <th>家居名</th>
                                <th>商家</th>
                                <th>價格</th>
                                <th>銷量</th>
                                <th>庫存</th>
                                <th>操作</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach items="${requestScope.page.items}" var="furn">


                                <tr>
                                    <td class="product-thumbnail">
                                        <a href="#"><img class="img-responsive ml-3" src="${furn.imgPath}"
                                                         alt=""/></a>
                                    </td>
                                    <td class="product-name"><a href="#">${furn.name}</a></td>
                                    <td class="product-name"><a href="#">${furn.maker}</a></td>
                                    <td class="product-price-cart"><span class="amount">${furn.price}</span></td>
                                    <td class="product-quantity">
                                            ${furn.sales}
                                    </td>
                                    <td class="product-quantity">
                                            ${furn.stock}
                                    </td>
                                    <td class="product-remove">
                                        <a href="manage/furnServlet?action=showFurn&id=${furn.id}&pageNo=${requestScope.page.pageNo}"><i
                                                class="icon-pencil"></i></a>
                                        <a class="deleteCss" href="manage/furnServlet?action=delete&id=${furn.id}&pageNo=${requestScope.page.pageNo}"><i
                                                class="icon-close"></i></a>
                                    </td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </form>
            </div>
        </div>
        <!-- Pagination Area Start 分頁導航條-->
        <div class="pro-pagination-style text-center mb-md-30px mb-lm-30px mt-6"
             data-aos="fade-up">
            <ul>
                <%--如果當前頁 > 1 , 就顯示上一頁--%>
                <c:if test="${requestScope.page.pageNo>1}">
                    <li><a href="manage/furnServlet?action=page&pageNo=${requestScope.page.pageNo-1}">上一頁</a></li>
                </c:if>
                <%--                <li><a class="active" href="#">3</a></li>--%>
                <%--                <li><a href="#">4</a></li>--%>
                <%--                <li><a href="#">5</a></li>--%>

                <c:set var="begin" value="1"/>
                <c:set var="end" value="${requestScope.page.pageTotalCount}"/>

                <c:forEach begin="${begin}" end="${end}" var="i">
                    <c:if test="${i==requestScope.page.pageNo}">
                        <li><a class="active" href="manage/furnServlet?action=page&pageNo=${i}">${i}</a></li>
                    </c:if>

                    <c:if test="${i!=requestScope.page.pageNo}">
                        <li><a href="manage/furnServlet?action=page&pageNo=${i}">${i}</a></li>
                    </c:if>
                </c:forEach>

                <%--如果當前頁 < 總頁數 , 就顯示下一頁--%>
                <c:if test="${requestScope.page.pageNo<requestScope.page.pageTotalCount}">
                    <li><a href="manage/furnServlet?action=page&pageNo=${requestScope.page.pageNo+1}">下一頁</a></li>
                </c:if>

            </ul>
        </div>
        <!-- Pagination Area End -->
    </div>
</div>
<!-- Cart Area End -->

<!-- Footer Area Start -->
<div class="footer-area">
    <div class="footer-container">
        <div class="footer-top">
            <div class="container">
                <div class="row">
                    <!-- Start single blog -->
                    <!-- End single blog -->
                    <!-- Start single blog -->
                    <div class="col-md-6 col-sm-6 col-lg-3 mb-md-30px mb-lm-30px" data-aos="fade-up"
                         data-aos-delay="400">
                        <div class="single-wedge">
                            <h4 class="footer-herading">信息</h4>
                            <div class="footer-links">
                                <div class="footer-row">
                                    <ul class="align-items-center">
                                        <li class="li"><a class="single-link" href="about.html">關於我們</a></li>
                                        <li class="li"><a class="single-link" href="#">交貨信息</a></li>
                                        <li class="li"><a class="single-link" href="privacy-policy.html">隱私與政策</a>
                                        </li>
                                        <li class="li"><a class="single-link" href="#">條款和條件</a></li>
                                        <li class="li"><a class="single-link" href="#">製造</a></li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- End single blog -->
                    <!-- Start single blog -->
                    <div class="col-md-6 col-lg-2 col-sm-6 mb-lm-30px" data-aos="fade-up" data-aos-delay="600">
                        <div class="single-wedge">
                            <h4 class="footer-herading">我的帳號</h4>
                            <div class="footer-links">
                                <div class="footer-row">
                                    <ul class="align-items-center">
                                        <li class="li"><a class="single-link" href="my-account.html">我的帳號</a>
                                        </li>
                                        <li class="li"><a class="single-link" href="cart.html">我的購物車</a></li>
                                        <li class="li"><a class="single-link" href="login.html">登錄</a></li>
                                        <li class="li"><a class="single-link" href="wishlist.html">感興趣的</a></li>
                                        <li class="li"><a class="single-link" href="checkout.html">結帳</a></li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- End single blog -->
                    <!-- Start single blog -->
                    <div class="col-md-6 col-lg-3" data-aos="fade-up" data-aos-delay="800">

                    </div>
                    <!-- End single blog -->
                </div>
            </div>
        </div>
        <div class="footer-bottom">
            <div class="container">
                <div class="row flex-sm-row-reverse">
                    <div class="col-md-6 text-right">
                        <div class="payment-link">
                            <%--img src="#" 會去請求當前頁url http://localhost:8080/jiaju_mall/# --%>
                            <%--<img src="#" alt="">--%>
                        </div>
                    </div>
                    <div class="col-md-6 text-left">
                        <p class="copy-text">Copyright &copy; ~</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- Footer Area End -->
<script src="assets/js/vendor/vendor.min.js"></script>
<script src="assets/js/plugins/plugins.min.js"></script>
<!-- Main Js -->
<script src="assets/js/main.js"></script>
</body>
</html>

