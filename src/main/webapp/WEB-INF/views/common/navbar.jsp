<%@page pageEncoding="UTF-8" %>

<!-- Topbar -->
                <nav class="navbar navbar-expand navbar-light bg-white topbar mb-4 static-top shadow">

                    <!-- Topbar Navbar -->



	<ul class="navbar-nav ml-auto" width="100%">
<%@ include file="/WEB-INF/views/common/webSocket.jsp"%> 

	

		<!-- Nav Item - User Information -->
		<c:choose>
			<c:when test="${not empty sessionScope.user}">
				<!-- 로그인 상태 -->
				<li class="nav-item no-arrow">
					<a class="nav-link" href="/approval24/mypage" id="userDropdown" role="button" aria-haspopup="true"aria-expanded="false">
						<span class="mr-2 d-none d-lg-inline text-gray-600 fs-1">
							${logininstName} | ${logindeptName} | ${loginuserName} </span>	
						<img class="img-profile rounded-circle" src="${pageContext.request.contextPath}/resources/assets/img/undraw_profile.svg">
					</a> <!-- Dropdown -->
				</li>
			</c:when>

			<c:otherwise>
				<!-- 로그아웃 상태 (동일한 구조 유지) -->
				<li class="nav-item dropdown no-arrow">
					<a class="nav-link dropdown-toggle" href="${pageContext.request.contextPath}/login" id="userDropdown"role="button" aria-haspopup="true" aria-expanded="false">
						<span class="mr-2 d-none d-lg-inline text-gray-600 small">로그인</span>
						<img class="img-profile rounded-circle"	src="${pageContext.request.contextPath}/resources/assets/img/undraw_profile.svg">
					</a>
				</li>
			</c:otherwise>
		</c:choose>
		              
		</ul>
		
			<div class="topbar-divider d-none d-sm-block"></div>
			<ul class="navbar-nav" width="100%">
			<li class="nav-item dropdown no-arrow mx-1" id="alarm-dropdown-container">
                    <a class="nav-link dropdown-toggle" href="#" id="alarm-bell" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                        <i class="fas fa-bell fa-fw" style="font-size: 1.5rem;"></i>
                        <span class="badge badge-danger badge-counter" id="alarm-badge" style="display:none;"></span>
                    </a>
                    
                    <div class="dropdown-list dropdown-menu dropdown-menu-right shadow animated--grow-in"
                         aria-labelledby="alarm-bell" id="alarm-list-container">
                        
                        <h6 class="dropdown-header">알림 센터</h6>
                        
                        <div id="alarm-items-list" style="max-height: 300px; overflow-y: auto;">
                            <a class="dropdown-item text-center small text-gray-500">알림을 로딩 중입니다...</a>
                        </div>
                        
                    </div>
                </li>
                </ul>
				<a  href="/approval24/mypage">
					<i class="fas fa-user fa-sm fa-fw mr-2 text-gray-400"  title="내 정보"style="font-size: 24px;"></i> 
				</a>
				<a href="/approval24/logout"data-toggle="modal" data-target="#logoutModal"> 
					<i class="fas fa-sign-out-alt fa-sm fa-fw mr-2 text-gray-400"  title="로그아웃" style="font-size: 24px;"></i>
				</a>
</nav>
<!-- End of Topbar -->