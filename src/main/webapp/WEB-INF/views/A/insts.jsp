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
					<h1 class="h3 mb-2 text-gray-800">기관 목록</h1>
					<br>
					<%-- 컨트롤러에서 전달받은 삭제 메시지 표시 --%>
					<c:if test="${not empty delMessage}">
					    <div class="alert alert-info alert-dismissible fade show" role="alert">
					        ${delMessage}
					        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
					            <span aria-hidden="true">&times;</span>
					        </button>
					    </div>
					</c:if>
					<c:if test="${not empty insertMessage}">
					    <div class="alert alert-info alert-dismissible fade show" role="alert">
					        ${insertMessage}
					        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
					            <span aria-hidden="true">&times;</span>
					        </button>
					    </div>
					</c:if>

					<!-- DataTales Example -->
					<div class="card shadow mb-4">
						<div class="card-header py-3 d-flex align-items-center justify-content-between">
							<h6 class="m-0 font-weight-bold text-primary">기관 테이블</h6>
							<button class="btn btn-primary btn-sm" id="instsCreate" style="font-size: 1rem; padding: 0.25rem 0.75rem;">+ 기관 등록</button>
						</div>
						<div class="card-body">
							<div class="table-responsive">
								<table class="table table-bordered" id="dataTable" style="width:100%" cellspacing="0">
									<thead>
										<tr>
											<th>기관명</th>
											<th>대표자명</th>
											<th>기관 주소</th>
											<th>기관 연락처</th>
											<th>등록일</th>
											<th>수정일</th>
										</tr>
									</thead>
									<tbody>
									  <c:forEach var="inst" items="${getAllList}">
									    <tr class="clickable-row"
									        data-href="/approval24/admin/insts/detail?inst_id=${inst.instId}"
									        style="cursor:pointer;">
									      <td>${inst.instName}</td>
									      <td>${inst.instHeadName}</td>
									      <td>${inst.instAddress}</td>
									      <td>${inst.instPhone}</td>
									      <td>${inst.createDt}</td>
									      <td>${inst.updateDt}</td>
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
		$("#instsCreate").on('click', function() {
			window.location.href="${pageContext.request.contextPath}/admin/insts/new";
		});
	</script>

</body>

</html>