<%-- 
    Document   : productdetails
    Created on : Feb 11, 2025, 12:53:14 PM
    Author     : binh
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
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
    List<String> productImages = (List<String>) request.getAttribute("productImages");
    Map<Integer, String> colorThumbnails = (Map<Integer, String>) request.getAttribute("colorThumbnails");
    Map<String, Integer> variationStock = (Map<String, Integer>) request.getAttribute("variationStock");
    Integer defaultColorId = (Integer) request.getAttribute("defaultColorId");
    Integer defaultSizeId = (Integer) request.getAttribute("defaultSizeId");
%>
<!DOCTYPE html>
<html class="no-js" lang="en">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="x-ua-compatible" content="ie=edge">
        <title>Single Products || Clothing</title>
        <meta name="description" content="Clothing – eCommerce Fashion Template is a clean and elegant design – suitable for selling clothing, fashion, high fashion, men fashion, women fashion, accessories, digital, kids, watches, jewelries, shoes, kids, furniture, sports, tools….. It has a fully responsive width adjusts automatically to any screen size or resolution.">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <link rel="shortcut icon" type="image/x-icon" href="images/icons/favicon.png">

        <!-- Include thư viện Toastify -->
        <link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/toastify-js/src/toastify.min.css">
        <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/toastify-js"></script>

        <jsp:include page="../common/home/css-home.jsp"></jsp:include>
        <style>
            /* Custom CSS cho trang chi tiết sản phẩm */
            .product-details-container {
                padding: 30px 0;
            }
            .product-details-img {
                text-align: center;
            }
            .cart-plus-minus {
                display: flex;
                align-items: center;
            }
            .qtybutton {
                cursor: pointer;
                background-color: #f8f9fa;
                border: 1px solid #ced4da;
                width: 35px;
                height: 35px;
                text-align: center;
                line-height: 33px;
                font-size: 18px;
            }
            .cart-plus-minus-box {
                max-width: 60px;
                text-align: center;
                border: 1px solid #ced4da;
                margin: 0 5px;
            }
            .action-buttons {
                display: flex;
                gap: 15px;
                margin-top: 20px;
            }
            .action-buttons .btn {
                min-width: 180px;
                font-weight: bold;
                text-transform: uppercase;
            }
        </style>
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
                        <div class="col-lg-7 product-details-img">
                            <div class="portfolio-thumbnil-area mb-40">
                                <div class="tab-content active-portfolio-area">
                                    <div role="tabpanel" class="tab-pane active" id="view1">
                                        <div class="portfolio-big-img text-center">
                                            <img src="${thumbnail}" alt="${product.productName}" id="main-product-image" 
                                                 style="max-height: 450px; object-fit: contain; margin: 0 auto;">
                                        </div>
                                    </div>
                                </div>
                                <div class="product-more-views mt-3">
                                    <div class="tab_thumbnail" data-tabs="tabs">
                                        <ul class="nav tabs portfolio-thumbnil d-flex flex-wrap justify-content-center" 
                                            style="list-style: none; padding: 0;">
                                            <c:forEach var="image" items="${productImages}" varStatus="loop">
                                                <li style="width: 80px; height: 80px; margin: 5px;">
                                                    <a class="${loop.index == 0 ? 'active' : ''}" href="#" 
                                                       onclick="setMainImage('${image}'); return false;"
                                                       style="display: block; border: 1px solid #ddd; padding: 2px; border-radius: 4px;">
                                                        <img src="${image}" alt="${product.productName} image ${loop.index + 1}" 
                                                             style="width: 100%; height: 100%; object-fit: cover;">
                                                    </a>
                                                </li>
                                            </c:forEach>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-5">
                            <div class="single-product-description">
                                <div class="sp-top-des">
                                    <h3>${product.productName}</h3>
                                    <div class="prodcut-ratting-price">
                                        <div class="prodcut-price">
                                            <div class="new-price">VND ${product.price}</div>
                                        </div>
                                    </div>
                                </div>

                                <div class="sp-des">
                                    <p>${product.description}</p>
                                </div>

                                <div class="sp-bottom-des">
                                    <div class="single-product-option">
                                        <div class="sort product-type mb-20">
                                            <label>Color: </label>
                                            
                                            <!-- Color count: ${colors.size()} -->
                                            
                                            <div class="color-selector d-flex flex-wrap mt-2">
                                                <c:forEach var="color" items="${colors}" varStatus="status">
                                                    <div class="color-item me-3 mb-2" style="text-align: center;">
                                                        <input type="radio" name="color" id="color-${color.colorID}" value="${color.colorID}" 
                                                               style="display: none;" 
                                                               onchange="updateStockStatus(); updateProductImages(${color.colorID});" 
                                                               ${color.colorID == defaultColorId ? 'checked' : ''}>
                                                        <label for="color-${color.colorID}" 
                                                               style="width: 40px; height: 40px; 
                                                                      border-radius: 50%; display: block; cursor: pointer; 
                                                                      border: 2px solid ${color.colorID == defaultColorId ? '#007bff' : '#ddd'};
                                                                      background-color: ${color.colorID == 1 ? '#FFFFFF' : 
                                                                                        color.colorID == 2 ? '#0000FF' :
                                                                                        color.colorID == 3 ? '#000000' :
                                                                                        color.colorID == 4 ? '#808080' :
                                                                                        color.colorID == 5 ? '#008000' :
                                                                                        color.colorID == 6 ? '#A52A2A' :
                                                                                        color.colorID == 7 ? '#FFA500' :
                                                                                        color.colorID == 8 ? '#FFC0CB' :
                                                                                        color.colorID == 9 ? '#D2B48C' :
                                                                                        color.colorID == 10 ? '#FF0000' : '#CCCCCC'};">
                                                        </label>
                                                        <div class="color-name" style="font-size: 12px; margin-top: 5px;">
                                                            ${color.colorName}
                                                        </div>
                                                    </div>
                                                </c:forEach>
                                            </div>
                                        </div>

                                        <div class="sort product-type mb-20">
                                            <label>Size: </label>
                                            
                                            <!-- Size count: ${sizes.size()} -->
                                            
                                            <div class="size-selector d-flex flex-wrap mt-2">
                                                <c:forEach var="size" items="${sizes}" varStatus="status">
                                                    <div class="size-item me-2 mb-2">
                                                        <input type="radio" name="size" id="size-${size.sizeID}" value="${size.sizeID}" 
                                                               style="display: none;"
                                                               onchange="updateStockStatus();"
                                                               ${size.sizeID == defaultSizeId ? 'checked' : ''}>
                                                        <label for="size-${size.sizeID}" 
                                                               style="min-width: 40px; height: 40px; display: flex; align-items: center; 
                                                                      justify-content: center; cursor: pointer; 
                                                                      border: 1px solid ${size.sizeID == defaultSizeId ? '#007bff' : '#ddd'}; 
                                                                      background-color: ${size.sizeID == defaultSizeId ? '#007bff' : '#fff'};
                                                                      color: ${size.sizeID == defaultSizeId ? '#fff' : '#333'};
                                                                      padding: 0 10px;">
                                                            ${size.sizeName}
                                                        </label>
                                                    </div>
                                                </c:forEach>
                                            </div>
                                        </div>
                                        
                                        <div id="stockStatusContainer" class="mb-3">
                                            <div id="inStockMessage" style="display: none; color: green; font-weight: 500;">
                                                <i class="fa fa-check-circle"></i> In Stock
                                            </div>
                                            <div id="lowStockMessage" style="display: none; color: orange; font-weight: 500;">
                                                <i class="fa fa-exclamation-triangle"></i> Low Stock - Only <span id="stockCount"></span> remaining
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <div class="quantity-area">
                                        <label>Qty :</label>
                                        <div class="cart-quantity">
                                            <div class="product-qty">
                                                <div class="cart-plus-minus">
                                                    <div class="dec qtybutton">-</div>
                                                    <input id="visible-quantity" type="text" value="1" class="cart-plus-minus-box">
                                                    <div class="inc qtybutton">+</div>
                                                </div>
                                            </div>                                        
                                        </div>
                                    </div>
                                    
                                    <form action="cart" method="post" class="add">
                                        <input type="hidden" name="action" value="add">
                                        <input type="hidden" name="productId" value="${product.productID}">
                                        <input type="hidden" name="colorId" id="selected-color">
                                        <input type="hidden" name="sizeId" id="selected-size">
                                        <input type="hidden" name="quantity" id="selected-quantity">
                                        
                                        <div class="action-buttons">
                                            <button type="submit" class="btn btn-lg btn-primary">
                                                <i class="fa fa-shopping-cart"></i> Add to Cart
                                            </button>
                                            <a href="cart" class="btn btn-lg btn-outline-dark">
                                                <i class="fa fa-credit-card"></i> View Cart
                                            </a>
                                        </div>
                                    </form>
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
                                    
                                </div>
                                <div class="clearfix"></div>
                                <div class="col-lg-12">
                                    <div class="content-tab-product-category">
                                        <!-- Tab panes -->
                                      
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>    
            <!--descripton-area end--> 

            <!--new arrival area start-->
           
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

            <script>
                // Tách riêng dữ liệu từ server thành biến JavaScript
                const colorsSize = "${colors.size()}";
                const sizesSize = "${sizes.size()}";
                const productName = "${product.productName}";
                
                // Debug info 
                console.log("Available Colors:", colorsSize);
                console.log("Available Sizes:", sizesSize);
                
                // Color thumbnail mapping for JavaScript
                const colorThumbnails = {};
                <c:forEach var="entry" items="${colorThumbnails}">
                    colorThumbnails[${entry.key}] = "${entry.value}";
                </c:forEach>
                
                // Color -> ProductImgID mapping
                const colorToImgMap = {};
                <c:forEach var="entry" items="${colorToImgMap}">
                    colorToImgMap[${entry.key}] = ${entry.value};
                </c:forEach>
                
                // Variation stock data
                let stockData = {};
                try {
                    const variationStockJson = '<c:out value="${variationStock}" escapeXml="false"/>';
                    stockData = JSON.parse(variationStockJson.replace(/&quot;/g, '"'));
                } catch (e) {
                    console.error("Error parsing stock data:", e);
                }
                
                // Function to set main image
                function setMainImage(imgSrc) {
                    const mainImage = document.getElementById('main-product-image');
                    if (mainImage) {
                        mainImage.src = imgSrc;
                    }
                }
                
                // Function to update product images when color is changed
                function updateProductImages(colorId) {
                    console.log("Updating product images for color ID:", colorId);
                    
                    // Get the thumbnail for this color
                    const thumbnail = colorThumbnails[colorId];
                    if (!thumbnail) {
                        console.error("No thumbnail found for color ID:", colorId);
                        return;
                    }
                    
                    // Get the product_img_ID for this color
                    const imgId = colorToImgMap[colorId];
                    if (!imgId) {
                        console.error("No image ID found for color ID:", colorId);
                        return;
                    }
                    
                    // Clear existing thumbnail list
                    const thumbnailList = document.querySelector('.portfolio-thumbnil');
                    thumbnailList.innerHTML = '';
                    
                    // Use AJAX to get the images for this variation
                    fetch('product-images?imgId=' + imgId)
                        .then(response => response.json())
                        .then(data => {
                            // Update main image
                            if (data.images && data.images.length > 0) {
                                setMainImage(data.images[0]);
                                
                                // Populate thumbnail list
                                data.images.forEach((img, index) => {
                                    const listItem = document.createElement('li');
                                    listItem.style.width = '80px';
                                    listItem.style.height = '80px';
                                    listItem.style.margin = '5px';
                                    
                                    const link = document.createElement('a');
                                    link.className = index === 0 ? 'active' : '';
                                    link.href = '#';
                                    link.onclick = function() { setMainImage(img); return false; };
                                    link.style.display = 'block';
                                    link.style.border = '1px solid #ddd';
                                    link.style.padding = '2px';
                                    link.style.borderRadius = '4px';
                                    
                                    const imgElement = document.createElement('img');
                                    imgElement.src = img;
                                    imgElement.alt = productName + ' image ' + (index + 1);
                                    imgElement.style.width = '100%';
                                    imgElement.style.height = '100%';
                                    imgElement.style.objectFit = 'cover';
                                    
                                    link.appendChild(imgElement);
                                    listItem.appendChild(link);
                                    thumbnailList.appendChild(listItem);
                                });
                            }
                        })
                        .catch(error => {
                            console.error('Error fetching product images:', error);
                            // Fallback to thumbnail
                            setMainImage(thumbnail);
                            
                            // Add single thumbnail to list
                            const listItem = document.createElement('li');
                            listItem.style.width = '80px';
                            listItem.style.height = '80px';
                            listItem.style.margin = '5px';
                            
                            const link = document.createElement('a');
                            link.className = 'active';
                            link.href = '#';
                            link.style.display = 'block';
                            link.style.border = '1px solid #ddd';
                            link.style.padding = '2px';
                            link.style.borderRadius = '4px';
                            
                            const imgElement = document.createElement('img');
                            imgElement.src = thumbnail;
                            imgElement.alt = productName + ' thumbnail';
                            imgElement.style.width = '100%';
                            imgElement.style.height = '100%';
                            imgElement.style.objectFit = 'cover';
                            
                            link.appendChild(imgElement);
                            listItem.appendChild(link);
                            thumbnailList.appendChild(listItem);
                        });
                    
                    // Update hidden field
                    document.getElementById('selected-color').value = colorId;
                }
                
                // Function to update stock status based on selected color and size
                function updateStockStatus() {
                    const selectedColor = document.querySelector('input[name="color"]:checked');
                    const selectedSize = document.querySelector('input[name="size"]:checked');
                    
                    if (selectedColor && selectedSize) {
                        const stockKey = selectedColor.value + '-' + selectedSize.value;
                        const stockContainer = document.getElementById('stockStatusContainer');
                        const inStockMsg = document.getElementById('inStockMessage');
                        const lowStockMsg = document.getElementById('lowStockMessage');
                        const outStockMsg = document.getElementById('outOfStockMessage');
                        const stockCountSpan = document.getElementById('stockCount');
                        const addToCartBtn = document.querySelector('form.add button[type="submit"]');
                        
                        console.log("Stock key:", stockKey, "Stock data:", stockData);
                        const qtyInStock = stockData[stockKey] || 0;
                        
                        // Show stock status container
                        stockContainer.style.display = 'block';
                        
                        // Reset all messages
                        inStockMsg.style.display = 'none';
                        lowStockMsg.style.display = 'none';
                        outStockMsg.style.display = 'none';
                        
                        // Update based on stock level
                        if (qtyInStock <= 0) {
                            outStockMsg.style.display = 'block';
                            addToCartBtn.disabled = true;
                        } else if (qtyInStock <= 5) {
                            lowStockMsg.style.display = 'block';
                            stockCountSpan.textContent = qtyInStock;
                            addToCartBtn.disabled = false;
                        } else {
                            inStockMsg.style.display = 'block';
                            addToCartBtn.disabled = false;
                        }
                    }
                }
                
                // Initialize page when DOM is loaded
                document.addEventListener('DOMContentLoaded', function() {
                    // Set initial values for hidden fields
                    const defaultColorInput = document.querySelector('input[name="color"]:checked');
                    const defaultSizeInput = document.querySelector('input[name="size"]:checked');
                    
                    if (defaultColorInput) {
                        document.getElementById('selected-color').value = defaultColorInput.value;
                    }
                    
                    if (defaultSizeInput) {
                        document.getElementById('selected-size').value = defaultSizeInput.value;
                    }
                    
                    document.getElementById('selected-quantity').value = document.getElementById('visible-quantity').value;
                    
                    // Form submission handling
                    document.querySelector('form.add').addEventListener('submit', function(e) {
                        const colorId = document.getElementById('selected-color').value;
                        const sizeId = document.getElementById('selected-size').value;
                        
                        if (!colorId || !sizeId) {
                            e.preventDefault();
                            alert('Please select both color and size before adding to cart.');
                        }
                        
                        // Update quantity
                        document.getElementById('selected-quantity').value = document.getElementById('visible-quantity').value;
                    });
                    
                    // Quantity buttons
                document.querySelectorAll('.qtybutton').forEach(function(button) {
                    button.addEventListener('click', function(event) {
                        event.preventDefault();
                            const input = document.getElementById('visible-quantity');
                            let currentVal = parseInt(input.value, 10) || 1;
                        if (this.classList.contains('inc')) {
                            input.value = currentVal + 1;
                        } else if (this.classList.contains('dec') && currentVal > 1) {
                            input.value = currentVal - 1;
                        }
                            // Update hidden quantity field
                            document.getElementById('selected-quantity').value = input.value;
                        });
                    });
                    
                    // Color selector event listeners
                    document.querySelectorAll('input[name="color"]').forEach(radio => {
                        radio.addEventListener('change', function() {
                            // Reset all labels
                            document.querySelectorAll('label[for^="color-"]').forEach(label => {
                                label.style.border = '2px solid #ddd';
                            });
                            // Highlight selected
                            document.querySelector('label[for="color-' + this.value + '"]').style.border = '2px solid #007bff';
                        });
                    });
                    
                    // Size selector event listeners
                    document.querySelectorAll('input[name="size"]').forEach(radio => {
                        radio.addEventListener('change', function() {
                            // Reset all labels
                            document.querySelectorAll('label[for^="size-"]').forEach(label => {
                                label.style.border = '1px solid #ddd';
                                label.style.backgroundColor = '#fff';
                                label.style.color = '#333';
                            });
                            // Highlight selected
                            const selectedLabel = document.querySelector('label[for="size-' + this.value + '"]');
                            selectedLabel.style.border = '1px solid #007bff';
                            selectedLabel.style.backgroundColor = '#007bff';
                            selectedLabel.style.color = '#fff';
                        });
                    });
                    
                    // Update stock status initially
                    updateStockStatus();
                });
            </script>
            
            <script>
                // Handle toast messages from session
            <% 
                        String toastMessage = (String) session.getAttribute("toastMessage");
                String toastType = (String) session.getAttribute("toastType");
                        if (toastMessage != null) { 
            %>
                    Toastify({
                        text: "<%= toastMessage %>",
                        duration: 3000,
                        close: true,
                        gravity: "top",
                        position: "right",
                        backgroundColor: "<%= toastType != null && toastType.equals("success") ? "#4CAF50" : "#f44336" %>",
                        stopOnFocus: true
                    }).showToast();
            <% 
                    // Remove toast attributes after displaying
                            session.removeAttribute("toastMessage");
                    session.removeAttribute("toastType");
                } 
                %>
        </script>

        <!-- Script để ánh xạ tên màu với mã màu CSS -->
        <script>
            // Map tên màu với mã màu CSS
            const colorMap = {
                'White': '#FFFFFF',
                'Black': '#000000',
                'Red': '#FF0000',
                'Blue': '#0000FF',
                'Green': '#008000',
                'Grey': '#808080',
                'Brown': '#A52A2A',
                'Orange': '#FFA500',
                'Pink': '#FFC0CB',
                'Tan': '#D2B48C'
            };
            
            // Áp dụng màu cho các label dựa vào tên màu
            document.addEventListener('DOMContentLoaded', function() {
                document.querySelectorAll('.color-display').forEach(function(label) {
                    const colorName = label.getAttribute('data-color-name');
                    const colorCode = colorMap[colorName] || '#CCCCCC'; // Mã màu mặc định nếu không tìm thấy
                    label.style.backgroundColor = colorCode;
                });
            });
        </script>

    </body>


    <!-- Mirrored from htmldemo.net/clothing/clothing/single-product.html by HTTrack Website Copier/3.x [XR&CO'2014], Sat, 01 Feb 2025 03:37:47 GMT -->
</html>
</html>