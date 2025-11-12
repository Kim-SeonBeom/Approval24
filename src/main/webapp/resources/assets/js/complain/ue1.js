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
        const $btnSave = $('#btnSave');
        const $btnApprove = $('#btnApprove');
        const $btnReject = $('#btnReject');
        const $btnApprovalLine = $('#btnApprovalLine');
        const $btnComplainCancel = $('#btnComplainCancel');
        const $historyTbody = $('#historyTable tbody');
        let approvalList = [];
        
        
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
    		pendingAction = `/approval24/complain/category/ue1/${complainId}`; // 기본
																				// 저장
																				// 경로
    		$('#submitModalLabel').text('저장');
    		$('.modal-body').text('입력하신 내용으로 신청서를 저장할까요?');
    		$('#submitModal').modal('show');
    	});

    	

    	// 모달 "제출" -> 실제 submit
  	  $confirmBtn.on('click', function () {
		    
		    if (pendingAction) $form.attr('action', pendingAction);

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