<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>대결자 지정</title>
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
					<h1 class="h3 mb-4 text-gray-800">대결자 지정</h1>

					<!-- 대결자 지정 폼 -->
					<div class="card shadow mb-4">
						<div class="card-header py-3">
							<h6 class="m-0 font-weight-bold text-primary">대결자 등록</h6>
						</div>
						<div class="card-body">
							<form>
								<div class="form-row align-items-end">
									<div class="col-md-4 mb-3">
										<label>대결 시작일</label>
										<input type="date" class="form-control" value="2025-10-22">
									</div>
									<div class="col-md-4 mb-3">
										<label>대결 종료일</label>
										<input type="date" class="form-control" value="2025-10-26">
									</div>
									<div class="col-md-4 mb-3">
										<label>부서</label>
										<select class="form-control">
											<option>민원1팀</option>
											<option>민원2팀</option>
											<option>민원3팀</option>
											<option>인사팀</option>
										</select>
									</div>
									<div class="col-md-4 mb-3">
										<label>대결자</label>
										<select class="form-control">
											<option>홍길동</option>
											<option>이수진</option>
											<option>김서연</option>
											<option>박준혁</option>
										</select>
									</div>
								</div>
								<button type="submit" class="btn btn-primary">등록</button>
							</form>
						</div>
					</div>

					<!-- 대결자 내역 -->
					<div class="card shadow mb-4">
						<div class="card-header py-3 d-flex justify-content-between align-items-center">
							<h6 class="m-0 font-weight-bold text-primary">대결자 내역</h6>
						</div>
						<div class="card-body">
							<div class="table-responsive">
								<table class="table table-bordered" width="100%" cellspacing="0">
									<thead>
										<tr>
											<th>번호</th>
											<th>대결자</th>
											<th>시작일</th>
											<th>종료일</th>
											<th>상태</th>
											<th>비고</th>
										</tr>
									</thead>
									<tbody>
										<tr>
											<td>1</td>
											<td>홍길동</td>
											<td>2025-10-20</td>
											<td>2025-10-22</td>
											<td>기간 만료</td>
											<td></td>
										</tr>
										<tr>
											<td>2</td>
											<td>이수진</td>
											<td>2025-10-23</td>
											<td>2025-10-26</td>
											<td>진행 중</td>
											<td>
												<button class="btn btn-warning btn-sm">수정</button>
												<button class="btn btn-danger btn-sm">삭제</button>
											</td>
										</tr>
										<tr>
											<td>3</td>
											<td>김서연</td>
											<td>2025-10-28</td>
											<td>2025-10-30</td>
											<td>예정</td>
											<td>
												<button class="btn btn-warning btn-sm">수정</button>
												<button class="btn btn-danger btn-sm">삭제</button>
											</td>
										</tr>
									</tbody>
								</table>
							</div>
						</div>
					</div>

				</div>
				<!-- /.container-fluid -->

			</div>
			<!-- End of Main Content -->

			<%@ include file="/WEB-INF/views/common/footer.jsp"%>

		</div>
		<!-- End of Content Wrapper -->

	</div>
	<!-- End of Page Wrapper -->

	<%@ include file="/WEB-INF/views/common/logoutModal.jsp"%>
</body>
</html>
