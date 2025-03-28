<%-- 
    Document   : slider_list
    Created on : May 15, 2025, 6:03:27 PM
    Author     : Quang
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en" data-theme="light">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Store 24-Manage Slider Stories</title>
        <link rel="icon" type="image/png" href="assets/images/favicon.png" sizes="16x16">
        <!-- CSS here -->
        <jsp:include page="../../common/dashboard/css-dashboard.jsp"></jsp:include>
            <!-- Toast CSS -->
<!--            <style>
                .toast-container {
                    position: fixed;
                    top: 20px;
                    right: 20px;
                    z-index: 1050;
                }
                .toast {
                    min-width: 250px;
                }
            </style>-->
        </head>
        <body>
        <c:url value="/manage-story" var="paginationUrl">
            <c:if test="${not empty param.status}">
                <c:param name="status" value="${param.status}" />
            </c:if>
            <c:if test="${not empty param.search}">
                <c:param name="search" value="${param.search}" />
            </c:if>
        </c:url>
        <!--<main>-->
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



            <div class="dashboard-main-body">
                <div class="card h-100 p-0 radius-12">
                    <div class="card-header border-bottom bg-base py-16 px-24 d-flex align-items-center flex-wrap gap-3 justify-content-between">
                        <div class="d-flex align-items-center flex-wrap gap-3"> 
                            <form action="${pageContext.request.contextPath}/manage-story" method="GET" class="d-flex align-items-center gap-3">
                                <div class="navbar-search">
                                    <input type="text" class="bg-base h-40-px w-auto" name="search" placeholder="Search title" value='${searchFilter}'>
                                    <iconify-icon icon="ion:search-outline" class="icon"></iconify-icon>
                                </div>

                                <select class="form-select form-select-sm w-auto ps-12 py-6 radius-12 h-40-px" name="status">
                                    <option value="">All Status</option>
                                    <option value="Active" ${statusFilter == 'Active' ? 'selected' : ''}>Active</option>
                                    <option value="Inactive" ${statusFilter == 'Inactive' ? 'selected' : ''}>Inactive</option>
                                </select>

                                <button type="submit" class="btn btn-primary h-40-px radius-12">Search</button>
                            </form>    
                        </div>

                        <a href="${pageContext.request.contextPath}/manage-story?action=add" class="btn btn-primary text-sm btn-sm px-12 py-12 radius-8 d-flex align-items-center gap-2"> 
                            <iconify-icon icon="ic:baseline-plus" class="icon text-xl line-height-1"></iconify-icon>
                            Add New Story
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
                                        <th scope="col">Backlink</th>
                                        <th scope="col" class="text-center">Status</th>
                                        <th scope="col" class="text-center">Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="story" items="${stories}">
                                        <tr>
                                            <td>${story.storyId}</td>   
                                            <td>
                                                <img src="${pageContext.request.contextPath}/${story.thumbnail}" alt="${story.title}" 
                                                     class="img-thumbnail" style="max-width: 80px; max-height: 60px;">
                                            </td>
                                            <td>${story.title}</td>
                                            <td>${story.backlink}</td>
                                            <td class="text-center">
                                                <span class="badge ${story.status == 'Active' ? 'bg-success' : 'bg-danger'}">${story.status}</span>
                                            </td>
                                            <td class="text-center"> 
                                                <div class="d-flex align-items-center gap-10 justify-content-center">
                                                    <a href="${pageContext.request.contextPath}/manage-story?action=edit&id=${story.storyId}"
                                                       class="bg-success-focus text-success-600 bg-hover-success-200 fw-medium w-40-px h-40-px d-flex justify-content-center align-items-center rounded-circle"> 
                                                        <iconify-icon icon="lucide:edit" class="menu-icon"></iconify-icon>
                                                    </a>
                                                    <a href="javascript:void(0)" 
                                                       class="bg-warning-focus bg-hover-warning-200 text-warning-600 fw-medium w-40-px h-40-px d-flex justify-content-center align-items-center rounded-circle"
                                                       onclick="confirmDeactivate(${story.storyId})"> 
                                                        <iconify-icon icon="mdi:power-standby" class="menu-icon"></iconify-icon>
                                                    </a>
                                                    <a href="javascript:void(0)" 
                                                       class="bg-danger-focus bg-hover-danger-200 text-danger-600 fw-medium w-40-px h-40-px d-flex justify-content-center align-items-center rounded-circle"
                                                       onclick="confirmDelete(${story.storyId})"> 
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
                    function confirmDeactivate(storyId) {
                        if (confirm('Are you sure you want to deactivate this story?')) {
                            window.location.href = '${pageContext.request.contextPath}/manage-story?action=deactivate&id=' + storyId;
                        }
                    }

                    function confirmDelete(storyId) {
                        if (confirm('Are you sure you want to delete this story? This action cannot be undone.')) {
                            window.location.href = '${pageContext.request.contextPath}/manage-story?action=delete&id=' + storyId;
                        }
                    }

                    // Auto-hide toast after 5 seconds
                    $(document).ready(function () {
                        setTimeout(function () {
                            $('.toast').toast('hide');
                        }, 5000);
                    });
            </script>
        <!--</main>-->
    </body>
</html> 