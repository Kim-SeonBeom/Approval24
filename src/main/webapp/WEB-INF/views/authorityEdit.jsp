<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
</head>
<body id="page-top">

<div id="wrapper">
	<%@ include file="/WEB-INF/views/common/sidebar.jsp"%>

	<div id="content-wrapper" class="d-flex flex-column">
		<div id="content">
			<%@ include file="/WEB-INF/views/common/navbar.jsp"%>

			<div class="container-fluid">
				<h1 class="h3 mb-4 text-gray-800">권한 수정</h1>

				<div class="card shadow mb-4">
					<div class="card-body">
						<form id="authorityForm">
							<div class="form-group">
								<label>권한 이름</label>
								<input type="text" class="form-control" value="인사관리권한">
							</div>

							<hr>

							<h5 class="mb-3">메뉴별 권한</h5>
							<table class="table table-bordered">
								<thead>
									<tr>
										<th>메뉴명</th>
										<th>조회</th>
										<th>수정</th>
										<th>삭제</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td>직원 관리</td>
										<td><input type="checkbox" checked></td>
										<td><input type="checkbox" checked></td>
										<td><input type="checkbox"></td>
									</tr>
									<tr>
										<td>근태 관리</td>
										<td><input type="checkbox" checked></td>
										<td><input type="checkbox"></td>
										<td><input type="checkbox"></td>
									</tr>
								</tbody>
							</table>

							<div class="text-right">
								<button type="button" id="saveBtn" class="btn btn-primary">저장</button>
								<a href="${pageContext.request.contextPath}/authority/list" class="btn btn-secondary">취소</a>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>

	</div>
</div>

<%@ include file="/WEB-INF/views/common/logoutModal.jsp"%>
<%@ include file="/WEB-INF/views/common/footer.jsp"%>

<script>
$("#saveBtn").on("click", function() {
	alert("권한이 수정되었습니다. (더미)");
	window.location.href = "${pageContext.request.contextPath}/authority/list";
});
</script>
</body>
</html>
