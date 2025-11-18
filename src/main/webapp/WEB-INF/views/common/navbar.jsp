<%@page pageEncoding="UTF-8" %>
<!-- Topbar -->
                <nav class="navbar navbar-expand navbar-light bg-white topbar mb-4 static-top shadow">

                    <!-- Topbar Navbar -->



	<ul class="navbar-nav ml-auto" width="100%">


	

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
				<a  href="/approval24/mypage">
					<i class="fas fa-user fa-sm fa-fw mr-2 text-gray-400"  title="내 정보"style="font-size: 24px;"></i> 
				</a>
				<a href="/approval24/logout"data-toggle="modal" data-target="#logoutModal"> 
					<i class="fas fa-sign-out-alt fa-sm fa-fw mr-2 text-gray-400"  title="로그아웃" style="font-size: 24px;"></i>
				</a>




</nav>
<!-- End of Topbar -->