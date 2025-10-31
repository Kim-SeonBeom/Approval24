function setDisabled($els, isDisabled) {
  $els.prop('disabled', isDisabled).toggleClass('readonly-box', isDisabled);
}
function clearVals($els) { $els.val(''); }

document.addEventListener('DOMContentLoaded', function () {
	  // form & buttons
	  const $form        = $('#submitForm');
	  const $updateBtn   = $('#btnUpdate');         // "수정↔저장" 토글 버튼
	  const $confirmBtn  = $('#btnSubmitConfirm');  // 모달 "제출" 버튼

	  // controls
	  const $textInputs = $form.find([
	    'input[type=text]','input[type=tel]','input[type=email]','input[type=number]',
	    'input[type=date]','input[type=time]','input[type=datetime-local]',
	    'input[type=url]','input[type=search]','input[type=password]','textarea'
	  ].join(','));
	  const $choiceInputs = $form.find('select, input[type=checkbox], input[type=radio], input[type=file]');

	  // 항상 잠금 유지(있을 때만)
	  const $fixedReadonly = $([
	    '#complainuserResiNoFront',
	    '#complainuserResiNoBack',
	    '#complainuserPost',
	    '#complainuserAddress'
	  ].join(','));

	  // 페이지 고유 필드
	  const $infantRrnFront = $form.find('#infantRrnFront');
	  const $infantRrnBack  = $form.find('#infantRrnBack');

	  // 확인사항(소득) 종속
	  const incomeYnY = document.getElementById('incomeYnY');
	  const incomeYnN = document.getElementById('incomeYnN');
	  const $incomeTypeRadios = $form.find('input[name="incomeType"]');
	  const $incomeStartTime  = $form.find('input[name="incomeStartTime"]');
	  const $incomeEndTime    = $form.find('input[name="incomeEndTime"]');
	  const $workHours        = $form.find('input[name="workHours"]');

	  function toggleIncomeBlock() {
	    const off = !!(incomeYnN && incomeYnN.checked);
	    const $group = $incomeTypeRadios.add($incomeStartTime).add($incomeEndTime).add($workHours);
	    setDisabled($group, off);
	    if (off) clearVals($group);
	  }

	  if (incomeYnY) incomeYnY.addEventListener('change', toggleIncomeBlock);
	  if (incomeYnN) incomeYnN.addEventListener('change', toggleIncomeBlock);

	  // ===== 편집 모드 토글 =====
	  function setEditMode(isEdit) {
	    // 전체 활성/비활성
	    setDisabled($textInputs, !isEdit);
	    setDisabled($choiceInputs, !isEdit);

	    // 항상 잠금 유지
	    setDisabled($fixedReadonly, true);

	    // 라디오 종속 재보정
	    toggleIncomeBlock();

	    // 버튼 라벨/스타일 토글
	    if (isEdit) {
	      $updateBtn.html('<i class="fas fa-save mr-1"></i>저장')
	                .removeClass('btn-primary').addClass('btn-success');
	    } else {
	      $updateBtn.html('<i class="fas fa-edit mr-1"></i>수정')
	                .removeClass('btn-success').addClass('btn-primary');
	    }
	  }

	  // 초기: 보기 모드(모두 잠금)
	  setEditMode(false);

	  // 숫자만 허용(영아 주민번호)
	  $infantRrnFront.on('input', function () {
	    this.value = this.value.replace(/\D/g, '').slice(0, 6);
	  });
	  $infantRrnBack.on('input', function () {
	    this.value = this.value.replace(/\D/g, '').slice(0, 7);
	  });

	  // 수정/저장 토글 클릭
	  $updateBtn.on('click', function () {
	    const isViewLocked = $textInputs.first().prop('disabled'); // 보기 모드면 true
	    if (isViewLocked) {
	      // 수정 모드 진입
	      setEditMode(true);
	      return;
	    }
	    // 저장 시: 필수 검증 -> 모달 열기
	    if ($form[0].checkValidity && !$form[0].checkValidity()) {
	      if ($form[0].reportValidity) $form[0].reportValidity();
	      return;
	    }
	    $('#submitModal').modal('show');
	  });

	  // 모달 "제출" -> 실제 submit
	  $confirmBtn.on('click', function () {
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