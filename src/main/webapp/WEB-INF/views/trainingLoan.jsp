<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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

					<form id="loanApplyForm" method="post" action="${pageContext.request.contextPath}/approval24/loan/training/apply">

						<div class="card shadow mb-4">
							<div class="card-header py-3 d-flex align-items-center">
								<h6 class="m-0 font-weight-bold text-primary">신청인 정보</h6>
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
												<th>성명</th>
												<td><input type="text" class="form-control" name="complainuser_name" value="${dto.complainuser_name}"></td>
												<th>주민등록번호</th>
												<td><input type="text" id="complainuser_resi_no_front" maxlength="6" inputmode="numeric" pattern="[0-9]*" placeholder="생년월일 6자리" style="width: 40%; display: inline-block;"> <span class="mx-1">-</span> <input type="text" id="complainuser_resi_no_back" maxlength="7" inputmode="numeric" pattern="[0-9]*" placeholder="뒤 7자리" style="width: 50%; display: inline-block;"></td>
											</tr>
											<tr>
												<th scope="col" class="text-dark bg-light font-weight-bold" style="vertical-align: middle;">주소</th>
												<td colspan="3">
													<div class="d-flex mb-2">
														<input type="text" class="form-control form-postal-code mr-2" placeholder="우편번호" name="complainuser_post" id="complainuser_post" readonly style="width: 150px;">

														<button type="button" class="btn btn-secondary" onclick="openDaumPostcode()">주소 검색</button>
													</div> <input type="text" class="form-control mb-2" placeholder="기본 주소" name="complainuser_addr1" id="complainuser_addr1" readonly> <input type="text" class="form-control" placeholder="상세 주소 (건물명, 동/호수 등)" name="complainuser_addr2" id="complainuser_addr2">
												</td>
											</tr>
											<tr>
												<th>전화번호</th>
												<td><input type="tel" class="form-control" name="complainuser_tel"></td>
												<th>휴대전화번호</th>

												<td><input type="tel" class="form-control" name="complainuser_phone"></td>

											</tr>
											<tr>
												<th>이메일</th>
												<td colspan="3"><input type="email" class="form-control" name="complainuser_email"></td>
											</tr>
										</tbody>
									</table>
								</div>
							</div>
						</div>

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
												<td><input type="text" class="form-control" name="prev_co_nm" value="${dto.prev_co_nm}"></td>
												<th>회사 전화번호</th>
												<td><input type="text" class="form-control" name="prev_co_tel_no" value="${dto.prev_co_tel_no}" placeholder="예: 02-1234-5678"></td>
											</tr>
											<tr>
												<th>직위</th>
												<td><input type="text" class="form-control" name="PREV_CO_POSITION" value="${dto.PREV_CO_POSITION}"></td>
												<th>입사일</th>
												<td><input type="date" class="form-control" name="EMP_DT" value="${dto.EMP_DT}"></td>
											</tr>
											<tr>
												<th>퇴사일</th>
												<td><input type="date" class="form-control" name="UNEMP_DT" value="${dto.UNEMP_DT}"></td>
												<th>실직기간(일)</th>
												<td>
													<div class="input-group">
														<input type="number" class="form-control" name="UNEMP_PERIOD" id="UNEMP_PERIOD" value="${dto.UNEMP_PERIOD}" placeholder="자동 계산/직접 입력">
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
														<input class="form-check-input" type="radio" name="SUBSIDY_BENEFIT_YN" id="benefitY" value="Y" <c:if test="${dto.SUBSIDY_BENEFIT_YN eq 'Y'}">checked</c:if>> <label class="form-check-label" for="benefitY">예</label>
													</div>
													<div class="form-check form-check-inline ml-3">
														<input class="form-check-input" type="radio" name="SUBSIDY_BENEFIT_YN" id="benefitN" value="N" <c:if test="${dto.SUBSIDY_BENEFIT_YN ne 'Y'}">checked</c:if>> <label class="form-check-label" for="benefitN">아니오</label>
													</div>
												</td>
												<th>수혜 금액</th>
												<td><input type="number" class="form-control" name="SUBSIDY_AMT" id="SUBSIDY_AMT" value="${dto.SUBSIDY_AMT}" placeholder="(원)숫자만 입력"></td>
											</tr>
											<tr>
												<th>사업자 등록 유무</th>
												<td colspan="3">
													<div class="form-check form-check-inline">
														<input class="form-check-input" type="radio" name="BIZ_REG_YN" id="bizY" value="Y" <c:if test="${dto.BIZ_REG_YN eq 'Y'}">checked</c:if>> <label class="form-check-label" for="bizY">예</label>
													</div>
													<div class="form-check form-check-inline ml-3">
														<input class="form-check-input" type="radio" name="BIZ_REG_YN" id="bizN" value="N" <c:if test="${dto.BIZ_REG_YN ne 'Y'}">checked</c:if>> <label class="form-check-label" for="bizN">아니오</label>
													</div>
												</td>
											</tr>
										</tbody>
									</table>
								</div>
							</div>
						</div>

						<!-- D. 훈련기관/훈련 정보 -->
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
												<td colspan="3"><input type="text" class="form-control" name="TRAIN_INSTITUTE_NM" value="${dto.TRAIN_INSTITUTE_NM}"></td>
											</tr>
											<tr>
												<th scope="col" class="text-dark bg-light font-weight-bold" style="vertical-align: middle;">주소</th>
												<td colspan="3">
													<div class="d-flex mb-2">
														<input type="text" class="form-control form-postal-code mr-2" placeholder="우편번호" name="postalCode" id="postalCode" readonly style="width: 150px;">

														<button type="button" class="btn btn-secondary" onclick="openDaumPostcode()">주소 검색</button>
													</div> <input type="text" class="form-control mb-2" placeholder="기본 주소" name="TRAIN_INSTITUTE_ADDR1" id="TRAIN_INSTITUTE_ADDR1" readonly> <input type="text" class="form-control" placeholder="상세 주소 (건물명, 동/호수 등)" name="TRAIN_INSTITUTE_ADDR2" id="TRAIN_INSTITUTE_ADDR2">
												</td>
											</tr>
											<tr>
												<th>훈련 시작일</th>
												<td><input type="date" class="form-control" name="TRAIN_START_DT" id="TRAIN_START_DT" value="${dto.TRAIN_START_DT}"></td>
												<th>훈련 종료일</th>
												<td><input type="date" class="form-control" name="TRAIN_END_DT" id="TRAIN_END_DT" value="${dto.TRAIN_END_DT}"></td>
											</tr>
											<tr>
												<th>훈련 기간(일)</th>
												<td>
													<div class="input-group">
														<input type="number" class="form-control" name="TRAIN_PERIOD" id="TRAIN_PERIOD" value="${dto.TRAIN_PERIOD}" placeholder="자동 계산/직접 입력">
														<div class="input-group-append">
															<button class="btn btn-outline-secondary" type="button" id="btnCalcTrain">계산</button>
														</div>
													</div>

												</td>
												<th>수강료</th>
												<td><input type="number" class="form-control" name="TUITION_FEE_AMT" value="${dto.TUITION_FEE_AMT}" placeholder="(원)숫자만 입력 "></td>
											</tr>
										</tbody>
									</table>
								</div>
							</div>
						</div>

						<div class="card shadow mb-4">
							<div class="card-header py-3 d-flex align-items-center">
								<h6 class="m-0 font-weight-bold text-primary">대부금 신청</h6>
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
											<th>대부 신청 금액</th>
											<td colspan="3"><input type="number" class="form-contorl" name="LOAN_APPI_AMT" value="${dto.LOAN_APPI_AMT}"  /> ※천원 단위 미만 버림</td>
										</tbody>
									</table>
								</div>
							</div>
						</div>



						<div class="d-flex justify-content-between mt-4">
							<a href="${pageContext.request.contextPath}/approval24" class="btn btn-light"> <i class="fas fa-arrow-left mr-1"></i> 취소
							</a>
							<div>
								<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#submitModal">
									<i class="fas fa-paper-plane mr-1"></i> 신청
								</button>
							</div>
						</div>
				</div>
				</form>

			</div>
			<!-- /.container-fluid -->
		</div>
		<!-- /#content -->

		<%@ include file="/WEB-INF/views/common/footer.jsp"%>
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

	<!-- 페이지 스크립트 -->
	<script>


  document.getElementById('btnCalcUnemp')?.addEventListener('click', function() {
    const emp = document.querySelector('input[name="EMP_DT"]').value;
    const unemp = document.querySelector('input[name="UNEMP_DT"]').value;
    const days = daysBetweenStr(emp, unemp);
    if (days !== '') document.getElementById('UNEMP_PERIOD').value = days;
  });

  // 훈련기간 자동 계산 (TRAIN_START_DT ~ TRAIN_END_DT)
  document.getElementById('btnCalcTrain')?.addEventListener('click', function() {
    const st = document.getElementById('TRAIN_START_DT').value;
    const en = document.getElementById('TRAIN_END_DT').value;
    const days = daysBetweenStr(st, en);
    if (days !== '') document.getElementById('TRAIN_PERIOD').value = days;
  });

</script>
</body>
</html>