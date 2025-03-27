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
                                <div class="header-cart">
                                    <div class="cart-icon"> <a href="${pageContext.request.contextPath}/cart">Cart<i
                                                class="zmdi zmdi-shopping-cart"></i></a>  </div>
                                   
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
<!--                                    <ul class="dropdown">
                                        <li><a class="active" href="${pageContext.request.contextPath}/products">Home One</a></li>
                                        <li><a href="${pageContext.request.contextPath}/order-history">Home Two</a></li>
                                        <li><a href="index-boxed-01.html">Home Three (Boxed)</a></li>
                                        <li><a href="index-boxed-02.html">Home Four (Boxed)</a></li>
                                    </ul>-->
                                </li>
                                <li ><a class="" href="${pageContext.request.contextPath}/products">Shop</a>

                                </li>
                                <li class="mega-parent pos-rltv"><a href="${pageContext.request.contextPath}/products?category=1">Man</a>
<!--                                    <div class="mega-menu-area mma-800">
                                        <ul class="single-mega-item">
                                            <li class="menu-title uppercase">Shirts</li>
                                            <li><a href="shop.html">Shirt 01</a></li>
                                            <li><a href="shop.html">Shirt 02</a></li>
                                            <li><a href="shop.html">Shirt 03</a></li>
                                            <li><a href="shop.html">Shirt 04</a></li>
                                        </ul>
                                        <ul class="single-mega-item">
                                            <li class="menu-title uppercase">Pants</li>
                                            <li><a href="shop.html">Pant 01</a></li>
                                            <li><a href="shop.html">Pant 02</a></li>
                                            <li><a href="shop.html">Pant 03</a></li>
                                            <li><a href="shop.html">Pant 04</a></li>
                                        </ul>
                                        <ul class="single-mega-item">
                                            <li class="menu-title uppercase">T-Shirts</li>
                                            <li><a href="shop.html">T-Shirt 01</a></li>
                                            <li><a href="shop.html">T-Shirt 02</a></li>
                                            <li><a href="shop.html">T-Shirt 03</a></li>
                                            <li><a href="shop.html">T-Shirt 04</a></li>
                                        </ul>
                                        <div class="mega-banner-img">
                                            <a href="single-product.html"><img
                                                    src="${pageContext.request.contextPath}/assets/home/images/banner/banner-fashion-02.jpg" alt=""></a>
                                        </div>
                                    </div>-->
                                </li>
                                <li class="mega-parent pos-rltv"><a href="${pageContext.request.contextPath}/products?category=2">Women</a>
