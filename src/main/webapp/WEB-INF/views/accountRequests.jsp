<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<title>계정 신청 목록 | 결재24</title>
<style>
.badge-wait {
	background: #f6c23e;
	color: #212529;
} /* 대기 */
.badge-approve {
	background: #1cc88a;
} /* 승인 */
.badge-reject {
	background: #e74a3b;
} /* 반려 */
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
					<div class="d-flex align-items-center justify-content-between mb-4">
						<h1 class="h3 text-gray-800 m-0">계정 신청 승인</h1>
						
					</div>

					<!-- Table -->
					<div class="card shadow mb-4">
						<div class="card-header py-3 d-flex align-items-center justify-content-between">
							<h6 class="m-0 font-weight-bold text-primary">신청 목록</h6>
						</div>
						<div class="card-body">
							<div class="table-responsive">
								<table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
									<thead>
										<tr>
											<th>신청번호</th>
											<th>신청자</th>
											<th>부서</th>
											<th>요청 권한</th>
											<th>로그인ID</th>
											<th>신청일</th>

											<th>비고</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach var="req" items="${requests}">
											<tr class="clickable-row" data-href="${pageContext.request.contextPath}/approval24/account/requests/${req.requestId}" style="cursor: pointer;">
												<td>${req.requestId}</td>
												<td>${req.userName}</td>
												<td>${req.orgName}/ ${req.deptName}</td>
												<td>${req.requestAuthName}</td>
												<td>${req.loginId}</td>
												<td>${req.requestedAt}</td>
												<td>${empty req.processedBy ? '-' : req.processedBy}</td>
												<td>${empty req.processedAt ? '-' : req.processedAt}</td>
											</tr>
										</c:forEach>

										<!-- 더미 데이터 (백엔드 연결 전 테스트용) -->
										<c:if test="${empty requests}">
											<tr class="clickable-row" data-href="${pageContext.request.contextPath}/account/auth" style="cursor: pointer;">
												<td>REQ-20251022001</td>
												<td>홍길동</td>
												<td>서울센터 / 인사팀</td>
												<td>HR</td>
												<td>honggd</td>
												<td>2025-10-22</td>
												<td></td>


											</tr>
											<tr class="clickable-row" data-href="${pageContext.request.contextPath}/account/auth" style="cursor: pointer;">
												<td>REQ-20251021003</td>
												<td>김철수</td>
												<td>부산센터 / 민원팀</td>
												<td>Reviewer</td>
												<td>kimcs</td>
												<td>2025-10-21</td>
												<td></td>

											</tr>
											<tr class="clickable-row" data-href="${pageContext.request.contextPath}/account/auth" style="cursor: pointer;">
												<td>REQ-20251020007</td>
												<td>이영희</td>
												<td>대구센터 / 운영팀</td>
												<td>MANAGER</td>
												<td>leeyh</td>
												<td>2025-10-20</td>
												<td></td>
											</tr>
										</c:if>
									</tbody>
								</table>
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