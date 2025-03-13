<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Blog</title>
    <jsp:include page="../common/dashboard/css-dashboard.jsp" />
</head>
<body>
    <jsp:include page="../common/dashboard/sidebar-dashboard.jsp" />
    <jsp:include page="../common/dashboard/header-dashboard.jsp" />
    <main class="dashboard-main">
        <div class="dashboard-main-body">
            <div class="d-flex flex-wrap align-items-center justify-content-between gap-3 mb-24">
                <h6 class="fw-semibold mb-0">Add Blog</h6>
            </div>

            <div class="row gy-4">
                <div class="col-lg-8">
                    <div class="card mt-24">
                        <div class="card-header border-bottom">
                            <h6 class="text-xl mb-0">Add New Post</h6>
                        </div>
                        <div class="card-body p-24">
                            <c:if test="${not empty userError}">
                                <div class="alert alert-danger">${userError}</div>
                            </c:if>
                            <form action="${pageContext.request.contextPath}/post-manage?action=create" 
                                  method="post" 
                                  enctype="multipart/form-data" 
                                  class="d-flex flex-column gap-20">

                                <!-- Blog Title -->
                                <div>
                                    <label class="form-label fw-bold text-neutral-900" for="title">Post Title:</label>
                                    <input type="text" 
                                           class="form-control border border-neutral-200 radius-8" 
                                           id="title" 
                                           name="title" 
                                           placeholder="Enter Post Title" 
                                           required>
                                </div>

                                <!-- Blog Brief -->
                                <div>
                                    <label class="form-label fw-bold text-neutral-900" for="brief">Brief Info:</label>
                                    <input type="text" 
                                           class="form-control border border-neutral-200 radius-8" 
                                           id="brief" 
                                           name="brief" 
                                           placeholder="Enter Brief Description" 
                                           required>
                                </div>

                                <!-- Blog Content (Quill Editor) -->
                                <div>
                                    <label class="form-label fw-bold text-neutral-900">Post Description:</label>
                                    <div class="border border-neutral-200 radius-8 overflow-hidden">
                                        <div class="height-200">
                                            <div id="toolbar-container">
                                                <span class="ql-formats">
                                                    <button class="ql-bold"></button>
                                                    <button class="ql-italic"></button>
                                                    <button class="ql-underline"></button>
                                                </span>
                                            </div>
                                            <div id="editor" class="h-100"></div>
                                            <textarea name="content" id="content" style="display:none;"></textarea>
                                        </div>
                                    </div>
                                </div>

                                <!-- Blog Category (lấy từ DB) -->
                                <div>
                                    <label class="form-label fw-bold text-neutral-900" for="category">Category:</label>
                                    <select class="form-control border border-neutral-200 radius-8" 
                                            id="category" 
                                            name="category" 
                                            required>
                                        <c:forEach var="cat" items="${categories}">
                                            <option value="${cat.id}">${cat.name}</option>
                                        </c:forEach>
                                    </select>
                                </div>

                                <!-- Select Author (Lấy từ DB) -->
                                <div>
                                    <label class="form-label fw-bold text-neutral-900" for="author">Author:</label>
                                    <select class="form-control border border-neutral-200 radius-8" 
                                            id="author" 
                                            name="author" 
                                            required>
                                        <c:choose>
                                            <c:when test="${not empty users}">
                                                <c:forEach var="user" items="${users}">
                                                    <option value="${user.id}">${user.firstName} ${user.lastName}</option>
                                                </c:forEach>
                                            </c:when>
                                            <c:otherwise>
                                                <option value="" disabled>No users available</option>
                                            </c:otherwise>
                                        </c:choose>
                                    </select>
                                </div>

                                <!-- Upload Thumbnail -->
                                <div>
                                    <label class="form-label fw-bold text-neutral-900" for="image">Upload Thumbnail:</label>
                                    <input id="image" 
                                           type="file" 
                                           name="image" 
                                           class="form-control border border-neutral-200 radius-8" 
                                           accept="image/*" 
                                           required>
                                </div>

                                <!-- Hidden Fields -->
                                <input type="hidden" name="status" value="Active">

                                <!-- Submit Button -->
                                <button type="submit" class="btn btn-primary-600 radius-8">Submit</button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </main>

    <footer class="d-footer">
        <div class="row align-items-center justify-content-between">
            <div class="col-auto">
                <p class="mb-0">&copy; 2024 Blog System. All Rights Reserved.</p>
            </div>
        </div>
    </footer>

    <jsp:include page="../common/dashboard/js-dashboard.jsp" />
    <!-- Quill Editor JS -->
    <script src="https://cdn.quilljs.com/1.3.6/quill.min.js"></script>
    <script>
        const quill = new Quill('#editor', {
            theme: 'snow',
            placeholder: 'Enter your blog content here...'
        });

        document.querySelector('form').onsubmit = () => {
            document.querySelector('#content').value = quill.root.innerHTML;
        };
    </script>
</body>
</html>
