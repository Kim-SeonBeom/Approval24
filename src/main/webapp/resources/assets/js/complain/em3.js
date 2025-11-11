document.addEventListener('DOMContentLoaded', function() {
	// form & buttons
	const $form = $('#submitForm');
	const $confirmBtn = $('#btnSubmitConfirm');
	const complainId = $form.find('input[name="complainId"]').val();

	
	// 버튼 캐시
	const $btnApprovalLine = $('#btnApprovalLine');
	const $btnSave = $('#btnSave');
	const $btnApprove = $('#btnApprove');
	const $btnReject = $('#btnReject');
	const $btnCancel = $('#btnComplainCancel');


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
		pendingAction = `/approval24/complain/category/em3/${complainId}`; // 기본 저장 경로
		$('#submitModalLabel').text('저장');
		$('.modal-body').text('입력하신 내용으로 신청서를 저장할까요?');
		$('#submitModal').modal('show');
	});

	// 승인 버튼 클릭
	$btnApprove.on('click', function() {
		if (!authData.canApprove) {
			alert('승인 권한이 없습니다.');
			return;
		}

		// 승인 할때 url 경로
		pendingAction = `/approval24/em3/${complainId}/approve`;
		$('#submitModalLabel').text('승인');
		$('.modal-body').text('이 신청서를 승인하시겠습니까?');
		$('#submitModal').modal('show');
	});

	// 반려 버튼 클릭
	$btnReject.on('click', function() {

		if (!authData.canApprove) {
			alert('승인 권한이 없습니다.');
			return;
		}

		// 반려 할때 url 경로
		pendingAction = `/approval24/em3/${complainId}/reject`;
		$('#submitModalLabel').text('반려');
		$('.modal-body').text('이 신청서를 반려하시겠습니까?');
		$('#submitModal').modal('show');
	});

	// 취하 버튼 클릭
	$btnCancel.on('click', function() {
		if (!canCancelOrSetLine) {
			alert('민원을 취하할 권한이 없거나 본인이 신청한 민원이 아닙니다.');
			return;
		}
		// 취하 할때 url 경로
		pendingAction = `/approval24/em3/${complainId}/cancel`;
		$('#submitModalLabel').text('취하');
		$('.modal-body').text('신청서를 취하하시겠습니까?');
		$('#submitModal').modal('show');
	});

	// 모달 확인 버튼 -> 실제 제출
	$confirmBtn.on('click', function() {
		if (pendingAction) {
			$form.attr('action', pendingAction);
			$form.trigger('submit');
			$('#submitModal').modal('hide');
		}
	});

});
