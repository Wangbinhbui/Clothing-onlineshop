<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page import="com.shop.swp391.dal.BlogDAO, com.shop.swp391.entity.Blog" %>
<%@page import="java.util.*" %>
<%
    // Lấy ID từ URL
    String idParam = request.getParameter("id");
    int blogId = (idParam != null) ? Integer.parseInt(idParam) : -1;

    // Lấy dữ liệu bài viết từ DAO
    BlogDAO blogDAO = new BlogDAO();
    Blog blog = blogDAO.findById(blogId);

    if (blog == null) {
        response.sendRedirect("blog-list.jsp"); // Chuyển hướng nếu không tìm thấy bài viết
        return;
    }
%>
<!DOCTYPE html>
<html lang="en" data-theme="light">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Update Blog | WowDash</title>
  <jsp:include page="../common/dashboard/css-dashboard.jsp"></jsp:include>
</head>
<body>
  <jsp:include page="../common/dashboard/sidebar-dashboard.jsp"></jsp:include>
  <main class="dashboard-main">
    <jsp:include page="../common/dashboard/header-dashboard.jsp"></jsp:include>
    <div class="dashboard-main-body">
      <div class="d-flex flex-wrap align-items-center justify-content-between gap-3 mb-24">
        <h6 class="fw-semibold mb-0">Update Blog</h6>
        <ul class="d-flex align-items-center gap-2">
          <li class="fw-medium">
            <a href="index.html" class="d-flex align-items-center gap-1 hover-text-primary">
              <iconify-icon icon="solar:home-smile-angle-outline" class="icon text-lg"></iconify-icon>
              Dashboard
            </a>
          </li>
          <li>-</li>
          <li class="fw-medium">Update Blog</li>
        </ul>
      </div>
      <div class="row gy-4">
        <div class="col-lg-8">
          <div class="card mt-24">
            <div class="card-header border-bottom">
              <h6 class="text-xl mb-0">Edit Post</h6>
            </div>
            <div class="card-body p-24">
              <!-- Form gửi đến PostController với action=update -->
              <form action="${pageContext.request.contextPath}/post-manage?action=update" method="post" enctype="multipart/form-data" class="d-flex flex-column gap-20">
                <!-- Blog ID (Hidden) -->
                <input type="hidden" name="id" value="<%= blog.getId() %>">
                
                <!-- Blog Title -->
                <div>
                  <label class="form-label fw-bold text-neutral-900" for="title">Post Title:</label>
                  <input type="text" class="form-control border border-neutral-200 radius-8" id="title" name="title" value="<%= blog.getTitle() %>" required>
                </div>

                <!-- Blog Category (Lấy từ DB) -->
                <div>
                  <label class="form-label fw-bold text-neutral-900" for="category">Post Category:</label>
                  <select class="form-control border border-neutral-200 radius-8" id="category" name="category" required>
                    <c:forEach var="cat" items="${categories}">
                      <option value="${cat.id}" <c:if test="${cat.id == blog.categoryId}">selected</c:if>>${cat.name}</option>
                    </c:forEach>
                  </select>
                </div>

                <!-- Blog Content -->
                <div>
                  <label class="form-label fw-bold text-neutral-900">Post Description:</label>
                  <div class="border border-neutral-200 radius-8 overflow-hidden">
                    <div class="height-200">
                      <!-- Quill Editor cho Content -->
                      <div id="editorContent" class="h-100"><%= blog.getContent() %></div>
                      <textarea name="content" id="content" style="display:none;"></textarea>
                    </div>
                  </div>
                </div>

                <!-- Blog Brief -->
                <div>
                  <label class="form-label fw-bold text-neutral-900">Post Brief:</label>
                  <div class="border border-neutral-200 radius-8 overflow-hidden">
                    <div class="height-200">
                      <!-- Quill Editor cho Brief -->
                      <div id="editorBrief" class="h-100"><%= blog.getBriefInfo() %></div>
                      <textarea name="brief" id="brief" style="display:none;"></textarea>
                    </div>
                  </div>
                </div>

                <!-- Upload Thumbnail -->
                <div>
                  <label class="form-label fw-bold text-neutral-900" for="image">Upload New Thumbnail:</label>
                  <input id="image" type="file" name="image" class="form-control border border-neutral-200 radius-8" accept="image/*">
                  <!-- Hiển thị ảnh hiện tại nếu có -->
                  <c:if test="${not empty blog.thumbnail}">
                    <div class="mt-2">
                      <img src="<%= blog.getThumbnail() %>" alt="Current Thumbnail" class="w-100 radius-8">
                      <input type="hidden" name="existingThumbnail" value="<%= blog.getThumbnail() %>">
                    </div>
                  </c:if>
                </div>

                <!-- Submit Button -->
                <button type="submit" class="btn btn-primary-600 radius-8">Update</button>
              </form>
            </div>
          </div>
        </div>
      </div>
    </div>
    <footer class="d-footer">
      <p class="mb-0">© 2024 WowDash. All Rights Reserved.</p>
    </footer>
  </main>
  <jsp:include page="../common/dashboard/js-dashboard.jsp"></jsp:include>
  <!-- Quill Script -->
  <script src="https://cdn.quilljs.com/1.3.6/quill.min.js"></script>
  <script>
    // Khởi tạo Quill Editor cho content và brief
    const quillContent = new Quill('#editorContent', {
      theme: 'snow',
      placeholder: 'Edit your blog content here...'
    });
    const quillBrief = new Quill('#editorBrief', {
      theme: 'snow',
      placeholder: 'Edit your blog brief here...'
    });
    
    // Khi submit form, đưa nội dung từ editor vào textarea tương ứng
    document.querySelector('form').onsubmit = () => {
      document.querySelector('#content').value = quillContent.root.innerHTML;
      document.querySelector('#brief').value = quillBrief.root.innerHTML;
    };
  </script>
</body>
</html>
