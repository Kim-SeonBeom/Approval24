document.addEventListener('DOMContentLoaded', function() {
	// form & buttons
	const $form = $('#submitForm'); // 수정버튼
	const $confirmBtn = $('#btnSubmitConfirm'); // 모달 "제출" 버튼
	const $userAddressBtn = $('#btnAddressSearch');
	const $bizAddressBtn = $('#btnSearchBizAddress');
	const complainId = $form.find('input[name="complainId"]').val();

	// 버튼 캐시
	const $btnApprovalLine = $('#btnApprovalLine');
	const $btnSave = $('#btnSave');
	const $btnApprove = $('#btnApprove');
	const $btnReject = $('#btnReject');
	const $btnCancel = $('#btnComplainCancel');

	


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
		pendingAction = `/approval24/em1/${complainId}`; // 기본 저장 경로
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
		pendingAction = `/approval24/em1/${complainId}/approve`;
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
		pendingAction = `/approval24/em1/${complainId}/reject`;
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
		pendingAction = `/approval24/em1/${complainId}/cancel`;
		$('#submitModalLabel').text('취하');
		$('.modal-body').text('신청서를 취하하시겠습니까?');
		$('#submitModal').modal('show');
	});

	//모달 확인 버튼 -> 실제 제출 
	$confirmBtn.on('click', function() {
		if (pendingAction) {
			$form.attr('action', pendingAction);
			$form.trigger('submit');
			$('#submitModal').modal('hide');
		}
	});

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