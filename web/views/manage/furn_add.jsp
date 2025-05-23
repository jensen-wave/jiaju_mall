<%--jsp文件頭--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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

                        <!-- Single Wedge Start -->
                        <div class="header-bottom-set dropdown">
                            <a href="#">家居管理</a>
                        </div>
                        <div class="header-bottom-set dropdown">
                            <a href="#">訂單管理</a>
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
        <h3 class="cart-page-title">家居後臺管理-添加家居</h3>
        <%--顯示錯誤--%>
        ${requestScope.mes}
        <div class="row">
            <div class="col-lg-12 col-md-12 col-sm-12 col-12">
                <form action="manage/furnServlet" method="post">
                    <%--增加一個隱藏欄位給action-add--%>
                    <input type="hidden" name="action" value="add">
                    <input type="hidden" name="pageNo" value="${param.pageNo}">
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
                            <tr>
                                <td class="product-thumbnail">
                                    <a href="#"><img class="img-responsive ml-3"
                                                     src="assets/images/product-image/default.jpg"
                                                     alt=""/></a>
                                </td>
                                <td class="product-name"><input name="name" style="width: 60%" type="text"
                                                                value="Name"/></td>
                                <td class="product-name"><input name="maker" style="width: 90%" type="text"
                                                                value="螞蟻家居"/></td>
                                <td class="product-price-cart"><input name="price" style="width: 90%" type="text"
                                                                      value="60.00"/></td>
                                <td class="product-quantity">
                                    <input name="sales" style="width: 90%" type="text" value="100"/>
                                </td>
                                <td class="product-quantity">
                                    <input name="stock" style="width: 90%" type="text" value="80"/>
                                </td>
                                <td>
                                    <!--                                    <a href="#"><i class="icon-pencil"></i></a>-->
                                    <!--                                    <a href="#"><i class="icon-close"></i></a>-->
                                    <input type="submit"
                                           style="width: 90%;background-color: silver;border: silver;border-radius: 20%;"
                                           value="添加家居"/>
                                </td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                </form>
            </div>
        </div>
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
                            <img src="#" alt="">
                        </div>
                    </div>
                    <div class="col-md-6 text-left">
                        <p class="copy-text">Copyright &copy; 2021 韓順平教育~</p>
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

