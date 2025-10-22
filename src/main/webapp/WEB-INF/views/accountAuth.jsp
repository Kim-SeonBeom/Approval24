<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<title>계정 신청 승인 | 결재24</title>
<style>
.form-hint {
	font-size: .85rem;
	color: #858796;
}

.readonly-box {
	background: #f8f9fc;
}
</style>
</head>
<body id="page-top">
	<div id="wrapper">
		<%@ include file="/WEB-INF/views/common/sidebar.jsp"%>

		<div id="content-wrapper" class="d-flex flex-column">
			<div id="content">
				<%@ include file="/WEB-INF/views/common/navbar.jsp"%>

				<div class="container-fluid">
					<!-- Page Heading -->
					<div class="d-flex align-items-center justify-content-between mb-4">
						<h1 class="h3 text-gray-800 m-0">계정 신청 승인</h1>
					</div>

					<div class="row justify-content-center">
						<div class="col-lg-10 col-xl-10">
							<div class="card shadow mb-4">
								<div class="card-header py-3 d-flex align-items-center justify-content-between">
									<h6 class="m-0 font-weight-bold text-primary">
										신청번호: <span class="text-dark">${requestDto.requestId}</span>
									</h6>
								</div>

								<div class="card-body">

									<!-- 신청 정보 (읽기 전용) -->
									<div class="mb-2 text-muted small">신청일: ${requestDto.requestedAt}</div>

									<div class="row">
										<div class="col-md-6 mb-3">
											<label>기관</label> <input type="text" class="form-control readonly-box" value="${requestDto.orgName}" readonly>
										</div>
										<div class="col-md-6 mb-3">
											<label>부서</label> <input type="text" class="form-control readonly-box" value="${requestDto.deptName}" readonly>
										</div>

										<div class="col-md-4 mb-3">
											<label>신청자</label> <input type="text" class="form-control readonly-box" value="${requestDto.userName}" readonly>
										</div>
										<div class="col-md-4 mb-3">
											<label>휴대전화</label> <input type="text" class="form-control readonly-box" value="${requestDto.phone}" readonly>
										</div>
										<div class="col-md-4 mb-3">
											<label>사원번호</label> <input type="text" class="form-control readonly-box" value="${requestDto.employeeNo}" readonly>
										</div>

										<div class="col-md-6 mb-3">
											<label>요청 권한</label> <input type="text" class="form-control readonly-box" value="${requestDto.requestAuthName}" readonly>
										</div>
										<div class="col-md-6 mb-3">
											<label>요청 로그인ID</label> <input type="text" class="form-control readonly-box" value="${requestDto.loginId}" readonly>
										</div>

										<div class="col-12 mb-3">
											<label>신청 사유</label>
											<textarea class="form-control readonly-box" rows="3" readonly>${requestDto.reason}</textarea>
										</div>
									</div>

									<hr>

									<div class="col-12 mb-3">
										<label>관리자 메모(선택)</label>
										<textarea class="form-control" name="adminMemo" rows="2" placeholder="부여 사유, 특이사항 등"></textarea>
									</div>

									<!-- 반려 사유 (반려 선택 시 필수) -->
									<div id="rejectReasonWrap" class="mb-3 mr-3 ml-3" style="display: none;">
										<label class="required">반려 사유</label>
										<textarea class="form-control" name="rejectReason" rows="2" placeholder="반려 사유를 입력하세요"></textarea>
									</div>

								</div>



								<div class="d-flex justify-content-between mb-4 ml-4 mr-4">
									<a href="${pageContext.request.contextPath}/account/requests" class="btn btn-light"> <i class="fas fa-arrow-left mr-1"></i> 목록
									</a>

									<div>
										<c:if test="${loginUser.departmentName eq '인사팀'}">
											<button type="button" class="btn btn-danger mr-2" id="btnReject">
												<i class="fas fa-times mr-1"></i> 반려
											</button>
											<button type="button" class="btn btn-primary" id="btnApprove">
												<i class="fas fa-check mr-1"></i> 승인
											</button>
										</c:if>
									</div>
								</div>
								</form>
							</div>
						</div>

					</div>
				</div>

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

	<script>
		// 승인/반려 버튼 동작
		const $rejectWrap = $('#rejectReasonWrap');

		$('#btnApprove').on('click', function() {
			$('#decision').val('APPROVE');
			$rejectWrap.hide();
			$('#approveForm').trigger('submit');
		});

		$('#btnReject').on('click', function() {
			$('#decision').val('REJECT');
			$rejectWrap.show();

			// 반려 사유가 비어있지 않으면 제출
			const reason = $('textarea[name="rejectReason"]').val();
			if (reason && reason.trim().length > 0) {
				$('#approveForm').trigger('submit');
			} else {
				$('textarea[name="rejectReason"]').focus();
			}
		});
	</script>
</body>
</html>