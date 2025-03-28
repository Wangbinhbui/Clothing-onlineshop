<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!doctype html>
<html class="no-js" lang="en">


<!-- Mirrored from htmldemo.net/clothing/clothing/blog.html by HTTrack Website Copier/3.x [XR&CO'2014], Sat, 01 Feb 2025 03:37:50 GMT -->
<head>
    <meta charset="utf-8">
    <meta http-equiv="x-ua-compatible" content="ie=edge">
    <title>Blog | Store 24</title>
    <meta name="description" content="Store 24 – eCommerce Fashion Blog is a clean and elegant design – suitable for selling clothing, fashion, high fashion, men fashion, women fashion, accessories, digital, kids, watches, jewelries, shoes, kids, furniture, sports, tools.">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <link rel="shortcut icon" type="image/x-icon" href="images/icons/favicon.png">
    <!-- Place favicon.png in the root directory -->

    <!-- All css files are included here. -->
    <!-- Bootstrap fremwork main css -->
    <jsp:include page="../common/home/css-home.jsp"></jsp:include>
    
    <!-- Bootstrap Pagination Styling -->
    <style>
        /* Custom Bootstrap Pagination Styling */
        .pagination {
            justify-content: center;
            margin-top: 30px;
            margin-bottom: 40px;
        }
        
        .page-item:not(.active) .page-link {
            color: #333;
            background-color: #f8f9fa;
            border-color: #dee2e6;
        }
        
        .page-item.active .page-link {
            background-color: #ff6a00;
            border-color: #ff6a00;
        }
        
        .page-item:not(.active) .page-link:hover {
            color: #fff;
            background-color: #ff8533;
            border-color: #ff8533;
        }
        
        .page-link {
            padding: 0.5rem 0.75rem;
            margin: 0 3px;
            border-radius: 3px;
            transition: all 0.3s ease;
        }
        
        .page-item:first-child .page-link,
        .page-item:last-child .page-link {
            border-radius: 3px;
        }
        
        .pagination-info {
            text-align: center;
            color: #666;
            font-size: 14px;
            margin-top: 10px;
        }
        
        /* Container for blog items with aspect ratio */
        .single-blog {
            width: 100%;
            margin-bottom: 30px;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 3px 10px rgba(0,0,0,0.1);
            height: 100%;
            display: flex;
            flex-direction: column;
        }
        
        /* Blog image container with aspect ratio */
        .blog-img {
            position: relative;
            width: 100%;
            padding-top: 66.67%; /* 2:3 aspect ratio (height = 66.67% of width) */
            overflow: hidden;
        }
        
        /* Position image absolutely within container to maintain aspect ratio */
        .blog-img img {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: transform 0.5s ease;
        }
        
        /* Hover effect for images */
        .blog-img:hover img {
            transform: scale(1.05);
        }
        
        /* Content area with flexible height */
        .blog-content {
            padding: 5% 6%;
            background: #fff;
            flex-grow: 1;
            display: flex;
            flex-direction: column;
        }
        
        /* Title and text sizing */
        .blog-title h5 {
            font-size: 1.2em;
            margin-bottom: 3%;
        }
        
        .blog-text p {
            margin: 4% 0;
            font-size: 0.95em;
            line-height: 1.6;
        }
        
        /* Responsive adjustments */
        @media (max-width: 768px) {
            .blog-img {
                padding-top: 60%; /* Slightly different aspect ratio on mobile */
            }
        }
    </style>
</head>

<body>
    <!--[if lt IE 8]>
        <p class="browserupgrade">You are using an <strong>outdated</strong> browser. Please <a href="http://browsehappy.com/">upgrade your browser</a> to improve your experience.</p>
    <![endif]-->  

    <!-- Body main wrapper start -->
    <div class="wrapper blog">
       
        <!-- Start of header area -->
        <jsp:include page="../common/home/header-homepage.jsp"></jsp:include>

        <!-- End of header area -->
        
        <!--breadcumb area start -->
        <div class="breadcumb-area breadcumb-2 overlay pos-rltv">
            <div class="bread-main">
                <div class="bred-hading text-center">
                    <h5>Our Blog</h5> </div>
                <ol class="breadcrumb">
                    <li class="home"><a title="Go to Home Page" href="${pageContext.request.contextPath}/home">Home</a></li>
                    <li class="active">Blog</li>
                </ol>
            </div>
        </div>
        <!--breadcumb area end -->
        
        <!--blog main area are start-->
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
                                        <input class="single-input" placeholder="Search...." type="text" name="search" value="${searchFilter}">
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
                                        <li class="${empty categoryFilter ? 'active' : ''}">
                                            <a href="${pageContext.request.contextPath}/blogs">All Categories</a>
                                        </li>
                                        <c:forEach var="category" items="${categories}">
                                            <li class="${categoryFilter == category.id ? 'active' : ''}">
                                                <a href="${pageContext.request.contextPath}/blogs?category=${category.id}">${category.name}</a>
                                            </li>
                                        </c:forEach>
                                    </ul>
                                </div>
                            </aside>
                            <!--single aside end-->
                        </div>
                    </div>
                    <!--shop sidebar end-->
                    
                    <!--main-shop-product start-->
                    <div class="col-lg-9 col-md-8 order-lg-2 order-md-2 order-1">
                       <div class="row">
                            <div class="blog-wraper row">
                                <c:choose>
                                    <c:when test="${not empty blogs}">
                                        <c:forEach var="blog" items="${blogs}">
                                            <div class="col-lg-6">
                                                <div class="single-blog sb-2 mb-30">
                                                    <div class="blog-img pos-rltv product-overlay">
                                                        <a href="${pageContext.request.contextPath}/blogs?action=view&id=${blog.id}">
                                                            <img src="${pageContext.request.contextPath}/${blog.thumbnail}" alt="${blog.title}" 
                                                                 onerror="this.src='${pageContext.request.contextPath}/assets/images/blog/blog7.png'">
                                                        </a>
                                                    </div>
                                                    <div class="blog-content">
                                                        <div class="blog-title">
                                                            <h5 class="uppercase font-bold">
                                                                <a href="${pageContext.request.contextPath}/blogs?action=view&id=${blog.id}">
                                                                    ${blog.title}
                                                                </a>
                                                            </h5>
                                                            <div class="like-comments-date">
                                                                <ul>
                                                                    <li class="blog-date">
                                                                        <a href="#">
                                                                            <i class="zmdi zmdi-calendar-alt"></i>
                                                                            <fmt:parseDate value="${blog.createdDate}" pattern="yyyy-MM-dd'T'HH:mm:ss" var="parsedDate" type="both" />
                                                                            <fmt:formatDate value="${parsedDate}" pattern="dd MMM yyyy" />
                                                                        </a>
                                                                    </li>
                                                                    <li>
                                                                        <c:forEach var="category" items="${categories}">
                                                                            <c:if test="${category.id == blog.categoryId}">
                                                                                <a href="${pageContext.request.contextPath}/blogs?category=${category.id}">
                                                                                    <i class="zmdi zmdi-label"></i> ${category.name}
                                                                                </a>
                                                                            </c:if>
                                                                        </c:forEach>
                                                                    </li>
                                                                </ul>
                                                            </div>
                                                            <div class="blog-text">
                                                                <p>${blog.briefInfo}</p>
                                                            </div> 
                                                            <a class="read-more montserrat" href="${pageContext.request.contextPath}/blogs?action=view&id=${blog.id}">Read More</a>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </c:forEach>
                                    </c:when>
                                    <c:otherwise>
                                        <div class="col-12">
                                            <div class="text-center" style="padding: 50px 0;">
                                                <h4>No blogs found</h4>
                                                <p>Try adjusting your search criteria or category filter.</p>
                                            </div>
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                            
                            <!-- Bootstrap Pagination -->
                            <c:if test="${totalPages > 1}">
                                <div class="col-12">
                                    <nav aria-label="Page navigation">
                                        <ul class="pagination">
                                            <c:if test="${currentPage > 1}">
                                                <li class="page-item">
                                                    <a class="page-link" href="${paginationUrl}page=1" aria-label="First">
                                                        <span aria-hidden="true"><i class="zmdi zmdi-skip-previous"></i></span>
                                                    </a>
                                                </li>
                                                <li class="page-item">
                                                    <a class="page-link" href="${paginationUrl}page=${currentPage - 1}" aria-label="Previous">
                                                        <span aria-hidden="true"><i class="zmdi zmdi-chevron-left"></i></span>
                                                    </a>
                                                </li>
                                            </c:if>
                                            
                                            <c:choose>
                                                <c:when test="${totalPages <= 5}">
                                                    <c:forEach begin="1" end="${totalPages}" var="i">
                                                        <li class="page-item ${currentPage == i ? 'active' : ''}">
                                                            <a class="page-link" href="${paginationUrl}page=${i}">${i}</a>
                                                        </li>
                                                    </c:forEach>
                                                </c:when>
                                                <c:otherwise>
                                                    <c:set var="startPage" value="${Math.max(1, currentPage - 2)}" />
                                                    <c:set var="endPage" value="${Math.min(totalPages, startPage + 4)}" />
                                                    
                                                    <c:if test="${startPage > 1}">
                                                        <li class="page-item">
                                                            <a class="page-link" href="${paginationUrl}page=1">1</a>
                                                        </li>
                                                        <c:if test="${startPage > 2}">
                                                            <li class="page-item disabled">
                                                                <span class="page-link">...</span>
                                                            </li>
                                                        </c:if>
                                                    </c:if>
                                                    
                                                    <c:forEach begin="${startPage}" end="${endPage}" var="i">
                                                        <li class="page-item ${currentPage == i ? 'active' : ''}">
                                                            <a class="page-link" href="${paginationUrl}page=${i}">${i}</a>
                                                        </li>
                                                    </c:forEach>
                                                    
                                                    <c:if test="${endPage < totalPages}">
                                                        <c:if test="${endPage < totalPages - 1}">
                                                            <li class="page-item disabled">
                                                                <span class="page-link">...</span>
                                                            </li>
                                                        </c:if>
                                                        <li class="page-item">
                                                            <a class="page-link" href="${paginationUrl}page=${totalPages}">${totalPages}</a>
                                                        </li>
                                                    </c:if>
                                                </c:otherwise>
                                            </c:choose>
                                            
                                            <c:if test="${currentPage < totalPages}">
                                                <li class="page-item">
                                                    <a class="page-link" href="${paginationUrl}page=${currentPage + 1}" aria-label="Next">
                                                        <span aria-hidden="true"><i class="zmdi zmdi-chevron-right"></i></span>
                                                    </a>
                                                </li>
                                                <li class="page-item">
                                                    <a class="page-link" href="${paginationUrl}page=${totalPages}" aria-label="Last">
                                                        <span aria-hidden="true"><i class="zmdi zmdi-skip-next"></i></span>
                                                    </a>
                                                </li>
                                            </c:if>
                                        </ul>
                                    </nav>
                                    <div class="pagination-info">
                                        Showing page ${currentPage} of ${totalPages} (Total ${totalBlogs} blogs)
                                    </div>
                                </div>
                            </c:if>
                        </div>
                    </div>
                    <!--main-shop-product start-->
                </div>
            </div>
        </div>
        <!--blog main area are end-->
        
        <!--footer bottom area start-->
        <jsp:include page="../common/home/footer-homepage.jsp"></jsp:include>

        <!--footer bottom area end-->
        
    </div> 
    <!-- Body main wrapper end -->

    <!-- Placed js at the end of the document so the pages load faster -->

    <!-- jquery latest version -->
    <jsp:include page="../common/home/js-home.jsp"></jsp:include>

</body>


<!-- Mirrored from htmldemo.net/clothing/clothing/blog.html by HTTrack Website Copier/3.x [XR&CO'2014], Sat, 01 Feb 2025 03:37:50 GMT -->
</html>