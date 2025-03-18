<%-- 
    Document   : product-add
    Created on : Mar 17, 2025, 8:49:19 PM
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
    <title>Store 24 - Add New Product</title>
    <link rel="icon" type="image/png" href="assets/images/favicon.png" sizes="16x16">
    <!-- CSS here -->
    <jsp:include page="../../common/dashboard/css-dashboard.jsp"></jsp:include>
    <style>
        .image-preview {
            width: 150px;
            height: 150px;
            border: 1px solid #ddd;
            border-radius: 4px;
            padding: 5px;
            margin-top: 10px;
            object-fit: cover;
            display: none;
        }
    </style>
    </head>
    <body>
    <!-- Sidebar -->
    <jsp:include page="../../common/dashboard/sidebar-dashboard.jsp"></jsp:include>

    <!-- Header -->
    <jsp:include page="../../common/dashboard/header-dashboard.jsp"></jsp:include>

    <div class="dashboard-main-body">
        <div class="d-flex flex-wrap align-items-center justify-content-between gap-3 mb-24">
            <h6 class="fw-semibold mb-0">Add New Product</h6>
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
                <li class="fw-medium">Add New Product</li>
            </ul>
        </div>

        <div class="card h-100 p-0 radius-12">
            <div class="card-header border-bottom bg-base py-16 px-24">
                <h6 class="fw-semibold mb-0">Product Information</h6>
            </div>
            <div class="card-body p-24">
                <c:if test="${not empty errorMessage}">
                    <div class="alert alert-danger" role="alert">
                        ${errorMessage}
                    </div>
                </c:if>
                
                <form action="${pageContext.request.contextPath}/manage-products" method="POST" enctype="multipart/form-data">
                    <input type="hidden" name="action" value="add">
                    
                    <div class="row mb-3">
                        <div class="col-md-6">
                            <div class="mb-3">
                                <label for="productName" class="form-label">Product Name</label>
                                <input type="text" class="form-control" id="productName" name="productName" required>
                            </div>
                            
                            <div class="mb-3">
                                <label for="price" class="form-label">Price</label>
                                <input type="number" step="0.01" class="form-control" id="price" name="price" required>
                            </div>
                            
                            <div class="mb-3">
                                <label for="categoryId" class="form-label">Category</label>
                                <select class="form-select" id="categoryId" name="categoryId" required>
                                    <option value="">Select Category</option>
                                    <c:forEach var="category" items="${categories}">
                                        <option value="${category.categoryID}">${category.categoryName}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            
                            <div class="mb-3">
                                <label for="collectionId" class="form-label">Collection</label>
                                <select class="form-select" id="collectionId" name="collectionId" required>
                                    <option value="">Select Collection</option>
                                    <c:forEach var="collection" items="${collections}">
                                        <option value="${collection.collectionID}">${collection.collectionName}</option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>
                        
                        <div class="col-md-6">
                            <div class="mb-3">
                                <label for="description" class="form-label">Description</label>
                                <textarea class="form-control" id="description" name="description" rows="5"></textarea>
                            </div>
                            
                            <div class="mb-3">
                                <label for="status" class="form-label">Status</label>
                                <select class="form-select" id="status" name="status" required>
                                    <option value="1" selected>Active</option>
                                    <option value="0">Inactive</option>
                                </select>
                            </div>
                        </div>
                    </div>
                    
                    <div class="d-flex justify-content-end gap-2">
                        <a href="${pageContext.request.contextPath}/manage-products" class="btn btn-secondary">Cancel</a>
                        <button type="submit" class="btn btn-primary">Add Product</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
    
    <!-- JS here -->
    <jsp:include page="../../common/dashboard/js-dashboard.jsp"></jsp:include>
    </body>
</html>
