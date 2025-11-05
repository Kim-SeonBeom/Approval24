<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지</title>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
</head>
<body id="page-top">

	<!-- Page Wrapper -->
	<div id="wrapper">

		<!-- Sidebar -->
		<%@ include file="/WEB-INF/views/common/sidebar.jsp"%>
		<!-- End of Sidebar -->

		<!-- Content Wrapper -->
		<div id="content-wrapper" class="d-flex flex-column">

			<!-- Main Content -->
			<div id="content">

				<!-- Topbar -->
				<%@ include file="/WEB-INF/views/common/navbar.jsp"%>
				<!-- End of Topbar -->

				<!-- Begin Page Content -->
				<div class="container-fluid">

					<!-- Page Heading -->
					<div class="d-sm-flex align-items-center justify-content-between mb-4">
						<h1 class="h3 mb-0 text-gray-800">직원 등록</h1>
					</div>

					<!-- 사용자 등록 card -->
					<div class="card shadow mb-4">

						<!-- 프로필 card -->
						<div class="card-body">
							<div class="row align-items-start">
								<!-- 개인 정보들 -->
								<div class="col-lg-6 col-md-4 col-12 d-flex  justify-content-center align-items-center " style="margin-top: 80px;">
									<div class="w-100">
										<h6 class="text-dark font-weight-bold">직원정보</h6>
										<table class="table table-bordered" id="dataTable_mypage1" width="100%" cellspacing="0">
											<tbody>
												<tr>
													<td class="text-dark bg-light  font-weight-bold" style="width: 25%;">이름</td>
													<td>{userName}</td>
												</tr>
												<tr>
													<td class="text-dark bg-light font-weight-bold " style="width: 25%;">기관이름</td>
													<td>{logindeptName}</td>
												</tr>
												<tr>
													<td class="text-dark bg-light font-weight-bold " style="width: 25%;">부서</td>
													<td>{deptName}</td>
												</tr>
												<tr>
													<td class="text-dark bg-light  font-weight-bold" style="width: 25%;">직책</td>
													<td>{userPositionCd}</td>
												</tr>
												<tr>
													<td class="text-dark bg-light font-weight-bold" style="width: 25%;">전화번호</td>
													<td>{userPhone}</td>
												</tr>
												<tr>
											</tbody>
										</table>
									</div>
								</div>
							</div>

						</div>
					</div>

				</div>
			</div>

		</div>

	</div>
	<!-- Logout Modal-->
	<%@ include file="/WEB-INF/views/common/logoutModal.jsp"%>
	<!-- footer 영역 -->
	<%@ include file="/WEB-INF/views/common/footer.jsp"%>
</body>
</html>