<%-- 
    Document   : sidebar
    Created on : Feb 8, 2025, 6:46:52 PM
    Author     : ADMIN
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
            <!-- <li>
              <a href="${pageContext.request.contextPath}/manage-variation">
                <iconify-icon icon="icon-park-outline:setting-two" class="menu-icon"></iconify-icon>
                <span>Variation Management</span> 
              </a>
            </li> -->
            <li>
                <a href="${pageContext.request.contextPath}/change-password">
                    <iconify-icon icon="icon-park-outline:setting-two" class="menu-icon"></iconify-icon>
                    <span>Change Password</span> 
                </a>
            </li>
          
            <li>
                <a href="${pageContext.request.contextPath}/order-history">
                    <iconify-icon icon="icon-park-outline:setting-two" class="menu-icon"></iconify-icon>
                    <span>Order History </span> 
                </a>
            </li>
            <li>
                <a href="${pageContext.request.contextPath}/admin/orders">
                    <iconify-icon icon="icon-park-outline:setting-two" class="menu-icon"></iconify-icon>
                    <span>Order Management </span> 
                </a>
            </li>

        </ul>
    </div>
</aside>
