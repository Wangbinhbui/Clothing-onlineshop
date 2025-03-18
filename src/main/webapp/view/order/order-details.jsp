<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en" data-theme="light">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Store 24 - Order Details</title>
    <link rel="icon" type="image/png" href="assets/images/favicon.png" sizes="16x16">
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
                    <a href="${pageContext.request.contextPath}/" class="d-flex align-items-center gap-1 hover-text-primary">
                        <iconify-icon icon="solar:home-smile-angle-outline" class="icon text-lg"></iconify-icon>
                        Home
                    </a>
                </li>
                <li>-</li>
                <li class="fw-medium">
                    <a href="${pageContext.request.contextPath}/order-history" class="d-flex align-items-center gap-1 hover-text-primary">
                        Order History
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
                    <a href="${pageContext.request.contextPath}/order-history" class="btn btn-outline-primary h-40-px radius-12">
                        <iconify-icon icon="material-symbols:arrow-back" class="me-2"></iconify-icon>
                        Back to Order History
                    </a>
                    <c:if test="${order.orderStatus == 1}">
                        <button type="button" class="btn btn-danger h-40-px radius-12" onclick="confirmCancel(${order.shopOrderID})">
                            <iconify-icon icon="material-symbols:cancel-outline" class="me-2"></iconify-icon>
                            Cancel Order
                        </button>
                    </c:if>
                </div>
            </div>
            
            <div class="card-body p-24">
                <!-- Order Information Section -->
                <div class="row mb-4">
                    <div class="col-md-6">
                        <div class="order-info">
                            <h6 class="mb-3">Order Information</h6>
                            <div class="order-info-item">
                                <span class="order-info-label">Order ID:</span> 
                                <span>${order.shopOrderID}</span>
                            </div>
                            <div class="order-info-item">
                                <span class="order-info-label">Recipient:</span> 
                                <span>${order.recipient}</span>
                            </div>
                            <div class="order-info-item">
                                <span class="order-info-label">Phone:</span> 
                                <span>${order.recipientPhone}</span>
                            </div>
                            <div class="order-info-item">
                                <span class="order-info-label">Status:</span> 
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
                                        <span class="badge bg-success">Cancelled</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge bg-secondary">Unknown</span>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="order-info">
                            <h6 class="mb-3">Payment Information</h6>
                            <div class="order-info-item">
                                <span class="order-info-label">Total Amount:</span> 
                                <span class="fw-bold text-primary">
                                    <fmt:formatNumber value="${order.orderTotal}" type="currency" currencySymbol="đ" maxFractionDigits="0"/>
                                </span>
                            </div>
                            <div class="order-info-item">
                                <span class="order-info-label">Payment Method:</span> 
                                <span>Cash on Delivery</span>
                            </div>
                            <c:if test="${orderDetails[0].orderDate != null}">
                                <div class="order-info-item">
                                    <span class="order-info-label">Order Date:</span> 
                                    <span><fmt:formatDate value="${orderDetails[0].orderDate}" pattern="dd/MM/yyyy"/></span>
                                </div>
                            </c:if>
                        </div>
                    </div>
                </div>
                
                <!-- Order Items Section -->
                <h6 class="mb-3">Order Items</h6>
                <div class="table-responsive scroll-sm">
                    <table class="table bordered-table sm-table mb-0">
                        <thead>
                            <tr>
                                <th scope="col">#</th>
                                <th scope="col">Product</th>
                                <th scope="col">Variation</th>
                                <th scope="col">Unit Price</th>
                                <th scope="col">Quantity</th>
                                <th scope="col">Subtotal</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="detail" items="${orderDetails}" varStatus="status">
                                <tr>
                                    <td>${status.index + 1}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${not empty productMap[detail.productID]}">
                                                ${productMap[detail.productID].productName}
                                            </c:when>
                                            <c:otherwise>
                                                Product ID: ${detail.productID}
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <c:if test="${detail.variationID != null}">
                                            Variation ID: ${detail.variationID}
                                        </c:if>
                                    </td>
                                    <td><fmt:formatNumber value="${detail.price}" type="currency" currencySymbol="đ" maxFractionDigits="0"/></td>
                                    <td>${detail.quantity}</td>
                                    <td><fmt:formatNumber value="${detail.price * detail.quantity}" type="currency" currencySymbol="đ" maxFractionDigits="0"/></td>
                                </tr>
                            </c:forEach>
                            <c:if test="${empty orderDetails}">
                                <tr>
                                    <td colspan="6" class="text-center">No items found for this order</td>
                                </tr>
                            </c:if>
                        </tbody>
                        <tfoot>
                            <tr>
                                <td colspan="5" class="text-end fw-bold">Total:</td>
                                <td class="fw-bold text-primary">
                                    <fmt:formatNumber value="${order.orderTotal}" type="currency" currencySymbol="đ" maxFractionDigits="0"/>
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
        function confirmCancel(orderId) {
            if (confirm('Are you sure you want to cancel this order? This action cannot be undone.')) {
                const form = document.createElement('form');
                form.method = 'POST';
                form.action = '${pageContext.request.contextPath}/order-history';
                
                const actionInput = document.createElement('input');
                actionInput.type = 'hidden';
                actionInput.name = 'action';
                actionInput.value = 'cancel';
                
                const orderIdInput = document.createElement('input');
                orderIdInput.type = 'hidden';
                orderIdInput.name = 'id';
                orderIdInput.value = orderId;
                
                form.appendChild(actionInput);
                form.appendChild(orderIdInput);
                document.body.appendChild(form);
                form.submit();
            }
        }
        
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