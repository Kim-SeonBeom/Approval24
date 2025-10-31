function setDisabled($els, isDisabled) {
  $els.prop('disabled', isDisabled).toggleClass('readonly-box', isDisabled);
}
function clearVals($els) { $els.val(''); }

// =============== 시작 ===============
document.addEventListener('DOMContentLoaded', function () {
  // --- 폼/버튼 ---
  const $form       = $('#submitForm');
  const $updateBtn  = $('#btnUpdate');          // 수정↔저장 토글 버튼
  const $confirmBtn = $('#btnSubmitConfirm');   // 모달의 "제출" 버튼
  const $userAddrBtn  = $('#btnAddressSearch');       // 있으면 자동 제어

  // --- 공통 묶음 (텍스트류/선택류) ---
  const $textInputs = $form.find([
    'input[type=text]','input[type=tel]','input[type=email]','input[type=number]',
    'input[type=date]','input[type=time]','input[type=datetime-local]',
    'input[type=url]','input[type=search]','input[type=password]','textarea'
  ].join(','));
  const $choiceInputs = $form.find('select, input[type=checkbox], input[type=radio], input[type=file]');

  // --- 주소/주민번호: 항상 잠금 유지 ---
  const $fixedReadonly = $('#complainuserResiNoFront,#complainuserResiNoBack,#complainuserPost,#complainuserAddress');

  // --- 종속 그룹: 라디오에 따라 잠금/초기화 ---
  const incomeOccurYnY = document.getElementById('incomeOccurYnY');
  const incomeOccurYnN = document.getElementById('incomeOccurYnN');
  const $incomeDetail  = $form.find('input[name="incomeDetail"]');
  const $workStartDt   = $form.find('input[name="workStartDt"]');
  const $incomeAmt     = $form.find('input[name="incomeAmt"]');
  const $incomeEstAmt  = $form.find('input[name="incomeEstAmt"]');

  const bizRegYnY = document.getElementById('bizRegYnY');
  const bizRegYnN = document.getElementById('bizRegYnN');
  const $bizDetail = $form.find('input[name="bizDetail"]');
  const $bizRegDt  = $form.find('input[name="bizRegDt"]');

  const selfEmpPrepActYnY = document.getElementById('selfEmpPrepActYnY');
  const selfEmpPrepActYnN = document.getElementById('selfEmpPrepActYnN');
  const $selfEmpPrepAct     = $form.find('input[name="selfEmpPrepAct"]');
  const $selfEmpStartPlanDt = $form.find('input[name="selfEmpStartPlanDt"]');

  const reEmploymentYnY = document.getElementById('reEmploymentYnY');
  const reEmploymentYnN = document.getElementById('reEmploymentYnN');
  const $coNm             = $form.find('input[name="coNm"]');
  const $reEmploymentPlanDt = $form.find('input[name="reEmploymentPlanDt"]');

  function toggleIncomeBlock() {
    const off = !!(incomeOccurYnN && incomeOccurYnN.checked);
    setDisabled($incomeDetail.add($workStartDt).add($incomeAmt).add($incomeEstAmt), off);
    if (off) clearVals($incomeDetail.add($workStartDt).add($incomeAmt).add($incomeEstAmt));
  }
  function toggleBizBlock() {
    const off = !!(bizRegYnN && bizRegYnN.checked);
    setDisabled($bizDetail.add($bizRegDt), off);
    if (off) clearVals($bizDetail.add($bizRegDt));
  }
  function toggleSelfEmpBlock() {
    const off = !!(selfEmpPrepActYnN && selfEmpPrepActYnN.checked);
    setDisabled($selfEmpPrepAct.add($selfEmpStartPlanDt), off);
    if (off) clearVals($selfEmpPrepAct.add($selfEmpStartPlanDt));
  }
  function toggleReEmploymentBlock() {
    const off = !!(reEmploymentYnN && reEmploymentYnN.checked);
    setDisabled($coNm.add($reEmploymentPlanDt), off);
    if (off) clearVals($coNm.add($reEmploymentPlanDt));
  }

  // 라디오 변경 이벤트
  incomeOccurYnY && incomeOccurYnY.addEventListener('change', toggleIncomeBlock);
  incomeOccurYnN && incomeOccurYnN.addEventListener('change', toggleIncomeBlock);
  bizRegYnY && bizRegYnY.addEventListener('change', toggleBizBlock);
  bizRegYnN && bizRegYnN.addEventListener('change', toggleBizBlock);
  selfEmpPrepActYnY && selfEmpPrepActYnY.addEventListener('change', toggleSelfEmpBlock);
  selfEmpPrepActYnN && selfEmpPrepActYnN.addEventListener('change', toggleSelfEmpBlock);
  reEmploymentYnY && reEmploymentYnY.addEventListener('change', toggleReEmploymentBlock);
  reEmploymentYnN && reEmploymentYnN.addEventListener('change', toggleReEmploymentBlock);

  // --- 편집 모드 토글 ---
  function setEditMode(isEdit) {
    // 전체 제어
    setDisabled($textInputs, !isEdit);
    setDisabled($choiceInputs, !isEdit);
    if ($userAddrBtn.length)  $userAddrBtn.prop('disabled', !isEdit);

    // 항상 잠금 유지 (주소/주민)
    setDisabled($fixedReadonly, true);

    // 라디오 종속 블록 보정
    toggleIncomeBlock();
    toggleBizBlock();
    toggleSelfEmpBlock();
    toggleReEmploymentBlock();

    // 버튼 토글
    if (isEdit) {
      $updateBtn.html('<i class="fas fa-save mr-1"></i>저장').removeClass('btn-primary').addClass('btn-success');
    } else {
      $updateBtn.html('<i class="fas fa-edit mr-1"></i>수정').removeClass('btn-success').addClass('btn-primary');
    }
  }

  // 최초: 보기 모드(전부 잠금)
  setEditMode(false);

  // 수정/저장 클릭
  $updateBtn.on('click', function () {
    const lockedNow = $textInputs.first().prop('disabled'); // 보기모드면 true
    if (lockedNow) {
      // → 수정 모드 진입
      setEditMode(true);
      return;
    }
    // → 저장: 유효성 검사 후 모달
    if ($form[0].checkValidity && !$form[0].checkValidity()) {
      if ($form[0].reportValidity) $form[0].reportValidity();
      return;
    }
    $('#submitModal').modal('show');
  });

  // 모달 "제출" → 실제 submit
  $confirmBtn.on('click', function () {
    // disabled는 전송 안 되므로 일시 해제
    setDisabled($textInputs, false);
    setDisabled($choiceInputs, false);
    if ($userAddrBtn.length)  $userAddrBtn.prop('disabled', false);

    // N인 블록 값 초기화(전송 직전 최종 보정)
    toggleIncomeBlock();
    toggleBizBlock();
    toggleSelfEmpBlock();
    toggleReEmploymentBlock();

    $form.trigger('submit');
  });
});