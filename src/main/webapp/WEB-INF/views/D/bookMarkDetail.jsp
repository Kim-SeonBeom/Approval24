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
/* (스타일 유지) */
.approver-box { border: 1px dashed #ccc; padding: 10px; margin-bottom: 10px; }
.approver-list-item { margin-top: 5px; border: 1px solid #eee; padding: 5px; }
.readonly-box { background: #f8f9fc; }
.list-equal { height: 350px; overflow-y: auto; border: 1px solid #e3e6f0; }
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

					<form id="bookmarkUpdateForm" action="" method="post">

						<div class="card shadow mb-4">
							<div class="card-header py-3 d-flex align-items-center justify-content-between">
								<h6 class="m-0 font-weight-bold text-primary">기본 정보</h6>
								<div>
									<button type="button" class="btn btn-primary btn-sm" id="btnUpdate" onclick="handleUpdate(false)">수정</button>
									
									<button type="button" class="btn btn-danger btn-sm" id="btnDelete" onclick="handleUpdate(true)">삭제</button>
									
									<a href="approval24/bookmark/list" class="btn btn-secondary btn-sm">목록</a>
								</div>
							</div>
							<div class="card-body">
								<div class="d-flex align-items-center mb-3">
									<h5 class="mb-0 mr-4" style="width: 120px;">북마크 이름</h5>
									<input type="text" class="form-control form-control-sm w-50" name="bookmarkName" id="bookmarkName" value="${bookmark.bookmarkName}" required>
								</div>
								<input type="hidden" id="bookmarkId" name="bookmarkId" value="${bookmark.bookmarkId}">
							</div>
						</div>

						<div class="row">
							<div class="col-md-6 mb-3">
                                <div class="card h-100">
                                    <div class="card-header py-2 d-flex align-items-center justify-content-between">
                                        <strong>전체 계정 목록</strong>
                                    </div>
                                    <div class="card-body p-2">
                                        <div id="accountList" class="list-equal">
                                            <div class="text-muted small text-center">계정 목록을 불러오는 중...</div>
                                        </div>
                                    </div>
                                </div>
                            </div>

							<div class="col-md-6 mb-3">
								<div class="card h-100">
									<div class="card-header py-2 d-flex align-items-center justify-content-between">
										<strong>선택된 결재 경로</strong>
									</div>
									<div class="card-body p-2 list-equal">
										<div id="selectedApprovers">
											<ul class="list-group" id="approverList">
												<c:forEach var="appr" items="${bookmark.approvers}" varStatus="st">
													<li id="appr_${st.index+1}" class="list-group-item d-flex justify-content-between align-items-center" data-account-id="${appr.approverId}">
                                                        <span class="text-dark fw-bold"> 
                                                            순서 <span class="order">${st.index+1}</span> : ${appr.approverName} 
                                                            <small class="text-muted">(${appr.deptName})</small> 
                                                            <c:if test="${not empty appr.approverTypeCdName}">
																<small class="text-muted">- ${appr.approverTypeCdName}</small>
															</c:if>
													    </span>
														<div class="d-flex align-items-center">
                                                            <input type="hidden" class="hid-approverId" name="approvers[${st.index}].approverId" value="${appr.approverId}"> 
                                                            <input type="hidden" class="hid-type" name="approvers[${st.index}].approverTypeCd" value="${appr.approverTypeCd}"> 
                                                            <input type="hidden" class="hid-del" name="approvers[${st.index}].delYn" value="N">
															<button type="button" class="btn btn-warning btn-sm ml-3 js-remove-approver">제거</button>
														</div>
                                                    </li>
												</c:forEach>
											</ul>
										</div>
									</div>
								</div>
							</div>
						</div>
					</form>

				</div>
			</div>
			<%@ include file="/WEB-INF/views/common/logoutModal.jsp"%>
			<%@ include file="/WEB-INF/views/common/footer.jsp"%>
		</div>
	</div>

	<a class="scroll-to-top rounded" href="#page-top"><i class="fas fa-angle-up"></i></a>

	<script>
    // ================= [NEW] AJAX 요청 핸들러 함수 정의 =================
    
    /**
     * 수정 및 삭제 요청을 AJAX로 서버에 전송합니다.
     * @param {boolean} isDelete 삭제 버튼 클릭 여부
     */
    function handleUpdate(isDelete) {
        // 1. 삭제 요청일 경우 확인 메시지
        if (isDelete) {
            if (!confirm('정말로 북마크를 삭제하시겠습니까?')) {
                return;
            }
        } else {
            // 2. 수정 요청일 경우 유효성 검사 (최소 3명 체크)
            const count = $('#approverList li').length;
            if (count < 3) {
                alert('결재선은 최소 3명 이상 지정해야 합니다.');
                return;
            }
        }
        
        // 3. 결재선 순번 및 타입 재정렬
        reindexApprovers();

        // 4. 전송할 데이터 수집 (DTO 구조에 맞춰 JSON 객체 생성)
        let formData = {
            bookmarkId: $('#bookmarkId').val(),
            bookmarkName: $('#bookmarkName').val(),
            delYn: isDelete ? 'Y' : 'N', // 삭제 여부 플래그
            approvers: []
        };

        // Approvers 리스트 구성
        $('#approverList li').each(function(i) {
            let approver = {
                approverId: $(this).find('.hid-approverId').val(),
                approverTypeCd: $(this).find('.hid-type').val(),
                delYn: $(this).find('.hid-del').val(),
                // SEQ_NO는 서버(Service)에서 부여하므로 여기서는 제외합니다.
            };
            formData.approvers.push(approver);
        });
        
        console.log('--- AJAX Update/Delete 전송 데이터 확인 ---', formData);

        // 5. AJAX 요청 전송
        $.ajax({
            url: '/approval24/bookmark/update',
            type: 'POST',
            contentType: 'application/json', // JSON 형식으로 데이터 전송
            data: JSON.stringify(formData),
            dataType: 'json',
            success: function(response) {
                if (response.result === 'SUCCESS') {
                    alert(isDelete ? '북마크가 성공적으로 삭제되었습니다.' : '북마크가 성공적으로 수정되었습니다.');
                    // 성공 후 목록 페이지로 이동
                    location.href = 'approval24/bookmark/list';
                } else if (response.result === 'FAIL') {
                    alert(response.message || '요청 처리에 실패했습니다.');
                } else {
                    alert('알 수 없는 오류가 발생했습니다. (로그 확인 요망)');
                }
            },
            error: function(xhr, status, error) {
                console.error("AJAX 요청 실패:", xhr.responseText);
                if (xhr.status === 400) {
                     alert('요청 데이터가 유효하지 않습니다. (400 Bad Request)');
                } else if (xhr.status === 500 && xhr.responseText.includes('ORA-00001')) {
                    alert('데이터 무결성 오류가 발생했습니다. (ORA-00001) - 서버 Service 코드를 확인해 주세요.');
                } else {
                    alert('서버 요청 중 오류가 발생했습니다: ' + status);
                }
            }
        });
    }

    // ================= 공통 유틸 및 부수 기능 =================
    
    function ensureApproverList() {
        if ($('#approverList').length === 0) {
            $('#selectedApprovers').html('<ul class="list-group" id="approverList"></ul>');
        }
    }

    function getSelectedIds() {
        const set = new Set();
        $('#approverList li').each(function () {
            const id = String($(this).data('account-id'));
            if (id && id !== 'undefined') set.add(id);
        });
        return set;
    }

    // 순번 + name 인덱스 + 타입(F002/F003/F004) 정리
    function reindexApprovers() { 
        console.log("Reindexing Approvers");
        const $lis = $('#approverList li');
        const total = $lis.length;

        $lis.each(function (i) {
            const index = i;
            const order = i + 1;

            $(this).attr('id', 'appr_' + order);
            $(this).find('.order').text(order);

            const namePrefix = 'approvers[' + index + ']';
            
            // Hidden fields for data binding
            $(this).find('input.hid-approverId').attr('name', namePrefix + '.approverId');
            $(this).find('input.hid-type').attr('name', namePrefix + '.approverTypeCd');
            $(this).find('input.hid-del').attr('name', namePrefix + '.delYn');

            // ---- 타입 코드 세팅 ----
            let typeCd;
            if (total >= 3) {
                if (i === 0) { typeCd = 'F002'; } 
                else if (i === total - 1) { typeCd = 'F004'; } 
                else { typeCd = 'F003'; }
            } else { typeCd = 'F004'; } 

            $(this).find('input.hid-type').val(typeCd);
        });
        console.log("Reindexing Finished");
    }

    // ================= 왼쪽: 전체 계정 목록 로드 (API 변경 적용) =================

    /**
     * 페이지 로드 시 전체 계정 목록을 로드하는 함수.
     */
    function loadAccounts() {
        console.log("API 호출: /approval24/api/common/accounts");
        
        $('#accountList').html('<div class="text-muted small text-center">계정 목록을 불러오는 중...</div>');

        $.ajax({
            url: '/approval24/api/common/accounts', 
            type: 'GET', 
            data: {}, // 데이터 없음 (deptId 전송 안 함)
            dataType: 'json',
            success: function (accounts) {
                let html = '<ul class="list-group">';
                const selectedIds = getSelectedIds();
                
                if (accounts && accounts.length) {
                    accounts.forEach(function (acc) {
                        var accountIdStr = String(acc.accountId || '');
                        if (!accountIdStr) return;

                        var disabled = selectedIds.has(accountIdStr);
                        var label    = disabled ? '추가됨' : '추가';
                        var disAttr  = disabled ? 'disabled' : '';

                        const positionName = acc.userPositionName || '직급없음';
                        const loginId = acc.loginId || 'ID없음';
                        const deptName = acc.deptName || 'N/A';
                        
                        const displayText = 
                            `\${acc.userName} (\${positionName} / \${loginId})`;

                        html += ''
                        + '<li class="list-group-item d-flex justify-content-between align-items-center">'
                        + '  <span class="text-dark">'
                        + displayText 
                        + '  </span>'
                        + '  <button type="button" class="btn btn-sm btn-outline-primary js-add-approver" '
                        + '          data-id="' + accountIdStr + '" '
                        + '          data-name="' + acc.userName + '" '
                        + '          data-dept="' + deptName + '" ' 
                        + disAttr + '>'
                        + label
                        + '  </button>'
                        + '</li>';
                    });
                } else {
                     html += '<li class="list-group-item text-muted">활성 계정이 없습니다.</li>';
                }
                html += '</ul>';
                $('#accountList').html(html);
            },
            error: function (xhr, status, error) {
                console.error("계정 목록 로드 실패:", status, error, xhr.responseText);
                alert('계정 목록을 불러오는 데 실패했습니다.');
            }
        });
    }

    // ================= 결재자 추가/제거 =================
    function addApprover(accountId, approverName, deptName) {
        ensureApproverList();

        const approverIdStr = String(accountId);
        if (getSelectedIds().has(approverIdStr)) return;

        if (!approverIdStr || parseInt(approverIdStr, 10) === 0 || approverIdStr === 'undefined') {
            console.error("추가하려는 계정 ID가 유효하지 않습니다:", accountId);
            return;
        }

        const currentIdx = $('#approverList li').length;
        const order = currentIdx + 1;

        // 추가된 결재자는 상세 페이지처럼 '이름 (부서이름)'으로 표시
        const liHtml = ''
            + '<li id="appr_' + order + '" class="list-group-item d-flex justify-content-between align-items-center" '
            + '    data-account-id="' + approverIdStr + '">'
            + '  <span class="text-dark fw-bold">'
            + '    순서 <span class="order">' + order + '</span> : ' + approverName
            + '    <small class="text-muted">(' + (deptName || '') + ')</small>' // 여기는 부서 이름 유지
            + '  </span>'
            + '  <div class="d-flex align-items-center">'
            + '    <input type="hidden" class="hid-approverId" name="approvers[' + currentIdx + '].approverId" value="' + approverIdStr + '">'
            + '    <input type="hidden" class="hid-type" name="approvers[' + currentIdx + '].approverTypeCd" value="">'
            + '    <input type="hidden" class="hid-del" name="approvers[' + currentIdx + '].delYn" value="N">'
            + '    <button type="button" class="btn btn-warning btn-sm ml-3 js-remove-approver">제거</button>'
            + '  </div>'
            + '</li>';

        $('#approverList').append(liHtml);

        reindexApprovers();
    }

    // 왼쪽 계정 리스트: 추가 버튼
    $('#accountList').on('click', '.js-add-approver', function () {
        var $btn      = $(this);
        var accountId = $btn.attr('data-id');
        var name      = $btn.attr('data-name');
        var deptName  = $btn.attr('data-dept'); // data 속성에 저장된 부서 이름 사용

        addApprover(accountId, name, deptName);

        $btn.prop('disabled', true).text('추가됨');
    });

    // 오른쪽: 제거 버튼
    $('#selectedApprovers').on('click', '.js-remove-approver', function () {
        var $li       = $(this).closest('li');
        var accountId = String($li.data('account-id'));

        $li.remove();

        $('#accountList .js-add-approver[data-id="' + accountId + '"]')
            .prop('disabled', false)
            .text('추가');

        reindexApprovers();

        if ($('#approverList li').length === 0) {
            $('#selectedApprovers').html('<ul class="list-group" id="approverList"></ul>');
        }
    });

    // ⭐ 페이지 로드 완료 시 loadAccounts() 함수 호출 ⭐
    $(document).ready(function() {
        // HTML에서 부서 선택 드롭다운이 제거되었으므로, 바로 전체 계정 목록을 로드합니다.
        loadAccounts();
    });

    // 서버에서 에러 메시지 내려준 경우 알림
    <c:if test="${not empty errorMsg}">
        alert('${errorMsg}');
    </c:if>
</script>

</body>
</html>