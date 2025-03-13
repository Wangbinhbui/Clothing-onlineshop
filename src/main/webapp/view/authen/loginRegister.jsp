<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!doctype html>
<html class="no-js" lang="en">


<!-- Mirrored from htmldemo.net/clothing/clothing/login.html by HTTrack Website Copier/3.x [XR&CO'2014], Sat, 01 Feb 2025 03:37:53 GMT -->
<head>
    <meta charset="utf-8">
    <meta http-equiv="x-ua-compatible" content="ie=edge">
    <title>Login || Clothing</title>
    <meta name="description" content="Clothing – eCommerce Fashion Template is a clean and elegant design – suitable for selling clothing, fashion, high fashion, men fashion, women fashion, accessories, digital, kids, watches, jewelries, shoes, kids, furniture, sports, tools….. It has a fully responsive width adjusts automatically to any screen size or resolution.">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <link rel="shortcut icon" type="image/x-icon" href="images/icons/favicon.png">
    <!-- Place favicon.png in the root directory -->

    <!-- All css files are included here. -->
    <!-- Bootstrap fremwork main css -->
    <jsp:include page="../common/home/css-home.jsp"></jsp:include>
    
    <!-- Modernizr JS -->
</head>

<body>
    <!--[if lt IE 8]>
        <p class="browserupgrade">You are using an <strong>outdated</strong> browser. Please <a href="http://browsehappy.com/">upgrade your browser</a> to improve your experience.</p>
    <![endif]-->  

    <!-- Body main wrapper start -->
    <div class="wrapper login">
       
        <!-- Start of header area -->
        <jsp:include page="../common/home/header-homepage.jsp"></jsp:include>
        <!-- End of header area -->
        
        
        <!-- Account Area Start -->
        <div class="account-area ptb-80">
            <div class="container">
                <div class="row">
                    <div class="col-md-6">
                        <form action="authen?action=login" method="post" class="login-side">
                            <div class="login-reg">
                                <h3>Login</h3>

                                <!-- Hiển thị lỗi nếu có -->
                                <c:if test="${not empty error}">
                                    <div class="alert alert-danger">
                                        ${error}
                                    </div>
                                </c:if>

                                <div class="input-box mb-20">
                                    <label class="control-label">E-Mail / Username</label>
                                    <input type="text" placeholder="E-Mail or Username" name="username" class="info" required>
                                </div>
                                <div class="input-box">
                                    <label class="control-label">Password</label>
                                    <input type="password" placeholder="Password" name="password" class="info" required>
                                </div>
                            </div>
                            <div class="frm-action">
                                <div class="input-box tci-box">
                                    <a href="#" onclick="this.closest('form').submit(); return false;" class="btn-def btn2">Login</a>
                                </div>
                                <span>
                                    <input class="remr" type="checkbox" name="remember"> Remember me 
                                </span>
                                <a href="authen?action=enter-email" class="forgotten forg">Forgotten Password?</a>
                            </div>
                        </form>
                    </div>
                    <div class="col-md-6 lr2">
                        <form action="authen?action=sign-up" method="post">
                            <div class="login-reg">
                                <h3>Register</h3>

                                <!-- Hiển thị lỗi nếu có -->
                                <c:if test="${not empty error}">
                                    <div class="alert alert-danger">
                                        ${error}
                                    </div>
                                </c:if>

                                <div class="input-box mb-20">
                                    <label class="control-label">Username</label>
                                    <input type="text" class="info" placeholder="Username" name="username" required>
                                </div>

                                <div class="input-box mb-20">
                                    <label class="control-label">E-Mail</label>
                                    <input type="email" class="info" placeholder="E-Mail" name="email" required>
                                </div>

                                <div class="input-box">
                                    <label class="control-label">Password</label>
                                    <input type="password" class="info" placeholder="Password" name="password" required>
                                </div>

                                <div class="input-box">
                                    <label class="control-label">Confirm Password</label>
                                    <input type="password" class="info" placeholder="Confirm Password" name="confirmPassword" required>
                                </div>
                            </div>
                            <div class="frm-action">
                                <div class="input-box tci-box">
                                    <a href="#" onclick="this.closest('form').submit(); return false;" class="btn-def btn2">Register</a>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        <!-- Account Area End -->

        <!-- footer area start-->
        <jsp:include page="../common/home/footer-homepage.jsp"></jsp:include>
        <!--footer bottom area end-->
      
    </div> 
    <!-- Body main wrapper end -->

    <!-- Placed js at the end of the document so the pages load faster -->

    <!-- jquery latest version -->
    <jsp:include page="../common/home/js-home.jsp"></jsp:include>

</body>


<!-- Mirrored from htmldemo.net/clothing/clothing/login.html by HTTrack Website Copier/3.x [XR&CO'2014], Sat, 01 Feb 2025 03:37:53 GMT -->
</html>