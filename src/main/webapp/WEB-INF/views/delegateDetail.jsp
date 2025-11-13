<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:useBean id="now" class="java.util.Date" />

<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<title>대결자 등록 | 결재24</title>
<style>
/* 표 기반(딱딱한) 작성 레이아웃 */
.kv-table th {
	width: 140px;
	background: #f8f9fc;
	vertical-align: middle;
}

.kv-table td {
	background: #fff;
}
/* 상세와 동일한 룩앤필 유지 */
.kv-table .content-cell {
	white-space: pre-wrap;
	line-height: 1.6;
	min-height: 300px;
}
/* 파일 리스트 UI 정리 */
.kv-table .attach-cell ul {
	margin: 0;
	padding-left: 1rem;
}

.kv-table .attach-cell li+li {
	margin-top: .25rem;
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

					<!-- 상단 제목/버튼 -->
					<div class="d-sm-flex align-items-center justify-content-between mb-3">
						<h1 class="h3 mb-0 text-gray-800">대결자 등록</h1>

					</div>
					<br>
					<c:if test="${not empty insertMsg}">
						<div class="alert alert-info alert-dismissible fade show" role="alert">
							${insertMsg}
							<button type="button" class="close" data-dismiss="alert" aria-label="Close">
								<span aria-hidden="true">&times;</span>
							</button>
						</div>
					</c:if>

					<div class="card shadow mb-4">
						<div class="card-header py-3 d-flex align-items-center">
							<h6 class="m-0 font-weight-bold text-primary" style="line-height: 1.5;">상세 내용</h6>
							<div class="ml-auto">
								<button type="button" class="btn btn-primary btn-sm" id="btnUpdateTop">
									<i class="fas fa-edit mr-1"></i>수정
								</button>

							</div>

						</div>

						<div class="card-body">
							<form id="submitForm" action="/approval24/delegate/detail/${detail.seqNo}" method="post">
								<div class="table-responsive">
									<table class="table table-bordered table-sm kv-table">
										<colgroup>
											<col style="width: 18%;">
											<col style="width: 32%;">
											<col style="width: 18%;">
											<col style="width: 32%;">
										</colgroup>
										<tbody>


											<tr>
												<th scope="col" class="text-dark bg-light font-weight-bold">대결자</th>
												<td><select id="delegateId" name="delegateId" class="form-control" required>
														<option value="<c:out value='${detail.delegateId}'/>">${detail.delegateId} | ${detail.delegateUserName}</option>
														<c:forEach var="acc" items="${accountList}">
															<c:if test="${acc.accountId ne null and acc.userName ne null}">
																<option value="${acc.accountId}">${acc.userNo}|${acc.userName}</option>
															</c:if>
														</c:forEach>
												</select></td>
												<th>사유</th>
												<td><input type="text" name="proxyComment" id="proxyComment" class="form-control form-control-sm" placeholder="대결자 지정사유를 입력하세요" required value="<c:out value='${detail.proxyComment}'/>" /></td>

											</tr>

											<!--등록일-->
											<tr>
												<th scope="col" class="text-dark bg-light font-weight-bold">시작일</th>
												<td><input type="date" class="form-control" name="startDt" value="${detail.startDt}" /></td>
												<th>종료일</th>
												<td><input type="date" class="form-control" name="endDt" class="form-control" value="${detail.endDt}" /></td>
											</tr>
											<!-- 삭제여부 -->
											<tr>
											  <th class="text-dark bg-light font-weight-bold">삭제여부</th>
											  <td colspan="6">
											    <div class="d-flex align-items-center" style="gap:16px;">
											      <label class="d-inline-flex align-items-center mb-0" for="delYnN">
											        <input type="radio" id="delYnN" name="delYn" value="N"
											          <c:if test="${detail.delYn == 'N'}">checked="checked"</c:if> />
											        <span class="ml-1">사용</span>
											      </label>
											
											      <label class="d-inline-flex align-items-center mb-0" for="delYnY">
											        <input type="radio" id="delYnY" name="delYn" value="Y"
											          <c:if test="${detail.delYn == 'Y'}">checked="checked"</c:if> />
											        <span class="ml-1">삭제</span>
											      </label>
											    </div>
											  </td>
											</tr>


										</tbody>
									</table>
								</div>
							</form>
						</div>
					</div>
					<div class="d-flex justify-content-between mt-4">
						<a href="${pageContext.request.contextPath}/delegate" class="btn btn-light"> <i class="fas fa-arrow-left mr-1"></i> 목록</a>
					</div>

				</div>
			</div>

		</div>
	</div>

	<a class="scroll-to-top rounded" href="#page-top"><i class="fas fa-angle-up"></i></a>

	<%@ include file="/WEB-INF/views/common/logoutModal.jsp"%>
	<%@ include file="/WEB-INF/views/common/footer.jsp"%>

	<script>
	$(document).ready(function () {

		  // 폼 & URL 
		  const $updateForm = $('#submitForm');           // 폼 id 확인
		  const updateActionUrl = $updateForm.attr('action');

		  $('#btnUpdateTop').on('click', function (e) {
		    e.preventDefault();

		    const formEl = $updateForm.get(0);

		    // 1) 브라우저 기본 유효성 검사
		    if (formEl && !formEl.checkValidity()) {
		      formEl.reportValidity();
		      return;
		    }

		    // 2) 사용자 확인
		    if (!confirm('수정된 내용을 저장하시겠습니까?')) {
		      return;
		    }

		    // 3) 업데이트 URL로 고정
		    $updateForm.attr('action', updateActionUrl);

		    // 4) disabled 된 필드는 전송되지 않으므로 모두 활성화
		    $updateForm.find(':input:disabled').prop('disabled', false);

		    // 5) 제출
		    $updateForm.submit();
		  });
		});
	</script>

</body>
</html>
