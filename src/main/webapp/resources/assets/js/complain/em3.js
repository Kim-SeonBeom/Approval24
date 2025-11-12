document.addEventListener('DOMContentLoaded', function() {
	// form & buttons
	const $form = $('#submitForm');
	const $confirmBtn = $('#btnSubmitConfirm');
	const complainId = $form.find('input[name="complainId"]').val();

	// 버튼 캐시
    const $btnSave = $('#btnSave');
    const $btnApprove = $('#btnApprove');
    const $btnReject = $('#btnReject');
    const $btnApprovalLine = $('#btnApprovalLine');
    const $btnComplainCancel = $('#btnComplainCancel');
    const $historyTbody = $('#historyTable tbody');
    let approvalList = [];

	// 라디오
	const $participantType = $form.find('input[name="participantType"]');

	// 학적 정보
	const $studentNo = $form.find('#studentNo');
	const $grade = $form.find('#grade');
	const $major = $form.find('#major');
	const $studentStatus = $form.find('#studentStatus');
	const $graduateDate = $form.find('#graduateDate');

	function setDisabled($el, disabled) {
		$el.prop('disabled', disabled).toggleClass('readonly-box', disabled)
				.css('pointer-events', disabled ? 'none' : '');
	}
	function clearValues() {
		$studentNo.val('');
		$grade.val('');
		$major.val('');
		$studentStatus.val('');
		$graduateDate.val('');
	}
	function enableAll() {
		setDisabled($studentNo, false);
		setDisabled($grade, false);
		setDisabled($major, false);
		setDisabled($studentStatus, false);
		setDisabled($graduateDate, false);
	}
	function disableAll() {
		setDisabled($studentNo, true);
		setDisabled($grade, true);
		setDisabled($major, true);
		setDisabled($studentStatus, true);
		setDisabled($graduateDate, true);
	}

	function updateParticipantTypeState() {
		// 1) 항상 먼저 풀기
		enableAll();

		// 2) region일 때만 비우고 잠그기
		const selected = $participantType.filter(':checked').val();
		if (selected === 'region') {
			clearValues();
			disableAll();
		}
	}

	// 초기 1회 + 변경시
	$participantType.on('change', updateParticipantTypeState);
	updateParticipantTypeState();
	// 어떤 버튼으로 모달을 띄웠는지 구분용
	let pendingAction = null;

	// 결재선버튼 클릭
	$btnApprovalLine.on('click', function() {
		if (!canCancelOrSetLine) {
			alert('결재선을 설정할 권한이 없거나 본인이 신청한 민원이 아닙니다.');
			return;
		}

		// 결재선버튼 클릭시 팝업버튼 구현하면됩니다<<<<<시작

		alert("결재선 설정 팝업 로직 구현");

		// 결재선버튼 클릭시 팝업버튼 구현하면됩니다<<<<<끝
	});

	// 저장 버튼 클릭
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
		// 저장 할때 url 경로
		pendingAction = `/approval24/complain/category/em3/${complainId}`; // 기본
																			// 저장
																			// 경로
		$('#submitModalLabel').text('저장');
		$('.modal-body').text('입력하신 내용으로 신청서를 저장할까요?');
		$('#submitModal').modal('show');
	});


	// 모달 확인 버튼 -> 실제 제출
	$confirmBtn.on('click', function() {
		if (pendingAction)
			$form.attr('action', pendingAction);
		const $disabledInputs = $form.find(':input:disabled');
		$disabledInputs.prop('disabled', false);

		$form[0].submit();
	});
	
	async function loadApprovalLine() {
	    if (!complainId) {
	        $historyTbody.html('<tr><td colspan="5">민원 ID가 없어 결재 내역을 불러올 수 없습니다.</td></tr>');
	        return;
	    }

	    $historyTbody.html('<tr><td colspan="5">로딩 중...</td></tr>');

	    try {
	        const res = await fetch(`/approval24/api/approval/line?complainId=${complainId}`, { credentials: 'same-origin' });
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

	function updateApprovalButtons() {
	    const hasPending = approvalList.some(a => a.approvalStatusCd === 'E001');
	    $btnApprove.prop('disabled', !hasPending || !authData.canApprove);
	    $btnReject.prop('disabled', !hasPending || !authData.canApprove);
	}

	async function handleDecision(statusCd) {
	    const current = approvalList.find(a => a.approvalStatusCd === 'E001');
	    if (!current) {
	        alert('현재 처리 가능한 결재가 없습니다.');
	        return;
	    }
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
	            loadApprovalLine();
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
	            loadApprovalLine();
	        } else {
	            alert(json?.message || `오류: ${res.status}`);
	        }
	    } catch (e) {
	        console.error(e);
	        alert('서버 에러 발생');
	    }
	}

	$('#btnApprovalLine').on('click', function() {
	    $('#approvalLineEditorModal').modal('show'); 
	});

	$('#btnComplainCancel').on('click', handleCancel);
	$btnApprove.on('click', () => handleDecision('E002'));
	$btnReject.on('click', () => handleDecision('E003'));

	// 페이지 로드 시 실행
	loadApprovalLine();

});
