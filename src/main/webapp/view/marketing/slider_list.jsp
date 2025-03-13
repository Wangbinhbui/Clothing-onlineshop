<!-- meta tags and other links -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en" data-theme="light">

    <!-- Mirrored from wowdash.wowtheme7.com/demo/blog.html by HTTrack Website Copier/3.x [XR&CO'2014], Mon, 03 Feb 2025 04:44:31 GMT -->
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Wowdash - Bootstrap 5 Admin Dashboard HTML Template</title>
        <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/assets/images/favicon.png" sizes="16x16">
        <!--CSS Here-->
        <jsp:include page="../../common/dashboard/css-dashboard.jsp"></jsp:include>
            <style>
                .description-column {
                max-width: 100%; /* Chiều rộng tối đa */
                max-height: 200px; /* Chiều cao tối đa */
                min-height: 150px; /* Đảm bảo chiều cao tối thiểu để ô luôn đủ lớn */
                display: flex;
                overflow: hidden; /* Ẩn phần nội dung vượt quá */
                display: -webkit-box;
                -webkit-line-clamp: 3; /* Giới hạn tối đa 3 dòng */
                -webkit-box-orient: vertical;
                overflow-y: auto;  /* Hiển thị thanh cuộn dọc khi nội dung dài */
                overflow-x: hidden; /* Ẩn thanh cuộn ngang */
                white-space: normal;
                cursor: pointer; /* Hiển thị con trỏ khi di chuột vào */
                padding: 10px; /* Giúp ô trông cân đối */
                word-wrap: break-word; /* Đảm bảo xuống dòng */
            }
            </style>
        </head>

        <body>
        <c:url value="/manage-story" var="paginationUrl">
            <c:param name="action" value="list" />
            <c:if test="${not empty param.type}">
                <c:param name="type" value="${param.type}" />
            </c:if>
            <c:if test="${not empty param.status}">
                <c:param name="status" value="${param.status}" />
            </c:if>
            <c:if test="${not empty param.search}">
                <c:param name="search" value="${param.search}" />
            </c:if>
        </c:url>
        <!--Sidebar-->
        <jsp:include page="../../common/dashboard/sidebar-dashboard.jsp"></jsp:include>
            <main class="dashboard-main">
                <!--header-->
            <jsp:include page="../../common/dashboard/header-dashboard.jsp"></jsp:include>
                <div class="dashboard-main-body">
                    <div class="d-flex flex-wrap align-items-center justify-content-between gap-3 mb-24">
                        <!--  <h6 class="fw-semibold mb-0">Sl</h6>-->
                        <ul class="d-flex align-items-center gap-2">
                            <li class="fw-medium">
                                <a href="index.html" class="d-flex align-items-center gap-1 hover-text-primary">
                                    <iconify-icon icon="solar:home-smile-angle-outline" class="icon text-lg"></iconify-icon>
                                    Dashboard
                                </a>
                            </li>
                            <li>-</li>
                            <li class="fw-medium">Slider</li>
                        </ul>
                    </div>
                    <!-- table here-->
                    <div class="dashboard__content-wrap">
                        <div class="dashboard__content-title">
                            <div class="title d-flex justify-content-between align-items-center">
                                <h4>Manage Sliders</h4>

                            </div>
                            <form action="${pageContext.request.contextPath}/manage-story" method="GET" class="mb-4">
                            <input type="hidden" name="action" value="list"/>
                            <div class="row mb-3">
                                <div class="col-md-4">
                                    <select class="form-select" id="statusFilter" name="status">
                                        <option value="">All Status</option>
                                        <option value="Active" ${param.status=='Active' ? 'selected'
                                                                 : '' }>Active</option>
                                        <option value="Inactive" ${param.status=='Inactive' ? 'selected'
                                                                   : '' }>Inactive</option>
                                    </select>
                                </div>
                                <div class="col-md-4">
                                    <input type="text" class="form-control" id="searchFilter"
                                           name="search" placeholder="Search sliders..."
                                           value="${param.search}">
                                </div>
                                <div class="col-md-3">
                                    <!-- Nút Filter -->
                                    <button type="submit" class="btn btn-primary d-flex align-items-center justify-content-center w-100 py-2" 
                                            style="background: linear-gradient(45deg, #007aff, #0056b3); border: none; border-radius: 8px;
                                            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1); transition: all 0.3s ease;">
                                        <i class="fa fa-filter me-2"></i> Filter
                                    </button>

                                    <!-- Nút Add Slider -->
                                    <a href="${pageContext.request.contextPath}/manage-story?action=add" 
                                       class="btn btn-success d-flex align-items-center justify-content-center w-100 py-2 mt-2"
                                       style="background: linear-gradient(45deg, #28a745, #218838); border: none; border-radius: 8px;
                                       box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1); transition: all 0.3s ease;">
                                        <i class="ri-add-circle-line me-2"></i> Add Slider
                                    </a>
                                </div>

                            </div>
                        </form>
                        <div class="row">
                            <div class="col-12">
                                <div class="dashboard__review-table">
                                    <table class="table table-borderless">
                                        <thead>
                                            <tr>
                                                <th style="width: 5%;">ID</th>
                                                <th style="width: 10%;">Image</th>
                                                <th style="width: 15%;">Title</th>
                                                <th style="width: 20%;">Backlink</th>
                                                <th style="width: 20%;">Status</th>
                                                <th style="width: 30%;">Description</th>

                                                <th style="width: 10%; text-align: center;">Action</th>
                                            </tr>
                                        </thead>

                                        <c:forEach var="story" items="${stories}">
                                            <tr>
                                                <td>${story.storyId}</td>
                                                <td>
                                                    <img src="${pageContext.request.contextPath}/${story.thumbnail}" 
                                                         alt="Story image" class="img-thumbnail" 
                                                         style="width: 100px; height: 60px; object-fit: cover;">
                                                </td>
                                                <td>${story.title}</td>
                                                <td>
                                                    <a href="${story.backlink}" target="_blank" class="text-primary">
                                                        ${story.backlink}
                                                    </a>
                                                </td>

                                                <td>
                                                    <span class="dashboard__quiz-result ${story.status == 'Active' ? 'text-success' : 'text-danger'}">
                                                        ${story.status}
                                                    </span>
                                                </td>
                                                <td class="description-column">
                                                    ${story.description}
                                                </td>
                                                <td>
                                                    <div class="dashboard__review-action d-flex align-items-center gap-2">
                                                        <!-- Nút Edit -->
                                                        <a href="${pageContext.request.contextPath}/manage-story?action=edit&id=${story.storyId}" title="Edit">
                                                            <i class="ri-edit-line fs-3"></i>
                                                        </a>
                                                        <!-- Nút Deactivate -->
                                                        <a href="javascript:void(0);" onclick="confirmDeactivate(${story.storyId})" title="Deactivate">
                                                            <i class="ri-close-circle-line text-danger fs-3"></i>
                                                        </a>
                                                        <!-- Nút Delete -->
                                                        <a href="${pageContext.request.contextPath}/manage-story?action=delete&id=${story.storyId}" title="Delete">
                                                            <i class="ri-delete-bin-line fs-3 text-danger"></i>
                                                        </a>
                                                    </div>
                                                </td>

                                            </tr>
                                        </c:forEach>

                                    </table>
                                </div>

                                <!-- Pagination -->
                                <nav aria-label="Page navigation" style="margin-top: 30px">
                                    <ul class="pagination justify-content-center">
                                        <c:if test="${currentPage > 1}">
                                            <li class="page-item">
                                                <a class="page-link"
                                                   href="${paginationUrl}&page=${currentPage - 1}"
                                                   aria-label="Previous">
                                                    <span aria-hidden="true">&laquo;</span>
                                                </a>
                                            </li>
                                        </c:if>

                                        <c:forEach begin="1" end="${totalPages}" var="i">
                                            <li class="page-item ${currentPage == i ? 'active' : ''}">
                                                <a class="page-link"
                                                   href="${paginationUrl}&page=${i}">${i}</a>
                                            </li>
                                        </c:forEach>

                                        <c:if test="${currentPage < totalPages}">
                                            <li class="page-item">
                                                <a class="page-link"
                                                   href="${paginationUrl}&page=${currentPage + 1}"
                                                   aria-label="Next">
                                                    <span aria-hidden="true">&raquo;</span>
                                                </a>
                                            </li>
                                        </c:if>
                                    </ul>
                                </nav>

                            </div>
                        </div>
                    </div>


                    <footer class="d-footer">
                        <div class="row align-items-center justify-content-between">
                            <div class="col-auto">
                                <p class="mb-0">© 2024 WowDash. All Rights Reserved.</p>
                            </div>
                            <div class="col-auto">
                                <p class="mb-0">Made by <span class="text-primary-600">wowtheme7</span></p>
                            </div>
                        </div>
                    </footer>
                    </main>

                    <script>
                        function confirmDeactivate(storyId) {
                            if (confirm("Are you sure you want to deactivate this slider?")) {
                                window.location.href = '${pageContext.request.contextPath}/manage-story?action=deactivate&id=' + storyId;
                            }
                        }
                        // Toast message display
                        var toastMessage = "${sessionScope.toastMessage}";
                        var toastType = "${sessionScope.toastType}";
                        if (toastMessage) {
                            iziToast.show({
                                title: toastType === 'success' ? 'Success' : 'Error',
                                message: toastMessage,
                                position: 'topRight',
                                color: toastType === 'success' ? 'green' : 'red',
                                timeout: 5000,
                                onClosing: function () {
                                    // Remove toast attributes from the session after displaying
                                    fetch('${pageContext.request.contextPath}/remove-toast', {
                                        method: 'POST',
                                        headers: {
                                            'Content-Type': 'application/x-www-form-urlencoded',
                                        },
                                    }).then(response => {
                                        if (!response.ok) {
                                            console.error('Failed to remove toast attributes');
                                        }
                                    }).catch(error => {
                                        console.error('Error:', error);
                                    });
                                }
                            });
                        }
                    </script>
                    <!--JS Here-->
                    <jsp:include page="../../common/dashboard/js-dashboard.jsp"></jsp:include>

                    </body>

                    <!-- Mirrored from wowdash.wowtheme7.com/demo/blog.html by HTTrack Website Copier/3.x [XR&CO'2014], Mon, 03 Feb 2025 04:44:34 GMT -->
                    </html>