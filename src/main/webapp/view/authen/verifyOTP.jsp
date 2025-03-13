<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!doctype html>
<html class="no-js" lang="en">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="x-ua-compatible" content="ie=edge">
        <meta name="description" content="Clothing – eCommerce Fashion Template is a clean and elegant design – suitable for selling clothing, fashion, high fashion, men fashion, women fashion, accessories, digital, kids, watches, jewelries, shoes, kids, furniture, sports, tools….. It has a fully responsive width adjusts automatically to any screen size or resolution.">
        <meta name="viewport" content="width=device-width, initial-scale=1">
    
        <link rel="shortcut icon" type="image/x-icon" href="images/icons/favicon.png">
        <title>Verify OTP || Clothing</title>
        <jsp:include page="../common/home/css-home.jsp"></jsp:include>
    </head>
    
<body>
    <div class="wrapper login">
        <jsp:include page="../common/home/header-homepage.jsp"></jsp:include>
        
        <div class="account-area ptb-80">
            <div class="container">
                <div class="row">
                    <div class="col-md-12">
                        <form action="authen?action=verify-otp" method="post">
                            <div class="login-reg">
                                <h3>Verify OTP</h3>

                                <!-- Hiển thị lỗi nếu có -->
                                <c:if test="${not empty error}">
                                    <div class="alert alert-danger">
                                        ${error}
                                    </div>
                                </c:if>

                                <div class="input-box mb-20">
                                    <label class="control-label">Enter OTP</label>
                                    <input type="text" class="info" placeholder="OTP Code" name="otp" required>
                                </div>

                                <div class="input-box">
                                    <p class="otp-instruction">
                                        We've sent an OTP to your email. Please check your inbox and enter the code here.
                                    </p>
                                </div>
                            </div>
                            <div class="frm-action">
                                <div class="input-box tci-box">
                                    <a href="#" onclick="this.closest('form').submit(); return false;" class="btn-def btn2">Verify OTP</a>
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