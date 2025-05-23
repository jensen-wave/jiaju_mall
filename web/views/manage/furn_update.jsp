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
    <style type="text/css">

        #pic {
            position: relative;
        }

        input[type="file"] {
            position: absolute;
            left: 0;
            top: 0;
            height: 150px;
            opacity: 0;
            cursor: pointer;
        }
    </style>

    <script type="text/javascript">
        // 定義 prev 函式，用於預覽上傳的圖片
        function prev(event) {
            // 獲取展示圖片的 <img> 元素
            var img = document.getElementById("prevView");

            // 獲取用戶選擇的文件（僅取第一個）
            var file = event.files[0];

            // 創建 FileReader 對象，用於讀取文件內容
            var reader = new FileReader();

            // 以數據 URL（Base64 編碼）讀取圖片文件
            reader.readAsDataURL(file);

            // 當檔讀取完成後執行回調函式
            reader.onload = function () {
                // 將讀取到的圖片數據設置為 <img> 的 src 屬性，以顯示圖片預覽
                img.setAttribute("src", this.result);
            }
        }
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
        <h3 class="cart-page-title">家居後臺管理-修改家居</h3>
        <div class="row">
            <div class="col-lg-12 col-md-12 col-sm-12 col-12">
                <form action="manage/furnServlet?id=${requestScope.furn.id}&action=update&pageNo=${param.pageNo}" method="post" enctype="multipart/form-data">
                    <%--因為是post,所以我們需要使用到隱藏欄位id,action--%>
                    <%--傳id--%>
                    <%--                    <input type="hidden" name="id" value="${requestScope.furn.id}">--%>
                    <%--                    &lt;%&ndash;確定調用servlet的update方法&ndash;%&gt;--%>
                    <%--                    <input type="hidden" name="action" value="update">--%>
                    <%--                    <input type="hidden" name="pageNo" value="${param.pageNo}">--%>
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
                                    <div id="pic">
                                        <img id="prevView" class="img-responsive ml-3"
                                             src="${requestScope.furn.imgPath}"
                                             alt=""/>
                                        <input type="file" name="imgPath" id="" value="${requestScope.furn.imgPath}"
                                               onchange="prev(this)"/>
                                    </div>
                                </td>


                                <td class="product-name"><input name="name" style="width: 60%" type="text"
                                                                value="${requestScope.furn.name}"/></td>
                                <td class="product-name"><input name="maker" style="width: 90%" type="text"
                                                                value="${requestScope.furn.maker}"/></td>
                                <td class="product-price-cart"><input name="price" style="width: 90%" type="text"
                                                                      value="${requestScope.furn.price}"/></td>
                                <td class="product-quantity">
                                    <input name="sales" style="width: 90%" type="text"
                                           value="${requestScope.furn.sales}"/>
                                </td>
                                <td class="product-quantity">
                                    <input name="stock" style="width: 90%" type="text"
                                           value="${requestScope.furn.stock}"/>
                                </td>
                                <td>
                                    <!--                                    <a href="#"><i class="icon-pencil"></i></a>-->
                                    <!--                                    <a href="#"><i class="icon-close"></i></a>-->
                                    <input type="submit"
                                           style="width: 90%;background-color: silver;border: silver;border-radius: 20%;"
                                           value="修改家居"/>
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

