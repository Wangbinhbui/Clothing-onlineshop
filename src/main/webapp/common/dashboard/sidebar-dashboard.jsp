<%-- 
    Document   : sidebar
    Created on : Feb 20, 2025, 9:30:40 PM
    Author     : Quang
--%>

    <aside class="sidebar">
            <button type="button" class="sidebar-close-btn">
                <iconify-icon icon="radix-icons:cross-2"></iconify-icon>
            </button>
            <div>
                <a href="index.html" class="sidebar-logo">
                    <img src="${pageContext.request.contextPath}/assets/images/logo.png" alt="site logo" class="light-logo">
                    <img src="${pageContext.request.contextPath}/assets/images/logo-light.png" alt="site logo" class="dark-logo">
                    <img src="${pageContext.request.contextPath}/assets/images/logo-icon.png" alt="site logo" class="logo-icon">
                </a>
            </div>
            <div class="sidebar-menu-area">
                <ul class="sidebar-menu" id="sidebar-menu">
                   
                        <a href="javascript:void(0)">
                            <iconify-icon icon="solar:home-smile-angle-outline" class="menu-icon"></iconify-icon>
                            <span>Dashboard</span>
                        </a>

   


                    <li class="dropdown">
                        <a href="javascript:void(0)">
                            <i class="ri-news-line text-xl me-14 d-flex w-auto"></i>
                            <span>Slider</span> 
                        </a>
                        <ul class="sidebar-submenu">
                            <li>
                                <a href="${pageContext.request.contextPath}/manage-story"><i class="ri-circle-fill circle-icon text-primary-600 w-auto"></i> Slider list</a>
                            </li>

                        </ul>
                    </li>

                </ul>
            </div>
        </aside>