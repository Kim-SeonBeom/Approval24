<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<title>고용보험 미적용자 출산(유산･사산) 급여 신청 | 결재24</title>
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

		<%@ include file="/WEB-INF/views/common/sidebar2.jsp"%>

		<div id="content-wrapper" class="d-flex flex-column">
			<div id="content">
				<%@ include file="/WEB-INF/views/common/navbar.jsp"%>

				<div class="container-fluid mb-4">

					<!-- Heading -->
					<div class="d-sm-flex align-items-center justify-content-between mb-4">
						<h1 class="h3 mb-0 text-gray-800">고용보험 미적용자 출산(유산･사산) 급여 신청서</h1>
					</div>

					<form id="loanApplyForm" method="post" action="${pageContext.request.contextPath}/approval24/loan/training/apply">

						<div class="card shadow mb-4">
							<div class="card-header py-3 d-flex align-items-center">
								<h6 class="m-0 font-weight-bold text-primary">신청인 정보(출산여성 본인)</h6>
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
												<td><input type="text" class="form-control" name="prev_co_nm" value="${dto.prev_co_nm}"></td>
												<th>주민등록번호</th>
												<td><input type="text" id="jumin_front" maxlength="6" inputmode="numeric" pattern="[0-9]*" placeholder="생년월일 6자리" style="width: 40%; display: inline-block;"> <span class="mx-1">-</span> <input type="text" id="jumin_back" maxlength="7" inputmode="numeric" pattern="[0-9]*" placeholder="뒤 7자리" style="width: 50%; display: inline-block;"></td>
											</tr>
											<tr>
												<th scope="col" class="text-dark bg-light font-weight-bold" style="vertical-align: middle;">주소</th>
												<td colspan="3">
													<div class="d-flex mb-2">
														<input type="text" class="form-control form-postal-code mr-2" placeholder="우편번호" name="postalCode" id="postalCode" readonly style="width: 150px;">

														<button type="button" class="btn btn-secondary" onclick="openDaumPostcode()">주소 검색</button>
													</div> <input type="text" class="form-control mb-2" placeholder="기본 주소" name="addr1" id="addr1" readonly> <input type="text" class="form-control" placeholder="상세 주소 (건물명, 동/호수 등)" name="addr2" id="addr2">
												</td>
											</tr>
											<tr>
												<th>전화번호</th>
												<td><input type="tel" class="form-control" name="UNEMP_DT"></td>
												<th>휴대전화번호</th>

												<td><input type="tel" class="form-control" name="UNEMP_DT"></td>

											</tr>
											<tr>
												<th>출산(유산/사산)일</th>
												<td><input type="date" class="form-control" name="UNEMP_DT" value="${dto.UNEMP_DT}"></td>
												<th>주민등록번호</th>
												<td><input type="text" id="jumin_front" maxlength="6" inputmode="numeric" pattern="[0-9]*" placeholder="생년월일 6자리" style="width: 40%; display: inline-block;"> <span class="mx-1">-</span> <input type="text" id="jumin_back" maxlength="7" inputmode="numeric" pattern="[0-9]*" placeholder="뒤 7자리" style="width: 50%; display: inline-block;"></td>
											</tr>
										</tbody>
									</table>
								</div>
							</div>
						</div>

						<div class="card shadow mb-4">
							<div class="card-header py-3 d-flex align-items-center">
								<h6 class="m-0 font-weight-bold text-primary">사업주와 동거･친족 여부(출산일 현재 근로자인 경우)</h6>
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
												<th>동거여부</th>
												<td>
													<div class="form-check form-check-inline">
														<input class="form-check-input" type="radio" name="LIVING_TOGETHER_YN" id="livingTogetherY" value="Y" <c:if test="${dto.SUBSIDY_BENEFIT_YN eq 'Y'}">checked</c:if>> <label class="form-check-label" for="livingY">예</label>
													</div>
													<div class="form-check form-check-inline ml-3">
														<input class="form-check-input" type="radio" name="LIVING_TOGETHER_YN" id="livingTogetherN" value="N" <c:if test="${dto.SUBSIDY_BENEFIT_YN ne 'Y'}">checked</c:if>> <label class="form-check-label" for="livingN">아니오</label>
													</div>
												</td>
												<th>친족여부</th>
													<td colspan="1">
													<label>
													<input class="ml-1" type="radio" name="payment_method" value="certification"> 배우자</label>
													<label>
													<input class="ml-1" type="radio" name="payment_method"  value="provisional"> 8촌이내 혈족</label>
													<label>
													<input class="ml-1" type="radio" name="payment_method" value="termination"> 4촌이내 인척</label><br>
													<label>
													<input class="ml-1" type="radio" name="payment_method" value="sickness"> 해당없음</label>
													</td>
												</tr>
										</tbody>
									</table>
								</div>
							</div>
						</div>

						<!-- 사업장 정보(출산일 현재 1인사업자인 경우) -->
						<div class="card shadow mb-4">
							<div class="card-header py-3 d-flex align-items-center">
								<h6 class="m-0 font-weight-bold text-primary">사업장 정보(출산일 현재 1인사업자인 경우)</h6>
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
												<th>사업장명</th>
												<td><input type="text" class="form-control" name="TRAIN_INSTITUTE_NM" value="${dto.TRAIN_INSTITUTE_NM}"></td>
												<th>사업장의 고용보험관리번호</th>
												<td><input type="text" class="form-control" name="TRAIN_INSTITUTE_NM" value="${dto.TRAIN_INSTITUTE_NM}"></td>
											</tr>
											<tr>
												<th scope="col" class="text-dark bg-light font-weight-bold" style="vertical-align: middle;">사업장주소</th>
												<td colspan="3">
													<div class="d-flex mb-2">
														<input type="text" class="form-control form-postal-code mr-2" placeholder="우편번호" name="postalCode" id="postalCode" readonly style="width: 150px;">

														<button type="button" class="btn btn-secondary" onclick="openDaumPostcode()">주소 검색</button>
													</div> <input type="text" class="form-control mb-2" placeholder="기본 주소" name="addr1" id="addr1" readonly> <input type="text" class="form-control" placeholder="상세 주소 (건물명, 동/호수 등)" name="addr2" id="addr2">
												</td>
											</tr>
											<tr>
												<th>사업자등록번호</th>
												<td><input type="text" class="form-control" name="TRAIN_INSTITUTE_NM" value="${dto.TRAIN_INSTITUTE_NM}"></td>
												<th>법인등록번호</th>
												<td><input type="text" class="form-control" name="TRAIN_INSTITUTE_NM" value="${dto.TRAIN_INSTITUTE_NM}"></td>
											</tr>
											<tr>
											<th>자영업자고용보험 가입여부</th>
												<td colspan="3">
													<div class="form-check form-check-inline">
														<input class="form-check-input" type="radio" name="register_YN" id="registerY" value="Y" <c:if test="${dto.SUBSIDY_BENEFIT_YN eq 'Y'}">checked</c:if>> <label class="form-check-label" for="registerY">가입</label>
													</div>
													<div class="form-check form-check-inline ml-3">
														<input class="form-check-input" type="radio" name="register_YN" id="registerN" value="N" <c:if test="${dto.SUBSIDY_BENEFIT_YN ne 'Y'}">checked</c:if>> <label class="form-check-label" for="registerN">미가입</label>
													</div>
												</td>
											</tr>								
										</tbody>
									</table>
								</div>
							</div>
						</div>

						<!-- 신청내용 -->
						<div class="card shadow mb-4">
							<div class="card-header py-3 d-flex align-items-center">
								<h6 class="m-0 font-weight-bold text-primary">신청내용</h6>
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
												<th>급여의 구분</th>
													<td colspan="6">
													<label>
													<input class="ml-6" type="radio" name="payment_method" value="certification"> 출산급여</label><br>
													<label>
													<input class="ml-6" type="radio" name="payment_method"  value="provisional"> 유산/사산급여 (임신기간 : </label>
													<label>
													<input class="ml-6" type="checkbox" name="payment_method" value="termination"> 15주 이내</label>
													<label>
													<input class="ml-6" type="checkbox" name="payment_method" value="termination"> 16~21주</label>
													<label>
													<input class="ml-6" type="checkbox" name="payment_method" value="termination"> 22~27주</label>
													<label>
													<input class="ml-6" type="checkbox" name="payment_method" value="termination"> 28주 이상</label> )
													</td>
											</tr>
											<tr >
                                            <th scope="col" class="text-dark bg-light  font-weight-bold"  style="vertical-align: middle;" >은행명</th>
                                            <td>
                                                <input type="text" class="form-control" id="applicantName" name="applicantName" placeholder="은행명">
											</td>
											<th scope="col" class="text-dark bg-light  font-weight-bold"  style="vertical-align: middle;" >예금주</th>
                                            <td class="form-control">
                                              <input type="text" class="form-control" id="applicantName" name="applicantName" placeholder="예금주">
											</td>
	                                        </tr>
	                                        <tr >
	                                            <th scope="col" class="text-dark bg-light  font-weight-bold"  style="vertical-align: middle;" >계좌번호</th>
	                                            <td colspan="3">
	                                                <input type="text" class="form-control" id="applicantName" name="applicantName" placeholder="계좌번호">
												</td>
	                                        </tr>
										</tbody>
									</table>
								</div>
							</div>
						</div>
						
						
						<!-- 출산(유산･사산)일 현재 소득활동 여부 -->
						<div class="card shadow mb-4">
							<div class="card-header py-3 d-flex align-items-center">
								<h6 class="m-0 font-weight-bold text-primary">출산(유산･사산)일 현재 소득활동 여부</h6>
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
												<th>근로자</th>
													<td colspan="3">
													<label>
													<input class="ml-2" type="radio" name="payment_method" value="certification"> 고용보험 피보험자이나 180일 요건 미충족으로 고용보험의 ‘출산전후휴가급여’를 지급받지 못하는 자(출산일 전일까지 30일 이상 피보험자격을 유지하고 있어야 함)</label><br>
													<label>
													<input class="ml-2" type="radio" name="payment_method"  value="provisional"> 고용보험법 적용 제외 사업의 근로자이거나 고용보험법 적용 제외자</label><br>
													<label>
													<input class="ml-2" type="radio" name="payment_method"  value="provisional"> 고용보험 미성립사업장 소속 고용보험 미가입 근로자</label><br>
													</td>
											</tr>
											<tr>
												<th>1인사업자(피고용인이 없는 단독사업자 및 공동사업자)</th>
													<td colspan="3">
													<label>
													<input class="ml-2" type="radio" name="payment_method" value="certification"> 전전년도~출산년도 사업에 대한 세금신고 사실이 있는 자</label><br>
													<label>
													<input class="ml-2" type="radio" name="payment_method"  value="provisional"> 전전년도~출산년도 사업에 대한 세금신고 사실이 없는 자</label><br>
													</td>
											</tr>
											<tr>
												<th>기타 소득활동하는 자</th>
													<td colspan="3">
													<label>
													<input class="ml-2" type="radio" name="payment_method" value="certification"> 사업자등록증 없는 특수형태근로자, 프리랜서 등</label>
													</td>
											</tr>
										</tbody>
									</table>
								</div>
							</div>
						</div>
						
						

						<!-- E. 대부 신청 정보 -->

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