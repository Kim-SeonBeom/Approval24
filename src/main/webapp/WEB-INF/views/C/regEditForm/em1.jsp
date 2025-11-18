<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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

#historyTable {
    width: 100%;           
    table-layout: fixed;   
    text-align: center;    
}

/* 헤더 중앙 정렬 */
#historyTable thead th {
    text-align: center;
    vertical-align: middle;
}

/* 💡 컬럼별 너비 지정 (총 7개 컬럼에 맞게 조정) */
#historyTable colgroup col:nth-child(1) { width: 10%; } /* 이름 */
#historyTable colgroup col:nth-child(2) { width: 10%; } /* 직급 */
#historyTable colgroup col:nth-child(3) { width: 10%; } /* 계정 ID */
#historyTable colgroup col:nth-child(4) { width: 10%; } /* 결재자 유형 */
#historyTable colgroup col:nth-child(5) { width: 10%; } /* 결재 종류 */
#historyTable colgroup col:nth-child(6) { width: 10%; } /* 상태 */
#historyTable colgroup col:nth-child(7) { width: 40%; } /* 처리일 */
</style>
</head>

<body id="page-top">

	<div id="wrapper">

		<%@ include file="/WEB-INF/views/common/sidebar.jsp"%>

		<div id="content-wrapper" class="d-flex flex-column">
			<div id="content">
				<%@ include file="/WEB-INF/views/common/navbar.jsp"%>

				<div class="container-fluid mb-4">

					<div class="d-sm-flex align-items-center justify-content-between mb-4">
						<h1 class="h3 mb-0 text-gray-800">「청년 빈 일자리 취업지원 특화 프로그램」 수당 지급 신청</h1>
					</div>

					<form id="submitForm" method="post" action="${pageContext.request.contextPath}/complain/category/em1/${detail.complainId}">

						<%@ include file="/WEB-INF/views/C/regEditForm/complainUserInfo.jsp"%>

						<div class="card shadow mb-4">
							<div class="card-header py-3 d-flex align-items-center">
								<h6 class="m-0 font-weight-bold text-primary">취업 성공 수당</h6>
							</div>
							<div class="card-body">
								<div class="table-responsive">
									<table class="table table-bordered mb-0 text-center" width="100%">
										<colgroup>
											<col style="width: 18%">
											<col style="width: 32%">
											<col style="width: 18%">
											<col style="width: 32%">
										</colgroup>
										<tbody>
											<tr>
												<th>회사명</th>
												<td><input type="text" class="form-control" name="bizOwnerNm" value="<c:out value='${detail.bizOwnerNm}'/>"></td>
												<th>업종</th>
												<td><input type="text" class="form-control" name="industryType" value="<c:out value='${detail.industryType}'/>"></td>
											</tr>
											<tr>
												<th scope="col" class="text-dark bg-light font-weight-bold" style="vertical-align: middle;">회사주소</th>
												<td colspan="3">
													<div class="d-flex mb-2">
														<input type="text" class="form-control form-postal-code mr-2" placeholder="우편번호" name="bizPost" id="bizPost" readonly style="width: 150px;" value="<c:out value='${detail.bizPost}'/>">

														<button type="button" class="btn btn-secondary" id="btnSearchBizAddress">주소 검색</button>
													</div> <input type="text" class="form-control mb-2" placeholder="기본 주소" name="bizAddr" id="bizAddr" value="<c:out value='${detail.bizAddr}'/>" readonly> <input type="text" class="form-control" placeholder="상세 주소 (건물명, 동/호수 등)" name="bizAddrDetail" id="bizAddrDetail" value="<c:out value='${detail.bizAddrDetail}'/>">
												</td>

											</tr>
											<tr>
												<th>입사일</th>
												<td colspan="3"><input type="date" class="form-control" name="employmentDt" value="<fmt:formatDate value='${detail.employmentDt}' pattern='yyyy-MM-dd'/>"></td>

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
									<table class="table table-bordered mb-0 text-center" width="100%">
										<colgroup>
											<col style="width: 18%">
											<col style="width: 32%">
											<col style="width: 18%">
											<col style="width: 32%">
										</colgroup>
										<tbody>
											<tr>
												<th>훈련과정명</th>
												<td><input type="text" class="form-control" name="trainCourseNm" value="<c:out value='${detail.trainCourseNm}'/>"></td>
												<th>훈련기관명</th>
												<td><input type="text" class="form-control" name="trainInstituteNm" value="<c:out value='${detail.trainInstituteNm}'/>"></td>
											</tr>
											<tr>
												<th>훈련시작일</th>
												<td><input type="date" class="form-control" name="trainStartDt" value="<fmt:formatDate value='${detail.trainStartDt}' pattern='yyyy-MM-dd'/>"></td>
												<th>훈련종료일</th>
												<td><input type="date" class="form-control" name="trainEndDt" value="<fmt:formatDate value='${detail.trainEndDt}' pattern='yyyy-MM-dd'/>"></td>
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
									<table class="table table-bordered mb-0 text-center" width="100%">
										<colgroup>
											<col style="width: 18%">
											<col style="width: 32%">
											<col style="width: 18%">
											<col style="width: 32%">
										</colgroup>
										<tbody>
											<tr>
												<th>예금주</th>
												<td><input type="text" class="form-control" name="accountHolderNm" value="<c:out value='${detail.accountHolderNm}'/>"></td>
												<th>금융기관</th>
												<td><input type="text" class="form-control" name="bankNm" value="<c:out value='${detail.bankNm}'/>"></td>
											</tr>
											<tr>
												<th>계좌번호</th>
												<td colspan="3"><input type="text" class="form-control" name="accountNo" value="<c:out value='${detail.accountNo}'/>"></td>
											</tr>
										</tbody>
									</table>
								</div>
							</div>
						</div>
						<div class="card shadow mb-4">
							<div class="card-header py-3 d-flex align-items-center">
								<h6 class="m-0 font-weight-bold text-primary">결재 내역</h6>
							</div>
							<div class="card-body">
								<div class="table-responsive">
									<table style="text-align: center;" class="table table-bordered mb-0" id="historyTable">
							
										<thead>
											<tr>
												<th>이름</th>
												<th>직급</th>
												<th>계정 ID</th>
												<th>결재자 유형</th>
												<th>결재 종류</th>
												<th>상태</th>
												<th>처리일</th>
											</tr>
										</thead>
										<tbody>
											<tr>
												<td colspan="7">로딩 중...</td>
											</tr>
										</tbody>
									</table>
									<hr>
								</div>
								<div class="mt-2">
									<label>의견: <input type="text" id="comment" class="form-control" style="width: 300px; display: inline-block;"></label>
								</div>
							</div>
						</div>
						
						<div class="card shadow mb-4">
							<div class="card-header py-3 d-flex align-items-center">
								<h6 class="m-0 font-weight-bold text-primary">반려 사유</h6>
							</div>
							<div class="card-body">
								<div class="table-responsive">
