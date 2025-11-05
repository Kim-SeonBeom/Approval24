<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%-- 
    이 파일은 다른 JSP에 <jsp:include page="approvalLineEditor.jsp" /> 형태로 포함되어 사용
--%>
<style>
    /* 결재 라인 편집기 영역 */
    #approval-editor-area {
        margin-top: 20px;
        padding: 15px;
        border: 1px solid #dee2e6;
        border-radius: 5px;
        display: none; /* 초기에는 숨김 */
    }
    .approver-item {
        margin-bottom: 5px;
    }
    .approver-table th, .approver-table td {
        vertical-align: middle;
    }
</style>

<!-- ================================================================= -->
<!-- 1. 초기 버튼 -->
<!-- ================================================================= -->
<div class="d-flex justify-content-end mb-3">
    <button class="btn btn-primary" id="btn-show-editor" onclick="showApprovalEditor(this)">
        <i class="bi bi-person-plus-fill"></i> 결재 라인 생성
    </button>
</div>

<!-- ================================================================= -->
<!-- 2. 결재 라인 편집기 영역 (초기 숨김) -->
<!-- ================================================================= -->
<div id="approval-editor-area" class="card">
    <div class="card-header bg-light d-flex justify-content-between align-items-center">
        <h5 class="mb-0">결재자 추가</h5>
        <button type="button" class="btn-close" aria-label="Close" onclick="hideApprovalEditor()"></button>
    </div>
    
    <div class="card-body">
        
        <!-- 결재자 선택 카드 형식 -->
        <div class="row g-3 align-items-center mb-3">
            <div class="col-sm-3">
                <label for="dept-select" class="form-label">부서</label>
                <select id="dept-select" class="form-select form-select-sm" onchange="loadAccounts()">
                    <option value="">-- 부서 선택 --</option>
                </select>
            </div>
            <div class="col-sm-4">
                <label for="account-select" class="form-label">계정</label>
                <select id="account-select" class="form-select form-select-sm">
                    <option value="">-- 계정 선택 --</option>
                </select>
            </div>
            <div class="col-sm-3">
                <label for="type-select" class="form-label">유형</label>
                <select id="type-select" class="form-select form-select-sm">
                    <option value="">-- 로딩 중 --</option> 
                </select>
            </div>
            <div class="col-sm-2 d-grid">
                <button type="button" class="btn btn-sm btn-outline-success mt-4" onclick="addApprover()">추가</button>
            </div>
        </div>
        
        <!-- 결재 라인 미리보기 테이블 -->
        <h6 class="mt-4">순서 지정</h6>
        <div class="table-responsive">
            <table class="table table-sm table-striped approval-table">
                <thead class="table-secondary">
                    <tr>
                        <th scope="col" style="width: 10%;">순번</th>
                        <th scope="col" style="width: 25%;">이름 (ID)</th>
                        <th scope="col" style="width: 20%;">유형</th>
                        <th scope="col" style="width: 20%;">순서</th>
                        <th scope="col" style="width: 15%;">삭제</th>
                    </tr>
                </thead>
                <tbody id="approver-list-body">
                    <tr id="no-approver-row"><td colspan="5" class="text-center text-muted">결재자를 추가해주세요.</td></tr>
                </tbody>
            </table>
        </div>
    </div>
    
    <div class="card-footer d-flex justify-content-end">
        <input type="hidden" id="complain-id" value="12345"> 
        <button class="btn btn-success me-2" onclick="createApprovalLine()">결재 라인 최종 생성</button>
        <button class="btn btn-secondary" onclick="hideApprovalEditor()">취소</button>
    </div>
</div>

