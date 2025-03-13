<%-- 
    Document   : user-list
    Created on : Feb 8, 2025, 6:03:27 PM
    Author     : ADMIN
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!-- meta tags and other links -->
<!DOCTYPE html>
<html lang="en" data-theme="light">

    <!-- Mirrored from wowdash.wowtheme7.com/demo/users-list.html by HTTrack Website Copier/3.x [XR&CO'2014], Mon, 03 Feb 2025 04:44:16 GMT -->
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Store 24-Manage users</title>
        <link rel="icon" type="image/png" href="assets/images/favicon.png" sizes="16x16">
        <!-- CSS here -->
        <jsp:include page="../../common/dashboard/css-dashboard.jsp"></jsp:include>
        </head>
        <body>
            <!-- Sidebar -->
        <jsp:include page="../../common/dashboard/sidebar-dashboard.jsp"></jsp:include>

            <!-- Header -->
        <jsp:include page="../../common/dashboard/header-dashboard.jsp"></jsp:include>

        <c:url value="/manage-users" var="paginationUrl">
            <c:param name="action" value="list" />
            <c:if test="${not empty param.role}">
                <c:param name="role" value="${param.role}" />
            </c:if>
            <c:if test="${not empty param.sex}">
                <c:param name="sex" value="${param.sex}" />
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
                <h6 class="fw-semibold mb-0">Users List</h6>
                <ul class="d-flex align-items-center gap-2">
                    <li class="fw-medium">
                        <a href="index.html" class="d-flex align-items-center gap-1 hover-text-primary">
                            <iconify-icon icon="solar:home-smile-angle-outline" class="icon text-lg"></iconify-icon>
                            Dashboard
                        </a>
                    </li>
                    <li>-</li>
                    <li class="fw-medium">Users List</li>
                </ul>
            </div>

            <div class="card h-100 p-0 radius-12">
                <div class="card-header border-bottom bg-base py-16 px-24 d-flex align-items-center flex-wrap gap-3 justify-content-between">
                    <div class="d-flex align-items-center flex-wrap gap-3"> 
                        <form action="${pageContext.request.contextPath}/manage-users" method="GET" class="d-flex align-items-center gap-3">
                            <div class="navbar-search">
                                <input type="text" class="bg-base h-40-px w-auto" name="search" placeholder="Search" value='${param.search}'>
                                <iconify-icon icon="ion:search-outline" class="icon"></iconify-icon>
                            </div>

                            <select class="form-select form-select-sm w-auto ps-12 py-6 radius-12 h-40-px" name="status">
                                <option value="">All Status</option>
                                <option value="1" ${param.status == '1' ? 'selected' : ''}>Active</option>
                                <option value="0" ${param.status == '0' ? 'selected' : ''}>Inactive</option>
                            </select>

                            <select class="form-select form-select-sm w-auto ps-12 py-6 radius-12 h-40-px" name="role">
                                <option value="">All Role</option>
                                <option value="2" ${param.role == '2' ? 'selected' : ''}>Sale</option>
                                <option value="3" ${param.role == '3' ? 'selected' : ''}>Marketing</option>
                                <option value="4" ${param.role == '4' ? 'selected' : ''}>User</option>
                                <option value="5" ${param.role == '5' ? 'selected' : ''}>Sale Manager</option>
                                <option value="6" ${param.role == '6' ? 'selected' : ''}>Staff</option>
                            </select>

                            <select class="form-select form-select-sm w-auto ps-12 py-6 radius-12 h-40-px" name="sex">
                                <option value="">All Sex</option>
                                <option value="1" ${param.sex == '1' ? 'selected' : ''}>Male</option>
                                <option value="0" ${param.sex == '0' ? 'selected' : ''}>Female</option>
                            </select>

                            <button type="submit" class="btn btn-primary h-40-px radius-12">Search</button>
                        </form>    
                    </div>

                    <a href="${pageContext.request.contextPath}/manage-users?action=addform" class="btn btn-primary text-sm btn-sm px-12 py-12 radius-8 d-flex align-items-center gap-2"> 
                        <iconify-icon icon="ic:baseline-plus" class="icon text-xl line-height-1"></iconify-icon>
                        Add New User
                    </a>
                </div>
                <div class="card-body p-24">
                    <div class="table-responsive scroll-sm">
                        <table class="table bordered-table sm-table mb-0">
                            <thead>
                                <tr>
                                    <th scope="col">Id</th>   
                                    <th scope="col">FullName</th>
                                    <th scope="col">Email</th>                                       
                                    <th scope="col">BirthDate</th>
                                    <th scope="col">Sex</th>
                                    <th scope="col">Role</th>
                                    <th scope="col">Phone</th>
                                    <th scope="col" class="text-center">Status</th>
                                    <th scope="col" class="text-center">Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="user" items="${users}">
                                    <tr>
                                        <td>${user.id}</td>   
                                        <td>${user.firstName} ${user.lastName}</td>
                                        <td>${user.email}</td>
                                        <td>${user.dob}</td>
                                        <td>${user.sex ? 'Male' : 'Female'}</td>
                                        <td>${user.roleId == 2 ? 'Sale' 
                                              : user.roleId == 3 ? 'Marketing' 
                                              : user.roleId == 4 ? 'User'
                                              : user.roleId == 5 ? 'Sale Manager' 
                                              : "Staff"}</td>
                                        <td>${user.phone}</td>
                                        <td>${user.active ? 'Active' : 'InActive'}</td>
                                        <td class="text-center"> 
                                            <div class="d-flex align-items-center gap-10 justify-content-center">
                                                <button type="button" class="bg-success-focus text-success-600 bg-hover-success-200 fw-medium w-40-px h-40-px d-flex justify-content-center align-items-center rounded-circle"
                                                        onclick="window.location.href = '${pageContext.request.contextPath}/manage-users?action=details&id=${user.id}'"> 
                                                    <iconify-icon icon="lucide:edit" class="menu-icon"></iconify-icon>
                                                </button>
                                                <button type="button" class="bg-danger-focus bg-hover-danger-200 text-danger-600 fw-medium w-40-px h-40-px d-flex justify-content-center align-items-center rounded-circle"
                                                        onclick="confirmDeactivate(${user.id})"> 
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
                function confirmDeactivate(userId) {
                    if (confirm('Are you sure you want to deactivate this account?')) {
                        window.location.href = '${pageContext.request.contextPath}/manage-users?action=deactivate&id=' + userId;
                    }
                }
        </script>


    </main>

</body>

<!-- Mirrored from wowdash.wowtheme7.com/demo/users-list.html by HTTrack Website Copier/3.x [XR&CO'2014], Mon, 03 Feb 2025 04:44:16 GMT -->
</html>

