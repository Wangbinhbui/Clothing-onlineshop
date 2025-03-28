<%-- 
    Document   : productlist
    Created on : Feb 15, 2025, 11:08:16 AM
    Author     : hung
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!doctype html>
<html class="no-js" lang="en">
    <!-- Mirrored from htmldemo.net/clothing/clothing/index.html by HTTrack Website Copier/3.x [XR&CO'2014], Sat, 01 Feb 2025 03:37:06 GMT -->
    <head>
        <meta charset="utf-8">
        <meta http-equiv="x-ua-compatible" content="ie=edge">
        <title>Home || Clothing</title>
        <meta name="description"
              content="Clothing – eCommerce Fashion Template is a clean and elegant design – suitable for selling clothing, fashion, high fashion, men fashion, women fashion, accessories, digital, kids, watches, jewelries, shoes, kids, furniture, sports, tools….. It has a fully responsive width adjusts automatically to any screen size or resolution.">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <link rel="shortcut icon" type="image/x-icon" href="images/icons/favicon.png">
        <!-- Place favicon.png in the root directory -->
        
        <!-- Prevent the default slider initialization from main.js -->
        <script>
            // Store the original jQuery UI slider function
            window.originalSliderInit = window.originalSliderInit || $.fn.slider;
            
            // Override the price slider initialization from main.js
            $(document).ready(function() {
                var mainJsSliderInit = false;
                
                // Override the slider initialization
                $.fn.slider = function(options) {
                    // Only use the override for the price slider in main.js
                    if (options && options.min === 40 && options.max === 600 && !mainJsSliderInit) {
                        console.log('Prevented default price slider initialization from main.js');
                        mainJsSliderInit = true;
                        return this;
                    }
                    
                    // For all other sliders, use the original slider function
                    return window.originalSliderInit.apply(this, arguments);
                };
            });
        </script>

        <!-- All css files are included here. -->
        <!-- Bootstrap fremwork main css -->
        <jsp:include page="../common/home/css-home.jsp"></jsp:include>
        </head>
    <body>
        <!--[if lt IE 8]>
            <p class="browserupgrade">You are using an <strong>outdated</strong> browser. Please <a href="http://browsehappy.com/">upgrade your browser</a> to improve your experience.</p>
        <![endif]-->  

        <!-- Body main wrapper start -->
        <div class="wrapper shop">

            <!-- Start of header area -->
            <jsp:include page="../common/home/header-homepage.jsp"></jsp:include>
                <!-- End of header area -->

                <!--breadcumb area start -->
                <div class="breadcumb-area breadcumb-2 overlay pos-rltv">
                    <div class="container">
                        <div class="row">
                            <div class="col-xs-12">
                                <div class="breadcumb-wrap text-center">
                                    <h2>
                                        <c:choose>
                                            <c:when test="${not empty search}">
                                                Search Results for: "${search}"
                                            </c:when>
                                            <c:otherwise>
                                                Product List
                                            </c:otherwise>
                                        </c:choose>
                                    </h2>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <!-- Search results summary -->
                                <c:if test="${not empty search}">
                                    <div class="search-summary text-center mt-3 text-white">
                                        <p>Found ${totalProducts} products for "${search}"</p>
                                    </div>
                                </c:if>
                            </div>
                        </div>
                    </div>
                </div>
                <!--breadcumb area end -->

                <!--shop main area are start-->
                <div class="shop-main-area grid-view_area ptb-70">
                    <div class="container">
                        <div class="row">
                        <!--shop sidebar start-->
                        <div class="col-lg-3 col-md-4 order-lg-1 order-md-1 order-2">
                            <div class="shop-sidebar">
                                <!--single aside start-->
                                <aside class="single-aside price-aside fix">
                                    <div class="heading-title aside-title pos-rltv">
                                        <h5 class="uppercase">Price</h5>
                                    </div>
                                    <div class="price_filter">
                                        <div id="slider-range"></div>
                                        <div class="price_slider_amount">
                                                <form id="priceFilterForm" action="${pageContext.request.contextPath}/products" method="GET" accept-charset="UTF-8">
                                                <input type="hidden" id="minPrice" name="minPrice" value="${minPrice != null ? minPrice : dbMinPrice}" />
                                                <input type="hidden" id="maxPrice" name="maxPrice" value="${maxPrice != null ? maxPrice : dbMaxPrice}" />
                                                <div class="price-display-wrapper">
                                                    <input type="text" id="amount" name="price" placeholder="Add Your Price" readonly />
                                                </div>
                                                    <!-- Preserve other parameters -->
                                                    <c:if test="${not empty search}">
                                                        <input type="hidden" name="search" value="${search}" />
                                                    </c:if>
                                                    <c:if test="${not empty sortBy}">
                                                        <input type="hidden" name="sortBy" value="${sortBy}" />
                                                    </c:if>
                                                    <c:if test="${not empty param.colorId}">
                                                        <input type="hidden" name="colorId" value="${param.colorId}" />
                                                    </c:if>
                                                <div class="filter-button-wrapper">
                                                    <input type="submit" value="Filter" class="price-filter-button" />
                                                </div>
                                            </form>
                                        </div>
                                    </div>
                                </aside>
                                <style>
                                    .price-display-wrapper {
                                        margin-bottom: 10px;
                                    }
                                    #amount {
                                        width: 100%;
                                        text-align: center;
                                        font-weight: bold;
                                        color: #333;
                                        border: none;
                                        margin-top: 10px;
                                        font-size: 14px;
                                    }
                                    .filter-button-wrapper {
                                        text-align: center;
                                        margin-top: 10px;
                                    }
                                    .price-filter-button {
                                        background-color: #ff4d4d;
                                        color: white;
                                        border: none;
                                        padding: 8px 20px;
                                        border-radius: 5px;
                                        font-weight: bold;
                                        cursor: pointer;
                                        transition: background-color 0.3s;
                                    }
                                    .price-filter-button:hover {
                                        background-color: #d43f3f;
                                    }
                                    #slider-range {
                                        margin-bottom: 20px;
                                    }
                                    .ui-slider-handle {
                                        cursor: pointer !important;
                                        outline: none !important;
                                    }
                                    .ui-slider-range {
                                        background-color: #ff4d4d !important;
                                    }
                                </style>
                                <script>
                                    document.addEventListener("DOMContentLoaded", function() {
                                        // Wait until document is fully loaded
                                        setTimeout(function() {
                                            try {
                                                // Get min/max prices from server or use defaults
                                                var dbMinPrice = parseFloat(<c:out value="${dbMinPrice}"/> || 0);
                                                var dbMaxPrice = parseFloat(<c:out value="${dbMaxPrice}"/> || 1000000);
                                                
                                                var currentMinPrice = parseFloat(<c:out value="${minPrice != null ? minPrice : dbMinPrice}"/>);
                                                var currentMaxPrice = parseFloat(<c:out value="${maxPrice != null ? maxPrice : dbMaxPrice}"/>);
                                                
                                                // Format currency
                                                function formatCurrency(value) {
                                                    return "$" + value.toLocaleString();
                                                }
                                                
                                                // Destroy any existing slider to avoid conflicts
                                                if ($("#slider-range").slider("instance")) {
                                                    $("#slider-range").slider("destroy");
                                                }
                                                
                                                // Initialize the slider with our values
                                                $("#slider-range").slider({
                                                    range: true,
                                                    min: dbMinPrice,
                                                    max: dbMaxPrice,
                                                    values: [currentMinPrice, currentMaxPrice],
                                                    step: (dbMaxPrice - dbMinPrice) / 100,
                                                    slide: function(event, ui) {
                                                        $("#amount").val(formatCurrency(ui.values[0]) + " - " + formatCurrency(ui.values[1]));
                                                        $("#minPrice").val(ui.values[0]);
                                                        $("#maxPrice").val(ui.values[1]);
                                                    }
                                                });
                                                
                                                // Set initial display values
                                                $("#amount").val(formatCurrency(currentMinPrice) + " - " + formatCurrency(currentMaxPrice));
                                                $("#minPrice").val(currentMinPrice);
                                                $("#maxPrice").val(currentMaxPrice);
                                                
                                                console.log("Price slider initialized with:", {
                                                    min: dbMinPrice,
                                                    max: dbMaxPrice,
                                                    currentMin: currentMinPrice,
                                                    currentMax: currentMaxPrice
                                                });
                                                
                                            } catch (error) {
                                                console.error("Error initializing price slider:", error);
                                            }
                                        }, 500); // Delay to ensure all scripts are loaded
                                        
                                        // Handle form submission
                                        $("#priceFilterForm").on("submit", function() {
                                            var minPrice = parseFloat($("#minPrice").val());
                                            var maxPrice = parseFloat($("#maxPrice").val());
                                            
                                            if (isNaN(minPrice) || isNaN(maxPrice) || minPrice < 0 || maxPrice < minPrice) {
                                                alert("Please select a valid price range");
                                                return false;
                                            }
                                            return true;
                                        });
                                    });
                                </script>
                                <!--single aside end-->

                                <!--single aside start-->
                                <aside class="single-aside color-aside">
                                    <div class="heading-title aside-title pos-rltv">
                                        <h5 class="uppercase">Color</h5>
                                    </div>
                                    <ul class="color-filter mt-30">
                                        <li><a href="${pageContext.request.contextPath}/products?colorId=1" style="background-color: white; border: 2px solid #ccc;" ${param.colorId == '1' ? 'class="active"' : ''}></a></li> <!-- White -->
                                        <li><a href="${pageContext.request.contextPath}/products?colorId=2" style="background-color: blue;" ${param.colorId == '2' ? 'class="active"' : ''}></a></li> <!-- Blue -->
                                        <li><a href="${pageContext.request.contextPath}/products?colorId=3" style="background-color: black;" ${param.colorId == '3' ? 'class="active"' : ''}></a></li> <!-- Black -->
                                        <li><a href="${pageContext.request.contextPath}/products?colorId=4" style="background-color: grey;" ${param.colorId == '4' ? 'class="active"' : ''}></a></li> <!-- Grey -->
                                        <li><a href="${pageContext.request.contextPath}/products?colorId=5" style="background-color: green;" ${param.colorId == '5' ? 'class="active"' : ''}></a></li> <!-- Green -->
                                        <li><a href="${pageContext.request.contextPath}/products?colorId=6" style="background-color: brown;" ${param.colorId == '6' ? 'class="active"' : ''}></a></li> <!-- Brown -->
                                        <li><a href="${pageContext.request.contextPath}/products?colorId=7" style="background-color: orange;" ${param.colorId == '7' ? 'class="active"' : ''}></a></li> <!-- Orange -->
                                        <li><a href="${pageContext.request.contextPath}/products?colorId=8" style="background-color: pink;" ${param.colorId == '8' ? 'class="active"' : ''}></a></li> <!-- Pink -->
                                        <li><a href="${pageContext.request.contextPath}/products?colorId=9" style="background-color: tan;" ${param.colorId == '9' ? 'class="active"' : ''}></a></li> <!-- Tan -->
                                        <li><a href="${pageContext.request.contextPath}/products?colorId=10" style="background-color: red;" ${param.colorId == '10' ? 'class="active"' : ''}></a></li> <!-- Red -->
                                    </ul>
                                    <br>
                                    <div class="clear-filter">
                                        <a href="${pageContext.request.contextPath}/products" class="clear-btn" 
                                           style="display: inline-block; padding: 8px 15px; background-color: #ff4d4d; color: white;
                                           text-decoration: none; border-radius: 5px; font-weight: bold; transition: 0.3s;"
                                           onmouseover="this.style.backgroundColor = '#d43f3f';" 
                                           onmouseout="this.style.backgroundColor = '#ff4d4d';">
                                            Clear 
                                        </a>
                                    </div>
                                </aside>
                                <!--single aside end-->

                                    <!-- Category menu start -->
                                    <div class="panel panel-default">
                                        <!-- <div class="panel-heading">
                                            <h4 class="panel-title">
                                                <a data-toggle="collapse" data-parent="#accordion" href="#collapseThree">COLOR CATEGORIES</a>
                                            </h4>
                                        </div> -->
                                        <div id="collapseThree" class="panel-collapse collapse in">
                                            <div class="panel-body">
                                                <div class="shop-categori-list">
                                                    <ul>
                                                        <!-- Base URL with current parameters except colorId -->
                                                        <c:url value="/products" var="colorBaseUrl">
                                                            <c:param name="page" value="1" />
                                                            <c:if test="${not empty search}">
                                                                <c:param name="search" value="${search}" />
                                                            </c:if>
                                                            <c:if test="${not empty minPrice}">
                                                                <c:param name="minPrice" value="${minPrice}" />
                                                            </c:if>
                                                            <c:if test="${not empty maxPrice}">
                                                                <c:param name="maxPrice" value="${maxPrice}" />
                                                            </c:if>
                                                            <c:if test="${not empty sortBy}">
                                                                <c:param name="sortBy" value="${sortBy}" />
                                                            </c:if>
                                                        </c:url>
                                                        
                                                        <li><a href="${colorBaseUrl}"
                                                               <c:if test="${empty param.colorId}">class="active"</c:if>>All</a>
                                                        </li>
                                                        <li><a href="${colorBaseUrl}&colorId=3"
                                                               <c:if test="${param.colorId == '3'}">class="active"</c:if>>Black</a>
                                                        </li>
                                                        <li><a href="${colorBaseUrl}&colorId=1"
                                                               <c:if test="${param.colorId == '1'}">class="active"</c:if>>White</a>
                                                        </li>
                                                        <li><a href="${colorBaseUrl}&colorId=10"
                                                               <c:if test="${param.colorId == '10'}">class="active"</c:if>>Red</a>
                                                        </li>
                                                        <li><a href="${colorBaseUrl}&colorId=2"
                                                               <c:if test="${param.colorId == '2'}">class="active"</c:if>>Blue</a>
                                                        </li>
                                                        <li><a href="${colorBaseUrl}&colorId=5"
                                                               <c:if test="${param.colorId == '5'}">class="active"</c:if>>Green</a>
                                                        </li>
                                                    </ul>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <!-- End categori menu -->
                                </div>
                            </div>
                            <!--shop sidebar end-->

                            <!--main-shop-product start-->
                            <div class="col-lg-9 col-md-8 order-lg-2 order-md-2 order-1">
                                <div class="shop-wraper">
                                    <div class="col-lg-12">
                                        <div class="shop-area-top">
                                            <div class="row">
                                                <div class="col-xl-6 col-lg-9 col-md-9">
                                                    <div class="sort product-type">
                                                        <label>Sort By</label>
                                                        <select id="input-sort" onchange="location = this.value;">
                                                            <c:url value="/products" var="sortUrl">
                                                                <c:param name="page" value="${currentPage}" />
                                                                <c:if test="${not empty search}">
                                                                    <c:param name="search" value="${search}" />
                                                                </c:if>
                                                                <c:if test="${not empty minPrice}">
                                                                    <c:param name="minPrice" value="${minPrice}" />
                                                                </c:if>
                                                                <c:if test="${not empty maxPrice}">
                                                                    <c:param name="maxPrice" value="${maxPrice}" />
                                                                </c:if>
                                                                <c:if test="${not empty param.colorId}">
                                                                    <c:param name="colorId" value="${param.colorId}" />
                                                                </c:if>
                                                            </c:url>
                                                            <option value="${sortUrl}&sortBy=default" ${sortBy == 'default' ? 'selected' : ''}>Default</option>
                                                            <option value="${sortUrl}&sortBy=name_asc" ${sortBy == 'name_asc' ? 'selected' : ''}>Name (A - Z)</option>
                                                            <option value="${sortUrl}&sortBy=name_desc" ${sortBy == 'name_desc' ? 'selected' : ''}>Name (Z - A)</option>
                                                            <option value="${sortUrl}&sortBy=price_asc" ${sortBy == 'price_asc' ? 'selected' : ''}>Price (Low > High)</option>
                                                            <option value="${sortUrl}&sortBy=price_desc" ${sortBy == 'price_desc' ? 'selected' : ''}>Price (High > Low)</option>
                                                        </select>
                                                    </div>
                                                </div>

                                            </div>

                                        </div>
                                    </div>
                                </div>
                                <div class="clearfix"></div>
                                <div class="col-lg-12">
                                    <div class="shop-total-product-area clearfix mt-35">
                                        <div class="tab-content">
                                            <div role="tabpanel" class="tab-pane fade show active" id="grid">
                                                <div class="total-shop-product-grid row">
                                                    <c:choose>
                                                        <c:when test="${not empty products}">
                                                            <c:forEach items="${products}" var="product">
                                                                <div class="col-lg-4 col-md-6 item">
                                                                    <div class="single-product">
                                                                        <div class="product-img">
                                                                            <div class="product-label red">
                                                                                <div class="new">New</div>
                                                                            </div>
                                                                            <div class="single-prodcut-img product-overlay pos-rltv">
                                                                                <a href="product-detail?productID=${product.productID}">
                                                                                    <img alt="" src="${thumbnails[product.productID]}" class="primary-image" style="width: 200px; height: 200px; object-fit: cover;">
                                                                                </a>
                                                                            </div>
                                                                        </div>
                                                                        <div class="product-text">
                                                                            <div class="prodcut-name">
                                                                                <a href="product-detail?productID=${product.productID}">
                                                                                    ${product.productName}
                                                                                </a>
                                                                            </div>
                                                                            <div class="prodcut-ratting-price">
                                                                                <div class="prodcut-price">
                                                                                    <div class="new-price"> $${product.price} </div>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </c:forEach>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <p>No products available.</p>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="pagination-btn text-center mt-4">
                                        <ul class="page-numbers">
                                            <!-- Previous Button -->
                                            <c:choose>
                                                <c:when test="${currentPage > 1}">
                                                    <li>
                                                        <a href="${paginationUrl}page=${currentPage - 1}" class="next page-numbers">
                                                            <i class="zmdi zmdi-long-arrow-left"></i>
                                                        </a>
                                                    </li>
                                                </c:when>
                                                <c:otherwise>
                                                    <li class="disabled">
                                                        <span class="page-numbers">
                                                            <i class="zmdi zmdi-long-arrow-left"></i>
                                                        </span>
                                                    </li>
                                                </c:otherwise>
                                            </c:choose>
                                            
                                            <!-- First page and ellipsis -->
                                            <c:if test="${startPage > 1}">
                                                <li>
                                                    <a href="${paginationUrl}page=1" class="page-numbers">1</a>
                                                </li>
                                                <c:if test="${startPage > 2}">
                                                    <li><span class="page-numbers">...</span></li>
                                                </c:if>
                                            </c:if>
                                            
                                            <!-- Page numbers -->
                                            <c:forEach begin="${startPage}" end="${endPage}" var="i">
                                                <c:choose>
                                                    <c:when test="${i == currentPage}">
                                                        <li>
                                                            <span class="page-numbers current">${i}</span>
                                                        </li>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <li>
                                                            <a href="${paginationUrl}page=${i}" class="page-numbers">${i}</a>
                                                        </li>
                                                    </c:otherwise>
                                                </c:choose>
                                            </c:forEach>
                                            
                                            <!-- Last page and ellipsis -->
                                            <c:if test="${endPage < totalPages}">
                                                <c:if test="${endPage < totalPages - 1}">
                                                    <li><span class="page-numbers">...</span></li>
                                                </c:if>
                                                <li>
                                                    <a href="${paginationUrl}page=${totalPages}" class="page-numbers">${totalPages}</a>
                                                </li>
                                            </c:if>
                                            
                                            <!-- Next Button -->
                                            <c:choose>
                                                <c:when test="${currentPage < totalPages}">
                                                    <li>
                                                        <a href="${paginationUrl}page=${currentPage + 1}" class="next page-numbers">
                                                            <i class="zmdi zmdi-long-arrow-right"></i>
                                                        </a>
                                                    </li>
                                                </c:when>
                                                <c:otherwise>
                                                    <li class="disabled">
                                                        <span class="page-numbers">
                                                            <i class="zmdi zmdi-long-arrow-right"></i>
                                                        </span>
                                                    </li>
                                                </c:otherwise>
                                            </c:choose>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                            <!--main-shop-product end-->
                        </div>
                    </div>
                </div>
            </div>
            <!--shop main area are end-->

            <!-- footer area start-->

            <!--footer area start-->

            <!--footer bottom area start-->
            <jsp:include page="../common/home/footer-homepage.jsp"></jsp:include>
                <!--footer bottom area end-->



                <!-- QUICKVIEW PRODUCT -->

                <!-- END QUICKVIEW PRODUCT -->

            </div> 
            <!-- Body main wrapper end -->

            <!-- Placed js at the end of the document so the pages load faster -->

            <!-- jquery latest version -->
        <jsp:include page="../common/home/js-home.jsp"></jsp:include>

    </body>


    <!-- Mirrored from htmldemo.net/clothing/clothing/shop.html by HTTrack Website Copier/3.x [XR&CO'2014], Sat, 01 Feb 2025 03:37:47 GMT -->
</html>

