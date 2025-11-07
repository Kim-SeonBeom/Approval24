<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
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
					<h1 class="h3 mb-2 text-gray-800">${title }</h1>
					<br>

					<div class="card shadow mb-4">
						<div class="card-header py-3">
							<h6 class="m-0 font-weight-bold text-primary">검색 및 필터링</h6>
						</div>
						<div class="card-body">
							<form id="userFilterForm" action="${pageContext.request.contextPath}/user/list" method="get">
								<div class="form-row align-items-end">

									<div class="col-md-3 mb-3">
										<label for="complainCategory">민원서식</label> <input type="text" class="form-control" id="userNameFilter" name="userName" value="${filter.userName}" placeholder="이름 입력">
									</div>
									<div class="col-md-3 mb-3">
										<label for="complainUserName">신청자</label> <input type="email" class="form-control" id="userEmailFilter" name="userEmail" value="${filter.userEmail}" placeholder="이메일 입력">
									</div>
									<div class="col-md-3 mb-3">
										<label for="manager">담당자</label> <input type="email" class="form-control" id="userEmailFilter" name="userEmail" value="${filter.userEmail}" placeholder="이메일 입력">
									</div>
									<div class="col-md-3 mb-3">
										<label for="compainStatus">상태</label> <input type="email" class="form-control" id="userEmailFilter" name="userEmail" value="${filter.userEmail}" placeholder="이메일 입력">
									</div>

									<div class="col-md-2 mb-3">
										<button class="btn btn-primary btn-block" type="submit">검색</button>
									</div>
								</div>
							</form>
						</div>
					</div>

					<!-- DataTales Example -->
					<div class="card shadow mb-4">
						<div class="card-header py-3">
							<h6 class="m-0 font-weight-bold text-primary">민원목록</h6>
						</div>
						<div class="card-body">
							<div class="table-responsive">
								<table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
									<thead>
										<tr>
											<th>접수번호</th>
											<th>민원서식</th>
											<th>신청자</th>
											<th>담당자</th>
											<th>상태</th>
											<th>신청일</th>
											<th>마감일</th>
										</tr>
									</thead>
									<c:forEach var="item" items="${complainList}">

										<tr class="clickable-row" data-href="/approval24/${item.categoryUrl}/${item.complainId}" style="cursor: pointer;">
											<td>${item.complainId}</td>
											<td>${item.categoryName}</td>
											<td>${item.complainuserName}</td>
											<td>${item.userName}</td>
											<td>${item.complainStatusCd}</td>
											<td>${item.rcptDt}</td>
											<td>${item.deadlineDt}</td>
										</tr>
									</c:forEach>

									</tbody>
								</table>
							</div>
						</div>
					</div>

				</div>
				<!-- /.container-fluid -->

			</div>
			<!-- End of Main Content -->


		</div>
		<!-- End of Content Wrapper -->

	</div>
	<!-- End of Page Wrapper -->

	<!-- Scroll to Top Button-->
	<a class="scroll-to-top rounded" href="#page-top"> <i class="fas fa-angle-up"></i>
	</a>
	<!-- Logout Modal-->
	<%@ include file="/WEB-INF/views/common/logoutModal.jsp"%>
	<!-- footer 영역 -->
	<%@ include file="/WEB-INF/views/common/footer.jsp"%>

</body>

</html>