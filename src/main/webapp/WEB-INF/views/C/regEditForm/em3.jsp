<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<title>졸업생 특화프로그램 신청 | 결재24</title>
<style>
.required::after {
	content: " *";
	color: #e74a3b;
}

.readonly-box {
	background: #f8f9fc;
}

.form-hint {
	font-size: .85rem;
	color: #858796;
}

.table th {
	width: 18%;
	background: #f8f9fc;
	vertical-align: !important middle;
}
</style>
</head>

<body id="page-top">
	<div id="wrapper">

		<%@ include file="/WEB-INF/views/common/sidebar.jsp"%>

		<div id="content-wrapper" class="d-flex flex-column">
			<div id="content">
				<%@ include file="/WEB-INF/views/common/navbar.jsp"%>

				<div class="container-fluid mb-4">

					<!-- Heading -->
					<div class="d-sm-flex align-items-center justify-content-between mb-4">
						<h1 class="h3 mb-0 text-gray-800">졸업색 특화 프로그램 신청</h1>
					</div>

					<form id="submitForm" method="post" action="${pageContext.request.contextPath}/complain/category/em3/${detail.complainId}">

						<%@ include file="/WEB-INF/views/C/regEditForm/complainUserInfo.jsp"%>

						<div class="card shadow mb-4">
							<div class="card-header py-3 d-flex align-items-center">
								<h6 class="m-0 font-weight-bold text-primary">참여 대학, 참여자구분</h6>
							</div>
							<div class="card-body">
								<div class="table-responsive">
									<table class="table table-bordered mb-0" width="100%">
										<colgroup>
											<col style="width: 18%">
											<col style="width: 32%">
											<col style="width: 18%">
											<col style="width: 32%">
										</colgroup>
										<tbody>
											<tr>
												<th>참여대학</th>
												<td colspan="3"><input type="text" class="form-control" name="universityName" value="<c:out value='${detail.universityName}'/>"></td>

											</tr>
											<tr>
												<th rowspan="2">참여자구분</th>
												<td colspan="3">
													<div class="form-check form-check-inline">
														<input class="form-check-input" type="radio" name="participantType" id="participantTypeGraduate" value="graduate" <c:if test="${detail.participantType eq 'graduate'}">checked</c:if>> <label class="form-check-label" for="participantTypeGraduate">①졸업생 특화 프로그램을 운영하는 대학(원)의 졸업생, 졸업 유예자 및 예정자 </label>
													</div> <br>
													<div class="form-check form-check-inline">
														<input class="form-check-input" type="radio" name="participantType" id="participantTypeRegion" value="region" <c:if test="${detail.participantType eq 'region'}">checked</c:if>> <label class="form-check-label" for="participantTypeRegion">② ①에 해당하지 않는 직업계고 졸업생, 미취업 지역청년</label>
													</div>
												</td>
											</tr>
										</tbody>
									</table>
								</div>
							</div>
						</div>

						<div class="card shadow mb-4">
							<div class="card-header py-3 d-flex align-items-center">
								<h6 class="m-0 font-weight-bold text-primary">학적 정보</h6>
							</div>
							<div class="card-body">
								<div class="table-responsive">
									<table class="table table-bordered mb-0" width="100%">
										<colgroup>
											<col style="width: 18%">
											<col style="width: 32%">
											<col style="width: 18%">
											<col style="width: 32%">
										</colgroup>
										<tbody>
											<tr>
												<th>학번</th>
												<td><input type="text" class="form-control" name="studentNo" id="studentNo" value="<c:out value='${detail.studentNo}'/>"></td>
												<th>학년</th>
												<td><select name="grade" id="grade" class="form-control">
														<option value="" disabled selected>선택하세요</option>
														<option value="1" <c:if test="${detail.grade == 1}">selected</c:if>>1학년</option>
														<option value="2" <c:if test="${detail.grade == 2}">selected</c:if>>2학년</option>
														<option value="3" <c:if test="${detail.grade == 3}">selected</c:if>>3학년</option>
														<option value="4" <c:if test="${detail.grade == 4}">selected</c:if>>4학년</option>
														<option value="5" <c:if test="${detail.grade == 5}">selected</c:if>>5학년</option>
												</select></td>
											</tr>
											<tr>
												<th>전공</th>
												<td><input type="text" class="form-control" name="major" id="major" value="<c:out value='${detail.major}'/>"></td>
												<th>상태</th>
												<td><select name="studentStatus" id="studentStatus" class="form-control">
														<option value="" disabled selected>선택하세요</option>
														<option value="재학" <c:if test="${detail.studentStatus eq '재학'}">selected</c:if>>재학</option>
														<option value="휴학" <c:if test="${detail.studentStatus eq '휴학'}">selected</c:if>>휴업</option>
														<option value="졸업" <c:if test="${detail.studentStatus eq '졸업'}">selected</c:if>>졸업</option>
												</select></td>

											</tr>
											<tr>
												<th>졸업(예정)연월일</th>
												<td colspan="3"><input type="date" class="form-control" name="graduateDate" id="graduateDate" value="<fmt:formatDate value='${detail.graduateDate}' pattern='yyyy-MM-dd'/>"></td>
											</tr>
										</tbody>
									</table>
								</div>
							</div>
						</div>

						<div class="d-flex justify-content-between mt-4">
							<a href="${pageContext.request.contextPath}/complains" class="btn btn-light"> <i class="fas fa-arrow-left mr-1"></i> 목록으로
							</a>
							<div>
								<c:if test="${pageAuth.updateYn == 'Y' && complainInfo.accountId == sessionScope.user}">
									<button type="button" class="btn btn-secondary" id="btnApprovalLine">
										<i class="fas fa-edit mr-1"></i>결재선설정
									</button>

								</c:if>
								<c:if test="${pageAuth.updateYn == 'Y'}">
									<button type="button" class="btn btn-light" id="btnSave">
										<i class="fas fa-edit mr-1"></i>수정
									</button>
									<button type="button" class="btn btn-warning" id="btnComplainCancel">
										<i class="fas fa-edit mr-1"></i>취하
									</button>

								</c:if>

								<c:if test="${pageAuth.approveYn == 'Y'}">
									<button type="button" class="btn btn-primary" id="btnApprove">
										<i class="fas fa-edit mr-1"></i>승인
									</button>
									<button type="button" class="btn btn-danger" id="btnReject">
										<i class="fas fa-edit mr-1"></i>반려
									</button>
								</c:if>
							</div>
						</div>
						<input type="hidden" name="complainId" value="<c:out value='${detail.complainId}'/>"> <input type="hidden" name="complainuserNo" value="<c:out value='${userInfo.complainuserNo}'/>">

					</form>

				</div>
				<!-- /.container-fluid -->
				<!-- 결재라인 모달로 처리 -->
				<jsp:include page="../../D/approvalLineEditor.jsp" />

			</div>
			<!-- /#content -->

			<%@ include file="/WEB-INF/views/common/footer.jsp"%>

		</div>
		<!-- /#content-wrapper -->
	</div>
	<!-- /#wrapper -->

	<%@ include file="/WEB-INF/views/common/logoutModal.jsp"%>

	<script>
		const authData = {
			// 페이지 권한
			canUpdate : '${pageAuth.updateYn}' === 'Y',
			canApprove : '${pageAuth.approveYn}' === 'Y',

			// 담당자 아이디 체크
			complainAccountId : '${complainInfo.accountId}',

			// 현재 로그인한 사용자 정보
			sessionAccountId : '${sessionScope.user}'
		};
		// "취하" & "결재선설정" 권한
		const canCancelOrSetLine = authData.canApprove
				&& (authData.complainAccountId === authData.sessionAccountId);
	</script>
	<script src="${pageContext.request.contextPath}/resources/assets/js/complain/em3.js"></script>
	<script src="${pageContext.request.contextPath}/resources/assets/js/complain/approvalLine.js"></script>

	<!-- Submit Modal -->
	<div class="modal fade" id="submitModal" tabindex="-1" role="dialog" aria-labelledby="submitModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="submitModalLabel">신청 제출</h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">입력하신 내용으로 신청을 제출할까요?</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
					<button type="button" class="btn btn-primary" id="btnSubmitConfirm">제출</button>
				</div>
			</div>
		</div>
	</div>


</body>
</html>