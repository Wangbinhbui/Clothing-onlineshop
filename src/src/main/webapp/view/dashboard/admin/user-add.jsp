<%-- 
    Document   : user-add
    Created on : Feb 12, 2025, 12:36:33 PM
    Author     : ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!-- meta tags and other links -->
<!DOCTYPE html>
<html lang="en" data-theme="light">

    <!-- Mirrored from wowdash.wowtheme7.com/demo/add-user.html by HTTrack Website Copier/3.x [XR&CO'2014], Mon, 03 Feb 2025 04:44:21 GMT -->
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Store 24-Add User</title>
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
                    <h6 class="fw-semibold mb-0">Add User</h6>
                    <ul class="d-flex align-items-center gap-2">
                        <li class="fw-medium">
                            <a href="index.html" class="d-flex align-items-center gap-1 hover-text-primary">
                                <iconify-icon icon="solar:home-smile-angle-outline" class="icon text-lg"></iconify-icon>
                                Dashboard
                            </a>
                        </li>
                        <li>-</li>
                        <li class="fw-medium">Add User</li>
                    </ul>
                </div>

                <div class="card h-100 p-0 radius-12">
                    <div class="card-body p-24">
                        <div class="row justify-content-center">
                            <div class="col-xxl-6 col-xl-8 col-lg-10">
                                <div class="card border">
                                    <div class="card-body">                                      
                                        <form action="${pageContext.request.contextPath}/manage-users" method="POST"">
                                        <input type="hidden" name="action" value="add">

                                        <div class="mb-20">
                                            <label for="name" class="form-label fw-semibold text-primary-light text-sm mb-8">First Name <span class="text-danger-600">*</span></label>
                                            <input type="text" class="form-control radius-8" id="name" placeholder="Enter First Name" name="firstname" required="">
                                        </div>
                                        <div class="mb-20">
                                            <label for="name" class="form-label fw-semibold text-primary-light text-sm mb-8">Last Name <span class="text-danger-600">*</span></label>
                                            <input type="text" class="form-control radius-8" id="name" placeholder="Enter Last Name" name="lastname" required="">
                                        </div>
                                        <div class="mb-20">
                                            <label for="depart" class="form-label fw-semibold text-primary-light text-sm mb-8">Sex <span class="text-danger-600">*</span> </label>
                                            <select class="form-control radius-8 form-select" id="depart" name="sex">
                                                <option value="true">Male</option>
                                                <option value="false">Female</option>
                                            </select>
                                        </div>
                                        <div class="mb-20">
                                            <label for="name" class="form-label fw-semibold text-primary-light text-sm mb-8">BirthDate <span class="text-danger-600">*</span></label>
                                            <input type="date" class="form-control radius-8" id="name" placeholder="Enter BirthDate" name="dob" required="">
                                        </div>
                                        <div class="mb-20">
                                            <label for="email" class="form-label fw-semibold text-primary-light text-sm mb-8">Email <span class="text-danger-600">*</span></label>
                                            <input type="email" class="form-control radius-8" id="email" placeholder="Enter email address" name="email" required="">
                                        </div>
                                        <div class="mb-20">
                                            <label for="number" class="form-label fw-semibold text-primary-light text-sm mb-8">Phone</label>
                                            <input type="text" class="form-control radius-8" id="number" placeholder="Enter phone number" name="phone" required="">
                                        </div>
                                        <div class="mb-20">
                                            <label for="depart" class="form-label fw-semibold text-primary-light text-sm mb-8">Role<span class="text-danger-600">*</span> </label>
                                            <select class="form-control radius-8 form-select" id="depart" name="role">
                                                <option value="2">Sale</option>
                                                <option value="3">Marketing</option>
                                                <option value="4">User</option>
                                                <option value="5">Sale Manager</option>
                                                <option value="6">Staff</option>
                                            </select>
                                        </div>
                                        <div class="mb-20">
                                            <label for="name" class="form-label fw-semibold text-primary-light text-sm mb-8">Username <span class="text-danger-600">*</span></label>
                                            <input type="text" class="form-control radius-8" id="name" placeholder="Enter Username" name="username" required="">
                                        </div>
                                        <div class="mb-20">
                                            <label for="name" class="form-label fw-semibold text-primary-light text-sm mb-8">Password <span class="text-danger-600">*</span></label>
                                            <input type="password" class="form-control radius-8" id="name" placeholder="Enter Password" name="password" required="">
                                        </div>

                                        <div class="d-flex align-items-center justify-content-center gap-3">
                                            <button type="button" class="border border-danger-600 bg-hover-danger-200 text-danger-600 text-md px-56 py-11 radius-8"
                                                    onclick="window.location.href = '${pageContext.request.contextPath}/manage-users'"> 
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

</html>

