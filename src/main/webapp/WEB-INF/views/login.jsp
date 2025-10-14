<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
<title>로그인</title>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
</head>

<body class="bg-light" style="background: linear-gradient(to right, #126C83, #74BCAA); height: 100vh;">

<div class="h-100 d-flex flex-column justify-content-center">
	<div class="container">

		<!-- Outer Row -->
		<div class="row justify-content-center align-items-center">

			<div class="col-xl-10 col-lg-12 col-md-9">

				<div class="card o-hidden border-0 shadow-lg my-5 " >
					<div class="card-body p-0 h-100">
						<!-- Nested Row within Card Body -->
						<div class="row h-100">
							<div
								class="col-lg-6 d-none d-lg-flex bg-login-image d-flex justify-content-center align-items-center h-100">
								<img
									src="${pageContext.request.contextPath}/resources/assets/img/two_go_dragon.png"
									class="w-50" />
							</div>
							<div class="col-lg-6">
								<div class="p-5">
									<div class="text-center">
										<h1 class="h4 text-gray-900 mb-4">고용24</h1>
									</div>
									<form class="user">
										<div class="form-group">
											<input type="id" class="form-control form-control-user"
												id="InputId" aria-describedby="IdHelp" placeholder="아이디">
										</div>
										<div class="form-group">
											<input type="password" class="form-control form-control-user"
												id="InputPassword" placeholder="비밀번호">
										</div>
										<a href="/approval24/"
											class="btn btn-success btn-user btn-block"> 로그인 </a>
										<hr>
									</form>
									<div class="text-center">
										<a class="small" href="forgot-password.html">비밀번호를 잊으셨나요?</a>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>

			</div>

		</div>

	</div>
	</div>

	<%@ include file="/WEB-INF/views/common/footer.jsp"%>
</body>

</html>