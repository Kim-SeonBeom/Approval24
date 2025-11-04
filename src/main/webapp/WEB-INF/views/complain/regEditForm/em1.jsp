<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<title>청년 빈 일자리 취업지원 특화 프로그램 수당 지급 신청 | 결재24</title>
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
						<h1 class="h3 mb-0 text-gray-800">「청년 빈 일자리 취업지원 특화 프로그램」 수당
							지급 신청</h1>
					</div>

					<form id="submitForm" method="post"
						action="${pageContext.request.contextPath}/em1/${detail.complainId}">

						<%@ include
							file="/WEB-INF/views/complain/regEditForm/complainUserInfo.jsp"%>

						<div class="card shadow mb-4">
							<div class="card-header py-3 d-flex align-items-center">
								<h6 class="m-0 font-weight-bold text-primary">취업 성공 수당</h6>
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
												<td><input type="text" class="form-control"
													name="bizOwnerNm" value="<c:out value='${detail.bizOwnerNm}'/>"></td>
												<th>업종</th>
												<td><input type="text" class="form-control"
													name="industryType" value="<c:out value='${detail.industryType}'/>"></td>
											</tr>
											<tr>
												<th scope="col" class="text-dark bg-light font-weight-bold"
													style="vertical-align: middle;">회사주소</th>
												<td colspan="3">
													<div class="d-flex mb-2">
														<input type="text"
															class="form-control form-postal-code mr-2"
															placeholder="우편번호" name="bizPost" id="bizPost" readonly
															style="width: 150px;"
															value="<c:out value='${detail.bizPost}'/>">

														<button type="button" class="btn btn-secondary"
															id="btnSearchBizAddress" onclick="openBizPostcode()">주소
															검색</button>
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
												<th>입사일</th>
												<td colspan="3"><input type="date" class="form-control"
													name="employmentDt" value="<fmt:formatDate value='${detail.employmentDt}' pattern='yyyy-MM-dd'/>"></td>

											</tr>
										</tbody>
									</table>
								</div>
							</div>
						</div>

						<div class="card shadow mb-4">
							<div class="card-header py-3 d-flex align-items-center">
								<h6 class="m-0 font-weight-bold text-primary">훈련 참여 수당</h6>
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
												<th>훈련과정명</th>
												<td><input type="text" class="form-control"
													name="trainCourseNm" value="<c:out value='${detail.trainCourseNm}'/>"></td>
												<th>훈련기관명</th>
												<td><input type="text" class="form-control"
													name="trainInstituteNm" value="<c:out value='${detail.trainInstituteNm}'/>"></td>
											</tr>
											<tr>
												<th>훈련시작일</th>
												<td><input type="date" class="form-control"
													name="trainStartDt" value="<fmt:formatDate value='${detail.trainStartDt}' pattern='yyyy-MM-dd'/>"></td>
												<th>훈련종료일</th>
												<td><input type="date" class="form-control"
													name="trainEndDt" value="<fmt:formatDate value='${detail.trainEndDt}' pattern='yyyy-MM-dd'/>"></td>
											</tr>
										</tbody>
									</table>
								</div>
							</div>
						</div>

						<div class="card shadow mb-4">
							<div class="card-header py-3 d-flex align-items-center">
								<h6 class="m-0 font-weight-bold text-primary">수당수급계좌번호</h6>
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
												<td><input type="text" class="form-control"
													name="accountHolderNm"  value="<c:out value='${detail.accountHolderNm}'/>"></td>
												<th>금융기관</th>
												<td><input type="text" class="form-control"
													name="bankNm" value="<c:out value='${detail.bankNm}'/>"></td>
											</tr>
											<tr>
												<th>계좌번호</th>
												<td colspan="3"><input type="text" class="form-control"
													name="accountNo"  value="<c:out value='${detail.accountNo}'/>"></td>
											</tr>
										</tbody>
									</table>
								</div>
							</div>
						</div>

						<div class="d-flex justify-content-between mt-4">
							<a href="${pageContext.request.contextPath}/complains"
								class="btn btn-light"> <i class="fas fa-arrow-left mr-1"></i>
								취소
							</a>
							<div>
								<button type="button" class="btn btn-primary" id="btnUpdate">
									<i class="fas fa-edit mr-1"></i>수정
								</button>
							</div>
						</div>
						<input type="hidden" name="complainId"
							value="<c:out value='${detail.complainId}'/>"> <input
							type="hidden" name="complainuserNo"
							value="<c:out value='${user.complainuserNo}'/>">


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
	<script
		src="${pageContext.request.contextPath}/resources/assets/js/complain/em1.js"></script>


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