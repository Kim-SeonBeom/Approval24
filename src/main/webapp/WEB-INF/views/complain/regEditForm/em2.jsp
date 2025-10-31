<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<title>청년도전지원사업  | 결재24</title>
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
						<h1 class="h3 mb-0 text-gray-800">청년도전지원사업 신청서</h1>
					</div>

					<form id="loanApplyForm" method="post" action="${pageContext.request.contextPath}/approval24/loan/training/apply">

						<%@ include file="/WEB-INF/views/complain/regEditForm/complainUserInfo.jsp"%>

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
												<td><input type="text" class="form-control"
													id="BANK_NM" name="BANK_NM" placeholder="은행명"></td>
												<th scope="col" class="text-dark bg-light  font-weight-bold"
													style="vertical-align: middle;">계좌번호</th>
												<td><input type="text" class="form-control"
													id="ACCOUNT_NO" name="ACCOUNT_NO"
													placeholder="계좌번호는 ＂-＂ 없이 숫자로만 입력바랍니다."></td>
											</tr>
											<tr>
												<th>대학재학생 여부</th>
												<td colspan="3"><label> <input class="ml-2"
														type="radio" name="colleger_yn"> 예
												</label> <label> <input class="ml-2" type="radio"
														name="colleger_yn"> 아니오
												</label></td>
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
							</form>
				</div>
				
				

			</div>
			<!-- /.container-fluid -->
		</div>
		<!-- /#content -->

		<%@ include file="/WEB-INF/views/common/footer.jsp"%>
	</div>
	<!-- /#content-wrapper -->
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