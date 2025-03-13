<%-- 
    Document   : productlist
    Created on : Feb 15, 2025, 11:08:16 AM
    Author     : hung
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!doctype html>
<html class="no-js" lang="en">
    <%@page import="java.util.List"%>
    <%@page import="java.util.ArrayList" %>
    <%@page import="java.util.Map"%>
    <%@page import="com.shop.swp391.entity.Product"%>
    <%@page import="com.shop.swp391.entity.Color"%>
    <%@page import="com.shop.swp391.entity.ProductImg"%>
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

        <!-- All css files are included here. -->
        <!-- Bootstrap fremwork main css -->
        <jsp:include page="../common/home/css-home.jsp"></jsp:include>



        </head>
    <% 
   List<Product> products = (List<Product>) request.getAttribute("products");
   Map<Integer, String> productImages = (Map<Integer, String>) request.getAttribute("productImages");
   int currentPage = (int) request.getAttribute("currentPage");
   int totalPages = (int) request.getAttribute("totalPages");
   int pagesToShow = 5;
   int halfPagesToShow = pagesToShow / 2;
   int startPage = Math.max(1, currentPage - halfPagesToShow);
   int endPage = Math.min(totalPages, startPage + pagesToShow - 1);
   if (endPage - startPage + 1 < pagesToShow) {
       startPage = Math.max(1, endPage - pagesToShow + 1);
   }
    %>
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

                </div>
                <!--breadcumb area end -->

                <!--shop main area are start-->
                <div class="shop-main-area grid-view_area ptb-70">
                    <div class="container">
                        <div class="row">
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
                                                            <option value="products?page=${currentPage}&sortBy=default" ${sortBy == 'default' ? 'selected' : ''}>Default</option>
                                                        <option value="products?page=${currentPage}&sortBy=name_asc" ${sortBy == 'name_asc' ? 'selected' : ''}>Name (A - Z)</option>
                                                        <option value="products?page=${currentPage}&sortBy=name_desc" ${sortBy == 'name_desc' ? 'selected' : ''}>Name (Z - A)</option>
                                                        <option value="products?page=${currentPage}&sortBy=price_asc" ${sortBy == 'price_asc' ? 'selected' : ''}>Price (Low > High)</option>
                                                        <option value="products?page=${currentPage}&sortBy=price_desc" ${sortBy == 'price_desc' ? 'selected' : ''}>Price (High > Low)</option>
                                                    </select>
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
                                                    <% if (products != null && !products.isEmpty()) { %>
                                                    <% for (Product product : products) { %>
                                                    <div class="col-lg-4 col-md-6 item">
                                                        <div class="single-product">
                                                            <div class="product-img">
                                                                <div class="product-label red">
                                                                    <div class="new">New</div>
                                                                </div>
                                                                <div class="single-prodcut-img product-overlay pos-rltv">
                                                                    <a href="product-detail?productID=<%= product.getProductID() %>">
                                                                        <img alt="" src="<%= productImages.get(product.getProductID()) %>" class="primary-image" style="width: 200px; height: 200px; object-fit: cover;">
                                                                    </a>
                                                                </div>
                                                            </div>
                                                            <div class="product-text">
                                                                <div class="prodcut-name">
                                                                    <a href="product-detail?productID=<%= product.getProductID() %>">
                                                                        <%= product.getProductName() %>
                                                                    </a>
                                                                </div>
                                                                <div class="prodcut-ratting-price">
                                                                    <div class="prodcut-price">
                                                                        <div class="new-price"> $<%= product.getPrice() %> </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <% } %>
                                                    <% } else { %>
                                                    <p>No products available.</p>
                                                    <% } %>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="pagination-btn text-center mt-4">
                                        <ul class="page-numbers">
                                            <!-- Previous Button -->
                                            <% if (currentPage > 1) { %>
                                            <li>
                                                <a href="products?page=<%= currentPage - 1 %>" class="next page-numbers">
                                                    <i class="zmdi zmdi-long-arrow-left"></i>
                                                </a>
                                            </li>
                                            <% } else { %>
                                            <li class="disabled">
                                                <span class="page-numbers">
                                                    <i class="zmdi zmdi-long-arrow-left"></i>
                                                </span>
                                            </li>
                                            <% } %>
                                            <% if (startPage > 1) { %>
                                            <li>
                                                <a href="products?page=1" class="page-numbers">1</a>
                                            </li>
                                            <% if (startPage > 2) { %>
                                            <li><span class="page-numbers">...</span></li>
                                                <% } %>
                                                <% } %>
                                                <% for (int i = startPage; i <= endPage; i++) { %>
                                                <% if (i == currentPage) { %>
                                            <li>
                                                <span class="page-numbers current"><%= i %></span>
                                            </li>
                                            <% } else { %>
                                            <li>
                                                <a href="products?page=<%= i %>" class="page-numbers"><%= i %></a>
                                            </li>
                                            <% } %>
                                            <% } %>
                                            <% if (endPage < totalPages) { %>
                                            <% if (endPage < totalPages - 1) { %>
                                            <li><span class="page-numbers">...</span></li>
                                                <% } %>
                                            <li>
                                                <a href="products?page=<%= totalPages %>" class="page-numbers"><%= totalPages %></a>
                                            </li>
                                            <% } %>
                                            <% if (currentPage < totalPages) { %>
                                            <li>
                                                <a href="products?page=<%= currentPage + 1 %>" class="next page-numbers">
                                                    <i class="zmdi zmdi-long-arrow-right"></i>
                                                </a>
                                            </li>
                                            <% } else { %>
                                            <li class="disabled">
                                                <span class="page-numbers">
                                                    <i class="zmdi zmdi-long-arrow-right"></i>
                                                </span>
                                            </li>
                                            <% } %>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!--main-shop-product start-->

                        <!--shop sidebar start-->
                        <div class="col-lg-3 col-md-4 order-lg-1 order-md-1 order-2">
                            <div class="shop-sidebar">
                                <!--single aside start-->

                                <!--single aside end-->

                                <!--single aside start-->

                                <!--single aside end-->

                                <!--single aside start-->
                                <aside class="single-aside price-aside fix">
                                    <div class="heading-title aside-title pos-rltv">
                                        <h5 class="uppercase">Price</h5>
                                    </div>
                                    <div class="price_filter">
                                        <div id="slider-range"></div>
                                        <div class="price_slider_amount">
                                            <form id="priceFilterForm" action="products" method="GET">
                                                <input type="hidden" id="minPrice" name="minPrice" />
                                                <input type="hidden" id="maxPrice" name="maxPrice" />
                                                <input type="text" id="amount" name="price" placeholder="Add Your Price" readonly />
                                                <input type="submit" value="Filter" />
                                            </form>
                                        </div>
                                    </div>
                                </aside>
                                <script>
                                    $(function () {
                                        $("#slider-range").slider({
                                            range: true,
                                            min: 0,
                                            max: 1000000, 
                                            values: [0, 1000000], 
                                            step: 1000, 
                                            slide: function (event, ui) {
                                                $("#amount").val("$" + ui.values[0].toLocaleString() + " - $" + ui.values[1].toLocaleString());
                                                $("#minPrice").val(ui.values[0]);
                                                $("#maxPrice").val(ui.values[1]);
                                            }
                                        });

                                        $("#amount").val("$" + $("#slider-range").slider("values", 0).toLocaleString() +
                                                " - $" + $("#slider-range").slider("values", 1).toLocaleString());
                                        $("#minPrice").val($("#slider-range").slider("values", 0));
                                        $("#maxPrice").val($("#slider-range").slider("values", 1));

                                        $("#priceFilterForm").submit(function () {
                                            $("#minPrice").val($("#slider-range").slider("values", 0));
                                            $("#maxPrice").val($("#slider-range").slider("values", 1));
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
                                        <li><a href="products?color=1" style="background-color: white; border: 2px solid #ccc;"></a></li> <!-- White -->
                                        <li><a href="products?color=2" style="background-color: blue;"></a></li> <!-- Blue -->
                                        <li><a href="products?color=3" style="background-color: black;"></a></li> <!-- Black -->
                                        <li><a href="products?color=4" style="background-color: grey;"></a></li> <!-- Grey -->
                                        <li><a href="products?color=5" style="background-color: green;"></a></li> <!-- Green -->
                                        <li><a href="products?color=6" style="background-color: brown;"></a></li> <!-- Brown -->
                                        <li><a href="products?color=7" style="background-color: orange;"></a></li> <!-- Orange -->
                                        <li><a href="products?color=8" style="background-color: pink;"></a></li> <!-- Pink -->
                                        <li><a href="products?color=9" style="background-color: tan;"></a></li> <!-- Tan -->
                                        <li><a href="products?color=10" style="background-color: red;"></a></li> <!-- Red -->
                                    </ul>
                                    <br>
                                    <div class="clear-filter">
                                        <a href="products" class="clear-btn" 
                                           style="display: inline-block; padding: 8px 15px; background-color: #ff4d4d; color: white;
                                           text-decoration: none; border-radius: 5px; font-weight: bold; transition: 0.3s;"
                                           onmouseover="this.style.backgroundColor = '#d43f3f';" 
                                           onmouseout="this.style.backgroundColor = '#ff4d4d';">
                                            Clear 
                                        </a>
                                    </div>
                                </aside>
                                <!--single aside end-->

                                <!--single aside start-->
                                <!--single aside end-->

                                <!--single aside start-->
                                <aside class="single-aside add-aside">
                                    <a href="single-product.html"><img src="images/banner/add.jpg" alt=""></a>
                                </aside>
                                <!--single aside end-->
                            </div>
                        </div>
                        <!--shop sidebar end-->
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

