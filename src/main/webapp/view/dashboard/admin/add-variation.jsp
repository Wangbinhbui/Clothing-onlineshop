<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en" data-theme="light">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Add Variation</title>
        <link rel="icon" type="image/png" href="assets/images/favicon.png" sizes="16x16">
        <jsp:include page="../../common/dashboard/css-dashboard.jsp"></jsp:include>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    </head>
    <body>
        <jsp:include page="../../common/dashboard/sidebar-dashboard.jsp"></jsp:include>
        <jsp:include page="../../common/dashboard/header-dashboard.jsp"></jsp:include>

        <!-- Toast Container for Notifications -->
        <div class="toast-container position-fixed top-0 end-0 p-3" style="z-index: 1050;">
            <c:if test="${not empty successMessage}">
                <div id="successToast" class="toast align-items-center text-white bg-success border-0 shadow-lg" role="alert" aria-live="assertive" aria-atomic="true">
                    <div class="d-flex">
                        <div class="toast-body d-flex align-items-center">
                            <i class="fa fa-check-circle me-2" style="font-size: 1.2rem;"></i>
                            <span>${successMessage}</span>
                        </div>
                        <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast" aria-label="Close"></button>
                    </div>
                </div>
                <% session.removeAttribute("successMessage"); %>
            </c:if>
            <c:if test="${not empty errorMessage}">
                <div id="errorToast" class="toast align-items-center text-white bg-danger border-0 shadow-lg" role="alert" aria-live="assertive" aria-atomic="true">
                    <div class="d-flex">
                        <div class="toast-body d-flex align-items-center">
                            <i class="fa fa-exclamation-circle me-2" style="font-size: 1.2rem;"></i>
                            <span>${errorMessage}</span>
                        </div>
                        <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast" aria-label="Close"></button>
                    </div>
                </div>
                <% session.removeAttribute("errorMessage"); %>
            </c:if>
        </div>

        <div class="dashboard-main-body">
            <div class="d-flex flex-wrap align-items-center justify-content-between gap-3 mb-24">
                <h6 class="fw-semibold mb-0">Add New Variation</h6>
                <ul class="d-flex align-items-center gap-2">
                    <li class="fw-medium">
                        <a href="index.html" class="d-flex align-items-center gap-1 hover-text-primary">
                            <iconify-icon icon="solar:home-smile-angle-outline" class="icon text-lg"></iconify-icon>
                            Dashboard
                        </a>
                    </li>
                    <li>-</li>
                    <li class="fw-medium">Add Variation</li>
                </ul>
            </div>

            <div class="card h-100 p-0 radius-12">
                <div class="card-header border-bottom bg-base py-16 px-24">
                    <h6 class="fw-semibold mb-0">Variation Information</h6>
                </div>
                <div class="card-body p-24">
                    <form action="${pageContext.request.contextPath}/manage-variation" method="POST" enctype="multipart/form-data">
                        <input type="hidden" name="action" value="add">
                        <input type="hidden" name="productId" value="${productId}">
                        
                        <div class="row mb-3">
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label for="colorId" class="form-label">Color</label>
                                    <select class="form-select" id="colorId" name="colorId" required>
                                        <c:forEach var="color" items="${colorList}">
                                            <option value="${color.colorID}">${color.colorName}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                                
                                <div class="mb-3">
                                    <label for="qtyInStock" class="form-label">Quantity in Stock</label>
                                    <input type="number" class="form-control" id="qtyInStock" name="qtyInStock" required>
                                </div>
                            </div>
                            
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label for="sizeId" class="form-label">Size</label>
                                    <select class="form-select" id="sizeId" name="sizeId" required>
                                        <c:forEach var="size" items="${sizeList}">
                                            <option value="${size.sizeID}">${size.sizeName}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                                
                                <div class="mb-3">
                                    <label for="productImg" class="form-label">Product Image</label>
                                    <input type="file" class="form-control" id="productImg" name="productImg" accept="image/*" required>
                                    <div class="form-text text-muted">Upload an image for this product variation (required)</div>
                                </div>
                            </div>
                        </div>
                        
                        <div class="d-flex justify-content-end gap-2">
                            <a href="${pageContext.request.contextPath}/manage-products" class="btn btn-secondary">Cancel</a>
                            <button type="submit" class="btn btn-primary">Add Variation</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        
        <jsp:include page="../../common/dashboard/js-dashboard.jsp"></jsp:include>
        
        <!-- Toast initialization script -->
        <script>
            document.addEventListener('DOMContentLoaded', function() {
                // Initialize and show toasts if they exist
                var successToast = document.getElementById('successToast');
                var errorToast = document.getElementById('errorToast');
                
                // Toast options
                var toastOptions = {
                    delay: 4500,
                    animation: true,
                    autohide: true
                };
                
                if (successToast) {
                    var toast = new bootstrap.Toast(successToast, toastOptions);
                    toast.show();
                    
                    // Auto remove toast element after hiding
                    successToast.addEventListener('hidden.bs.toast', function() {
                        successToast.remove();
                    });
                }
                
                if (errorToast) {
                    var toast = new bootstrap.Toast(errorToast, toastOptions);
                    toast.show();
                    
                    // Auto remove toast element after hiding
                    errorToast.addEventListener('hidden.bs.toast', function() {
                        errorToast.remove();
                    });
                }
            });
        </script>
    </body>
</html> 