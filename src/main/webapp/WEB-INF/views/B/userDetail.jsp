<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<style>
/* 수정 가능한 input/select의 스타일을 명확히 표시 */
.form-control
:not
 
(
[
readonly
]
 
)
{
background-color
:
 
#fff
;

	
border-color
:
 
#80bdff
;


}
.form-control[readonly] {
	background-color: #e9ecef;
}
</style>
</head>
<body id="page-top">

	<div id="wrapper">
		<%@ include file="/WEB-INF/views/common/sidebar.jsp"%>

		<div id="content-wrapper" class="d-flex flex-column">
			<div id="content">
				<%@ include file="/WEB-INF/views/common/navbar.jsp"%>

				<div class="container-fluid">
					<h1 class="h3 mb-4 text-gray-800">사용자 상세/수정</h1>
					<br>

					<c:if test="${not empty successMessage}">
						<div class="alert alert-success" role="alert">${successMessage}</div>
					</c:if>
					<c:if test="${not empty errorMessage}">
						<div class="alert alert-danger" role="alert">${errorMessage}</div>
					</c:if>

					<form id="userEditForm" action="${pageContext.request.contextPath}/user/edit" method="post">
						<input type="hidden" name="userNo" value="${user.userNo}">

						<div class="card shadow mb-4">
							<div class="card-header py-3">
								<h6 class="m-0 font-weight-bold text-primary">기본 정보 수정: ${user.userName}</h6>
							</div>
							<div class="card-body">

								<div class="table-responsive">
									<table class="table table-bordered" style="width: 100%; max-width: 800px;">
										<colgroup>
											<col style="width: 20%;">
											<col style="width: 30%;">
											<col style="width: 20%;">
											<col style="width: 30%;">
										</colgroup>
										<tbody>
											<tr>
												<th>사번</th>
												<td><input type="text" class="form-control" value="${user.userNo}" readonly></td>

												<th>주민등록번호</th>
												<td><input type="text" class="form-control" value="${user.userResidentNo}" readonly></td>
											</tr>
											<tr>
												<th>이름</th>
												<td><input type="text" class="form-control" name="userName" value="${user.userName}" required></td>

												<th>직급</th>
												<td><input type="hidden" name="userPositionCd" value="${user.userPositionCd}"> <input type="text" class="form-control" value="${user.userPositionName}" readonly></td>
											</tr>
											<tr>
												<th>이메일</th>
												<td colspan="3"><input type="email" class="form-control" name="userEmail" value="${user.userEmail}" required></td>
											</tr>
											<tr>
												<th>휴대전화</th>
												<td><input type="text" class="form-control" name="userPhone" value="${user.userPhone}"></td>

												<th>전화번호 (유선)</th>
												<td><input type="text" class="form-control" name="userTel" value="${user.userTel}"></td>
											</tr>
											<tr>
												<th>생성일</th>
												<td><input type="text" class="form-control" value="<fmt:formatDate value="${user.createDt}" pattern="yyyy-MM-dd HH:mm:ss"/>" readonly></td>
												<th>수정일</th>
												<td><input type="text" class="form-control" value="<fmt:formatDate value="${user.updateDt}" pattern="yyyy-MM-dd HH:mm:ss"/>" readonly></td>
											</tr>
											<tr>
												<th>생성자 ID</th>
												<td><input type="text" class="form-control" value="${user.createId}" readonly></td>
												<th>수정자 ID</th>
												<td><input type="text" class="form-control" value="${user.updateId}" readonly></td>
											</tr>
											<tr>
												<th>상태</th>
												<td colspan="3"><select class="custom-select form-control" name="delYn">
														<option value="N" ${user.delYn eq 'N' ? 'selected' : ''}>활성</option>
														<option value="Y" ${user.delYn eq 'Y' ? 'selected' : ''}>삭제됨</option>
												</select></td>
											</tr>
										</tbody>
									</table>
								</div>

								<hr>

								<h6 class="m-0 font-weight-bold text-primary mb-3">연결된 계정 목록</h6>

								<c:if test="${empty accountList}">
									<div class="alert alert-info text-center" role="alert">이 사용자에게 연결된 계정이 없습니다.</div>
								</c:if>

								<c:if test="${not empty accountList}">
									<div class="table-responsive">
										<table class="table table-bordered table-hover" width="100%" cellspacing="0">
											<thead>
												<tr>
													<th style="width: 60px;">번호</th>
													<th>로그인 ID</th>
													<th>기관 ID</th>
													<th>부서명</th>
													<th>계정 상태</th>
													<th>생성일</th>
													<th>삭제여부</th>
												</tr>
											</thead>
											<tbody>
												<c:forEach var="account" items="${accountList}" varStatus="status">
													<tr>
														<td><input type="hidden" name="accountList[${status.index}].accountId" value="${account.accountId}"> ${(filter.page - 1) * filter.size + status.index + 1}</td>
														<td><input type="text" class="form-control" value="${account.loginId}" readonly></td>
														<td><input type="text" class="form-control" value="${account.instName}" readonly></td>
														<td><input type="text" class="form-control" value="${account.deptName}" readonly></td>
														<td><select class="custom-select form-control" name="accountList[${status.index}].accountStatusCd">
																<option value="B001" ${account.accountStatusCd eq 'B001' ? 'selected' : ''}>B001 (신청)</option>
																<option value="B002" ${account.accountStatusCd eq 'B002' ? 'selected' : ''}>B002 (승인)</option>
																<option value="B003" ${account.accountStatusCd eq 'B003' ? 'selected' : ''}>B003 (반려)</option>
																<option value="B004" ${account.accountStatusCd eq 'B004' ? 'selected' : ''}>B004 (정지)</option>
														</select></td>
														<td><input type="text" class="form-control" value="<fmt:formatDate value="${account.createDt}" pattern="yyyy-MM-dd"/>" readonly></td>
														<td><input type="hidden" name="accountList[${status.index}].delYn" value="${account.delYn}"> <input type="text" class="form-control" value="${account.delYn}" readonly></td>
													</tr>
												</c:forEach>
											</tbody>
										</table>
									</div>
								</c:if>

								<hr>

								<div class="d-flex justify-content-between">
									<a href="${pageContext.request.contextPath}/user/list" class="btn btn-secondary">목록으로</a>
									<div>
										<button type="submit" class="btn btn-primary" onclick="return confirm('사용자 정보 및 계정 상태를 수정하시겠습니까?');">수정</button>

										<c:if test="${user.delYn eq 'N'}">
											<form action="${pageContext.request.contextPath}/user/delete/${user.userNo}" method="post" style="display: inline">
												<button type="submit" class="btn btn-danger" onclick="return confirm('사용자 [${user.userName}]을(를) 정말로 삭제(비활성화)하시겠습니까?');">삭제</button>
											</form>
										</c:if>
									</div>
								</div>
							</div>
						</div>
					</form>
				</div>
			</div>

			<%@ include file="/WEB-INF/views/common/footer.jsp"%>
		</div>
	</div>

	<a class="scroll-to-top rounded" href="#page-top"><i class="fas fa-angle-up"></i></a>
	<%@ include file="/WEB-INF/views/common/logoutModal.jsp"%>

</body>
</html>