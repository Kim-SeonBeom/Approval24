function setDisabled($els, isDisabled) {
	$els.prop('disabled', isDisabled).toggleClass('readonly-box', isDisabled);
}
function clearVals($els) {
	$els.val('');
}

document
		.addEventListener(
				'DOMContentLoaded',
				function() {
					// form & buttons
					let isEditMode = false;
					const $form = $('#submitForm');
					const $updateBtn = $('#btnUpdate'); // "수정↔저장" 토글 버튼
					const $confirmBtn = $('#btnSubmitConfirm'); // 모달 "제출" 버튼
					const $userAddressBtn = $('#btnAddressSearch');

					const $participantType = $form
							.find('input[name="participantType"]');
					const $studentNo = $form.find('input[name="studentNo"]');
					const $grade = $form.find('input[name="grade"]');
					const $major = $form.find('input[name="major"]');
					const $studentStatus = $form
							.find('input[name="studentStatus"]');
					const $graduateDate = $form
							.find('input[name="graduateDate"]');

					// controls
					const $textInputs = $form.find([ 'input[type=text]',
							'input[type=tel]', 'input[type=email]',
							'input[type=number]', 'input[type=date]',
							'input[type=time]', 'input[type=datetime-local]',
							'input[type=url]', 'input[type=search]',
							'input[type=password]', 'textarea' ].join(','));
					const $choiceInputs = $form
							.find('select, input[type=checkbox], input[type=radio], input[type=file]');

					// 항상 잠금 유지(있을 때만)
					const $fixedReadonly = $([ '#complainuserResiNoFront',
							'#complainuserResiNoBack', '#complainuserPost',
							'#complainuserAddress' ].join(','));

					function updateParticipantTypeState() {
						if (!isEditMode) {
							// 보기모드: 항상 선택 불가 + 회색
							$$participantType.prop('disabled', true).closest(
									'.form-check').addClass('readonly-box')
									.css('pointer-events', 'none'); // 라벨 클릭도
							// 막기(안전)
							return;
						}
						const selected = $participantType.filter(':checked')
								.val();
						if (selected === 'graduate') {
							$studentNo.prop('checked', false).prop('disabled',
									true).closest('.form-check').addClass(
									'readonly-box').css('pointer-events',
									'none');
							$grade.prop('checked', false)
									.prop('disabled', true).closest(
											'.form-check').addClass(
											'readonly-box').css(
											'pointer-events', 'none');
							$major.prop('checked', false)
									.prop('disabled', true).closest(
											'.form-check').addClass(
											'readonly-box').css(
											'pointer-events', 'none');
							$studentStatus.prop('checked', false).prop(
									'disabled', true).closest('.form-check')
									.addClass('readonly-box').css(
											'pointer-events', 'none');
							$graduateDate.prop('checked', false).prop(
									'disabled', true).closest('.form-check')
									.addClass('readonly-box').css(
											'pointer-events', 'none');
						} else {
							$studentNo.prop('disabled', false).closest(
									'.form-check').removeClass('readonly-box')
									.css('pointer-events', '');
							$grade.prop('disabled', false).closest(
									'.form-check').removeClass('readonly-box')
									.css('pointer-events', '');
							$major.prop('disabled', false).closest(
									'.form-check').removeClass('readonly-box')
									.css('pointer-events', '');
							$studentStatus.prop('disabled', false).closest(
									'.form-check').removeClass('readonly-box')
									.css('pointer-events', '');
							$graduateDate.prop('disabled', false).closest(
									'.form-check').removeClass('readonly-box')
									.css('pointer-events', '');
						}
					}

					// ===== 편집 모드 토글 =====
					function setEditMode(isEdit) {

						isEditMode = isEdit;
						// 전체 활성/비활성
						setDisabled($textInputs, !isEdit);
						setDisabled($choiceInputs, !isEdit);
						if ($userAddressBtn.length)
							$userAddressBtn.prop('disabled', !isEdit);

						// 항상 잠금 유지
						setDisabled($fixedReadonly, true);

						// 버튼 라벨/스타일 토글
						if (isEdit) {
							$updateBtn.html(
									'<i class="fas fa-save mr-1"></i>저장')
									.removeClass('btn-primary').addClass(
											'btn-success');
						} else {
							$updateBtn.html(
									'<i class="fas fa-edit mr-1"></i>수정')
									.removeClass('btn-success').addClass(
											'btn-primary');
						}
						updateParticipantTypeState();
					}

					// 초기: 보기 모드(모두 잠금)
					setEditMode(false);

					$benefitRadios.on('change', updateParticipantTypeState);

					// 수정/저장 토글 클릭
					$updateBtn.on('click',
							function() {
								const isViewLocked = $textInputs.first().prop(
										'disabled'); // 보기 모드면 true
								if (isViewLocked) {
									// 수정 모드 진입
									setEditMode(true);
									return;
								}
								// 저장 시: 필수 검증 -> 모달 열기
								if ($form[0].checkValidity
										&& !$form[0].checkValidity()) {
									if ($form[0].reportValidity)
										$form[0].reportValidity();
									return;
								}
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
