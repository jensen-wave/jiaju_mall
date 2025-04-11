<%--jsp文件頭--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="x-ua-compatible" content="ie=edge" />
    <title>家居網購</title>


    <%--<base href="http://localhost:8080/jiaju_mall/">--%>
    <%--jsp腳本運算式--%>
    <base href="<%=request.getContextPath() + "/"%>">

    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <link rel="stylesheet" href="assets/css/vendor/vendor.min.css"/>
    <link rel="stylesheet" href="assets/css/plugins/plugins.min.css"/>
    <link rel="stylesheet" href="assets/css/style.min.css"/>
    <script type="text/javascript" src="script/jquery-3.6.0.min.js"></script>
    <script type="text/javascript">

        $(function () {


            //給用戶名輸入框綁定一個 blur
            $("#username").blur(function () {
                //獲取輸入的用戶名 js基礎
                var username = this.value;
                //發出ajax請求=》 jquery
                //儘量準確，一把搞定
                // $.getJSON("memberServlet",
                //     "action=isExistUserName&username=" + username,
                //     function (data) {
                //         console.log("data=", data);
                //     })

                $.getJSON("memberServlet",
                    {"action":"isExistUserName",
                        "username":username},
                    function (data) {
                        console.log("data=", data.isExist);
                        if (data.isExist){
                            $("span.errorMsg").text("用戶名不可用.")
                        }else {
                            $("span.errorMsg").text("用戶名可用.")
                        }
                    })
            })


            //決定是顯示登錄還是註冊tab “” 不能少
            //如果註冊失敗，顯示註冊tab , 而不是默認的登錄tab, 增加該代碼
            if ("${requestScope.active}" == "register") {
                $("#register_tab")[0].click();//模擬點擊
            }
            //對驗證碼圖片進行處理, 綁定一個點擊事件，可以獲取新的驗證碼
            $("#codeImg").click(function () {
                //先死後活
                //在url沒有變化時候，圖片不會發出新的請求
                //為了防止不請求，不刷新, 可以攜帶一個變化參數
                this.src = "<%=request.getContextPath()%>/kaptchaServlet?d=" + new Date();
            })

            //綁定點擊事件 => 忘記的去看jquery
            $("#sub-btn").click(function () {

                //獲取到到輸入的用戶名 => 自己看前端給的頁面
                var usernameVal = $("#username").val();
                // alert("usernameVal=" + usernameVal)

                //編寫規則運算式來進行驗證.
                var usernamePattern = /^\w{6,10}$/;
                //驗證
                if (!usernamePattern.test(usernameVal)) {
                    //展示錯誤提示, jquery屬性篩檢程式
                    $("span[class='errorMsg']").text("用戶名格式不對, 需要6-10字元");
                    return false;//不提交 , 返回false
                }

                //一關一個關的通過驗證
                //完成對密碼的校驗
                var passwordVal = $("#password").val();
                var passwordPattern = /^\w{6,10}$/;
                if (!passwordPattern.test(passwordVal)) {
                    //展示密碼錯誤提示-基本篩檢程式, 希望小夥伴感到知識不是每個都是新
                    //信心-》潛意識我學過.
                    $("span.errorMsg").text("密碼格式不對, 需要6-10字元");
                    return false;
                }

                //兩次密碼相同
                //得到第二次輸入密碼
                var repwdVal = $("#repwd").val();
                if (repwdVal != passwordVal) {
                    $("span.errorMsg").text("輸入的兩次密碼不同");
                    return false;
                }
                //驗證郵箱
                //得到郵箱 => 去看html
                var emailVal = $("#email").val();
                //老師說明 在java中，規則運算式的轉義是\\, 在js 規則運算式 轉義是\
                //如果你看不懂，回看java規則運算式
                var emailPattern = /^[\w-]+@([a-zA-Z]+\.)+[a-zA-Z]+$/; //偷懶->java
                if (!emailPattern.test(emailVal)) {
                    $("span.errorMsg").text("電子郵件格式不對");
                    return false;
                }

                // 驗證碼：流覽器這裡驗證不能為空
                var codeText = $("#code").val();
                //去掉驗證碼前後空格
                codeText = $.trim(codeText);
                if (codeText == null || codeText == "") {
                    //提示
                    $("span.errorMsg").text("驗證碼不能為空！");
                    return false;
                }

                //到這裡就全部過關. => 我們暫時不提交，顯示驗證通過資訊
                $("span.errorMsg").text("驗證通過...");
                //目前我們寫了後臺，當驗證通過時，就提交給後臺
                return true;
            })

// $(function () {
//  $("#sub-btn1").click(function () {
//      var usernameVal1 = $("#user-name").val();
//      // alert("usernameVal=" + usernameVal)
//
//      //編寫規則運算式來進行驗證.
//      var usernamePattern = /^\w{6,10}$/;
//      //驗證
//      if (!usernamePattern.test(usernameVal1)) {
//          //展示錯誤提示, jquery屬性篩檢程式
//          $("span[class='errorMsg']").text("用戶名格式不對, 需要6-10字元");
//          return false;//不提交 , 返回false
//      }
//
//
//  })
//
//
//
// })



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
                        <a href="index.html"><img width="280px" src="assets/images/logo/logo.png" alt="Site Logo" /></a>
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
<!-- login area start -->
<div class="login-register-area pt-70px pb-100px">
    <div class="container">
        <div class="row">
            <div class="col-lg-7 col-md-12 ml-auto mr-auto">
                <div class="login-register-wrapper">
                    <div class="login-register-tab-list nav">
                        <a class="active" data-bs-toggle="tab" href="#lg1">
                            <h4>會員登錄</h4>
                        </a>
                        <a id="register_tab" data-bs-toggle="tab" href="#lg2">
                            <h4>會員註冊</h4>
                        </a>
                    </div>
                    <div class="tab-content">
                        <div id="lg1" class="tab-pane active">
                            <div class="login-form-container">
                                <div class="login-register-form">
                                    <%--提示錯誤資訊--%>
                                    <span style="font-size: 18pt;font-weight: bold;float: right;color: black">
                                        ${requestScope.msg}
                                    </span>
                                    <!--老師說明前面有 el運算式 -->
                                    <form action="memberServlet" method="post">
                                        <input type="hidden" name="action" value="login">
                                        <input type="text" name="user-name" value="${requestScope.username}" placeholder="Username"/>
                                        <input type="password" name="user-password" placeholder="Password"/>
                                        <div class="button-box">
                                            <div class="login-toggle-btn">
                                                <input type="checkbox"/>
                                                <a class="flote-none" href="javascript:void(0)">Remember me</a>
                                                <a href="#">Forgot Password?</a>
                                            </div>
                                            <button type="submit" id="sub-btn1"><span>Login</span></button>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                        <div id="lg2" class="tab-pane">
                            <div class="login-form-container">
                                <div class="login-register-form">
                                    <%--提示錯誤資訊--%>
                                    <span class="errorMsg" style="font-size: 18pt;font-weight: bold;float: right;color: black">
                                        ${requestScope.msg}
                                    </span>
                                    <!-- 註冊表單 -->
                                    <form action="memberServlet" method="post">
                                        <!-- 增加隱藏欄位表示register請求 -->
                                        <input type="hidden" name="action" value="register">
                                        <input type="text" id="username" name="username" placeholder="Username" value="${requestScope.username}"/>
                                        <input type="password" id="password" name="password" placeholder="輸入密碼"/>
                                        <input type="password" id="repwd" name="repassword" placeholder="確認密碼"/>
                                        <input name="email" id="email" placeholder="電子郵件" type="email" value="${requestScope.email}"/>
                                        <input type="text" id="code" name="code" style="width: 50%"
                                               placeholder="驗證碼"/>　　<img id="codeImg" alt="" src="kaptchaServlet" style="width: 120px;height: 50px">
                                        <div class="button-box">
                                            <button type="submit" id="sub-btn"><span>會員註冊</span></button>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- login area end -->

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
                                        <li class="li"><a class="single-link" href="privacy-policy.html">隱私與政策</a></li>
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
                                        <li class="li"><a class="single-link" href="login.jsp">登錄</a></li>
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

