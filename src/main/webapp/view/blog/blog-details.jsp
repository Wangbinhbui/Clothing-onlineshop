<%-- 
    Document   : blog-details
    Created on : Feb 9, 2025, 11:01:48 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!doctype html>
<html class="no-js" lang="en">


<!-- Mirrored from htmldemo.net/clothing/clothing/single-blog.html by HTTrack Website Copier/3.x [XR&CO'2014], Sat, 01 Feb 2025 03:37:50 GMT -->
<head>
    <meta charset="utf-8">
    <meta http-equiv="x-ua-compatible" content="ie=edge">
    <title>${blog.title} | Store 24</title>
    <meta name="description" content="${blog.briefInfo}">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <link rel="shortcut icon" type="image/x-icon" href="images/icons/favicon.png">
    <!-- Place favicon.png in the root directory -->

    <!-- All css files are included here. -->
    <jsp:include page="../common/home/css-home.jsp"></jsp:include>

</head>

<body>
    <!--[if lt IE 8]>
        <p class="browserupgrade">You are using an <strong>outdated</strong> browser. Please <a href="http://browsehappy.com/">upgrade your browser</a> to improve your experience.</p>
    <![endif]-->

    <!-- Body main wrapper start -->
    <div class="wrapper single-blog">

        <!-- Start of header area -->
        <jsp:include page="../common/home/header-homepage.jsp"></jsp:include>
        <!-- End of header area -->

        <!--breadcumb area start -->
        <div class="breadcumb-area breadcumb-2 overlay pos-rltv">
            <div class="bread-main">
                <div class="bred-hading text-center">
                    <h5>${blog.title}</h5>
                </div>
                <ol class="breadcrumb">
                    <li class="home"><a title="Go to Home Page" href="${pageContext.request.contextPath}/home">Home</a></li>
                    <li><a href="${pageContext.request.contextPath}/blogs">Blog</a></li>
                    <li class="active">Blog Details</li>
                </ol>
            </div>
        </div>
        <!--breadcumb area end -->

        <!--single blog main area are start-->
        <div class="shop-main-area pt-70 pb-40">
            <div class="container">
                <div class="row">
                    <!--shop sidebar start-->
                    <div class="col-lg-3 col-md-4 order-lg-1 order-md-1 order-2">
                        <div class="shop-sidebar blog-sidebar">
                            <!--single aside start-->
                            <aside class="single-aside search-aside search-box">
                                <form action="${pageContext.request.contextPath}/blogs" method="GET">
                                    <div class="input-box">
                                        <input class="single-input" placeholder="Search...." type="text" name="search">
                                        <button type="submit" class="src-btn sb-2"><i class="fa fa-search"></i></button>
                                    </div>
                                </form>
                            </aside>
                            <!--single aside end-->

                            <!--single aside start-->
                            <aside class="single-aside catagories-aside">
                                <div class="heading-title aside-title pos-rltv">
                                    <h5 class="uppercase">categories</h5>
                                </div>
                                <div id="cat-treeview" class="product-cat">
                                    <ul>
                                        <li>
                                            <a href="${pageContext.request.contextPath}/blogs">All Categories</a>
                                        </li>
                                        <c:forEach var="cat" items="${categories}">
                                            <li class="${category.id == cat.id ? 'active' : ''}">
                                                <a href="${pageContext.request.contextPath}/blogs?category=${cat.id}">${cat.name}</a>
                                            </li>
                                        </c:forEach>
                                    </ul>
                                </div>
                            </aside>
                            <!--single aside end-->

                            <!--single aside start-->
                            <aside class="single-aside tag-aside">
                                <div class="heading-title aside-title pos-rltv">
                                    <h5 class="uppercase">Popular Tags</h5>
                                </div>
                                <ul class="tag-filter mt-30">
                                    <li><a href="${pageContext.request.contextPath}/blogs?search=fashion">Fashion</a></li>
                                    <li><a href="${pageContext.request.contextPath}/blogs?search=style">Style</a></li>
                                    <li><a href="${pageContext.request.contextPath}/blogs?search=trend">Trends</a></li>
                                    <li><a href="${pageContext.request.contextPath}/blogs?search=collection">Collection</a></li>
                                    <li><a href="${pageContext.request.contextPath}/blogs?search=apparel">Apparel</a></li>
                                </ul>
                            </aside>
                            <!--single aside end-->

                            <!-- If you have related blogs -->
                            <c:if test="${not empty relatedBlogs}">
                                <aside class="single-aside">
                                    <div class="heading-title aside-title pos-rltv">
                                        <h5 class="uppercase">Related Articles</h5>
                                    </div>
                                    <div class="recent-post mt-30">
                                        <c:forEach var="relatedBlog" items="${relatedBlogs}">
                                            <div class="single-post mb-20">
                                                <div class="post-img">
                                                    <a href="${pageContext.request.contextPath}/blogs?action=view&id=${relatedBlog.id}">
                                                        <img src="${pageContext.request.contextPath}/${relatedBlog.thumbnail}" alt="${relatedBlog.title}"
                                                             style="width: 70px; height: 70px; object-fit: cover;" 
                                                             onerror="this.src='${pageContext.request.contextPath}/assets/images/blog/blog7.png'">
                                                    </a>
                                                </div>
                                                <div class="post-text">
                                                    <h4><a href="${pageContext.request.contextPath}/blogs?action=view&id=${relatedBlog.id}">${relatedBlog.title}</a></h4>
                                                    <span>
                                                        <fmt:parseDate value="${relatedBlog.createdDate}" pattern="yyyy-MM-dd'T'HH:mm:ss" var="rParsedDate" type="both" />
                                                        <fmt:formatDate value="${rParsedDate}" pattern="MMM dd, yyyy" />
                                                    </span>
                                                </div>
                                            </div>
                                        </c:forEach>
                                    </div>
                                </aside>
                            </c:if>
                        </div>
                    </div>
                    <!--shop sidebar end-->

                    <!--main-shop-product start-->
                    <div class="col-lg-9 col-md-8 order-lg-2 order-md-2 order-1">
                        <div class="single-blog-body">
                            <div class="single-blog sb-2 mb-30">
                                <div class="blog-img pos-rltv product-overlay">
                                    <img src="${pageContext.request.contextPath}/${blog.thumbnail}" alt="${blog.title}"
                                         style="width: 100%; height: auto; max-height: 500px; object-fit: cover;"
                                         onerror="this.src='${pageContext.request.contextPath}/assets/images/blog/blog7.png'">
                                </div>
                                <div class="blog-content">
                                    <div class="blog-title">
                                        <h5 class="uppercase font-bold">${blog.title}</h5>
                                        <div class="like-comments-date">
                                            <ul>
                                                <li class="blog-date">
                                                    <a href="#">
                                                        <i class="zmdi zmdi-calendar-alt"></i>
                                                        <fmt:parseDate value="${blog.createdDate}" pattern="yyyy-MM-dd'T'HH:mm:ss" var="parsedDate" type="both" />
                                                        <fmt:formatDate value="${parsedDate}" pattern="MMMM dd, yyyy" />
                                                    </a>
                                                </li>
                                                <li>
                                                    <a href="${pageContext.request.contextPath}/blogs?category=${category.id}">
                                                        <i class="zmdi zmdi-label"></i> ${category.name}
                                                    </a>
                                                </li>
                                                <li>
                                                    <a href="#">
                                                        <i class="zmdi zmdi-account"></i> ${author.firstName} ${author.lastName}
                                                    </a>
                                                </li>
                                            </ul>
                                        </div>
                                        <div class="blog-text">
                                            <!-- Display the brief info first -->
                                            <p><strong>${blog.briefInfo}</strong></p>
                                            
                                            <!-- Display the main content -->
                                            ${blog.content}
                                        </div>
                                    </div>
                                </div>
                            </div>
                            
                            <!-- Related Blogs Section (for mobile display) -->
                            <c:if test="${not empty relatedBlogs}">
                                <div class="related-blogs d-block d-md-none mt-40">
                                    <h5 class="uppercase font-bold mb-20">Related Articles</h5>
                                    <div class="row">
                                        <c:forEach var="relatedBlog" items="${relatedBlogs}">
                                            <div class="col-md-4 col-sm-6 mb-20">
                                                <div class="single-blog sb-2" style="height: 100%;">
                                                    <div class="blog-img pos-rltv product-overlay">
                                                        <a href="${pageContext.request.contextPath}/blogs?action=view&id=${relatedBlog.id}">
                                                            <img src="${pageContext.request.contextPath}/${relatedBlog.thumbnail}" alt="${relatedBlog.title}"
                                                                 style="width: 100%; height: 150px; object-fit: cover;"
                                                                 onerror="this.src='${pageContext.request.contextPath}/assets/images/blog/blog7.png'">
                                                        </a>
                                                    </div>
                                                    <div class="blog-content" style="padding: 15px;">
                                                        <div class="blog-title">
                                                            <h5 style="font-size: 16px; margin-bottom: 10px;">
                                                                <a href="${pageContext.request.contextPath}/blogs?action=view&id=${relatedBlog.id}">${relatedBlog.title}</a>
                                                            </h5>
                                                            <span style="font-size: 12px; color: #777;">
                                                                <fmt:parseDate value="${relatedBlog.createdDate}" pattern="yyyy-MM-dd'T'HH:mm:ss" var="rParsedDate" type="both" />
                                                                <fmt:formatDate value="${rParsedDate}" pattern="MMM dd, yyyy" />
                                                            </span>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </c:forEach>
                                    </div>
                                </div>
                            </c:if>
                        </div>
                    </div>
                    <!--main-shop-product end-->
                </div>
            </div>
        </div>
        <!--single blog main area are end-->

        <!-- footer area start-->
        <jsp:include page="../common/home/footer-homepage.jsp"></jsp:include>
        <!--footer bottom area end-->

    </div>
    <!-- Body main wrapper end -->

    <!-- Placed js at the end of the document so the pages load faster -->

    <!-- jquery latest version -->
    <jsp:include page="../common/home/js-home.jsp"></jsp:include>

</body>


<!-- Mirrored from htmldemo.net/clothing/clothing/single-blog.html by HTTrack Website Copier/3.x [XR&CO'2014], Sat, 01 Feb 2025 03:37:51 GMT -->
</html>