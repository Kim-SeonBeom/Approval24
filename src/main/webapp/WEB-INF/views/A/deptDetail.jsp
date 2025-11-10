<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<%-- 외부 JSP 파일 포함: header.jsp, footer.jsp, navbar.jsp, sidebar.jsp, logoutModal.jsp 등은 프로젝트 구조에 맞게 위치해야 합니다. --%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<title>부서 상세 | 결재24</title>
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
						<h1 class="h3 mb-0 text-gray-800">부서 상세</h1>
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
								<button type="button" class="btn btn-danger btn-sm ml-2" id="btnDeleteTop">
								    <i class="fas fas-trash-alt mr-1"></i>삭제
								</button>
								
							</div>

						</div>


						<div class="card-body">
						
							<form id="deptUpdateForm" action="/approval24/admin/dept/update" method="post">
                                
                                <input type="hidden" name="deptId" value="${deptInfo.deptId}" id="deptIdValue">
                                
                                
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
												<th scope="col" class="text-dark bg-light font-weight-bold">부서명</th>
												<td colspan="1"><input type="text" name="deptName" id="deptName" class="form-control form-control-sm" value="${deptInfo.deptName}" required maxlength="200"></td>
											<tr>
												<th>부서 연락처</th>
												<td colspan="3"><input type="tel" class="form-control form-control-sm" value="${deptInfo.deptPhone}"
													name="deptPhone"></td>
											</tr>
											<tr>
											  <th class="text-dark bg-light font-weight-bold">소속 기관명</th>
											  <td colspan="6">
											    <div style="display:flex; flex-wrap:wrap; gap:8px 16px; line-height:1.8;">
											      <c:forEach var="inst" items="${getAllInst}">
											        <c:set var="isChecked" value="false"/>
											        <c:forEach var="m" items="${instByDeptList}">
											          <c:if test="${m.instId == inst.instId}">
											            <c:set var="isChecked" value="true"/>
											          </c:if>
											        </c:forEach>
											
											        <label class="d-inline-flex align-items-center mb-1">
											          <input
											            type="checkbox"
											            name="instIds"
											            value="${inst.instId}"
											            class="mr-1"
											            <c:if test="${isChecked}">checked="checked"</c:if>
											          />
											          ${inst.instName}
											        </label>
											      </c:forEach>
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
						<a href="${pageContext.request.contextPath}/admin/dept" class="btn btn-light"> <i class="fas fa-arrow-left mr-1"></i> 취소</a>
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
$(document).ready(function () {
	  const $updateForm = $('#deptUpdateForm');
	  const updateActionUrl = $updateForm.attr('action');
	  const deleteActionUrl = '/approval24/admin/dept/delete';

	  // 입력군을 역할별로 분리
	  // - 텍스트계: readonly로 제어 (text/password/number/email/date 등 + textarea)
	  // - 선택계:  disabled로 제어 (select/checkbox/radio/file)
	  const $textInputs = $updateForm.find(
	    'input:not([type=button]):not([type=hidden]):not([type=checkbox]):not([type=radio]):not([type=file]), textarea'
	  );
	  const $choiceInputs = $updateForm.find('select, input[type=checkbox], input[type=radio], input[type=file]');
	  const $addressButton = $('#btnSearchAddress');

	  function setEditMode(isEdit) {
	    // readonly 토글
	    $textInputs.prop('readonly', !isEdit);

	    // disabled 토글
	    $choiceInputs.prop('disabled', !isEdit);

	    // 주소검색 버튼 등: disabled 토글
	    if ($addressButton.length) $addressButton.prop('disabled', !isEdit);

	    const $btn = $('#btnUpdateTop');
	    if (isEdit) {
	      $btn.html('<i class="fas fa-save mr-1"></i>저장')
	          .removeClass('btn-primary').addClass('btn-success');
	    } else {
	      $btn.html('<i class="fas fa-edit mr-1"></i>수정')
	          .removeClass('btn-success').addClass('btn-primary');
	    }
	  }

	  // 2) 초기 상태
	  setEditMode(false);

	  // 3) 수정/저장 토글
	  $('#btnUpdateTop').on('click', function () {
	    const isReadOnlyNow = $textInputs.first().prop('readonly'); // 현재 읽기전용이면 수정모드로
	    if (isReadOnlyNow) {
	      // 수정 모드 진입
	      setEditMode(true);
	    } else {
	      // 저장
	      if (confirm('수정된 내용을 저장하시겠습니까?')) {
	        $choiceInputs.prop('disabled', false);
	        if ($addressButton.length) $addressButton.prop('disabled', false);

	        $updateForm.attr('action', updateActionUrl);
	        $updateForm.submit();
	      }
	    }
	  });

	  // 4) 삭제
	  $('#btnDeleteTop').on('click', function () {
	    if (confirm('정말로 이 기관을 삭제하시겠습니까? 삭제된 데이터는 복구되지 않습니다.')) {
	      $textInputs.prop('readonly', true);
	      $choiceInputs.prop('disabled', true);
	      if ($addressButton.length) $addressButton.prop('disabled', true);

	      $updateForm.attr('action', deleteActionUrl);
	      $updateForm.submit();
	    }
	  });
	});


// 1. Daum Postcode API 함수 (openDaumPostcode)
function openDaumPostcode() {
    new daum.Postcode({
        oncomplete: function(data) {
            // R: 도로명, J: 지번
            const addr = data.userSelectedType === 'R' ? data.roadAddress : data.jibunAddress;
            
            // 우편번호 (ID: deptPost)
            document.getElementById('deptPost').value = data.zonecode; 
            
            // 기본 주소 (ID: deptAddress)
            document.getElementById('deptAddress').value = addr;
            
            // 상세 주소 입력창에 포커스 (ID: deptDetailAddress)
            document.getElementById('deptDetailAddress').focus();
        }
    }).open();
}


//2. 폼 제출 로직 (btnUpdateTop)
//- 버튼이 폼 외부에 있으므로, 클릭 시 명시적으로 폼 제출
$(document).ready(function() {

// 폼 외부에 있는 등록 버튼 클릭 시 폼 제출
$('#btnUpdateTop').on('click', function(e) {
  
  if (!form.checkValidity()) {
       // 유효성 검사 실패 시 브라우저가 기본 동작을 수행하고 제출 중단
       return; 
  }
  
  // 폼 제출
  $('#').submit();
});
});


</script>

</body>
</html>