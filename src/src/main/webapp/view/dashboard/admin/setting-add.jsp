<%-- 
    Document   : setting-add
    Created on : Feb 14, 2025, 9:27:29 PM
    Author     : ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en" data-theme="light">

    <!-- Mirrored from wowdash.wowtheme7.com/demo/add-user.html by HTTrack Website Copier/3.x [XR&CO'2014], Mon, 03 Feb 2025 04:44:21 GMT -->
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Store 24-Add Setting</title>
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
                    <h6 class="fw-semibold mb-0">Add Setting</h6>
                    <ul class="d-flex align-items-center gap-2">
                        <li class="fw-medium">
                            <a href="index.html" class="d-flex align-items-center gap-1 hover-text-primary">
                                <iconify-icon icon="solar:home-smile-angle-outline" class="icon text-lg"></iconify-icon>
                                Dashboard
                            </a>
                        </li>
                        <li>-</li>
                        <li class="fw-medium">Add Setting</li>
                    </ul>
                </div>

                <div class="card h-100 p-0 radius-12">
                    <div class="card-body p-24">
                        <div class="row justify-content-center">
                            <div class="col-xxl-6 col-xl-8 col-lg-10">
                                <div class="card border">
                                    <div class="card-body">                                      
                                        <form action="${pageContext.request.contextPath}/manage-settings" method="POST"">
                                        <input type="hidden" name="action" value="add">

                                        <div class="mb-20">
                                            <label for="depart" class="form-label fw-semibold text-primary-light text-sm mb-8">Type<span class="text-danger-600">*</span> </label>
                                            <select class="form-control radius-8 form-select" id="depart" name="type">
                                                <option value="System">System</option>
                                                <option value="User">User</option>
                                                <option value="Payment">Payment</option>
                                            </select>
                                        </div>
                                        <div class="mb-20">
                                            <label for="name" class="form-label fw-semibold text-primary-light text-sm mb-8">Value <span class="text-danger-600">*</span></label>
                                            <input type="text" class="form-control radius-8" id="name" placeholder="Enter Value" name="value" required="">
                                        </div>
                                        <div class="mb-20">
                                            <label for="name" class="form-label fw-semibold text-primary-light text-sm mb-8">Order <span class="text-danger-600">*</span></label>
                                            <input type="number" class="form-control radius-8" id="name" placeholder="Enter Order" name="order" required="">
                                        </div>
                                        <div class="mb-20">
                                            <label for="depart" class="form-label fw-semibold text-primary-light text-sm mb-8">Status<span class="text-danger-600">*</span> </label>
                                            <select class="form-control radius-8 form-select" id="depart" name="status">
                                                <option value="Active">Active</option>
                                                <option value="Inactive">Inactive</option>                       
                                            </select>
                                        </div>

                                        <div class="d-flex align-items-center justify-content-center gap-3">
                                            <button type="button" class="border border-danger-600 bg-hover-danger-200 text-danger-600 text-md px-56 py-11 radius-8"
                                                    onclick="window.location.href = '${pageContext.request.contextPath}/manage-settings'"> 
                                                Cancel
                                            </button>
                                            <button type="submit" class="btn btn-primary border border-primary-600 text-md px-56 py-12 radius-8"> 
                                                Save
                                            </button>
                                        </div>
                                        <div class="text-center mt-3">
                                            <span style="color: #198754">${suc}</span>  <!-- Màu xanh cho thông báo thành công -->
                                            <span style="color: #dc3545">${err}</span>  <!-- Màu đỏ cho thông báo lỗi -->
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </main>

    <!-- JS here -->
    <jsp:include page="../../common/dashboard/js-dashboard.jsp"></jsp:include>


</body>

<!-- Mirrored from wowdash.wowtheme7.com/demo/add-user.html by HTTrack Website Copier/3.x [XR&CO'2014], Mon, 03 Feb 2025 04:44:21 GMT -->
</html>
