document
		.addEventListener(
				'DOMContentLoaded',
				function() {
					// --- 폼/버튼 ---
					const $form = $('#submitForm');
					const $confirmBtn = $('#btnSubmitConfirm'); // 모달의 "제출" 버튼
					const $userAddrBtn = $('#btnAddressSearch'); // 있으면 자동 제어

					// 버튼 캐시
				    const $btnSave = $('#btnSave');
				    const $btnApprove = $('#btnApprove');
				    const $btnReject = $('#btnReject');
				    const $btnApprovalLine = $('#btnApprovalLine');
				    const $btnComplainCancel = $('#btnComplainCancel');
				    const $historyTbody = $('#historyTable tbody');
				    let approvalList = [];
					const complainId = $form.find('input[name="complainId"]').val();

					// --- 종속 그룹: 라디오에 따라 잠금/초기화 ---
					const incomeOccurYnY = document
							.getElementById('incomeOccurYnY');
					const incomeOccurYnN = document
							.getElementById('incomeOccurYnN');
					const $incomeDetail = $form
							.find('input[name="incomeDetail"]');
					const $workStartDt = $form
							.find('input[name="workStartDt"]');
					const $incomeAmt = $form.find('input[name="incomeAmt"]');
					const $incomeEstAmt = $form
							.find('input[name="incomeEstAmt"]');

					const bizRegYnY = document.getElementById('bizRegYnY');
					const bizRegYnN = document.getElementById('bizRegYnN');
					const $bizDetail = $form.find('input[name="bizDetail"]');
					const $bizRegDt = $form.find('input[name="bizRegDt"]');

					const selfEmpPrepActYnY = document
							.getElementById('selfEmpPrepActYnY');
					const selfEmpPrepActYnN = document
							.getElementById('selfEmpPrepActYnN');
					const $selfEmpPrepAct = $form
							.find('input[name="selfEmpPrepAct"]');
					const $selfEmpStartPlanDt = $form
							.find('input[name="selfEmpStartPlanDt"]');

					const reEmploymentYnY = document
							.getElementById('reEmploymentYnY');
					const reEmploymentYnN = document
							.getElementById('reEmploymentYnN');
					const $coNm = $form.find('input[name="coNm"]');
					const $reEmploymentPlanDt = $form
							.find('input[name="reEmploymentPlanDt"]');

					function toggleIncomeBlock() {
						const off = !!(incomeOccurYnN && incomeOccurYnN.checked);
						const $grp = $incomeDetail.add($workStartDt).add(
								$incomeAmt).add($incomeEstAmt);
						$grp.prop('disabled', off).toggleClass('readonly-box',
								off);
						if (off)
							$grp.val('');
					}
					function toggleBizBlock() {
						const off = !!(bizRegYnN && bizRegYnN.checked);
						const $grp = $bizDetail.add($bizRegDt);
						$grp.prop('disabled', off).toggleClass('readonly-box',
								off);
						if (off)
							$grp.val('');
					}

					function toggleSelfEmpBlock() {
						const off = !!(selfEmpPrepActYnN && selfEmpPrepActYnN.checked);
						const $grp = $selfEmpPrepAct.add($selfEmpStartPlanDt);
						$grp.prop('disabled', off).toggleClass('readonly-box',
								off);
						if (off)
							$grp.val('');
					}

					function toggleReEmploymentBlock() {
						const off = !!(reEmploymentYnN && reEmploymentYnN.checked);
						const $grp = $coNm.add($reEmploymentPlanDt);
						$grp.prop('disabled', off).toggleClass('readonly-box',
								off);
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
					bizRegYnY
							&& bizRegYnY.addEventListener('change',
									toggleBizBlock);
					bizRegYnN
							&& bizRegYnN.addEventListener('change',
									toggleBizBlock);
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
					$btnSave
							.on(
									'click',
									function() {
										if (!authData.canUpdate) {
											alert('수정 권한이 없습니다.');
											return;
										}

										if ($form[0].checkValidity
												&& !$form[0].checkValidity()) {
											if ($form[0].reportValidity)
												$form[0].reportValidity();
											return;
										}
										// 저장 할때 url 경로
								   		pendingAction = `/approval24/complain/category/ue2/${complainId}`; // 기본
																											// 저장
																											// 경로
							    		$('#submitModalLabel').text('저장');
							    		$('.modal-body').text('입력하신 내용으로 신청서를 저장할까요?');
							    		$('#submitModal').modal('show');
									});


					// 모달 "제출" -> 실제 submit
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