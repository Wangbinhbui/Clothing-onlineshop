<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

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

        <!-- Additional Custom Styles -->
        <style>
            /* Tùy chỉnh thêm để làm đẹp giao diện Giỏ hàng */
            .cart-page-area {
                background: #fff;
                border-radius: 8px;
                padding: 30px;
                box-shadow: 0 0 10px rgba(0,0,0,0.1);
            }
            .table thead th {
                border-bottom: 2px solid #dee2e6;
            }
            .qtybutton {
                cursor: pointer;
                background-color: #f8f9fa;
                border: 1px solid #ced4da;
                width: 35px;
                height: 35px;
                text-align: center;
                line-height: 33px;
                font-size: 18px;
            }
            .cart-plus-minus-box {
                max-width: 60px;
                text-align: center;
            }
            .btn-update {
                margin-top: 5px;
            }
            .remove-button {
                background: transparent;
                border: none;
                color: #dc3545;
                font-size: 18px;
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
            <div class="wrapper cart">

                <!-- Start of header area -->
            <jsp:include page="../common/home/header-homepage.jsp"></jsp:include>
                <!-- End of header area -->

                <!--breadcumb area start -->
                <div class="breadcumb-area overlay pos-rltv py-4" style="background: url('assets/images/breadcrumb.jpg'); background-size: cover;">
                    <div class="container">
                        <div class="bread-main text-center text-white">
                            <h5>Cart Details</h5>
                            <ol class="breadcrumb justify-content-center">
                                <li class="breadcrumb-item"><a href="index.html" class="text-white">Home</a></li>
                                <li class="breadcrumb-item active text-white">Cart</li>
                            </ol>
                        </div>
                    </div>
                </div>
                <!--breadcumb area end -->

                <!--cart-checkout-area start -->
                <div class="cart-checkout-area pt-30 pb-60">
                    <div class="container">
                        <div class="row justify-content-center">
                            <div class="col-lg-12">
                            <c:if test="${not empty errorMessage}">
                                <div class="alert alert-danger">${errorMessage}</div>
                            </c:if>

                            <div class="product-area">
<!--                                <div class="title-tab-product-category row">
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
                                </div>-->
                                <div class="clearfix"></div>
                                <div class="content-tab-product-category pb-70">
                                    <!-- Tab panes -->
                                    <div class="tab-content">
                                        <div role="tabpanel" class="tab-pane fade show active" id="cart">
                                            <!-- cart are start-->
                                            <div class="cart-page-area">
                                                <form method="post" action="cart">
                                                    <input type="hidden" name="action" value="update"/>
                                                    <div class="table-responsive mb-4">
                                                        <table class="table table-striped table-hover">
                                                            <thead>
                                                                <tr>
                                                                    <th class="text-center">Image</th>
                                                                    <th>Product Name</th>
                                                                    <th class="text-center">Unit Price</th>
                                                                    <th class="text-center">Quantity</th>
                                                                    <th class="text-center">Total</th>
                                                                    <th class="text-center">Remove</th>
                                                                </tr>
                                                            </thead>
                                                            <tbody>
                                                                <c:forEach items="${cartItems}" var="item">
                                                                    <tr class="cart_item align-middle">
                                                                        <td class="item-img text-center">
                                                                            <a href="#">
                                                                                <c:set var="prod" value="${requestScope['product_'.concat(item.cartItemId)]}" />
                                                                                <c:set var="thumb" value="${requestScope['thumbnail_'.concat(item.cartItemId)]}" />
                                                                                <img class="img-fluid" src="${thumb}" alt="${prod.productName}" style="max-width: 80px;">
                                                                            </a>
                                                                        </td>
                                                                        <td class="item-title">
                                                                            <a href="#"><strong>${prod.productName}</strong></a>
                                                                            <p class="variation-info mb-0">
                                                                                <c:set var="color" value="${requestScope['color_'.concat(item.cartItemId)]}" />
                                                                                <c:set var="size" value="${requestScope['size_'.concat(item.cartItemId)]}" />
                                                                                <small>Color: ${color.colorName} | Size: ${size.sizeName}</small>
                                                                            </p>
                                                                        </td>
                                                                        <td class="item-price text-center">
                                                                            <fmt:formatNumber value="${prod.price}" type="currency" />
                                                                        </td>
                                                                        <td class="item-qty text-center">
                                                                            <input type="hidden" name="cartItemId" value="${item.cartItemId}" />
                                                                            <div class="d-flex justify-content-center align-items-center">
                                                                                <div class="qtybutton dec">-</div>
                                                                                <input name="quantity" value="${item.quantity}" class="cart-plus-minus-box mx-2" type="text" />
                                                                                <div class="qtybutton inc">+</div>
                                                                            </div>
                                                                        </td>
                                                                        <td class="total-price text-center">
                                                                            <strong>
                                                                                <fmt:formatNumber value="${prod.price * item.quantity}" type="currency" />
                                                                            </strong>
                                                                        </td>
                                                                        <td class="remove-item text-center">
                                                                            <button type="button" class="btn btn-danger" onclick="removeCartItem(${item.cartItemId})">Remove</button>
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
                                                                        <button type="submit" class="btn btn-primary">Update Cart</button>
                                                                        <a href="${pageContext.request.contextPath}/products" class="btn btn-secondary">Continue Shopping</a>
                                                                    </div>
                                                                    <!-- Promotion Section -->
                                                                    <!-- Promotion code section if needed -->
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
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </form><!-- Kết thúc form cập nhật giỏ hàng -->

                                                <!-- Form thanh toán đặt bên ngoài form cập nhật giỏ hàng -->
                                                <div class="row mt-4">
                                                    <div class="col-lg-8 col-md-7">
                                                    </div>
                                                    <div class="col-lg-4 col-md-5">
                                                        <form action="cart" method="GET" id="checkoutForm">
                                                            <input type="hidden" name="action" value="checkout" />
                                                            
                                                            <div class="payment-methods mb-3 text-start">
                                                                <h6 class="mb-2">Chọn phương thức thanh toán:</h6>
                                                                <!-- <div class="form-check mb-2">
                                                                    <input class="form-check-input" type="radio" name="paymentMethod" value="cod" id="codPayment" checked>
                                                                    <label class="form-check-label" for="codPayment">
                                                                        <i class="fa fa-money text-success"></i> Thanh toán khi nhận hàng (COD)
                                                                    </label>
                                                                </div> -->
                                                                <div class="form-check">
                                                                    <input class="form-check-input" type="radio" name="paymentMethod" value="vnpay" id="vnpayPayment" checked>
                                                                    <label class="form-check-label" for="vnpayPayment">
                                                                        <img src="https://cdn.haitrieu.com/wp-content/uploads/2022/10/Icon-VNPAY-QR.png" alt="VNPAY" style="height: 24px;">
                                                                        Thanh toán qua VNPAY
                                                                    </label>
                                                                </div>
                                                            </div>
                                                            
                                                            <button type="submit" class="btn-def btn2 text-black">Tiến hành thanh toán</button>
                                                        </form>
                                                    </div>
                                                </div>
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

            <!-- jquery latest version -->
        <jsp:include page="../common/home/js-home.jsp"></jsp:include>

        <!-- Optional: Javascript to handle quantity increment/decrement và log chi tiết -->
        <script>
            // Ghi log khi submit form Update Cart
            function logUpdateCart(form) {
                console.log("Update Cart clicked, collecting form data:");
                const cartItemIds = form.querySelectorAll("input[name='cartItemId']");
                const quantities = form.querySelectorAll("input[name='quantity']");
                
                if (cartItemIds.length !== quantities.length) {
                    console.error("Mismatch between cartItemId inputs and quantity inputs.");
                }
                
                cartItemIds.forEach(function(item, index) {
                    console.log("CartItemId: " + item.value + ", Quantity: " + quantities[index].value);
                });
                // Cho phép submit form
                return true;
            }
            
            // Sự kiện xử lý tăng giảm số lượng sản phẩm trên giỏ hàng với log
            document.querySelectorAll('.qtybutton').forEach(function(button) {
                button.addEventListener('click', function(event) {
                    try {
                        event.preventDefault();
                        event.stopPropagation();
                        
                        // Lấy ô input số lượng nằm cùng nhóm nút bấm này
                        var input = this.parentElement.querySelector('.cart-plus-minus-box');
                        console.log(input);
                        console.log(input.value);
                        if (!input) {
                            console.error("Không tìm thấy input .cart-plus-minus-box cho button:", this);
                            return;
                        }
                        
                        var currentVal = parseInt(input.value, 10);
                        console.log("before: " + currentVal);
                        if (isNaN(currentVal)) {
                            console.warn("Giá trị hiện tại không hợp lệ cho input, mặc định về 1. (input: " + input.value + ")");
                            currentVal = 1;
                        }
                        
                        // Nếu bấm nút tăng (+)
                        if (this.classList.contains('inc')) {
                            console.log(currentVal);
                            input.value = currentVal + 1;
                            console.log("Button tăng: Giá trị mới: " + input.value);
                        }
                        // Nếu bấm nút giảm (-) và đảm bảo số lượng không giảm dưới 1
                        else if (this.classList.contains('dec') && currentVal > 1) {
                            input.value = currentVal - 1;
                            console.log("Button giảm: Giá trị mới: " + input.value);
                        } else {
                            console.warn("Nút giảm bị nhấn khi số lượng tối thiểu (1) hoặc không xác định hành động.");
                        }
                    } catch (e) {
                        console.error("Lỗi trong sự kiện thay đổi số lượng:", e);
                    }
                });
            });

            // Hàm này xử lý submit form remove sử dụng form ẩn
            function removeCartItem(cartItemId) {
                document.getElementById("removeCartItemId").value = cartItemId;
                document.getElementById("removeForm").submit();
            }
        </script>

        <!-- Form ẩn dùng để remove sản phẩm - không lồng trong form update -->
        <form id="removeForm" action="cart" method="post" style="display: none;">
            <input type="hidden" name="action" value="remove" />
            <input type="hidden" name="cartItemId" id="removeCartItemId" value=""/>
        </form>

    </body>


    <!-- Mirrored from htmldemo.net/clothing/clothing/cart.html by HTTrack Website Copier/3.x [XR&CO'2014], Sat, 01 Feb 2025 03:37:43 GMT -->
</html>