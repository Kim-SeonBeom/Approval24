<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<meta charset="UTF-8">
<title>${bookmark.bookmarkName}상세|결재24</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<style>
.readonly-box {
	background: #f8f9fc;
}

.list-equal {
	max-height: 360px;
	overflow: auto;
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
					<h1 class="h3 mb-3 text-gray-800">북마크 상세/수정</h1>

					<form id="bookmarkUpdateForm" action="/approval24/bookmark/approver/replace" method="post">

						<!-- 북마크 기본 정보 -->
						<div class="card shadow mb-4">
							<div class="card-header py-3 d-flex align-items-center justify-content-between">
								<h6 class="m-0 font-weight-bold text-primary">기본 정보</h6>
								<div>
									<button type="submit" class="btn btn-primary btn-sm">수정</button>
									<button type="submit" name="delYn" value="Y">삭제</button>
									<a href="/approval24/bookmark/list" class="btn btn-secondary btn-sm">목록</a>
								</div>
							</div>
							<div class="card-body">
								<div class="d-flex align-items-center mb-3">
									<h5 class="mb-0 mr-4" style="width: 120px;">북마크 이름</h5>
									<input type="text" class="form-control form-control-sm w-50" name="bookmarkName" value="${bookmark.bookmarkName}" required>
								</div>
								<input type="hidden" id="bookmarkId" name="bookmarkId" value="${bookmark.bookmarkId}"> 
							</div>
						</div>

						<!-- 좌우 2열: 계정 목록 / 선택된 결재 경로 -->
						<div class="row">
							<!-- 왼쪽: 부서 선택 + 계정 목록 -->
							<div class="col-md-6 mb-3">
								<div class="card h-100">
									<div class="card-header py-2 d-flex align-items-center justify-content-between">
										<strong>부서 선택</strong>
										<select id="deptSelect" class="form-select text-dark w-auto" style="min-width: 260px; text-align: center; text-align-last: center;">
											<option value="">-- 부서를 선택하세요 --</option>
											<c:forEach var="dept" items="${depts}">
												<option value="${dept.deptId}">${dept.deptName}</option>
											</c:forEach>
										</select>

									</div>

									<div class="card-body p-2">

										<div id="accountList" class="list-equal d-flex justify-content-center align-items-center text-center">
											<div class="text-muted small">부서를 선택하면 계정 목록이 표시됩니다.</div>
										</div>
									</div>

								</div>
							</div>

							<!-- 오른쪽: 선택된 결재 경로 -->
							<div class="col-md-6 mb-3">
								<div class="card h-100">
									<div class="card-header py-2 d-flex align-items-center justify-content-between">
										<strong>선택된 결재 경로</strong>
									</div>
									<div class="card-body p-2 list-equal">
										<div id="selectedApprovers">
											<ul class="list-group" id="approverList">
												<!-- 기존 결재자 선반영 -->
												<c:forEach var="appr" items="${bookmark.approvers}" varStatus="st">
													<li id="appr_${st.index+1}" class="list-group-item d-flex justify-content-between align-items-center" data-account-id="${appr.approverId}"><span class="text-dark fw-bold"> 순서 <span class="order">${st.index+1}</span> : ${appr.approverName} <small class="text-muted">(${appr.deptName})</small> <c:if test="${not empty appr.approverTypeCdName}">
																<small class="text-muted">- ${appr.approverTypeCdName}</small>
															</c:if>
													</span>
														<div class="d-flex align-items-center">
															<input type="hidden" class="seq" name="approvers[${st.index}].seqNo" value="${st.index+1}"> <input type="hidden" class="hid-approverId" name="approvers[${st.index}].approverId" value="${appr.approverId}"> <input type="hidden" class="hid-type" name="approvers[${st.index}].approverTypeCd" value="${appr.approverTypeCd}"> <input type="hidden" class="hid-del" name="approvers[${st.index}].delYn" value="N">
															<button type="button" class="btn btn-warning btn-sm ml-3 js-remove-approver">제거</button>
														</div></li>
												</c:forEach>
											</ul>
										</div>
									</div>
								</div>
							</div>
						</div>
					</form>

				</div>
				<!-- /.container-fluid -->
			</div>
			<!-- /#content -->

			<%@ include file="/WEB-INF/views/common/logoutModal.jsp"%>
			<%@ include file="/WEB-INF/views/common/footer.jsp"%>
		</div>
		<!-- /#content-wrapper -->
	</div>
	<!-- /#wrapper -->

	<a class="scroll-to-top rounded" href="#page-top"><i class="fas fa-angle-up"></i></a>

<script>
	// ================= 공통 유틸 =================
	function ensureApproverList() {
	    if ($('#approverList').length === 0) {
	        $('#selectedApprovers').html('<ul class="list-group" id="approverList"></ul>');
	    }
	}

	function getSelectedIds() {
	    const set = new Set();
	    $('#approverList li').each(function () {
	        const id = String($(this).data('account-id'));
	        if (id && id !== 'undefined') set.add(id); // 안전한 체크
	    });
	    return set;
	}

	function reindexApprovers() {
	    console.log("Reindexing Started");
	    
	    $('#approverList li').each(function (i) { 
	        const index = i; // 0-based index
	        const order = i + 1; // 1-based order

	        // DOM 순서 및 텍스트 업데이트
	        $(this).attr('id', 'appr_' + order);
	        $(this).find('.order').text(order);
	        
	        const namePrefix = 'approvers[' + index + ']'; 
	        
	        // Hidden name 인덱스를 정확히 재설정
	        $(this).find('input.seq').val(order).attr('name', namePrefix + '.seqNo');
	        $(this).find('input.hid-approverId').attr('name', namePrefix + '.approverId');
	        $(this).find('input.hid-type').attr('name', namePrefix + '.approverTypeCd');
	        $(this).find('input.hid-del').attr('name', namePrefix + '.delYn');
	    });
	    console.log("Reindexing Finished");
	}

	// ================= 왼쪽: 부서 선택 → 계정 목록 로드 =================
	$('#deptSelect').on('change', function () {
	    // 🚨 ReferenceError 해결: 여기서 deptId 변수 정의
	    const deptId = $(this).val(); 
	    
	    if (!deptId) {
	        $('#accountList').html('<div class="text-muted small">부서를 선택하면 계정 목록이 표시됩니다.</div>');
	        return;
	    }
	    
	    // 로딩 인디케이터 표시
	    $('#accountList').html('<div class="spinner-border text-primary" role="status"><span class="visually-hidden">Loading...</span></div>');

	    $.ajax({
	        url: '/approval24/bookmark/accounts',
	        type: 'POST',
	        data: { deptId: deptId }, 
	        dataType: 'json',
	        
	        success: function (accounts) {
	            let html = '<ul class="list-group">';
	            const selectedIds = getSelectedIds();
	            
	            if (accounts && accounts.length) {
	                
	                // ⭐ jQuery $.each 대신 JS 표준 forEach를 사용하여 변수 참조 문제 해결
	            	accounts.forEach(function (acc, i) { 
	            	    
	            	    let currentAccountId = acc.accountId; 
	            	    const accountIdStr = (currentAccountId && currentAccountId > 0) 
	            	                         ? String(currentAccountId) 
	            	                         : ''; 

	            	    console.log(`[JS FOR EACH] Index ${i}: accountIdStr=${accountIdStr}`); 
	            	    
	            	    if (!accountIdStr) return; 

	            	    const disabled = selectedIds.has(accountIdStr); 
	            	    const label = disabled ? '추가됨' : '추가';
	            	    const disAttr = disabled ? 'disabled' : '';
	            	    
	            	    // ⭐⭐⭐ 데이터 바인딩 복원 ⭐⭐⭐
	            	    html += `	                        
	            	        <li class="list-group-item d-flex justify-content-between align-items-center">	                            
	            	            <span class="text-dark">	
	            	                ${acc.userName} <small class="text-muted">(${acc.deptName})</small>	                            
	            	            </span>	                            
	            	            <button type="button"	                                    
	            	                    class="btn btn-sm btn-outline-primary js-add-approver"	                                    
	            	                    data-id="${accountIdStr}"   	                                    
	            	                    data-name="${acc.userName}"
	            	                    data-dept="${acc.deptName}"
	            	                    ${disAttr}>${label}</button>
	            	        </li>`;
	            	});
	            } else {
	                html += '<li class="list-group-item text-muted">해당 부서에 활성 계정이 없습니다.</li>';
	            }
	            
	            html += '</ul>';
	            $('#accountList').html(html);
	        }, 
	        
	        error: function (xhr, status, error) {
	            console.error("계정 목록 로드 실패:", status, error, xhr.responseText);
	            alert('계정 목록을 불러오는 데 실패했습니다.');
	        }
	    }); 
	});

	// ================= 결재자 추가/제거 =================
	function addApprover(accountId, approverName, deptName) {
	    ensureApproverList();
	    const approverIdStr = String(accountId);
	    if (getSelectedIds().has(approverIdStr)) return;

		// 유효성 재확인
		if (!approverIdStr || parseInt(approverIdStr) === 0 || approverIdStr === 'undefined') {
    	    console.error("추가하려는 계정 ID가 유효하지 않습니다:", accountId);
        	return; 
    	}
	
	    const currentIdx = $('#approverList li').length; 
	    const order = currentIdx + 1;
	
	    const liHtml = `
	       <li id="appr_${order}" class="list-group-item d-flex justify-content-between align-items-center"
	           data-account-id="${approverIdStr}">
	         <span class="text-dark fw-bold">
	           순서 <span class="order">${order}</span> : ${approverName}
	           <small class="text-muted">(${deptName || ''})</small>
	         </span>
	         <div class="d-flex align-items-center">
	                     <input type="hidden" class="seq" name="approvers[${currentIdx}].seqNo" value="${order}">
	           <input type="hidden" class="hid-approverId" name="approvers[${currentIdx}].approverId" value="${approverIdStr}">
	           <input type="hidden" class="hid-type" name="approvers[${currentIdx}].approverTypeCd" value="AP01">
	           <input type="hidden" class="hid-del"  name="approvers[${currentIdx}].delYn" value="N">
	           <button type="button" class="btn btn-warning btn-sm ml-3 js-remove-approver">제거</button>
	         </div>
	       </li>`;
	    $('#approverList').append(liHtml);
	}

	// 왼쪽 계정 리스트: 추가 (data-id 읽기 문제 최종 해결)
	$('#accountList').on('click', '.js-add-approver', function () {
	    const $btn = $(this);
	    
	    // ⭐ 최종 수정: .attr('data-id')를 사용하여 HTML 속성 값을 명시적으로 읽음
	    const accountId = $btn.attr('data-id'); 
	    
	    console.log("Adding Approver, read accountId (ATTR):", accountId);
	    
	    // 유효성 검사
	    if (!accountId || accountId.length === 0 || accountId === 'undefined') {
	        console.error("Critical: accountId attribute missing or empty!");
	        return; 
	    }
	    
	    addApprover(String(accountId), $btn.data('name'), $btn.data('dept'));
	    
	    $btn.prop('disabled', true).text('추가됨');
	});

	// 오른쪽: 제거
	$('#selectedApprovers').on('click', '.js-remove-approver', function () {
	    const $li = $(this).closest('li');
	    const accountId = String($li.data('account-id'));
	    $li.remove();

	    // 동일 계정의 왼쪽 "추가" 버튼 다시 활성화
	    $('#accountList .js-add-approver[data-id="' + accountId + '"]')
	      .prop('disabled', false)
	      .text('추가');

	    reindexApprovers(); 

	    if ($('#approverList li').length === 0) {
	      $('#selectedApprovers').html('<ul class="list-group" id="approverList"></ul>');
	    }
	});

	// 폼 제출 시 마지막 인덱스 정리
	$('#bookmarkUpdateForm').on('submit', function () {
		reindexApprovers();
	    
	    const formData = new FormData(this);
	    console.log("--- 폼 제출 데이터 확인 시작 ---");
	    for (let [key, value] of formData.entries()) {
	        console.log(key + ': ' + value);
	    }
	    console.log("--- 폼 제출 데이터 확인 종료 ---");
	    // return true; // 실제 제출을 위해 주석 처리
	});
</script>

</body>
</html>
