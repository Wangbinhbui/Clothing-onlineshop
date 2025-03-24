<!-- meta tags and other links -->
<!DOCTYPE html>
<html lang="en" data-theme="light">

    <!-- Mirrored from wowdash.wowtheme7.com/demo/add-blog.html by HTTrack Website Copier/3.x [XR&CO'2014], Mon, 03 Feb 2025 04:44:35 GMT -->
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Wowdash - Bootstrap 5 Admin Dashboard HTML Template</title>
        <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/assets/images/favicon.png" sizes="16x16">
       <!--CSS Here-->
        <jsp:include page="../../common/dashboard/css-dashboard.jsp"></jsp:include>
    </head>
    <body>
      <!--Sidebar-->
        <jsp:include page="../../common/dashboard/sidebar-dashboard.jsp"></jsp:include>

        <main class="dashboard-main">
            <!--header-->
            <jsp:include page="../../common/dashboard/header-dashboard.jsp"></jsp:include>

            <div class="dashboard-main-body">
                <div class="d-flex flex-wrap align-items-center justify-content-between gap-3 mb-24">
                    <h6 class="fw-semibold mb-0">Slider Details</h6>
                    <ul class="d-flex align-items-center gap-2">
                        <li class="fw-medium">
                            <a href="index.html" class="d-flex align-items-center gap-1 hover-text-primary">
                                <iconify-icon icon="solar:home-smile-angle-outline" class="icon text-lg"></iconify-icon>
                                Dashboard
                            </a>
                        </li>
                        <li>-</li>
                        <li class="fw-medium">Slider Details</li>
                    </ul>
                </div>

                <div class="row gy-4">
                    <div class="col-lg-8">
                        <div class="card mt-24">
                            <div class="card-header border-bottom">
                                <h6 class="text-xl mb-0">Update Slider</h6>
                            </div>
                            <div class="card-body p-24">
                                <form action="${pageContext.request.contextPath}/manage-story"  method="post" enctype="multipart/form-data" class="d-flex flex-column gap-20">

                                    <input type="hidden" name="action" value="update"/>
                                    <input type="hidden" name="id" value="${story.storyId}">


                                    <div>
                                        <label class="form-label fw-bold text-neutral-900" for="title">Post New Title: </label>
                                        <input type="text" class="form-control border border-neutral-200 radius-8" id="title" name="title" value="${story.title}" placeholder="Enter Post Title">
                                    </div>
                                    <div>
                                        <label class="form-label fw-bold text-neutral-900" for="backlink">Backlink URL: </label>
                                        <input type="url" class="form-control border border-neutral-200 radius-8" id="backlink" name="backlink" value="${story.backlink}" placeholder="Enter Backlink URL">

                                    </div>


                                    <div>
                                        <label class="form-label fw-bold text-neutral-900" for="status">Status</label>
                                        <select class="form-control border border-neutral-200 radius-8" id="status" name="status"> 
                                            <option value="Active" ${story.status == 'Active' ? 'selected' : ''}>Active</option>
                                            <option value="Inactive" ${story.status == 'Inactive' ? 'selected' : ''}>Inactive</option>

                                        </select>
                                    </div>
                                    <div>
                                        <label for="description" class="form-label fw-bold text-neutral-900"> Post Description </label>

                                        <div  class="height-200">
                                            <!-- Editor Toolbar Start -->
                                            <div  id="toolbar-container">
                                                <span class="ql-formats">
                                                    <select class="ql-font"></select>
                                                    <select class="ql-size"></select>
                                                </span>
                                                <span class="ql-formats">
                                                    <button class="ql-bold"></button>
                                                    <button class="ql-italic"></button>
                                                    <button class="ql-underline"></button>
                                                    <button class="ql-strike"></button>
                                                </span>
                                                <span class="ql-formats">
                                                    <select class="ql-color"></select>
                                                    <select class="ql-background"></select>
                                                </span>
                                                <span class="ql-formats">
                                                    <button class="ql-script" value="sub"></button>
                                                    <button class="ql-script" value="super"></button>
                                                </span>
                                                <span class="ql-formats">
                                                    <button class="ql-header" value="1"></button>
                                                    <button class="ql-header" value="2"></button>
                                                    <button class="ql-blockquote"></button>
                                                    <button class="ql-code-block"></button>
                                                </span>
                                                <span class="ql-formats">
                                                    <button class="ql-list" value="ordered"></button>
                                                    <button class="ql-list" value="bullet"></button>
                                                    <button class="ql-indent" value="-1"></button>
                                                    <button class="ql-indent" value="+1"></button>
                                                </span>
                                                <span class="ql-formats">
                                                    <button class="ql-direction" value="rtl"></button>
                                                    <select class="ql-align"></select>
                                                </span>
                                                <span class="ql-formats">
                                                    <button class="ql-link"></button>
                                                    <button class="ql-image"></button>
                                                    <button class="ql-video"></button>
                                                    <button class="ql-formula"></button>
                                                </span>
                                                <span class="ql-formats">
                                                    <button class="ql-clean"></button>
                                                </span>
                                            </div>
                                            <!-- Editor Toolbar End -->



                                            <!-- Editor start -->
                                            <div  id="editor">
                                                <p class=""></p>

                                            </div>
                                            <input type="hidden" id="description" name="description" value="${story.description}">
                                            <!-- Editor End -->
                                        </div>
                                    </div>
                                    <div>
                                        <label for="imageUrl" class="form-label fw-bold text-neutral-900">Upload Thumbnail </label>
                                        <div class="upload-image-wrapper">
                                            <!-- Hi?n th? ?nh c? n?u có -->
                                            <div id="uploaded-img-container" class="position-relative h-160-px w-100 border input-form-light radius-8 overflow-hidden border-dashed bg-neutral-50
                                                 ${empty slider.imageUrl ? 'd-none' : ''}">
                                                <button type="button" class="uploaded-img__remove position-absolute top-0 end-0 z-1 text-2xxl line-height-1 me-8 mt-8 d-flex
                                                        bg-danger-600 w-40-px h-40-px justify-content-center align-items-center rounded-circle">
                                                    <iconify-icon icon="radix-icons:cross-2" class="text-2xl text-white"></iconify-icon>
                                                </button>
                                                <img id="uploaded-img__preview" class="w-100 h-100 object-fit-cover" 
                                                     src="${not empty slider.imageUrl ? pageContext.request.contextPath + '/assets/images/story/' + story.imageUrl : ''}" 
                                                     alt="Current Image">
                                            </div>

                                            <!-- Ch?n ?nh m?i -->
                                            <label class="upload-file h-160-px w-100 border input-form-light radius-8 overflow-hidden border-dashed bg-neutral-50
                                                   bg-hover-neutral-200 d-flex align-items-center flex-column justify-content-center gap-1" for="upload-file">
                                                <iconify-icon icon="solar:camera-outline" class="text-xl text-secondary-light"></iconify-icon>
                                                <span class="fw-semibold text-secondary-light">Upload</span>
                                                <input id="upload-file" type="file" name="thumbnail" accept="image/*" hidden>
                                            </label>
                                        </div>

                                        <!-- ?n giá tr? ?nh c? ?? l?u l?i n?u không có ?nh m?i -->
                                        <input type="hidden" name="current_image" value="${slider.imageUrl}">
                                    </div>


                                    <div class="d-flex gap-3 mt-3">
                                        <button type="submit" class="btn btn-primary-600 radius-8">Update</button>
                                        <a href="${pageContext.request.contextPath}/manage-story" class="btn btn-secondary ml-2">Cancel</a>
                                    </div>
                                </form>
                            </div>
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

        <!-- jQuery library js -->
         <jsp:include page="../../common/dashboard/js-dashboard.jsp"></jsp:include>

        <script>
            // Editor Js Start
            document.addEventListener("DOMContentLoaded", function () {
                // Kh?i t?o trình so?n th?o Quill
                const quill = new Quill('#editor', {
                    modules: {
                        syntax: true,
                        toolbar: '#toolbar-container',
                    },
                    placeholder: '',
                    theme: 'snow',
                });

                // L?y n?i dung mô t? t? backend và ??t vào editor
                const descriptionInput = document.getElementById('description');
                if (descriptionInput.value) {
                    quill.root.innerHTML = descriptionInput.value; // Hi?n th? mô t? hi?n t?i trong trình so?n th?o
                }

                // Khi n?i dung thay ??i, c?p nh?t l?i input ?n ?? l?u d? li?u
                quill.on('text-change', function () {
                    descriptionInput.value = quill.root.innerHTML;
                });

                // ??m b?o n?i dung description ???c g?i khi c?p nh?t form
                document.querySelector('form').onsubmit = function () {
                    descriptionInput.value = quill.root.innerHTML;
                };
            });

            // Editor Js End
            document.addEventListener("DOMContentLoaded", function () {
                const fileInput = document.getElementById("upload-file");
                const imagePreview = document.getElementById("uploaded-img__preview");
                const uploadedImgContainer = document.getElementById("uploaded-img-container");
                const removeButton = document.querySelector(".uploaded-img__remove");

                // Hi?n th? ?nh m?i khi ch?n file
                fileInput.addEventListener("change", function (e) {
                    if (e.target.files.length) {
                        const src = URL.createObjectURL(e.target.files[0]);
                        imagePreview.src = src;
                        uploadedImgContainer.classList.remove('d-none');
                    }
                });

                // Xóa ?nh c? khi nh?n nút "X"
                removeButton.addEventListener("click", function () {
                    imagePreview.src = "";
                    uploadedImgContainer.classList.add('d-none');
                    fileInput.value = ""; // Reset input file
                });
            });


            // =============================== Upload Single Image js start here ================================================
            const fileInput = document.getElementById("upload-file");
            const imagePreview = document.getElementById("uploaded-img__preview");
            const uploadedImgContainer = document.querySelector(".uploaded-img");
            const removeButton = document.querySelector(".uploaded-img__remove");

            fileInput.addEventListener("change", (e) => {
                if (e.target.files.length) {
                    const src = URL.createObjectURL(e.target.files[0]);
                    imagePreview.src = src;
                    uploadedImgContainer.classList.remove('d-none');
                }
            });
            removeButton.addEventListener("click", () => {
                imagePreview.src = "";
                uploadedImgContainer.classList.add('d-none');
                fileInput.value = "";
            });
            // =============================== Upload Single Image js End here ================================================

        </script>

    </body>

    <!-- Mirrored from wowdash.wowtheme7.com/demo/add-blog.html by HTTrack Website Copier/3.x [XR&CO'2014], Mon, 03 Feb 2025 04:44:36 GMT -->
</html>