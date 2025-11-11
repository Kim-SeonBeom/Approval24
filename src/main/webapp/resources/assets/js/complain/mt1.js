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



	  const $incomeYnRadios   = $form.find('input[name="incomeYn"]'); // ✅ 누락
																		// 보완
	  const $incomeTypeRadios = $form.find('input[name="incomeType"]');
	  const $incomeStartTime  = $form.find('input[name="incomeStartTime"]');
	  const $incomeEndTime    = $form.find('input[name="incomeEndTime"]');
	  const $workHours        = $form.find('input[name="workHours"]');

	function setDisabledGroup(disabled) {
		  // 라디오/인풋 모두 비활성/활성 + 시각 표시
		  $incomeTypeRadios
		    .prop('disabled', disabled)
		    .toggleClass('readonly-box', disabled)
		    .css('pointer-events', disabled ? 'none' : '');

		  [$incomeStartTime, $incomeEndTime, $workHours].forEach($el => {
		    $el.prop('disabled', disabled)
		       .toggleClass('readonly-box', disabled)
		       .css('pointer-events', disabled ? 'none' : '');
		  });
		}

		function clearIncomeGroup() {
		  // 라디오 선택 해제
		  $incomeTypeRadios.prop('checked', false);
		  // 값 초기화
		  $incomeStartTime.val('');
		  $incomeEndTime.val('');
		  $workHours.val('');
		}

		function toggleIncomeBlock() {
		  const val = $incomeYnRadios.filter(':checked').val(); // 'Y' or 'N'
	
		  if (val === 'N') {
		    clearIncomeGroup();
		    setDisabledGroup(true);
		  } else {
		    setDisabledGroup(false);
		  }
		}

		// 최초 1회 반영 + 변경 시 반영
		$incomeYnRadios.on('change', toggleIncomeBlock);
		toggleIncomeBlock();
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
		pendingAction = `/approval24/mt1/${complainId}`; // 기본 저장 경로
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
		pendingAction = `/approval24/mt1/${complainId}/approve`;
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
		pendingAction = `/approval24/mt1/${complainId}/reject`;
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
		pendingAction = `/approval24/mt1/${complainId}/cancel`;
		$('#submitModalLabel').text('취하');
		$('.modal-body').text('신청서를 취하하시겠습니까?');
		$('#submitModal').modal('show');
	});

	// 모달 "제출" -> 실제 submit
	$confirmBtn.on('click', function() {
		// disabled는 전송 안 되므로 일시 해제
		setDisabled($textInputs, false);
		setDisabled($choiceInputs, false);

		// 소득 N이면 값 초기화 최종 보정
		toggleIncomeBlock();

		$form.trigger('submit');
	});

	// 초기 종속 블록 상태 반영
	toggleIncomeBlock();
});