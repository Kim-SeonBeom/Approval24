<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<title>계정 신청 | 결재24</title>
<style>
.required::after {
	content: " *";
	color: #e74a3b;
}

.form-hint {
	font-size: .85rem;
	color: #858796;
}

.roles-box {
	max-height: 200px;
	overflow: auto;
	border: 1px solid #e3e6f0;
	border-radius: .35rem;
	padding: .5rem;
}
</style>
</head>
<body id="page-top">
	<div id="wrapper">

		<%@ include file="/WEB-INF/views/common/sidebar.jsp"%>

		<div id="content-wrapper" class="d-flex flex-column">
			<div id="content">

				<%@ include file="/WEB-INF/views/common/navbar.jsp"%>

				<div class="container-fluid">

					<!-- Page Heading -->
					<div class="d-sm-flex align-items-center justify-content-between mb-4">
						<h1 class="h3 mb-0 text-gray-800">계정 신청</h1>
					</div>

					<!-- Card -->
					<div class="row justify-content-center">
					
						<div class="col-lg-10 col-xl-10">
							<div class="card shadow mb-4">
								<div class="card-header py-3 d-flex justify-content-between align-items-center">
									<h6 class="m-0 font-weight-bold text-primary">신규 계정 신청</h6>
								</div>
								<div class="card-body">
									<form id="signupForm" method="post" action="/approval24/account/signup">

										<!-- 1) 소속 정보 -->
										<div class="mb-3">
											<label for="orgId" class="required">기관</label> <select class="form-control" id="orgId" name="orgId" required>
												<option value="">기관을 선택하세요</option>
											</select>
										</div>

										<div class="mb-3">
											<label for="deptId" class="required">부서</label> <select class="form-control" id="deptId" name="deptId" required>
												<option value="">부서를 선택하세요</option>
											</select>
										</div>

										<div class="mb-3">
											<label class="required">권한</label> <select class="form-control" id="authId" name="authId" required>
												<option value="">요청 하실 권한을 선택하세요.</option>
											</select>
										</div>

										<hr>

										<!-- 2) 사용자 정보 -->
										<div class="form-row">
											<div class="form-group col-md-6">
												<label for="userName" class="required">이름</label> <input type="text" class="form-control" id="userName" name="userName" required>
											</div>
											<div class="form-group col-md-6">
												<label for="phone" class="required">휴대전화</label> <input type="tel" class="form-control" id="phone" name="phone" placeholder="010-1234-5678" required>
											</div>
										</div>

										<div class="form-row">
											<div class="form-group col-md-6">
												<label for="email" class="required">사원번호</label> <input type="email" class="form-control" id="email" name="email" required>
											</div>
											<div class="form-group col-md-6">
												<label for="loginId" class="required">로그인 아이디</label> <input type="text" class="form-control" id="loginId" name="loginId" autocomplete="username" required>

											</div>
										</div>

										<!-- 3) 로그인 정보 -->
										<div class="form-row">
											<div class="form-group col-md-6">
												<label for="password" class="required">비밀번호</label> <input type="password" class="form-control" id="password" name="password" autocomplete="new-password" required>
											</div>
											<div class="form-group col-md-6">
												<label for="passwordConfirm" class="required">비밀번호 확인</label> <input type="password" class="form-control" id="passwordConfirm" required>
												<div id="pwMatch" class="small mt-1"></div>
											</div>
										</div>

										<!-- 숨겨진 상태값 (이번 버전: 즉시 활성) -->
										<!-- <input type="hidden" name="accountStatus" value="ACTIVE"> -->

										<div class="d-flex justify-content-between">
											<a href="/approval24/" class="btn btn-light"> <i class="fas fa-arrow-left mr-1"></i> 취소
											</a>
											<button type="submit" class="btn btn-primary" id="submitBtn">
												<i class="fas fa-user-plus mr-1"></i> 계정 신청
											</button>
										</div>
									</form>
								</div>
							</div>

						</div>
					</div>

				</div>
				<!-- /.container-fluid -->
			</div>
			<!-- /#content -->

			<%@ include file="/WEB-INF/views/common/footer.jsp"%>
		</div>
		<!-- /#content-wrapper -->
	</div>
	<!-- /#wrapper -->
	<%@ include file="/WEB-INF/views/common/logoutModal.jsp"%>
</body>
</html>