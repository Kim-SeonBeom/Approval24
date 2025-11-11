document.addEventListener('DOMContentLoaded', function() {
    // ===== 기존 코드 그대로 유지 =====
    const $form = $('#submitForm'); 
    const $confirmBtn = $('#btnSubmitConfirm');
    const complainId = $form.find('input[name="complainId"]').val();

    const $btnApprove = $('#btnApprove');
    const $btnReject = $('#btnReject');

    // ===== 새로 추가: 결재 내역 불러오기 =====
    const $historyTbody = $('#historyTable tbody'); // 테이블 tbody
    let approvalList = [];

    async function loadApprovalLine() {
        if (!complainId) {
            $historyTbody.html('<tr><td colspan="5">민원 ID가 없어 결재 내역을 불러올 수 없습니다.</td></tr>');
            return;
        }

        $historyTbody.html('<tr><td colspan="5">로딩 중...</td></tr>');

        try {
            const res = await fetch(`/approval24/api/approval/line?complainId=${complainId}`, { credentials: 'same-origin' })
            approvalList = await res.json();

            if (!Array.isArray(approvalList) || approvalList.length === 0) {
                $historyTbody.html('<tr><td colspan="5">결재 이력이 없습니다.</td></tr>');
                updateApprovalButtons();
                return;
            }

            $historyTbody.empty();
            approvalList.forEach(item => {
                const tr = $('<tr>').html(`
                    <td>${item.categoryName || ''}</td>
                    <td>${item.userName || ''}</td>
                    <td>${item.approverTypeName || ''}</td>
                    <td>${item.approvalStatusName || ''}</td>
                    <td>${item.processDt ? new Date(item.processDt).toLocaleString() : ''}</td>
                `);
                $historyTbody.append(tr);
            });

            updateApprovalButtons();

        } catch (e) {
            console.error(e);
            $historyTbody.html('<tr><td colspan="5">서버 오류 발생</td></tr>');
        }
    }

    // ===== 승인/반려 버튼 활성화 여부 결정 =====
    function updateApprovalButtons() {
        const hasPending = approvalList.some(a => a.approvalStatusCd === 'E001');
        $btnApprove.prop('disabled', !hasPending || !authData.canApprove);
        $btnReject.prop('disabled', !hasPending || !authData.canApprove);
    }

    // ===== 승인/반려 처리 =====
    async function handleDecision(statusCd) {
        const current = approvalList.find(a => a.approvalStatusCd === 'E001');
        if (!current) {
            alert('현재 처리 가능한 결재가 없습니다.');
            return;
        }
        // 반려시 의견 필수
        if (statusCd === 'E003' && !$('#comment').val().trim()) {
            alert("반려 시에는 의견이 필수입니다.");
            $('#comment').focus();
            return;
        }

        const payload = {
            ...current,
            approvalStatusCd: statusCd,
            approvalComment: $('#comment').val() || ''
        };

        if (!confirm(statusCd === 'E002' ? '승인 하시겠습니까?' : '반려 하시겠습니까?')) return;

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
                loadApprovalLine(); // 최신 결재 내역 갱신
            } else {
                alert(json?.message || `오류: ${res.status}`);
            }
        } catch (e) {
            console.error(e);
            alert('서버 에러 발생');
        }
    }
    
    async function handleCancel() {
        const current = approvalList.find(a => a.approvalStatusCd === 'E001');
        if (!current) {
            alert('현재 취하 가능한 결재가 없습니다.');
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
                loadApprovalLine(); // 최신 결재 내역 갱신
            } else {
                alert(json?.message || `오류: ${res.status}`);
            }
        } catch (e) {
            console.error(e);
            alert('서버 에러 발생');
        }
    }
    
    // 결재라인 불러오기
    $('#btnApprovalLine').on('click', function() {
        $('#approvalLineEditorModal').modal('show'); 
    });

    // 버튼과 연결
    
    $('#btnComplainCancle').on('click', handleCancel);
    $btnApprove.on('click', () => handleDecision('E002'));
    $btnReject.on('click', () => handleDecision('E003'));

    // 페이지 로드 시 결재 내역 불러오기
    loadApprovalLine();
});

function openBizPostcode() {
	new daum.Postcode({
		oncomplete : function(data) {
			// R: 도로명, J: 지번
			const addr = data.userSelectedType === 'R' ? data.roadAddress
					: data.jibunAddress;

			// 우편번호
			document.getElementById('bizPost').value = data.zonecode;

			// 기본 주소
			document.getElementById('bizAddr').value = addr;

			// 상세 주소 입력창에 포커스
			document.getElementById('bizAddrDetail').focus();
		}
	}).open();
}

