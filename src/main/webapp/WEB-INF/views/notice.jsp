<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<!-- 테이블 hover -->
<style>
tbody tr:hover {
	background-color: #f5f5f5;
	color: blue;
}
</style>
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
					<h1 class="h3 mb-2 text-gray-800">공지사항</h1>
					<p class="mb-4">
						Chart.js is a third party plugin that is used to generate the charts in this theme. The charts below have been customized - for further customization options, please visit the <a target="_blank" href="https://www.chartjs.org/docs/latest/">official Chart.js documentation</a>.
					</p>

					<!-- DataTales Example -->
					<div class="card shadow mb-4">
						<div class="card-header py-3 d-flex align-items-center justify-content-between">
							<h6 class="m-0 font-weight-bold text-primary" style="line-height: 1.5;">공지사항 내역</h6>
							<!-- 글쓰기 버튼 안보이게 -->
							<c:if test="${loginUser.departmentName eq '인사팀'}">
								<button class="btn btn-primary btn-sm" style="font-size: 1rem; padding: 0.25rem 0.75rem;">글쓰기</button>
							</c:if>
						</div>
						<div class="card-body">
							<div class="table-responsive">
								<table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
									<thead>
										<tr>
											<th>번호</th>
											<th>제목</th>
											<th>첨부파일</th>
											<th>출처</th>
											<th>등록일</th>
											<th>조회수</th>
										</tr>
									</thead>
									<tbody>
										<tr class="clickable-row" data-href="/approval24/pending" style="cursor: pointer;">
											<td>12</td>
											<td>[공지] 10월 시스템 정기 점검 안내</td>
											<td></td>
											<td>인사팀_조민재</td>
											<td>2025-10-12</td>
											<td>412</td>
										</tr>
										<tr class="clickable-row" data-href="/approval24/pending" style="cursor: pointer;">
											<td>11</td>
											<td>[알림] 실업급여 신청 절차 개선사항 안내</td>
											<td></td>
											<td>인사팀_한유진</td>
											<td>2025-10-11</td>
											<td>367</td>
										</tr>
										<tr class="clickable-row" data-href="/approval24/pending" style="cursor: pointer;">
											<td>10</td>
											<td>[안내] 홈페이지 접속 지연 현상 복구 완료</td>
											<td></td>
											<td>인사팀_이도현</td>
											<td>2025-10-10</td>
											<td>298</td>
										</tr>
										<tr class="clickable-row" data-href="/approval24/pending" style="cursor: pointer;">
											<td>9</td>
											<td>[공지] 실업급여 수급자 교육 일정 변경 안내</td>
											<td></td>
											<td>인사팀_정하은</td>
											<td>2025-10-09</td>
											<td>425</td>
										</tr>
										<tr class="clickable-row" data-href="/approval24/pending" style="cursor: pointer;">
											<td>8</td>
											<td>[공지] 전산 시스템 보안 업데이트 공지</td>
											<td></td>
											<td>인사팀_박서준</td>
											<td>2025-10-08</td>
											<td>353</td>
										</tr>
										<tr class="clickable-row" data-href="/approval24/pending" style="cursor: pointer;">
											<td>7</td>
											<td>[안내] 실업급여 상담센터 운영시간 단축 안내</td>
											<td></td>
											<td>인사팀_윤지호</td>
											<td>2025-10-07</td>
											<td>287</td>
										</tr>
										<tr class="clickable-row" data-href="/approval24/pending" style="cursor: pointer;">
											<td>6</td>
											<td>[공지] 실업급여 구직활동 인정 기준 변경사항</td>
											<td></td>
											<td>인사팀_김나연</td>
											<td>2025-10-06</td>
											<td>404</td>
										</tr>
										<tr class="clickable-row" data-href="/approval24/pending" style="cursor: pointer;">
											<td>5</td>
											<td>[알림] 10월 공휴일 고객센터 휴무 안내</td>
											<td></td>
											<td>인사팀_최민호</td>
											<td>2025-10-05</td>
											<td>318</td>
										</tr>
										<tr class="clickable-row" data-href="/approval24/pending" style="cursor: pointer;">
											<td>4</td>
											<td>[공지] 실업급여 신청서 양식 변경 안내</td>
											<td></td>
											<td>인사팀_이수진</td>
											<td>2025-10-04</td>
											<td>459</td>
										</tr>
										<tr class="clickable-row" data-href="/approval24/pending" style="cursor: pointer;">
											<td>3</td>
											<td>[안내] 모바일 신청 서비스 점검 예정 (10/6 새벽)</td>
											<td></td>
											<td>인사팀_박준혁</td>
											<td>2025-10-03</td>
											<td>342</td>
										</tr>
										<tr class="clickable-row" data-href="/approval24/pending" style="cursor: pointer;">
											<td>2</td>
											<td>[공지] 개인정보 처리방침 개정 안내</td>
											<td></td>
											<td>인사팀_김서연</td>
											<td>2025-10-02</td>
											<td>271</td>
										</tr>
										<tr class="clickable-row" data-href="/approval24/pending" style="cursor: pointer;">
											<td>1</td>
											<td>[알림] 실업급여 지급 일정 공지 (10월분)</td>
											<td></td>
											<td>인사팀_정동윤</td>
											<td>2025-10-01</td>
											<td>496</td>
										</tr>

										<%-- <c:forEach var="item" items="${list}">
											<tr>
												<td>${item.mainCode}</td>
														<td>${item.productName}</td>
												<td>${item.manufacturerName}</td>
												<td>${item.quantity}</td>
												<td>${item.transactionType}</td>
												<td>${item.transactionDate}</td>
											</tr>
										</c:forEach> --%>

									</tbody>
								</table>
							</div>
						</div>
					</div>

				</div>
				<!-- /.container-fluid -->

			</div>
			<!-- End of Main Content -->

			<!-- Footer -->
			<footer class="sticky-footer bg-white">
				<div class="container my-auto">
					<div class="copyright text-center my-auto">
						<span>Copyright &copy; Your Website 2020</span>
					</div>
				</div>
			</footer>
			<!-- End of Footer -->

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
	<script src="resources/assets/js/demo/chart-bar-demo.js"></script>

	<script>
		$(document).on(
				'click',
				'#dataTable tbody tr.clickable-row',
				function(e) {
					if ($(e.target).closest(
							'a, button, input, [data-no-row-click]').length)
						return;

					const url = $(this).data('href');
					if (url) {
						window.location.assign(url);
					}
				});
	</script>


</body>
</html>