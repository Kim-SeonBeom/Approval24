<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<title>기간제-파견근로자의 출산전후휴가 급여지급 신청| 결재24</title>
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
						<h1 class="h3 mb-0 text-gray-800">기간제-파견근로자의 출산전후휴가 급여지급 신청</h1>
					</div>
					<c:if test="${not empty msg}">
						<div class="alert alert-success alert-dismissible fade show" role="alert">
							<i class="fas fa-check-circle mr-1"></i> ${msg}
							<button type="button" class="close" data-dismiss="alert" aria-label="Close">
								<span aria-hidden="true">&times;</span>
							</button>
						</div>
					</c:if>

					<form id="submitForm" method="post" action="${pageContext.request.contextPath}/mt1/${detail.complainId}">

						<%@ include file="/WEB-INF/views/C/regEditForm/complainUserInfo.jsp"%>


						<div class="card shadow mb-4">
							<div class="card-header py-3 d-flex align-items-center">
								<h6 class="m-0 font-weight-bold text-primary">출산정보</h6>
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
												<th>출산일(예정일) 또는 유산·사산일</th>
												<td><input type="date" class="form-control" name="birthDt" id="birthDt" value="<fmt:formatDate value='${detail.birthDt}' pattern='yyyy-MM-dd'/>" /></td>

												<th>영아의 주민등록번호</th>
												<td><input type="text" class="form-control" name="infantRrnFront" id="infantRrnFront" maxlength="6" inputmode="numeric" pattern="[0-9]*" placeholder="생년월일 6자리" style="width: 40%; display: inline-block;"value="<c:out value='${detail.infantRrnFront}'/>"> <span class="mx-1">-</span> <input type="password" class="form-control" name="infantRrnBack" id="infantRrnBack" maxlength="7" inputmode="numeric" pattern="[0-9]*" placeholder="뒤 7자리" style="width: 50%; display: inline-block;" value="<c:out value='${detail.infantRrnBack}'/>"></td>
											</tr>

											<tr>
												<th>다태아 여부</th>
												<td>
													<div class="form-check form-check-inline">
														<input class="form-check-input" type="radio" name="multipleBirthYn" id="multipleBirthYnY" value="Y" ${detail.multipleBirthYn == 'Y' ? 'checked' : ''}> <label class="form-check-label" for="multipleBirthYnY">예</label>
													</div>
													<div class="form-check form-check-inline ml-3">
														<input class="form-check-input" type="radio" name="multipleBirthYn" id="multipleBirthYnN" value="N"  ${detail.multipleBirthYn != 'Y' ? 'checked' : ''}> <label class="form-check-label" for="multipleBirthYnN">아니오</label>
													</div>
												</td>

												<th>미숙아 여부</th>
												<td>
													<div class="form-check form-check-inline">
														<input class="form-check-input" type="radio" name="prematureBabyYn" id="prematureBabyYnY" value="Y" ${detail.prematureBabyYn == 'Y' ? 'checked' : ''}> <label class="form-check-label" for="prematureBabyYnY">예</label>
													</div>
													<div class="form-check form-check-inline ml-3">
														<input class="form-check-input" type="radio" name="prematureBabyYn" id="prematureBabyYnN" value="N" ${detail.prematureBabyYn != 'Y' ? 'checked' : ''}> <label class="form-check-label" for="prematureBabyYnN">아니오</label>
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
								<h6 class="m-0 font-weight-bold text-primary">근로계약 정보</h6>
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
												<th>근로 계약 시작일</th>
												<td><input type="date" class="form-control" name="contractStartDt" id="contractStartDt" value="<fmt:formatDate value='${detail.contractStartDt}' pattern='yyyy-MM-dd'/>"/></td>
												<th>근로 계약 만료일</th>
												<td><input type="date" class="form-control" name="contractEndDt" id="contractEndDt" value="<fmt:formatDate value='${detail.contractEndDt}' pattern='yyyy-MM-dd'/>"/></td>
											</tr>
											<tr>
												<th>출산 전후 휴가 기간</th>
												<td colspan="3"><input type="text" class="form-control" name="maternityLeavePeriod" id="maternityLeavePeriod" value="<c:out value='${detail.maternityLeavePeriod}'/>" placeholder="예: 90일, 2025-01-01 ~ 2025-03-31 등" /></td>
											</tr>
										</tbody>
									</table>
								</div>
							</div>
						</div>


						<div class="card shadow mb-4">
							<div class="card-header py-3 d-flex align-items-center">
								<h6 class="m-0 font-weight-bold text-primary">신청 내용 및 지급계좌</h6>
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
												<th>이번 회차 신청 시작일</th>
												<td><input type="date" class="form-control" name="currentApplStartDt" id="currentApplStartDt"  value="<fmt:formatDate value='${detail.currentApplStartDt}' pattern='yyyy-MM-dd'/>"/></td>
												<th>이번 회차 신청 종료일</th>
												<td><input type="date" class="form-control" name="currentApplEndDt" id="currentApplEndDt"  value="<fmt:formatDate value='${detail.currentApplEndDt}' pattern='yyyy-MM-dd'/>"/></td>
											</tr>
											<tr>
												<th>예금주</th>
												<td><input type="text" class="form-control" name="accountHolderNm" value="<c:out value='${detail.accountHolderNm}'/>" /></td>
												<th>은행명</th>
												<td><input type="text" class="form-control" name="bankNm"  value="<c:out value='${detail.bankNm}'/>"/></td>
											</tr>
											<tr>
												<th>계좌번호</th>
												<td colspan="3"><input type="text" class="form-control" name="paymentAccountNo"  value="<c:out value='${detail.paymentAccountNo}'/>"/></td>
											</tr>
										</tbody>
									</table>
								</div>
							</div>
						</div>

						<div class="card shadow mb-4">
							<div class="card-header py-3 d-flex align-items-center">
								<h6 class="m-0 font-weight-bold text-primary">확인사항</h6>
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
												<th>소득여부</th>
												<td colspan="3">
													<div class="form-check form-check-inline">
														<input class="form-check-input" type="radio" name="incomeYn" id="incomeYnY" value="Y" ${detail.incomeYn == 'Y' ? 'checked' : ''}> <label class="form-check-label" for="incomeYnY">예</label>
													</div>
													<div class="form-check form-check-inline ml-3">
														<input class="form-check-input" type="radio" name="incomeYn" id="incomeYnN" value="N" ${detail.incomeYn != 'Y' ? 'checked' : ''}> <label class="form-check-label" for="incomeYnN">아니오</label>
													</div>
												</td>
											</tr>

											<tr>
												<th>소득 종류</th>
												<td colspan="3">
													<div class="form-check form-check-inline">
														<input class="form-check-input" type="radio" name="incomeType" id="incomeTypeBiz" value="사업소득"  ${detail.incomeType == '사업소득' ? 'checked' : ''}> <label class="form-check-label" for="incomeTypeBiz">사업소득</label>
													</div>
													<div class="form-check form-check-inline ml-3">
														<input class="form-check-input" type="radio" name="incomeType" id="incomeTypeWork" value="근로소득" ${detail.incomeType == '근로소득' ? 'checked' : ''}> <label class="form-check-label" for="incomeTypeWork">근로소득</label>
													</div>
												</td>
											</tr>

											<tr>
												<th>소득 활동 시작일</th>
												<td><input type="date" class="form-control" name="incomeStartTime" id="incomeStartTime" value="<fmt:formatDate value='${detail.incomeStartTime}' pattern='yyyy-MM-dd'/>"></td>
												<th>소득 활동 중단일</th>
												<td><input type="date" class="form-control" name="incomeEndTime" id="incomeEndTime" value="<fmt:formatDate value='${detail.incomeEndTime}' pattern='yyyy-MM-dd'/>"></td>
											</tr>

											<tr>
												<th>근로 기간(시간/일수 등)</th>
												<td colspan="3"><input type="text" class="form-control" name="workHours" id="workHours"  value="<c:out value='${detail.workHours}'/>" placeholder="예: 주 15시간, 총 160시간, 30일 등"></td>
											</tr>
										</tbody>
									</table>
								</div>
							</div>
						</div>


						<div class="d-flex justify-content-between mt-4">
							<a href="${pageContext.request.contextPath}/complains" class="btn btn-light"> <i class="fas fa-arrow-left mr-1"></i> 취소
							</a>
							<div>
								<button type="button" class="btn btn-primary" id="btnUpdate">
									<i class="fas fa-edit mr-1"></i>수정
								</button>
							</div>
						</div>

						<input type="hidden" name="complainId" value="<c:out value='${detail.complainId}'/>"> <input type="hidden" name="complainuserNo" value="<c:out value='${userInfo.complainuserNo}'/>">
					</form>

				</div>
				<!-- /.container-fluid -->
			</div>


			<%@ include file="/WEB-INF/views/common/footer.jsp"%>
			<!--페이지 전용 js -->
			<script src="${pageContext.request.contextPath}/resources/assets/js/complain/mt1.js"></script>
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