<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<div class="modal fade" id="approvalLineEditorModal" tabindex="-1" role="dialog" aria-labelledby="approvalLineEditorModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-xl" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="approvalLineEditorModalLabel">결재 라인 편집 및 설정</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            
            <div class="modal-body">
                <div id="approval-editor-area">
                    <div class="container-fluid mb-4">
                        <div class="card shadow mb-4">
                            <div class="card-header py-3 d-flex align-items-center justify-content-between">
                                <h3 class="m-0">결재 라인 편집기</h3>
                                <button type="button" class="btn btn-primary btn-sm" id="addLineBtn">결재자 추가</button>
                            </div>
                            <div class="card-body">
                                <table class="table table-bordered mb-3 text-center" width="100%">
                                    <colgroup>
                                        <col style="width: 25%">
                                        <col style="width: 75%">
                                    </colgroup>
                                    <tbody>
                                        <tr>
                                            <th>북마크 선택</th>
                                            <td>
                                                <select class="form-control w-100" id="bookmarkSelect">
                                                    <option value="">-- 즐겨찾기 선택 --</option>
                                                </select>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th>계정 선택</th>
                                            <td>
                                                <select class="form-control w-100" id="accountSelect">
                                                    <option value="">-- 계정 선택 --</option>
                                                </select>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                                
                                <table class="table table-bordered mb-0 text-center" width="100%" id="approvalLineTable">
                                    <colgroup>
                                        <col style="width: 30%">
                                        <col style="width: 30%">
                                        <col style="width: 30%">
                                        <col style="width: 10%"> 
                                    </colgroup>
                                    <thead>
                                        <tr>
                                            <th>직급</th>
                                            <th>이름</th>
                                            <th>계정 ID</th>
                                            <th>삭제</th>
                                        </tr>
                                    </thead>
                                    <tbody></tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
                <button type="button" class="btn btn-primary" id="submitApprovalBtn">설정 완료</button> 
            </div>
        </div>
    </div>
</div>

