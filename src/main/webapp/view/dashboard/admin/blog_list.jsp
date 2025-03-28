<%-- 
    Document   : blog_list
    Created on : May 16, 2025, 10:30:00 AM
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
        <title>Store 24-Manage Blogs</title>
        <link rel="icon" type="image/png" href="assets/images/favicon.png" sizes="16x16">
        <!-- CSS here -->
        <jsp:include page="../../common/dashboard/css-dashboard.jsp"></jsp:include>
        <!-- Toast CSS -->
        <style>
            .toast-container {
                position: fixed;
                top: 20px;
                right: 20px;
                z-index: 1050;
            }
            .toast {
                min-width: 250px;
            }
            .truncate-text {
                display: -webkit-box;
                -webkit-line-clamp: 2;
                -webkit-box-orient: vertical;
                overflow: hidden;
                max-height: 3em;
            }
        </style>
    </head>
    <body>
        <main>
            <!-- Sidebar -->
            <jsp:include page="../../common/dashboard/sidebar-dashboard.jsp"></jsp:include>

            <!-- Header -->
            <jsp:include page="../../common/dashboard/header-dashboard.jsp"></jsp:include>

            <!-- Toast container for notifications -->
            <div class="toast-container">
                <c:if test="${not empty sessionScope.toastMessage}">
                    <div class="toast show" role="alert" aria-live="assertive" aria-atomic="true">
                        <div class="toast-header ${sessionScope.toastType == 'success' ? 'bg-success text-white' : 'bg-danger text-white'}">
                            <strong class="me-auto">${sessionScope.toastType == 'success' ? 'Success' : 'Error'}</strong>
                            <button type="button" class="btn-close" data-bs-dismiss="toast" aria-label="Close"></button>
                        </div>
                        <div class="toast-body">
                            ${sessionScope.toastMessage}
                        </div>
                    </div>
                    <% 
                       session.removeAttribute("toastMessage");
                       session.removeAttribute("toastType");
                    %>
                </c:if>
            </div>

            <c:url value="/manage-blog" var="paginationUrl">
                <c:param name="action" value="list" />
                <c:if test="${not empty param.status}">
                    <c:param name="status" value="${param.status}" />
                </c:if>
                <c:if test="${not empty param.search}">
                    <c:param name="search" value="${param.search}" />
                </c:if>
                <c:if test="${not empty param.category}">
                    <c:param name="category" value="${param.category}" />
                </c:if>
            </c:url>

            <div class="dashboard-main-body">
                <div class="d-flex flex-wrap align-items-center justify-content-between gap-3 mb-24">
                    <h6 class="fw-semibold mb-0">Blogs List</h6>
                    <ul class="d-flex align-items-center gap-2">
                        <li class="fw-medium">
                            <a href="index.html" class="d-flex align-items-center gap-1 hover-text-primary">
                                <iconify-icon icon="solar:home-smile-angle-outline" class="icon text-lg"></iconify-icon>
                                Dashboard
                            </a>
                        </li>
                        <li>-</li>
                        <li class="fw-medium">Blogs List</li>
                    </ul>
                </div>

                <div class="card h-100 p-0 radius-12">
                    <div class="card-header border-bottom bg-base py-16 px-24 d-flex align-items-center flex-wrap gap-3 justify-content-between">
                        <div class="d-flex align-items-center flex-wrap gap-3"> 
                            <form action="${pageContext.request.contextPath}/manage-blog" method="GET" class="d-flex align-items-center gap-3">
                                <input type="hidden" name="action" value="list">
                                <div class="navbar-search">
                                    <input type="text" class="bg-base h-40-px w-auto" name="search" placeholder="Search title" value='${searchFilter}'>
                                    <iconify-icon icon="ion:search-outline" class="icon"></iconify-icon>
                                </div>

                                <select class="form-select form-select-sm w-auto ps-12 py-6 radius-12 h-40-px" name="status">
                                    <option value="">All Status</option>
                                    <option value="Active" ${statusFilter == 'Active' ? 'selected' : ''}>Active</option>
                                    <option value="Inactive" ${statusFilter == 'Inactive' ? 'selected' : ''}>Inactive</option>
                                </select>

                                <select class="form-select form-select-sm w-auto ps-12 py-6 radius-12 h-40-px" name="category">
                                    <option value="">All Categories</option>
                                    <c:forEach var="category" items="${categories}">
                                        <option value="${category.id}" ${categoryFilter == category.id ? 'selected' : ''}>${category.name}</option>
                                    </c:forEach>
                                </select>

                                <button type="submit" class="btn btn-primary h-40-px radius-12">Search</button>
                            </form>    
                        </div>

                        <a href="${pageContext.request.contextPath}/manage-blog?action=add" class="btn btn-primary text-sm btn-sm px-12 py-12 radius-8 d-flex align-items-center gap-2"> 
                            <iconify-icon icon="ic:baseline-plus" class="icon text-xl line-height-1"></iconify-icon>
                            Add New Blog
                        </a>
                    </div>
                    <div class="card-body p-24">
                        <div class="table-responsive scroll-sm">
                            <table class="table bordered-table sm-table mb-0">
                                <thead>
                                    <tr>
                                        <th scope="col">Id</th>   
                                        <th scope="col">Thumbnail</th>
                                        <th scope="col">Title</th>                                       
                                        <th scope="col">Category</th>
                                        <th scope="col">Brief Info</th>
                                        <th scope="col">Author</th>
                                        <th scope="col">Created</th>
                                        <th scope="col" class="text-center">Status</th>
                                        <th scope="col" class="text-center">Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="blog" items="${blogs}">
                                        <tr>
                                            <td>${blog.id}</td>   
                                            <td>
                                                <img src="${pageContext.request.contextPath}/${blog.thumbnail}" alt="${blog.title}" 
                                                     class="img-thumbnail" style="max-width: 80px; max-height: 60px;">
                                            </td>
                                            <td>${blog.title}</td>
                                            <td>
                                                <c:forEach var="category" items="${categories}">
                                                    <c:if test="${category.id == blog.categoryId}">
                                                        ${category.name}
                                                    </c:if>
                                                </c:forEach>
                                            </td>
                                            <td>
                                                <div class="truncate-text">${blog.briefInfo}</div>
                                            </td>
                                            <td>
                                                ${userMap[blog.author].firstName} ${userMap[blog.author].lastName}
                                            </td>
                                            <td>
                                                <fmt:parseDate value="${blog.createdDate}" pattern="yyyy-MM-dd'T'HH:mm:ss" var="parsedDate" type="both" />
                                                <fmt:formatDate value="${parsedDate}" pattern="dd/MM/yyyy HH:mm" />
                                            </td>
                                            <td class="text-center">
                                                <span class="badge ${blog.status == 'Active' ? 'bg-success' : 'bg-danger'}">${blog.status}</span>
                                            </td>
                                            <td class="text-center"> 
                                                <div class="d-flex align-items-center gap-10 justify-content-center">
                                                    <a href="${pageContext.request.contextPath}/manage-blog?action=edit&id=${blog.id}"
                                                       class="bg-success-focus text-success-600 bg-hover-success-200 fw-medium w-40-px h-40-px d-flex justify-content-center align-items-center rounded-circle"> 
                                                        <iconify-icon icon="lucide:edit" class="menu-icon"></iconify-icon>
                                                    </a>
                                                    
                                                    <c:choose>
                                                        <c:when test="${blog.status == 'Active'}">
                                                            <a href="javascript:void(0)" 
                                                               class="bg-warning-focus bg-hover-warning-200 text-warning-600 fw-medium w-40-px h-40-px d-flex justify-content-center align-items-center rounded-circle"
                                                               onclick="confirmDeactivate(${blog.id})"> 
                                                                <iconify-icon icon="mdi:power-standby" class="menu-icon"></iconify-icon>
                                                            </a>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <a href="javascript:void(0)" 
                                                               class="bg-info-focus bg-hover-info-200 text-info-600 fw-medium w-40-px h-40-px d-flex justify-content-center align-items-center rounded-circle"
                                                               onclick="confirmActivate(${blog.id})"> 
                                                                <iconify-icon icon="mdi:power" class="menu-icon"></iconify-icon>
                                                            </a>
                                                        </c:otherwise>
                                                    </c:choose>
                                                    
                                                    <a href="javascript:void(0)" 
                                                       class="bg-danger-focus bg-hover-danger-200 text-danger-600 fw-medium w-40-px h-40-px d-flex justify-content-center align-items-center rounded-circle"
                                                       onclick="confirmDelete(${blog.id})"> 
                                                        <iconify-icon icon="fluent:delete-24-regular" class="menu-icon"></iconify-icon>
                                                    </a>
                                                </div>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>

                        <div class="d-flex align-items-center justify-content-between flex-wrap gap-2 mt-24">
                            <ul class="pagination d-flex flex-wrap align-items-center gap-2 justify-content-center">
                                <c:if test="${currentPage > 1}">
                                    <li class="page-item">
                                        <a class="page-link bg-neutral-200 text-secondary-light fw-semibold radius-8 border-0 d-flex align-items-center justify-content-center h-32-px w-32-px text-md" 
                                           href="${paginationUrl}&page=${currentPage - 1}"><iconify-icon icon="ep:d-arrow-left" class=""></iconify-icon>
                                        </a>
                                    </li>
                                </c:if> 
                                <c:forEach begin="1" end="${totalPages}" var="i">
                                    <li class="page-item ${currentPage == i ? 'active' : ''}">
                                        <a class="page-link ${currentPage == i ? 'bg-primary text-white' : 'bg-neutral-200 text-secondary-emphasis'} fw-semibold radius-8 border-0 d-flex align-items-center justify-content-center h-32-px w-32-px" 
                                           href="${paginationUrl}&page=${i}">${i}
                                        </a>
                                    </li>
                                </c:forEach>
                                <c:if test="${currentPage < totalPages}">                               
                                    <li class="page-item">
                                        <a class="page-link bg-neutral-200 text-secondary-light fw-semibold radius-8 border-0 d-flex align-items-center justify-content-center h-32-px w-32-px text-md" 
                                           href="${paginationUrl}&page=${currentPage + 1}"><iconify-icon icon="ep:d-arrow-right" class=""></iconify-icon>
                                        </a>
                                    </li>
                                </c:if>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- JS here -->
            <jsp:include page="../../common/dashboard/js-dashboard.jsp"></jsp:include>

            <script>
                function confirmDeactivate(blogId) {
                    if (confirm('Are you sure you want to deactivate this blog?')) {
                        window.location.href = '${pageContext.request.contextPath}/manage-blog?action=deactivate&id=' + blogId;
                    }
                }
                
                function confirmActivate(blogId) {
                    if (confirm('Are you sure you want to activate this blog?')) {
                        window.location.href = '${pageContext.request.contextPath}/manage-blog?action=activate&id=' + blogId;
                    }
                }
                
                function confirmDelete(blogId) {
                    if (confirm('Are you sure you want to delete this blog? This action cannot be undone.')) {
                        window.location.href = '${pageContext.request.contextPath}/manage-blog?action=delete&id=' + blogId;
                    }
                }
                
                // Auto-hide toast after 5 seconds
                $(document).ready(function(){
                    setTimeout(function(){
                        $('.toast').toast('hide');
                    }, 5000);
                });
            </script>
        </main>
    </body>
</html> 