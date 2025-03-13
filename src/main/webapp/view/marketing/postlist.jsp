<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en" data-theme="light">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Wowdash - Blog Management</title>
    <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/assets/images/favicon.png" sizes="16x16">
    <jsp:include page="../common/dashboard/css-dashboard.jsp"></jsp:include>
</head>
<body>
    <jsp:include page="../common/dashboard/header-dashboard.jsp"></jsp:include>
    <jsp:include page="../common/dashboard/sidebar-dashboard.jsp"></jsp:include>
    <main class="dashboard-main">
        <div class="dashboard-main-body">
            <div class="d-flex flex-wrap align-items-center justify-content-between gap-3 mb-24">
                <ul class="d-flex align-items-center gap-2">
                    <li class="fw-medium">
                        <a href="index.html" class="d-flex align-items-center gap-1 hover-text-primary">
                            <iconify-icon icon="solar:home-smile-angle-outline" class="icon text-lg"></iconify-icon>
                            Dashboard
                        </a>
                    </li>
                    <li>-</li>
                    <li class="fw-medium">Blog</li>
                </ul>
            </div>
            <div class="dashboard__content-wrap">
                <div class="dashboard__content-title d-flex justify-content-between align-items-center">
                    <h4>Manage Blogs</h4>
                    <a href="${pageContext.request.contextPath}/post-manage?action=create" class="btn btn-success">
                        <i class="ri-add-circle-line me-2"></i> Add Blog
                    </a>
                </div>
                <form action="${pageContext.request.contextPath}/post-manage" method="GET" class="mb-4">
                    <input type="hidden" name="action" value="list"/>
                    <div class="row mb-3">
                        <div class="col-md-4">
                            <select class="form-select" id="statusFilter" name="status">
                                <option value="">All Status</option>
                                <option value="Active" ${param.status=='Active' ? 'selected' : '' }>Active</option>
                                <option value="Inactive" ${param.status=='Inactive' ? 'selected' : '' }>Inactive</option>
                            </select>
                        </div>
                        <div class="col-md-4">
                            <input type="text" class="form-control" id="searchFilter" name="search" placeholder="Search blogs..." value="${param.search}">
                        </div>
                        <div class="col-md-3">
                            <button type="submit" class="btn btn-primary w-100">Filter</button>
                        </div>
                    </div>
                </form>
                <div class="dashboard__review-table">
                    <table class="table table-borderless">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Image</th>
                                <th>Title</th>
                                <th>Category</th>
                                <th>Author</th>
                                <th>Status</th>
                                <th>Description</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="blog" items="${blogs}">
                                <tr>
                                    <td>${blog.id}</td>
                                    <td>
                                        <img src="${pageContext.request.contextPath}/${blog.thumbnail}" alt="Blog image" class="img-thumbnail" style="width: 100px; height: 60px; object-fit: cover;">
                                    </td>
                                    <td>${blog.title}</td>
                                    <td>${blog.categoryId}</td>
                                    <td>${blog.author}</td>
                                    <td>
                                        <span class="dashboard__quiz-result ${blog.status == 'Active' ? 'text-success' : 'text-danger'}">
                                            ${blog.status}
                                        </span>
                                    </td>
                                    <td class="description-column">
                                        ${blog.briefInfo}
                                    </td>
                                    <td>
                                        <div class="dashboard__review-action d-flex align-items-center gap-2">
                                            <a href="${pageContext.request.contextPath}/post-manage?action=edit&id=${blog.id}" title="Edit">
                                                <i class="ri-edit-line fs-3"></i>
                                            </a>
                                            <a href="${pageContext.request.contextPath}/post-manage?action=delete&id=${blog.id}" title="Delete" onclick="return confirm('Are you sure you want to delete this blog?');">
                                                <i class="ri-delete-bin-line fs-3 text-danger"></i>
                                            </a>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
        <footer class="d-footer">
            <div class="row align-items-center justify-content-between">
                <div class="col-auto">
                    <p class="mb-0">© 2024 WowDash. All Rights Reserved.</p>
                </div>
                <div class="col-auto">
                    <p class="mb-0">Made by <span class="text-primary-600">wowtheme7</span></p>
                </div>
            </div>
        </footer>
    </main>
    <jsp:include page="../../common/dashboard/js-dashboard.jsp"></jsp:include>
</body>
</html>
