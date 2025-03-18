<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!doctype html>
<html class="no-js" lang="en">


    <!-- Mirrored from htmldemo.net/clothing/clothing/cart.html by HTTrack Website Copier/3.x [XR&CO'2014], Sat, 01 Feb 2025 03:37:42 GMT -->
    <head>
        <meta charset="utf-8">
        <meta http-equiv="x-ua-compatible" content="ie=edge">
        <title>Cart - Clothing Shop</title>
        <meta name="description" content="Clothing ? eCommerce Fashion Template is a clean and elegant design ? suitable for selling clothing, fashion, high fashion, men fashion, women fashion, accessories, digital, kids, watches, jewelries, shoes, kids, furniture, sports, tools?.. It has a fully responsive width adjusts automatically to any screen size or resolution.">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <link rel="shortcut icon" type="image/x-icon" href="images/icons/favicon.png">
        <!-- Place favicon.png in the root directory -->

        <!-- All css files are included here. -->
        <!-- Bootstrap fremwork main css -->
        <jsp:include page="../common/home/css-home.jsp"></jsp:include>

            <!-- Modernizr JS -->
            <script src="js/vendor/modernizr-3.11.2.min.js"></script>
        </head>

        <body>
            <!--[if lt IE 8]>
                <p class="browserupgrade">You are using an <strong>outdated</strong> browser. Please <a href="http://browsehappy.com/">upgrade your browser</a> to improve your experience.</p>
            <![endif]-->

            <!-- Body main wrapper start -->
            <div class="wrapper cart">

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
                            <li class="home"><a href="index.html">Home</a></li>
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
                            <c:if test="${not empty errorMessage}">
                                <div class="alert alert-danger">${errorMessage}</div>
                            </c:if>

                            <div class="product-area">
                                <div class="title-tab-product-category row">
                                    <div class="col-lg-12 text-center pb-60">
                                        <ul class="nav heading-style-3" role="tablist">
                                            <li role="presentation"><a class="active shadow-box" href="#cart"
                                                                       aria-controls="cart" role="tab" data-bs-toggle="tab"><span>01</span>
                                                    Shopping
                                                    cart</a></li>
                                            <li role="presentation"><a class="shadow-box" href="#checkout"
                                                                       aria-controls="checkout" role="tab"
                                                                       data-bs-toggle="tab"><span>02</span>Checkout</a></li>
                                            <li role="presentation"><a class="shadow-box" href="#complete-order"
                                                                       aria-controls="complete-order" role="tab"
                                                                       data-bs-toggle="tab"><span>03</span>
                                                    complete-order</a></li>
                                        </ul>
                                    </div>
                                </div>
                                <div class="clearfix"></div>
                                <div class="content-tab-product-category pb-70">
                                    <!-- Tab panes -->
                                    <div class="tab-content">
                                        <div role="tabpanel" class="tab-pane fade show active" id="cart">
                                            <!-- cart are start-->
                                            <div class="cart-page-area">
                                                <form method="post" action="#">
                                                    <div class="table-responsive mb-20">
                                                        <table class="shop_table-2 cart table">
                                                            <thead>
                                                                <tr>
                                                                    <th class="product-thumbnail">Image</th>
                                                                    <th class="product-name">Product Name</th>
                                                                    <th class="product-price">Unit Price</th>
                                                                    <th class="product-quantity">Quantity</th>
                                                                    <th class="product-subtotal">Total</th>
                                                                    <th class="product-remove">Remove</th>
                                                                </tr>
                                                            </thead>
                                                            <tbody>
                                                                <c:forEach items="${cartItems}" var="item">
                                                                    <tr class="cart_item">
                                                                        <td class="item-img">
                                                                            <a href="#">
                                                                                <img src="${item.product.imageUrl}" alt="${item.product.productName}">
                                                                            </a>
                                                                        </td>
                                                                        <td class="item-title">
                                                                            <a href="#">${item.product.productName}</a>
                                                                            <p class="variation-info">
                                                                                Color: ${color.colorName}<br>
                                                                                Size: ${size.sizeName}
                                                                            </p>
                                                                        </td>
                                                                        <td class="item-price">
                                                                            <fmt:formatNumber value="${item.product.price}" type="currency"/>
                                                                        </td>
                                                                        <td class="item-qty">
                                                                            <form action="cart" method="post" class="cart-quantity">
                                                                                <input type="hidden" name="action" value="update">
                                                                                <input type="hidden" name="cartItemId" value="${item.cartItemId}">
                                                                                <div class="cart-plus-minus">
                                                                                    <div class="dec qtybutton">-</div>
                                                                                    <input name="quantity" value="${item.quantity}" 
                                                                                           class="cart-plus-minus-box" type="text">
                                                                                    <div class="inc qtybutton">+</div>
                                                                                </div>
                                                                                <button type="submit" class="btn-update">Update</button>
                                                                            </form>
                                                                        </td>
                                                                        <td class="total-price">
                                                                            <strong>
                                                                                <fmt:formatNumber value="${item.product.price * item.quantity}" 
                                                                                                  type="currency"/>
                                                                            </strong>
                                                                        </td>
                                                                        <td class="remove-item">
                                                                            <a href="cart?action=remove&cartItemId=${item.cartItemId}">
                                                                                <i class="fa fa-trash-o"></i>
                                                                            </a>
                                                                        </td>
                                                                    </tr>
                                                                </c:forEach>
                                                            </tbody>
                                                        </table>
                                                    </div>


                                                    <div class="cart-bottom-area">
                                                        <div class="row">
                                                            <div class="col-lg-8 col-md-7">
                                                                <div class="update-coupne-area">
                                                                    <div class="update-continue-btn text-end pb-20">
                                                                        <a href="#" class="btn-def btn2">Update Cart</a>
                                                                        <a href="#" class="btn-def btn2">Continue
                                                                            Shopping</a>
                                                                    </div>
                                                                    <!-- Promotion Section -->
                                                                    <div class="coupn-area">
                                                                        <div class="catagory-title cat-tit-5 mb-20">
                                                                            <h3>Coupon</h3>
                                                                            <p>Enter your coupon code if you have one.</p>
                                                                        </div>
                                                                        <form action="cart" method="post">
                                                                            <input type="hidden" name="action" value="apply-promotion">
                                                                            <div class="input-box input-box-2 mb-20">
                                                                                <input type="text" placeholder="Coupon Code" class="info" name="promotionCode">
                                                                            </div>
                                                                            <button type="submit" class="btn-def btn2">Apply Coupon</button>
                                                                        </form>
                                                                        <c:if test="${not empty promotion}">
                                                                            <div class="alert alert-success mt-20">
                                                                                Promotion applied: ${promotion.promotionName} (${promotion.discountRate * 100}% off)
                                                                            </div>
                                                                        </c:if>
                                                                        <c:if test="${not empty errorMessage}">
                                                                            <div class="alert alert-danger mt-20">
                                                                                ${errorMessage}
                                                                            </div>
                                                                        </c:if>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="col-lg-4 col-md-5">
                                                                <div class="cart-total-area">
                                                                    <div class="catagory-title cat-tit-5 mb-20 text-end">
                                                                        <h3>Cart Totals</h3>
                                                                    </div>
                                                                    <div class="sub-shipping">
                                                                        <p>Subtotal <span><fmt:formatNumber value="${total / (1 - (promotion != null ? promotion.discountRate : 0))}" type="currency"/></span></p>
                                                                        <c:if test="${not empty promotion}">
                                                                            <p>Discount <span>-<fmt:formatNumber value="${total * promotion.discountRate}" type="currency"/></span></p>
                                                                        </c:if>
                                                                        
                                                                    </div>
                                                                    <div class="process-cart-total">
                                                                        <p>Total <span><fmt:formatNumber value="${total + 3}" type="currency"/></span></p>
                                                                    </div>
                                                                    <div class="process-checkout-btn text-end">
                                                                        <a class="btn-def btn2" href="/cart?action=checkout">Process To Checkout</a>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </form>
                                            </div>
                                            <!-- cart are end-->
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
                <div class="footer-bottom global-table">
                    <div class="global-row">
                        <div class="global-cell">
                            <div class="container">
                                <div class="row">
                                    <div class="col-md-6">
                                        <p class="copyrigth text-center">
                                            Â© 2022 <span class="text-capitalize">clothing</span>. Made
                                            with <i style="color: #f53400;" class="fa fa-heart"></i>
                                            by
                                            <a  href="https://themeforest.net/user/codecarnival/portfolio">CodeCarnival</a>
                                        </p>
                                    </div>
                                    <div class="col-md-6">
                                        <ul class="payment-support text-end">
                                            <li>
                                                <a href="#"><img src="images/icons/pay1.png" alt="" /></a>
                                            </li>
                                            <li>
                                                <a href="#"><img src="images/icons/pay2.png" alt="" /></a>
                                            </li>
                                            <li>
                                                <a href="#"><img src="images/icons/pay3.png" alt="" /></a>
                                            </li>
                                            <li>
                                                <a href="#"><img src="images/icons/pay4.png" alt="" /></a>
                                            </li>
                                            <li>
                                                <a href="#"><img src="images/icons/pay5.png" alt="" /></a>
                                            </li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!--footer bottom area end-->

            </div>
            <!-- Body main wrapper end -->

            <!-- Placed js at the end of the document so the pages load faster -->

            <!-- jquery latest version -->
        <jsp:include page="../common/home/js-home.jsp"></jsp:include>

    </body>


    <!-- Mirrored from htmldemo.net/clothing/clothing/cart.html by HTTrack Website Copier/3.x [XR&CO'2014], Sat, 01 Feb 2025 03:37:43 GMT -->
</html>