<script>
// 부모 JSP의 전역 변수 approvalList에 접근할 것을 가정합니다.
document.addEventListener("DOMContentLoaded", () => {
    
    // 💡 모달 내부 임시 저장 배열
    let allBookmarksData = [];
    let draftApprovalLine = [];

    const accSel = document.getElementById("accountSelect");
    const tableBody = document.querySelector("#approvalLineTable tbody");
    const bmSel = document.getElementById("bookmarkSelect");
    
    // 1. 계정 목록 로드
    fetch("/approval24/api/common/accounts") 
        .then(res => {
            if (!res.ok) throw new Error("계정 목록 조회 실패");
            return res.json();
        })
        .then(list => {
            list.forEach(a => {
                const opt = document.createElement("option");
                opt.value = a.accountId;
                // 표시: 이름 (직급 / 로그인 ID)
                opt.text = `\${a.userName} (\${a.userPositionName || '직급없음'} / \${a.loginId})`; 
                
                // 데이터 속성 (부모 JSP로 전달할 DTO 필드)
                opt.dataset.userName = a.userName;
                opt.dataset.userPositionName = a.userPositionName;
                opt.dataset.loginId = a.loginId;
                opt.dataset.userDeptName = a.deptName; 
                opt.dataset.deptId = a.deptId; 

                accSel.appendChild(opt);
            });
        })
        .catch(err => console.error("계정 목록 로딩 에러:", err));
    
    loadBookmarks();


    // 2. 결재자 추가 (addLineBtn) 로직
    document.getElementById("addLineBtn").addEventListener("click", () => {
        if (!accSel.value) {
            alert("계정을 선택하세요.");
            return;
        }

        const selectedOption = accSel.options[accSel.selectedIndex];
        
        const accountId = selectedOption.value;
        const userName = selectedOption.dataset.userName;
        const userPositionName = selectedOption.dataset.userPositionName;
        const loginId = selectedOption.dataset.loginId; 
        const deptId = selectedOption.dataset.deptId;
        const userDeptName = selectedOption.dataset.userDeptName;
        
        // 중복 체크
        if (draftApprovalLine.some(item => item.accountId === accountId)) {
            alert("이미 추가된 계정입니다.");
            return;
        }

        // 1. 임시 배열에 저장할 데이터 객체 생성 
        const newItem = {
            // DB 통신에 필수적인 값
            accountId: accountId,
            processorName: userName,
            processorPositionName: userPositionName, 
            processorLoginId: loginId,
        };
        
        draftApprovalLine.push(newItem);
        
        // 2. HTML 테이블에 반영
        const tr = document.createElement("tr");
        tr.innerHTML = `
            <td data-position="\${userPositionName}">\${userPositionName}</td> 
            <td data-name="\${userName}">\${userName}</td>
            <td data-account-id="\${accountId}">\${loginId}</td> 
            <td><button type="button" class="btn btn-danger btn-sm btn-del">삭제</button></td>
        `;
        tableBody.appendChild(tr);

        // 선택값 초기화 (선택적)
        accSel.value = "";
    });


    // 3. 삭제 버튼 로직 수정 (임시 배열 반영)
    tableBody.addEventListener("click", (e) => {
        if (e.target.classList.contains("btn-del")) {
            const row = e.target.closest("tr");
            
            // 💡 data-account-id 속성에서 계정 ID를 가져옵니다.
            const accountId = row.querySelector('[data-account-id]').getAttribute('data-account-id');
            const isDbItem = e.target.disabled; // 비활성화 상태는 DB에 저장된 항목임을 의미

            if (isDbItem && !confirm("이미 DB에 저장된 항목입니다. 정말 삭제하시겠습니까?")) {
                return;
            }

            // HTML에서 제거
            row.remove();

            // draftApprovalLine 배열에서 해당 항목 제거
            draftApprovalLine = draftApprovalLine.filter(item => item.accountId !== accountId);
        }
    });

    // 4. 설정 완료 버튼 (`submitApprovalBtn`) 로직 (부모 JSP로 데이터 전송)
    document.getElementById("submitApprovalBtn").addEventListener("click", () => {
        if (draftApprovalLine.length === 0) { 
            alert("결재 라인을 추가하세요.");
            return;
        }

        if (typeof finalizeApprovalLineFromModal === 'function') {
            // 임시 배열의 복사본을 부모 페이지 함수로 전달
            finalizeApprovalLineFromModal([...draftApprovalLine]); 
        } else {
            alert("부모 페이지의 결재선 최종 처리 함수(finalizeApprovalLineFromModal)를 찾을 수 없습니다.");
            $('#approvalLineEditorModal').modal('hide'); 
        }
    });
    
    //북마크 로드
    function loadBookmarks() {

        fetch(`/approval24/api/common/bookmark/list`)
            .then(res => {
                if (!res.ok) throw new Error("북마크 목록 조회 실패");
                return res.json();
            })
            .then(list => {
                allBookmarksData = list; // ⭐ 데이터 전체를 메모리에 저장
                
                // 드롭다운 채우기
                bmSel.innerHTML = '<option value="">-- 즐겨찾기 선택 --</option>'; 
                list.forEach(bm => {
                    const opt = document.createElement("option");
                    // option value에 bookmarkId를 저장합니다.
                    opt.value = bm.bookmarkId; 
                    opt.text = bm.bookmarkName;
                    bmSel.appendChild(opt);
                });
            })
            .catch(err => console.error("북마크 목록 로딩 에러:", err));
    }
    
    //선택된 북마크 ID에 해당하는 데이터를 메모리에서 찾아 테이블에 반영
    function loadApproversFromMemory(bookmarkId) {
        if (!bookmarkId) return;

        // 1. 메모리에서 해당 북마크 데이터 찾기
        const selectedBookmark = allBookmarksData.find(bm => String(bm.bookmarkId) === String(bookmarkId));
        
        if (!selectedBookmark || !selectedBookmark.approvers) {
            alert("선택된 북마크의 상세 정보가 없습니다.");
            return;
        }

        // 2. 기존 결재 라인 초기화 및 데이터 갱신
        draftApprovalLine = [];
        tableBody.innerHTML = '';
        
        selectedBookmark.approvers.forEach(item => {
            // ⭐ Approver DTO 필드명 사용: approverId, approverName, userPositionName, loginId
            const newItem = {
                accountId: String(item.approverId),
                processorName: item.approverName || '이름없음',
                processorPositionName: item.userPositionName || '직급없음', 
                processorLoginId: item.loginId || 'ID없음',
            };
            draftApprovalLine.push(newItem);
            
            // 3. HTML 테이블에 반영
            const tr = document.createElement("tr");
            const position = newItem.processorPositionName;
            const name = newItem.processorName;
            const loginId = newItem.processorLoginId;
            const accountId = newItem.accountId;

            tr.innerHTML = `
                <td data-position="${position}">\${position}</td> 
                <td data-name="${name}">\${name}</td>
                <td data-account-id="${accountId}">\${loginId}</td> 
                <td>
                    <button type="button" class="btn btn-danger btn-sm btn-del">삭제</button>
                </td>
            `;
            tableBody.appendChild(tr);
        });

        alert(`"${selectedBookmark.bookmarkName}" 북마크가 적용되었습니다.`);
    }

    // ⭐ [수정된 이벤트] 북마크 드롭다운 변경 시 메모리 함수 실행
    bmSel.addEventListener("change", (e) => {
        const selectedBookmarkId = e.target.value;
        if (selectedBookmarkId) {
            loadApproversFromMemory(selectedBookmarkId);
        }
    });

    // 5. 모달이 열릴 때 기존 DB 데이터를 draftApprovalLine으로 로드
    $('#approvalLineEditorModal').on('show.bs.modal', function (e) {
    	//loadBookmarks();
        const $tableBody = $('#approvalLineTable tbody');
        $tableBody.empty();
        
        // 부모 페이지의 전역 변수 approvalList에 접근하여 데이터를 복사합니다.
        if (typeof approvalList !== 'undefined') {
            draftApprovalLine = [...approvalList]; 
        } else {
            draftApprovalLine = [];
        }

        // 모달 내부 HTML 테이블을 draftApprovalLine의 내용으로 다시 그립니다.
        draftApprovalLine.forEach(item => {
            // DB에서 로딩된 항목은 null 처리된 필드를 가질 수 있습니다.
            const displayPosition = item.userPositionName || item.positionName || 'N/A'; // DTO 필드명 유연하게 처리
            const displayLoginId = item.loginId || 'N/A'; 
            
            const isDbItem = item.seqNo !== null && item.approvalStatusCd !== 'E004'; // DB에 저장되어 대기 상태가 아닌 항목
            
            
            const tr = document.createElement("tr");
            tr.innerHTML = `
                <td data-position="${displayPosition}">${displayPosition}</td>
                <td data-name="${item.processorName || 'N/A'}">${item.processorName || 'N/A'}</td>
                <td data-account-id="${item.accountId}">${displayLoginId}</td>
                <td>
                    <button type="button" class="btn btn-danger btn-sm btn-del" ${isDbItem ? 'disabled' : ''}>삭제</button>
                </td>
            `;
            $tableBody.append(tr);
        });
    });
    
    $('#approvalLineEditorModal').on('hidden.bs.modal', function (e) {
        
        // 북마크 드롭다운 초기화
        bmSel.value = "";
        
        // 계정 선택 드롭다운 초기화 (선택 사항이지만 일관성을 위해 권장)
        accSel.value = ""; 
        
    });
    
});
</script>