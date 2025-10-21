<%@page pageEncoding="UTF-8" %>
<!-- Sidebar -->
        <ul class="navbar-nav bg-gradient-primary sidebar sidebar-dark accordion" id="minwonSidebar">

            <!-- Sidebar - Brand -->
            <div class="gyeolje24" style="background-color: white;">
            <a class="sidebar-brand d-flex align-items-center justify-content-center text-dark" href="/approval24/">
                <div class="sidebar-brand-icon rotate-n-15">
                    <img src="${pageContext.request.contextPath}/resources/assets/img/work24.png" width= 40px;>
                </div>
                <div class="sidebar-brand-text mx-3">결재24</div>
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
            
           <!-- 임시 카피 -->
           <li class="nav-item">
                <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">
                   <img src="${pageContext.request.contextPath}/resources/assets/img/side_search.svg" class="nav-icon-blur" style="width: 18px; margin-right: 3px;">
                    <span>계정관리</span>
                </a>
                <div id="collapseTwo" class="collapse" aria-labelledby="headingTwo" data-parent="#minwonSidebar" style="">
                    <div class="bg-white py-2 collapse-inner rounded">
                        <h6 class="collapse-header">처리현황</h6>
                         <a class="collapse-item" href="/approval24/tables">대기</a>
                        <a class="collapse-item" href="/approval24/benefits">반려</a>
                        <a class="collapse-item" href="/approval24/tables">승인</a>
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

            <!-- Sidebar Toggler (Sidebar) -->
            <div class="text-center d-none d-md-inline">
                <button class="rounded-circle border-0" id="sidebarToggle"></button>
            </div>
            
            <li class="nav-item" style="position: sticky; top:4000px;">
                <a class="nav-link" href="/approval24/regist">
                    <img src="${pageContext.request.contextPath}/resources/assets/img/add_user.svg" class="nav-icon-blur" style="width: 18px; margin-right: 3px;">
                    <span>계정신청</span></a>
            </li>

        </ul>
        



