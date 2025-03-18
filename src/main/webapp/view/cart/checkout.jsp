<!doctype html>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<html class="no-js" lang="en">


    <!-- Mirrored from htmldemo.net/clothing/clothing/checkout.html by HTTrack Website Copier/3.x [XR&CO'2014], Sat, 01 Feb 2025 03:37:43 GMT -->
    <head>
        <meta charset="utf-8">
        <meta http-equiv="x-ua-compatible" content="ie=edge">
        <title>Checkout || Clothing</title>
        <meta name="description" content="Clothing ? eCommerce Fashion Template is a clean and elegant design ? suitable for selling clothing, fashion, high fashion, men fashion, women fashion, accessories, digital, kids, watches, jewelries, shoes, kids, furniture, sports, tools?.. It has a fully responsive width adjusts automatically to any screen size or resolution.">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <link rel="shortcut icon" type="image/x-icon" href="images/icons/favicon.png">
        <!-- Place favicon.png in the root directory -->

        <!-- All css files are included here. -->
        <jsp:include page="../common/home/css-home.jsp"></jsp:include>

        <style>
            /* Custom CSS cho trang checkout */
            .billing-details, .order-summary {
                background: #fff;
                border: 1px solid #ddd;
                padding: 20px;
                margin-bottom: 20px;
                box-shadow: 0 0 8px rgba(0,0,0,0.05);
                border-radius: 4px;
            }
            .order-summary table {
                margin-top: 20px;
            }
            .place-order-btn {
                background-color: #007bff; /* Màu xanh nổi bật */
                color: #fff;
                font-weight: bold;
                padding: 10px 20px;
                border: none;
                border-radius: 4px;
                text-transform: uppercase;
                transition: background-color 0.3s;
            }
            .place-order-btn:hover {
                background-color: #0056b3;
            }
            /* CSS tùy chỉnh để buộc hiển thị 2 cột cạnh nhau */
            .checkout-row {
                display: flex;
                flex-wrap: nowrap;
            }
            .checkout-col {
                flex: 0 0 50%;
                max-width: 50%;
                padding: 0 10px;
            }
            
            /* Điều chỉnh vị trí toast container ra giữa màn hình */
            .toast-container {
                position: fixed;
                top: 50%;
                left: 50%;
                transform: translate(-50%, -50%);
                z-index: 9999;
                width: auto;
            }
            
            .toast {
                background-color: #fff;
                color: #333;
                padding: 20px 40px;
                border-radius: 8px;
                box-shadow: 0 4px 12px rgba(0,0,0,0.15);
                margin-bottom: 10px;
                display: flex;
                align-items: center;
                justify-content: center;
                opacity: 0;
                transition: opacity 0.3s;
                min-width: 300px;
            }
            
            .toast.success {
                border-left: 6px solid #28a745;
                font-size: 1.8em;  /* Chữ to hơn nữa */
                text-align: center;
                font-weight: 500;
            }
            
            .toast.error {
                border-left: 4px solid #dc3545;
            }
            
            .toast.show {
                opacity: 1;
            }
            /* Style cho khối nút hành động sau khi đặt đơn */
            #afterOrderActions {
                text-align: center;
                margin: 30px auto;
                display: none;
                max-width: 600px;
                padding: 20px;
                background: #fff;
                border-radius: 8px;
                box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            }
            
            .action-button {
                display: inline-block;
                padding: 12px 25px;
                margin: 10px;
                font-size: 1.2em;
                font-weight: 500;
                text-decoration: none;
                border-radius: 6px;
                transition: all 0.3s ease;
                cursor: pointer;
            }
            
            .continue-shopping {
                background-color: #28a745;
                color: white;
                border: none;
            }
            
            .view-orders {
                background-color: #007bff;
                color: white;
                border: none;
            }
            
            .continue-shopping:hover {
                background-color: #218838;
                transform: translateY(-2px);
            }
            
            .view-orders:hover {
                background-color: #0056b3;
                transform: translateY(-2px);
            }

            #afterOrderActions {
                background: #fff;
                border-radius: 8px;
                box-shadow: 0 2px 15px rgba(0,0,0,0.1);
                margin: 30px auto;
                max-width: 800px;
            }

            #afterOrderActions .btn {
                transition: all 0.3s ease;
            }

            #afterOrderActions .btn:hover {
                transform: translateY(-3px);
                box-shadow: 0 5px 15px rgba(0,0,0,0.2);
            }

            .success-message {
                animation: fadeInDown 0.5s ease;
            }

            @keyframes fadeInDown {
                from {
                    opacity: 0;
                    transform: translateY(-20px);
                }
                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }

            .action-buttons {
                animation: fadeIn 0.5s ease 0.3s both;
            }

            @keyframes fadeIn {
                from {
                    opacity: 0;
                }
                to {
                    opacity: 1;
                }
            }
        </style>

            <!-- Modernizr JS -->
            <script src="js/vendor/modernizr-3.11.2.min.js"></script>
        </head>

        <body>
            <!--[if lt IE 8]>
                <p class="browserupgrade">You are using an <strong>outdated</strong> browser. Please <a href="http://browsehappy.com/">upgrade your browser</a> to improve your experience.</p>
            <![endif]-->

            <!-- Body main wrapper start -->
            <div class="wrapper checkout">

                <!-- Start of header area -->
            <jsp:include page="../common/home/header-homepage.jsp"></jsp:include>
                <!-- End of header area -->

                <!--breadcumb area start -->
                <div class="breadcumb-area overlay pos-rltv">
                    <div class="bread-main">
                        <div class="bred-hading text-center">
                            <h5>Cart Details</h5>
                        </div>
                        <ol class="breadcrumb">
                            <li class="home"><a title="Go to Home Page" href="index.html">Home</a></li>
                            <li class="active">Cart</li>
                        </ol>
                    </div>
                </div>
                <!--breadcumb area end -->

                <!--cart-checkout-area start -->
                <div class="cart-checkout-area  pt-30">
                    <div class="container">
                        <div class="row">
                            <div class="col-lg-12">
                                <div class="product-area">
                                    <div class="clearfix"></div>
                                    <div class="content-tab-product-category pb-70">
                                        <!-- Tab panes -->
                                        <div class="tab-content">
                                            <div role="tabpanel" class="tab-pane fade show active " id="checkout">
                                                <!-- Checkout are start-->
                                                <div class="checkout-area">
                                                    <div class="">
                                                        <div class="checkout-row">
                                                            <div class="checkout-col">
                                                                <div class="billing-details">
                                                                    <div class="contact-text right-side">
                                                                        <h2>Billing Details</h2>
                                                                        <form id="orderForm" action="${pageContext.request.contextPath}/order" method="post">
                                                                            <input type="hidden" name="action" value="place">
                                                                            <div class="row">
                                                                                <div class="col-lg-6 col-md-6">
                                                                                    <div class="input-box mb-20">
                                                                                        <label>First Name
                                                                                            <em>*</em></label>
                                                                                        <input type="text"
                                                                                               name="firstName"
                                                                                               class="info"
                                                                                               value="${sessionScope.account.firstName}"
                                                                                        placeholder="First Name"
                                                                                        required>
                                                                                </div>
                                                                            </div>
                                                                            <div class="col-lg-6 col-md-6">
                                                                                <div class="input-box mb-20">
                                                                                    <label>Last
                                                                                        Name<em>*</em></label>
                                                                                    <input type="text"
                                                                                           name="lastName"
                                                                                           class="info"
                                                                                           value="${sessionScope.account.lastName}"
                                                                                           placeholder="Last Name"
                                                                                           required>
                                                                                </div>
                                                                            </div>
                                                                            <div class="col-md-6">
                                                                                <div class="input-box mb-20">
                                                                                    <label>Email
                                                                                        Address<em>*</em></label>
                                                                                    <input type="email"
                                                                                           name="email"
                                                                                           class="info"
                                                                                           value="${sessionScope.account.email}"
                                                                                           placeholder="Your Email"
                                                                                           required>
                                                                                </div>
                                                                            </div>
                                                                            <div class="col-md-6">
                                                                                <div class="input-box mb-20">
                                                                                    <label>Phone
                                                                                        Number<em>*</em></label>
                                                                                    <input type="text"
                                                                                           name="phone"
                                                                                           class="info"
                                                                                           value="${sessionScope.account.phone}"
                                                                                           placeholder="Phone Number"
                                                                                           required>
                                                                                </div>
                                                                            </div>
                                                                            <div class="form-group mt-3 text-right">
                                                                                <button type="submit" class="place-order-btn">Place Order</button>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="checkout-col">
                                                                <div class="order-summary">
                                                                    <h2>Order Summary</h2>
                                                                    <div class="table-responsive">
                                                                        <table class="checkout-area table">
                                                                            <thead>
                                                                                <tr class="cart_item check-heading">
                                                                                    <td class="ctg-type">Product</td>
                                                                                    <td class="cgt-des">Total</td>
                                                                                </tr>
                                                                            </thead>
                                                                            <tbody>
                                                                                <c:forEach items="${cartItemDetails}" var="detail">
                                                                                    <tr class="cart_item check-item prd-name">
                                                                                        <c:set var="color" value="${requestScope['color_'.concat(detail.cartItem.cartItemId)]}" />
                                                                                        <c:set var="size" value="${requestScope['size_'.concat(detail.cartItem.cartItemId)]}" />
                                                                                        <td class="ctg-type">
                                                                                            ${detail.product.productName} × ${detail.cartItem.quantity}
                                                                                            <div class="small text-muted">
                                                                                                Color: ${color.colorName}, Size: ${size.sizeName}
                                                                                            </div>
                                                                                        </td>
                                                                                        <td class="cgt-des">
                                                                                            <fmt:formatNumber value="${detail.product.price * detail.cartItem.quantity}" 
                                                                                                pattern="#,##0 ₫" />
                                                                                        </td>
                                                                                    </tr>
                                                                                </c:forEach>
                                                                                <tr class="cart_item">
                                                                                    <td class="ctg-type">Subtotal</td>
                                                                                    <td class="cgt-des">
                                                                                        <fmt:formatNumber value="${total}" pattern="#,##0 ₫" />
                                                                                    </td>
                                                                                </tr>
                                                                                <tr class="cart_item">
                                                                                    <td class="ctg-type crt-total">Total</td>
                                                                                    <td class="cgt-des prc-total">
                                                                                        <strong>
                                                                                            <fmt:formatNumber value="${total + 30000}" pattern="#,##0 ₫" />
                                                                                        </strong>
                                                                                    </td>
                                                                                </tr>
                                                                            </tbody>
                                                                        </table>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <!-- Checkout are end-->
                                        </div>
                                        <div role="tabpanel" class="tab-pane  fade in" id="complete-order">
                                            <div class="row">
                                                <div class="col-lg-12">
                                                    <div class="checkout-payment-area">
                                                        <div class="payment-section mt-20 clearfix">

                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!--cart-checkout-area end-->

            <!-- footer area start-->
            <jsp:include page="../common/home/footer-homepage.jsp"></jsp:include>
                <!--footer area start-->

                <!--footer bottom area start-->
                <!--footer bottom area end-->

            </div>
            <!-- Body main wrapper end -->

            <!-- Placed js at the end of the document so the pages load faster -->

            <!-- jquery latest version -->
        <jsp:include page="../common/home/js-home.jsp"></jsp:include>

            <!-- Toast container for notifications -->
            <div class="toast-container" id="toastContainer"></div>
            
            <!-- Toast script -->
            <script>
                // Function to show toast notification
                function showToast(message, type = 'success') {
                    const container = document.getElementById('toastContainer');
                    const toast = document.createElement('div');
                    toast.classList.add('toast', type);
                    toast.innerHTML = message;
                    
                    container.appendChild(toast);
                    
                    // Trigger reflow and add show class for animation
                    setTimeout(() => toast.classList.add('show'), 10);
                    
                    // Remove toast after 5 seconds and call RemoveToastServlet to clear session attributes
                    setTimeout(() => {
                        toast.classList.remove('show');
                        setTimeout(() => {
                            container.removeChild(toast);
                            // Gọi RemoveToastServlet để xóa thông báo khỏi session
                            fetch('${pageContext.request.contextPath}/remove-toast', {
                                method: 'POST',
                                headers: {
                                    'Content-Type': 'application/x-www-form-urlencoded'
                                }
                            }).then(response => {
                                if (!response.ok) {
                                    console.error('Failed to remove toast attributes');
                                }
                            }).catch(error => {
                                console.error('Error:', error);
                            });
                        }, 300);
                    }, 5000);
                }
                
                document.addEventListener('DOMContentLoaded', function() {
                    var toastMessage = "${sessionScope.toastMessage}";
                    var toastType = "${sessionScope.toastType}" || "success";
                    
                    if (toastMessage && toastMessage.trim() !== "") {
                        showToast(toastMessage, toastType);
                        if(toastType === 'success'){
                            // Ẩn form đặt hàng và hiện các nút hành động
                            setTimeout(function(){
                                // Ẩn toàn bộ khu vực checkout
                                var checkoutArea = document.querySelector('.checkout-area');
                                if(checkoutArea) {
                                    checkoutArea.style.display = 'none';
                                }
                                
                                // Hiện khối nút hành động
                                var afterActions = document.getElementById("afterOrderActions");
                                if(afterActions) {
                                    afterActions.style.display = 'block';
                                }
                            }, 1000); // Delay 1 giây sau khi hiện toast
                        }
                    }
                });
            </script>

    </body>


    <!-- Mirrored from htmldemo.net/clothing/clothing/checkout.html by HTTrack Website Copier/3.x [XR&CO'2014], Sat, 01 Feb 2025 03:37:43 GMT -->
</html>