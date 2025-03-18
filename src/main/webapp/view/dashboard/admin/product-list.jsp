<%-- Document : product-list Created on : Mar 17, 2025, 4:44:11 PM Author : PC --%>

    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <%@page contentType="text/html" pageEncoding="UTF-8" %>
                <!DOCTYPE html>
                <html lang="en" data-theme="light">

                <head>
                    <meta charset="UTF-8">
                    <meta name="viewport" content="width=device-width, initial-scale=1.0">
                    <title>Store 24 - Manage Products</title>
                    <link rel="icon" type="image/png" href="assets/images/favicon.png" sizes="16x16">
                    <!-- CSS here -->
                    <jsp:include page="../../common/dashboard/css-dashboard.jsp"></jsp:include>
                </head>

                <body>
                    <!-- Sidebar -->
                    <jsp:include page="../../common/dashboard/sidebar-dashboard.jsp"></jsp:include>

                    <!-- Header -->
                    <jsp:include page="../../common/dashboard/header-dashboard.jsp"></jsp:include>

                    <c:url value="/manage-products" var="paginationUrl">
                        <c:param name="action" value="list" />
                        <c:if test="${not empty param.category}">
                            <c:param name="category" value="${param.category}" />
                        </c:if>
                        <c:if test="${not empty param.collection}">
                            <c:param name="collection" value="${param.collection}" />
                        </c:if>
                        <c:if test="${not empty param.minPrice}">
                            <c:param name="minPrice" value="${param.minPrice}" />
                        </c:if>
                        <c:if test="${not empty param.maxPrice}">
                            <c:param name="maxPrice" value="${param.maxPrice}" />
                        </c:if>
                        <c:if test="${not empty param.search}">
                            <c:param name="search" value="${param.search}" />
                        </c:if>
                    </c:url>

                    <div class="dashboard-main-body">
                        <div class="d-flex flex-wrap align-items-center justify-content-between gap-3 mb-24">
                            <h6 class="fw-semibold mb-0">Products List</h6>
                            <ul class="d-flex align-items-center gap-2">
                                <li class="fw-medium">
                                    <a href="index.html" class="d-flex align-items-center gap-1 hover-text-primary">
                                        <iconify-icon icon="solar:home-smile-angle-outline"
                                            class="icon text-lg"></iconify-icon>
                                        Dashboard
                                    </a>
                                </li>
                                <li>-</li>
                                <li class="fw-medium">Products List</li>
                            </ul>
                        </div>

                        <div class="card h-100 p-0 radius-12">
                            <div
                                class="card-header border-bottom bg-base py-16 px-24 d-flex align-items-center flex-wrap gap-3 justify-content-between">
                                <div class="d-flex align-items-center flex-wrap gap-3">
                                    <form action="${pageContext.request.contextPath}/manage-products" method="GET"
                                        class="d-flex align-items-center gap-3">
                                        <div class="navbar-search">
                                            <input type="text" class="bg-base h-40-px w-auto" name="search"
                                                placeholder="Search" value='${param.search}'>
                                            <iconify-icon icon="ion:search-outline" class="icon"></iconify-icon>
                                        </div>

                                        <select class="form-select form-select-sm w-auto ps-12 py-6 radius-12 h-40-px"
                                            name="category">
                                            <option value="">All Categories</option>
                                            <c:forEach var="category" items="${categories}">
                                                <option value="${category.categoryID}"
                                                    ${param.category==category.categoryID ? 'selected' : '' }>
                                                    ${category.categoryName}</option>
                                            </c:forEach>
                                        </select>

                                        <select class="form-select form-select-sm w-auto ps-12 py-6 radius-12 h-40-px"
                                            name="collection">
                                            <option value="">All Collections</option>
                                            <c:forEach var="collection" items="${collections}">
                                                <option value="${collection.collectionID}"
                                                    ${param.collection==collection.collectionID ? 'selected' : '' }>
                                                    ${collection.collectionName}</option>
                                            </c:forEach>
                                        </select>

                                        <div class="d-flex align-items-center">
                                            <input type="number"
                                                class="form-control form-control-sm w-auto ps-12 py-6 radius-12 h-40-px"
                                                name="minPrice" placeholder="Min Price" value="${param.minPrice}">
                                            <span class="mx-2">-</span>
                                            <input type="number"
                                                class="form-control form-control-sm w-auto ps-12 py-6 radius-12 h-40-px"
                                                name="maxPrice" placeholder="Max Price" value="${param.maxPrice}">
                                        </div>

                                        <select class="form-select form-select-sm w-auto ps-12 py-6 radius-12 h-40-px"
                                            name="status">
                                            <option value="">All Status</option>
                                            <option value="1" ${param.status=='1' ? 'selected' : '' }>Active</option>
                                            <option value="0" ${param.status=='0' ? 'selected' : '' }>Inactive</option>
                                        </select>

                                        <button type="submit" class="btn btn-primary h-40-px radius-12">Search</button>
                                    </form>
                                </div>

                                <a href="${pageContext.request.contextPath}/manage-products?action=addform"
                                    class="btn btn-primary text-sm btn-sm px-12 py-12 radius-8 d-flex align-items-center gap-2">
                                    <iconify-icon icon="ic:baseline-plus"
                                        class="icon text-xl line-height-1"></iconify-icon>
                                    Add New Product
                                </a>
                            </div>
                            <div class="card-body p-24">
                                <c:if test="${not empty successMessage}">
                                    <div class="alert alert-success" role="alert">
                                        ${successMessage}
                                    </div>
                                </c:if>
                                <c:if test="${not empty errorMessage}">
                                    <div class="alert alert-danger" role="alert">
                                        ${errorMessage}
                                    </div>
                                </c:if>

                                <div class="table-responsive scroll-sm">
                                    <table class="table bordered-table sm-table mb-0">
                                        <thead>
                                            <tr>
                                                <th scope="col">ID</th>
                                                <th scope="col">Name</th>
                                                <th scope="col">Price</th>
                                                <th scope="col">Category</th>
                                                <th scope="col">Collection</th>
                                                <th scope="col" class="text-center">Status</th>
                                                <th scope="col" class="text-center">Action</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="product" items="${products}">
                                                <tr>
                                                    <td>${product.productID}</td>
                                                    <td>${product.productName}</td>
                                                    <td>
                                                        <fmt:formatNumber value="${product.price}" type="currency"
                                                            currencySymbol="$" />
                                                    </td>
                                                    <td>
                                                        <c:forEach var="category" items="${categories}">
                                                            <c:if test="${category.categoryID == product.categoryID}">
                                                                ${category.categoryName}
                                                            </c:if>
                                                        </c:forEach>
                                                    </td>
                                                    <td>
                                                        <c:forEach var="collection" items="${collections}">
                                                            <c:if
                                                                test="${collection.collectionID == product.collectionID}">
                                                                ${collection.collectionName}
                                                            </c:if>
                                                        </c:forEach>
                                                    </td>
                                                    <td class="text-center">
                                                        <c:choose>
                                                            <c:when test="${product.status == 1}">
                                                                <span class="badge bg-success">Active</span>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <span class="badge bg-danger">Inactive</span>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </td>
                                                    <td class="text-center">
                                                        <div
                                                            class="d-flex align-items-center gap-10 justify-content-center">
                                                            <button type="button"
                                                                class="bg-success-focus text-success-600 bg-hover-success-200 fw-medium w-40-px h-40-px d-flex justify-content-center align-items-center rounded-circle"
                                                                onclick="window.location.href = '${pageContext.request.contextPath}/manage-products?action=details&id=${product.productID}'">
                                                                <iconify-icon icon="lucide:edit"
                                                                    class="menu-icon"></iconify-icon>
                                                            </button>
                                                            <!-- Thay đổi nút xóa thành nút thay đổi trạng thái -->
                                                            <button type="button"
                                                                class="${product.status == 1 ? 'bg-danger-focus bg-hover-danger-200 text-danger-600' : 'bg-success-focus bg-hover-success-200 text-success-600'} fw-medium w-40-px h-40-px d-flex justify-content-center align-items-center rounded-circle"
                                                                onclick="confirmChangeStatus(${product.productID}, ${product.status})">
                                                                <iconify-icon
                                                                    icon="${product.status == 1 ? 'mdi:power-off' : 'mdi:power'}"
                                                                    class="menu-icon"></iconify-icon>
                                                            </button>
                                                        </div>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>

                                <div class="d-flex align-items-center justify-content-between flex-wrap gap-2 mt-24">
                                    <ul
                                        class="pagination d-flex flex-wrap align-items-center gap-2 justify-content-center">
                                        <c:if test="${currentPage > 1}">
                                            <li class="page-item">
                                                <a class="page-link bg-neutral-200 text-secondary-light fw-semibold radius-8 border-0 d-flex align-items-center justify-content-center h-32-px w-32-px text-md"
                                                    href="${paginationUrl}&page=${currentPage - 1}"><iconify-icon
                                                        icon="ep:d-arrow-left" class=""></iconify-icon>
                                                </a>
                                            </li>
                                        </c:if>
                                        <c:forEach begin="1" end="${totalPages}" var="i">
                                            <li class="page-item">
                                                <a class="page-link bg-neutral-200 text-secondary-emphasis fw-semibold radius-8 border-0 d-flex align-items-center justify-content-center h-32-px w-32-px"
                                                    href="${paginationUrl}&page=${i}">${i}
                                                </a>
                                            </li>
                                        </c:forEach>
                                        <c:if test="${currentPage < totalPages}">
                                            <li class="page-item">
                                                <a class="page-link bg-neutral-200 text-secondary-light fw-semibold radius-8 border-0 d-flex align-items-center justify-content-center h-32-px w-32-px text-md"
                                                    href="${paginationUrl}&page=${currentPage + 1}"><iconify-icon
                                                        icon="ep:d-arrow-right" class=""></iconify-icon>
                                                </a>
                                            </li>
                                        </c:if>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- JS here -->
                    <jsp:include page="../../common/dashboard/js-dashboard.jsp"></jsp:include>

                    <script>
                        function confirmChangeStatus(productId, currentStatus) {
                            let message = currentStatus == 1 ?
                                'Are you sure you want to deactivate this product?' :
                                'Are you sure you want to activate this product?';

                            if (confirm(message)) {
                                window.location.href = '${pageContext.request.contextPath}/manage-products?action=changestatus&id=' + productId + '&status=' + currentStatus;
                            }
                        }
                    </script>
                </body>

                </html>