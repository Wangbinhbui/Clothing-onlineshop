<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en" data-theme="light">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Store 24 - Order History</title>
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
            </style>
        </head>
        <body>
            <!-- Sidebar -->
        <jsp:include page="../common/dashboard/sidebar-dashboard.jsp"></jsp:include>

            <!-- Header -->
        <jsp:include page="../common/dashboard/header-dashboard.jsp"></jsp:include>

            <!-- Setup proper base URL for pagination -->
        <c:set var="baseUrl" value="${pageContext.request.contextPath}/order-history"/>
        <c:choose>
            <c:when test="${not empty statusFilter}">
                <c:set var="queryParams" value="status=${statusFilter}&"/>
            </c:when>
            <c:otherwise>
                <c:set var="queryParams" value=""/>
            </c:otherwise>
        </c:choose>

        <div class="dashboard-main-body">
            <div class="d-flex flex-wrap align-items-center justify-content-between gap-3 mb-24">
                <h6 class="fw-semibold mb-0">Order History</h6>
                <ul class="d-flex align-items-center gap-2">
                    <li class="fw-medium">
                        <a href="${pageContext.request.contextPath}/" class="d-flex align-items-center gap-1 hover-text-primary">
                            <iconify-icon icon="solar:home-smile-angle-outline" class="icon text-lg"></iconify-icon>
                            Home
                        </a>
                    </li>
                    <li>-</li>
                    <li class="fw-medium">Order History</li>
                </ul>
            </div>

            <div class="card h-100 p-0 radius-12">
                <div class="card-header border-bottom bg-base py-16 px-24 d-flex align-items-center flex-wrap gap-3 justify-content-between">
                    <div class="d-flex align-items-center flex-wrap gap-3"> 
                        <form action="${baseUrl}" method="GET" class="d-flex align-items-center gap-3">
                            <select class="form-select form-select-sm w-auto ps-12 py-6 radius-12 h-40-px" name="status">
                                <option value="">All Status</option>
                                <option value="1" ${statusFilter == '1' ? 'selected' : ''}>Pending</option>
                                <option value="2" ${statusFilter == '2' ? 'selected' : ''}>Prepared</option>
                                <option value="3" ${statusFilter == '3' ? 'selected' : ''}>Packaged</option>
                                <option value="4" ${statusFilter == '4' ? 'selected' : ''}>Delivering</option>
                                <option value="5" ${statusFilter == '5' ? 'selected' : ''}>Successfully</option>
                                <option value="6" ${statusFilter == '6' ? 'selected' : ''}>Cancelled</option>
                            </select>
                            <button type="submit" class="btn btn-primary h-40-px radius-12">Filter</button>
                        </form>
                    </div>
                </div>
                <div class="card-body p-24">
                    <div class="table-responsive scroll-sm">
                        <table class="table bordered-table sm-table mb-0">
                            <thead>
                                <tr>
                                    <th scope="col">Order ID</th>   
                                    <th scope="col">Recipient</th>
                                    <th scope="col">Phone</th>                                       
                                    <th scope="col">Total</th>
                                    <th scope="col">Status</th>
                                    <th scope="col" class="text-center">Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="order" items="${orders}">
                                    <tr>
                                        <td>${order.shopOrderID}</td>   
                                        <td>${order.recipient}</td>
                                        <td>${order.recipientPhone}</td>
                                        <td>
                                            <fmt:formatNumber value="${order.orderTotal}" type="currency" 
                                                              currencySymbol="đ" maxFractionDigits="0"/>
                                        </td>
                                        <td>
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
                                        </td>
                                        <td class="text-center"> 
                                            <div class="d-flex align-items-center gap-10 justify-content-center">
                                                <a href="${pageContext.request.contextPath}/order-history?action=details&id=${order.shopOrderID}" 
                                                   class="bg-success-focus text-success-600 bg-hover-success-200 fw-medium w-40-px h-40-px
                                                   d-flex justify-content-center align-items-center rounded-circle"> 
                                                    <iconify-icon icon="ion:eye-outline" class="menu-icon"></iconify-icon>
                                                </a>
                                                <c:if test="${order.orderStatus == 1}">
                                                    <button type="button" 
                                                            class="bg-danger-focus bg-hover-danger-200 text-danger-600 fw-medium w-40-px
                                                            h-40-px d-flex justify-content-center align-items-center rounded-circle"
                                                            onclick="confirmCancel('${order.shopOrderID}')"> 
                                                        <iconify-icon icon="material-symbols:cancel-outline" class="menu-icon"></iconify-icon>
                                                    </button>
                                                </c:if>
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
                                <c:if test="${empty orders}">
                                    <tr>
                                        <td colspan="6" class="text-center">No orders found</td>
                                    </tr>
                                </c:if>
                            </tbody>
                        </table>
                    </div>

                    <!-- Pagination -->
                    <div class="d-flex align-items-center justify-content-between flex-wrap gap-2 mt-24">
                        <ul class="pagination d-flex flex-wrap align-items-center gap-2 justify-content-center">
                            <c:if test="${currentPage > 1}">
                                <li class="page-item">
                                    <a class="page-link bg-neutral-200 text-secondary-light fw-semibold radius-8 border-0
                                       d-flex align-items-center justify-content-center h-32-px w-32-px text-md" 
                                       href="${baseUrl}?${queryParams}page=${currentPage - 1}">
                                        <iconify-icon icon="ep:d-arrow-left" class=""/>
                                    </a>
                                </li>
                            </c:if> 
                            <c:forEach begin="1" end="${totalPages}" var="i">
                                <li class="page-item">
                                    <a class="page-link ${currentPage == i ? 'bg-primary text-white' : 
                                                          'bg-neutral-200 text-secondary-emphasis'} fw-semibold radius-8 border-0 d-flex
                                       align-items-center justify-content-center h-32-px w-32-px" 
                                       href="${baseUrl}?${queryParams}page=${i}">${i}
                                    </a>
                                </li>
                            </c:forEach>
                            <c:if test="${currentPage < totalPages}">                               
                                <li class="page-item">
                                    <a class="page-link bg-neutral-200 text-secondary-light fw-semibold radius-8 border-0
                                       d-flex align-items-center justify-content-center h-32-px w-32-px text-md" 
                                       href="${baseUrl}?${queryParams}page=${currentPage + 1}">
                                        <iconify-icon icon="ep:d-arrow-right" class=""/>
                                    </a>
                                </li>
                            </c:if>
                        </ul>
                    </div>
                </div>
            </div>
        </div>

        <!-- JS here -->
        <jsp:include page="../common/dashboard/js-dashboard.jsp"></jsp:include>

            <script>
                function confirmCancel(orderId) {
                    if (confirm('Are you sure you want to cancel this order? This action cannot be undone.')) {
                        // Submit form to cancel the order
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

                // Toast message display using iziToast
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
                            // Remove toast attributes from session after displaying
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