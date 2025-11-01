<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

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

		<%@ include file="/WEB-INF/views/common/sidebar.jsp"%>

		<div id="content-wrapper" class="d-flex flex-column">
			<div id="content">
				<%@ include file="/WEB-INF/views/common/navbar.jsp"%>

				<div class="container-fluid mb-4">

					<!-- Heading -->
					<div
						class="d-sm-flex align-items-center justify-content-between mb-4">
						<h1 class="h3 mb-0 text-gray-800">고용보험 미적용자 출산(유산･사산) 급여 신청서</h1>
					</div>

					<form id="submitForm" method="post"
						action="${pageContext.request.contextPath}/mt2/${detail.complainId}">

						<%@ include
							file="/WEB-INF/views/complain/regEditForm/complainUserInfo.jsp"%>

						<div class="card shadow mb-4">
							<div class="card-header py-3 d-flex align-items-center">
								<h6 class="m-0 font-weight-bold text-primary">출산 정보</h6>
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
												<th>출산(유산/사산)일</th>
												<td><input type="date" class="form-control"
													name="birthdate"
													value="<fmt:formatDate value='${detail.birthdate}' pattern='yyyy-MM-dd'/>"></td>
												<th>영아의 주민등록번호</th>
												<td><input type="text" id="babyResiNoFront"
													name="babyResiNoFront" maxlength="6" inputmode="numeric"
													pattern="[0-9]*" placeholder="생년월일 6자리"
													style="width: 40%; display: inline-block;"
													class="form-control"
													value="<c:out value='${detail.babyResiNoFront}'/>">
													<span class="mx-1">-</span> <input type="text"
													id="babyResiNoBack" maxlength="7" inputmode="numeric"
													pattern="[0-9]*" placeholder="뒤 7자리"
													style="width: 50%; display: inline-block;"
													class="form-control"
													value="<c:out value='${detail.babyResiNoBack}'/>"></td>
											</tr>
										</tbody>
									</table>
								</div>
							</div>
						</div>

						<div class="card shadow mb-4">
							<div class="card-header py-3 d-flex align-items-center">
								<h6 class="m-0 font-weight-bold text-primary">사업주와 동거･친족
									여부(출산일 현재 근로자인 경우)</h6>
							</div>
							<div class="card-body">
								<div class="table-responsive">
									<table class="table table-bordered mb-0" style="width: 100%">
										<colgroup>
											<col style="width: 18%">
											<col style="width: 32%">
											<col style="width: 18%">
											<col style="width: 32%">
										</colgroup>
										<tbody>
											<tr>
												<th>동거여부</th>
												<td class="align-middle">
													<div class="form-check form-check-inline">
														<input class="form-check-input" type="radio"
															name="cohabitYn" id="cohabitYnY" value="Y"
															<c:if test="${detail.cohabitYn eq 'Y'}">checked</c:if>>
														<label class="form-check-label" for="cohabitYnY">예</label>
													</div>
													<div class="form-check form-check-inline ml-3">
														<input class="form-check-input" type="radio"
															name="cohabitYn" id="cohabitYnN" value="N"
															<c:if test="${detail.cohabitYn ne 'Y'}">checked</c:if>>
														<label class="form-check-label" for="cohabitYnN">아니오</label>
													</div>
												</td>
												<th>친족여부</th>
												<td>
													<div class="form-check form-check-inline ml-3">
														<input class="form-check-input" type="radio"
															name="RELATIONSHIP" id="RELATIONSHIP_1" value="배우자"
															<c:if test="${detail.relationship eq '배우자'}">checked</c:if>>
														<label class="form-check-label" for="RELATIONSHIP_1">배우자</label>
													</div> &emsp;&emsp;&ensp;
													<div class="form-check form-check-inline ml-3">
														<input class="form-check-input" type="radio"
															name="RELATIONSHIP" id="RELATIONSHIP_2" value="4촌이내"
															<c:if test="${detail.relationship eq '4촌이내'}">checked</c:if>>
														<label class="form-check-label" for="RELATIONSHIP_2">4촌이내
															인척 </label>
													</div> <br>
													<div class="form-check form-check-inline ml-3">
														<input class="form-check-input" type="radio"
															name="RELATIONSHIP" id="RELATIONSHIP_3" value="8촌이내"
															<c:if test="${detail.relationship eq '8촌이내'}">checked</c:if>>
														<label class="form-check-label" for="RELATIONSHIP_3">8촌이내
															혈족</label>
													</div>
													<div class="form-check form-check-inline ml-3">
														<input class="form-check-input" type="radio"
															name="RELATIONSHIP" id="RELATIONSHIP_4" value="해당없음"
															<c:if test="${detail.relationship eq '해당없음'}">checked</c:if>>
														<label class="form-check-label" for="RELATIONSHIP_4">해당없음</label>
													</div>
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
								<h6 class="m-0 font-weight-bold text-primary">사업장 정보(출산일 현재
									1인사업자인 경우)</h6>
							</div>
							<div class="card-body">
								<div class="table-responsive">
									<table class="table table-bordered mb-0" style="width: 100%">
										<colgroup>
											<col style="width: 18%">
											<col style="width: 32%">
											<col style="width: 18%">
											<col style="width: 32%">
										</colgroup>
										<tbody>
											<tr>
												<th>사업장명</th>
												<td><input type="text" class="form-control"
													name="bizOwnerNm"
													value="<c:out value='${detail.bizOwnerNm}'/>"></td>
												<th>사업장의 고용보험관리번호</th>
												<td><input type="text" class="form-control"
													name="empInsurMngNo"
													value="<c:out value='${detail.empInsurMngNo}'/>"></td>
											</tr>
											<tr>
												<th scope="col" class="text-dark bg-light font-weight-bold"
													style="vertical-align: middle;">사업장주소</th>
												<td colspan="3">
													<div class="d-flex mb-2">
														<input type="text"
															class="form-control form-postal-code mr-2"
															placeholder="우편번호" name="bisPost" id="bisPost" readonly
															style="width: 150px;"
															value="<c:out value='${detail.bisPost}'/>">

														<button type="button" class="btn btn-secondary"
															onclick="openDaumPostcode()">주소 검색</button>
													</div> <input type="text" class="form-control mb-2"
													placeholder="기본 주소" name="bizAddr" id="bizAddr"
													value="<c:out value='${detail.bizAddr}'/>" readonly>
													<input type="text" class="form-control"
													placeholder="상세 주소 (건물명, 동/호수 등)" name="bizAddrDetail"
													id="bizAddrDetail"
													value="<c:out value='${detail.bizAddrDetail}'/>">
												</td>
											</tr>
											<tr>
												<th>사업자등록번호</th>
												<td><input type="text" class="form-control"
													name="bizRegNo" value="<c:out value='${detail.bizRegNo}'/>"></td>
												<th>법인등록번호</th>
												<td><input type="text" class="form-control"
													name="corpRegNo"
													value="<c:out value='${detail.corpRegNo}'/>"></td>
											</tr>
											<tr>
												<th>자영업자고용보험 가입여부</th>
												<td colspan="3">
													<div class="form-check form-check-inline">
														<input class="form-check-input" type="radio"
															name="selfEmpInsurYn" id="selfEmpInsurYnY" value="Y"
															<c:if test="${detail.selfEmpInsurYn eq 'Y'}">checked</c:if>>
														<label class="form-check-label" for="selfEmpInsurYnY">가입</label>
													</div>
													<div class="form-check form-check-inline ml-3">
														<input class="form-check-input" type="radio"
															name="selfEmpInsurYn" id="selfEmpInsurYnN" value="N"
															<c:if test="${detail.selfEmpInsurYn ne 'Y'}">checked</c:if>>
														<label class="form-check-label" for="selfEmpInsurYnN">미가입</label>
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
									<table class="table table-bordered mb-0" style="width: 100%">
										<colgroup>
											<col style="width: 18%">
											<col style="width: 32%">
											<col style="width: 18%">
											<col style="width: 32%">
										</colgroup>
										<tbody>
											<tr>
												<th>급여의 구분</th>
												<td class="align-middle">
													<div class="form-check form-check-inline ml-3">
														<input class="form-check-input" type="radio"
															name="benefitType" id="benefitType_1" value="출산급여"
															<c:if test="${detail.benefitType eq '출산급여'}">checked</c:if>>
														<label class="form-check-label" for="benefitType_1">출산급여</label>
													</div>
													<div class="form-check form-check-inline ml-3">
														<input class="form-check-input" type="radio"
															name="benefitType" id=benefitType_2 value="유산/사산급여"
															<c:if test="${detail.benefitType ne '출산급여'}">checked</c:if>>
														<label class="form-check-label" for="benefitType_2">유산/사산급여</label>
													</div>
												</td>
												<th>임신기간</th>
												<td>
													<div class="form-check form-check-inline ml-3">
														<input class="form-check-input" type="radio"
															name="pregnancyWeek" id="PREGNANCY_WEEK_1" value="15주이내"
															<c:if test="${detail.pregnancyWeek eq '15주이내'}">checked</c:if>>
														<label class="form-check-label" for="PREGNANCY_WEEK_1">15주
															이내</label>
													</div>
													<div class="form-check form-check-inline ml-3">
														<input class="form-check-input" type="radio"
															name="pregnancyWeek" id="PREGNANCY_WEEK_2" value="16~21주"
															<c:if test="${detail.pregnancyWeek eq '16~21주'}">checked</c:if>>
														<label class="form-check-label" for="PREGNANCY_WEEK_2">16~21주</label>
													</div> <br>
													<div class="form-check form-check-inline ml-3">
														<input class="form-check-input" type="radio"
															name="pregnancyWeek" id="PREGNANCY_WEEK_3" value="22~27주"
															<c:if test="${detail.pregnancyWeek eq '22~27주'}">checked</c:if>>
														<label class="form-check-label" for="PREGNANCY_WEEK_3">22~27주
														</label>
													</div>&nbsp;
													<div class="form-check form-check-inline ml-3">
														<input class="form-check-input" type="radio"
															name="pregnancyWeek" id="PREGNANCY_WEEK_4" value="28주"
															<c:if test="${detail.pregnancyWeek eq '28주이상'}">checked</c:if>>
														<label class="form-check-label" for="PREGNANCY_WEEK_4">28주
															이상</label>
													</div>
												</td>
											</tr>
											<tr>
												<th scope="col" class="text-dark bg-light  font-weight-bold"
													style="vertical-align: middle;">은행명</th>
												<td><input type="text" class="form-control" id="bankNm"
													name="bankNm" placeholder="은행명"
													value="<c:out value='${detail.bankNm}'/>" /></td>
												<th scope="col" class="text-dark bg-light  font-weight-bold"
													style="vertical-align: middle;">예금주</th>
												<td class="form-control"><input type="text"
													class="form-control" id="accountHolderNm"
													name="accountHolderNm" placeholder="예금주"
													value="<c:out value='${detail.accountHolderNm}'/>"></td>
											</tr>
											<tr>
												<th scope="col" class="text-dark bg-light  font-weight-bold"
													style="vertical-align: middle;">계좌번호</th>
												<td colspan="3"><input type="text" class="form-control"
													id="accountNo" name="accountNo" placeholder="계좌번호"
													value="<c:out value='${detail.accountNo}'/>"></td>
											</tr>
										</tbody>
									</table>
								</div>
							</div>
						</div>


						<!-- 출산(유산･사산)일 현재 소득활동 여부 -->
						<div class="card shadow mb-4">
							<div class="card-header py-3 d-flex align-items-center">
								<h6 class="m-0 font-weight-bold text-primary">출산(유산･사산)일 현재
									소득활동 여부(택1)</h6>
							</div>
							<div class="card-body">
								<div class="table-responsive">
									<table class="table table-bordered mb-0" style="width: 100%">
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
													<div class="form-check form-check-inline ml-3">
														<input class="form-check-input" type="radio"
															name="incomeAct" id="incomeAct_1" value="incomeType1"
															<c:if test="${detail.incomeAct eq 'incomeType1'}">checked</c:if>>
														<label class="form-check-label" for="incomeAct_1">고용보험
															피보험자이나 180일 요건 미충족으로 고용보험의 ‘출산전후휴가급여’를 지급받지 못하는 자</label>
													</div> <br>
													<div class="form-check form-check-inline ml-3">
														<input class="form-check-input" type="radio"
															name="incomeAct" id="incomeAct_2" value="incomeType2"
															<c:if test="${detail.incomeAct eq 'incomeType2'}">checked</c:if>>
														<label class="form-check-label" for="incomeAct_2">고용보험법
															적용 제외 사업의 근로자이거나 고용보험법 적용 제외자</label>
													</div> <br>
													<div class="form-check form-check-inline ml-3">
														<input class="form-check-input" type="radio"
															name="incomeAct" id="incomeAct_3" value="incomeType3"
															<c:if test="${detail.incomeAct eq 'incomeType3'}">checked</c:if>>
														<label class="form-check-label" for="incomeAct_3">고용보험
															미성립사업장 소속 고용보험 미가입 근로자</label>
													</div>
												</td>
											</tr>
											<tr>
												<th>1인사업자(피고용인이 없는 단독사업자 및 공동사업자)</th>
												<td colspan="3">
													<div class="form-check form-check-inline ml-3">
														<input class="form-check-input" type="radio"
															name="incomeAct" id="incomeAct_3" value="incomeType3"
															<c:if test="${detail.incomeAct eq 'incomeType3'}">checked</c:if>>
														<label class="form-check-label" for="incomeAct_3">전전년도~출산년도
															사업에 대한 세금신고 사실이 있는 자</label>
													</div> <br>
													<div class="form-check form-check-inline ml-3">
														<input class="form-check-input" type="radio"
															name="incomeAct" id="incomeAct_4" value="incomeType4"
															<c:if test="${detail.incomeAct eq 'incomeType4'}">checked</c:if>>
														<label class="form-check-label" for="incomeAct_4">전전년도~출산년도
															사업에 대한 세금신고 사실이 없는 자</label>
													</div>
												</td>
											</tr>
											<tr>
												<th>기타 소득활동하는 자</th>
												<td colspan="3">
													<div class="form-check form-check-inline ml-3">
														<input class="form-check-input" type="radio"
															name="incomeAct" id="incomeAct_54" value="incomeType5"
															<c:if test="${detail.incomeAct eq 'incomeType5'}">checked</c:if>>
														<label class="form-check-label" for="incomeAct_5">사업자등록증
															없는 특수형태근로자, 프리랜서 등</label>
													</div>
												</td>
											</tr>
										</tbody>
									</table>
								</div>
							</div>
						</div>


						<!-- 신청기간 연장사유 -->
						<div class="card shadow mb-4">
							<div class="card-header py-3 d-flex align-items-center">
								<h6 class="m-0 font-weight-bold text-primary">신청기간 연장사유(출산
									또는 유산･사산일로부터 1년을 경과하여 신청하는 경우에만 기재)</h6>
							</div>
							<div class="card-body">
								<div class="table-responsive">
									<table class="table table-bordered mb-0" style="width: 100%">
										<colgroup>
											<col style="width: 18%">
											<col style="width: 32%">
											<col style="width: 18%">
											<col style="width: 32%">
										</colgroup>
										<tbody>
											<tr>
												<td colspan="4"><input type="text" class="form-control"
													id="applPeriodExtReason" name="applPeriodExtReason"
													value="<c:out value='${detail.applPeriodExtReason}'/>">
												</td>
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

						<input type="hidden" name="complainId" value="<c:out value='${detail.complainId}'/>"> <input type="hidden" name="complainuserNo" value="<c:out value='${user.complainuserNo}'/>">
					</form>
				</div>
			</div>

			<!-- /.container-fluid -->
		</div>
		<!-- /#content -->

		<%@ include file="/WEB-INF/views/common/footer.jsp"%>
		<script src="${pageContext.request.contextPath}/resources/assets/js/complain/mt2.js"></script>
	</div>
	<!-- /#content-wrapper -->
	<!-- /#wrapper -->

	<%@ include file="/WEB-INF/views/common/logoutModal.jsp"%>

	<!-- Submit Modal -->
	<div class="modal fade" id="submitModal" tabindex="-1" role="dialog"
		aria-labelledby="submitModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="submitModalLabel">신청 제출</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">입력하신 내용으로 신청을 제출할까요?</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-dismiss="modal">취소</button>
					<button type="button" class="btn btn-primary" id="btnSubmitConfirm">제출</button>
				</div>
			</div>
		</div>
	</div>

</body>
</html>