<!--                                    <div class="mega-menu-area mma-700">
                                        <ul class="single-mega-item">
                                            <li class="menu-title uppercase">Sharees</li>
                                            <li><a href="shop.html">Sharee 01</a></li>
                                            <li><a href="shop.html">Sharee 02</a></li>
                                            <li><a href="shop.html">Sharee 03</a></li>
                                            <li><a href="shop.html">Sharee 04</a></li>
                                            <li><a href="shop.html">Sharee 05</a></li>
                                        </ul>
                                        <ul class="single-mega-item">
                                            <li class="menu-title uppercase">Lahenga</li>
                                            <li><a href="shop.html">Lahenga 01</a></li>
                                            <li><a href="shop.html">Lahenga 02</a></li>
                                            <li><a href="shop.html">Lahenga 03</a></li>
                                            <li><a href="shop.html">Lahenga 04</a></li>
                                            <li><a href="shop.html">Lahenga 05</a></li>
                                        </ul>
                                        <ul class="single-mega-item">
                                            <li class="menu-title uppercase">Sandels</li>
                                            <li><a href="shop.html">Sandel 01</a></li>
                                            <li><a href="shop.html">Sandel 02</a></li>
                                            <li><a href="shop.html">Sandel 03</a></li>
                                            <li><a href="shop.html">Sandel 04</a></li>
                                            <li><a href="shop.html">Sandel 05</a></li>
                                        </ul>
                                        <div class="mega-banner-img">
                                            <a href="single-product.html"><img
                                                    src="${pageContext.request.contextPath}/assets/home/images/banner/banner-fashion.jpg" alt=""></a>
                                        </div>
                                    </div>-->
                                </li>
                                <li><a href="blog.html">BLOG</a></li>
                                <li><a href="about-us.html">ABOUT</a></li>
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
                                                <ul>
                                                    <li><a class="active" href="index.html">Home One</a></li>
                                                    <li><a href="index-2.html">Home Two</a></li>
                                                    <li><a href="index-boxed-01.html">Home Three (Boxed)</a>
                                                    </li>
                                                    <li><a href="index-boxed-02.html">Home Four (Boxed)</a></li>
                                                </ul>
                                            </li>
                                            <li><a href="shop.html">Man</a>
                                                <ul class="single-mega-item">
                                                    <li><a href="shop.html">Shirt 01</a></li>
                                                    <li><a href="shop.html">Shirt 02</a></li>
                                                    <li><a href="shop.html">Shirt 03</a></li>
                                                    <li><a href="shop.html">Shirt 04</a></li>
                                                    <li><a href="shop.html">Pant 01</a></li>
                                                    <li><a href="shop.html">Pant 02</a></li>
                                                    <li><a href="shop.html">Pant 03</a></li>
                                                    <li><a href="shop.html">Pant 04</a></li>
                                                    <li><a href="shop.html">T-Shirt 01</a></li>
                                                    <li><a href="shop.html">T-Shirt 02</a></li>
                                                    <li><a href="shop.html">T-Shirt 03</a></li>
                                                    <li><a href="shop.html">T-Shirt 04</a></li>
                                                </ul>
                                            </li>
                                            <li><a href="shop.html">Shop</a>
                                                <ul class="single-mega-item">
                                                    <li><a href="shop.html">Sharee 01</a></li>
                                                    <li><a href="shop.html">Sharee 02</a></li>
                                                    <li><a href="shop.html">Sharee 03</a></li>
                                                    <li><a href="shop.html">Sharee 04</a></li>
                                                    <li><a href="shop.html">Sharee 05</a></li>
                                                    <li><a href="shop.html">Lahenga 01</a></li>
                                                    <li><a href="shop.html">Lahenga 02</a></li>
                                                    <li><a href="shop.html">Lahenga 03</a></li>
                                                    <li><a href="shop.html">Lahenga 04</a></li>
                                                    <li><a href="shop.html">Lahenga 05</a></li>
                                                    <li><a href="shop.html">Sandel 01</a></li>
                                                    <li><a href="shop.html">Sandel 02</a></li>
                                                    <li><a href="shop.html">Sandel 03</a></li>
                                                    <li><a href="shop.html">Sandel 04</a></li>
                                                    <li><a href="shop.html">Sandel 05</a></li>
                                                </ul>
                                            </li>
                                            <li><a href="#">Shortcode</a>
                                                <ul class="single-mega-item">
                                                    <li><a href="shortcode-banner.html">shortcode-banner</a>
                                                    </li>
                                                    <li><a
                                                            href="shortcode-best-top-on-sale-slider.html">too-on-sale</a>
                                                    </li>
                                                    <li><a href="shortcode-blog-item.html">Short
                                                            Blog Item</a></li>
                                                    <li><a href="shortcode-brand-prodcut.html">Brand Product</a>
                                                    </li>
                                                    <li><a href="shortcode-brand-slider.html">Brand Slider</a>
                                                    </li>

                                                    <li><a href="shortcode-breadcrumb.html">Breadcrumb</a></li>
                                                    <li><a href="shortcode-related-product.html">Related
                                                            Product</a></li>
                                                    <li><a href="shortcode-service.html">Service</a></li>
                                                    <li><a href="shortcode-skill.html">Skill</a>
                                                    </li>
                                                    <li><a href="shortcode-slider.html">Slider</a></li>

                                                    <li><a href="shortcode-team.html">Team</a>
                                                    </li>
                                                    <li><a href="shortcode-testimonial.html">Testimonial</a>
                                                    </li>
                                                    <li><a href="shortcode-why-choose-us.html">Why Choose Us</a>
                                                    </li>
                                                </ul>
                                            </li>
                                            <li> <a href="#">Pages</a>
                                                <ul class="single-mega-item coloum-4">
                                                    <li><a href="about-us.html">About-us</a>
                                                    </li>
                                                    <li><a href="blog.html">Blog</a></li>
                                                    <li><a href="blog-right.html">Blog-Right</a>
                                                    </li>
                                                    <li><a href="single-blog.html">Single
                                                            Blog</a></li>
                                                    <li><a href="single-blog-right.html">Single
                                                            Blog Right</a></li>
                                                    <li><a href="blog-full.html">Blog-Fullwidth</a></li>
                                                    <li class="menu-title uppercase">pages-02</li>
                                                    <li><a href="blog-full-right.html">Blog Ful
                                                            Rightl</a></li>
                                                    <li><a href="cart.html">Cart</a></li>
                                                    <li><a href="checkout.html">Checkout</a>
                                                    </li>
                                                    <li><a href="compare.html">Compare</a></li>
                                                    <li><a href="complete-order.html">Complete
                                                            Order</a></li>
                                                    <li><a href="contact-us.html">Contact US</a>
                                                    </li>
                                                    <li class="menu-title uppercase">pages-03</li>
                                                    <li><a href="login.html">Login</a></li>
                                                    <li><a href="my-account.html">My Account</a>
                                                    </li>
                                                    <li><a href="shop-full-grid.html">Shop Full
                                                            Grid</a></li>
                                                    <li><a href="shop-full-list.html">Shop Full
                                                            List</a></li>
                                                    <li><a href="shop-list-right-sidebar.html">Shop List
                                                            Right</a></li>
                                                    <li><a href="shop-list.html">Shop List</a>
                                                    </li>
                                                    <li class="menu-title uppercase">pages-03</li>
                                                    <li><a href="shop-right-sidebar.html">Shop
                                                            Right</a></li>
                                                    <li><a href="shop.html">Shop</a></li>
                                                    <li><a href="single-product.html">Single
                                                            Prodcut</a></li>
                                                    <li><a href="wishlist.html">Wishlist</a>
                                                    </li>
                                                </ul>
                                            </li>
                                            <li><a href="about-us.html">about</a></li>
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