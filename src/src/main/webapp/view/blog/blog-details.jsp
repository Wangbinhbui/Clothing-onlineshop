<%-- 
    Document   : blog-details
    Created on : Feb 9, 2025, 11:01:48 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!doctype html>
<html class="no-js" lang="en">


    <!-- Mirrored from htmldemo.net/clothing/clothing/blog-full-right.html by HTTrack Website Copier/3.x [XR&CO'2014], Sat, 01 Feb 2025 03:37:52 GMT -->
    <head>
        <meta charset="utf-8">
        <meta http-equiv="x-ua-compatible" content="ie=edge">
        <title>Blog-Details || Clothing</title>
        <meta name="description" content="Clothing – eCommerce Fashion Template is a clean and elegant design – suitable for selling clothing, fashion, high fashion, men fashion, women fashion, accessories, digital, kids, watches, jewelries, shoes, kids, furniture, sports, tools….. It has a fully responsive width adjusts automatically to any screen size or resolution.">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <link rel="shortcut icon" type="image/x-icon" href="images/icons/favicon.png">
        <!-- Place favicon.png in the root directory -->

        <!-- All css files are included here. -->
        <jsp:include page="../common/blog/css-blog.jsp"></jsp:include>



            <!-- Modernizr JS -->
            <script src="js/vendor/modernizr-3.11.2.min.js"></script>
        </head>

        <body>
            <!--[if lt IE 8]>
                <p class="browserupgrade">You are using an <strong>outdated</strong> browser. Please <a href="http://browsehappy.com/">upgrade your browser</a> to improve your experience.</p>
            <![endif]-->

            <!-- Body main wrapper start -->
            <div class="wrapper blog-full-list">

                <!-- Start of header area -->
            <jsp:include page="../common/blog/header-blog.jsp"></jsp:include>
                <!-- End of header area -->

                <!--breadcumb area start -->
                <div class="breadcumb-area breadcumb-2 overlay pos-rltv">
                    <div class="bread-main">
                        <div class="bred-hading text-center">
                            <h5>Blog Details</h5>
                        </div>
                        <ol class="breadcrumb">
                            <li class="home"><a title="Go to Home Page" href="index.html">Home</a></li>
                            <li class="active">Blog Full List</li>
                        </ol>
                    </div>
                </div>
                <!--breadcumb area end -->

                <!--single blog main area are start-->
                <div class="shop-main-area pt-70 pb-40">
                    <div class="container">
                        <div class="row">
                            <!--shop sidebar start-->
                            <div class="col-lg-3 col-md-4 order-2">
                                <div class="shop-sidebar blog-sidebar">
                                    <!--single aside start-->
                                    <aside class="single-aside search-aside search-box">
                                        <form action="#">
                                            <div class="input-box">
                                                <input class="single-input" placeholder="Search...." type="text">
                                                <button class="src-btn sb-2"><i class="fa fa-search"></i></button>
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
                                                <li class="closed"><a href="#">Men (05)</a>
                                                    <ul>
                                                        <li><a href="#">T-Shirt</a></li>
                                                        <li><a href="#">Shirt</a></li>
                                                        <li><a href="#">Pant</a></li>
                                                        <li><a href="#">Shoe</a></li>
                                                        <li><a href="#">Gifts</a></li>
                                                    </ul>
                                                </li>
                                                <li class="closed"><a href="#">Women (10)</a>
                                                    <ul>
                                                        <li><a href="#">T-Shirt</a>
                                                            <ul>
                                                                <li><a href="#">T-Shirt 01</a></li>
                                                                <li><a href="#">T-Shirt 02</a></li>
                                                            </ul>
                                                        </li>
                                                        <li><a href="#">Shirt</a>
                                                            <ul>
                                                                <li><a href="#">Shirt 01</a></li>
                                                                <li><a href="#">Shirt 02</a></li>
                                                            </ul>
                                                        </li>
                                                        <li><a href="#">Pant</a>
                                                            <ul>
                                                                <li><a href="#">Pant 01</a></li>
                                                                <li><a href="#">Pant 02</a></li>
                                                            </ul>
                                                        </li>
                                                        <li><a href="#">Shoe</a>
                                                            <ul>
                                                                <li><a href="#">Shoe 01</a></li>
                                                                <li><a href="#">Shoe 02</a></li>
                                                            </ul>
                                                        </li>
                                                        <li><a href="#">Gifts</a>
                                                            <ul>
                                                                <li><a href="#">Gift 01</a></li>
                                                                <li><a href="#">Gift 02</a></li>
                                                            </ul>
                                                        </li>
                                                    </ul>
                                                </li>
                                                <li class="closed"><a href="#">Accessories (07)</a>
                                                    <ul>
                                                        <li><a href="#">Accessories 01</a></li>
                                                        <li><a href="#">Accessories 02</a></li>
                                                        <li><a href="#">Accessories 03</a></li>
                                                    </ul>
                                                </li>
                                                <li class="closed"><a href="#">Beauty (06)</a>
                                                    <ul>
                                                        <li><a href="#">Beauty 01</a></li>
                                                        <li><a href="#">Beauty 02</a></li>
                                                        <li><a href="#">Beauty 03</a></li>
                                                    </ul>
                                                </li>
                                                <li class="closed"><a href="#">Watch (09)</a>
                                                    <ul>
                                                        <li><a href="#">Watch 01</a></li>
                                                        <li><a href="#">Watch 02</a></li>
                                                        <li><a href="#">Watch 03</a></li>
                                                    </ul>
                                                </li>
                                                <li class="closed"><a href="#">Sports</a></li>
                                                <li class="closed"><a href="#">Others</a></li>
                                            </ul>
                                        </div>
                                    </aside>
                                    <!--single aside end-->

                                    <!--single aside start-->
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
                                    <!--single aside end-->

                                    <!--single aside start-->
                                    <aside class="single-aside product-aside">
                                        <div class="heading-title aside-title pos-rltv">
                                            <h5 class="uppercase">Recent Product</h5>
                                        </div>
                                        <div class="recent-prodcut-wraper total-rectnt-slider">
                                            <div class="single-rectnt-slider">
                                                <!-- single product start-->
                                                <div class="single-product recent-single-product">
                                                    <div class="product-img">
                                                        <div class="single-prodcut-img  product-overlay pos-rltv">
                                                            <a href="single-product.html"> <img alt=""
                                                                                                src="images/product/rp01.jpg" class="primary-image"> <img
                                                                                                alt="" src="images/product/rp02.jpg"
                                                                                                class="secondary-image"> </a>
                                                        </div>
                                                    </div>
                                                    <div class="product-text">
                                                        <div class="prodcut-name"> <a href="single-product.html">Copenhagen
                                                                Spitfire Chair</a> </div>
                                                        <div class="prodcut-ratting-price">
                                                            <div class="prodcut-ratting"> <a href="#"><i
                                                                        class="fa fa-star"></i></a> <a href="#"><i
                                                                        class="fa fa-star"></i></a> <a href="#"><i
                                                                        class="fa fa-star"></i></a> <a href="#"><i
                                                                        class="fa fa-star"></i></a> <a href="#"><i
                                                                        class="fa fa-star-o"></i></a> </div>
                                                            <div class="prodcut-price">
                                                                <div class="new-price"> $220 </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <!-- single product end-->

                                                <!-- single product start-->
                                                <div class="single-product recent-single-product">
                                                    <div class="product-img">
                                                        <div class="single-prodcut-img  product-overlay pos-rltv">
                                                            <a href="single-product.html"> <img alt=""
                                                                                                src="images/product/rp03.jpg" class="primary-image"> <img
                                                                                                alt="" src="images/product/rp04.jpg"
                                                                                                class="secondary-image"> </a>
                                                        </div>
                                                    </div>
                                                    <div class="product-text">
                                                        <div class="prodcut-name"> <a href="single-product.html">Copenhagen
                                                                Spitfire Chair</a> </div>
                                                        <div class="prodcut-ratting-price">
                                                            <div class="prodcut-ratting"> <a href="#"><i
                                                                        class="fa fa-star"></i></a> <a href="#"><i
                                                                        class="fa fa-star"></i></a> <a href="#"><i
                                                                        class="fa fa-star"></i></a> <a href="#"><i
                                                                        class="fa fa-star"></i></a> <a href="#"><i
                                                                        class="fa fa-star-o"></i></a> </div>
                                                            <div class="prodcut-price">
                                                                <div class="new-price"> $220 </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <!-- single product end-->

                                                <!-- single product start-->
                                                <div class="single-product recent-single-product">
                                                    <div class="product-img">
                                                        <div class="single-prodcut-img  product-overlay pos-rltv">
                                                            <a href="single-product.html"> <img alt=""
                                                                                                src="images/product/rp02.jpg" class="primary-image"> <img
                                                                                                alt="" src="images/product/rp03.jpg"
                                                                                                class="secondary-image"> </a>
                                                        </div>
                                                    </div>
                                                    <div class="product-text">
                                                        <div class="prodcut-name"> <a href="single-product.html">Copenhagen
                                                                Spitfire Chair</a> </div>
                                                        <div class="prodcut-ratting-price">
                                                            <div class="prodcut-ratting"> <a href="#"><i
                                                                        class="fa fa-star"></i></a> <a href="#"><i
                                                                        class="fa fa-star"></i></a> <a href="#"><i
                                                                        class="fa fa-star"></i></a> <a href="#"><i
                                                                        class="fa fa-star"></i></a> <a href="#"><i
                                                                        class="fa fa-star-o"></i></a> </div>
                                                            <div class="prodcut-price">
                                                                <div class="new-price"> $220 </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <!-- single product end-->

                                                <!-- single product start-->
                                                <div class="single-product recent-single-product">
                                                    <div class="product-img">
                                                        <div class="single-prodcut-img  product-overlay pos-rltv">
                                                            <a href="single-product.html"> <img alt=""
                                                                                                src="images/product/rp04.jpg" class="primary-image"> <img
                                                                                                alt="" src="images/product/rp01.jpg"
                                                                                                class="secondary-image"> </a>
                                                        </div>
                                                    </div>
                                                    <div class="product-text">
                                                        <div class="prodcut-name"> <a href="single-product.html">Copenhagen
                                                                Spitfire Chair</a> </div>
                                                        <div class="prodcut-ratting-price">
                                                            <div class="prodcut-ratting"> <a href="#"><i
                                                                        class="fa fa-star"></i></a> <a href="#"><i
                                                                        class="fa fa-star"></i></a> <a href="#"><i
                                                                        class="fa fa-star"></i></a> <a href="#"><i
                                                                        class="fa fa-star"></i></a> <a href="#"><i
                                                                        class="fa fa-star-o"></i></a> </div>
                                                            <div class="prodcut-price">
                                                                <div class="new-price"> $220 </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <!-- single product end-->
                                            </div>
                                            <div class="single-rectnt-slider">
                                                <!-- single product start-->
                                                <div class="single-product recent-single-product">
                                                    <div class="product-img">
                                                        <div class="single-prodcut-img  product-overlay pos-rltv">
                                                            <a href="single-product.html"> <img alt=""
                                                                                                src="images/product/rp01.jpg" class="primary-image"> <img
                                                                                                alt="" src="images/product/rp02.jpg"
                                                                                                class="secondary-image"> </a>
                                                        </div>
                                                    </div>
                                                    <div class="product-text">
                                                        <div class="prodcut-name"> <a href="single-product.html">Copenhagen
                                                                Spitfire Chair</a> </div>
                                                        <div class="prodcut-ratting-price">
                                                            <div class="prodcut-ratting"> <a href="#"><i
                                                                        class="fa fa-star"></i></a> <a href="#"><i
                                                                        class="fa fa-star"></i></a> <a href="#"><i
                                                                        class="fa fa-star"></i></a> <a href="#"><i
                                                                        class="fa fa-star"></i></a> <a href="#"><i
                                                                        class="fa fa-star-o"></i></a> </div>
                                                            <div class="prodcut-price">
                                                                <div class="new-price"> $220 </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <!-- single product end-->

                                                <!-- single product start-->
                                                <div class="single-product recent-single-product">
                                                    <div class="product-img">
                                                        <div class="single-prodcut-img  product-overlay pos-rltv">
                                                            <a href="single-product.html"> <img alt=""
                                                                                                src="images/product/rp03.jpg" class="primary-image"> <img
                                                                                                alt="" src="images/product/rp04.jpg"
                                                                                                class="secondary-image"> </a>
                                                        </div>
                                                    </div>
                                                    <div class="product-text">
                                                        <div class="prodcut-name"> <a href="single-product.html">Copenhagen
                                                                Spitfire Chair</a> </div>
                                                        <div class="prodcut-ratting-price">
                                                            <div class="prodcut-ratting"> <a href="#"><i
                                                                        class="fa fa-star"></i></a> <a href="#"><i
                                                                        class="fa fa-star"></i></a> <a href="#"><i
                                                                        class="fa fa-star"></i></a> <a href="#"><i
                                                                        class="fa fa-star"></i></a> <a href="#"><i
                                                                        class="fa fa-star-o"></i></a> </div>
                                                            <div class="prodcut-price">
                                                                <div class="new-price"> $220 </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <!-- single product end-->

                                                <!-- single product start-->
                                                <div class="single-product recent-single-product">
                                                    <div class="product-img">
                                                        <div class="single-prodcut-img  product-overlay pos-rltv">
                                                            <a href="single-product.html"> <img alt=""
                                                                                                src="images/product/rp02.jpg" class="primary-image"> <img
                                                                                                alt="" src="images/product/rp03.jpg"
                                                                                                class="secondary-image"> </a>
                                                        </div>
                                                    </div>
                                                    <div class="product-text">
                                                        <div class="prodcut-name"> <a href="single-product.html">Copenhagen
                                                                Spitfire Chair</a> </div>
                                                        <div class="prodcut-ratting-price">
                                                            <div class="prodcut-ratting"> <a href="#"><i
                                                                        class="fa fa-star"></i></a> <a href="#"><i
                                                                        class="fa fa-star"></i></a> <a href="#"><i
                                                                        class="fa fa-star"></i></a> <a href="#"><i
                                                                        class="fa fa-star"></i></a> <a href="#"><i
                                                                        class="fa fa-star-o"></i></a> </div>
                                                            <div class="prodcut-price">
                                                                <div class="new-price"> $220 </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <!-- single product end-->

                                                <!-- single product start-->
                                                <div class="single-product recent-single-product">
                                                    <div class="product-img">
                                                        <div class="single-prodcut-img  product-overlay pos-rltv">
                                                            <a href="single-product.html"> <img alt=""
                                                                                                src="images/product/rp04.jpg" class="primary-image"> <img
                                                                                                alt="" src="images/product/rp01.jpg"
                                                                                                class="secondary-image"> </a>
                                                        </div>
                                                    </div>
                                                    <div class="product-text">
                                                        <div class="prodcut-name"> <a href="single-product.html">Copenhagen
                                                                Spitfire Chair</a> </div>
                                                        <div class="prodcut-ratting-price">
                                                            <div class="prodcut-ratting"> <a href="#"><i
                                                                        class="fa fa-star"></i></a> <a href="#"><i
                                                                        class="fa fa-star"></i></a> <a href="#"><i
                                                                        class="fa fa-star"></i></a> <a href="#"><i
                                                                        class="fa fa-star"></i></a> <a href="#"><i
                                                                        class="fa fa-star-o"></i></a> </div>
                                                            <div class="prodcut-price">
                                                                <div class="new-price"> $220 </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <!-- single product end-->
                                            </div>
                                        </div>

                                    </aside>
                                    <!--single aside end-->

                                    <!--single aside start-->
                                    <aside class="single-aside add-aside">
                                        <a href="single-product.html"><img src="images/banner/add.jpg" alt=""></a>
                                    </aside>
                                    <!--single aside end-->
                                </div>
                            </div>
                            <!--shop sidebar end-->

                            <!--main-shop-product start-->
                            <div class="col-lg-9 col-md-8 order-1">
                                <div class="single-blog-body">
                                    <div class="single-blog sb-2 mb-30">
                                        <div class="blog-img pos-rltv product-overlay">
                                            <a href="#"><img src="${blog.thumbnail}" alt=""></a>
                                    </div>
                                    <div class="blog-content">
                                        <div class="blog-title">
                                            <h5 class="uppercase font-bold">${blog.title}</h5>
                                            <div class="like-comments-date">
                                                <ul>
                                                    <li><i class="zmdi zmdi-favorite-outline"></i> 24 Likes</li>
                                                    <li><i class="zmdi zmdi-comment-outline"></i> 24 Comments</li>
                                                    <li class="blog-date"><i class="zmdi zmdi-calendar-alt"></i> ${blog.updatedDate}</li>
                                                </ul>
                                            </div>
                                            <div class="blog-text">
                                                <p>${blog.content}</p>
                                            </div>
                                        </div>

                                        <!-- Related Posts Section -->
                                        <div class="related-post mt-30">
                                            <h5 class="uppercase sb-title">Related Blogs</h5>
                                            <div class="total-blog-3">
                                                <c:forEach var="relatedBlog" items="${relatedBlogs}">
                                                    <div class="blog-item">
                                                        <div class="single-blog">
                                                            <div class="blog-img pos-rltv product-overlay">
                                                                <a href="blog-details.jsp?id=${relatedBlog.id}">
                                                                    <img src="${relatedBlog.image}" alt="">
                                                                </a>
                                                            </div>
                                                            <div class="blog-content">
                                                                <div class="blog-title">
                                                                    <h5 class="uppercase font-bold">
                                                                        <a href="blog-details.jsp?id=${relatedBlog.id}">
                                                                            ${relatedBlog.title}
                                                                        </a>
                                                                    </h5>
                                                                    <div class="like-comments-date">
                                                                        <ul>
                                                                            <li><i class="zmdi zmdi-favorite-outline"></i> ${relatedBlog.likes} Likes</li>
                                                                            <li><i class="zmdi zmdi-comment-outline"></i> ${relatedBlog.commentsCount} Comments</li>
                                                                            <li class="blog-date"><i class="zmdi zmdi-calendar-alt"></i> ${relatedBlog.datePosted}</li>
                                                                        </ul>
                                                                    </div>
                                                                    <div class="blog-text">
                                                                        <p>${relatedBlog.briefInfo}</p>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </c:forEach>
                                            </div>
                                        </div>

                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                                                                    <div class="comments-area fix mt-20">
                            <h5 class="uppercase sb-title">Comments Area</h5>
                            <div class="comments-body">
                                <ul>
                                    <li class="signle-comments">
                                        <img src="images/blog/author.jpg" alt="">
                                        <div class="commets-text">
                                            <h5>JOHN NGUYEN</h5>
                                            <span>July 15 , 2022</span> <span>, at 2:39 am</span>
                                            <p>Exercitation photo booth stumptown tote bag Banksy, elit
                                                small batch freegan sed.</p>
                                        </div>
                                        <div class="replay"><a href="#">Replay</a></div>
                                    </li>
                                    <li class="signle-comments">
                                        <img src="images/blog/demo.jpg" alt="">
                                        <div class="commets-text">
                                            <h5>JOHN NGUYEN</h5>
                                            <span>July 15 , 2022</span> <span>, at 2:39 am</span>
                                            <p>Exercitation photo booth stumptown tote bag Banksy, elit
                                                small batch freegan sed.</p>
                                        </div>
                                        <div class="replay"><a href="#">Replay</a></div>
                                    </li>
                                    <li class="signle-comments">
                                        <img src="images/blog/author.jpg" alt="">
                                        <div class="commets-text">
                                            <h5>JOHN NGUYEN</h5>
                                            <span>July 15 , 2022</span> <span>, at 2:39 am</span>
                                            <p>Exercitation photo booth stumptown tote bag Banksy, elit
                                                small batch freegan sed.</p>
                                        </div>
                                        <div class="replay"><a href="#">Replay</a></div>
                                    </li>
                                </ul>
                            </div>
                        </div>
                        <div class="leave-through-area clearfix mt-40">
                            <h5 class="uppercase sb-title">Leave your thought</h5>
                            <div class="row">
                                <form class="row" action="https://htmldemo.net/clothing/clothing/mail.php" method="post">
                                    <div class="col-lg-6">
                                        <div class="input-box mb-20">
                                            <input name="name" class="info" placeholder="Name*" type="text">
                                        </div>
                                    </div>
                                    <div class="col-lg-6">
                                        <div class="input-box mb-20">
                                            <input name="name" class="info" placeholder="Email"
                                                   type="email">
                                        </div>
                                    </div>
                                    <div class="col-lg-6">
                                        <div class="input-box mb-20">
                                            <input name="name" class="info" placeholder="Phone" type="text">
                                        </div>
                                    </div>
                                    <div class="col-lg-6">
                                        <div class="input-box mb-20">
                                            <input name="name" class="info" placeholder="Country"
                                                   type="text">
                                        </div>
                                    </div>
                                    <div class="col-lg-12">
                                        <div class="input-box mb-20">
                                            <textarea name="message" class="area-tex"
                                                      placeholder="Your Message*"></textarea>
                                        </div>
                                    </div>
                                    <div class="col-lg-12">
                                        <div class="input-box">
                                            <button name="submit" class="sbumit-btn" type="submit">Post Commetns</button>
                                            <p class="form-messege"></p>
                                        </div>
                                    </div>

                                </form>
                            </div>
                        </div>
                </div>
            </div>
            <!--main-shop-product start-->
        </div>
    </div>
</div>
</div>
<!--single blog main area are end-->

<!-- footer area start-->
<jsp:include page="../common/blog/footer-blog.jsp"></jsp:include>
    <!--footer bottom area end-->

</div>
<!-- Body main wrapper end -->

<!-- Placed js at the end of the document so the pages load faster -->

<!-- jquery latest version -->
<jsp:include page="../common/blog/js-blog.jsp"></jsp:include>

</body>


<!-- Mirrored from htmldemo.net/clothing/clothing/blog-full-right.html by HTTrack Website Copier/3.x [XR&CO'2014], Sat, 01 Feb 2025 03:37:52 GMT -->
</html>
