<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<title>실업인정 신청 | 결재24</title>
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
	vertical-align: middle;
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
						<h1 class="h3 mb-0 text-gray-800">실업인정 신청</h1>
					</div>

					<form id="submitForm" method="post" action="${pageContext.request.contextPath}/ue2/${detail.complainId}">

						<%@ include file="/WEB-INF/views/complain/regEditForm/complainUserInfo.jsp"%>


						<div class="card shadow mb-4">
							<div class="card-header py-3 d-flex align-items-center">
								<h6 class="m-0 font-weight-bold text-primary">지급계좌</h6>
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
												<th>예금주</th>
												<td><input type="text" class="form-control" name="accountHolderNm" value="<c:out value='${detail.accountHolderNm}'/>"></td>
												<th>은행명</th>
												<td><input type="text" class="form-control" name="bankNm" value="<c:out value='${detail.bankNm}'/>"></td>
											</tr>
											<tr>
												<th>계좌번호</th>
												<td colspan="3"><input type="text" class="form-control" name="accountNo" value="<c:out value='${detail.accountNo}'/>"></td>
											</tr>
										</tbody>
									</table>
								</div>
							</div>
						</div>

						<!-- 실업 기간 중 취업사실 등의 확인 -->
						<div class="card shadow mb-4">
							<div class="card-header py-3 d-flex align-items-center">
								<h6 class="m-0 font-weight-bold text-primary">실업 기간 중 취업사실 등의 확인</h6>
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
												<th>소득 발생 여부</th>
												<td colspan="3">
													<div class="form-check form-check-inline">
														<input class="form-check-input" type="radio" name="incomeOccurYn" id="incomeOccurYnY" value="Y" <c:if test="${detail != null && detail.incomeOccurYn eq 'Y'}">checked</c:if>> <label class="form-check-label" for="incomeOccurYnY">예</label>
													</div>
													<div class="form-check form-check-inline ml-3">
														<input class="form-check-input" type="radio" name="incomeOccurYn" id="incomeOccurYnN" value="N" <c:if test="${detail == null || detail.incomeOccurYn ne 'Y'}">checked</c:if>> <label class="form-check-label" for="incomeOccurYnN">아니오</label>
													</div>
												</td>
											</tr>

											<tr>
												<th>소득 내역</th>
												<td><input type="text" class="form-control" name="incomeDetail" value="<c:out value='${detail.incomeDetail}'/>"></td>
												<th>근로 날짜</th>
												<td><input type="date" class="form-control" name="workStartDt" value="<fmt:formatDate value='${detail.workStartDt}' pattern='yyyy-MM-dd'/>"></td>
											</tr>

											<tr>
												<th>소득 금액</th>
												<td><input type="number" class="form-control" name="incomeAmt" value="<c:out value='${detail.incomeAmt}'/>" placeholder="(원)숫자만 입력"></td>
												<th>소득 예정 금액</th>
												<td><input type="number" class="form-control" name="incomeEstAmt" value="<c:out value='${detail.incomeEstAmt}'/>" placeholder="(원)숫자만 입력"></td>
											</tr>

											<tr>
												<th>사업자 등록(자영업 개시)</th>
												<td colspan="3">
													<div class="form-check form-check-inline">
														<input class="form-check-input" type="radio" name="bizRegYn" id="bizRegYnY" value="Y" <c:if test="${detail != null && detail.bizRegYn eq 'Y'}">checked</c:if>> <label class="form-check-label" for="bizRegYnY">예</label>
													</div>
													<div class="form-check form-check-inline ml-3">
														<input class="form-check-input" type="radio" name="bizRegYn" id="bizRegYnN" value="N" <c:if test="${detail == null || detail.bizRegYn ne 'Y'}">checked</c:if>> <label class="form-check-label" for="bizRegYnN">아니오</label>
													</div>
												</td>
											</tr>

											<tr>
												<th>사업 내용</th>
												<td><input type="text" class="form-control" name="bizDetail" value="<c:out value='${detail.bizDetail}'/>"></td>
												<th>사업자등록일</th>
												<td><input type="date" class="form-control" name="bizRegDt" value="<fmt:formatDate value='${detail.bizRegDt}' pattern='yyyy-MM-dd'/>"></td>
											</tr>
										</tbody>
									</table>
								</div>
							</div>
						</div>


						<div class="card shadow mb-4">
							<div class="card-header py-3 d-flex align-items-center">
								<h6 class="m-0 font-weight-bold text-primary">실업인정 대상 기간 중의 재취업활동 확인</h6>
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
												<th>자영업 준비활동</th>
												<td colspan="3">
													<div class="form-check form-check-inline">
														<input class="form-check-input" type="radio" name="selfEmpPrepActYn" id="selfEmpPrepActYnY" value="Y" <c:if test="${detail != null && detail.selfEmpPrepActYn eq 'Y'}">checked</c:if>> <label class="form-check-label" for="selfEmpPrepActYnY">예</label>
													</div>
													<div class="form-check form-check-inline ml-3">
														<input class="form-check-input" type="radio" name="selfEmpPrepActYn" id="selfEmpPrepActYnN" value="N" <c:if test="${detail == null || detail.selfEmpPrepActYn ne 'Y'}">checked</c:if>> <label class="form-check-label" for="selfEmpPrepActYnN">아니오</label>
													</div>
												</td>
											</tr>

											<tr>
												<th>자영업준비 활동내용</th>
												<td><input type="text" class="form-control" name="selfEmpPrepAct" value="<c:out value='${detail.selfEmpPrepAct}'/>"></td>
												<th>자영업 시작예정일</th>
												<td><input type="date" class="form-control" name="selfEmpStartPlanDt" value="<fmt:formatDate value='${detail.selfEmpStartPlanDt}' pattern='yyyy-MM-dd'/>"></td>
											</tr>

											<tr>
												<th>재취업여부</th>
												<td colspan="3">
													<div class="form-check form-check-inline">
														<input class="form-check-input" type="radio" name="reEmploymentYn" id="reEmploymentYnY" value="Y" <c:if test="${detail != null && detail.reEmploymentYn eq 'Y'}">checked</c:if>> <label class="form-check-label" for="reEmploymentYnY">예</label>
													</div>
													<div class="form-check form-check-inline ml-3">
														<input class="form-check-input" type="radio" name="reEmploymentYn" id="reEmploymentYnN" value="N" <c:if test="${detail == null || detail.reEmploymentYn ne 'Y'}">checked</c:if>> <label class="form-check-label" for="reEmploymentYnN">아니오</label>
													</div>
												</td>
											</tr>

											<tr>
												<th>회사명</th>
												<td><input type="text" class="form-control" name="coNm" value="<c:out value='${detail.coNm}'/>"></td>
												<th>취직예정일</th>
												<td><input type="date" class="form-control" name="reEmploymentPlanDt" value="<fmt:formatDate value='${detail.reEmploymentPlanDt}' pattern='yyyy-MM-dd'/>"></td>
											</tr>

											<tr>
												<th>구직활동 외 활동사항</th>
												<td colspan="3"><input type="text" class="form-control" name="nonJobSeekActivity" value="<c:out value='${detail.nonJobSeekActivity}'/>"></td>
											</tr>
										</tbody>
									</table>
								</div>
							</div>
						</div>

						<input type="hidden" name="complainId" value="<c:out value='${detail.complainId}'/>"> <input type="hidden" name="complainuserNo" value="<c:out value='${userInfo.complainuserNo}'/>">


						<div class="d-flex justify-content-between mt-4">
							<a href="${pageContext.request.contextPath}/complains" class="btn btn-light"> <i class="fas fa-arrow-left mr-1"></i> 취소
							</a>
							<div>
								<button type="button" class="btn btn-primary" id="btnUpdate">
									<i class="fas fa-edit mr-1"></i> 수정
								</button>
							</div>
						</div>
					</form>

				</div>
				<!-- /.container-fluid -->
			</div>
			<!-- /#content -->

			<%@ include file="/WEB-INF/views/common/footer.jsp"%>
			<!--페이지 전용 js -->
			<script src="${pageContext.request.contextPath}/resources/assets/js/complain/ue2.js"></script>
		</div>
		<!-- /#content-wrapper -->
	</div>
	<!-- /#wrapper -->

	<%@ include file="/WEB-INF/views/common/logoutModal.jsp"%>

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