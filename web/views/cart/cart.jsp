<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="x-ua-compatible" content="ie=edge"/>
    <title>家居網購</title>
    <base href="<%=request.getContextPath() + "/"%>">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no"/>
    <link rel="stylesheet" href="assets/css/vendor/vendor.min.css"/>
    <link rel="stylesheet" href="assets/css/plugins/plugins.min.css"/>
    <link rel="stylesheet" href="assets/css/style.min.css"/>
    <%--增加對+-的處理--%>
    <script type="text/javascript" src="script/jquery-3.6.0.min.js"></script>
    <script>
        $(function () {

            //給清空購物車綁定一個點擊事件
            $("a.clearCart").click(function (){
                //使用確認彈窗
                //返回一個false(取消刪除) 或者 true(刪除)
                return confirm("你確認要刪除購物車?");
            })

            //給刪除購物車綁定一個點擊事件
            $("a.delItem").click(function () {
                //獲取到你要刪除的家居名字
                //分析->jquery , 如果忘記了，去看老師講過的jquery
                //分析一下當前的html結構
                var furnName = $(this).parent().parent().find("td:eq(1)").text();
                //使用確認彈窗
                //返回一個false(取消刪除) 或者 true(刪除)
                return confirm("你確認要刪除【" + furnName + "】?");
            })

            /*----------------------------
        Cart Plus Minus Button
    ------------------------------ */
// 選擇所有帶有類名 cart-plus-minus 的元素，並將其存入變數
            var CartPlusMinus = $(".cart-plus-minus");
            // 先清除可能存在的按鈕
            CartPlusMinus.find('.qtybutton').remove();
// 在 cart-plus-minus 的開頭添加一個減號按鈕 <div class="dec qtybutton">-</div>
            CartPlusMinus.prepend('<div class="dec qtybutton">-</div>');

// 在 cart-plus-minus 的末尾添加一個加號按鈕 <div class="inc qtybutton">+</div>
            CartPlusMinus.append('<div class="inc qtybutton">+</div>');

// 綁定點擊事件到所有帶有類名 qtybutton 的按鈕
            $(".qtybutton").on("click", function () {

                // 獲取當前點擊的按鈕並儲存到變數 $button
                var $button = $(this);

                // 獲取當前按鈕父元素中的 <input> 標籤值，即當前商品數量
                var oldValue = $button.parent().find("input").val();

                // 如果點擊的是加號按鈕
                if ($button.text() === "+") {
                    // 將當前值轉為浮點數並加 1
                    var newVal = parseFloat(oldValue) + 1;
                } else {
                    // 如果點擊的是減號按鈕，並且當前值大於 1
                    if (oldValue > 1) {
                        // 將當前值轉為浮點數並減 1
                        var newVal = parseFloat(oldValue) - 1;
                    } else {
                        // 如果當前值小於或等於 1，設置為 1（不能減到 0 以下）
                        var newVal = 1;
                    }
                }

                // 將計算後的新值設定回輸入框
                $button.parent().find("input").val(newVal);

                // 獲取輸入框中自定義的 furnId 屬性值（商品 ID）
                var frunId = $button.parent().find("input").attr("furnId");

                // 發送請求至後端，修改購物車中商品數量
                location.href = "cartServlet?action=updateCount&count=" + newVal + "&id=" + frunId;
            });


        })


    </script>
</head>

<body>
<!-- Header Area start  -->
<div class="header section">
    <!-- Header Top Message Start -->
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
                        <div class="header-bottom-set dropdown">
                            <a>歡迎:${sessionScope.loginMember.username}</a>
                        </div>
                        <div class="header-bottom-set dropdown">
                            <a href="#">訂單管理</a>
                        </div>
                        <div class="header-bottom-set dropdown">
                            <a href="#">安全退出</a>
                        </div>
                    </div>
                </div>
                <!-- Header Action End -->
            </div>
        </div>
    </div>
    <!-- Header Bottom  Start 手機端的header -->
    <div class="header-bottom d-lg-none sticky-nav bg-white">
        <div class="container position-relative">
            <div class="row align-self-center">
                <!-- Header Logo Start -->
                <div class="col-auto align-self-center">
                    <div class="header-logo">
                        <a href="index.html"><img width="280px" src="assets/images/logo/logo.png"
                                                  alt="Site Logo"/></a>
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
<!-- Header Area End  -->

<!-- OffCanvas Cart Start -->

<!-- OffCanvas Cart End -->

<!-- OffCanvas Menu Start -->

<!-- OffCanvas Menu End -->


<!-- breadcrumb-area start -->


<!-- breadcrumb-area end -->

<!-- Cart Area Start -->
<div class="cart-main-area pt-100px pb-100px">
    <div class="container">
        <h3 class="cart-page-title">Your cart items</h3>
        <div class="row">
            <div class="col-lg-12 col-md-12 col-sm-12 col-12">
                <form action="#">
                    <div class="table-content table-responsive cart-table-content">
                        <table>
                            <thead>
                            <tr>
                                <th>圖片</th>
                                <th>家居名</th>
                                <th>單價</th>
                                <th>數量</th>
                                <th>金額</th>
                                <th>操作</th>
                            </tr>
                            </thead>
                            <tbody>
                            <%--找到顯示購物車項,進行迴圈items--%>
                            <%--
                                老師分析:
                                1. sessionScope.cart.items => 取出的是HashMap<Integer, CartItem>
                                2. 所以通過foreach取出每一個物件entry是 HashMap<Integer, CartItem> 的 k-v
                                3. var 其實就是 entry => 聽不懂的回去看java基礎 hashmap
                                4. 所以要取出cartItem 是 通過 entry.value
                            --%>
                            <c:if test="${not empty sessionScope.cart.items}">
                                <c:forEach items="${sessionScope.cart.items}" var="entry">
                                    <tr>
                                        <td class="product-thumbnail">
                                            <a href="#"><img class="img-responsive ml-3"
                                                             src="assets/images/product-image/1.jpg"
                                                             alt=""/></a>
                                        </td>
                                        <td class="product-name"><a href="#">${entry.value.name}</a></td>
                                        <td class="product-price-cart"><span class="amount">$${entry.value.price}</span>
                                        </td>
                                        <td class="product-quantity">
                                            <div class="cart-plus-minus">
                                                <input furnId="${entry.value.id}" class="cart-plus-minus-box" type="text" name="qtybutton"
                                                       value="${entry.value.count}"/>
                                            </div>
                                        </td>
                                        <td class="product-subtotal">$${entry.value.totalPrice}</td>
                                        <td class="product-remove">
                                            <a class="delItem" href="cartServlet?action=delItem&id=${entry.value.id}"><i class="icon-close"></i></a>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:if>
                            </tbody>
                        </table>
                    </div>
                    <div class="row">
                        <div class="col-lg-12">
                            <div class="cart-shiping-update-wrapper">
                                <h4>共${sessionScope.cart.totalCount}件商品 總價 ${sessionScope.cart.cartTotalPrice}元</h4>
                                <div class="cart-shiping-update">
                                    <a href="orderServlet?action=saveOrder">購 物 車-生 成 定 單</a>
                                </div>
                                <div class="cart-clear">
                                    <button>繼 續 購 物</button>
                                    <a class="clearCart" href="cartServlet?action=clear">清 空 購 物 車</a>
                                </div>
                            </div>
                        </div>
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

