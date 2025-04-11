<%--jsp文件头--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="x-ua-compatible" content="ie=edge"/>
    <title>韩顺平教育-家居网购~</title>
    <base href="<%=request.getContextPath() + "/"%>">
    <!-- 移动端适配 -->
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no"/>
    <link rel="stylesheet" href="assets/css/vendor/vendor.min.css"/>
    <link rel="stylesheet" href="assets/css/plugins/plugins.min.css"/>
    <link rel="stylesheet" href="assets/css/style.min.css">
    <script type="text/javascript" src="script/jquery-3.6.0.min.js"></script>
    <script>
        $(function () {
            // 监听所有带有类名 "add-to-cart" 的按钮的点击事件
            $("button.add-to-cart").click(function () {
                // 获取当前点击按钮的 `furnId`（家具 ID）
                var furnId = $(this).attr("furnId");

                // 之前的方式：直接跳转到 `cartServlet`，导致整个页面刷新（性能较低）
                // location.href = "cartServlet?action=addItem&id=" + furnId;

                // 现在改用 AJAX 发送请求，以提高性能并避免整页刷新
                $.getJSON("cartServlet", {  // 发送 AJAX `GET` 请求，使用 `getJSON` 方法简化 JSON 处理
                    "action": "addItemByAjax",  // 指定 `Servlet` 的 `action` 参数，表示添加商品到购物车
                    "id": furnId  // 传递商品 ID
                }, function (data) {  // 回调函数，处理服务器返回的 JSON 数据
                    console.log("data", data);  // 在控制台打印返回的数据，方便调试
                    if (data.url == undefined) {
                        // ✅ 没有返回 `url`，表示用户已经登录，正常返回购物车数据
                        // 🚀 更新购物车的商品数量（局部刷新，不刷新整个页面）
                        $("span.header-action-num").text(data.cartTotalCount);
                    } else {
                        // 🚨 服务器返回 `url`，说明用户未登录，需要跳转到登录页面
                        // 💡 这里 `data.url` 可能是 "views/member/login.jsp"
                        location.href = data.url; // 📌 让浏览器跳转到服务器返回的 URL
                    }


                });
            });
        });



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
                                <form class="action-form" action="customerFurnServlet">
                                    <input type="hidden" name="action" value="pageByName">


                                    <input class="form-control" placeholder="填入家居名稱" type="text" name="name">
                                    <button class="submit" type="submit"><i class="icon-magnifier"></i></button>
                                </form>
                            </div>
                        </div>
                        <!-- Single Wedge Start -->
                        <%--根据用户登录的状态,显示不同的菜单
                            老师思路; 根据session有没有 member对象来判断
                        --%>
                        <c:if test="${empty sessionScope.loginMember}">
                            <div class="header-bottom-set dropdown">
                                <a href="views/member/login.jsp">登录|注册</a>
                            </div>
                        </c:if>
                        <c:if test="${not empty sessionScope.loginMember}">
                            <div class="header-bottom-set dropdown">
                                <a>欢迎: ${sessionScope.loginMember.username}</a>
                            </div>
                            <div class="header-bottom-set dropdown">
                                <a href="#">订单管理</a>
                            </div>
                            <div class="header-bottom-set dropdown">
                                <a href="memberServlet?action=logout">安全退出</a>
                            </div>
                        </c:if>
                        <!-- Single Wedge End -->
                        <a href="views/cart/cart.jsp"
                           class="header-action-btn header-action-btn-cart pr-0">
                            <i class="icon-handbag"> 购物车</i>
                            <%--${sessionScope.cart.totalCount} 本质就是调用cart对象getTotalCount--%>
                            <span class="header-action-num">${sessionScope.cart.totalCount}</span>
                        </a>
                        <a href="#offcanvas-mobile-menu"
                           class="header-action-btn header-action-btn-menu offcanvas-toggle d-lg-none">
                            <i class="icon-menu"></i>
                        </a>
                    </div>
                </div>
                <!-- Header Action End -->
            </div>
        </div>
    </div>
    <!-- Header Bottom  End -->
    <!-- Header Bottom  Start 手机端的header -->
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
<br/>
<!-- Header Area End  -->