<script>
    let approvalLineData = []; 
    // 🚨 accountNameMap -> userNameMap으로 이름 변경
    let userNameMap = {}; 
    let codeNameMap = {};

    $(document).ready(function() {
        loadDepartments(); 
        loadApprovalTypes();
    });

    // UI 제어 함수
    function showApprovalEditor(button) {
        $('#approval-editor-area').slideDown(200);
        $(button).hide();
    }
    function hideApprovalEditor() {
        $('#approval-editor-area').slideUp(200);
        $('#btn-show-editor').show();
    }

    // =================================================================
    // 1. 공통 데이터 조회 (Dept/Account/Code)
    // =================================================================
    
    // 부서 목록 로드 (기존과 동일)
    function loadDepartments() {
        $.ajax({
            url: "/api/common/depts",
            type: "GET",
            success: function(data) {
                const $deptSelect = $('#dept-select');
                $deptSelect.empty().append('<option value="">-- 부서 선택 --</option>');
                data.forEach(function(dept) {
                    $deptSelect.append(`<option value="${dept.deptId}">${dept.deptName}</option>`);
                });
            },
            error: function(xhr) {
                console.error("부서 목록 로드 실패:", xhr);
            }
        });
    }

    // 계정 목록 로드: loginId, userName 사용
    function loadAccounts() {
        const deptId = $('#dept-select').val();
        const $accountSelect = $('#account-select');
        $accountSelect.empty().append('<option value="">-- 계정 선택 --</option>');
        userNameMap = {}; // 맵 초기화

        if (!deptId) return;

        $.ajax({
            url: "/api/common/accounts?deptId=" + deptId,
            type: "GET",
            success: function(data) {
                data.forEach(function(account) {
                    const loginId = account.loginId; 
                    const userName = account.userName; 
                    const accountId = account.accountId;
                    
                    userNameMap[accountId] = userName; 
                    
                    $accountSelect.append(`<option value="${accountId}">${userName} (${loginId})</option>`);
                });
            },
            error: function(xhr) {
                console.error("계정 목록 로드 실패:", xhr);
            }
        });
    }

    // 코드 목록 로드 
    function loadApprovalTypes() {
        const groupId = "F0"; 
        const $typeSelect = $('#type-select');
        $typeSelect.empty();
        
        $.ajax({
            url: "/api/common/codes?groupId=" + groupId,
            type: "GET",
            success: function(data) {
                if (data && data.length > 0) {
                    $typeSelect.append('<option value="">-- 유형 선택 --</option>');
                    data.forEach(function(code) {
                        codeNameMap[code.code] = code.codeName; 
                        $typeSelect.append(`<option value="${code.code}">${code.codeName}</option>`);
                    });
                } else {
                    $typeSelect.append('<option value="">코드 없음</option>');
                }
            },
            error: function(xhr) {
                $typeSelect.empty().append('<option value="">로드 오류</option>');
                console.error("코드 목록 로드 실패:", xhr);
            }
        });
    }


    // =================================================================
    // 2. 결재 라인 관리
    // =================================================================
    function addApprover() {
        const accountId = $('#account-select').val(); 
        const approverTypeCd = $('#type-select').val();
        
        if (!accountId) {
            alert("계정을 선택해주세요.");
            return;
        }
        if (!approverTypeCd) {
            alert("결재 유형을 선택해주세요.");
            return;
        }
        
        if (approvalLineData.some(item => item.accountId === accountId)) {
            alert("이미 추가된 결재자입니다.");
            return;
        }

        const newApprover = {
            accountId: accountId, 
            approverTypeCd: approverTypeCd
        };

        approvalLineData.push(newApprover);
        renderApproverList();
    }

    function removeApprover(index) {
        approvalLineData.splice(index, 1);
        renderApproverList();
    }

    function moveApproverUp(index) {
        if (index > 0) {
            [approvalLineData[index - 1], approvalLineData[index]] = [approvalLineData[index], approvalLineData[index - 1]];
            renderApproverList();
        }
    }

    function moveApproverDown(index) {
        if (index < approvalLineData.length - 1) {
            [approvalLineData[index + 1], approvalLineData[index]] = [approvalLineData[index], approvalLineData[index + 1]];
            renderApproverList();
        }
    }

    // 테이블 UI 업데이트
    function renderApproverList() {
        const $tbody = $('#approver-list-body');
        $tbody.empty();

        if (approvalLineData.length === 0) {
            $tbody.append('<tr id="no-approver-row"><td colspan="5" class="text-center text-muted">결재자를 추가해주세요.</td></tr>');
            return;
        }
        
        approvalLineData.forEach((item, index) => {
            const accountId = item.accountId; 
            const userName = userNameMap[accountId] || '이름 없음';
            const approverTypeName = codeNameMap[item.approverTypeCd] || item.approverTypeCd;
            
            const btnUp = index > 0 
                ? `<button class="btn btn-sm btn-outline-secondary" onclick="moveApproverUp(${index})"><i class="bi bi-arrow-up"></i></button>`
                : '';
            const btnDown = index < approvalLineData.length - 1 
                ? `<button class="btn btn-sm btn-outline-secondary" onclick="moveApproverDown(${index})"><i class="bi bi-arrow-down"></i></button>`
                : '';

            const row = `
                <tr>
                    <td class="text-center">${index + 1}</td>
                    <td>${userName} (${accountId})</td> 
                    <td>${approverTypeName}</td>
                    <td class="text-center">
                        <div class="btn-group btn-group-sm" role="group">
                            ${btnUp}
                            ${btnDown}
                        </div>
                    </td>
                    <td class="text-center">
                        <button class="btn btn-sm btn-danger" onclick="removeApprover(${index})"><i class="bi bi-trash"></i> 삭제</button>
                    </td>
                </tr>
            `;
            $tbody.append(row);
        });
    }

    // =================================================================
    // 3. 최종 API 호출 (기존과 동일)
    // =================================================================
    function createApprovalLine() {
        if (approvalLineData.length === 0) {
            alert("결재 라인에 최소 한 명의 결재자를 추가해야 합니다.");
            return;
        }
        
        const complainId = $('#complain-id').val(); 
        
        if (!complainId || isNaN(complainId)) {
            alert("민원 ID가 유효하지 않아 요청을 보낼 수 없습니다. 페이지 설정을 확인하세요.");
            return;
        }
        
        const requestData = {
            complainId: parseInt(complainId),
            approvalLineData: approvalLineData,
            contextUrl: currentUrl
        };

        $.ajax({
            url: "/api/approval/create",
            type: "POST",
            contentType: "application/json",
            data: JSON.stringify(requestData),
            success: function(response) {
                if (response.success) {
                    alert("✅ 결재 라인이 성공적으로 등록되었습니다.");
                    hideApprovalEditor(); 
                    // window.location.reload(); 
                } else {
                    alert("❌ 결재 등록 실패: " + response.message);
                }
            },
            error: function(xhr) {
                const errorMsg = xhr.responseJSON ? xhr.responseJSON.message : "알 수 없는 오류가 발생했습니다.";
                alert("❌ 오류 발생 (" + xhr.status + "): " + errorMsg);
            }
        });
    }
</script>
