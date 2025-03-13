<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en" data-theme="light">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Blog Details | WowDash</title>
  <jsp:include page="../common/dashboard/css-dashboard.jsp"></jsp:include>
</head>

<body>
  <jsp:include page="../common/dashboard/sidebar-dashboard.jsp"></jsp:include>
  <jsp:include page="../common/dashboard/header-dashboard.jsp"></jsp:include>

  <div class="dashboard-main-body">
    <!-- Breadcrumb -->
    <div class="d-flex flex-wrap align-items-center justify-content-between gap-3 mb-24">
      <h6 class="fw-semibold mb-0">Blog Details</h6>
      <ul class="d-flex align-items-center gap-2">
        <li class="fw-medium">
          <a href="index.html" class="d-flex align-items-center gap-1 hover-text-primary">
            <iconify-icon icon="solar:home-smile-angle-outline" class="icon text-lg"></iconify-icon>
            Dashboard
          </a>
        </li>
        <li>-</li>
        <li class="fw-medium">Blog Details</li>
      </ul>
    </div>

    <div class="row gy-4">
      <!-- Content Area -->
      <div class="col-lg-8">
        <div class="card p-0 radius-12 overflow-hidden">
          <div class="card-body p-0">
            <!-- Blog Thumbnail -->
            <img src="${blog.thumbnail}" alt="${blog.title}" class="w-100 h-100 object-fit-cover">

            <div class="p-32">
              <!-- Blog Meta Information -->
              <div class="d-flex align-items-center gap-16 justify-content-between flex-wrap mb-24">
                <div class="d-flex align-items-center gap-8">
                  <img src="${authorImage}" alt="${authorName}" class="w-48-px h-48-px rounded-circle object-fit-cover">
                  <div class="d-flex flex-column">
                    <h6 class="text-lg mb-0">${authorName}</h6>
                    <span class="text-sm text-neutral-500">${blog.createdDate}</span>
                  </div>
                </div>
                <div class="d-flex align-items-center gap-md-3 gap-2 flex-wrap">
                  <div class="d-flex align-items-center gap-8 text-neutral-500 text-lg fw-medium">
                    <i class="ri-calendar-2-line"></i>
                    ${blog.updatedDate}
                  </div>
                </div>
              </div>

              <!-- Blog Title -->
              <h3 class="mb-16">${blog.title}</h3>

              <!-- Blog Brief -->
              <p class="text-neutral-600 mb-16"><strong>${blog.briefInfo}</strong></p>

              <!-- Blog Content -->
              <c:forEach var="paragraph" items="${contentParagraphs}">
                <p class="text-lg lh-lg text-neutral-800 mb-16 text-justify">${blog.content}</p>
              </c:forEach>

              <!-- Related Blogs -->
              <h4 class="mt-32">Related Content</h4>
              <div class="d-flex gap-16">
                <c:forEach var="relatedBlog" items="${relatedBlogs}">
                  <div class="related-blog-item">
                    <img src="${relatedBlog.thumbnail}" alt="${relatedBlog.title}" class="w-100">
                    <h5>${relatedBlog.title}</h5>
                  </div>
                </c:forEach>
              </div>
            </div>
          </div>
        </div>

      </div>


        </div>
      </div>
    </div>

    <footer class="d-footer">
      <p class="mb-0">© 2024 WowDash. All Rights Reserved.</p>
    </footer>
  </div>

  <jsp:include page="../common/dashboard/js-dashboard.jsp"></jsp:include>
</body>

</html>
