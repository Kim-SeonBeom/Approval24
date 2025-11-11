    // 로컬 yyyy-MM-dd → Date(자정) 파서
    function parseLocalDate(ymd) {
      if (!ymd) return null;
      const [y, m, d] = ymd.split('-').map(Number); 
      if (!y || !m || !d) return null;
      return new Date(y, m - 1, d);
    }
    function todayLocal() {
      const t = new Date();
      return new Date(t.getFullYear(), t.getMonth(), t.getDate());
    }
    function daysBetweenDates(aDate, bDate) {
      const MS = 24 * 60 * 60 * 1000;
      return Math.round((bDate - aDate) / MS);
    }

    // 실직기간 계산: 퇴사일 ~ 오늘
    document.getElementById('btnCalcUnemp')?.addEventListener('click', function () {
      const unempStr = document.querySelector('input[name="unempDt"]').value;
      const unempDt = parseLocalDate(unempStr);
      const today = todayLocal();
      if (!unempDt) { alert('퇴사일을 먼저 입력해주세요.'); return; }
      let days = daysBetweenDates(unempDt, today);
      if (days < 0) days = 0;
      const out = document.getElementById('unempPeriod');
      if (out) out.value = days;
    });

    // 훈련기간 계산: 시작 ~ 종료
    document.getElementById('btnCalcTrain')?.addEventListener('click', function () {
      const stStr = document.getElementById('trainStartDt').value;
      const enStr = document.getElementById('trainEndDt').value;
      const st = parseLocalDate(stStr);
      const en = parseLocalDate(enStr);
      if (!st || !en) return;
      const days = daysBetweenDates(st, en);
      const out = document.getElementById('trainPeriod');
      if (out && !isNaN(days)) out.value = days;
    });

    document.addEventListener('DOMContentLoaded', function () {
        // 이 페이지의 실제 폼/버튼 id로 매칭
        const $form = $('#loanApplyForm');
        const $confirmBtn = $('#btnSubmitConfirm'); // 모달의 "저장" 버튼
        const $userAddressBtn = $('#btnAddressSearch');
        const $trainAddressBtn = $('#btnSearchTrainAddress');
        
    	// 버튼 캐시
    	const $btnApprovalLine = $('#btnApprovalLine');
    	const $btnSave = $('#btnSave');
    	const $btnApprove = $('#btnApprove');
    	const $btnReject = $('#btnReject');
    	const $btnCancel = $('#btnComplainCancel');

        
        
        // 수혜여부에 따른 YN체크를 위한 선언
        const benefitY = document.getElementById("benefitY");
        const benefitN = document.getElementById("benefitN");
        const subsidyAmt = document.getElementById("subsidyAmt");
        const submitBtn = document.getElementById("btnSubmitConfirm");
        
        const complainId = $form.find('input[name="complainId"]').val();

        
        // 수혜여부에 따른 수혜금액 전송
        function toggleSubsidyAmt() {
          if (benefitN.checked) {
            subsidyAmt.value = "0";
            subsidyAmt.readOnly = true;   // 수정 불가
            subsidyAmt.classList.add("readonly-box"); // 회색 처리
          } else {
            subsidyAmt.readOnly = false;  // 입력 가능
            subsidyAmt.classList.remove("readonly-box");
          }
        }
        
        if (benefitY) benefitY.addEventListener('change', toggleSubsidyAmt);
        if (benefitN) benefitN.addEventListener('change', toggleSubsidyAmt);
        toggleSubsidyAmt();


        const $choiceInputs = $form.find('select, input[type=checkbox], input[type=radio], input[type=file]');

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
    		pendingAction = `/approval24/complain/category/ue1/${complainId}`; // 기본 저장 경로
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
    		pendingAction = `/approval24/ue1/${complainId}/approve`;
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
    		pendingAction = `/approval24/ue1/${complainId}/reject`;
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
    		pendingAction = `/approval24/ue1/${complainId}/cancel`;
    		$('#submitModalLabel').text('취하');
    		$('.modal-body').text('신청서를 취하하시겠습니까?');
    		$('#submitModal').modal('show');
    	});

    	// 모달 "제출" -> 실제 submit
    	$confirmBtn.on('click', function() {
    		// disabled는 전송 안 되므로 일시 해제
    		setDisabled($textInputs, false);
    		setDisabled($choiceInputs, false);

    		$form.trigger('submit');
    	});
       
      }); 


function openTrainPostcode() {
	new daum.Postcode({
		oncomplete : function(data) {
			// R: 도로명, J: 지번
			const addr = data.userSelectedType === 'R' ? data.roadAddress
					: data.jibunAddress;

			// 우편번호
			document.getElementById('trainPost').value = data.zonecode;

			// 기본 주소
			document.getElementById('trainInstAddr').value = addr;

			// 상세 주소 입력창에 포커스
			document.getElementById('trainInstAddrDetail').focus();
		}
	}).open();
}