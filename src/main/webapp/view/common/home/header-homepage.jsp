<%-- 
    Document   : header-homepage
    Created on : Feb 5, 2025, 9:30:03 PM
    Author     : ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<header class="header-area header-wrapper">
    <div class="header-top-bar black-bg clearfix">
        <div class="container">
            <div class="row">
                <div class="col-md-3 col-sm-6 col-6">
                    <div class="login-register-area">
                        <ul >
                            <c:if test="${sessionScope.account == null}">
                                <li><a href="${pageContext.request.contextPath}/authen?action=login">Login</a></li>
                                <li><a href="${pageContext.request.contextPath}/authen?action=sign-up">Register</a></li>
                            </c:if>
                            <c:if test="${sessionScope.account != null}">
                                <li><a href="${pageContext.request.contextPath}/authen?action=logout">Logout</a></li>
                                <li><a href="${pageContext.request.contextPath}/profile">Dashboard</a></li>
                            </c:if>
                        </ul>
                    </div>
                </div>
                <div class="col-md-6 d-none d-md-block">
                    <div class="social-search-area text-center">
                        <div class="social-icon socile-icon-style-2">
                            <ul>
                                <li><a href="#" title="facebook"><i class="fa fa-facebook"></i></a> </li>
                                <li><a href="#" title="twitter"><i class="fa fa-twitter"></i></a> </li>
                                <li> <a href="#" title="dribble"><i class="fa fa-dribbble"></i></a></li>
                                <li> <a href="#" title="behance"><i class="fa fa-behance"></i></a> </li>
                                <li> <a href="#" title="rss"><i class="fa fa-rss"></i></a> </li>
                            </ul>
                        </div>
                    </div>
                </div>
                <div class="col-md-3 col-sm-6 col-6">
                    <div class="cart-currency-area login-register-area text-end">
                        <ul>
                            <li>
                                <div class="header-currency">
                                    <select>
                                        <option value="1">USD</option>
                                        <option value="2">Pound</option>
                                        <option value="3">Euro</option>
                                        <option value="4">Dinar</option>
                                    </select>
                                </div>
                            </li>
                            <li>
                                <div class="header-cart">
                                    <div class="cart-icon"> <a href="${pageContext.request.contextPath}/cart">Cart<i
                                                class="zmdi zmdi-shopping-cart"></i></a> </div>
                                </div>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div id="sticky-header" class="header-middle-area">
        <div class="container">
            <div class="full-width-mega-dropdown">
                <div class="row">
                    <div class="col-md-2">
                        <div class="logo ptb-20"><a href="index.html">
                                <img src="${pageContext.request.contextPath}/assets/home/images/logo/STORE 24 (2).png" alt="main logo"></a>
                        </div>
                    </div>
                    <div class="col-lg-7 col-md-10 d-none d-md-block">
                        <nav id="primary-menu">
                            <ul class="main-menu">
                                <li ><a class="active" href="${pageContext.request.contextPath}">Home</a>
                                </li>
                                <li ><a class="" href="${pageContext.request.contextPath}/products">Shop</a>

                                </li>
                                <li class="mega-parent pos-rltv"><a href="${pageContext.request.contextPath}/products?gender=man">Man</a>
                                </li>
                                <li class="mega-parent pos-rltv"><a href="${pageContext.request.contextPath}/products?gender=woman">Women</a>
                                </li>
                                <li><a href="${pageContext.request.contextPath}/blogs">BLOG</a></li>
                                <li><a href="${pageContext.request.contextPath}/about-us">ABOUT</a></li>
                            </ul>
                        </nav>
                    </div>
                    <div class="col-lg-3 d-none d-lg-block">
                        <div class="search-box global-table">
                            <div class="global-row">
                                <div class="global-cell">
                                    <form action="${pageContext.request.contextPath}/products" method="GET">
                                        <div class="input-box">
                                            <input class="single-input" placeholder="Search products..."
                                                   type="text" name="search" value="${param.search}">
                                            <button type="submit" class="src-btn"><i class="fa fa-search"></i></button>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- mobile-menu-area start -->
                    <div class="mobile-menu-area">
                        <div class="container">
                            <div class="row">
                                <div class="col-lg-12">
                                    <nav id="dropdown">
                                        <ul>
                                            <li><a href="index.html">Home</a>
                                            </li>
                                            <li><a href="${pageContext.request.contextPath}/products?gender=man">Man</a>
                                            </li>
                                            <li><a href="${pageContext.request.contextPath}/products?gender=woman">Women</a>
                                            </li>
                                            <li><a href="${pageContext.request.contextPath}/products">Shop</a>
                                            </li>
                                            <li><a href="${pageContext.request.contextPath}/blogs">Blog</a></li>
                                            <li><a href="${pageContext.request.contextPath}/about-us">about</a></li>
                                        </ul>
                                    </nav>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!--mobile menu area end-->
                </div>
            </div>
        </div>
    </div>
</header>