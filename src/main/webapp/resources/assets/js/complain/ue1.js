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
        // ✅ 이 페이지의 실제 폼/버튼 id로 매칭
        const $form = $('#loanApplyForm');
        const $updateBtn = $('#btnUpdate');
        const $confirmBtn = $('#btnSubmitConfirm'); // 모달의 "저장" 버튼
        const $userAddressBtn = $('#btnAddressSearch');
        const $trainAddressBtn = $('#btnSearchTrainAddress');
        
        //수혜여부에 따른 YN체크를 위한 선언
        const benefitY = document.getElementById("benefitY");
        const benefitN = document.getElementById("benefitN");
        const subsidyAmt = document.getElementById("subsidyAmt");
        const submitBtn = document.getElementById("btnSubmitConfirm");
        
        //수혜여부에 따른 수혜금액 전송
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

        // 텍스트형(읽기전용 제어), 선택형(비활성 제어)
        const $textInputs = $form.find([
          'input[type=text]',
          'input[type=tel]',
          'input[type=email]',
          'input[type=number]',
          'input[type=date]',
          'input[type=time]',
          'input[type=datetime-local]',
          'input[type=url]',
          'input[type=search]',
          'input[type=password]',
          'textarea'
        ].join(','));

        const $choiceInputs = $form.find('select, input[type=checkbox], input[type=radio], input[type=file]');

        function setEditMode(isEdit) {
          $textInputs.prop('readonly', !isEdit).toggleClass('readonly-box', !isEdit);
          $choiceInputs.prop('disabled', !isEdit);
          if ($userAddressBtn.length) $userAddressBtn.prop('disabled', !isEdit);
          if ($trainAddressBtn.length) $trainAddressBtn.prop('disabled', !isEdit);
          
          $('#complainuserResiNoFront,#complainuserResiNoBack, #complainuserPost,#complainuserAddress ,#trainPost, #trainInstAddr')
          .prop('readonly', true).addClass('readonly-box');

          

          if (isEdit) {
        	toggleSubsidyAmt();
            $updateBtn.html('<i class="fas fa-save mr-1"></i>저장')
                      .removeClass('btn-primary').addClass('btn-success');
          } else {
              if (subsidyAmt) {
                  subsidyAmt.readOnly = true;
                  subsidyAmt.classList.add('readonly-box');
                }
            $updateBtn.html('<i class="fas fa-edit mr-1"></i>수정')
                      .removeClass('btn-success').addClass('btn-primary');
          }
        }

        // 최초: 보기 모드
        setEditMode(false);

        // 수정/저장 버튼 클릭
        $updateBtn.on('click', function () {
          const readOnlyNow = $textInputs.first().prop('readonly');

          if (readOnlyNow) {
            //수정 모드 진입
            setEditMode(true);
            return;
          }

          //저장 전 모달로 확인
          if (!$form[0].checkValidity()) {
            $form[0].reportValidity?.();
            return;
          }
          $('#submitModal').modal('show');
        });

        // 모달에서 "저장" 확정
        $confirmBtn.on('click', function () {
          // disabled는 전송이 안 되므로 제출 직전 잠깐 활성화
          $choiceInputs.prop('disabled', false);
          if ($userAddressBtn.length) $userAddressBtn.prop('disabled', false);
          if ($trainAddressBtn.length) $trainAddressBtn.prop('disabled', false);

          $form.trigger('submit');
        });
        
        // 제출 직전에도 안전하게 0 보정
        submitBtn.addEventListener("click", function () {
          if (benefitN.checked) {
            subsidyAmt.value = "0";
          }
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