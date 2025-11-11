document.addEventListener('DOMContentLoaded',
		function() {
			// --- 폼/버튼 ---
			const $form = $('#submitForm');
			const $confirmBtn = $('#btnSubmitConfirm'); // 모달의 "제출" 버튼
			const $userAddrBtn = $('#btnAddressSearch'); // 있으면 자동 제어
			
			// 버튼 캐시
			const $btnApprovalLine = $('#btnApprovalLine');
			const $btnSave = $('#btnSave');
			const $btnApprove = $('#btnApprove');
			const $btnReject = $('#btnReject');
			const $btnCancel = $('#btnComplainCancel');

			

			// --- 종속 그룹: 라디오에 따라 잠금/초기화 ---
			const incomeOccurYnY = document.getElementById('incomeOccurYnY');
			const incomeOccurYnN = document.getElementById('incomeOccurYnN');
			const $incomeDetail = $form.find('input[name="incomeDetail"]');
			const $workStartDt = $form.find('input[name="workStartDt"]');
			const $incomeAmt = $form.find('input[name="incomeAmt"]');
			const $incomeEstAmt = $form.find('input[name="incomeEstAmt"]');

			const bizRegYnY = document.getElementById('bizRegYnY');
			const bizRegYnN = document.getElementById('bizRegYnN');
			const $bizDetail = $form.find('input[name="bizDetail"]');
			const $bizRegDt = $form.find('input[name="bizRegDt"]');

			const selfEmpPrepActYnY = document
					.getElementById('selfEmpPrepActYnY');
			const selfEmpPrepActYnN = document
					.getElementById('selfEmpPrepActYnN');
			const $selfEmpPrepAct = $form.find('input[name="selfEmpPrepAct"]');
			const $selfEmpStartPlanDt = $form
					.find('input[name="selfEmpStartPlanDt"]');

			const reEmploymentYnY = document.getElementById('reEmploymentYnY');
			const reEmploymentYnN = document.getElementById('reEmploymentYnN');
			const $coNm = $form.find('input[name="coNm"]');
			const $reEmploymentPlanDt = $form
					.find('input[name="reEmploymentPlanDt"]');

			function toggleIncomeBlock() {
				const off = !!(incomeOccurYnN && incomeOccurYnN.checked);
				const $grp = $incomeDetail.add($workStartDt).add($incomeAmt)
						.add($incomeEstAmt);
				$grp.prop('disabled', off).toggleClass('readonly-box', off);
				if (off)
					$grp.val('');
			}
			function toggleBizBlock() {
				const off = !!(bizRegYnN && bizRegYnN.checked);
				const $grp = $bizDetail.add($bizRegDt);
				$grp.prop('disabled', off).toggleClass('readonly-box', off);
				if (off)
					$grp.val('');
			}

			function toggleSelfEmpBlock() {
				const off = !!(selfEmpPrepActYnN && selfEmpPrepActYnN.checked);
				const $grp = $selfEmpPrepAct.add($selfEmpStartPlanDt);
				$grp.prop('disabled', off).toggleClass('readonly-box', off);
				if (off)
					$grp.val('');
			}

			function toggleReEmploymentBlock() {
				const off = !!(reEmploymentYnN && reEmploymentYnN.checked);
				const $grp = $coNm.add($reEmploymentPlanDt);
				$grp.prop('disabled', off).toggleClass('readonly-box', off);
				if (off)
					$grp.val('');
			}

			// 라디오 변경 이벤트
			incomeOccurYnY
					&& incomeOccurYnY.addEventListener('change',
							toggleIncomeBlock);
			incomeOccurYnN
					&& incomeOccurYnN.addEventListener('change',
							toggleIncomeBlock);
			bizRegYnY && bizRegYnY.addEventListener('change', toggleBizBlock);
			bizRegYnN && bizRegYnN.addEventListener('change', toggleBizBlock);
			selfEmpPrepActYnY
					&& selfEmpPrepActYnY.addEventListener('change',
							toggleSelfEmpBlock);
			selfEmpPrepActYnN
					&& selfEmpPrepActYnN.addEventListener('change',
							toggleSelfEmpBlock);
			reEmploymentYnY
					&& reEmploymentYnY.addEventListener('change',
							toggleReEmploymentBlock);
			reEmploymentYnN
					&& reEmploymentYnN.addEventListener('change',
							toggleReEmploymentBlock);
			toggleIncomeBlock();
			toggleBizBlock();
			toggleSelfEmpBlock();
			toggleReEmploymentBlock();

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
				pendingAction = `/approval24/complain/category/ue2/${complainId}`; // 기본 저장 경로
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
				pendingAction = `/approval24/ue2/${complainId}/approve`;
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
				pendingAction = `/approval24/ue2/${complainId}/reject`;
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
				pendingAction = `/approval24/ue2/${complainId}/cancel`;
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
				toggleBizBlock();
				toggleSelfEmpBlock();
				toggleReEmploymentBlock();

				$form.trigger('submit');
			});

		});