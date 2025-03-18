<%-- 
    Document   : productdetails
    Created on : Feb 11, 2025, 12:53:14 PM
    Author     : hung
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.util.List" %>
<%@page import="com.shop.swp391.entity.Product"%>
<%@page import="com.shop.swp391.entity.Color"%>
<%@page import="com.shop.swp391.entity.ProductImg"%>
<%@page import="com.shop.swp391.entity.Size"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    Product product = (Product) request.getAttribute("product");
    List<Color> colors = (List<Color>) request.getAttribute("colors");
    List<Size> sizes = (List<Size>) request.getAttribute("sizes");
    String thumbnail = (String) request.getAttribute("thumbnail");
%>
<!DOCTYPE html>
<html class="no-js" lang="en">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="x-ua-compatible" content="ie=edge">
        <title>Single Prodcuts || Clothing</title>
        <meta name="description" content="Clothing – eCommerce Fashion Template is a clean and elegant design – suitable for selling clothing, fashion, high fashion, men fashion, women fashion, accessories, digital, kids, watches, jewelries, shoes, kids, furniture, sports, tools….. It has a fully responsive width adjusts automatically to any screen size or resolution.">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <link rel="shortcut icon" type="image/x-icon" href="images/icons/favicon.png">
        <jsp:include page="../common/home/css-home.jsp"></jsp:include>
        </head>

        <body>
            <!--[if lt IE 8]>
                <p class="browserupgrade">You are using an <strong>outdated</strong> browser. Please <a href="http://browsehappy.com/">upgrade your browser</a> to improve your experience.</p>
            <![endif]-->  

            <!-- Body main wrapper start -->
            <div class="wrapper sigle-product">

                <!-- Start of header area -->
            <jsp:include page="../common/home/header-homepage.jsp"></jsp:include>
                <!-- End of header area -->

                <!--breadcumb area start -->
                <div class="breadcumb-area overlay pos-rltv">

                </div>
                <!--breadcumb area end -->

                <!--single-protfolio-area are start-->
                <div class="single-protfolio-area ptb-70">
                    <div class="container">
                        <div class="row">
                            <div class="col-lg-7">
                                <div class="portfolio-thumbnil-area">
                                    <div class="product-more-views">
                                        <div class="tab_thumbnail" data-tabs="tabs">
                                            <div class="thumbnail-carousel">
                                                <ul class="nav">
                                                    <li>
                                                        <a class="active" href="#view11" class="shadow-box" aria-controls="view11" data-bs-toggle="tab"><img src="${productThumbnail}" alt="Product Image" /></a></li>
                                                    <li>
                                                        <a href="#view22" class="shadow-box" aria-controls="view22" data-bs-toggle="tab"><img src="images/product/02.jpg" alt="" /></a></li>
                                                    <li>
                                                        <a href="#view33" class="shadow-box" aria-controls="view33" data-bs-toggle="tab"><img src="images/product/03.jpg" alt="" /></a></li>
                                                    <li>
                                                        <a href="#view44" class="shadow-box" aria-controls="view44" data-bs-toggle="tab"><img src="images/product/04.jpg" alt="" /></a></li>
                                                </ul>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="tab-content active-portfolio-area pos-rltv">                                       
                                        <div role="tabpanel" class="tab-pane active" id="view11">
                                            <div class="product-img">
                                                <a class="fancybox" data-fancybox-group="group" href="images/product/01.jpg"><img src="${productThumbnail}" alt="Product Image" /></a>
                                            </div>
                                        </div>
                                        <div role="tabpanel" class="tab-pane" id="view22">
                                            <div class="product-img">
                                                <a class="fancybox" data-fancybox-group="group" href="images/product/02.jpg"><img src="images/product/02.jpg" alt="Single portfolio" /></a>
                                            </div>
                                        </div>
                                        <div role="tabpanel" class="tab-pane" id="view33">
                                            <div class="product-img">
                                                <a class="fancybox" data-fancybox-group="group" href="images/product/03.jpg"><img src="images/product/03.jpg" alt="Single portfolio" /></a>
                                            </div>
                                        </div>
                                        <div role="tabpanel" class="tab-pane" id="view44">
                                            <div class="product-img">
                                                <a class="fancybox" data-fancybox-group="group" href="images/product/04.jpg"><img src="images/product/04.jpg" alt="Single portfolio" /></a>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-5">
                                <div class="single-product-description">
                                    <div class="sp-top-des">
                                        <h3>${product.productName} </h3>
                                    <div class="prodcut-ratting-price">
                                        <div class="prodcut-ratting"> 
                                            <a href="#"><i class="fa fa-star-o"></i></a> 
                                            <a href="#"><i class="fa fa-star-o"></i></a> 
                                            <a href="#"><i class="fa fa-star-o"></i></a> 
                                            <a href="#"><i class="fa fa-star-o"></i></a> 
                                            <a href="#"><i class="fa fa-star-o"></i></a> 
                                        </div>
                                        <div class="prodcut-price">
                                            <div class="new-price"> $${product.price} </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="sp-des">
                                    <p>${product.description}</p>
                                </div>

                                <div class="sp-bottom-des">
                                    <div class="single-product-option">
                                        <div class="sort product-type">
                                            <label>Color: </label>
                                            <select id="input-sort-color">
                                                <c:forEach var="color" items="${colors}">
                                                    <option value="${color.colorID}">${color.colorName}</option>
                                                </c:forEach>
                                            </select>
                                        </div>

                                        <div class="sort product-type">
                                            <label>Size: </label>
                                            <select id="input-sort-size">
                                                <c:forEach var="size" items="${sizes}">
                                                    <option value="${size.sizeID}">${size.sizeName}</option>
                                                </c:forEach>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="quantity-area">
                                        <label>Qty :</label>
                                        <div class="cart-quantity">
                                                <div class="product-qty">
                                                    <div class="cart-quantity">
                                                        <div class="cart-plus-minus">
                                                            <div class="dec qtybutton">-</div>
                                                            <input type="text" value="01" name="qtybutton" class="cart-plus-minus-box">
                                                            <div class="inc qtybutton">+</div>
                                                        </div>
                                                    </div>
                                                </div>                                        
                                        </div>
                                    </div>
                                    <div class="social-icon socile-icon-style-1">
                                        <ul>
                                            <li><a href="#" data-tooltip="Add To Cart" class="add-cart add-cart-text" data-placement="left" tabindex="0">Add To Cart<i class="fa fa-cart-plus"></i></a></li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>  
                </div>
            </div>
            <!--single-protfolio-area are start-->

            <!--descripton-area start -->
            <div class="descripton-area">
                <div class="container">
                    <div class="row">
                        <div class="col-lg-12">
                            <div class="product-area tab-cars-style">
                                <div class="title-tab-product-category row">
                                    <div class="col-lg-12 text-center">
                                        <ul class="nav mb-40 heading-style-2" role="tablist">
                                            <li role="presentation"><a href="#newarrival" aria-controls="newarrival" role="tab" data-bs-toggle="tab">Description</a></li>
                                            <li role="presentation"><a class="active" href="#bestsellr" aria-controls="bestsellr" role="tab" data-bs-toggle="tab">Review</a></li>
                                            <li role="presentation"><a href="#specialoffer" aria-controls="specialoffer" role="tab" data-bs-toggle="tab">Tags</a></li>
                                        </ul>
                                    </div>
                                </div>
                                <div class="clearfix"></div>
                                <div class="col-lg-12">
                                    <div class="content-tab-product-category">
                                        <!-- Tab panes -->
                                        <div class="tab-content">
                                            <div role="tabpanel" class="tab-pane fix fade in" id="newarrival">
                                                <div class="review-wraper">
                                                    <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim
                                                        <br> veniam, quis nostrud exercitation.</p>
                                                    <h5>ABOUT ME</h5>
                                                    <p>It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English.It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English</p>
                                                    <h5>SIZE & FIT</h5>
                                                    <ul>
                                                        <li>Model wears: Style Photoliya U2980</li>
                                                        <li>Model's height: 185”66</li>
                                                    </ul>
                                                    <h5>Overview</h5>
                                                    <p>There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don't look even slightly believable.There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form.</p>
                                                </div>
                                            </div>
                                            <div role="tabpanel" class="tab-pane fix fade show active" id="bestsellr">
                                                <div class="review-wraper">
                                                    <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim <br> veniam, quis nostrud exercitation.</p>
                                                    <h5>SIZE & FIT</h5>
                                                    <ul>
                                                        <li>Model wears: Style Photoliya U2980</li>
                                                        <li>Model's height: 185”66</li>
                                                    </ul>
                                                    <h5>ABOUT ME</h5>
                                                    <p>It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English.It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English</p>
                                                    <h5>Overview</h5>
                                                    <p>There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don't look even slightly believable.There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form.</p>
                                                </div>
                                            </div>
                                            <div role="tabpanel" class="tab-pane fix fade in" id="specialoffer">
                                                <ul class="tag-filter">
                                                    <li><a href="#">Fashion</a></li>
                                                    <li><a href="#">Women</a></li>
                                                    <li><a href="#">Winter</a></li>
                                                    <li><a href="#">Street Style</a></li>
                                                    <li><a href="#">Style</a></li>
                                                    <li><a href="#">Shop</a></li>
                                                    <li><a href="#">Collection</a></li>
                                                    <li><a href="#">Spring 2022</a></li>
                                                    <li><a href="#">Street Style</a></li>
                                                    <li><a href="#">Style</a></li>
                                                    <li><a href="#">Shop</a></li>
                                                </ul>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>    
            <!--descripton-area end--> 

            <!--new arrival area start-->
            <div class="new-arrival-area ptb-70">
                <div class="container">
                    <div class="row">
                        <div class="col-lg-12 text-center">
                            <div class="heading-title heading-style pos-rltv mb-50 text-center">
                                <h5 class="uppercase">Related Product</h5>
                            </div>
                            <div class="total-new-arrival new-arrival-slider-active carsoule-btn">
                                <div class="product-item">
                                    <!-- single product start-->
                                    <div class="single-product">
                                        <div class="product-img">
                                            <div class="product-label">
                                                <div class="new">New</div>
                                            </div>
                                            <div class="single-prodcut-img  product-overlay pos-rltv">
                                                <a href="single-product.html"> <img alt="" src="images/product/01.jpg"
                                                                                    class="primary-image"> <img alt="" src="images/product/02.jpg"
                                                                                    class="secondary-image"> </a>
                                            </div>
                                            <div class="product-icon socile-icon-tooltip text-center">
                                                <ul>
                                                    <li><a href="#" data-tooltip="Add To Cart" class="add-cart"
                                                           data-placement="left"><i class="fa fa-cart-plus"></i></a></li>
                                                    <li><a href="#" data-tooltip="Wishlist" class="w-list"><i
                                                                class="fa fa-heart-o"></i></a></li>
                                                    <li><a href="#" data-tooltip="Compare" class="cpare"><i
                                                                class="fa fa-refresh"></i></a></li>
                                                    <li><a href="#" data-tooltip="Quick View" class="q-view" data-bs-toggle="modal"
                                                           data-bs-target=".modal"><i class="fa fa-eye"></i></a></li>
                                                </ul>
                                            </div>
                                        </div>
                                        <div class="product-text">
                                            <div class="prodcut-name"> <a href="single-product.html">Quisque fringilla</a>
                                            </div>
                                            <div class="prodcut-ratting-price">
                                                <div class="prodcut-price">
                                                    <div class="new-price"> $220 </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <!-- single product end-->
                                </div>
                                <div class="product-item">
                                    <!-- single product start-->
                                    <div class="single-product">
                                        <div class="product-img">
                                            <div class="single-prodcut-img  product-overlay pos-rltv">
                                                <a href="single-product.html"> <img alt="" src="images/product/03.jpg"
                                                                                    class="primary-image"> <img alt="" src="images/product/04.jpg"
                                                                                    class="secondary-image"> </a>
                                            </div>
                                            <div class="product-icon socile-icon-tooltip text-center">
                                                <ul>
                                                    <li><a href="#" data-tooltip="Add To Cart" class="add-cart"
                                                           data-placement="left"><i class="fa fa-cart-plus"></i></a></li>
                                                    <li><a href="#" data-tooltip="Wishlist" class="w-list"><i
                                                                class="fa fa-heart-o"></i></a></li>
                                                    <li><a href="#" data-tooltip="Compare" class="cpare"><i
                                                                class="fa fa-refresh"></i></a></li>
                                                    <li><a href="#" data-tooltip="Quick View" class="q-view" data-bs-toggle="modal"
                                                           data-bs-target=".modal"><i class="fa fa-eye"></i></a></li>
                                                </ul>
                                            </div>
                                        </div>
                                        <div class="product-text">
                                            <div class="prodcut-name"> <a href="single-product.html">Quisque fringilla</a>
                                            </div>
                                            <div class="prodcut-ratting-price">
                                                <div class="prodcut-price">
                                                    <div class="new-price"> $220 </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <!-- single product end-->
                                </div>
                                <div class="product-item">
                                    <!-- single product start-->
                                    <div class="single-product">
                                        <div class="product-img">
                                            <div class="product-label">
                                                <div class="new">Sale</div>
                                            </div>
                                            <div class="single-prodcut-img  product-overlay pos-rltv">
                                                <a href="single-product.html"> <img alt="" src="images/product/02.jpg"
                                                                                    class="primary-image"> <img alt="" src="images/product/03.jpg"
                                                                                    class="secondary-image"> </a>
                                            </div>
                                            <div class="product-icon socile-icon-tooltip text-center">
                                                <ul>
                                                    <li><a href="#" data-tooltip="Add To Cart" class="add-cart"
                                                           data-placement="left"><i class="fa fa-cart-plus"></i></a></li>
                                                    <li><a href="#" data-tooltip="Wishlist" class="w-list"><i
                                                                class="fa fa-heart-o"></i></a></li>
                                                    <li><a href="#" data-tooltip="Compare" class="cpare"><i
                                                                class="fa fa-refresh"></i></a></li>
                                                    <li><a href="#" data-tooltip="Quick View" class="q-view" data-bs-toggle="modal"
                                                           data-bs-target=".modal"><i class="fa fa-eye"></i></a></li>
                                                </ul>
                                            </div>
                                        </div>
                                        <div class="product-text">
                                            <div class="prodcut-name"> <a href="single-product.html">Quisque fringilla</a>
                                            </div>
                                            <div class="prodcut-ratting-price">
                                                <div class="prodcut-ratting">
                                                    <a href="#"><i class="fa fa-star"></i></a>
                                                    <a href="#"><i class="fa fa-star"></i></a>
                                                    <a href="#"><i class="fa fa-star"></i></a>
                                                    <a href="#"><i class="fa fa-star"></i></a>
                                                    <a href="#"><i class="fa fa-star-o"></i></a>
                                                </div>
                                                <div class="prodcut-price">
                                                    <div class="new-price"> $220 </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <!-- single product end-->
                                </div>
                                <div class="product-item">
                                    <!-- single product start-->
                                    <div class="single-product">
                                        <div class="product-img">
                                            <div class="single-prodcut-img  product-overlay pos-rltv">
                                                <a href="single-product.html"> <img alt="" src="images/product/04.jpg"
                                                                                    class="primary-image"> <img alt="" src="images/product/03.jpg"
                                                                                    class="secondary-image"> </a>
                                            </div>
                                            <div class="product-icon socile-icon-tooltip text-center">
                                                <ul>
                                                    <li><a href="#" data-tooltip="Add To Cart" class="add-cart"
                                                           data-placement="left"><i class="fa fa-cart-plus"></i></a></li>
                                                    <li><a href="#" data-tooltip="Wishlist" class="w-list"><i
                                                                class="fa fa-heart-o"></i></a></li>
                                                    <li><a href="#" data-tooltip="Compare" class="cpare"><i
                                                                class="fa fa-refresh"></i></a></li>
                                                    <li><a href="#" data-tooltip="Quick View" class="q-view" data-bs-toggle="modal"
                                                           data-bs-target=".modal"><i class="fa fa-eye"></i></a></li>
                                                </ul>
                                            </div>
                                        </div>
                                        <div class="product-text">
                                            <div class="prodcut-name"> <a href="single-product.html">Quisque fringilla</a>
                                            </div>
                                            <div class="prodcut-ratting-price">
                                                <div class="prodcut-price">
                                                    <div class="new-price"> $220 </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <!-- single product end-->
                                </div>
                                <div class="product-item">
                                    <!-- single product start-->
                                    <div class="single-product">
                                        <div class="product-img">
                                            <div class="single-prodcut-img  product-overlay pos-rltv">
                                                <a href="single-product.html"> <img alt="" src="images/product/05.jpg"
                                                                                    class="primary-image"> <img alt="" src="images/product/06.jpg"
                                                                                    class="secondary-image"> </a>
                                            </div>
                                            <div class="product-icon socile-icon-tooltip text-center">
                                                <ul>
                                                    <li><a href="#" data-tooltip="Add To Cart" class="add-cart"
                                                           data-placement="left"><i class="fa fa-cart-plus"></i></a></li>
                                                    <li><a href="#" data-tooltip="Wishlist" class="w-list"><i
                                                                class="fa fa-heart-o"></i></a></li>
                                                    <li><a href="#" data-tooltip="Compare" class="cpare"><i
                                                                class="fa fa-refresh"></i></a></li>
                                                    <li><a href="#" data-tooltip="Quick View" class="q-view" data-bs-toggle="modal"
                                                           data-bs-target=".modal"><i class="fa fa-eye"></i></a></li>
                                                </ul>
                                            </div>
                                        </div>
                                        <div class="product-text">
                                            <div class="prodcut-name"> <a href="single-product.html">Quisque fringilla</a>
                                            </div>
                                            <div class="prodcut-ratting-price">
                                                <div class="prodcut-ratting">
                                                    <a href="#"><i class="fa fa-star"></i></a>
                                                    <a href="#"><i class="fa fa-star"></i></a>
                                                    <a href="#"><i class="fa fa-star"></i></a>
                                                    <a href="#"><i class="fa fa-star"></i></a>
                                                    <a href="#"><i class="fa fa-star-o"></i></a> </div>
                                                <div class="prodcut-price">
                                                    <div class="new-price"> $220 </div>
                                                    <div class="old-price"> <del>$250</del> </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <!-- single product end-->
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!--new arrival area end-->

            <!-- footer area start-->
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


    <!-- Mirrored from htmldemo.net/clothing/clothing/single-product.html by HTTrack Website Copier/3.x [XR&CO'2014], Sat, 01 Feb 2025 03:37:47 GMT -->
</html>