<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en" data-theme="light">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin - Order Details</title>
    <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/assets/images/favicon.png" sizes="16x16">
    <!-- CSS here -->
    <jsp:include page="../common/dashboard/css-dashboard.jsp"></jsp:include>
    
    <!-- Toast CSS and JS -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/izitoast/1.4.0/js/iziToast.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/izitoast/1.4.0/css/iziToast.min.css">
    <style>
        .iziToast-wrapper {
            z-index: 99999 !important;
        }
        .iziToast {
            min-width: 300px;
        }
        .order-info {
            background-color: #f8f9fa;
            padding: 15px;
            border-radius: 10px;
            margin-bottom: 20px;
        }
        .order-info-item {
            margin-bottom: 10px;
        }
        .order-info-label {
            font-weight: 600;
            color: #495057;
        }
    </style>
</head>
<body>
    <!-- Sidebar -->
    <jsp:include page="../common/dashboard/sidebar-dashboard.jsp"></jsp:include>

    <!-- Header -->
    <jsp:include page="../common/dashboard/header-dashboard.jsp"></jsp:include>

    <div class="dashboard-main-body">
        <div class="d-flex flex-wrap align-items-center justify-content-between gap-3 mb-24">
            <h6 class="fw-semibold mb-0">Order Details</h6>
            <ul class="d-flex align-items-center gap-2">
                <li class="fw-medium">
                    <a href="${pageContext.request.contextPath}/admin/dashboard" class="d-flex align-items-center gap-1 hover-text-primary">
                        <iconify-icon icon="solar:home-smile-angle-outline" class="icon text-lg"></iconify-icon>
                        Dashboard
                    </a>
                </li>
                <li>-</li>
                <li class="fw-medium">
                    <a href="${pageContext.request.contextPath}/admin/orders" class="d-flex align-items-center gap-1 hover-text-primary">
                        Order Management
                    </a>
                </li>
                <li>-</li>
                <li class="fw-medium">Order Details</li>
            </ul>
        </div>

        <div class="card h-100 p-0 radius-12">
            <div class="card-header border-bottom bg-base py-16 px-24 d-flex align-items-center flex-wrap gap-3 justify-content-between">
                <div class="d-flex align-items-center flex-wrap gap-3"> 
                    <h5>Order #${order.shopOrderID}</h5>
                </div>
                
                <div>
                    <a href="${pageContext.request.contextPath}/admin/orders" class="btn btn-outline-primary h-40-px radius-12">
                        <iconify-icon icon="mdi:arrow-left" class="me-2"></iconify-icon>
                        Back to Orders
                    </a>
                </div>
            </div>
            <div class="card-body p-24">
                <!-- Order and Customer Information -->
                <div class="row mb-4">
                    <div class="col-md-6">
                        <div class="order-info">
                            <h6 class="mb-3">Customer Information</h6>
                            <div class="order-info-item">
                                <span class="order-info-label">Customer Name:</span> 
                                <span>${user.firstName} ${user.lastName} (ID: ${user.id})</span>
                            </div>
                            <div class="order-info-item">
                                <span class="order-info-label">Customer Email:</span> 
                                <span>${user.email}</span>
                            </div>
                            <div class="order-info-item">
                                <span class="order-info-label">Customer Phone:</span> 
                                <span>${user.phone}</span>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="order-info">
                            <h6 class="mb-3">Shipping Information</h6>
                            <div class="order-info-item">
                                <span class="order-info-label">Recipient:</span> 
                                <span>${order.recipient}</span>
                            </div>
                            <div class="order-info-item">
                                <span class="order-info-label">Recipient Phone:</span> 
                                <span>${order.recipientPhone}</span>
                            </div>
                            <div class="order-info-item">
                                <span class="order-info-label">Address ID:</span> 
                                <span>${order.addressID}</span>
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- Order Status Management -->
                <div class="row mb-4">
                    <div class="col-12">
                        <div class="order-info">
                            <h6 class="mb-3">Order Status</h6>
                            <div class="order-info-item">
                                <span class="order-info-label">Current Status:</span> 
                                <c:choose>
                                    <c:when test="${order.orderStatus == 1}">
                                        <span class="badge bg-warning">Pending</span>
                                    </c:when>
                                    <c:when test="${order.orderStatus == 2}">
                                        <span class="badge bg-info">Prepared</span>
                                    </c:when>
                                    <c:when test="${order.orderStatus == 3}">
                                        <span class="badge bg-primary">Packaged</span>
                                    </c:when>
                                    <c:when test="${order.orderStatus == 4}">
                                        <span class="badge bg-secondary">Delivering</span>
                                    </c:when>
                                    <c:when test="${order.orderStatus == 5}">
                                        <span class="badge bg-success">Successfully</span>
                                    </c:when>
                                    <c:when test="${order.orderStatus == 6}">
                                        <span class="badge bg-danger">Cancelled</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge bg-secondary">Unknown</span>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                            <div class="order-info-item">
                                <span class="order-info-label">Update Status:</span>
                                <form action="${pageContext.request.contextPath}/admin/orders" method="POST" class="d-flex align-items-center gap-3 mt-2">
                                    <input type="hidden" name="action" value="update-status">
                                    <input type="hidden" name="id" value="${order.shopOrderID}">
                                    <select class="form-select form-select-sm w-auto ps-12 py-6 radius-12 h-40-px" name="status">
                                        <option value="1" ${order.orderStatus == 1 ? 'selected' : ''}>Pending</option>
                                        <option value="2" ${order.orderStatus == 2 ? 'selected' : ''}>Prepared</option>
                                        <option value="3" ${order.orderStatus == 3 ? 'selected' : ''}>Packaged</option>
                                        <option value="4" ${order.orderStatus == 4 ? 'selected' : ''}>Delivering</option>
                                        <option value="5" ${order.orderStatus == 5 ? 'selected' : ''}>Successfully</option>
                                        <option value="6" ${order.orderStatus == 6 ? 'selected' : ''}>Cancelled</option>
                                    </select>
                                    <button type="submit" class="btn btn-primary h-40-px radius-12">Update Status</button>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- Order Details Table -->
                <div class="table-responsive">
                    <table class="table bordered-table sm-table mb-0">
                        <thead>
                            <tr>
                                <th scope="col">Product ID</th>
                                <th scope="col">Product Name</th>
                                <th scope="col">Price</th>
                                <th scope="col">Quantity</th>
                                <th scope="col">Variation ID</th>
                                <th scope="col">Subtotal</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${orderDetails}" var="detail">
                                <tr>
                                    <td>${detail.productID}</td>
                                    <td>
                                        <c:set var="product" value="${productMap[detail.productID]}" />
                                        ${product.productName}
                                    </td>
                                    <td><fmt:formatNumber value="${detail.price}" type="currency" currencySymbol="₫" maxFractionDigits="0"/></td>
                                    <td>${detail.quantity}</td>
                                    <td>${detail.variationID}</td>
                                    <td><fmt:formatNumber value="${detail.price * detail.quantity}" type="currency" currencySymbol="₫" maxFractionDigits="0"/></td>
                                </tr>
                            </c:forEach>
                        </tbody>
                        <tfoot>
                            <tr>
                                <td colspan="5" class="text-end fw-bold">Total:</td>
                                <td class="fw-bold">
                                    <fmt:formatNumber value="${order.orderTotal}" type="currency" currencySymbol="₫" maxFractionDigits="0"/>
                                </td>
                            </tr>
                        </tfoot>
                    </table>
                </div>
            </div>
        </div>
    </div>
    
    <!-- JS here -->
    <jsp:include page="../common/dashboard/js-dashboard.jsp"></jsp:include>

    <script>
        var toastMessage = "${sessionScope.toastMessage}";
        var toastType = "${sessionScope.toastType}";
        if (toastMessage) {
            iziToast.show({
                title: toastType === 'success' ? 'Success' : 'Error',
                message: toastMessage,
                position: 'topRight',
                color: toastType === 'success' ? 'green' : 'red',
                timeout: 5000,
                onClosing: function () {
                    fetch('${pageContext.request.contextPath}/remove-toast', {
                        method: 'POST',
                        headers: {
                            'Content-Type': 'application/x-www-form-urlencoded',
                        },
                    }).then(response => {
                        if (!response.ok) {
                            console.error('Failed to remove toast attributes');
                        }
                    }).catch(error => {
                        console.error('Error:', error);
                    });
                }
            });
        }
    </script>
</body>
</html> 