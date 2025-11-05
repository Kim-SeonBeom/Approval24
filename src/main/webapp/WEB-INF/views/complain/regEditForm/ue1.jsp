<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<title>실업자 취업훈련비 대부 신청 | 결재24</title>
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
						<h1 class="h3 mb-0 text-gray-800">실업자 취업훈련비 대부 신청</h1>
					</div>

					<c:if test="${not empty msg}">
						<div class="alert alert-success alert-dismissible fade show" role="alert">
							<i class="fas fa-check-circle mr-1"></i> ${msg}
							<button type="button" class="close" data-dismiss="alert" aria-label="Close">
								<span aria-hidden="true">&times;</span>
							</button>
						</div>
					</c:if>

					<form id="loanApplyForm" method="post" action="${pageContext.request.contextPath}/ue1/${detail.complainId}">
						<%@ include file="/WEB-INF/views/complain/regEditForm/complainUserInfo.jsp"%>

						<!-- B. 이전 직장 정보 -->
						<div class="card shadow mb-4">
							<div class="card-header py-3 d-flex align-items-center">
								<h6 class="m-0 font-weight-bold text-primary">이전 직장 정보</h6>
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
												<th>회사명</th>
												<td><input type="text" class="form-control" name="prevCoNm" value="<c:out value='${detail.prevCoNm}'/>"></td>
												<th>회사 전화번호</th>
												<td><input type="text" class="form-control" name="prevCoTelNo" value="<c:out value='${detail.prevCoTelNo}'/>" placeholder="예: 02-1234-5678"></td>
											</tr>
											<tr>
												<th>직위</th>
												<td><input type="text" class="form-control" name="prevCoPosition" value="<c:out value='${detail.prevCoPosition}'/>"></td>
												<th>입사일</th>
												<td><input type="date" class="form-control" name="empDt" value="<fmt:formatDate value='${detail.empDt}' pattern='yyyy-MM-dd'/>"></td>
											</tr>
											<tr>
												<th>퇴사일</th>
												<td><input type="date" class="form-control" name="unempDt" value="<fmt:formatDate value='${detail.unempDt}' pattern='yyyy-MM-dd'/>"></td>
												<th>실직기간(일)</th>
												<td>
													<div class="input-group">
														<input type="number" class="form-control" name="unempPeriod" id="unempPeriod" min="0" value="<c:out value='${detail.unempPeriod}'/>" placeholder="자동 계산/직접 입력">
														<div class="input-group-append">
															<button class="btn btn-outline-secondary" type="button" id="btnCalcUnemp">계산</button>
														</div>
													</div>
												</td>
											</tr>
										</tbody>
									</table>
								</div>
							</div>
						</div>

						<!-- C. 수혜/사업자 여부 -->
						<div class="card shadow mb-4">
							<div class="card-header py-3 d-flex align-items-center">
								<h6 class="m-0 font-weight-bold text-primary">수혜/사업자 여부</h6>
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
												<th>융자·보조금 수혜 여부</th>
												<td>
													<div class="form-check form-check-inline">
														<input class="form-check-input" type="radio" name="subsidyBenefitYn" id="benefitY" value="Y" <c:if test="${detail != null && detail.subsidyBenefitYn eq 'Y'}">checked</c:if>> <label class="form-check-label" for="benefitY">예</label>
													</div>
													<div class="form-check form-check-inline ml-3">
														<input class="form-check-input" type="radio" name="subsidyBenefitYn" id="benefitN" value="N" <c:if test="${detail == null || detail.subsidyBenefitYn ne 'Y'}">checked</c:if>> <label class="form-check-label" for="benefitN">아니오</label>
													</div>
												</td>
												<th>수혜 금액</th>
												<td><input type="number" class="form-control" name="subsidyAmt" id="subsidyAmt" min="0" value="<c:out value='${detail.subsidyAmt}'/>" placeholder="(원)숫자만 입력"></td>
											</tr>
											<tr>
												<th>사업자 등록 유무</th>
												<td colspan="3">
													<div class="form-check form-check-inline">
														<input class="form-check-input" type="radio" name="bizRegYn" id="bizY" value="Y" <c:if test="${detail != null && detail.bizRegYn eq 'Y'}">checked</c:if>> <label class="form-check-label" for="bizY">예</label>
													</div>
													<div class="form-check form-check-inline ml-3">
														<input class="form-check-input" type="radio" name="bizRegYn" id="bizN" value="N" <c:if test="${detail == null || detail.bizRegYn ne 'Y'}">checked</c:if>> <label class="form-check-label" for="bizN">아니오</label>
													</div>
												</td>
											</tr>
										</tbody>
									</table>
								</div>
							</div>
						</div>

						<!-- D. 훈련기관 / 훈련 정보 -->
						<div class="card shadow mb-4">
							<div class="card-header py-3 d-flex align-items-center">
								<h6 class="m-0 font-weight-bold text-primary">훈련기관 / 훈련 정보</h6>
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
												<th>훈련기관명</th>
												<td colspan="3"><input type="text" class="form-control" name="trainInstNm" value="<c:out value='${detail.trainInstNm}'/>"></td>
											</tr>
											<tr>
												<th scope="col" class="text-dark bg-light font-weight-bold" style="vertical-align: middle;">주소</th>
												<td colspan="3">
													<div class="d-flex mb-2">
														<input type="text" class="form-control form-postal-code mr-2" placeholder="우편번호" name="trainPost" id="trainPost" readonly style="width: 150px;" value="<c:out value='${detail.trainPost}'/>">
														<button type="button" class="btn btn-secondary" id="btnSearchTrainAddress" onclick="openTrainPostcode()">주소 검색</button>
													</div> <input type="text" class="form-control mb-2" placeholder="기본 주소" name="trainInstAddr" id="trainInstAddr" value="<c:out value='${detail.trainInstAddr}'/>" readonly> <input type="text" class="form-control" placeholder="상세 주소 (건물명, 동/호수 등)" name="trainInstAddrDetail" id="trainInstAddrDetail" value="<c:out value='${detail.trainInstAddrDetail}'/>">
												</td>
											</tr>
											<tr>
												<th>훈련 시작일</th>
												<td><input type="date" class="form-control" name="trainStartDt" id="trainStartDt" value="<fmt:formatDate value='${detail.trainStartDt}' pattern='yyyy-MM-dd'/>"></td>
												<th>훈련 종료일</th>
												<td><input type="date" class="form-control" name="trainEndDt" id="trainEndDt" value="<fmt:formatDate value='${detail.trainEndDt}' pattern='yyyy-MM-dd'/>"></td>
											</tr>
											<tr>
												<th>훈련 기간(일)</th>
												<td>
													<div class="input-group">
														<input type="number" class="form-control" name="trainPeriod" id="trainPeriod" min="0" value="<c:out value='${detail.trainPeriod}'/>" placeholder="자동 계산/직접 입력">
														<div class="input-group-append">
															<button class="btn btn-outline-secondary" type="button" id="btnCalcTrain">계산</button>
														</div>
													</div>
												</td>
												<th>수강료</th>
												<td><input type="number" class="form-control" name="tuitionFeeAmt" min="0" value="<c:out value='${detail.tuitionFeeAmt}'/>" placeholder="(원)숫자만 입력 "></td>
											</tr>
										</tbody>
									</table>
								</div>
							</div>
						</div>

						<!-- E. 대부금 신청 -->
						<div class="card shadow mb-4">
							<div class="card-header py-3 d-flex align-items-center">
								<h6 class="m-0 font-weight-bold text-primary">대부금 신청</h6>
							</div>
							<div class="card-body">
								<div class="table-responsive">
									<table class="table table-bordered mb-0" width="100%">
										<colgroup>
											<col style="width: 18%">
											<col style="width: 82%">
										</colgroup>
										<tbody>
											<tr>
												<th>대부 신청 금액</th>
												<td><input type="number" class="form-control d-inline-block" style="max-width: 240px;" name="loanApplAmt" min="0" value="<c:out value='${detail.loanApplAmt}'/>"> <span class="ml-2 text-muted">※ 천원 단위 미만 버림</span></td>
											</tr>
										</tbody>
									</table>
								</div>
							</div>
						</div>

						<!-- 하단 버튼 -->
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
			</div>

			<!-- footer -->
			<%@ include file="/WEB-INF/views/common/footer.jsp"%>
			<!--페이지 전용 js -->
			<script src="${pageContext.request.contextPath}/resources/assets/js/complain/ue1.js"></script>

		</div>
	</div>

	<%@ include file="/WEB-INF/views/common/logoutModal.jsp"%>

	<!-- Submit Modal -->
	<div class="modal fade" id="submitModal" tabindex="-1" role="dialog" aria-labelledby="submitModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="submitModalLabel">신청서 등록</h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">입력하신 내용으로 저장할까요?</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
					<button type="button" class="btn btn-primary" id="btnSubmitConfirm">저장</button>
				</div>
			</div>
		</div>
	</div>



</body>
</html>