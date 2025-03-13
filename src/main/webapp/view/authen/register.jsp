<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!doctype html>
<html class="no-js" lang="en">
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
    <div class="wrapper login">
        <jsp:include page="../common/home/header-homepage.jsp"></jsp:include>
        
        <div class="account-area ptb-80">
            <div class="container">
                <div class="row">
                    <div class="col-md-12">
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
        
        <jsp:include page="../common/home/footer-homepage.jsp"></jsp:include>
    </div>
    <jsp:include page="../common/home/js-home.jsp"></jsp:include>
</body>
</html> 