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

					<h1 class="h3 mb-2 text-gray-800">대결자 지정</h1>
					<br>
					<c:if test="${not empty regMsg}">
						<div class="alert alert-info alert-dismissible fade show" role="alert">
							${regMsg	}
							<button type="button" class="close" data-dismiss="alert" aria-label="Close">
								<span aria-hidden="true">&times;</span>
							</button>
						</div>
					</c:if>
					<c:if test="${not empty delMsg}">
						<div class="alert alert-info alert-dismissible fade show" role="alert">
							${delMsg}
							<button type="button" class="close" data-dismiss="alert" aria-label="Close">
								<span aria-hidden="true">&times;</span>
							</button>
						</div>
					</c:if>

					<div class="card shadow mb-4">
						<div class="card-header py-3 d-flex align-items-center justify-content-between">
							<h6 class="m-0 font-weight-bold text-primary">대결자 목록</h6>
							<button class="btn btn-primary btn-sm" id="write" style="font-size: 1rem; padding: 0.25rem 0.75rem;">등록</button>

						</div>
						<div class="card-body">
							<div class="table-responsive">
								<table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
									<thead>
										<tr>
											<th>관리번호</th>
											<th>대결자</th>
											<th>시작일</th>
											<th>종료일</th>
											<th>사유</th>
										</tr>
									</thead>
									<c:forEach var="item" items="${myDelegateList}">
										<tr class="clickable-row" data-href="/approval24/delegate/${item.seqNo}" style="cursor: pointer;">
											<td>${item.seqNo }</td>
											<td>${item.delegateUserName}</td>
											<td>${item.startDt}</td>
											<td>${item.endDt}</td>
											<td>${item.proxyComment}</td>
										</tr>
									</c:forEach>
									</tbody>
								</table>
							</div>
						</div>
					</div>
				</div>

			</div>


			<%@ include file="/WEB-INF/views/common/footer.jsp"%>
			<script>
				$("#write")
						.on(
								'click',
								function() {
									window.location.href = "${pageContext.request.contextPath}/delegate/new";
								});
			</script>

		</div>
		<!-- End of Content Wrapper -->


	</div>
	<!-- End of Page Wrapper -->
	<%@ include file="/WEB-INF/views/common/logoutModal.jsp"%>
</body>
</html>
