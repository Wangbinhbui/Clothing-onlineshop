<%-- 
    Document   : product-details
    Created on : Mar 17, 2025, 4:44:24 PM
    Author     : PC
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en" data-theme="light">
    <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Store 24 - Product Details</title>
    <link rel="icon" type="image/png" href="assets/images/favicon.png" sizes="16x16">
    <!-- CSS here -->
    <jsp:include page="../../common/dashboard/css-dashboard.jsp"></jsp:include>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    </head>
    <body>
    <!-- Sidebar -->
    <jsp:include page="../../common/dashboard/sidebar-dashboard.jsp"></jsp:include>

    <!-- Header -->
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
            <h6 class="fw-semibold mb-0">Product Details</h6>
            <ul class="d-flex align-items-center gap-2">
                <li class="fw-medium">
                    <a href="index.html" class="d-flex align-items-center gap-1 hover-text-primary">
                        <iconify-icon icon="solar:home-smile-angle-outline" class="icon text-lg"></iconify-icon>
                        Dashboard
                    </a>
                </li>
                <li>-</li>
                <li class="fw-medium">
                    <a href="${pageContext.request.contextPath}/manage-products" class="hover-text-primary">Products List</a>
                </li>
                <li>-</li>
                <li class="fw-medium">Product Details</li>
            </ul>
        </div>

        <div class="card h-100 p-0 radius-12">
            <div class="card-header border-bottom bg-base py-16 px-24">
                <h6 class="fw-semibold mb-0">Product Information</h6>
            </div>
            <div class="card-body p-24">
                <form action="${pageContext.request.contextPath}/manage-products" method="POST">
                    <input type="hidden" name="action" value="update">
                    <input type="hidden" name="id" value="${product.productID}">
                    
                    <div class="row mb-3">
                        <div class="col-md-6">
                            <div class="mb-3">
                                <label for="productName" class="form-label">Product Name</label>
                                <input type="text" class="form-control" id="productName" name="productName" value="${product.productName}" required>
                            </div>
                            
                            <div class="mb-3">
                                <label for="price" class="form-label">Price</label>
                                <input type="number" step="0.01" class="form-control" id="price" name="price" value="${product.price}" required>
                            </div>
                            
                            <div class="mb-3">
                                <label for="categoryId" class="form-label">Category</label>
                                <select class="form-select" id="categoryId" name="categoryId" required>
                                    <c:forEach var="category" items="${categories}">
                                        <option value="${category.categoryID}" ${category.categoryID == product.categoryID ? 'selected' : ''}>${category.categoryName}</option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>
                        
                        <div class="col-md-6">
                            <div class="mb-3">
                                <label for="collectionId" class="form-label">Collection</label>
                                <select class="form-select" id="collectionId" name="collectionId" required>
                                    <c:forEach var="collection" items="${collections}">
                                        <option value="${collection.collectionID}" ${collection.collectionID == product.collectionID ? 'selected' : ''}>${collection.collectionName}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            
                            <div class="mb-3">
                                <label for="description" class="form-label">Description</label>
                                <textarea class="form-control" id="description" name="description" rows="5">${product.description}</textarea>
                            </div>
                            
                            <div class="mb-3">
                                <label for="status" class="form-label">Status</label>
                                <select class="form-select" id="status" name="status" required>
                                    <c:forEach items="${statusOptions}" var="status">
                                        <option value="${status.key}" ${product.status == status.key ? 'selected' : ''}>
                                            ${status.value}
                                        </option>
                                    </c:forEach>
                                </select>
                            </div>
                            
                            <div class="mb-3">
                                <label for="gender" class="form-label">Gender</label>
                                <select class="form-select" id="gender" name="gender" required>
                                    <option value="man" ${product.gender == 'man' ? 'selected' : ''}>Man</option>
                                    <option value="woman" ${product.gender == 'woman' ? 'selected' : ''}>Woman</option>
                                    <option value="unisex" ${product.gender == 'unisex' ? 'selected' : ''}>Unisex</option>
                                </select>
                            </div>
                        </div>
                    </div>
                    
                    <div class="d-flex justify-content-end gap-2">
                        <a href="${pageContext.request.contextPath}/manage-products" class="btn btn-secondary">Cancel</a>
                        <a href="${pageContext.request.contextPath}/manage-variation?action=add-variation&productId=${product.productID}" class="btn btn-success">Add Variation</a>
                        <button type="submit" class="btn btn-primary">Update Product</button>
                    </div>
                </form>
            </div>
        </div>

        <!-- Variations Table -->
        <div class="card h-100 p-0 radius-12 mt-4">
            <div class="card-header border-bottom bg-base py-16 px-24 d-flex justify-content-between align-items-center">
                <h6 class="fw-semibold mb-0">Product Variations</h6>
                <a href="${pageContext.request.contextPath}/manage-variation?action=add-variation&productId=${product.productID}" class="btn btn-sm btn-success">
                    <i class="bi bi-plus-circle me-1"></i> Add New Variation
                </a>
            </div>
            <div class="card-body p-24">
                <div class="table-responsive">
                    <table class="table table-striped table-hover align-middle">
                        <thead class="table-light">
                            <tr>
                                <th scope="col" class="text-center">ID</th>
                                <th scope="col">Product</th>
                                <th scope="col" class="text-center">Image</th>
                                <th scope="col">Color</th>
                                <th scope="col">Size</th>
                                <th scope="col" class="text-center">Quantity</th>
                                <th scope="col" class="text-center">Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="variation" items="${variations}">
                                <c:set var="colorName" value="${variationDAO.getColorNameById(variation.colorID)}" />
                                <c:set var="sizeName" value="${variationDAO.getSizeNameById(variation.sizeID)}" />
                                <c:set var="thumbnail" value="${variationDAO.getThumbnailById(variation.productImgID)}" />
                                <tr>
                                    <td class="text-center">${variation.variationID}</td>
                                    <td>${product.productName}</td>
                                    <td class="text-center">
                                        <c:if test="${not empty thumbnail}">
                                            <img src="${pageContext.request.contextPath}/${thumbnail}" 
                                                 alt="Product Image" class="rounded" style="width: 60px; height: 60px; object-fit: cover;" />
                                        </c:if>
                                        <c:if test="${empty thumbnail}">
                                            <div class="bg-light rounded d-flex align-items-center justify-content-center" style="width: 60px; height: 60px;">
                                                <iconify-icon icon="solar:gallery-broken" class="icon text-muted" style="font-size: 24px;"></iconify-icon>
                                            </div>
                                        </c:if>
                                    </td>
                                    <td>
                                        <span class="badge bg-secondary">${colorName}</span>
                                    </td>
                                    <td>${sizeName}</td>
                                    <td class="text-center">
                                        <span class="badge rounded-pill bg-${variation.qtyInStock > 10 ? 'success' : (variation.qtyInStock > 0 ? 'warning' : 'danger')}">
                                            ${variation.qtyInStock} ${variation.qtyInStock > 1 ? 'items' : 'item'}
                                        </span>
                                    </td>
                                    <td class="text-center">
                                        <div class="d-flex gap-2 justify-content-center">
                                            <a href="${pageContext.request.contextPath}/manage-variation?action=edit-variation&variationId=${variation.variationID}" 
                                              class="btn btn-sm btn-primary">
                                                <i class="fa fa-pencil"></i>
                                            </a>
                                            <a href="${pageContext.request.contextPath}/manage-variation?action=delete-variation&variationId=${variation.variationID}" 
                                               class="btn btn-sm btn-danger"
                                               onclick="return confirm('Are you sure you want to delete this variation? This action cannot be undone.')">
                                                <i class="fa fa-trash"></i>
                                            </a>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                            <c:if test="${empty variations}">
                                <tr>
                                    <td colspan="7" class="text-center py-4">
                                        <div class="py-3">
                                            <iconify-icon icon="solar:box-broken" class="icon text-muted mb-2" style="font-size: 48px;"></iconify-icon>
                                            <p class="text-muted mb-1">No variations found for this product</p>
                                            <a href="${pageContext.request.contextPath}/manage-variation?action=add-variation&productId=${product.productID}" class="btn btn-sm btn-primary">
                                                <i class="bi bi-plus-circle me-1"></i> Add Variation
                                            </a>
                                        </div>
                                    </td>
                                </tr>
                            </c:if>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
    
    <!-- JS here -->
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
