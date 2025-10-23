<%@page pageEncoding="UTF-8" %>
<!-- Sidebar -->
        <ul class="navbar-nav bg-gradient-success sidebar sidebar-dark accordion" id="minwonSidebar">

            <!-- Sidebar - Brand -->
            <div class="gyeolje24" style="background-color: white;">
            <a class="sidebar-brand d-flex align-items-center justify-content-center text-dark" href="/approval24/">
                <div class="sidebar-brand-icon rotate-n-15">
                    <img src="${pageContext.request.contextPath}/resources/assets/img/work24.png" width= 40px;>
                </div>
                <div class="sidebar-brand-text mx-3">고용24</div>
            </a>
            </div>
            
            <!-- Divider -->
            <hr class="sidebar-divider my-0">

            <!-- Nav Item - Dashboard -->
            <li class="nav-item">
    			<a class="nav-link" href="/approval24/">
        			<img src="${pageContext.request.contextPath}/resources/assets/img/home.svg" class="nav-icon-blur" style="width: 18px; margin-right: 3px; ">
        		<span>메인</span></a>
			</li>

            <!-- Divider -->
            <hr class="sidebar-divider">
            
           <!-- Nav Item - Tables -->
            <li class="nav-item">
                <a class="nav-link" href="/approval24/benefits">
                   <img src="${pageContext.request.contextPath}/resources/assets/img/side_search.svg" class="nav-icon-blur" style="width: 18px; margin-right: 3px;">
                    <span>민원 등록</span></a>
            </li>
            
            <!-- Nav Item - Tables -->
            <li class="nav-item">
                <a class="nav-link" href="/approval24/tables">
                   <img src="${pageContext.request.contextPath}/resources/assets/img/side_search.svg" class="nav-icon-blur" style="width: 18px; margin-right: 3px;">
                    <span>내 민원 보기</span></a>
            </li>
          
               <!-- Divider -->
            <hr class="sidebar-divider d-none d-md-block">
            
            <!-- Nav Item - notice -->
            <li class="nav-item">
                <a class="nav-link" href="/approval24/notice">
                    <img src="${pageContext.request.contextPath}/resources/assets/img/notice.svg" class="nav-icon-blur" style="width: 18px; margin-right: 3px;">
                    <span>공지사항</span></a>
            </li>
            
            <hr class="sidebar-divider d-none d-md-block">
            

            <!-- Sidebar Toggler (Sidebar) -->
            <div class="text-center d-none d-md-inline">
                <button class="rounded-circle border-0" id="sidebarToggle"></button>
            </div>

        </ul>

	<!-- footer 영역 -->
	<%@ include file="/WEB-INF/views/common/footer.jsp"%>
