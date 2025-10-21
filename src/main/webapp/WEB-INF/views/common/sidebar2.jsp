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
    			<a class="nav-link" href="/approval24/minwon">
        			<img src="${pageContext.request.contextPath}/resources/assets/img/home.svg" class="nav-icon-blur" style="width: 18px; margin-right: 3px; ">
        		<span>메인</span></a>
			</li>

            <!-- Divider -->
            <hr class="sidebar-divider">
            
           <!-- 임시 카피 -->
           <li class="nav-item">
                <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">
                   <img src="${pageContext.request.contextPath}/resources/assets/img/side_search.svg" class="nav-icon-blur" style="width: 18px; margin-right: 3px;">
                    <span>실업급여</span>
                </a>
                <div id="collapseTwo" class="collapse" aria-labelledby="headingTwo" data-parent="#minwonSidebar" style="">
                    <div class="bg-white py-2 collapse-inner rounded">
                        <h6 class="collapse-header">실업급여</h6>
                         <a class="collapse-item" href="/approval24/tables">실업급여 신청</a>
                        <a class="collapse-item" href="/approval24/benefits">실업인정 신고</a>
                        <a class="collapse-item" href="/approval24/tables">조기 재취업수당 신고</a>
                    </div>
                </div>
            </li>
            
            <!-- 임시 카피 -->
            <li class="nav-item">
                <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseUtilities" aria-expanded="false" aria-controls="collapseUtilities">
                    <img src="${pageContext.request.contextPath}/resources/assets/img/side_search.svg" class="nav-icon-blur" style="width: 18px; margin-right: 3px;">
                    <span>출산</span>
                </a>
                <div id="collapseUtilities" class="collapse" aria-labelledby="headingUtilities" data-parent="#minwonSidebar" style="">
                    <div class="bg-white py-2 collapse-inner rounded">
                        <h6 class="collapse-header">출산</h6>
                        <a class="collapse-item" href="/approval24/tables">출산휴가 신청</a>
                        <a class="collapse-item" href="/approval24/tables">육아휴직 급여 신청</a>
                    </div>
                </div>
            </li>
            	
                  <!-- 임시 카피 -->
           <li class="nav-item">
                <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapsethree" aria-expanded="false" aria-controls="collapseTwo">
                   <img src="${pageContext.request.contextPath}/resources/assets/img/side_search.svg" class="nav-icon-blur" style="width: 18px; margin-right: 3px;">
                    <span>취업지원</span>
                </a>
                <div id="collapsethree" class="collapse" aria-labelledby="headingthree" data-parent="#minwonSidebar" style="">
                    <div class="bg-white py-2 collapse-inner rounded">
                        <h6 class="collapse-header">취업지원</h6>
                         <a class="collapse-item" href="/approval24/tables">구직 	촉진 수당 신청</a>
                        <a class="collapse-item" href="/approval24/tables">빈 일자리  수당 신청</a>
                        <a class="collapse-item" href="/approval24/tables">취업지원</a>
                        <a class="collapse-item" href="/approval24/tables">청년도전사업 지원</a>
                    </div>
                </div>
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
            
            <!-- Sidebar Search -->
            <form
                class="d-none d-sm-inline-block form-inline mr-auto ml-md-3 my-2 my-md-0 mw-100 navbar-search">
                <div class="input-group" style="margin: 10px 10px 10px -3px;">
                    <input type="text" class="form-control bg-light border-0 small" placeholder="Search for..."
                    aria-label="Search" aria-describedby="basic-addon2">
                    <div class="input-group-append">
                        <button class="btn btn-primary" type="button" style="background-color:gray;">
                           <i class="fas fa-search fa-sm"></i>
                        </button>
                    </div>
                 </div>
            </form>
                    
            <hr class="sidebar-divider d-none d-md-block">

            <!-- Sidebar Toggler (Sidebar) -->
            <div class="text-center d-none d-md-inline">
                <button class="rounded-circle border-0" id="sidebarToggle"></button>
            </div>

        </ul>

	<!-- footer 영역 -->
	<%@ include file="/WEB-INF/views/common/footer.jsp"%>
