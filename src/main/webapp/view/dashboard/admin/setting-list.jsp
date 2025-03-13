<%-- 
    Document   : setting-list
    Created on : Feb 14, 2025, 4:15:25 PM
    Author     : ADMIN
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <!DOCTYPE html>
    <html lang="en" data-theme="light">

        <!-- Mirrored from wowdash.wowtheme7.com/demo/users-list.html by HTTrack Website Copier/3.x [XR&CO'2014], Mon, 03 Feb 2025 04:44:16 GMT -->
        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Store 24-Manage settings</title>
            <link rel="icon" type="image/png" href="assets/images/favicon.png" sizes="16x16">
            <!-- CSS here -->
            <jsp:include page="../../common/dashboard/css-dashboard.jsp"></jsp:include>
            </head>
            <body>
                <!-- Sidebar -->
            <jsp:include page="../../common/dashboard/sidebar-dashboard.jsp"></jsp:include>

                <!-- Header -->
            <jsp:include page="../../common/dashboard/header-dashboard.jsp"></jsp:include>

            <c:url value="/manage-settings" var="paginationUrl">
                <c:param name="action" value="list" />
                <c:if test="${not empty param.type}">
                    <c:param name="type" value="${param.type}" />
                </c:if>
                <c:if test="${not empty param.status}">
                    <c:param name="status" value="${param.status}" />
                </c:if>
                <c:if test="${not empty param.search}">
                    <c:param name="search" value="${param.search}" />
                </c:if>
            </c:url>

            <div class="dashboard-main-body">
                <div class="d-flex flex-wrap align-items-center justify-content-between gap-3 mb-24">
                    <h6 class="fw-semibold mb-0">Settings List</h6>
                    <ul class="d-flex align-items-center gap-2">
                        <li class="fw-medium">
                            <a href="index.html" class="d-flex align-items-center gap-1 hover-text-primary">
                                <iconify-icon icon="solar:home-smile-angle-outline" class="icon text-lg"></iconify-icon>
                                Dashboard
                            </a>
                        </li>
                        <li>-</li>
                        <li class="fw-medium">Settings List</li>
                    </ul>
                </div>

                <div class="card h-100 p-0 radius-12">
                    <div class="card-header border-bottom bg-base py-16 px-24 d-flex align-items-center flex-wrap gap-3 justify-content-between">
                        <div class="d-flex align-items-center flex-wrap gap-3"> 
                            <form action="${pageContext.request.contextPath}/manage-settings" method="GET" class="d-flex align-items-center gap-3">
                                <div class="navbar-search">
                                    <input type="text" class="bg-base h-40-px w-auto" name="search" placeholder="Search" value='${param.search}'>
                                    <iconify-icon icon="ion:search-outline" class="icon"></iconify-icon>
                                </div>

                                <select class="form-select form-select-sm w-auto ps-12 py-6 radius-12 h-40-px" name="status">
                                    <option value="">All Status</option>
                                    <option value="Active" ${param.status == 'Active' ? 'selected' : ''}>Active</option>
                                    <option value="Inactive" ${param.status == 'Inactive' ? 'selected' : ''}>Inactive</option>
                                </select>

                                <select class="form-select form-select-sm w-auto ps-12 py-6 radius-12 h-40-px" name="type">
                                    <option value="">All Type</option>
                                    <option value="System" ${param.type == 'System' ? 'selected' : ''}>System</option>
                                    <option value="User" ${param.type == 'User' ? 'selected' : ''}>User</option>
                                    <option value="Payment" ${param.type == 'Payment' ? 'selected' : ''}>Payment</option>
                                </select>

                                <button type="submit" class="btn btn-primary h-40-px radius-12">Search</button>
                            </form>    
                        </div>

                        <a href="${pageContext.request.contextPath}/manage-settings?action=addform" class="btn btn-primary text-sm btn-sm px-12 py-12 radius-8 d-flex align-items-center gap-2"> 
                            <iconify-icon icon="ic:baseline-plus" class="icon text-xl line-height-1"></iconify-icon>
                            Add New Setting
                        </a>
                    </div>
                    <div class="card-body p-24">
                        <div class="table-responsive scroll-sm">
                            <table class="table bordered-table sm-table mb-0">
                                <thead>
                                    <tr>
                                        <th scope="col">Id</th>   
                                        <th scope="col">Type</th>
                                        <th scope="col">Value</th>                                       
                                        <th scope="col">Order</th>
                                        <th scope="col">Status</th>
                                        <th scope="col">Created At</th>
                                        <th scope="col">Updated At</th>
                                        <th scope="col" class="text-center">Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="setting" items="${settings}">
                                        <tr>
                                            <td>${setting.id}</td>   
                                            <td>${setting.type}</td>
                                            <td>${setting.value}</td>
                                            <td>${setting.order}</td>
                                            <td>${setting.status == 'Active' ? 'Active' : 'Inactive'}</td>
                                            <td>${setting.createdAt}</td>
                                            <td>${setting.updatedAt}</td>
                                            <td class="text-center"> 
                                                <div class="d-flex align-items-center gap-10 justify-content-center">
                                                    <button type="button" class="bg-success-focus text-success-600 bg-hover-success-200 fw-medium w-40-px h-40-px d-flex justify-content-center align-items-center rounded-circle"
                                                            onclick="window.location.href = '${pageContext.request.contextPath}/manage-settings?action=details&id=${setting.id}'"> 
                                                        <iconify-icon icon="lucide:edit" class="menu-icon"></iconify-icon>
                                                    </button>
                                                    <button type="button" class="bg-danger-focus bg-hover-danger-200 text-danger-600 fw-medium w-40-px h-40-px d-flex justify-content-center align-items-center rounded-circle"
                                                            onclick="confirmDeactivate(${setting.id})"> 
                                                        <iconify-icon icon="fluent:delete-24-regular" class="menu-icon"></iconify-icon>
                                                    </button>
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
                                <c:forEach begin="1" end="${totalpages}" var="i">
                                    <li class="page-item">
                                        <a class="page-link bg-neutral-200 text-secondary-emphasis fw-semibold radius-8 border-0 d-flex align-items-center justify-content-center h-32-px w-32-px" 
                                           href="${paginationUrl}&page=${i}">${i}
                                        </a>
                                    </li>
                                </c:forEach>
                                <c:if test="${currentPage < totalpages}">                               
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
                    function confirmDeactivate(settingId) {
                        if (confirm('Are you sure you want to deactivate this account?')) {
                            window.location.href = '${pageContext.request.contextPath}/manage-settings?action=deactivate&id=' + settingId;
                        }
                    }
            </script>


        </main>

    </body>
</html>
