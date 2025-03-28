<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!doctype html>
<html class="no-js" lang="en">

<head>
    <meta charset="utf-8">
    <meta http-equiv="x-ua-compatible" content="ie=edge">
    <title>Checkout - Clothing Shop</title>
    <meta name="description" content="Clothing eCommerce Fashion Template">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <link rel="shortcut icon" type="image/x-icon" href="images/icons/favicon.png">
    <!-- Place favicon.png in the root directory -->

    <!-- All css files are included here. -->
    <!-- Bootstrap fremwork main css -->
    <jsp:include page="../common/home/css-home.jsp"></jsp:include>

    <!-- Additional Custom Styles -->
    <style>
        /* Tùy chỉnh thêm để làm đẹp giao diện Checkout */
        .checkout-area {
            background: #fff;
            border-radius: 8px;
            padding: 30px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        .order-details {
            background: #f8f9fa;
            border-radius: 8px;
            padding: 20px;
        }
        .form-control:focus {
            border-color: #80bdff;
            box-shadow: 0 0 0 0.2rem rgba(0, 123, 255, 0.25);
        }
        .payment-method-item {
            border: 1px solid #dee2e6;
            border-radius: 8px;
            padding: 15px;
            margin-bottom: 15px;
            transition: all 0.3s;
        }
        .payment-method-item:hover, .payment-method-item.active {
            border-color: #007bff;
            background-color: #f0f7ff;
        }
        .payment-method-item img {
            height: 30px;
            margin-right: 10px;
        }
    </style>

    <!-- Modernizr JS -->
    <script src="js/vendor/modernizr-3.11.2.min.js"></script>
</head>

<body>
    <!-- Body main wrapper start -->
    <div class="wrapper cart">

        <!-- Start of header area -->
        <jsp:include page="../common/home/header-homepage.jsp"></jsp:include>
        <!-- End of header area -->

        <!--breadcumb area start -->
        <div class="breadcumb-area overlay pos-rltv py-4" style="background: url('assets/images/breadcrumb.jpg'); background-size: cover;">
            <div class="container">
                <div class="bread-main text-center text-white">
                    <h5>Checkout Details</h5>
                    <ol class="breadcrumb justify-content-center">
                        <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/home" class="text-white">Home</a></li>
                        <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/cart" class="text-white">Cart</a></li>
                        <li class="breadcrumb-item active text-white">Checkout Details</li>
                    </ol>
                </div>
            </div>
        </div>
        <!--breadcumb area end -->

        <!--checkout area start-->
        <div class="checkout-area pt-30 pb-60">
            <div class="container">
                <!-- Checkout progress indicator -->
                <div class="row mb-4">
                    <div class="col-12">
                        <div class="checkout-progress-bar">
                            <div class="progress rounded-pill" style="height: 15px;">
                                <div class="progress-bar bg-primary" role="progressbar" style="width: 66%;" aria-valuenow="66" aria-valuemin="0" aria-valuemax="100"></div>
                            </div>
                            <div class="d-flex justify-content-between mt-2">
                                <div class="text-primary"><i class="fa fa-check-circle"></i> Cart</div>
                                <div class="text-primary fw-bold"><i class="fa fa-circle"></i> Details</div>
                                <div class="text-muted">Payment</div>
                            </div>
                        </div>
                    </div>
                </div>
                
                <div class="row">
                    <div class="col-lg-12">
                        <c:if test="${not empty errorMessage}">
                            <div class="alert alert-danger">${errorMessage}</div>
                        </c:if>
                        <c:if test="${not empty successMessage}">
                            <div class="alert alert-success">${successMessage}</div>
                        </c:if>
                    </div>
                </div>
                
                <div class="row">
                    <!-- Shipping Information Form -->
                    <div class="col-lg-7">
                        <div class="checkout-area mb-4">
                            <div class="catagory-title mb-3">
                                <h3>Shipping Information</h3>
                            </div>
                            
                            <form action="${pageContext.request.contextPath}/cart" method="post">
                                <input type="hidden" name="action" value="processCheckout">
                                
                                <div class="row">
                                    <div class="col-md-6 mb-3">
                                        <label for="firstName">First Name</label>
                                        <input type="text" class="form-control" id="firstName" name="firstName" value="${sessionScope.account.firstName}" required>
                                    </div>
                                    <div class="col-md-6 mb-3">
                                        <label for="lastName">Last Name</label>
                                        <input type="text" class="form-control" id="lastName" name="lastName" value="${sessionScope.account.lastName}" required>
                                    </div>
                                </div>
                                
                                <div class="mb-3">
                                    <label for="email">Email</label>
                                    <input type="email" class="form-control" id="email" name="email" value="${sessionScope.account.email}" required>
                                </div>
                                
                                <div class="mb-3">
                                    <label for="phone">Phone Number</label>
                                    <input type="tel" class="form-control" id="phone" name="phone" value="${sessionScope.account.phone}" required>
                                </div>
                                
                                <div class="mb-3">
                                    <label for="addressLine">Address Line</label>
                                    <input type="text" class="form-control" id="addressLine" name="addressLine" placeholder="Street address, apartment, suite, etc." required>
                                </div>
                                
                                <div class="row">
                                    <div class="col-md-6 mb-3">
                                        <label for="country">Country</label>
                                        <select class="form-control" id="country" name="countryID" required>
                                            <option value="1" >Việt Nam</option>
                                         
                                        </select> 
                                    </div>
                                    <div class="col-md-6 mb-3">
                                        <label for="postalCode">Postal Code</label>
                                        <input type="text" class="form-control" id="postalCode" name="postalCode" placeholder="Postal/ZIP code" required>
                                    </div>
                                </div>
                                
                                <div class="row">
                                    <div class="col-md-4 mb-3">
                                        <label for="province">Province/City</label>
                                        <select class="form-control" id="province" name="province" required>
                                            <option value="">Select Province/City</option>
                                        </select>
                                    </div>
                                    <div class="col-md-4 mb-3">
                                        <label for="district">District</label>
                                        <select class="form-control" id="district" name="district" disabled required>
                                            <option value="">Select District</option>
                                        </select>
                                    </div>
                                    <div class="col-md-4 mb-3">
                                        <label for="ward">Ward</label>
                                        <select class="form-control" id="ward" name="ward" disabled required>
                                            <option value="">Select Ward</option>
                                        </select>
                                    </div>
                                </div>
                                
                                <div class="mb-3">
                                    <label for="notes">Order Notes (Optional)</label>
                                    <textarea class="form-control" id="notes" name="notes" rows="3" placeholder="Notes about your order, e.g. special delivery instructions"></textarea>
                                </div>
                                
                                <!-- Payment Methods Section -->
                                <div class="payment-methods mt-4">
                                    <h5 class="mb-3">Payment Method</h5>
                                    
                                    <div class="payment-method-item active p-3">
                                        <div class="form-check">
                                            <input class="form-check-input" type="radio" name="paymentMethod" value="vnpay" id="vnpayPayment" checked>
                                            <label class="form-check-label d-flex align-items-center" for="vnpayPayment">
                                                <img src="https://cdn.haitrieu.com/wp-content/uploads/2022/10/Icon-VNPAY-QR.png" alt="VNPAY" style="height: 40px; margin-right: 15px;">
                                                <div>
                                                    <span class="fw-bold d-block">Thanh toán qua VNPAY</span>
                                                    <small class="text-muted">Secure online payment via VNPAY gateway</small>
                                                </div>
                                            </label>
                                        </div>
                                    </div>
                                    
                                    <div class="payment-method-item p-3 mt-2">
                                        <div class="form-check">
                                            <input class="form-check-input" type="radio" name="paymentMethod" value="cod" id="codPayment">
                                            <label class="form-check-label d-flex align-items-center" for="codPayment">
                                                <i class="fa fa-money text-success" style="font-size: 32px; margin-right: 15px;"></i>
                                                <div>
                                                    <span class="fw-bold d-block">Thanh toán khi nhận hàng (COD)</span>
                                                    <small class="text-muted">Pay in cash when you receive your order</small>
                                                </div>
                                            </label>
                                        </div>
                                    </div>
                                </div>
                                
                                <!-- Privacy Policy Note -->
                                <div class="privacy-note mt-3 mb-4 small text-muted">
                                    Your personal data will be used to process your order, support your experience throughout this website, and for other purposes described in our 
                                    <a href="privacy-policy">privacy policy</a>.
                                </div>
                                
                                <!-- Add hidden fields to store the names -->
                                <input type="hidden" id="provinceName" name="provinceName" value="">
                                <input type="hidden" id="districtName" name="districtName" value="">
                                <input type="hidden" id="wardName" name="wardName" value="">
                                
                                <div class="text-end mt-4">
                                    <a href="${pageContext.request.contextPath}/cart" class="btn btn-outline-secondary">Back to Cart</a>
                                    <c:choose>
                                        <c:when test="${empty cartItemDetails || cartItemDetails.size() == 0}">
                                            <button type="button" class="btn btn-primary btn-lg ms-2 disabled" 
                                                    data-bs-toggle="tooltip" data-bs-placement="top" 
                                                    title="Your cart is empty">
                                                <i class="fa fa-check"></i> Place Order
                                            </button>
                                        </c:when>
                                        <c:otherwise>
                                            <button type="submit" class="btn btn-primary btn-lg ms-2">
                                                <i class="fa fa-check"></i> Place Order
                                            </button>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </form>
                        </div>
                    </div>
                    
                    <!-- Order Summary -->
                    <div class="col-lg-5">
                        <div class="order-details mb-4">
                            <div class="catagory-title mb-3">
                                <h3>ORDER SUMMARY</h3>
                            </div>
                            
                            <div class="table-responsive mb-4">
                                <table class="table">
                                    <thead>
                                        <tr>
                                            <th>Product</th>
                                            <th class="text-end">Subtotal</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach items="${cartItemDetails}" var="item">
                                            <tr>
                                                <td>
                                                    <div class="d-flex align-items-center">
                                                        <img src="${item.imageUrl}" alt="${item.product.productName}" style="width: 50px; height: 50px; object-fit: cover; margin-right: 10px;">
                                                        <div>
                                                            <div>${item.product.productName} × ${item.cartItem.quantity}</div>
                                                            <div class="small text-muted">
                                                                Color: ${item.color.colorName} | Size: ${item.size.sizeName}
                                                            </div>
                                                        </div>
                                                    </div>
                                                </td>
                                                <td class="text-end"><fmt:formatNumber value="${item.itemTotal}" type="currency" /></td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                    <tfoot>
                                        <tr>
                                            <th>Subtotal</th>
                                            <td class="text-end"><fmt:formatNumber value="${total}" type="currency"/></td>
                                        </tr>
                                        <c:if test="${discount > 0}">
                                            <tr>
                                                <th>Discount</th>
                                                <td class="text-end text-danger">-<fmt:formatNumber value="${discount}" type="currency"/></td>
                                            </tr>
                                        </c:if>
                                        <tr>
                                            <th>Shipping</th>
                                            <td class="text-end"><fmt:formatNumber value="3" type="currency"/></td>
                                        </tr>
                                        <tr>
                                            <th>Total</th>
                                            <td class="text-end fw-bold"><fmt:formatNumber value="${finalTotal + 3}" type="currency"/></td>
                                        </tr>
                                    </tfoot>
                                </table>
                            </div>
                            
                            <!-- What You'll Get Section -->
                            <div class="what-you-get mb-4">
                                <h5 class="mb-3">What You'll Get:</h5>
                                <ul class="list-unstyled">
                                    <li class="d-flex align-items-center mb-2">
                                        <i class="fa fa-check-circle text-success me-2"></i>
                                        <span>Full lifetime access to all product features</span>
                                    </li>
                                    <li class="d-flex align-items-center mb-2">
                                        <i class="fa fa-check-circle text-success me-2"></i>
                                        <span>Free shipping for orders over $50</span>
                                    </li>
                                    <li class="d-flex align-items-center mb-2">
                                        <i class="fa fa-check-circle text-success me-2"></i>
                                        <span>30-day money-back guarantee</span>
                                    </li>
                                    <li class="d-flex align-items-center mb-2">
                                        <i class="fa fa-check-circle text-success me-2"></i>
                                        <span>24/7 customer support</span>
                                    </li>
                                </ul>
                            </div>
                            
                            <!-- Order summary note -->
                            <div class="bg-light p-3 mb-3 rounded">
                                <h5 class="text-center mb-3">Order Overview</h5>
                                <div class="d-flex justify-content-between mb-2">
                                    <span>Total Items:</span>
                                    <span>${cartItemDetails.size()}</span>
                                </div>
                                <div class="d-flex justify-content-between mb-2">
                                    <span>Shipping Method:</span>
                                    <span>Standard Delivery</span>
                                </div>
                                <div class="d-flex justify-content-between text-primary fw-bold">
                                    <span>Final Total:</span>
                                    <span><fmt:formatNumber value="${finalTotal + 3}" type="currency"/></span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!--checkout area end-->

        <!-- footer area start-->
        <jsp:include page="../common/home/footer-homepage.jsp"></jsp:include>
        <!--footer area end-->

        <!--footer bottom area start-->
        <div class="footer-bottom global-table">
            <div class="global-row">
                <div class="global-cell">
                    <div class="container">
                        <div class="row">
                            <div class="col-md-6">
                                <p class="copyrigth text-center">
                                    © 2022 <span class="text-capitalize">clothing</span>. Made
                                    with <i style="color: #f53400;" class="fa fa-heart"></i>
                                    by
                                    <a href="https://themeforest.net/user/codecarnival/portfolio">CodeCarnival</a>
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

    <!-- Vietnam Province/District/Ward API -->
    <script>
        document.addEventListener('DOMContentLoaded', function () {
            const provinceSelect = document.getElementById('province');
            const districtSelect = document.getElementById('district');
            const wardSelect = document.getElementById('ward');
            
            // Hidden fields for names
            const provinceNameField = document.getElementById('provinceName');
            const districtNameField = document.getElementById('districtName');
            const wardNameField = document.getElementById('wardName');
            
            // Load tỉnh/thành phố
            fetch('https://provinces.open-api.vn/api/p/')
                .then(res => res.json())
                .then(provinces => {
                    provinces.forEach(p => {
                        const option = document.createElement('option');
                        option.value = p.name; // Store name as value instead of code
                        option.textContent = p.name;
                        option.dataset.code = p.code; // Store code as data attribute
                        provinceSelect.appendChild(option);
                    });
                })
                .catch(err => console.error('Lỗi khi tải tỉnh/thành phố:', err));
            
            // Khi chọn tỉnh
            provinceSelect.addEventListener('change', function () {
                const selectedOption = this.options[this.selectedIndex];
                const provinceCode = selectedOption.dataset.code;
                const provinceName = this.value;
                
                // Store the province name
                provinceNameField.value = provinceName;
                
                // Reset quận và phường
                districtSelect.innerHTML = '<option value="">Select District</option>';
                wardSelect.innerHTML = '<option value="">Select Ward</option>';
                wardSelect.disabled = true;
                districtNameField.value = '';
                wardNameField.value = '';
                
                if (provinceCode) {
                    districtSelect.disabled = false;
                    fetch(`https://provinces.open-api.vn/api/p/` + provinceCode + `?depth=2`)
                        .then(res => res.json())
                        .then(data => {
                            data.districts.forEach(d => {
                                const option = document.createElement('option');
                                option.value = d.name; // Store name as value
                                option.textContent = d.name;
                                option.dataset.code = d.code; // Store code as data attribute
                                districtSelect.appendChild(option);
                            });
                        })
                        .catch(err => console.error('Lỗi khi tải quận/huyện:', err));
                } else {
                    districtSelect.disabled = true;
                }
            });
            
            // Khi chọn quận/huyện
            districtSelect.addEventListener('change', function () {
                const selectedOption = this.options[this.selectedIndex];
                const districtCode = selectedOption.dataset.code;
                const districtName = this.value;
                
                // Store the district name
                districtNameField.value = districtName;
                
                // Reset phường
                wardSelect.innerHTML = '<option value="">Select Ward</option>';
                wardNameField.value = '';
                
                if (districtCode) {
                    wardSelect.disabled = false;
                    fetch(`https://provinces.open-api.vn/api/d/` + districtCode + `?depth=2`)
                        .then(res => res.json())
                        .then(data => {
                            data.wards.forEach(w => {
                                const option = document.createElement('option');
                                option.value = w.name; // Store name as value
                                option.textContent = w.name;
                                option.dataset.code = w.code; // Store code as data attribute
                                wardSelect.appendChild(option);
                            });
                        })
                        .catch(err => console.error('Lỗi khi tải phường/xã:', err));
                } else {
                    wardSelect.disabled = true;
                }
            });
            
            // Khi chọn phường/xã
            wardSelect.addEventListener('change', function() {
                // Store the ward name
                wardNameField.value = this.value;
            });
            
            // Set up event listeners for payment method selection
            document.querySelectorAll('.payment-method-item').forEach(item => {
                item.addEventListener('click', function() {
                    // Remove active class from all items
                    document.querySelectorAll('.payment-method-item').forEach(i => {
                        i.classList.remove('active');
                    });
                    
                    // Add active class to clicked item
                    this.classList.add('active');
                    
                    // Check the radio button inside this item
                    const radio = this.querySelector('input[type="radio"]');
                    if (radio) {
                        radio.checked = true;
                    }
                });
            });
        });
    </script>
    
</body>
</html>