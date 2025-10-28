<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<title>공지사항</title>
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
					<br>

					<!-- DataTales Example -->
					<div class="card shadow mb-4">
						<div class="card-header py-3 d-flex align-items-center justify-content-between">
							<h6 class="m-0 font-weight-bold text-primary" style="line-height: 1.5;">공지사항 내역</h6>
							<!-- 글쓰기 버튼 안보이게 -->
							<c:if test="${loginUser.departmentName eq '인사팀'}">
								<button class="btn btn-primary btn-sm" id="noticeWrite" style="font-size: 1rem; padding: 0.25rem 0.75rem;">글쓰기</button>
							</c:if>
						</div>
						<div class="card-body">
							<div class="table-responsive">
								<table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
									<thead>
										<tr>
											<th>번호</th>
											<th>제목</th>
											<th>카테고리</th>
											<th>등록인</th>
											<th>등록일</th>
											<th>조회수</th>
										</tr>
									</thead>
									<tbody>

										<c:forEach var="notice" items="${noticeList}">
											<tr class="clickable-row" data-href="${pageContext.request.contextPath}/notice/detail/${notice.noticeId}" style="cursor: pointer;">
												<td>${notice.noticeId}</td>
												<td>${notice.title}</td>
												<td>${notice.categoryCd}</td>
												<td>${notice.userName}</td>
												<td><fmt:formatDate value="${notice.createDt}" pattern="yyyy'년  'MM'월 ' dd'일'"/></td>
												<td>${notice.viewAccount}</td>
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

			<!-- Footer -->
			<footer class="sticky-footer bg-white">
				<div class="container my-auto">
					<div class="copyright text-center my-auto">
						<span>Copyright &copy; 결재24 2025</span>
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
		$("#noticeWrite").on('click', function() {
			window.location.href="${pageContext.request.contextPath}/notice/new";
		});
	</script>


</body>
</html>