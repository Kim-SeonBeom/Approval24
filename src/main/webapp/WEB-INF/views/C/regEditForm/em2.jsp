<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<title>청년도전지원사업 | 결재24</title>
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
						<h1 class="h3 mb-0 text-gray-800">청년도전지원사업 신청서</h1>
					</div>

					<form id="submitForm" method="post"
						action="${pageContext.request.contextPath}/em2/${detail.complainId}">

						<%@ include
							file="/WEB-INF/views/C/regEditForm/complainUserInfo.jsp"%>

						<div class="card shadow mb-4">
							<div class="card-header py-3 d-flex align-items-center">
								<h6 class="m-0 font-weight-bold text-primary">추가 정보</h6>
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
												<th scope="col" class="text-dark bg-light  font-weight-bold"
													style="vertical-align: middle;">은행명</th>
												<td><input type="text" class="form-control" id="bankNm"
													name="bankNm" placeholder="은행명"
													value="<c:out value='${detail.bankNm}'/>"></td>
												<th scope="col" class="text-dark bg-light  font-weight-bold"
													style="vertical-align: middle;">계좌번호</th>
												<td><input type="text" class="form-control"
													id="accountNo" name="accountNo"
													value="<c:out value='${detail.accountNo}'/>"
													placeholder="계좌번호는 ＂-＂ 없이 숫자로만 입력바랍니다."></td>
											</tr>
											<tr>
												<th>대학재학생 여부</th>
												<td colspan="3">
													<div class="form-check form-check-inline">
														<input class="form-check-input" type="radio"
															name="collegerYn" id="collegerYnY" value="Y"
															<c:if test="${detail != null && detail.collegerYn eq 'Y'}">checked</c:if>>
														<label class="form-check-label" for="collegerYnY">예</label>
													</div>
													<div class="form-check form-check-inline ml-3">
														<input class="form-check-input" type="radio"
															name="collegerYn" id="collegerYnN" value="N"
															<c:if test="${detail == null || detail.collegerYn ne 'Y'}">checked</c:if>>
														<label class="form-check-label" for="collegerYnN">아니오</label>
													</div>
												</td>
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
							value="<c:out value='${userInfo.complainuserNo}'/>">

					</form>
				</div>



			</div>
			<!-- /.container-fluid -->
		</div>
		<!-- /#content -->

		<%@ include file="/WEB-INF/views/common/footer.jsp"%>
				<script src="${pageContext.request.contextPath}/resources/assets/js/complain/em2.js"></script>
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