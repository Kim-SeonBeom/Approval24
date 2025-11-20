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
	        pendingAction = `/approval24/complain/category/mt1/${complainId}`; 
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
	            	<td>${processorPositionName}</td>   
	                <td>${processorName}</td>         
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
	            renderRejectComments(approvalList);

	        } catch (e) {
	            console.error(e);
	            $historyTbody.html('<tr><td colspan="7">서버 오류 발생</td></tr>');
	            $('#rejectCommentTable tbody').html('<tr><td colspan="4">서버 오류로 사유를 불러올 수 없습니다.</td></tr>');
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
	     // isInitiator: 민원 담당자 계정 ID와 현재 세션 계정 ID가 같은지 확인
	     const isInitiator = authData.complainAccountId === authData.sessionAccountId;
	     
	     // ⭐️ 1. 코멘트 변수를 let으로 함수 시작 시 선언하고 초기화
	     let commentVal = $('#comment').val() || ''; 

	     // ==========================================================
	     // 1. [담당자 첫 제출 및 승인] (isApprove === true && isInitiator === true)
	     // ==========================================================
	     if (isApprove && isInitiator) {
	         
	         // (주석 처리된 결재선 유효성 검사 로직은 현재 비활성화 상태 유지)

	         if (!confirm('결재선을 제출하고 승인을 처리하시겠습니까?')) return;
	         
	         // 현재는 첫 번째 결재자(대부분 담당자 본인)에게 코멘트를 남기는 방식
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
	                 $('#comment').val(''); // 코멘트 초기화
	             } else {
	                 alert(json?.message || `오류: ${res.status}`);
	             }
	         } catch (e) {
	             console.error(e);
	             alert('서버 에러 발생');
	         }
	     } 
	     
	     // ==========================================================
	     // 2. [일반 승인/반려] 또는 [담당자의 반려/취하] (나머지 케이스)
	     // ==========================================================
	     else {
	         // 현재 E001(결재 대기) 상태인 결재 건을 찾음
	         const current = approvalList.find(a => a.approvalStatusCd === 'E001');
	         
	         // 🔹 A. E001 대기 건이 없음 -> 담당자의 반려(E003) 또는 취하(E005) 처리 시나리오
	         if (!current) {
	             
	             // ⭐️ 담당자의 반려(E003) 또는 취하(E005) 요청일 경우에만 처리
	             if (statusCd === 'E003' || statusCd === 'E005') { 
	                 
	                 const actionName = statusCd === 'E003' ? '반려' : '취하';
	                 
	                 // 반려(E003) 시에만 의견 필수 체크
	                 if (statusCd === 'E003' && !commentVal.trim()) {
	                     alert("반려 시에는 의견이 필수입니다.");
	                     $('#comment').focus();
	                     return;
	                 }

	                 if (!confirm(`${actionName} 하시겠습니까?`)) return;
	                 
	                 try {
	                     // ⭐️ 단일 기록을 위한 DTO 생성 및 코멘트 설정
	                     const singleActionRecord = [{
	                         complainId: complainId,
	                         approvalStatusCd: statusCd, // E003 또는 E005
	                         approvalComment: commentVal, 
	                     }];
	                     
	                     const payload = {
	                         complainId: complainId,
	                         approvalLineData: singleActionRecord, 
	                         contextUrl: window.location.href
	                     };

	                     // ⭐️ 통합된 URL로 fetch 호출
	                     const res = await fetch(`/approval24/api/approval/complain/rejectAndCancle`, {
	                         method: 'POST',
	                         headers: { 'Content-Type': 'application/json' },
	                         credentials: 'same-origin',
	                         body: JSON.stringify(payload)
	                     });
	                     
	                     const json = await res.json().catch(() => null);
	                     if (res.ok) {
	                         alert(json?.message || `${actionName} 완료되었습니다.`);
	                         $('#comment').val('');
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

	         // 🔹 B. E001 대기 건이 있음 -> 일반적인 승인/반려 로직 (기존 로직 유지)
	         
	         // 반려(E003) 시에만 의견 필수 체크
	         if (statusCd === 'E003' && !commentVal.trim()) {
	             alert("반려 시에는 의견이 필수입니다.");
	             $('#comment').focus();
	             return;
	         }
	         
	         // commentVal이 이미 선언되어 있으므로 const 없이 사용
	         const payload = {
	             ...current,
	             approvalStatusCd: statusCd,
	             approvalComment: commentVal || '' // 업데이트된 commentVal 사용
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
	 
	 function renderRejectComments(list) {
		    const $tbody = $('#rejectCommentTable tbody');
		    $tbody.empty();

		    // 1. E003 (반려) 상태이고, 코멘트 내용이 있는 항목만 필터링
		    const rejectComments = list.filter(item => 
		        item.approvalStatusCd === 'E003' && item.approvalComment && item.approvalComment.trim() !== ''
		    );

		    // ⭐️ 컬럼 개수: 3개
		    if (rejectComments.length === 0) {
		        $tbody.html('<tr><td colspan="3">반려 사유가 없습니다.</td></tr>');
		        return;
		    }

		    rejectComments.forEach(item => {
		        const processorName = item.processorName || 'N/A';
		        const processorPositionName = item.processorPositionName || 'N/A';
		        // 처리 일시는 제외

		        const tr = $('<tr>').html(`
		        	<td>${processorPositionName}</td>
		            <td>${processorName}</td>
		            <td class="text-left">${item.approvalComment}</td>
		        `);
		        $tbody.append(tr);
		    });
		}


	//-------------------------------------------------------------
	     // 5. 이벤트 핸들러 정리 (최종)
	     // -------------------------------------------------------------
	     $('#btnApprovalLine').on('click', function() {
	         $('#approvalLineEditorModal').modal('show'); 
	     });
	     
	     // 승인, 반려, 취소 버튼은 모두 handleDecision으로 통합합니다.
	     $btnApprove.on('click', () => handleDecision('E002')); // 승인
	     $btnReject.on('click', () => handleDecision('E003')); // 반려
	     $btnComplainCancel.on('click', () => handleDecision('E005')); // ⭐️ 취하 (E005)

	     // 페이지 로드 시 실행
	     loadApprovalLine();
});