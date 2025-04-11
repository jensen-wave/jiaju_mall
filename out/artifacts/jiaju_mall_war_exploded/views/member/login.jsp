<%--jsp文件头--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="x-ua-compatible" content="ie=edge" />
    <title>韩顺平教育-家居网购</title>


    <%--<base href="http://localhost:8080/jiaju_mall/">--%>
    <%--jsp脚本表达式--%>
    <base href="<%=request.getContextPath() + "/"%>">

    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <link rel="stylesheet" href="assets/css/vendor/vendor.min.css"/>
    <link rel="stylesheet" href="assets/css/plugins/plugins.min.css"/>
    <link rel="stylesheet" href="assets/css/style.min.css"/>
    <script type="text/javascript" src="script/jquery-3.6.0.min.js"></script>
    <script type="text/javascript">

$(function () {


    //给用户名输入框绑定一个 blur
    $("#username").blur(function () {
        //获取输入的用户名 js基础
        var username = this.value;
        //发出ajax请求=》 jquery
        //尽量准确，一把搞定
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
                    $("span.errorMsg").text("用户名不可用.")
                }else {
                    $("span.errorMsg").text("用户名可用.")
                }
            })
    })


    //决定是显示登录还是注册tab “” 不能少
    //如果注册失败，显示注册tab , 而不是默认的登录tab, 增加该代码
    if ("${requestScope.active}" == "register") {
        $("#register_tab")[0].click();//模拟点击
    }
    //对验证码图片进行处理, 绑定一个点击事件，可以获取新的验证码
    $("#codeImg").click(function () {
        //先死后活
        //在url没有变化时候，图片不会发出新的请求
        //为了防止不请求，不刷新, 可以携带一个变化参数
        this.src = "<%=request.getContextPath()%>/kaptchaServlet?d=" + new Date();
    })

    //绑定点击事件 => 忘记的去看jquery
    $("#sub-btn").click(function () {

        //获取到到输入的用户名 => 自己看前端给的页面
        var usernameVal = $("#username").val();
        // alert("usernameVal=" + usernameVal)

        //编写正则表达式来进行验证.
        var usernamePattern = /^\w{6,10}$/;
        //验证
        if (!usernamePattern.test(usernameVal)) {
            //展示错误提示, jquery属性过滤器
            $("span[class='errorMsg']").text("用户名格式不对, 需要6-10字符");
            return false;//不提交 , 返回false
        }

        //一关一个关的通过验证
        //完成对密码的校验
        var passwordVal = $("#password").val();
        var passwordPattern = /^\w{6,10}$/;
        if (!passwordPattern.test(passwordVal)) {
            //展示密码错误提示-基本过滤器, 希望小伙伴感到知识不是每个都是新
            //信心-》潜意识我学过.
            $("span.errorMsg").text("密码格式不对, 需要6-10字符");
            return false;
        }

        //两次密码相同
        //得到第二次输入密码
        var repwdVal = $("#repwd").val();
        if (repwdVal != passwordVal) {
            $("span.errorMsg").text("输入的两次密码不同");
            return false;
        }
        //验证邮箱
        //得到邮箱 => 去看html
        var emailVal = $("#email").val();
        //老师说明 在java中，正则表达式的转义是\\, 在js 正则表达式 转义是\
        //如果你看不懂，回看java正则表达式
        var emailPattern = /^[\w-]+@([a-zA-Z]+\.)+[a-zA-Z]+$/; //偷懒->java
        if (!emailPattern.test(emailVal)) {
            $("span.errorMsg").text("电子邮件格式不对");
            return false;
        }

        // 验证码：浏览器这里验证不能为空
        var codeText = $("#code").val();
        //去掉验证码前后空格
        codeText = $.trim(codeText);
        if (codeText == null || codeText == "") {
            //提示
            $("span.errorMsg").text("验证码不能为空！");
            return false;
        }

        //到这里就全部过关. => 我们暂时不提交，显示验证通过信息
        $("span.errorMsg").text("验证通过...");
        //目前我们写了后台，当验证通过时，就提交给后台
    return true;
})

// $(function () {
//  $("#sub-btn1").click(function () {
//      var usernameVal1 = $("#user-name").val();
//      // alert("usernameVal=" + usernameVal)
//
//      //编写正则表达式来进行验证.
//      var usernamePattern = /^\w{6,10}$/;
//      //验证
//      if (!usernamePattern.test(usernameVal1)) {
//          //展示错误提示, jquery属性过滤器
//          $("span[class='errorMsg']").text("用户名格式不对, 需要6-10字符");
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
    <!-- Header Bottom  Start 手机端的header -->
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
                            <h4>会员登录</h4>
                        </a>
                        <a id="register_tab" data-bs-toggle="tab" href="#lg2">
                            <h4>会员注册</h4>
                        </a>
                    </div>
                    <div class="tab-content">
                        <div id="lg1" class="tab-pane active">
                            <div class="login-form-container">
                                <div class="login-register-form">
                                    <%--提示错误信息--%>
                                    <span style="font-size: 18pt;font-weight: bold;float: right;color: black">
                                        ${requestScope.msg}
                                    </span>
                                    <!--老师说明前面有 el表达式 -->
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
                                    <%--提示错误信息--%>
                                    <span class="errorMsg" style="font-size: 18pt;font-weight: bold;float: right;color: black">
                                        ${requestScope.msg}
                                    </span>
                                    <!-- 注册表单 -->
                                    <form action="memberServlet" method="post">
                                        <!-- 增加隐藏域表示register请求 -->
                                        <input type="hidden" name="action" value="register">
                                        <input type="text" id="username" name="username" placeholder="Username" value="${requestScope.username}"/>
                                        <input type="password" id="password" name="password" placeholder="输入密码"/>
                                        <input type="password" id="repwd" name="repassword" placeholder="确认密码"/>
                                        <input name="email" id="email" placeholder="电子邮件" type="email" value="${requestScope.email}"/>
                                        <input type="text" id="code" name="code" style="width: 50%"
                                               placeholder="验证码"/>　　<img id="codeImg" alt="" src="kaptchaServlet" style="width: 120px;height: 50px">
                                        <div class="button-box">
                                            <button type="submit" id="sub-btn"><span>会员注册</span></button>
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
                                        <li class="li"><a class="single-link" href="about.html">关于我们</a></li>
                                        <li class="li"><a class="single-link" href="#">交货信息</a></li>
                                        <li class="li"><a class="single-link" href="privacy-policy.html">隐私与政策</a></li>
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
<script src="assets/js/vendor/vendor.min.js"></script>
<script src="assets/js/plugins/plugins.min.js"></script>
<!-- Main Js -->
<script src="assets/js/main.js"></script>
</body>
</html>