<!-- OffCanvas Cart Start 弹出cart -->
<!-- OffCanvas Cart End -->

<!-- OffCanvas Menu Start 处理手机端 -->
<!-- OffCanvas Menu End -->

<!-- Product tab Area Start -->
<div class="section product-tab-area">
    <div class="container">
        <div class="row">
            <div class="col">
                <div class="tab-content">
                    <!-- 1st tab start -->
                    <div class="tab-pane fade show active" id="tab-product-new-arrivals">
                        <div class="row">
                            <c:forEach items="${requestScope.page.items}" var="furn">
                                <div class="col-lg-3 col-md-6 col-sm-6 col-xs-6 mb-6" data-aos="fade-up"
                                     data-aos-delay="200">
                                    <!-- Single Prodect -->
                                    <div class="product">
                                        <div class="thumb">
                                            <a href="shop-left-sidebar.html" class="image">
                                                <img src="${furn.imgPath}" alt="Product"/>
                                                <img class="hover-image" src="${furn.imgPath}"
                                                     alt="Product"/>
                                            </a>
                                            <span class="badges">
                                                <span class="new">New</span>
                                            </span>
                                            <div class="actions">
                                                <a href="#" class="action wishlist" data-link-action="quickview"
                                                   title="Quick view" data-bs-toggle="modal"
                                                   data-bs-target="#exampleModal"><i
                                                        class="icon-size-fullscreen"></i></a>
                                            </div>
                                            <c:if test="${furn.stock>0}">
                                                <button title="Add To Cart" class="add-to-cart" furnId="${furn.id}">Add
                                                    To Cart
                                                </button>
                                            </c:if>

                                            <c:if test="${furn.stock == 0}">
                                                <div class="alert alert-warning">該商品暫時缺貨，無法添加到購物車！</div>
                                            </c:if>

                                            <!-- 錯誤提示應只針對當前商品 -->
                                            <c:if test="${not empty msg && msgFurnId == furn.id}">
                                                <div class="alert alert-danger">${msg}</div>
                                            </c:if>


                                        </div>
                                        <div class="content">
                                            <h5 class="title">
                                                <a href="shop-left-sidebar.html">${furn.name} </a></h5>
                                            <span class="price">
                                                <span class="new">家居:　${furn.name}</span>
                                            </span>
                                            <span class="price">
                                                <span class="new">厂商:　${furn.maker}</span>
                                            </span>
                                            <span class="price">
                                                <span class="new">价格:　￥${furn.price}</span>
                                            </span>
                                            <span class="price">
                                                <span class="new">销量:　${furn.sales}</span>
                                            </span>
                                            <span class="price">
                                                <span class="new">库存:　${furn.stock}</span>
                                            </span>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                    <!-- 1st tab end -->
                </div>
            </div>
        </div>
    </div>
</div>
<!-- Pagination Area Start 分页导航条-->
<div class="pro-pagination-style text-center mb-md-30px mb-lm-30px mt-6"
     data-aos="fade-up">
    <ul>
        <c:if test="${requestScope.page.pageNo>1}">
            <%--            <li><a href="customerFurnServlet?action=page&pageNo=${requestScope.page.pageNo-1}">上一頁</a></li>--%>
            <li><a href="${requestScope.page.url}&pageNo=${requestScope.page.pageNo-1}">上一頁</a></li>
        </c:if>

        <c:set var="begin" value="1"/>
        <c:set var="end" value="${requestScope.page.pageTotalCount}"/>

        <c:forEach begin="${begin}" end="${end}" var="i">
            <c:if test="${requestScope.page.pageNo==i}">
                <li><a class="active" href="${requestScope.page.url}&pageNo=${i}">${i}</a></li>
            </c:if>

            <c:if test="${requestScope.page.pageNo!=i}">
                <li><a href="${requestScope.page.url}&pageNo=${i}">${i}</a></li>
            </c:if>

        </c:forEach>

        <%--        <li><a class="active" href="#">3</a></li>--%>
        <%--        <li><a href="#">4</a></li>--%>
        <%--        <li><a href="#">5</a></li>--%>

        <c:if test="${requestScope.page.pageNo<requestScope.page.pageTotalCount}">
            <li><a href="${requestScope.page.url}&pageNo=${requestScope.page.pageNo+1}">下一頁</a></li>
        </c:if>
        <li><a href="#">共${requestScope.page.pageTotalCount}頁</a></li>
    </ul>
