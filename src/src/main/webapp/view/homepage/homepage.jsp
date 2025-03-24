<%-- 
    Document   : homepage
    Created on : Feb 5, 2025, 9:09:31 PM
    Author     : ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
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

    <!-- All css files are included here. -->
    <!-- Bootstrap fremwork main css -->
    <jsp:include page="../common/home/css-home.jsp"></jsp:include>


   
</head>

<body>
    <!--[if lt IE 8]>
        <p class="browserupgrade">You are using an <strong>outdated</strong> browser. Please <a href="http://browsehappy.com/">upgrade your browser</a> to improve your experience.</p>
    <![endif]-->

    <!-- Body main wrapper start -->
    <div class="wrapper home-one">

        <!-- Start of header area -->
    <jsp:include page="../common/home/header-homepage.jsp"></jsp:include>
        <!-- End of header area -->

        <!--slider area start-->
        <div class="slider-area pos-rltv carosule-pagi cp-line">
            <div class="active-slider">
                <div class="single-slider pos-rltv">
                    <div class="slider-img"><img src="${pageContext.request.contextPath}/assets/home/images/slider/slider01.jpg" alt=""></div>
                    <div class="slider-content pos-abs">
                        <h4>Best Collection</h4>
                        <h1 class="uppercase pos-rltv underline">exclusive Fashion 2022</h1>
                        <a href="#" class="btn-def btn-white">Shop Now</a>
                    </div>
                </div>
                <div class="single-slider pos-rltv">
                    <div class="slider-img"><img src="${pageContext.request.contextPath}/assets/home/images/slider/slider02.jpg" alt=""></div>
                    <div class="slider-content pos-abs">
                        <h4>Best Collection</h4>
                        <h1 class="uppercase pos-rltv underline">exclusive Fashion 2022</h1>
                        <a href="#" class="btn-def btn-white">Shop Now</a>
                    </div>
                </div>
                <div class="single-slider pos-rltv">
                    <div class="slider-img"><img src="${pageContext.request.contextPath}/assets/home/images/slider/slider01.jpg" alt=""></div>
                    <div class="slider-content pos-abs">
                        <h4>Best Collection</h4>
                        <h1 class="uppercase pos-rltv underline">exclusive Fashion 2022</h1>
                        <a href="#" class="btn-def btn-white">Shop Now</a>
                    </div>
                </div>
            </div>
        </div>
        <!--slider area start-->

        <!--delivery service start-->
        <div class="delivery-service-area ptb-30">
            <div class="container">
                <div class="row">
                    <div class="col-lg-3 col-md-6">
                        <div class="single-service shadow-box text-center">
                            <img src="${pageContext.request.contextPath}/assets/home/images/icons/garantee.png" alt="">
                            <h5>Money Back Guarantee</h5>
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-6">
                        <div class="single-service shadow-box text-center">
                            <img src="${pageContext.request.contextPath}/assets/home/images/icons/coupon.png" alt="">
                            <h5>Gift Coupon</h5>
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-6">
                        <div class="single-service shadow-box text-center">
                            <img src="${pageContext.request.contextPath}/assets/home/images/icons/delivery.png" alt="">
                            <h5>Free Shipping</h5>
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-6">
                        <div class="single-service shadow-box text-center">
                            <img src="${pageContext.request.contextPath}/assets/home/images/icons/support.png" alt="">
                            <h5>24x7 Support</h5>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!--delivery service start-->

        <!--branding-section-area start-->
        <div class="branding-section-area">
            <div class="container">
                <div class="row">
                    <div class="col-lg-12">
                        <div class="active-slider pos-rltv carosule-pagi cp-line pagi-02">
                            <div class="single-slider">
                                <div class="row">
                                    <div class="col-xl-7 col-lg-6 col-md-6">
                                        <div class="brand-img text-center">
                                            <img src="${pageContext.request.contextPath}/assets/home/images/team/branding.png" alt="">
                                        </div>
                                    </div>
                                    <div class="col-xl-5 col-lg-6 col-md-6">
                                        <div class="brand-content ptb-55">
                                            <div class="brand-text color-lightgrey">
                                                <h6>New Fashion</h6>
                                                <h2 class="uppercase montserrat">Brand Cortta</h2>
                                                <h3 class="montserrat">$200.00</h3>
                                                <p>It is a long established fact that a reader will be distracted by the
                                                    readable content of a page when looking at its layout.</p>
                                                <div class="social-icon-wraper mt-35">
                                                    <div class="social-icon">
                                                        <ul>
                                                            <li><a href="#"><i class="zmdi zmdi-shopping-cart"></i></a>
                                                            </li>
                                                            <li><a href="#"><i
                                                                        class="zmdi zmdi-favorite-outline"></i></a></li>
                                                            <li><a href="#" data-tooltip="Quick View" class="q-view"
                                                                    data-bs-toggle="modal" data-bs-target=".modal"
                                                                    tabindex="0"><i class="zmdi zmdi-eye"></i></a></li>
                                                            <li><a href="#"><i class="zmdi zmdi-repeat"></i></a></li>

                                                        </ul>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="brand-timer shadow-box-2 mt-50">
                                                <div class="timer-wraper text-center">
                                                    <div class="timer">
                                                        <div data-countdown="2023/02/01"></div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="single-slider">
                                <div class="row">
                                    <div class="col-xl-7 col-lg-6 col-md-6">
                                        <div class="brand-img text-center">
                                            <img src="${pageContext.request.contextPath}/assets/home/images/team/branding.png" alt="">
                                        </div>
                                    </div>
                                    <div class="col-xl-5 col-lg-6 col-md-6">
                                        <div class="brand-content ptb-55">
                                            <div class="brand-text color-lightgrey">
                                                <h6>New Fashion</h6>
                                                <h2 class="uppercase montserrat">Brand Cortta</h2>
                                                <h3 class="montserrat">$200.00</h3>
                                                <p>It is a long established fact that a reader will be distracted by the
                                                    readable content of a page when looking at its layout.</p>
                                                <div class="social-icon-wraper mt-35">
                                                    <div class="social-icon">
                                                        <ul>
                                                            <li><a href="#"><i class="zmdi zmdi-shopping-cart"></i></a>
                                                            </li>
                                                            <li><a href="#"><i
                                                                        class="zmdi zmdi-favorite-outline"></i></a></li>
                                                            <li><a href="#" data-tooltip="Quick View" class="q-view"
                                                                    data-bs-toggle="modal" data-bs-target=".modal"
                                                                    tabindex="0"><i class="zmdi zmdi-eye"></i></a></li>
                                                            <li><a href="#"><i class="zmdi zmdi-repeat"></i></a></li>

                                                        </ul>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="brand-timer shadow-box-2 mt-50">
                                                <div class="timer-wraper text-center">
                                                    <div class="timer">
                                                        <div data-countdown="2017/02/01"></div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="single-slider">
                                <div class="row">
                                    <div class="col-xl-7 col-lg-6 col-md-6">
                                        <div class="brand-img text-center">
                                            <img src="${pageContext.request.contextPath}/assets/home/images/team/branding.png" alt="">
                                        </div>
                                    </div>
                                    <div class="col-xl-5 col-lg-6 col-md-6">
                                        <div class="brand-content ptb-55">
                                            <div class="brand-text color-lightgrey">
                                                <h6>New Fashion</h6>
                                                <h2 class="uppercase montserrat">Brand Cortta</h2>
                                                <h3 class="montserrat">$200.00</h3>
                                                <p>It is a long established fact that a reader will be distracted by the
                                                    readable content of a page when looking at its layout.</p>
                                                <div class="social-icon-wraper mt-35">
                                                    <div class="social-icon">
                                                        <ul>
                                                            <li><a href="#"><i class="zmdi zmdi-shopping-cart"></i></a>
                                                            </li>
                                                            <li><a href="#"><i
                                                                        class="zmdi zmdi-favorite-outline"></i></a></li>
                                                            <li><a href="#" data-tooltip="Quick View" class="q-view"
                                                                    data-bs-toggle="modal" data-bs-target=".modal"
                                                                    tabindex="0"><i class="zmdi zmdi-eye"></i></a></li>
                                                            <li><a href="#"><i class="zmdi zmdi-repeat"></i></a></li>

                                                        </ul>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="brand-timer shadow-box-2 mt-50">
                                                <div class="timer-wraper text-center">
                                                    <div class="timer">
                                                        <div data-countdown="2023/02/01"></div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!--branding-section-area end-->

        <!--new arrival area start-->
        <div class="new-arrival-area pt-70">
            <div class="container">
                <div class="row">
                    <div class="col-lg-12 text-center">
                        <div class="heading-title heading-style pos-rltv mb-50 text-center">
                            <h5 class="uppercase">New Arrival</h5>
                        </div>
                        <div class="total-new-arrival new-arrival-slider-active carsoule-btn row">
                            <div class="product-item">
                                <!-- single product start-->
                                <div class="single-product">
                                    <div class="product-img">
                                        <div class="product-label">
                                            <div class="new">New</div>
                                        </div>
                                        <div class="single-prodcut-img  product-overlay pos-rltv">
                                            <a href="single-product.html"> <img alt="" src="${pageContext.request.contextPath}/assets/home/images/product/01.jpg"
                                                    class="primary-image"> <img alt="" src="${pageContext.request.contextPath}/assets/home/images/product/02.jpg"
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
                                                <li><a href="#" data-tooltip="Quick View" class="q-view"
                                                        data-bs-toggle="modal" data-bs-target=".modal"><i
                                                            class="fa fa-eye"></i></a></li>
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
                                            <a href="single-product.html"> <img alt="" src="${pageContext.request.contextPath}/assets/home/images/product/03.jpg"
                                                    class="primary-image"> <img alt="" src="${pageContext.request.contextPath}/assets/home/images/product/04.jpg"
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
                                                <li><a href="#" data-tooltip="Quick View" class="q-view"
                                                        data-bs-toggle="modal" data-bs-target=".modal"><i
                                                            class="fa fa-eye"></i></a></li>
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
                                            <a href="single-product.html"> <img alt="" src="${pageContext.request.contextPath}/assets/home/images/product/02.jpg"
                                                    class="primary-image"> <img alt="" src="${pageContext.request.contextPath}/assets/home/images/product/03.jpg"
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
                                                <li><a href="#" data-tooltip="Quick View" class="q-view"
                                                        data-bs-toggle="modal" data-bs-target=".modal"><i
                                                            class="fa fa-eye"></i></a></li>
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
                                            <a href="single-product.html"> <img alt="" src="${pageContext.request.contextPath}/assets/home/images/product/04.jpg"
                                                    class="primary-image"> <img alt="" src="${pageContext.request.contextPath}/assets/home/images/product/03.jpg"
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
                                                <li><a href="#" data-tooltip="Quick View" class="q-view"
                                                        data-bs-toggle="modal" data-bs-target=".modal"><i
                                                            class="fa fa-eye"></i></a></li>
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
                                            <a href="single-product.html"> <img alt="" src="${pageContext.request.contextPath}/assets/home/images/product/05.jpg"
                                                    class="primary-image"> <img alt="" src="${pageContext.request.contextPath}/assets/home/images/product/06.jpg"
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
                                                <li><a href="#" data-tooltip="Quick View" class="q-view"
                                                        data-bs-toggle="modal" data-bs-target=".modal"><i
                                                            class="fa fa-eye"></i></a></li>
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

        <!--banner area start-->
        <div class="banner-area pt-70">
            <div class="container">
                <div class="row">
                    <div class="col-lg-6">
                        <div class="single-banner gray-bg">
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="sb-img text-center">
                                        <img src="${pageContext.request.contextPath}/assets/home/images/banner/02.png" alt="">
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="sb-content mt-60">
                                        <div class="banner-text">
                                            <h5 class="lato">New Arrival</h5>
                                            <h2 class="montserrat">Grag T- Shirt</h2>
                                            <h3 class="montserrat">$99.99</h3>
                                            <div class="banner-list">
                                                <ul>
                                                    <li>Best quality</li>
                                                    <li>Best quality</li>
                                                    <li>Best quality</li>
                                                </ul>
                                            </div>
                                            <div class="social-icon-wraper mt-25">
                                                <div class="social-icon socile-icon-style-1">
                                                    <ul>
                                                        <li><a href="#"><i class="zmdi zmdi-shopping-cart"></i></a></li>
                                                        <li><a href="#"><i class="zmdi zmdi-favorite-outline"></i></a>
                                                        </li>
                                                        <li><a href="#" data-tooltip="Quick View" class="q-view"
                                                                data-bs-toggle="modal" data-bs-target=".modal"
                                                                tabindex="0"><i class="zmdi zmdi-eye"></i></a></li>
                                                        <li><a href="#"><i class="zmdi zmdi-repeat"></i></a></li>
                                                    </ul>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-6">
                        <div class="single-banner gray-bg">
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="sb-img text-center">
                                        <img src="${pageContext.request.contextPath}/assets/home/images/banner/01.png" alt="">
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="sb-content mt-60">
                                        <div class="banner-text">
                                            <h5 class="lato">New Arrival</h5>
                                            <h2 class="montserrat">Grag T- Shirt</h2>
                                            <h3 class="montserrat">$99.99</h3>
                                            <p>It is a long established fact that a reader will be distracted by the
                                                readable content.</p>
                                            <a class="btn-def btn2" href="#">Shop Now</a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!--banner area end-->

        <!--discunt-featured-onsale-area start -->
        <div class="discunt-featured-onsale-area pt-60">
            <div class="container">
                <div class="row">
                    <div class="col-lg-12">
                        <div class="product-area tab-cars-style">
                            <div class="title-tab-product-category">
                                <div class="col-lg-12 text-center">
                                    <ul class="nav mb-40 heading-style-2" role="tablist">
                                        <li role="presentation"><a class="active" href="#newarrival"
                                                aria-controls="newarrival" role="tab" data-bs-toggle="tab">New
                                                Arrival</a>
                                        </li>
                                        <li role="presentation"><a href="#bestsellr" aria-controls="bestsellr"
                                                role="tab" data-bs-toggle="tab">Best Seller</a></li>
                                        <li role="presentation"><a href="#specialoffer" aria-controls="specialoffer"
                                                role="tab" data-bs-toggle="tab">Special Offer</a></li>
                                    </ul>
                                </div>
                            </div>
                            <div class="content-tab-product-category">
                                <!-- Tab panes -->
                                <div class="tab-content">
                                    <div role="tabpanel" class="tab-pane fade in active" id="newarrival">
                                        <div class="total-new-arrival new-arrival-slider-active carsoule-btn">
                                            <div class="product-item">
                                                <!-- single product start-->
                                                <div class="single-product">
                                                    <div class="product-img">
                                                        <div class="product-label">
                                                            <div class="new">New</div>
                                                        </div>
                                                        <div class="single-prodcut-img  product-overlay pos-rltv">
                                                            <a href="single-product.html"> <img alt=""
                                                                    src="${pageContext.request.contextPath}/assets/home/images/product/01.jpg" class="primary-image">
                                                                <img alt="" src="${pageContext.request.contextPath}/assets/home/images/product/02.jpg"
                                                                    class="secondary-image"> </a>
                                                        </div>
                                                        <div class="product-icon socile-icon-tooltip text-center">
                                                            <ul>
                                                                <li><a href="#" data-tooltip="Add To Cart"
                                                                        class="add-cart" data-placement="left"><i
                                                                            class="fa fa-cart-plus"></i></a></li>
                                                                <li><a href="#" data-tooltip="Wishlist"
                                                                        class="w-list"><i class="fa fa-heart-o"></i></a>
                                                                </li>
                                                                <li><a href="#" data-tooltip="Compare" class="cpare"><i
                                                                            class="fa fa-refresh"></i></a></li>
                                                                <li><a href="#" data-tooltip="Quick View" class="q-view"
                                                                        data-bs-toggle="modal"
                                                                        data-bs-target=".modal"><i
                                                                            class="fa fa-eye"></i></a></li>
                                                            </ul>
                                                        </div>
                                                    </div>
                                                    <div class="product-text">
                                                        <div class="prodcut-name"> <a href="single-product.html">Quisque
                                                                fringilla</a> </div>
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
                                                            <a href="single-product.html"> <img alt=""
                                                                    src="${pageContext.request.contextPath}/assets/home/images/product/03.jpg" class="primary-image">
                                                                <img alt="" src="${pageContext.request.contextPath}/assets/home/images/product/04.jpg"
                                                                    class="secondary-image"> </a>
                                                        </div>
                                                        <div class="product-icon socile-icon-tooltip text-center">
                                                            <ul>
                                                                <li><a href="#" data-tooltip="Add To Cart"
                                                                        class="add-cart" data-placement="left"><i
                                                                            class="fa fa-cart-plus"></i></a></li>
                                                                <li><a href="#" data-tooltip="Wishlist"
                                                                        class="w-list"><i class="fa fa-heart-o"></i></a>
                                                                </li>
                                                                <li><a href="#" data-tooltip="Compare" class="cpare"><i
                                                                            class="fa fa-refresh"></i></a></li>
                                                                <li><a href="#" data-tooltip="Quick View" class="q-view"
                                                                        data-bs-toggle="modal"
                                                                        data-bs-target=".modal"><i
                                                                            class="fa fa-eye"></i></a></li>
                                                            </ul>
                                                        </div>
                                                    </div>
                                                    <div class="product-text">
                                                        <div class="prodcut-name"> <a href="single-product.html">Quisque
                                                                fringilla</a> </div>
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
                                                            <a href="single-product.html"> <img alt=""
                                                                    src="${pageContext.request.contextPath}/assets/home/images/product/02.jpg" class="primary-image">
                                                                <img alt="" src="${pageContext.request.contextPath}/assets/home/images/product/03.jpg"
                                                                    class="secondary-image"> </a>
                                                        </div>
                                                        <div class="product-icon socile-icon-tooltip text-center">
                                                            <ul>
                                                                <li><a href="#" data-tooltip="Add To Cart"
                                                                        class="add-cart" data-placement="left"><i
                                                                            class="fa fa-cart-plus"></i></a></li>
                                                                <li><a href="#" data-tooltip="Wishlist"
                                                                        class="w-list"><i class="fa fa-heart-o"></i></a>
                                                                </li>
                                                                <li><a href="#" data-tooltip="Compare" class="cpare"><i
                                                                            class="fa fa-refresh"></i></a></li>
                                                                <li><a href="#" data-tooltip="Quick View" class="q-view"
                                                                        data-bs-toggle="modal"
                                                                        data-bs-target=".modal"><i
                                                                            class="fa fa-eye"></i></a></li>
                                                            </ul>
                                                        </div>
                                                    </div>
                                                    <div class="product-text">
                                                        <div class="prodcut-name"> <a href="single-product.html">Quisque
                                                                fringilla</a> </div>
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
                                                            <a href="single-product.html"> <img alt=""
                                                                    src="${pageContext.request.contextPath}/assets/home/images/product/04.jpg" class="primary-image">
                                                                <img alt="" src="${pageContext.request.contextPath}/assets/home/images/product/03.jpg"
                                                                    class="secondary-image"> </a>
                                                        </div>
                                                        <div class="product-icon socile-icon-tooltip text-center">
                                                            <ul>
                                                                <li><a href="#" data-tooltip="Add To Cart"
                                                                        class="add-cart" data-placement="left"><i
                                                                            class="fa fa-cart-plus"></i></a></li>
                                                                <li><a href="#" data-tooltip="Wishlist"
                                                                        class="w-list"><i class="fa fa-heart-o"></i></a>
                                                                </li>
                                                                <li><a href="#" data-tooltip="Compare" class="cpare"><i
                                                                            class="fa fa-refresh"></i></a></li>
                                                                <li><a href="#" data-tooltip="Quick View" class="q-view"
                                                                        data-bs-toggle="modal"
                                                                        data-bs-target=".modal"><i
                                                                            class="fa fa-eye"></i></a></li>
                                                            </ul>
                                                        </div>
                                                    </div>
                                                    <div class="product-text">
                                                        <div class="prodcut-name"> <a href="single-product.html">Quisque
                                                                fringilla</a> </div>
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
                                                            <a href="single-product.html"> <img alt=""
                                                                    src="${pageContext.request.contextPath}/assets/home/images/product/05.jpg" class="primary-image">
                                                                <img alt="" src="${pageContext.request.contextPath}/assets/home/images/product/06.jpg"
                                                                    class="secondary-image"> </a>
                                                        </div>
                                                        <div class="product-icon socile-icon-tooltip text-center">
                                                            <ul>
                                                                <li><a href="#" data-tooltip="Add To Cart"
                                                                        class="add-cart" data-placement="left"><i
                                                                            class="fa fa-cart-plus"></i></a></li>
                                                                <li><a href="#" data-tooltip="Wishlist"
                                                                        class="w-list"><i class="fa fa-heart-o"></i></a>
                                                                </li>
                                                                <li><a href="#" data-tooltip="Compare" class="cpare"><i
                                                                            class="fa fa-refresh"></i></a></li>
                                                                <li><a href="#" data-tooltip="Quick View" class="q-view"
                                                                        data-bs-toggle="modal"
                                                                        data-bs-target=".modal"><i
                                                                            class="fa fa-eye"></i></a></li>
                                                            </ul>
                                                        </div>
                                                    </div>
                                                    <div class="product-text">
                                                        <div class="prodcut-name"> <a href="single-product.html">Quisque
                                                                fringilla</a> </div>
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
                                                                <div class="old-price"> <del>$250</del> </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <!-- single product end-->
                                            </div>
                                        </div>
                                    </div>
                                    <div role="tabpanel" class="tab-pane  fade in" id="bestsellr">
                                        <div class="total-new-arrival new-arrival-slider-active carsoule-btn">
                                            <div class="product-item">
                                                <!-- single product start-->
                                                <div class="single-product">
                                                    <div class="product-img">
                                                        <div class="product-label">
                                                            <div class="new">New</div>
                                                        </div>
                                                        <div class="single-prodcut-img  product-overlay pos-rltv">
                                                            <a href="single-product.html"> <img alt=""
                                                                    src="${pageContext.request.contextPath}/assets/home/images/product/01.jpg" class="primary-image">
                                                                <img alt="" src="${pageContext.request.contextPath}/assets/home/images/product/02.jpg"
                                                                    class="secondary-image"> </a>
                                                        </div>
                                                        <div class="product-icon socile-icon-tooltip text-center">
                                                            <ul>
                                                                <li><a href="#" data-tooltip="Add To Cart"
                                                                        class="add-cart" data-placement="left"><i
                                                                            class="fa fa-cart-plus"></i></a></li>
                                                                <li><a href="#" data-tooltip="Wishlist"
                                                                        class="w-list"><i class="fa fa-heart-o"></i></a>
                                                                </li>
                                                                <li><a href="#" data-tooltip="Compare" class="cpare"><i
                                                                            class="fa fa-refresh"></i></a></li>
                                                                <li><a href="#" data-tooltip="Quick View" class="q-view"
                                                                        data-bs-toggle="modal"
                                                                        data-bs-target=".modal"><i
                                                                            class="fa fa-eye"></i></a></li>
                                                            </ul>
                                                        </div>
                                                    </div>
                                                    <div class="product-text">
                                                        <div class="prodcut-name"> <a href="single-product.html">Quisque
                                                                fringilla</a> </div>
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
                                                            <a href="single-product.html"> <img alt=""
                                                                    src="${pageContext.request.contextPath}/assets/home/images/product/02.jpg" class="primary-image">
                                                                <img alt="" src="${pageContext.request.contextPath}/assets/home/images/product/03.jpg"
                                                                    class="secondary-image"> </a>
                                                        </div>
                                                        <div class="product-icon socile-icon-tooltip text-center">
                                                            <ul>
                                                                <li><a href="#" data-tooltip="Add To Cart"
                                                                        class="add-cart" data-placement="left"><i
                                                                            class="fa fa-cart-plus"></i></a></li>
                                                                <li><a href="#" data-tooltip="Wishlist"
                                                                        class="w-list"><i class="fa fa-heart-o"></i></a>
                                                                </li>
                                                                <li><a href="#" data-tooltip="Compare" class="cpare"><i
                                                                            class="fa fa-refresh"></i></a></li>
                                                                <li><a href="#" data-tooltip="Quick View" class="q-view"
                                                                        data-bs-toggle="modal"
                                                                        data-bs-target=".modal"><i
                                                                            class="fa fa-eye"></i></a></li>
                                                            </ul>
                                                        </div>
                                                    </div>
                                                    <div class="product-text">
                                                        <div class="prodcut-name"> <a href="single-product.html">Quisque
                                                                fringilla</a> </div>
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
                                                            <a href="single-product.html"> <img alt=""
                                                                    src="${pageContext.request.contextPath}/assets/home/images/product/04.jpg" class="primary-image">
                                                                <img alt="" src="${pageContext.request.contextPath}/assets/home/images/product/03.jpg"
                                                                    class="secondary-image"> </a>
                                                        </div>
                                                        <div class="product-icon socile-icon-tooltip text-center">
                                                            <ul>
                                                                <li><a href="#" data-tooltip="Add To Cart"
                                                                        class="add-cart" data-placement="left"><i
                                                                            class="fa fa-cart-plus"></i></a></li>
                                                                <li><a href="#" data-tooltip="Wishlist"
                                                                        class="w-list"><i class="fa fa-heart-o"></i></a>
                                                                </li>
                                                                <li><a href="#" data-tooltip="Compare" class="cpare"><i
                                                                            class="fa fa-refresh"></i></a></li>
                                                                <li><a href="#" data-tooltip="Quick View" class="q-view"
                                                                        data-bs-toggle="modal"
                                                                        data-bs-target=".modal"><i
                                                                            class="fa fa-eye"></i></a></li>
                                                            </ul>
                                                        </div>
                                                    </div>
                                                    <div class="product-text">
                                                        <div class="prodcut-name"> <a href="single-product.html">Quisque
                                                                fringilla</a> </div>
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
                                                            <a href="single-product.html"> <img alt=""
                                                                    src="${pageContext.request.contextPath}/assets/home/images/product/03.jpg" class="primary-image">
                                                                <img alt="" src="${pageContext.request.contextPath}/assets/home/images/product/04.jpg"
                                                                    class="secondary-image"> </a>
                                                        </div>
                                                        <div class="product-icon socile-icon-tooltip text-center">
                                                            <ul>
                                                                <li><a href="#" data-tooltip="Add To Cart"
                                                                        class="add-cart" data-placement="left"><i
                                                                            class="fa fa-cart-plus"></i></a></li>
                                                                <li><a href="#" data-tooltip="Wishlist"
                                                                        class="w-list"><i class="fa fa-heart-o"></i></a>
                                                                </li>
                                                                <li><a href="#" data-tooltip="Compare" class="cpare"><i
                                                                            class="fa fa-refresh"></i></a></li>
                                                                <li><a href="#" data-tooltip="Quick View" class="q-view"
                                                                        data-bs-toggle="modal"
                                                                        data-bs-target=".modal"><i
                                                                            class="fa fa-eye"></i></a></li>
                                                            </ul>
                                                        </div>
                                                    </div>
                                                    <div class="product-text">
                                                        <div class="prodcut-name"> <a href="single-product.html">Quisque
                                                                fringilla</a> </div>
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
                                                            <a href="single-product.html"> <img alt=""
                                                                    src="${pageContext.request.contextPath}/assets/home/images/product/05.jpg" class="primary-image">
                                                                <img alt="" src="${pageContext.request.contextPath}/assets/home/images/product/06.jpg"
                                                                    class="secondary-image"> </a>
                                                        </div>
                                                        <div class="product-icon socile-icon-tooltip text-center">
                                                            <ul>
                                                                <li><a href="#" data-tooltip="Add To Cart"
                                                                        class="add-cart" data-placement="left"><i
                                                                            class="fa fa-cart-plus"></i></a></li>
                                                                <li><a href="#" data-tooltip="Wishlist"
                                                                        class="w-list"><i class="fa fa-heart-o"></i></a>
                                                                </li>
                                                                <li><a href="#" data-tooltip="Compare" class="cpare"><i
                                                                            class="fa fa-refresh"></i></a></li>
                                                                <li><a href="#" data-tooltip="Quick View" class="q-view"
                                                                        data-bs-toggle="modal"
                                                                        data-bs-target=".modal"><i
                                                                            class="fa fa-eye"></i></a></li>
                                                            </ul>
                                                        </div>
                                                    </div>
                                                    <div class="product-text">
                                                        <div class="prodcut-name"> <a href="single-product.html">Quisque
                                                                fringilla</a> </div>
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
                                                                <div class="old-price"> <del>$250</del> </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <!-- single product end-->
                                            </div>
                                        </div>
                                    </div>
                                    <div role="tabpanel" class="tab-pane  fade in" id="specialoffer">
                                        <div class="total-new-arrival new-arrival-slider-active carsoule-btn">
                                            <div class="product-item">
                                                <!-- single product start-->
                                                <div class="single-product">
                                                    <div class="product-img">
                                                        <div class="single-prodcut-img  product-overlay pos-rltv">
                                                            <a href="single-product.html"> <img alt=""
                                                                    src="${pageContext.request.contextPath}/assets/home/images/product/04.jpg" class="primary-image">
                                                                <img alt="" src="${pageContext.request.contextPath}/assets/home/images/product/03.jpg"
                                                                    class="secondary-image"> </a>
                                                        </div>
                                                        <div class="product-icon socile-icon-tooltip text-center">
                                                            <ul>
                                                                <li><a href="#" data-tooltip="Add To Cart"
                                                                        class="add-cart" data-placement="left"><i
                                                                            class="fa fa-cart-plus"></i></a></li>
                                                                <li><a href="#" data-tooltip="Wishlist"
                                                                        class="w-list"><i class="fa fa-heart-o"></i></a>
                                                                </li>
                                                                <li><a href="#" data-tooltip="Compare" class="cpare"><i
                                                                            class="fa fa-refresh"></i></a></li>
                                                                <li><a href="#" data-tooltip="Quick View" class="q-view"
                                                                        data-bs-toggle="modal"
                                                                        data-bs-target=".modal"><i
                                                                            class="fa fa-eye"></i></a></li>
                                                            </ul>
                                                        </div>
                                                    </div>
                                                    <div class="product-text">
                                                        <div class="prodcut-name"> <a href="single-product.html">Quisque
                                                                fringilla</a> </div>
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
                                                            <a href="single-product.html"> <img alt=""
                                                                    src="${pageContext.request.contextPath}/assets/home/images/product/05.jpg" class="primary-image">
                                                                <img alt="" src="${pageContext.request.contextPath}/assets/home/images/product/06.jpg"
                                                                    class="secondary-image"> </a>
                                                        </div>
                                                        <div class="product-icon socile-icon-tooltip text-center">
                                                            <ul>
                                                                <li><a href="#" data-tooltip="Add To Cart"
                                                                        class="add-cart" data-placement="left"><i
                                                                            class="fa fa-cart-plus"></i></a></li>
                                                                <li><a href="#" data-tooltip="Wishlist"
                                                                        class="w-list"><i class="fa fa-heart-o"></i></a>
                                                                </li>
                                                                <li><a href="#" data-tooltip="Compare" class="cpare"><i
                                                                            class="fa fa-refresh"></i></a></li>
                                                                <li><a href="#" data-tooltip="Quick View" class="q-view"
                                                                        data-bs-toggle="modal"
                                                                        data-bs-target=".modal"><i
                                                                            class="fa fa-eye"></i></a></li>
                                                            </ul>
                                                        </div>
                                                    </div>
                                                    <div class="product-text">
                                                        <div class="prodcut-name"> <a href="single-product.html">Quisque
                                                                fringilla</a> </div>
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
                                                                <div class="old-price"> <del>$250</del> </div>
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
                                                            <div class="new">New</div>
                                                        </div>
                                                        <div class="single-prodcut-img  product-overlay pos-rltv">
                                                            <a href="single-product.html"> <img alt=""
                                                                    src="${pageContext.request.contextPath}/assets/home/images/product/01.jpg" class="primary-image">
                                                                <img alt="" src="${pageContext.request.contextPath}/assets/home/images/product/02.jpg"
                                                                    class="secondary-image"> </a>
                                                        </div>
                                                        <div class="product-icon socile-icon-tooltip text-center">
                                                            <ul>
                                                                <li><a href="#" data-tooltip="Add To Cart"
                                                                        class="add-cart" data-placement="left"><i
                                                                            class="fa fa-cart-plus"></i></a></li>
                                                                <li><a href="#" data-tooltip="Wishlist"
                                                                        class="w-list"><i class="fa fa-heart-o"></i></a>
                                                                </li>
                                                                <li><a href="#" data-tooltip="Compare" class="cpare"><i
                                                                            class="fa fa-refresh"></i></a></li>
                                                                <li><a href="#" data-tooltip="Quick View" class="q-view"
                                                                        data-bs-toggle="modal"
                                                                        data-bs-target=".modal"><i
                                                                            class="fa fa-eye"></i></a></li>
                                                            </ul>
                                                        </div>
                                                    </div>
                                                    <div class="product-text">
                                                        <div class="prodcut-name"> <a href="single-product.html">Quisque
                                                                fringilla</a> </div>
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
                                                            <a href="single-product.html"> <img alt=""
                                                                    src="${pageContext.request.contextPath}/assets/home/images/product/03.jpg" class="primary-image">
                                                                <img alt="" src="${pageContext.request.contextPath}/assets/home/images/product/04.jpg"
                                                                    class="secondary-image"> </a>
                                                        </div>
                                                        <div class="product-icon socile-icon-tooltip text-center">
                                                            <ul>
                                                                <li><a href="#" data-tooltip="Add To Cart"
                                                                        class="add-cart" data-placement="left"><i
                                                                            class="fa fa-cart-plus"></i></a></li>
                                                                <li><a href="#" data-tooltip="Wishlist"
                                                                        class="w-list"><i class="fa fa-heart-o"></i></a>
                                                                </li>
                                                                <li><a href="#" data-tooltip="Compare" class="cpare"><i
                                                                            class="fa fa-refresh"></i></a></li>
                                                                <li><a href="#" data-tooltip="Quick View" class="q-view"
                                                                        data-bs-toggle="modal"
                                                                        data-bs-target=".modal"><i
                                                                            class="fa fa-eye"></i></a></li>
                                                            </ul>
                                                        </div>
                                                    </div>
                                                    <div class="product-text">
                                                        <div class="prodcut-name"> <a href="single-product.html">Quisque
                                                                fringilla</a> </div>
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
                                                            <a href="single-product.html"> <img alt=""
                                                                    src="${pageContext.request.contextPath}/assets/home/images/product/02.jpg" class="primary-image">
                                                                <img alt="" src="${pageContext.request.contextPath}/assets/home/images/product/03.jpg"
                                                                    class="secondary-image"> </a>
                                                        </div>
                                                        <div class="product-icon socile-icon-tooltip text-center">
                                                            <ul>
                                                                <li><a href="#" data-tooltip="Add To Cart"
                                                                        class="add-cart" data-placement="left"><i
                                                                            class="fa fa-cart-plus"></i></a></li>
                                                                <li><a href="#" data-tooltip="Wishlist"
                                                                        class="w-list"><i class="fa fa-heart-o"></i></a>
                                                                </li>
                                                                <li><a href="#" data-tooltip="Compare" class="cpare"><i
                                                                            class="fa fa-refresh"></i></a></li>
                                                                <li><a href="#" data-tooltip="Quick View" class="q-view"
                                                                        data-bs-toggle="modal"
                                                                        data-bs-target=".modal"><i
                                                                            class="fa fa-eye"></i></a></li>
                                                            </ul>
                                                        </div>
                                                    </div>
                                                    <div class="product-text">
                                                        <div class="prodcut-name"> <a href="single-product.html">Quisque
                                                                fringilla</a> </div>
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
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!--discunt-featured-onsale-area end-->

        <!--testimonial-area-start-->
        <div class="testimonial-area overlay ptb-70 mt-70">
            <div class="container">
                <div class="row">
                    <div class="col-lg-12 text-center">
                        <div class="heading-title color-lightgrey mb-40 text-center">
                            <h5 class="uppercase">Testimonial</h5>
                        </div>
                    </div>
                    <div class="col-lg-12">
                        <div class="total-testimonial active-slider carosule-pagi pagi-03">
                            <div class="single-testimonial">
                                <div class="testimonial-img">
                                    <img src="${pageContext.request.contextPath}/assets/home/images/team/testi-03.jpg" alt="">
                                </div>
                                <div class="testimonial-content color-lightgrey">
                                    <div class="name-degi pos-rltv">
                                        <h5>Alexandra</h5>
                                        <p>Developer</p>
                                    </div>
                                    <div class="testi-text">
                                        <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod
                                            tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,
                                            quis nostrud exercitation ullamco.</p>
                                    </div>
                                </div>
                            </div>
                            <div class="single-testimonial">
                                <div class="testimonial-img">
                                    <img src="${pageContext.request.contextPath}/assets/home/images/team/testi-02.jpg" alt="">
                                </div>
                                <div class="testimonial-content color-lightgrey">
                                    <div class="name-degi pos-rltv">
                                        <h5>Bernadette</h5>
                                        <p>Facebook Liker</p>
                                    </div>
                                    <div class="testi-text">
                                        <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod
                                            tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,
                                            quis nostrud exercitation ullamco.</p>
                                    </div>
                                </div>
                            </div>
                            <div class="single-testimonial">
                                <div class="testimonial-img">
                                    <img src="${pageContext.request.contextPath}/assets/home/images/team/testi-01.jpg" alt="">
                                </div>
                                <div class="testimonial-content color-lightgrey">
                                    <div class="name-degi pos-rltv">
                                        <h5>Amanda</h5>
                                        <p>Designer</p>
                                    </div>
                                    <div class="testi-text">
                                        <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod
                                            tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,
                                            quis nostrud exercitation ullamco.</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!--testimonial-area-end-->

        <!--new-arrival on-sale Top-ratted area start-->
        <div class="arrival-ratted-sale-area pt-70">
            <div class="container">
                <div class="row">
                    <div class="col-md-4">
                        <div class="heading-title heading-style pos-rltv mb-50 text-center">
                            <h5 class="uppercase">New Arrival</h5>
                        </div>
                        <div class="ctg-slider-active">
                            <div class="single-ctg new-arrival-ctg">
                                <div class="single-ctg-item">
                                    <div class="row">
                                        <div class="col-lg-6 col-md-12 col-sm-6">
                                            <div class="product-ctg-img pos-rltv product-overlay">
                                                <a href="single-product.html"><img src="${pageContext.request.contextPath}/assets/home/images/product/s01.jpg"
                                                        alt=""></a>
                                            </div>
                                        </div>
                                        <div class="col-lg-6 col-md-12 col-sm-6">
                                            <div class="product-ctg-content">
                                                <p>Primo Court Mid Suede</p>
                                                <p class="font-bold">$236.99</p>
                                                <div class="social-icon socile-icon-style-1 mt-15">
                                                    <ul>
                                                        <li><a href="#"><i class="zmdi zmdi-shopping-cart"></i></a></li>
                                                        <li><a href="#" data-tooltip="Quick View" class="q-view"
                                                                data-bs-toggle="modal" data-bs-target=".modal"
                                                                tabindex="0"><i class="zmdi zmdi-eye"></i></a></li>
                                                    </ul>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="single-ctg-item">
                                    <div class="row">
                                        <div class="col-lg-6 col-md-12 col-sm-6">
                                            <div class="product-ctg-img pos-rltv product-overlay">
                                                <a href="single-product.html"><img src="${pageContext.request.contextPath}/assets/home/images/product/s02.jpg"
                                                        alt=""></a>
                                            </div>
                                        </div>
                                        <div class="col-lg-6 col-md-12 col-sm-6">
                                            <div class="product-ctg-content">
                                                <p>Primo Court Mid Suede</p>
                                                <p class="font-bold">$236.99</p>
                                                <div class="social-icon socile-icon-style-1 mt-15">
                                                    <ul>
                                                        <li><a href="#"><i class="zmdi zmdi-shopping-cart"></i></a></li>
                                                        <li><a href="#" data-tooltip="Quick View" class="q-view"
                                                                data-bs-toggle="modal" data-bs-target=".modal"
                                                                tabindex="0"><i class="zmdi zmdi-eye"></i></a></li>
                                                    </ul>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="single-ctg new-arrival-ctg">
                                <div class="single-ctg-item">
                                    <div class="row">
                                        <div class="col-lg-6 col-md-12 col-sm-6">
                                            <div class="product-ctg-img pos-rltv product-overlay">
                                                <a href="single-product.html"><img src="${pageContext.request.contextPath}/assets/home/images/product/s01.jpg"
                                                        alt=""></a>
                                            </div>
                                        </div>
                                        <div class="col-lg-6 col-md-12 col-sm-6">
                                            <div class="product-ctg-content">
                                                <p>Primo Court Mid Suede</p>
                                                <p class="font-bold">$236.99</p>
                                                <div class="social-icon socile-icon-style-1 mt-15">
                                                    <ul>
                                                        <li><a href="#"><i class="zmdi zmdi-shopping-cart"></i></a></li>
                                                        <li><a href="#" data-tooltip="Quick View" class="q-view"
                                                                data-bs-toggle="modal" data-bs-target=".modal"
                                                                tabindex="0"><i class="zmdi zmdi-eye"></i></a></li>
                                                    </ul>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="single-ctg-item">
                                    <div class="row">
                                        <div class="col-lg-6 col-md-12 col-sm-6">
                                            <div class="product-ctg-img pos-rltv product-overlay">
                                                <a href="single-product.html"><img src="${pageContext.request.contextPath}/assets/home/images/product/s02.jpg"
                                                        alt=""></a>
                                            </div>
                                        </div>
                                        <div class="col-lg-6 col-md-12 col-sm-6">
                                            <div class="product-ctg-content">
                                                <p>Primo Court Mid Suede</p>
                                                <p class="font-bold">$236.99</p>
                                                <div class="social-icon socile-icon-style-1 mt-15">
                                                    <ul>
                                                        <li><a href="#"><i class="zmdi zmdi-shopping-cart"></i></a></li>
                                                        <li><a href="#" data-tooltip="Quick View" class="q-view"
                                                                data-bs-toggle="modal" data-bs-target=".modal"
                                                                tabindex="0"><i class="zmdi zmdi-eye"></i></a></li>
                                                    </ul>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="single-ctg on-sale-ctg">
                            <div class="heading-title heading-style pos-rltv mb-50 text-center">
                                <h5 class="uppercase">On Sale</h5>
                            </div>
                            <div class="ctg-slider-active">
                                <div class="single-ctg new-arrival-ctg">
                                    <div class="single-ctg-item">
                                        <div class="row">
                                            <div class="col-lg-6 col-md-12 col-sm-6">
                                                <div class="product-ctg-img pos-rltv product-overlay">
                                                    <a href="single-product.html"><img src="${pageContext.request.contextPath}/assets/home/images/product/s01.jpg"
                                                            alt=""></a>
                                                </div>
                                            </div>
                                            <div class="col-lg-6 col-md-12 col-sm-6">
                                                <div class="product-ctg-content">
                                                    <p>Primo Court Mid Suede</p>
                                                    <p class="font-bold">$236.99</p>
                                                    <div class="social-icon socile-icon-style-1 mt-15">
                                                        <ul>
                                                            <li><a href="#"><i class="zmdi zmdi-shopping-cart"></i></a>
                                                            </li>
                                                            <li><a href="#" data-tooltip="Quick View" class="q-view"
                                                                    data-bs-toggle="modal" data-bs-target=".modal"
                                                                    tabindex="0"><i class="zmdi zmdi-eye"></i></a></li>
                                                        </ul>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="single-ctg-item">
                                        <div class="row">
                                            <div class="col-lg-6 col-md-12 col-sm-6">
                                                <div class="product-ctg-img pos-rltv product-overlay">
                                                    <a href="single-product.html"><img src="${pageContext.request.contextPath}/assets/home/images/product/s02.jpg"
                                                            alt=""></a>
                                                </div>
                                            </div>
                                            <div class="col-lg-6 col-md-12 col-sm-6">
                                                <div class="product-ctg-content">
                                                    <p>Primo Court Mid Suede</p>
                                                    <p class="font-bold">$236.99</p>
                                                    <div class="social-icon socile-icon-style-1 mt-15">
                                                        <ul>
                                                            <li><a href="#"><i class="zmdi zmdi-shopping-cart"></i></a>
                                                            </li>
                                                            <li><a href="#" data-tooltip="Quick View" class="q-view"
                                                                    data-bs-toggle="modal" data-bs-target=".modal"
                                                                    tabindex="0"><i class="zmdi zmdi-eye"></i></a></li>
                                                        </ul>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="single-ctg new-arrival-ctg">
                                    <div class="single-ctg-item">
                                        <div class="row">
                                            <div class="col-lg-6 col-md-12 col-sm-6">
                                                <div class="product-ctg-img pos-rltv product-overlay">
                                                    <a href="single-product.html"><img src="${pageContext.request.contextPath}/assets/home/images/product/s01.jpg"
                                                            alt=""></a>
                                                </div>
                                            </div>
                                            <div class="col-lg-6 col-md-12 col-sm-6">
                                                <div class="product-ctg-content">
                                                    <p>Primo Court Mid Suede</p>
                                                    <p class="font-bold">$236.99</p>
                                                    <div class="social-icon socile-icon-style-1 mt-15">
                                                        <ul>
                                                            <li><a href="#"><i class="zmdi zmdi-shopping-cart"></i></a>
                                                            </li>
                                                            <li><a href="#" data-tooltip="Quick View" class="q-view"
                                                                    data-bs-toggle="modal" data-bs-target=".modal"
                                                                    tabindex="0"><i class="zmdi zmdi-eye"></i></a></li>
                                                        </ul>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="single-ctg-item">
                                        <div class="row">
                                            <div class="col-lg-6 col-md-12 col-sm-6">
                                                <div class="product-ctg-img pos-rltv product-overlay">
                                                    <a href="single-product.html"><img src="${pageContext.request.contextPath}/assets/home/images/product/s02.jpg"
                                                            alt=""></a>
                                                </div>
                                            </div>
                                            <div class="col-lg-6 col-md-12 col-sm-6">
                                                <div class="product-ctg-content">
                                                    <p>Primo Court Mid Suede</p>
                                                    <p class="font-bold">$236.99</p>
                                                    <div class="social-icon socile-icon-style-1 mt-15">
                                                        <ul>
                                                            <li><a href="#"><i class="zmdi zmdi-shopping-cart"></i></a>
                                                            </li>
                                                            <li><a href="#" data-tooltip="Quick View" class="q-view"
                                                                    data-bs-toggle="modal" data-bs-target=".modal"
                                                                    tabindex="0"><i class="zmdi zmdi-eye"></i></a></li>
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
                    <div class="col-md-4">
                        <div class="single-ctg top-rated-ctg">
                            <div class="heading-title heading-style pos-rltv mb-50 text-center">
                                <h5 class="uppercase">Top Rated</h5>
                            </div>
                            <div class="ctg-slider-active">
                                <div class="single-ctg new-arrival-ctg">
                                    <div class="single-ctg-item">
                                        <div class="row">
                                            <div class="col-lg-6 col-md-12 col-sm-6">
                                                <div class="product-ctg-img pos-rltv product-overlay">
                                                    <a href="single-product.html"><img src="${pageContext.request.contextPath}/assets/home/images/product/s01.jpg"
                                                            alt=""></a>
                                                </div>
                                            </div>
                                            <div class="col-lg-6 col-md-12 col-sm-6">
                                                <div class="product-ctg-content">
                                                    <p>Primo Court Mid Suede</p>
                                                    <p class="font-bold">$236.99</p>
                                                    <div class="social-icon socile-icon-style-1 mt-15">
                                                        <ul>
                                                            <li><a href="#"><i class="zmdi zmdi-shopping-cart"></i></a>
                                                            </li>
                                                            <li><a href="#" data-tooltip="Quick View" class="q-view"
                                                                    data-bs-toggle="modal" data-bs-target=".modal"
                                                                    tabindex="0"><i class="zmdi zmdi-eye"></i></a></li>
                                                        </ul>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="single-ctg-item">
                                        <div class="row">
                                            <div class="col-lg-6 col-md-12 col-sm-6">
                                                <div class="product-ctg-img pos-rltv product-overlay">
                                                    <a href="single-product.html"><img src="${pageContext.request.contextPath}/assets/home/images/product/s02.jpg"
                                                            alt=""></a>
                                                </div>
                                            </div>
                                            <div class="col-lg-6 col-md-12 col-sm-6">
                                                <div class="product-ctg-content">
                                                    <p>Primo Court Mid Suede</p>
                                                    <p class="font-bold">$236.99</p>
                                                    <div class="social-icon socile-icon-style-1 mt-15">
                                                        <ul>
                                                            <li><a href="#"><i class="zmdi zmdi-shopping-cart"></i></a>
                                                            </li>
                                                            <li><a href="#" data-tooltip="Quick View" class="q-view"
                                                                    data-bs-toggle="modal" data-bs-target=".modal"
                                                                    tabindex="0"><i class="zmdi zmdi-eye"></i></a></li>
                                                        </ul>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="single-ctg new-arrival-ctg">
                                    <div class="single-ctg-item">
                                        <div class="row">
                                            <div class="col-lg-6 col-md-12 col-sm-6">
                                                <div class="product-ctg-img pos-rltv product-overlay">
                                                    <a href="single-product.html"><img src="${pageContext.request.contextPath}/assets/home/images/product/s01.jpg"
                                                            alt=""></a>
                                                </div>
                                            </div>
                                            <div class="col-lg-6 col-md-12 col-sm-6">
                                                <div class="product-ctg-content">
                                                    <p>Primo Court Mid Suede</p>
                                                    <p class="font-bold">$236.99</p>
                                                    <div class="social-icon socile-icon-style-1 mt-15">
                                                        <ul>
                                                            <li><a href="#"><i class="zmdi zmdi-shopping-cart"></i></a>
                                                            </li>
                                                            <li><a href="#" data-tooltip="Quick View" class="q-view"
                                                                    data-bs-toggle="modal" data-bs-target=".modal"
                                                                    tabindex="0"><i class="zmdi zmdi-eye"></i></a></li>
                                                        </ul>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="single-ctg-item">
                                        <div class="row">
                                            <div class="col-lg-6 col-md-12 col-sm-6">
                                                <div class="product-ctg-img pos-rltv product-overlay">
                                                    <a href="single-product.html"><img src="${pageContext.request.contextPath}/assets/home/images/product/s02.jpg"
                                                            alt=""></a>
                                                </div>
                                            </div>
                                            <div class="col-lg-6 col-md-12 col-sm-6">
                                                <div class="product-ctg-content">
                                                    <p>Primo Court Mid Suede</p>
                                                    <p class="font-bold">$236.99</p>
                                                    <div class="social-icon socile-icon-style-1 mt-15">
                                                        <ul>
                                                            <li><a href="#"><i class="zmdi zmdi-shopping-cart"></i></a>
                                                            </li>
                                                            <li><a href="#" data-tooltip="Quick View" class="q-view"
                                                                    data-bs-toggle="modal" data-bs-target=".modal"
                                                                    tabindex="0"><i class="zmdi zmdi-eye"></i></a></li>
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
                </div>
            </div>
        </div>
        <!--new-arrival on-sale Top-ratted area end-->

        <!--brand area are start-->
        <div class="brand-area ptb-60">
            <div class="container">
                <div class="row">
                    <div class="col-lg-12">
                        <div class="total-brand">
                            <div class="brand-item">
                                <div class="single-brand shadow-box"><a href="#"><img src="${pageContext.request.contextPath}/assets/home/images/brand/01.png"
                                            alt=""></a></div>
                            </div>
                            <div class="brand-item">
                                <div class="single-brand shadow-box"><a href="#"><img src="${pageContext.request.contextPath}/assets/home/images/brand/02.png"
                                            alt=""></a></div>
                            </div>
                            <div class="brand-item">
                                <div class="single-brand shadow-box"><a href="#"><img src="${pageContext.request.contextPath}/assets/home/images/brand/03.png"
                                            alt=""></a></div>
                            </div>
                            <div class="brand-item">
                                <div class="single-brand shadow-box"><a href="#"><img src="${pageContext.request.contextPath}/assets/home/images/brand/04.png"
                                            alt=""></a></div>
                            </div>
                            <div class="brand-item">
                                <div class="single-brand shadow-box"><a href="#"><img src="${pageContext.request.contextPath}/assets/home/images/brand/05.png"
                                            alt=""></a></div>
                            </div>
                            <div class="brand-item">
                                <div class="single-brand shadow-box"><a href="#"><img src="${pageContext.request.contextPath}/assets/home/images/brand/06.png"
                                            alt=""></a></div>
                            </div>
                            <div class="brand-item">
                                <div class="single-brand shadow-box"><a href="#"><img src="${pageContext.request.contextPath}/assets/home/images/brand/01.png"
                                            alt=""></a></div>
                            </div>
                            <div class="brand-item">
                                <div class="single-brand shadow-box"><a href="#"><img src="${pageContext.request.contextPath}/assets/home/images/brand/02.png"
                                            alt=""></a></div>
                            </div>
                            <div class="brand-item">
                                <div class="single-brand shadow-box"><a href="#"><img src="${pageContext.request.contextPath}/assets/home/images/brand/03.png"
                                            alt=""></a></div>
                            </div>
                            <div class="brand-item">
                                <div class="single-brand shadow-box"><a href="#"><img src="${pageContext.request.contextPath}/assets/home/images/brand/04.png"
                                            alt=""></a></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!--brand area are start-->

        <!--blog area are start-->
        <div class="blog-area pb-70">
            <div class="container">
                <div class="row">
                    <div class="col-lg-12 text-center">
                        <div class="heading-title heading-style pos-rltv mb-50 text-center">
                            <h5 class="uppercase">Blog</h5>
                        </div>
                        <div class="total-blog">
                            <div class="blog-item">
                                <div class="single-blog">
                                    <div class="blog-img pos-rltv product-overlay">
                                        <a href="#"><img src="${pageContext.request.contextPath}/assets/home/images/blog/01.jpg" alt=""></a>
                                    </div>
                                    <div class="blog-content">
                                        <div class="blog-title">
                                            <h5 class="uppercase font-bold"><a href="#">New fashion collection 2022</a>
                                            </h5>
                                            <div class="like-comments-date">
                                                <ul>
                                                    <li><a href="#"><i class="zmdi zmdi-favorite-outline"></i>13
                                                            Like</a>
                                                    </li>
                                                    <li><a href="#"><i class="zmdi zmdi-comment-outline"></i>03
                                                            Comments</a>
                                                    </li>
                                                    <li class="blog-date"><a href="#"><i
                                                                class="zmdi zmdi-calendar-alt"></i>16 jun 2022</a></li>
                                                </ul>
                                            </div>
                                            <div class="blog-text">
                                                <p>It is a long established fact that a reader will be distracted by the
                                                    readable content of a page when looking at its layout. The point of
                                                    using.</p>
                                            </div>
                                            <a class="read-more montserrat" href="single-blog.html">Read More</a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="blog-item">
                                <div class="single-blog">
                                    <div class="blog-img pos-rltv product-overlay">
                                        <a href="#"><img src="${pageContext.request.contextPath}/assets/home/images/blog/02.jpg" alt=""></a>
                                    </div>
                                    <div class="blog-content">
                                        <div class="blog-title">
                                            <h5 class="uppercase font-bold"><a href="#">New fashion collection 2022</a>
                                            </h5>
                                            <div class="like-comments-date">
                                                <ul>
                                                    <li><a href="#"><i class="zmdi zmdi-favorite-outline"></i>13
                                                            Like</a>
                                                    </li>
                                                    <li><a href="#"><i class="zmdi zmdi-comment-outline"></i>03
                                                            Comments</a>
                                                    </li>
                                                    <li class="blog-date"><a href="#"><i
                                                                class="zmdi zmdi-calendar-alt"></i>16 jun 2022</a></li>
                                                </ul>
                                            </div>
                                            <div class="blog-text">
                                                <p>It is a long established fact that a reader will be distracted by the
                                                    readable content of a page when looking at its layout. The point of
                                                    using.</p>
                                            </div>
                                            <a class="read-more montserrat" href="single-blog.html">Read More</a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="blog-item">
                                <div class="single-blog">
                                    <div class="blog-img pos-rltv product-overlay">
                                        <a href="#"><img src="${pageContext.request.contextPath}/assets/home/images/blog/03.jpg" alt=""></a>
                                    </div>
                                    <div class="blog-content">
                                        <div class="blog-title">
                                            <h5 class="uppercase font-bold"><a href="#">New fashion collection 2022</a>
                                            </h5>
                                            <div class="like-comments-date">
                                                <ul>
                                                    <li><a href="#"><i class="zmdi zmdi-favorite-outline"></i>13
                                                            Like</a>
                                                    </li>
                                                    <li><a href="#"><i class="zmdi zmdi-comment-outline"></i>03
                                                            Comments</a>
                                                    </li>
                                                    <li class="blog-date"><a href="#"><i
                                                                class="zmdi zmdi-calendar-alt"></i>16 jun 2022</a></li>
                                                </ul>
                                            </div>
                                            <div class="blog-text">
                                                <p>It is a long established fact that a reader will be distracted by the
                                                    readable content of a page when looking at its layout. The point of
                                                    using.</p>
                                            </div>
                                            <a class="read-more montserrat" href="single-blog.html">Read More</a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="blog-item">
                                <div class="single-blog">
                                    <div class="blog-img pos-rltv product-overlay">
                                        <a href="#"><img src="${pageContext.request.contextPath}/assets/home/images/blog/01.jpg" alt=""></a>
                                    </div>
                                    <div class="blog-content">
                                        <div class="blog-title">
                                            <h5 class="uppercase font-bold"><a href="#">New fashion collection 2022</a>
                                            </h5>
                                            <div class="like-comments-date">
                                                <ul>
                                                    <li><a href="#"><i class="zmdi zmdi-favorite-outline"></i>13
                                                            Like</a>
                                                    </li>
                                                    <li><a href="#"><i class="zmdi zmdi-comment-outline"></i>03
                                                            Comments</a>
                                                    </li>
                                                    <li class="blog-date"><a href="#"><i
                                                                class="zmdi zmdi-calendar-alt"></i>16 jun 2022</a></li>
                                                </ul>
                                            </div>
                                            <div class="blog-text">
                                                <p>It is a long established fact that a reader will be distracted by the
                                                    readable content of a page when looking at its layout. The point of
                                                    using.</p>
                                            </div>
                                            <a class="read-more montserrat" href="single-blog.html">Read More</a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!--blog area are end-->

        <!-- footer area start-->
       <jsp:include page="../common/home/footer-homepage.jsp"></jsp:include>
        <!--footer bottom area end-->

        <!-- QUICKVIEW PRODUCT -->
        <div id="quickview-wrapper">
            <!-- Modal -->
            <div class="modal fade" id="productModal" tabindex="-1" role="dialog">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close"><span
                                    aria-hidden="true">&times;</span></button>
                        </div>
                        <div class="modal-body">
                            <div class="modal-product">
                                <div class="product-images">
                                    <!--modal tab start-->
                                    <div class="portfolio-thumbnil-area-2">
                                        <div class="tab-content active-portfolio-area-2">
                                            <div role="tabpanel" class="tab-pane active" id="view1">
                                                <div class="product-img">
                                                    <a href="#"><img src="${pageContext.request.contextPath}/assets/home/images/product/01.jpg"
                                                            alt="Single portfolio" /></a>
                                                </div>
                                            </div>
                                            <div role="tabpanel" class="tab-pane" id="view2">
                                                <div class="product-img">
                                                    <a href="#"><img src="${pageContext.request.contextPath}/assets/home/images/product/02.jpg"
                                                            alt="Single portfolio" /></a>
                                                </div>
                                            </div>
                                            <div role="tabpanel" class="tab-pane" id="view3">
                                                <div class="product-img">
                                                    <a href="#"><img src="${pageContext.request.contextPath}/assets/home/images/product/03.jpg"
                                                            alt="Single portfolio" /></a>
                                                </div>
                                            </div>
                                            <div role="tabpanel" class="tab-pane" id="view4">
                                                <div class="product-img">
                                                    <a href="#"><img src="${pageContext.request.contextPath}/assets/home/images/product/04.jpg"
                                                            alt="Single portfolio" /></a>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="product-more-views-2">
                                            <ul class="thumbnail-carousel-modal-2 nav" data-tabs="tabs">
                                                <li class="nav-item" role="presentation">
                                                    <a class="nav-link active" id="view1" data-bs-toggle="tab" href="#view1"
                                                        role="tab" aria-controls="view1" aria-selected="true">
                                                        <img
                                                        src="${pageContext.request.contextPath}/assets/home/images/product/01.jpg" alt="" />
                                                    </a>
                                                </li>
                                                <li class="nav-item" role="presentation">
                                                    <a class="nav-link" id="view2" data-bs-toggle="tab" href="#view2"
                                                        role="tab" aria-controls="view2" aria-selected="true">
                                                        <img
                                                        src="${pageContext.request.contextPath}/assets/home/images/product/02.jpg" alt="" />
                                                    </a>
                                                </li>
                                                <li class="nav-item" role="presentation">
                                                    <a class="nav-link" id="view3" data-bs-toggle="tab" href="#view3"
                                                        role="tab" aria-controls="view3" aria-selected="true">
                                                        <img
                                                        src="${pageContext.request.contextPath}/assets/home/images/product/03.jpg" alt="" />
                                                    </a>
                                                </li>
                                                <li class="nav-item" role="presentation">
                                                    <a class="nav-link" id="view4" data-bs-toggle="tab" href="#view4"
                                                        role="tab" aria-controls="view4" aria-selected="true">
                                                        <img
                                                        src="${pageContext.request.contextPath}/assets/home/images/product/04.jpg" alt="" />
                                                    </a>
                                                </li>
                                            </ul>
                                        </div>
                                    </div>
                                </div>
                                <!--modal tab end-->
                                <!-- .product-images -->
                                <div class="product-info">
                                    <h1>Aenean eu tristique</h1>
                                    <div class="price-box-3">
                                        <div class="s-price-box"> <span class="new-price">$160.00</span> <span
                                                class="old-price">$190.00</span> </div>
                                    </div> <a href="shop.html" class="see-all">See all features</a>
                                    <div class="quick-add-to-cart">
                                        <form method="post" class="cart">
                                            <div class="numbers-row">
                                                <input type="number" id="french-hens" value="3" min="1">
                                            </div>
                                            <button class="single_add_to_cart_button" type="submit">Add to cart</button>
                                        </form>
                                    </div>
                                    <div class="quick-desc"> Lorem ipsum dolor sit amet, consectetur adipiscing elit.
                                        Nam
                                        fringilla augue nec est tristique auctor. Donec non est at libero.Lorem ipsum
                                        dolor
                                        sit amet, consectetur adipiscing elit. Nam fringilla augue nec est tristique
                                        auctor.
                                        Donec non est at libero.Nam fringilla tristique auctor. </div>
                                    <div class="social-sharing-modal">
                                        <div class="widget widget_socialsharing_widget">
                                            <h3 class="widget-title-modal">Share this product</h3>
                                            <ul class="social-icons-modal">
                                                <li><a title="Facebook" href="#" class="facebook m-single-icon"><i
                                                            class="fa fa-facebook"></i></a>
                                                </li>
                                                <li><a title="Twitter" href="#" class="twitter m-single-icon"><i
                                                            class="fa fa-twitter"></i></a></li>
                                                <li><a title="Pinterest" href="#" class="pinterest m-single-icon"><i
                                                            class="fa fa-pinterest"></i></a>
                                                </li>
                                                <li><a title="Google +" href="#" class="gplus m-single-icon"><i
                                                            class="fa fa-google-plus"></i></a>
                                                </li>
                                                <li><a title="LinkedIn" href="#" class="linkedin m-single-icon"><i
                                                            class="fa fa-linkedin"></i></a>
                                                </li>
                                            </ul>
                                        </div>
                                    </div>
                                </div>
                                <!-- .product-info -->
                            </div>
                            <!-- .modal-product -->
                        </div>
                        <!-- .modal-body -->
                    </div>
                    <!-- .modal-content -->
                </div>
                <!-- .modal-dialog -->
            </div>
            <!-- END Modal -->
        </div>
        <!-- END QUICKVIEW PRODUCT -->
    </div>
    <!-- Body main wrapper end -->

    <!-- Placed js at the end of the document so the pages load faster -->

    <!-- jquery latest version -->
     <jsp:include page="../common/home/js-home.jsp"></jsp:include>

</body>


<!-- Mirrored from htmldemo.net/clothing/clothing/index.html by HTTrack Website Copier/3.x [XR&CO'2014], Sat, 01 Feb 2025 03:37:37 GMT -->
</html>