<table style="text-align: center;" class="table table-bordered mb-0"  id="rejectCommentTable">
    <thead>
        <tr>
            <th>처리자 이름</th>
            <th>직급</th>
            <th>반려 사유</th>
            </tr>
    </thead>
    <tbody>
        <tr>
            <td colspan="3">반려 사유를 로딩 중입니다...</td>
        </tr>
    </tbody>
</table>
</div></div></div>
						<div class="d-flex justify-content-between mt-4">
							<a href="${pageContext.request.contextPath}/complain/category/em1" class="btn btn-light"> <i class="fas fa-arrow-left mr-1"></i> 목록으로
							</a>
							<div>

								<c:if test="${pageAuth.updateYn == 'Y'}">
									<button type="button" class="btn btn-secondary" id="btnApprovalLine">
										<i class="fas fa-edit mr-1"></i>결재선설정
									</button>
								</c:if>

								<c:if test="${pageAuth.updateYn == 'Y'}">
									<button type="button" class="btn  btn-secondary" id="btnSave">
										<i class="fas fa-edit mr-1"></i>수정
									</button>
									<button type="button" class="btn btn-warning" id="btnComplainCancel">
										<i class="fas fa-times-circle mr-1"></i>취하
									</button>
								</c:if>
								<c:if test="${pageAuth.approveYn == 'Y'}">
									<button type="button" class="btn btn-primary" id="btnApprove">
										<i class="fas fa-check-circle mr-1"></i>승인
									</button>
									<button type="button" class="btn btn-danger" id="btnReject">
										<i class="fas fa-undo-alt mr-1"></i>반려
									</button>
								</c:if>

							</div>
						</div>
						<input type="hidden" name="complainId" value="<c:out value='${detail.complainId}'/>"> <input type="hidden" name="complainuserNo" value="<c:out value='${userInfo.complainuserNo}'/>">
					</form>

				</div>
				<jsp:include page="../../D/approvalLineEditor.jsp" />

			</div>
			<%@ include file="/WEB-INF/views/common/footer.jsp"%>
		</div>
		</div>
	<%@ include file="/WEB-INF/views/common/logoutModal.jsp"%>
	<script>
		const authData = {
			// 페이지 권한
			canUpdate : '${pageAuth.updateYn}' === 'Y',
			canApprove : '${pageAuth.approveYn}' === 'Y',

			// 담당자 아이디 체크
			complainAccountId : '${complainInfo.accountId}',

			// 현재 로그인한 사용자 정보
			sessionAccountId : '${sessionScope.user}'
		};
		// "취하" & "결재선설정" 권한
		const canCancelOrSetLine = authData.canApprove
				&& (authData.complainAccountId === authData.sessionAccountId);
	</script>
	<script src="${pageContext.request.contextPath}/resources/assets/js/complain/em1.js"></script>
	


	<div class="modal fade" id="submitModal" tabindex="-1" role="dialog" aria-labelledby="submitModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="submitModalLabel">저장</h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">입력하신 내용으로 신청서를 저장할까요?</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
					<button type="button" class="btn btn-primary" id="btnSubmitConfirm">저장</button>
				</div>
			</div>
		</div>
	</div>
	
<div class="modal fade" id="msgModal" tabindex="-1" role="dialog" aria-labelledby="msgModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content shadow">
            <div class="modal-header">
                <h5 class="modal-title" id="msgModalLabel">알림</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                ${msg}
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary" data-dismiss="modal">확인</button>
            </div>
        </div>
    </div>
</div>

<c:if test="${not empty msg}">
    <script>
        $(document).ready(function(){
            $('#msgModal').modal('show');
        });
    </script>
</c:if>
</body>
</html>