<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
												<td><input type="text" class="form-control" name="complainuser_name" ></td>
												<th>주민등록번호</th>
												<td><input type="text" id="complainuser_resi_no_front" maxlength="6" inputmode="numeric" pattern="[0-9]*" placeholder="생년월일 6자리" style="width: 40%; display: inline-block;"> <span class="mx-1">-</span> <input type="text" id="complainuser_resi_no_back" maxlength="7" inputmode="numeric" pattern="[0-9]*" placeholder="뒤 7자리" style="width: 50%; display: inline-block;"></td>
											</tr>
											<tr>
												<th scope="col" class="text-dark bg-light font-weight-bold" style="vertical-align: middle;">주소</th>
												<td colspan="3">
													<div class="d-flex mb-2">
														<input type="text" class="form-control form-postal-code mr-2" placeholder="우편번호" name="complainuser_post" id="postalCode" readonly style="width: 150px;">

														<button type="button" class="btn btn-secondary" onclick="openDaumPostcode()">주소 검색</button>
													</div> <input type="text" class="form-control mb-2" placeholder="기본 주소" name="complainuser_addr1" id="addr1" readonly> <input type="text" class="form-control" placeholder="상세 주소 (건물명, 동/호수 등)" name="complainuser_addr2" id="complainuser_addr2">
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
												<th>출산일(예정일) 또는 유산,사산일</th>
												<td><input type="date" name="date"></td>

												<th>영아의 주민등록번호</th>
												<td colspan="3"><input type="text" id="INFANT_RRN_FRONT" maxlength="6" inputmode="numeric" pattern="[0-9]*" placeholder="생년월일 6자리" style="width: 40%; display: inline-block;"> <span class="mx-1">-</span> <input type="text" id="INFANT_RRN_BACK" maxlength="7" inputmode="numeric" pattern="[0-9]*" placeholder="뒤 7자리" style="width: 50%; display: inline-block;"></td>

											</tr>

											<tr>
												<th>다태아 여부</th>
												<td>
													<div class="form-check form-check-inline">
														<input class="form-check-input" type="radio" name="MULTIPLE_BIRTH_YN" id="MULTIPLE_BIRTH_YN" value="Y" /> <label class="form-check-label" for="MULTIPLE_BIRTH_YN">예</label>
													</div>
													<div class="form-check form-check-inline ml-3">
														<input class="form-check-input" type="radio" name="MULTIPLE_BIRTH_YN" id="MULTIPLE_BIRTH_YN" value="N" /> <label class="form-check-label" for="MULTIPLE_BIRTH_YN">아니오</label>
													</div>
												</td>
												<th>미숙아 여부</th>
												<td>
													<div class="form-check form-check-inline">
														<input class="form-check-input" type="radio" name="PREMATURE_BABY_YN" value="Y" id="PREMATURE_BABY_YN"><label class="form-check-label" for="PREMATURE_BABY_YN">예</label>
													</div>
													<div class="form-check form-check-inline ml-3">
														<input class="form-check-input" type="radio" name="PREMATURE_BABY_YN" value="N" id="PREMATURE_BABY_YN"> <label class="form-check-label" for="PREMATURE_BABY_YN">아니오</label>
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
												<td><input type="date" class=form-contorl " name="CONTRACT_START_DT" id="CONTRACT_START_DT" /></td>
												<th>근로 계약 만료일</th>
												<td><input type="date" class=form-contorl " name="CONTRACT_END_DT" id="CONTRACT_END_DT" /></td>

											</tr>
											<tr>
												<th>출산 전후 휴가 기간</th>
												<td colspan="3"><input type="number" class="form-control" name="MATERNITY_LEAVE_PERIOD" id="MATERNITY_LEAVE_PERIOD"></td>
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
												<td><input type="date" class=form-contorl " name="CURRENT_APPL_START_DT" id="CURRENT_APPL_START_DT" /></td>
												<th>이번 회차 신청 종료일</th>
												<td><input type="date" class=form-contorl " name="CURRENT_APPL_END_DT" id="CURRENT_APPL_END_DT" /></td>
											</tr>
											<tr>
												<th>예금주</th>
												<td><input type="text" class="form-control" name="ACCOUNT_HOLDER_NM" ></td>
												<th>은행명</th>
												<td><input type="text" class="form-control" name="BANK_NM"></td>
											</tr>
											<tr>
												<th>계좌번호</th>
												<td colspan="3"><input type="text" class="form-control" name="PAYMENT_ACCOUNT_NO" ></td>
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
														<input class="form-check-input" type="radio" name="INCOME_YN" id="INCOME_YN" value="Y" > <label class="form-check-label" for="INCOME_YN">예</label>
													</div>
													<div class="form-check form-check-inline ml-3">
														<input class="form-check-input" type="radio" name="INCOME_YN" id="INCOME_YN" value="N" > <label class="form-check-label" for="INCOME_YN">아니오</label>
													</div>
												</td>
											</tr>
											<tr>
												<th>소득 종류</th>
												<td colspan="3">
													<div class="form-check form-check-inline">
														<input class="form-check-input" type="radio" name="INCOME_TYPE" id="INCOME_TYPE" value="사업소득" > <label class="form-check-label" for="INCOME_TYPE">사업소득</label>
													</div>
													<div class="form-check form-check-inline ml-3">
														<input class="form-check-input" type="radio" name="INCOME_TYPE" id="INCOME_TYPE" value="근로소득" > <label class="form-check-label" for="INCOME_TYPE">근로소득</label>
													</div>
												</td>
											</tr>
											<tr>
												<th>소득 활동 시작일</th>
												<td><input type="date" class="form-control" name="INCOME_START_TIME"></td>
												<th>소득 활동 중단일</th>
												<td><input type="date" class="form-control" name="INCOME_END_TIME" ></td>
											</tr>
											<tr>
												<th>근로 기간</th>
												<td colspan="3"><input type="number" name="WORK_HOURS"></td>
											</tr>

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
		document
				.getElementById('btnCalcUnemp')
				.addEventListener(
						'click',
						function() {
							const emp = document
									.querySelector('input[name="EMP_DT"]').value;
							const unemp = document
									.querySelector('input[name="UNEMP_DT"]').value;
							const days = daysBetweenStr(emp, unemp);
							if (days !== '')
								document.getElementById('UNEMP_PERIOD').value = days;
						});

		// 훈련기간 자동 계산 (TRAIN_START_DT ~ TRAIN_END_DT)
		document.getElementById('btnCalcTrain').addEventListener('click',
				function() {
					const st = document.getElementById('TRAIN_START_DT').value;
					const en = document.getElementById('TRAIN_END_DT').value;
					const days = daysBetweenStr(st, en);
					if (days !== '')
						document.getElementById('TRAIN_PERIOD').value = days;
				});
	</script>
</body>
</html>