</div>
<!-- Pagination Area End -->
<!-- Product tab Area End -->

<!-- Banner Section Start -->
<div class="section pb-100px pt-100px">
    <div class="container">
        <!-- Banners Start -->
        <div class="row">
            <!-- Banner Start -->
            <div class="col-lg-6 col-12 mb-md-30px mb-lm-30px" data-aos="fade-up" data-aos-delay="200">
                <a href="shop-left-sidebar.html" class="banner">
                    <img src="assets/images/banner/1.jpg" alt=""/>
                </a>
            </div>
            <!-- Banner End -->

            <!-- Banner Start -->
            <div class="col-lg-6 col-12" data-aos="fade-up" data-aos-delay="400">
                <a href="shop-left-sidebar.html" class="banner">
                    <img src="assets/images/banner/2.jpg" alt=""/>
                </a>
            </div>
            <!-- Banner End -->
        </div>
        <!-- Banners End -->
    </div>
</div>
<!-- Banner Section End -->
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
                                        <li class="li"><a class="single-link" href="about.html">关于我们</a></li>
                                        <li class="li"><a class="single-link" href="#">交货信息</a></li>
                                        <li class="li"><a class="single-link" href="privacy-policy.html">隐私与政策</a>
                                        </li>
                                        <li class="li"><a class="single-link" href="#">条款和条件</a></li>
                                        <li class="li"><a class="single-link" href="#">制造</a></li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- End single blog -->
                    <!-- Start single blog -->
                    <div class="col-md-6 col-lg-2 col-sm-6 mb-lm-30px" data-aos="fade-up" data-aos-delay="600">
                        <div class="single-wedge">
                            <h4 class="footer-herading">我的账号</h4>
                            <div class="footer-links">
                                <div class="footer-row">
                                    <ul class="align-items-center">
                                        <li class="li"><a class="single-link" href="my-account.html">我的账号</a>
                                        </li>
                                        <li class="li"><a class="single-link" href="cart.html">我的购物车</a></li>
                                        <li class="li"><a class="single-link" href="login.jsp">登录</a></li>
                                        <li class="li"><a class="single-link" href="wishlist.html">感兴趣的</a></li>
                                        <li class="li"><a class="single-link" href="checkout.html">结账</a></li>
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
                        <p class="copy-text">Copyright &copy; 2021 韩顺平教育~</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- Footer Area End -->

