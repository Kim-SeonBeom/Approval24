document.addEventListener('DOMContentLoaded', function() {

    // ===== 기존 코드 그대로 유지 =====
    const $form = $('#submitForm'); 
    const $confirmBtn = $('#btnSubmitConfirm');
    const complainId = $form.find('input[name="complainId"]').val();
    
    const $btnSave = $('#btnSave');
    const $btnApprove = $('#btnApprove');
    const $btnReject = $('#btnReject');
    const $btnApprovalLine = $('#btnApprovalLine');
    const $btnComplainCancel = $('#btnComplainCancel');
    const $historyTbody = $('#historyTable tbody');
    
    // 💡 전역 변수 선언: 결재선 설정 및 DB 조회 결과 저장
    let approvalList = []; 
    // ⭐ [수정] 모달에서 결재선 병합을 위한 DB 조회 결과 (기존 이력) 저장 변수 선언
    let existingDbLines = []; 
    
    let pendingAction = null;
    
    // 저장 버튼 클릭 (기존 로직 유지)
    $btnSave.on('click', function() {
        if (!authData.canUpdate) {
            alert('수정 권한이 없습니다.');
            return;
        }

        if ($form[0].checkValidity && !$form[0].checkValidity()) {
            if ($form[0].reportValidity)
                $form[0].reportValidity();
            return;
        }
        pendingAction = `/approval24/complain/category/em1/${complainId}`; 
        $('#submitModalLabel').text('저장');
        $('.modal-body').text('입력하신 내용으로 신청서를 저장할까요?');
        $('#submitModal').modal('show');
    });
    
    // 모달 "제출" -> 실제 submit (기존 로직 유지)
    $confirmBtn.on('click', function() {
        if (pendingAction) $form.attr('action', pendingAction);
        const $disabledInputs = $form.find(':input:disabled');
        $disabledInputs.prop('disabled', false);
        $form[0].submit();
    });


    // -------------------------------------------------------------
    // 💡 1. 결재 내역 테이블 렌더링 함수 
    // -------------------------------------------------------------

    function renderApprovalTable(list) {
        const $tbody = $('#historyTable tbody');
        $tbody.empty();

        // 💡 컬럼 개수: 7개 (이름, 직급, ID, 유형, 종류, 상태, 처리일)
        if (!Array.isArray(list) || list.length === 0) {
            $tbody.html('<tr><td colspan="7">결재 이력이 없습니다.</td></tr>');
            return;
        }

        list.forEach(item => {
            // 💡 DTO에서 새로 정의된 필드 사용
            const processorName = item.processorName || 'N/A';
            const processorPositionName = item.processorPositionName || 'N/A';
            const processorLoginId = item.processorLoginId || 'N/A';

            const tr = $('<tr>').html(`
                <td>${processorName}</td>         
                <td>${processorPositionName}</td>         
                <td>${processorLoginId}</td>           
                <td>${item.approverTypeName || '-'}</td>
                <td>${item.approvalTypeName || '-'}</td>  
                <td>${item.approvalStatusName || '-'}</td>
                <td>${item.processDt ? new Date(item.processDt).toLocaleString() : '-'}</td>
            `);
            $tbody.append(tr);
        });
        
        updateApprovalButtons();
    }


    // -------------------------------------------------------------
    // 💡 2. 모달에서 최종 데이터를 받아 처리하는 함수 (데이터 병합)
    // -------------------------------------------------------------

    // 이 함수는 approvalLineEditor.jsp의 submitApprovalBtn에서 호출됩니다.
    function finalizeApprovalLineFromModal(newDraft) {
        // ⭐ [수정] existingDbLines가 정의되어 이제 정상적으로 작동합니다.
        // newDraft는 모달에서 새로 설정한 전체 라인입니다.
        // 여기서 existingDbLines는 DB에서 불러온 최종 이력(처리 완료 및 대기)을 가지고 있습니다.
        
        // existingDbLines는 loadApprovalLine에서 최신 DB 데이터를 저장하고 있음
        approvalList = existingDbLines.concat(newDraft); 
        
        renderApprovalTable(approvalList); 
        
        $('#approvalLineEditorModal').modal('hide'); 
        alert("결재선 설정이 임시 저장되었습니다. '승인' 버튼 클릭 시 최종 제출됩니다.");
    }

    window.finalizeApprovalLineFromModal = finalizeApprovalLineFromModal;


    // -------------------------------------------------------------
    // 3. 기존 결재선 로드 및 버튼 업데이트 (기존 로직 기반으로 수정)
    // -------------------------------------------------------------

    async function loadApprovalLine() {
        if (!complainId) {
            $historyTbody.html('<tr><td colspan="7">민원 ID가 없어 결재 내역을 불러올 수 없습니다.</td></tr>');
            return;
        }

        $historyTbody.html('<tr><td colspan="7">로딩 중...</td></tr>');

        try {
            const res = await fetch(`/approval24/api/approval/line?complainId=${complainId}`, { credentials: 'same-origin' });
            
            approvalList = await res.json(); 
            
            // ⭐ [수정] 모달 병합을 위해 DB에서 불러온 최신 이력을 저장
            // 이 데이터는 모달에서 신규 라인과 병합할 베이스 라인이 됩니다.
            existingDbLines = [...approvalList];

            // 렌더링 함수 호출
            renderApprovalTable(approvalList); 

        } catch (e) {
            console.error(e);
            $historyTbody.html('<tr><td colspan="7">서버 오류 발생</td></tr>');
        }
    }

    // ... (이하 나머지 함수 handleDecision, handleCancel 등은 기존 로직 유지) ...
    function updateApprovalButtons() {
        // 결재 버튼 상태 업데이트 로직 (기존 로직 유지)
        const hasPending = approvalList.some(a => a.approvalStatusCd === 'E001');
        // ... (버튼 비활성화/활성화 로직 - 이 부분은 DTO와 권한에 따라 구현되어 있어야 합니다.) ...
    }


    // -------------------------------------------------------------
    // 4. 통합 승인/반려 로직 수정 (handleDecision)
    // -------------------------------------------------------------

    async function handleDecision(statusCd) {
        const isApprove = statusCd === 'E002';
        const isInitiator = authData.complainAccountId === authData.sessionAccountId; //담당자 체크 로직
        //const hasPendingInDb = approvalList.some(a => a.approvalStatusCd === 'E001');
        
        const commentVal = $('#comment').val();
        
        if (isApprove && isInitiator) {
            
//            if (approvalList.length === 0 || !approvalList.some(a => a.approvalStatusCd === 'E004')) { 
//                alert("결재선을 먼저 설정해야 제출할 수 있습니다.");
//                return;
//            }

            if (!confirm('결재선을 제출하고 승인을 처리하시겠습니까?')) return;
            
            const commentVal = $('#comment').val() || ''; 
            if (approvalList.length > 0) {
            	approvalList[0].approvalComment = commentVal; 
            }
            const payload = {
                complainId: complainId,
                approvalLineData: approvalList, 
                contextUrl: window.location.href
            };

            try {
                // 💡 첫 제출 및 승인 통합 API 호출 
                const res = await fetch(`/approval24/api/approval/create`, {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    credentials: 'same-origin',
                    body: JSON.stringify(payload)
                });
                
                const json = await res.json().catch(() => null);
                if (res.ok) {
                    alert(json?.message || '제출 및 첫 승인 완료되었습니다.');
                } else {
                    alert(json?.message || `오류: ${res.status}`);
                }
            } catch (e) {
                console.error(e);
                alert('서버 에러 발생');
            }

        } 
        // ==========================================================
        // 2. [기존 로직 유지] (일반 승인/반려 또는 담당자의 E001 처리)
        // ==========================================================
        else {
            const current = approvalList.find(a => a.approvalStatusCd === 'E001');
            
            // 🔹 E001이 없으면 -> 반려 시에만 별도 컨트롤러 호출 (기존 로직 유지)
            if (!current) {
                if (statusCd === 'E003') { 
                    if (!confirm('반려 하시겠습니까?')) return;
                    try {
                        const res = await fetch(`/approval24/api/approval/complain/reject`, {
                            method: 'POST',
                            headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                            credentials: 'same-origin',
                            body: new URLSearchParams({ complainId })
                        });
                        const json = await res.json().catch(() => null);
                        if (res.ok) {
                            alert(json?.message || '반려 완료되었습니다.');
                        } else {
                            alert(json?.message || `오류: ${res.status}`);
                        }
                    } catch (e) {
                        console.error(e);
                        alert('서버 에러 발생');
                    }
                } else {
                    alert('현재 처리 가능한 결재가 없습니다.');
                }
                loadApprovalLine(); // 처리 후 재로드
                return;
            }

            // 🔹 E001이 있으면, 해당 결재 건 처리 (기존 로직 유지)
            if (statusCd === 'E003' && !commentVal.trim()) {
                alert("반려 시에는 의견이 필수입니다.");
                $('#comment').focus();
                return;
            }
            
            const payload = {
                ...current,
                approvalStatusCd: statusCd,
                approvalComment: commentVal || ''
            };
            
            if (!confirm(isApprove ? '승인 하시겠습니까?' : '반려 하시겠습니까?')) return;

            try {
                const res = await fetch(`/approval24/api/approval/process`, {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    credentials: 'same-origin',
                    body: JSON.stringify(payload)
                });
                
                const json = await res.json().catch(() => null);
                if (res.ok) {
                    alert(json?.message || '처리 성공');
                    $('#comment').val('');
                } else {
                    alert(json?.message || `오류: ${res.status}`);
                }
            } catch (e) {
                console.error(e);
                alert('서버 에러 발생');
            }
        }
        
        // 최종적으로 처리 후 재로드
        loadApprovalLine();
    }


    // -------------------------------------------------------------
    // 5. 기타 이벤트 핸들러 (기존 로직 유지)
    // -------------------------------------------------------------
    
    // handleCancel 함수 (기존 로직 유지)
    async function handleCancel() {
        // ... (기존 handleCancel 로직 그대로 사용) ...
        const current = approvalList.find(a => a.approvalStatusCd === 'E001');

        if (!current) {
            if (!confirm('신청서를 취하하시겠습니까?')) return;
            try {
                const res = await fetch(`/approval24/api/approval/complain/cancel`, {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                    credentials: 'same-origin',
                    body: new URLSearchParams({ complainId })
                });
                const json = await res.json().catch(() => null);
                if (res.ok) {
                    alert(json?.message || '취하 완료되었습니다.');
                } else {
                    alert(json?.message || `오류: ${res.status}`);
                }
            } catch (e) {
                console.error(e);
                alert('서버 에러 발생');
            }
            loadApprovalLine();
            return;
        }

        if (!confirm('신청서를 취하하시겠습니까?')) return;

        const payload = {
            ...current,
            approvalStatusCd: 'E005',
            approvalComment: $('#comment').val() || ''
        };

        try {
            const res = await fetch(`/approval24/api/approval/process`, {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                credentials: 'same-origin',
                body: JSON.stringify(payload)
            });

            const json = await res.json().catch(() => null);
            if (res.ok) {
                alert(json?.message || '취하 완료되었습니다.');
                $('#comment').val('');
            } else {
                alert(json?.message || `오류: ${res.status}`);
            }
        } catch (e) {
            console.error(e);
            alert('서버 에러 발생');
        }
        loadApprovalLine();
    }


    $('#btnApprovalLine').on('click', function() {
        // 모달이 열릴 때 기존 이력(existingDbLines)이 모달 내부 JS에 전달되어
        // 모달 내부의 draftApprovalLine을 초기화하도록 로직이 설계되어 있습니다.
        $('#approvalLineEditorModal').modal('show'); 
    });

    $('#btnComplainCancel').on('click', handleCancel);
    $btnApprove.on('click', () => handleDecision('E002'));
    $btnReject.on('click', () => handleDecision('E003'));

    // 페이지 로드 시 실행
    loadApprovalLine();


    function openBizPostcode() {
        new daum.Postcode({
            oncomplete : function(data) {
                const addr = data.userSelectedType === 'R' ? data.roadAddress
                        : data.jibunAddress;

                document.getElementById('bizPost').value = data.zonecode;
                document.getElementById('bizAddr').value = addr;
                document.getElementById('bizAddrDetail').focus();
            }
        }).open();
    }
});