<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en" data-theme="light">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Add Variation</title>
        <link rel="icon" type="image/png" href="assets/images/favicon.png" sizes="16x16">
        <jsp:include page="../../common/dashboard/css-dashboard.jsp"></jsp:include>
    </head>
    <body>
        <jsp:include page="../../common/dashboard/sidebar-dashboard.jsp"></jsp:include>
        <jsp:include page="../../common/dashboard/header-dashboard.jsp"></jsp:include>

        <div class="dashboard-main-body">
            <div class="d-flex flex-wrap align-items-center justify-content-between gap-3 mb-24">
                <h6 class="fw-semibold mb-0">Add New Variation</h6>
                <ul class="d-flex align-items-center gap-2">
                    <li class="fw-medium">
                        <a href="index.html" class="d-flex align-items-center gap-1 hover-text-primary">
                            <iconify-icon icon="solar:home-smile-angle-outline" class="icon text-lg"></iconify-icon>
                            Dashboard
                        </a>
                    </li>
                    <li>-</li>
                    <li class="fw-medium">Add Variation</li>
                </ul>
            </div>

            <div class="card h-100 p-0 radius-12">
                <div class="card-header border-bottom bg-base py-16 px-24">
                    <h6 class="fw-semibold mb-0">Variation Information</h6>
                </div>
                <div class="card-body p-24">
                    <form action="${pageContext.request.contextPath}/manage-variation" method="POST" enctype="multipart/form-data">
                        <input type="hidden" name="action" value="add">
                        <input type="hidden" name="productId" value="${productId}">
                        
                        <div class="row mb-3">
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label for="colorId" class="form-label">Color</label>
                                    <select class="form-select" id="colorId" name="colorId" required>
                                        <c:forEach var="color" items="${colorList}">
                                            <option value="${color.colorID}">${color.colorName}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                                
                                <div class="mb-3">
                                    <label for="qtyInStock" class="form-label">Quantity in Stock</label>
                                    <input type="number" class="form-control" id="qtyInStock" name="qtyInStock" required>
                                </div>
                            </div>
                            
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label for="sizeId" class="form-label">Size</label>
                                    <select class="form-select" id="sizeId" name="sizeId" required>
                                        <c:forEach var="size" items="${sizeList}">
                                            <option value="${size.sizeID}">${size.sizeName}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                                
                                <div class="mb-3">
                                    <label for="productImg1" class="form-label">Product Image 1</label>
                                    <input type="file" class="form-control" id="productImg1" name="productImg1" accept="image/*" required>
                                </div>
                                <div class="mb-3">
                                    <label for="productImg2" class="form-label">Product Image 2</label>
                                    <input type="file" class="form-control" id="productImg2" name="productImg2" accept="image/*">
                                </div>
                                <div class="mb-3">
                                    <label for="productImg3" class="form-label">Product Image 3</label>
                                    <input type="file" class="form-control" id="productImg3" name="productImg3" accept="image/*">
                                </div>
                            </div>
                        </div>
                        
                        <div class="d-flex justify-content-end gap-2">
                            <a href="${pageContext.request.contextPath}/manage-products" class="btn btn-secondary">Cancel</a>
                            <button type="submit" class="btn btn-primary">Add Variation</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        
        <jsp:include page="../../common/dashboard/js-dashboard.jsp"></jsp:include>
    </body>
</html> 