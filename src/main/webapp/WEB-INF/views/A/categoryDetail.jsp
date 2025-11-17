<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<%-- 외부 JSP 파일 포함: header.jsp, footer.jsp, navbar.jsp, sidebar.jsp, logoutModal.jsp 등은 프로젝트 구조에 맞게 위치해야 합니다. --%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<title>민원서식 상세 | 결재24</title>
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
						<h1 class="h3 mb-0 text-gray-800">민원서식 상세</h1>
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
						
							<form id="categoryUpdateForm" action="/approval24/category/update" method="post">
                                
                                <input type="hidden" name="complainCategoryId" value="${categoryInfo.complainCategoryId}" id="complainCategoryIdValue">
                                
                                
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
												<th scope="col" class="text-dark bg-light font-weight-bold text-center">민원서식명</th>
												<td colspan="3">
												      <input type="text" 
												             name="codeName" 
												             id="codeName" 
												             class="form-control form-control-sm" 
												             value="${categoryInfo.codeName}"
												             readonly>
												</td>
											</tr>
											<tr>
												<th scope="col" class="text-dark bg-light font-weight-bold text-center">유형코드</th>
												<td colspan="1">
												      <input type="text" 
												             name="codeId" 
												             id="codeId" 
												             class="form-control form-control-sm"
												             value="${categoryInfo.codeId}" 
												             readonly>
												</td>
												
												<th scope="col" class="text-dark bg-light font-weight-bold text-center">생성일</th>
												<td colspan="1"><input type="text" name=createDt id="createDt" class="form-control form-control-sm" readonly value="${categoryInfo.createDt}" required></td>
											</tr>
											
											<tr>
												<th scope="col" class="text-dark bg-light font-weight-bold text-center">처리소요일</th>
												<td colspan="1"><input type="text" name="dueDt" id="dueDt" class="form-control form-control-sm" value="${categoryInfo.dueDt}" required maxlength="200"></td>
												<th scope="col" class="text-dark bg-light font-weight-bold text-center">수정일</th>
												<td colspan="1"><input type="text" name="updateDt" id="updateDt" class="form-control form-control-sm" readonly value="${categoryInfo.updateDt}" required></td>
											</tr>

											
											<tr>
												<th scope="col" class="text-dark bg-light font-weight-bold text-center">생성자 계정관리번호</th>
												<td colspan="1"><input type="text" name="createId" id="createId" class="form-control form-control-sm" readonly value="${categoryInfo.createId}" required maxlength="200"></td>
												<th scope="col" class="text-dark bg-light font-weight-bold text-center">수정자 계정관리번호</th>
												<td colspan="1"><input type="text" name="updateId" id="updateId" class="form-control form-control-sm" readonly value="${categoryInfo.updateId}" required></td>
											</tr>
											<tr>	
												<th class="text-dark bg-light font-weight-bold text-center">서식URL</th>
												<td colspan="3"><input type="tel" class="form-control form-control-sm" value="${categoryInfo.categoryUrl}"
													name="categoryUrl"></td>
											</tr>
											<tr>
											  <th class="text-dark bg-light font-weight-bold text-center">소속 부서</th>
											  <td colspan="6">
											    <div style="display:flex; flex-wrap:wrap; gap:8px 16px; line-height:1.8;">
											      <c:forEach var="dept" items="${getAllDept}">
											        <c:set var="isChecked" value="false"/>
											        <c:forEach var="m" items="${deptByCategoryList}">
											          <c:if test="${m.deptId == dept.deptId}">
											            <c:set var="isChecked" value="true"/>
											          </c:if>
											        </c:forEach>
											
											        <label class="d-inline-flex align-items-center mb-1">
											          <input
											            type="checkbox"
											            name="deptIds"
											            value="${dept.deptId}"
											            class="mr-1"
											            <c:if test="${isChecked}">checked="checked"</c:if>
											          />
											          ${dept.deptName}
											        </label>
											      </c:forEach>
											    </div>
											  </td>
											</tr>
											<tr>
											  <th class="text-dark bg-light font-weight-bold text-center">삭제여부</th>
											  <td colspan="6">
											    <div class="d-flex align-items-center" style="gap:16px;">
											      <label class="d-inline-flex align-items-center mb-0" for="delYnN">
											        <input type="radio" id="delYnN" name="delYn" value="N"
											          <c:if test="${categoryInfo.delYn == 'N'}">checked="checked"</c:if> />
											        <span class="ml-1">사용</span>
											      </label>
											
											      <label class="d-inline-flex align-items-center mb-0" for="delYnY">
											        <input type="radio" id="delYnY" name="delYn" value="Y"
											          <c:if test="${categoryInfo.delYn == 'Y'}">checked="checked"</c:if> />
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
						<a href="${pageContext.request.contextPath}/category" class="btn btn-light"> <i class="fas fa-arrow-left mr-1"></i> 취소</a>
					</div>
				</div>
				</div>
			</div>
		</div>
	<a class="scroll-to-top rounded" href="#page-top"><i class="fas fa-angle-up"></i></a>

	<%@ include file="/WEB-INF/views/common/logoutModal.jsp"%>

	<%@ include file="/WEB-INF/views/common/footer.jsp"%>
    
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<script>
$(document).ready(function () {

	  // 폼 & URL 
	  const $updateForm = $('#categoryUpdateForm');           // 폼 id 확인
	  const updateActionUrl = $updateForm.attr('action'); // "/approval24/category/update"

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