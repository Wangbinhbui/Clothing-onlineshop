<%-- 
    Document   : blog_details
    Created on : May 16, 2025, 11:30:00 AM
    Author     : Admin
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en" data-theme="light">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Store 24-Edit Blog</title>
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
                    <h6 class="fw-semibold mb-0">Edit Blog</h6>
                    <ul class="d-flex align-items-center gap-2">
                        <li class="fw-medium">
                            <a href="index.html" class="d-flex align-items-center gap-1 hover-text-primary">
                                <iconify-icon icon="solar:home-smile-angle-outline" class="icon text-lg"></iconify-icon>
                                Dashboard
                            </a>
                        </li>
                        <li>-</li>
                        <li class="fw-medium">Edit Blog</li>
                    </ul>
                </div>

                <div class="row gy-4">
                    <div class="col-lg-4">
                        <div class="user-grid-card position-relative border radius-16 overflow-hidden bg-base h-100">
                            <div class="pb-24 ms-16 mb-24 me-16 mt-24">
                                <div class="text-center border border-top-0 border-start-0 border-end-0">
                                    <img src="${pageContext.request.contextPath}/${blog.thumbnail}" alt="${blog.title}" 
                                         class="w-100 object-fit-cover" style="max-height: 250px;">
                                    <h6 class="mb-0 mt-16">${blog.title}</h6>
                                    <span class="text-secondary-light mb-16">ID: ${blog.id}</span>
                                </div>
                                <div class="mt-24">
                                    <h6 class="text-xl mb-16">Blog Info</h6>
                                    <ul>
                                        <li class="d-flex align-items-center gap-1 mb-12">
                                            <span class="w-30 text-md fw-semibold text-primary-light">Category</span>
                                            <span class="w-70 text-secondary-light fw-medium">: 
                                                <c:forEach var="category" items="${categories}">
                                                    <c:if test="${category.id == blog.categoryId}">
                                                        ${category.name}
                                                    </c:if>
                                                </c:forEach>
                                            </span>
                                        </li>
                                        <li class="d-flex align-items-center gap-1 mb-12">
                                            <span class="w-30 text-md fw-semibold text-primary-light">Status</span>
                                            <span class="w-70 text-secondary-light fw-medium">: ${blog.status}</span>
                                        </li>
                                        <li class="d-flex align-items-center gap-1 mb-12">
                                            <span class="w-30 text-md fw-semibold text-primary-light">Created</span>
                                            <span class="w-70 text-secondary-light fw-medium">: 
                                                <fmt:parseDate value="${blog.createdDate}" pattern="yyyy-MM-dd'T'HH:mm:ss" var="parsedDate" type="both" />
                                                <fmt:formatDate value="${parsedDate}" pattern="dd/MM/yyyy HH:mm" />
                                            </span>
                                        </li>
                                        <li class="d-flex align-items-center gap-1">
                                            <span class="w-30 text-md fw-semibold text-primary-light">Updated</span>
                                            <span class="w-70 text-secondary-light fw-medium">: 
                                                <fmt:parseDate value="${blog.updatedDate}" pattern="yyyy-MM-dd'T'HH:mm:ss" var="parsedUpdateDate" type="both" />
                                                <fmt:formatDate value="${parsedUpdateDate}" pattern="dd/MM/yyyy HH:mm" />
                                            </span>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-8">
                        <div class="card h-100">
                            <div class="card-body p-24">
                                <ul class="nav border-gradient-tab nav-pills mb-20 d-inline-flex" id="pills-tab" role="tablist">
                                    <li class="nav-item" role="presentation">
                                        <button class="nav-link d-flex align-items-center px-24 active" id="pills-edit-profile-tab" data-bs-toggle="pill" data-bs-target="#pills-edit-profile" type="button" role="tab" aria-controls="pills-edit-profile" aria-selected="true">
                                            Edit Blog 
                                        </button>
                                    </li>                                   
                                </ul>

                                <div class="tab-content" id="pills-tabContent">   
                                    <div class="tab-pane fade show active" id="pills-edit-profile" role="tabpanel" aria-labelledby="pills-edit-profile-tab" tabindex="0">

                                        <form action="${pageContext.request.contextPath}/manage-blog" method="POST" enctype="multipart/form-data">
                                            <input type="hidden" name="action" value="update">
                                            <input type="hidden" name="id" value="${blog.id}">
                                            <div class="row">
                                                <div class="col-sm-12">
                                                    <div class="mb-20">
                                                        <label for="title" class="form-label fw-semibold text-primary-light text-sm mb-8">Title <span class="text-danger-600">*</span></label>
                                                        <input type="text" class="form-control radius-8" id="title" name="title" value="${blog.title}" required>
                                                    </div>
                                                </div>
                                                <div class="col-sm-6">
                                                    <div class="mb-20">
                                                        <label for="categoryId" class="form-label fw-semibold text-primary-light text-sm mb-8">Category <span class="text-danger-600">*</span></label>
                                                        <select class="form-control radius-8 form-select" id="categoryId" name="categoryId" required>
                                                            <c:forEach var="category" items="${categories}">
                                                                <option value="${category.id}" ${blog.categoryId == category.id ? 'selected' : ''}>${category.name}</option>
                                                            </c:forEach>
                                                        </select>
                                                    </div>
                                                </div>
                                                <div class="col-sm-6">
                                                    <div class="mb-20">
                                                        <label for="status" class="form-label fw-semibold text-primary-light text-sm mb-8">Status <span class="text-danger-600">*</span></label>
                                                        <select class="form-control radius-8 form-select" id="status" name="status">
                                                            <option value="Active" ${blog.status == 'Active' ? 'selected' : ''}>Active</option>
                                                            <option value="Inactive" ${blog.status == 'Inactive' ? 'selected' : ''}>Inactive</option>
                                                        </select>
                                                    </div>
                                                </div>
                                                <div class="col-sm-12">
                                                    <div class="mb-20">
                                                        <label for="thumbnail" class="form-label fw-semibold text-primary-light text-sm mb-8">New Thumbnail</label>
                                                        <input type="file" class="form-control radius-8" id="thumbnail" name="thumbnail" accept="image/*">
                                                        <small class="text-muted">Leave empty to keep current image</small>
                                                    </div>
                                                </div>
                                                <div class="col-sm-12">
                                                    <div class="mb-20">
                                                        <label for="briefInfo" class="form-label fw-semibold text-primary-light text-sm mb-8">Brief Info <span class="text-danger-600">*</span></label>
                                                        <textarea class="form-control radius-8" id="briefInfo" name="briefInfo" rows="3" required>${blog.briefInfo}</textarea>
                                                        <small class="text-muted">A short summary of the blog (150-200 characters)</small>
                                                    </div>
                                                </div>
                                                <div class="col-sm-12">
                                                    <div class="mb-20">
                                                        <label for="content" class="form-label fw-semibold text-primary-light text-sm mb-8">Content <span class="text-danger-600">*</span></label>
                                                        <textarea class="form-control radius-8" id="content" name="content" rows="10" required>${blog.content}</textarea>
                                                    </div>
                                                </div>
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
            
            <!-- Initialize CKEditor -->
            <script>
                CKEDITOR.replace('content', {
                    height: 400,
                    filebrowserUploadUrl: '${pageContext.request.contextPath}/upload'
                });
            </script>
        </main>
    </body>
</html> 