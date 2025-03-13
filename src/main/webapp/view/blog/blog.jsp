<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!doctype html>
<html class="no-js" lang="en">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="x-ua-compatible" content="ie=edge">
        <title>Blog || Clothing</title>
        <meta name="description" content="Clothing – eCommerce Fashion Template is a clean and elegant design suitable for selling clothing, fashion, accessories,...">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="shortcut icon" type="image/x-icon" href="images/icons/favicon.png">
        <!-- Include CSS cho blog -->
        <jsp:include page="../common/blog/css-blog.jsp"></jsp:include>
        <!-- Modernizr JS -->
        <script src="js/vendor/modernizr-3.11.2.min.js"></script>
    </head>
    <body>
        <!--[if lt IE 8]>
            <p class="browserupgrade">You are using an <strong>outdated</strong> browser. Please <a href="http://browsehappy.com/">upgrade your browser</a> to improve your experience.</p>
        <![endif]-->  

        <!-- Body main wrapper start -->
        <div class="wrapper blog">
            <!-- Header area -->
            <jsp:include page="../common/blog/header-blog.jsp"></jsp:include>
            
            <!-- Breadcumb area start -->
            <div class="breadcumb-area breadcumb-2 overlay pos-rltv">
                <div class="bread-main">
                    <div class="bred-hading text-center">
                        <h5>Blog Details</h5>
                    </div>
                    <ol class="breadcrumb">
                        <li class="home"><a title="Go to Home Page" href="index.html">Home</a></li>
                        <li class="active">Blog</li>
                    </ol>
                </div>
            </div>
            <!-- Breadcumb area end -->

            <!-- Blog main area start -->
            <div class="shop-main-area pt-70 pb-40">
                <div class="container">
                    <div class="row">
                        <!-- Sidebar start -->
                        <div class="col-lg-3 col-md-4 order-lg-1 order-md-1 order-2">
                            <div class="shop-sidebar blog-sidebar">
                                <!-- Search aside -->
                                <aside class="single-aside search-aside search-box">
                                    <form action="#">
                                        <div class="input-box">
                                            <input class="single-input" placeholder="Search...." type="text">
                                            <button class="src-btn sb-2"><i class="fa fa-search"></i></button>
                                        </div>
                                    </form>
                                </aside>
                                <!-- Categories aside -->
                                <aside class="single-aside catagories-aside">
                                    <div class="heading-title aside-title pos-rltv">
                                        <h5 class="uppercase">Categories</h5>
                                    </div>
                                    <div id="cat-treeview" class="product-cat">
                                        <ul>
                                            <c:forEach var="cat" items="${categories}">
                                                <li class="closed">
                                                    <!-- Khi click vào category, chuyển qua action=category với parameter "category" -->
                                                    <a href="${pageContext.request.contextPath}/blog?action=category&category=${cat.id}">
                                                        ${cat.name}
                                                    </a>
                                                </li>
                                            </c:forEach>
                                        </ul>
                                    </div>
                                </aside>
                                <!-- Các aside khác (Tag, Recent Product, ...) có thể giữ nguyên -->
                                <aside class="single-aside tag-aside">
                                    <div class="heading-title aside-title pos-rltv">
                                        <h5 class="uppercase">Product Tags</h5>
                                    </div>
                                    <ul class="tag-filter mt-30">
                                        <li><a href="#">Fashion</a></li>
                                        <li><a href="#">Women</a></li>
                                        <li><a href="#">Winter</a></li>
                                        <li><a href="#">Street Style</a></li>
                                        <li><a href="#">Style</a></li>
                                        <li><a href="#">Shop</a></li>
                                        <li><a href="#">Collection</a></li>
                                        <li><a href="#">Spring 2022</a></li>
                                    </ul>
                                </aside>
                            </div>
                        </div>
                        <!-- Sidebar end -->

                        <!-- Blog listing area start -->
                        <div class="col-lg-9 col-md-8 order-lg-1 order-md-1 order-2">
                            <div class="blog-listing">
                                <c:forEach var="blog" items="${blogs}">
                                    <div class="blog-item">
                                        <img src="${blog.thumbnail}" alt="Blog Image" class="blog-thumbnail">
                                        <h3 class="blog-title">${blog.title}</h3>
                                        <p class="blog-brief">${blog.briefInfo}</p>
                                        <a href="${pageContext.request.contextPath}/blog?action=view&id=${blog.id}" class="read-more">READ MORE</a>
                                    </div>
                                </c:forEach>
                            </div>
                        </div>
                        <!-- Blog listing area end -->
                    </div>
                </div>
            </div>
            <!-- Blog main area end -->

            <!-- Footer area start -->
            <jsp:include page="../common/blog/footer-blog.jsp"></jsp:include>
        </div>
        <!-- Body main wrapper end -->

        <!-- Include JS files -->
        <jsp:include page="../common/blog/js-blog.jsp"></jsp:include>
    </body>
</html>
