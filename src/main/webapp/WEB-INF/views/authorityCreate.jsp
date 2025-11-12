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
				<h1 class="h3 mb-4 text-gray-800">권한 생성</h1>

				<div class="card shadow mb-4">
					<div class="card-body">
						<form id="createForm">
							<div class="form-group">
								<label>권한 이름</label>
								<input type="text" class="form-control" placeholder="예: 근태관리권한">
							</div>

							<div class="form-group">
								<label>부서 선택</label>
								<select class="form-control">
									<option>인사팀</option>
									<option>총무팀</option>
									<option>전산팀</option>
								</select>
							</div>

							<div class="form-group">
								<label>메뉴 선택</label>
								<select class="form-control">
									<option>직원 관리</option>
									<option>근태 관리</option>
									<option>급여 관리</option>
								</select>
							</div>

							<hr>

							<h5 class="mb-3">가능 여부</h5>
							<div class="form-check">
								<input class="form-check-input" type="checkbox" id="viewCheck">
								<label class="form-check-label" for="viewCheck">조회 가능</label>
							</div>
							<div class="form-check">
								<input class="form-check-input" type="checkbox" id="editCheck">
								<label class="form-check-label" for="editCheck">수정 가능</label>
							</div>
							<div class="form-check">
								<input class="form-check-input" type="checkbox" id="deleteCheck">
								<label class="form-check-label" for="deleteCheck">삭제 가능</label>
							</div>

							<div class="text-right mt-4">
								<button type="button" id="createBtn" class="btn btn-success">생성</button>
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
$("#createBtn").on("click", function() {
	alert("새 권한이 생성되었습니다. (더미)");
	window.location.href = "${pageContext.request.contextPath}/authority/list";
});
</script>
</body>
</html>