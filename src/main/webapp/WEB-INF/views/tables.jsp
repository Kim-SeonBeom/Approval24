<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
		<%@ include file="/WEB-INF/views/common/sidebar_dropdown.jsp"%>
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
					<h1 class="h3 mb-2 text-gray-800">실업급여</h1>
					<br>

					<!-- DataTales Example -->
					<div class="card shadow mb-4">
						<div class="card-header py-3">
							<h6 class="m-0 font-weight-bold text-primary">대기 민원내역</h6>
						</div>
						<div class="card-body">
							<div class="table-responsive">
								<table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
									<thead>
										<tr>
											<th>접수번호</th>
											<th>신청명</th>
											<th>신청자</th>
											<th>상태</th>
											<th>신청일</th>
											<th>마감일</th>
										</tr>
									</thead>
									<tbody>
										<tr class="clickable-row" data-href="/approval24/pending" style="cursor: pointer;">
											<td>2058230690</td>
											<td>실업급여 신규 신청</td>
											<td>정동윤</td>
											<td>대기</td>
											<td>2025-10-13</td>
											<td>2025-11-22</td>
										</tr>
										<tr class="clickable-row" data-href="/approval24/pending" style="cursor: pointer;">
											<td>2058230691</td>
											<td>실업급여 재신청</td>
											<td>김서연</td>
											<td>대기</td>
											<td>2025-10-14</td>
											<td>2025-11-23</td>
										</tr>
										<tr class="clickable-row" data-href="/approval24/pending" style="cursor: pointer;">
											<td>2058230692</td>
											<td>실업급여 지급 연장 요청</td>
											<td>박준혁</td>
											<td>대기</td>
											<td>2025-10-15</td>
											<td>2025-11-24</td>
										</tr>
										<tr class="clickable-row" data-href="/approval24/pending" style="cursor: pointer;">
											<td>2058230693</td>
											<td>실업급여 재심사 신청</td>
											<td>이수진</td>
											<td>대기</td>
											<td>2025-10-16</td>
											<td>2025-11-25</td>
										</tr>
										<tr class="clickable-row" data-href="/approval24/pending" style="cursor: pointer;">
											<td>2058230694</td>
											<td>실업급여 수급자격 변경신청</td>
											<td>최민호</td>
											<td>대기</td>
											<td>2025-10-17</td>
											<td>2025-11-26</td>
										</tr>
										<tr class="clickable-row" data-href="/approval24/pending" style="cursor: pointer;">
											<td>2058230695</td>
											<td>실업급여 중지 해제 신청</td>
											<td>김나연</td>
											<td>대기</td>
											<td>2025-10-18</td>
											<td>2025-11-27</td>
										</tr>
										<tr class="clickable-row" data-href="/approval24/pending" style="cursor: pointer;">
											<td>2058230696</td>
											<td>실업급여 구직활동 인정신청</td>
											<td>윤지호</td>
											<td>대기</td>
											<td>2025-10-19</td>
											<td>2025-11-28</td>
										</tr>
										<tr class="clickable-row" data-href="/approval24/pending" style="cursor: pointer;">
											<td>2058230697</td>
											<td>실업급여 수급기간 연장신청</td>
											<td>박서준</td>
											<td>대기</td>
											<td>2025-10-20</td>
											<td>2025-11-29</td>
										</tr>
										<tr class="clickable-row" data-href="/approval24/pending" style="cursor: pointer;">
											<td>2058230698</td>
											<td>실업급여 지급 재개 신청</td>
											<td>정하은</td>
											<td>대기</td>
											<td>2025-10-21</td>
											<td>2025-11-30</td>
										</tr>
										<tr class="clickable-row" data-href="/approval24/pending" style="cursor: pointer;">
											<td>2058230699</td>
											<td>실업급여 신청서 수정요청</td>
											<td>이도현</td>
											<td>대기</td>
											<td>2025-10-22</td>
											<td>2025-12-01</td>
										</tr>
										<tr class="clickable-row" data-href="/approval24/pending" style="cursor: pointer;">
											<td>2058230700</td>
											<td>실업급여 추가서류 제출신청</td>
											<td>한유진</td>
											<td>대기</td>
											<td>2025-10-23</td>
											<td>2025-12-02</td>
										</tr>
										<tr class="clickable-row" data-href="/approval24/pending" style="cursor: pointer;">
											<td>2058230701</td>
											<td>실업급여 상담신청</td>
											<td>조민재</td>
											<td>대기</td>
											<td>2025-10-24</td>
											<td>2025-12-03</td>
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