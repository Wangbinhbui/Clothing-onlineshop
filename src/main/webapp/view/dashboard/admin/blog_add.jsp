<%-- 
    Document   : blog_add
    Created on : May 16, 2025, 11:00:00 AM
    Author     : Admin
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en" data-theme="light">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Store 24-Add Blog</title>
        <link rel="icon" type="image/png" href="assets/images/favicon.png" sizes="16x16">
        <!-- CSS here -->
        <jsp:include page="../../common/dashboard/css-dashboard.jsp"></jsp:include>
        <!-- Include CKEditor -->
        <script src="https://cdn.ckeditor.com/4.16.2/standard/ckeditor.js"></script>
    </head>
    <body>
        <main>
            <!-- Sidebar -->
            <jsp:include page="../../common/dashboard/sidebar-dashboard.jsp"></jsp:include>

            <!-- Header -->
            <jsp:include page="../../common/dashboard/header-dashboard.jsp"></jsp:include>

            <div class="dashboard-main-body">
                <div class="d-flex flex-wrap align-items-center justify-content-between gap-3 mb-24">
                    <h6 class="fw-semibold mb-0">Add Blog</h6>
                    <ul class="d-flex align-items-center gap-2">
                        <li class="fw-medium">
                            <a href="index.html" class="d-flex align-items-center gap-1 hover-text-primary">
                                <iconify-icon icon="solar:home-smile-angle-outline" class="icon text-lg"></iconify-icon>
                                Dashboard
                            </a>
                        </li>
                        <li>-</li>
                        <li class="fw-medium">Add Blog</li>
                    </ul>
                </div>

                <div class="card h-100 p-0 radius-12">
                    <div class="card-body p-24">
                        <div class="row justify-content-center">
                            <div class="col-xxl-10 col-xl-10 col-lg-12">
                                <div class="card border">
                                    <div class="card-body">                                      
                                        <form action="${pageContext.request.contextPath}/manage-blog" method="POST" enctype="multipart/form-data">
                                            <input type="hidden" name="action" value="add">

                                            <div class="mb-20">
                                                <label for="title" class="form-label fw-semibold text-primary-light text-sm mb-8">Title <span class="text-danger-600">*</span></label>
                                                <input type="text" class="form-control radius-8" id="title" placeholder="Enter Blog Title" name="title" required>
                                            </div>
                                            
                                            <div class="mb-20">
                                                <label for="categoryId" class="form-label fw-semibold text-primary-light text-sm mb-8">Category <span class="text-danger-600">*</span></label>
                                                <select class="form-control radius-8 form-select" id="categoryId" name="categoryId" required>
                                                    <option value="">Select Category</option>
                                                    <c:forEach var="category" items="${categories}">
                                                        <option value="${category.id}">${category.name}</option>
                                                    </c:forEach>
                                                </select>
                                            </div>
                                            
                                            <div class="mb-20">
                                                <label for="status" class="form-label fw-semibold text-primary-light text-sm mb-8">Status <span class="text-danger-600">*</span></label>
                                                <select class="form-control radius-8 form-select" id="status" name="status">
                                                    <option value="Active">Active</option>
                                                    <option value="Inactive">Inactive</option>
                                                </select>
                                            </div>
                                            
                                            <div class="mb-20">
                                                <label for="thumbnail" class="form-label fw-semibold text-primary-light text-sm mb-8">Thumbnail Image <span class="text-danger-600">*</span></label>
                                                <input type="file" class="form-control radius-8" id="thumbnail" name="thumbnail" accept="image/*" required>
                                                <small class="text-muted">Recommended size: 1200x630 pixels, Max file size: 10MB</small>
                                            </div>
                                            
                                            <div class="mb-20">
                                                <label for="briefInfo" class="form-label fw-semibold text-primary-light text-sm mb-8">Brief Info <span class="text-danger-600">*</span></label>
                                                <textarea class="form-control radius-8" id="briefInfo" name="briefInfo" rows="3" required></textarea>
                                                <small class="text-muted">A short summary of the blog (150-200 characters)</small>
                                            </div>
                                            
                                            <div class="mb-20">
                                                <label for="content" class="form-label fw-semibold text-primary-light text-sm mb-8">Content <span class="text-danger-600">*</span></label>
                                                <textarea class="form-control radius-8" id="content" name="content" rows="10" required></textarea>
                                            </div>

                                            <div class="d-flex align-items-center justify-content-center gap-3">
                                                <button type="button" class="border border-danger-600 bg-hover-danger-200 text-danger-600 text-md px-56 py-11 radius-8"
                                                        onclick="window.location.href = '${pageContext.request.contextPath}/manage-blog'"> 
                                                    Cancel
                                                </button>
                                                <button type="submit" class="btn btn-primary border border-primary-600 text-md px-56 py-12 radius-8"> 
                                                    Save
                                                </button>
                                            </div>
                                            <div class="text-center mt-3">
                                                <span style="color: #198754">${requestScope.suc}</span>  <!-- Green for success message -->
                                                <span style="color: #dc3545">${requestScope.err}</span>  <!-- Red for error message -->
                                            </div>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- JS here -->
            <jsp:include page="../../common/dashboard/js-dashboard.jsp"></jsp:include>
            
            <!-- Initialize CKEditor for rich text fields -->
            <script>
                CKEDITOR.replace('content', {
                    height: 400,
                    filebrowserUploadUrl: '${pageContext.request.contextPath}/upload'
                });
            </script>
        </main>
    </body>
</html> 