<!-- Modal 放大查看家居 -->
<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close"><span
                        aria-hidden="true">x</span></button>
            </div>
            <div class="modal-body">
                <div class="row">
                    <div class="col-md-5 col-sm-12 col-xs-12 mb-lm-30px mb-sm-30px">
                        <!-- Swiper -->
                        <div class="swiper-container gallery-top mb-4">
                            <div class="swiper-wrapper">
                                <div class="swiper-slide">
                                    <img class="img-responsive m-auto" src="assets/images/product-image/1.jpg" alt="">
                                </div>
                                <div class="swiper-slide">
                                    <img class="img-responsive m-auto" src="assets/images/product-image/2.jpg" alt="">
                                </div>
                                <div class="swiper-slide">
                                    <img class="img-responsive m-auto" src="assets/images/product-image/3.jpg" alt="">
                                </div>
                                <div class="swiper-slide">
                                    <img class="img-responsive m-auto" src="assets/images/product-image/4.jpg" alt="">
                                </div>
                                <div class="swiper-slide">
                                    <img class="img-responsive m-auto" src="assets/images/product-image/5.jpg" alt="">
                                </div>
                            </div>
                        </div>
                        <div class="swiper-container gallery-thumbs slider-nav-style-1 small-nav">
                            <div class="swiper-wrapper">
                                <div class="swiper-slide">
                                    <img class="img-responsive m-auto" src="assets/images/product-image/1.jpg" alt="">
                                </div>
                                <div class="swiper-slide">
                                    <img class="img-responsive m-auto" src="assets/images/product-image/2.jpg" alt="">
                                </div>
                                <div class="swiper-slide">
                                    <img class="img-responsive m-auto" src="assets/images/product-image/3.jpg" alt="">
                                </div>
                                <div class="swiper-slide">
                                    <img class="img-responsive m-auto" src="assets/images/product-image/4.jpg" alt="">
                                </div>
                                <div class="swiper-slide">
                                    <img class="img-responsive m-auto" src="assets/images/product-image/5.jpg" alt="">
                                </div>
                            </div>
                            <!-- Add Arrows -->
                            <div class="swiper-buttons">
                                <div class="swiper-button-next"></div>
                                <div class="swiper-button-prev"></div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-7 col-sm-12 col-xs-12">
                        <div class="product-details-content quickview-content">
                            <h2>Originals Kaval Windbr</h2>
                            <p class="reference">Reference:<span> demo_17</span></p>
                            <div class="pro-details-rating-wrap">
                                <div class="rating-product">
                                    <i class="ion-android-star"></i>
                                    <i class="ion-android-star"></i>
                                    <i class="ion-android-star"></i>
                                    <i class="ion-android-star"></i>
                                    <i class="ion-android-star"></i>
                                </div>
                                <span class="read-review"><a class="reviews" href="#">Read reviews (1)</a></span>
                            </div>
                            <div class="pricing-meta">
                                <ul>
                                    <li class="old-price not-cut">$18.90</li>
                                </ul>
                            </div>
                            <p class="quickview-para">Lorem ipsum dolor sit amet, consectetur adipisic elit eiusm tempor
                                incidid ut labore et dolore magna aliqua. Ut enim ad minim venialo quis nostrud
                                exercitation ullamco</p>
                            <div class="pro-details-size-color">
                                <div class="pro-details-color-wrap">
                                    <span>Color</span>
                                    <div class="pro-details-color-content">
                                        <ul>
                                            <li class="blue"></li>
                                            <li class="maroon active"></li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                            <div class="pro-details-quality">
                                <div class="cart-plus-minus">
                                    <input class="cart-plus-minus-box" type="text" name="qtybutton" value="1"/>
                                </div>
                                <div class="pro-details-cart btn-hover">
                                    <button class="add-cart btn btn-primary btn-hover-primary ml-4"> Add To
                                        Cart
                                    </button>
                                </div>
                            </div>
                            <div class="pro-details-wish-com">
                                <div class="pro-details-wishlist">
                                    <a href="wishlist.html"><i class="ion-android-favorite-outline"></i>Add to
                                        wishlist</a>
                                </div>
                                <div class="pro-details-compare">
                                    <a href="compare.html"><i class="ion-ios-shuffle-strong"></i>Add to compare</a>
                                </div>
                            </div>
                            <div class="pro-details-social-info">
                                <span>Share</span>
                                <div class="social-info">
                                    <ul>
                                        <li>
                                            <a href="#"><i class="ion-social-facebook"></i></a>
                                        </li>
                                        <li>
                                            <a href="#"><i class="ion-social-twitter"></i></a>
                                        </li>
                                        <li>
                                            <a href="#"><i class="ion-social-google"></i></a>
                                        </li>
                                        <li>
                                            <a href="#"><i class="ion-social-instagram"></i></a>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- Modal end -->

<!-- Use the minified version files listed below for better performance and remove the files listed above -->
<script src="assets/js/vendor/vendor.min.js"></script>
<script src="assets/js/plugins/plugins.min.js"></script>
<!-- Main Js -->
<script src="assets/js/main.js"></script>
</body>
</html>