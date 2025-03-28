<%-- 
    Document   : sidebar
    Created on : Feb 8, 2025, 6:46:52 PM
    Author     : ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<aside class="sidebar">
    <button type="button" class="sidebar-close-btn">
        <iconify-icon icon="radix-icons:cross-2"></iconify-icon>
    </button>
    <div>
        <a href="${pageContext.request.contextPath}/home" class="sidebar-logo">
            <img src="${pageContext.request.contextPath}/assets/admin/images/STORE 24.png" alt="site logo" class="light-logo">
            <img src="${pageContext.request.contextPath}/assets/admin/images/logo-light.png" alt="site logo" class="dark-logo">
            <img src="${pageContext.request.contextPath}/assets/admin/images/logo-icon.png" alt="site logo" class="logo-icon">
        </a>
    </div>
    <div class="sidebar-menu-area">
        <ul class="sidebar-menu" id="sidebar-menu">
            <li>
                <a href="${pageContext.request.contextPath}/profile">
                    <iconify-icon icon="flowbite:users-group-outline" class="menu-icon"></iconify-icon>
                    <span>Profile</span> 
                </a>
            </li>
            <c:if test="${sessionScope.account.roleId == '1' || sessionScope.account.roleId == '6'}">
                <li>
                    <a href="${pageContext.request.contextPath}/manage-story">
                        <iconify-icon icon="flowbite:users-group-outline" class="menu-icon"></iconify-icon>
                        <span>Story Management</span> 
                    </a>
                </li>
                <li>
                    <a href="${pageContext.request.contextPath}/manage-blog">
                        <iconify-icon icon="flowbite:users-group-outline" class="menu-icon"></iconify-icon>
                        <span>Blog Management</span> 
                    </a>
                </li>
                <li>
                    <a href="${pageContext.request.contextPath}/manage-users">
                        <iconify-icon icon="flowbite:users-group-outline" class="menu-icon"></iconify-icon>
                        <span>Users Management</span> 
                    </a>
                </li>
                <li>
                    <a href="${pageContext.request.contextPath}/manage-settings">
                        <iconify-icon icon="icon-park-outline:setting-two" class="menu-icon"></iconify-icon>
                        <span>Settings Management</span> 
                    </a>
                </li>
                <li>
                    <a href="${pageContext.request.contextPath}/manage-customers">
                        <iconify-icon icon="icon-park-outline:setting-two" class="menu-icon"></iconify-icon>
                        <span>Customer Management</span> 
                    </a>
                </li>
                <li>
                    <a href="${pageContext.request.contextPath}/manage-products">
                        <iconify-icon icon="icon-park-outline:setting-two" class="menu-icon"></iconify-icon>
                        <span>Product Management</span> 
                    </a>
                </li>
                <li>
                    <a href="${pageContext.request.contextPath}/change-password">
                        <iconify-icon icon="icon-park-outline:setting-two" class="menu-icon"></iconify-icon>
                        <span>Change Password</span> 
                    </a>
                </li>
                <li>
                    <a href="${pageContext.request.contextPath}/admin/orders">
                        <iconify-icon icon="icon-park-outline:setting-two" class="menu-icon"></iconify-icon>
                        <span>Order Management </span> 
                    </a>
                </li>
            </c:if>
            <c:if test="${sessionScope.account.roleId == '4'}">

                <li>
                    <a href="${pageContext.request.contextPath}/order-history">
                        <iconify-icon icon="icon-park-outline:setting-two" class="menu-icon"></iconify-icon>
                        <span>Order History </span> 
                    </a>
                </li>
            </c:if>
        </ul>
    </div>
</aside>
