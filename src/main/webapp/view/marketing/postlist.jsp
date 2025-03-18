

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!-- meta tags and other links -->
<!DOCTYPE html>
<html lang="en" data-theme="light">

<!-- Mirrored from wowdash.wowtheme7.com/demo/users-list.html by HTTrack Website Copier/3.x [XR&CO'2014], Mon, 03 Feb 2025 04:44:16 GMT -->
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Wowdash - Bootstrap 5 Admin Dashboard HTML Template</title>
  <link rel="icon" type="image/png" href="assets/images/favicon.png" sizes="16x16">
  <!-- CSS here -->
  <jsp:include page="../../common/dashboard/css-dashboard.jsp"></jsp:include>
</head>
  <body>
      <!-- Sidebar -->
      <jsp:include page="../../common/dashboard/sidebar-dashboard.jsp"></jsp:include>

      <!-- Header -->
      <jsp:include page="../../common/dashboard/header-dashboard.jsp"></jsp:include>
    

            <div class="dashboard-main-body">
                <div class="d-flex flex-wrap align-items-center justify-content-between gap-3 mb-24">
                    <h6 class="fw-semibold mb-0">Blog</h6>
                    <ul class="d-flex align-items-center gap-2">
                        <li class="fw-medium">
                            <a href="index.html" class="d-flex align-items-center gap-1 hover-text-primary">
                                <iconify-icon icon="solar:home-smile-angle-outline" class="icon text-lg"></iconify-icon>
                                Dashboard
                            </a>
                        </li>
                        <li>-</li>
                        <li class="fw-medium">Blog</li>
                    </ul>
                </div>

                <div class="col-xxl-3 col-lg-4 col-sm-6">
                    <c:forEach var="blog" items="${blog}">
                    <div class="card h-100 p-0 radius-12 overflow-hidden">
                        <div class="card-body p-0">
                            <a href="blog?action=view&id=${blog.id}" class="w-100 max-h-266-px radius-0 overflow-hidden">
                                <img src="${blog.thumbnail}" alt="Blog Image" class="w-100 h-100 object-fit-cover">
                            </a>
                            <div class="p-20">
                                <h6 class="mb-16">
                                    <a href="blog?action=view&id=${blog.id}" class="text-line-2 text-hover-primary-600 text-xl transition-2">
                                        ${blog.title}
                                    </a>
                                </h6>
                                <p class="text-line-3 text-neutral-500 mb-0">${blog.briefInfo}</p>
                                <span class="d-block border-bottom border-neutral-300 border-dashed my-20"></span>
                                <div class="d-flex align-items-center justify-content-between flex-wrap gap-6">
                                    <div class="d-flex align-items-center gap-8">
                                        <img src="assets/images/user-list/user-list5.png" alt="" class="w-40-px h-40-px rounded-circle object-fit-cover">
                                        <div class="d-flex flex-column">
                                            <h6 class="text-sm mb-0">John Doe</h6>
                                            <span class="text-xs text-neutral-500">${blog.createdDate}</span>
                                        </div>
                                    </div>
                                    <a href="post?action=view&id=${blog.id}" class="btn btn-sm btn-primary-600 d-flex align-items-center gap-1 text-xs px-8 py-6">
                                        Read More
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
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
  <!-- JS here -->
  <jsp:include page="../../common/dashboard/js-dashboard.jsp"></jsp:include>
    </body>

    <!-- Mirrored from wowdash.wowtheme7.com/demo/blog.html by HTTrack Website Copier/3.x [XR&CO'2014], Mon, 03 Feb 2025 04:44:34 GMT -->
</html>
