<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<%-- 외부 JSP 파일 포함: header.jsp, footer.jsp, navbar.jsp, sidebar.jsp, logoutModal.jsp 등은 프로젝트 구조에 맞게 위치해야 합니다. --%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<title>공통코드 상세 | 결재24</title>
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
	min-height: 300px; /* 상세와 동일한 최소 높이 */
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

					<div class="d-sm-flex align-items-center justify-content-between mb-3">
						<h1 class="h3 mb-0 text-gray-800">공통코드 상세</h1>
					</div>
					
					<%-- 컨트롤러에서 전달받은 수정메시지 표시 --%>
					<c:if test="${not empty updMessage}">
					    <div class="alert alert-info alert-dismissible fade show" role="alert">
					        ${updMessage}
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
						
							<form id="totalCodeUpdateForm" action="/approval24/admin/totalcode/update" method="post">
                                
                                <input type="hidden" name="codeId" value="${codeInfo.codeId}" id="codeIdValue">
                                
                                
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
												<th scope="col" class="text-dark bg-light font-weight-bold">코드그룹ID</th>
												<td colspan="1"><input type="text" name="groupId" id="groupId" class="form-control form-control-sm" value="${codeInfo.groupId}" required maxlength="200"></td>
												<th scope="col" class="text-dark bg-light font-weight-bold">코드ID</th>
												<td colspan="1"><input type="text" name="codeId" id="codeId" class="form-control form-control-sm" value="${codeInfo.codeId}" required></td>
											</tr>

											<tr>
												<th>코드명</th>
												<td colspan="3"><input type="tel" class="form-control form-control-sm" value="${codeInfo.codeName}"
													name="codeName"></td>
											</tr>
											<tr>
												<th>코드내용</th>
												<td colspan="3"><input type="tel" class="form-control form-control-sm" value="${codeInfo.codeDetail}"
													name="codeDetail"></td>
											</tr>
											<tr>
											  <th class="text-dark bg-light font-weight-bold">삭제여부</th>
											  <td colspan="6">
											    <div class="d-flex align-items-center" style="gap:16px;">
											      <label class="d-inline-flex align-items-center mb-0" for="delYnN">
											        <input type="radio" id="delYnN" name="delYn" value="N"
											          <c:if test="${codeInfo.delYn == 'N'}">checked="checked"</c:if> />
											        <span class="ml-1">사용</span>
											      </label>
											
											      <label class="d-inline-flex align-items-center mb-0" for="delYnY">
											        <input type="radio" id="delYnY" name="delYn" value="Y"
											          <c:if test="${codeInfo.delYn == 'Y'}">checked="checked"</c:if> />
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
					<!-- 하단 버튼 -->
					<div class="d-flex justify-content-between mt-4">
						<a href="${pageContext.request.contextPath}/admin/totalcode" class="btn btn-light"> <i class="fas fa-arrow-left mr-1"></i> 취소</a>
					</div>
				</div>
				</div>
			<footer class="sticky-footer bg-white">
				<div class="container my-auto">
					<div class="copyright text-center my-auto">
						<span>Copyright &copy; Your Website 2020</span>
					</div>
				</div>
			</footer>
			</div>
		</div>
	<a class="scroll-to-top rounded" href="#page-top"><i class="fas fa-angle-up"></i></a>

	<%@ include file="/WEB-INF/views/common/logoutModal.jsp"%>

	<%@ include file="/WEB-INF/views/common/footer.jsp"%>
    
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<script>
$(function() {
	  // 폼 객체 및 URL 정의
	  const $updateForm = $('#totalCodeUpdateForm');
	  const updateActionUrl = $updateForm.attr('action');         // 초기 action

	  // 항상 잠가둘 필드(selector): groupId만 비활성화
	  const EXCLUDED = '#groupId, #codeId';

	  // 텍스트형 입력은 readonly로 제어
	  const $updatableInputs = $updateForm
	    .find('input[type="text"], input[type="tel"], textarea')
	    .not(':button, :hidden')
	    .not(EXCLUDED);

	  // 선택형 입력은 disabled로 제어
	  const $choiceInputs = $updateForm
	    .find('input[type="radio"], input[type="checkbox"], select')
	    .not(EXCLUDED);

	  // 1) 초기 잠금
	  $updatableInputs.prop('readonly', true);
	  $choiceInputs.prop('disabled', true);

	  // 항상 잠금: groupId
	  $updateForm.find(EXCLUDED).prop('readonly', true).prop('disabled', true);

	  // 2) 수정/저장 버튼
	  $('#btnUpdateTop').on('click', function () {
	    const $btn = $(this);
	    const isReadonly = $updatableInputs.first().prop('readonly');

	    if (isReadonly) {
	      // 편집 가능 상태로 전환 (EXCLUDED는 제외되어 계속 잠김)
	      $updatableInputs.prop('readonly', false);
	      $updatableInputs.prop('disabled', false);
	      $choiceInputs.prop('disabled', false);

	      $btn.html('<i class="fas fa-save mr-1"></i>저장')
	          .removeClass('btn-primary').addClass('btn-success');
	    } else {
	      if (confirm('수정된 내용을 저장하시겠습니까?')) {
	        $updateForm.attr('action', updateActionUrl).submit();
	      }
	    }
	  });
});
</script>

</body>
</html>