<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<title>계정 신청 승인 | 결재24</title>


</head>
<body id="page-top" style="background: linear-gradient(to right, #126C83, #74BCAA); min-height: 100vh;">
	<div id="wrapper" style="background: transparent !important;">

		<div id="content-wrapper" class="d-flex flex-column" style="background: transparent !important;">
			<div id="content" style="background: transparent !important;">

				<div class="container-fluid">
					<!-- Page Heading -->
					<div class="d-flex align-items-center justify-content-between mb-4">
					</div>

					<div class="row justify-content-center">
						<div class="col-lg-10 col-xl-10">
							<form id="requestForm"
								action="${pageContext.request.contextPath}/signup/approveForm"
								method="post">
								<div class="card shadow mb-4">

									<c:if test="${not empty error}">
										<div class="alert alert-danger alert-dismissible fade show"
											role="alert" style="margin: 15px;">
											<i class="fas fa-exclamation-triangle mr-2"></i> <strong>오류:</strong>
											${error}
											<button type="button" class="close" data-dismiss="alert"
												aria-label="Close">
												<span aria-hidden="true">&times;</span>
											</button>
										</div>
									</c:if>
									<div
										class="card-header py-3 d-flex align-items-center justify-content-between">
										<h6 class="m-0 font-weight-bold text-primary">계정신청</h6>
									</div>

									<div class="card-body">

										<!-- 신청 정보 -->
										<div class="row">
											<!-- 기관 -->
											<div class="col-md-6 mb-3">
												<label>기관</label> <select class="form-control" id="instId"
													name="instId">
													<option value="">-- 기관 선택 --</option>
													<c:forEach var="inst" items="${instList}">
														<option value="${inst.instId}">${inst.instName}</option>
													</c:forEach>
												</select>
											</div>

											<!-- 부서 -->
											<div class="col-md-6 mb-3">
												<label>부서</label> <select class="form-control" id="deptId"
													name="deptId">
													<option value="">-- 부서 선택--</option>
													<c:forEach var="dept" items="${deptList}">
														<option value="${dept.deptId}">${dept.deptName}</option>
													</c:forEach>
												</select> <small id="deptMessage" class="form-text text-muted"></small>
											</div>

											<div class="col-md-4 mb-3">
												<label>신청자</label> <input type="text"
													class="form-control readonly-box"
													value="${request.userName}" placeholder="신청자 입력">
											</div>
											<div class="col-md-4 mb-3">
												<label>휴대전화</label> <input type="text"
													class="form-control readonly-box" value="${request.phone}"
													placeholder="휴대전화 입력">
											</div>
											<div class="col-md-4 mb-3">
												<label>주민번호</label> <input type="text"
													class="form-control readonly-box" name="residentNo"
													value="${request.residentNo}" placeholder="주민번호 입력">
											</div>
											<!-- 아이디 -->
											<div class="col-md-4 mb-3">
												<label>아이디</label>
												<div class="input-group">
													<input type="text" class="form-control" name="loginId"
														id="loginId" value="${request.loginId}"
														placeholder="아이디 입력">
													<div class="input-group-append">
														<button class="btn btn-secondary" type="button"
															id="idCheck">중복확인</button>
													</div>
												</div>
												<input type="hidden" id="idCheckResult" value="false">
												<small id="idCheckMessage" class="form-text text-muted"></small>
											</div>

											<div class="col-md-4 mb-3">
												<label>비밀번호</label> <input id="password" name="password"
													type="password" class="form-control readonly-box"
													placeholder="비밀번호 입력">
											</div>

											<div class="col-md-4 mb-3">
												<label>비밀번호 확인</label> <input id="passwordCheck"
													type="password" class="form-control readonly-box"
													placeholder="비밀번호 확인"> <small
													id="passwordCheckMessage" class="form-text text-muted"></small>
											</div>
										</div>
										<!-- row끝 -->
										<!-- 권한 요청 start-->
										<div id="authFieldsContainer" class="row">
											<div class="col-md-6 mb-3 auth-field-group" data-index="0">
												<label>요청 권한</label>
												<div class="input-group">
													<!--권한 리스트 -->
													<select class="form-control auth-select authorityId"
														name="authorityIds" required>
														<option value="">-- 권한 선택 --</option>
														<c:forEach var="auth" items="${authList}">
															<option value="${auth.authorityId}">${auth.authorityName}</option>

														</c:forEach>
													</select>

													<div class="input-group-append">
														<button class="btn btn-success btn-add-auth" type="button">+</button>
													</div>

												</div>
												<small id="authMessage" class="form-text text-muted"></small>
											</div>
										</div>
										<!-- 권한 요청 end-->

									</div>




									<div class="d-flex justify-content-between mb-4 ml-4 mr-4">
										<a href="${pageContext.request.contextPath}/login"
											class="btn btn-light"> <i class="fas fa-arrow-left mr-1"></i>
											홈으로 가기
										</a>

										<div>
											<button type="submit" class="btn btn-primary" id="btnApprove">
												<i class="fas fa-check mr-1"></i> 신청
											</button>
										</div>
									</div>
								</div>
							</form>
						</div>

					</div>
				</div>

			</div>
			<!-- /.container-fluid -->
		</div>
		<!-- /#content -->

		<%@ include file="/WEB-INF/views/common/footer.jsp"%>
	</div>
	<!-- /#content-wrapper -->

	<!-- /#wrapper -->

<script>
$(document).ready(function () {
  // ---------------- 요소 캐시 ----------------
  const $form = $('#requestForm');

  // 아이디
  const $loginId = $('#loginId');
  const $idCheckMessage = $('#idCheckMessage');
  const $idCheckResult = $('#idCheckResult');

  // 패스워드
  const $password = $('#password');
  const $passwordCheck = $('#passwordCheck');
  const $passwordCheckMessage = $('#passwordCheckMessage');

  // 기관/부서
  const $instId = $('#instId');
  const $deptId = $('#deptId');
  const $deptMessage = $('#deptMessage');

  // 권한 컨테이너
  const $container = $('#authFieldsContainer');
  const $authMessage = $('#authMessage');

  // ---------------- 옵션 베이스 HTML ----------------
  // 플레이스홀더로 안전 시작 후, 페이지가 서버에서 옵션을 내려줬다면 그걸로 덮어쓰기
  let authOptionsHtml = '<option value="">-- 권한 선택 --</option>';
  const firstAuthHtml = $container.find('.auth-select').first().html();
  if (firstAuthHtml && firstAuthHtml.trim()) {
    authOptionsHtml = firstAuthHtml;
  }

  // ---------------- 유틸 ----------------
  function getUsedAuthIds() {
    const ids = [];
    $container.find('.auth-select').each(function () {
      const v = $(this).val();
      if (v) ids.push(v);
    });
    return ids;
  }

  function updateAllAuthOptions() {
	  //  현재 선택된 값들 중 빈값('') 제외
	  const used = getUsedAuthIds().filter(v => v !== '');

	  $container.find('.auth-select').each(function () {
	    const $sel = $(this);
	    const current = $sel.val() || '';

	    // 최신 전체 옵션으로 리셋
	    $sel.html(authOptionsHtml);

	    // 다른 필드에서 사용 중인 값은 제거 
	    used.forEach(id => {
	      if (id && id !== current) {
	        $sel.find(`option[value="${id}"]`).remove();
	      }
	    });

	    //("-- 권한 선택 --")는 유지
	    if ($sel.find('option[value=""]').length === 0) {
	      $sel.prepend('<option value="">-- 권한 선택 --</option>');
	    }

	    // 현재 선택값 복원 (없으면 placeholder)
	    if (current && $sel.find(`option[value="${current}"]`).length > 0) {
	      $sel.val(current);
	    } else {
	      $sel.val('');
	    }
	  });
	}


  function reorderAuthLabels() {
    $container.find('.auth-field-group').each(function () {
      $(this).find('label').text('요청 권한');
    });

    const $groups = $container.find('.auth-field-group');

    // 모든 + 제거, - 로 통일
    $groups.find('.btn-add-auth').remove();
    $groups.find('.btn-remove-auth')
      .removeClass('btn-success btn-add-auth')
      .addClass('btn-danger btn-remove-auth')
      .text('-');

    // 마지막 그룹에만 + 버튼
    const $last = $groups.last();
    $last.find('.input-group-append').html(
      '<button class="btn btn-success btn-add-auth" type="button">+</button>'
    );
  }

  const authFieldTemplate = `
    <div class="col-md-6 mb-3 auth-field-group">
      <label>요청 권한</label>
      <div class="input-group">
        <select class="form-control auth-select authorityId" name="authorityIds" required></select>
        <div class="input-group-append">
          <button class="btn btn-danger btn-remove-auth" type="button">-</button>
        </div>
      </div>
    </div>
  `;

  // ---------------- 권한 동적 추가/삭제/변경 ----------------
  $container.on('click', '.btn-add-auth', function () {
    // 기존 + 들은 - 로
    $container.find('.btn-add-auth')
      .removeClass('btn-success btn-add-auth')
      .addClass('btn-danger btn-remove-auth')
      .text('-');

    // 새 필드 추가
    const $new = $(authFieldTemplate);
    const $newSel = $new.find('.auth-select');
    $newSel.html(authOptionsHtml).val(''); 
    $container.append($new);
    console.log('새로 추가된 셀렉트의 권한 목록:');
    $newSel.find('option').each(function () {
      console.log('  option value:', $(this).val(), 'text:', $(this).text());
    });

    reorderAuthLabels();
    updateAllAuthOptions();
  });

  $container.on('click', '.btn-remove-auth', function () {
    $(this).closest('.auth-field-group').remove();
    reorderAuthLabels();
    updateAllAuthOptions();
  });

  $container.on('change', '.auth-select', function () {
    updateAllAuthOptions();
  });

  // ---------------- 기관 선택 → 부서 목록 ----------------
  $instId.on('change', function () {
    const instVal = ($instId.val() || '').trim();

    $deptId.empty().append('<option value="">-- 부서 선택 --</option>');
    $deptMessage.text('');

    if (!instVal) {
      $deptMessage.text('기관을 선택해주세요.').css('color', 'red');
      return;
    }

    $.ajax({
      url: '${pageContext.request.contextPath}/signup/getDeptList',
      type: 'GET',
      data: { instId: instVal },
      dataType: 'json',
      success: function (list) {
        if (list && list.length > 0) {
          $.each(list, function (_i, dept) {
            $deptId.append(
              $('<option>', { value: dept.deptId, text: dept.deptName })
            );
          });
        } else {
          $deptMessage.text('해당 기관에 등록된 부서가 없습니다.').css('color', 'red');
        }
      },
      error: function (_xhr, _st, err) {
        $deptMessage.text('부서 목록을 불러오지 못했습니다: ' + err).css('color', 'red');
      }
    });
  });

  // ---------------- 부서 선택 → 권한 목록 ----------------
  $deptId.on('change', function () {
    const deptVal = ($deptId.val() || '').trim();

    // 모든 권한 셀렉트 초기화
    $container.find('.auth-select').each(function () {
      $(this).empty().append('<option value="">-- 권한 선택 --</option>');
    });
    $authMessage.text('');

    if (!deptVal) {
      $authMessage.text('부서를 선택해주세요.').css('color', 'red');
      // 부서 미선택 시에도 플레이스홀더 상태 유지
      return;
    }

    $.ajax({
      url: '${pageContext.request.contextPath}/signup/getAuthList',
      type: 'GET',
      data: { deptId: deptVal },
      dataType: 'json',
      success: function (list) {
        if (list && list.length > 0) {
          let newOptions = '<option value="">-- 권한 선택 --</option>';
          $.each(list, function (_i, auth) {
        	  console.log(auth);
            // 오타 주의: auth.authorityId / auth.authorityName
         	  newOptions += '<option value="' + auth.authorityId + '">' + auth.authorityName + '</option>';
         	  console.log(auth.authorityId);
          });

          // 최신 전체 옵션 저장
          authOptionsHtml = newOptions;

          // 모든 권한 셀렉트에 새 옵션 적용 + 플레이스홀더
          $container.find('.auth-select').each(function () {
            $(this).html(authOptionsHtml).val('');
          });

          // 그 다음 중복 제거 로직 적용
          updateAllAuthOptions();
        } else {
          $authMessage.text('해당 부서에 등록된 권한이 없습니다.').css('color', 'red');
          authOptionsHtml = '<option value="">-- 권한 선택 --</option>';
          $container.find('.auth-select').each(function () {
            $(this).html(authOptionsHtml).val('');
          });
        }
      },
      error: function (_xhr, _st, err) {
        $authMessage.text('권한 목록을 불러오지 못했습니다: ' + err).css('color', 'red');
      }
    });
  });

  // ---------------- 아이디 중복 확인 ----------------
  $('#idCheck').on('click', function () {
    const loginId = ($loginId.val() || '').trim();

    if (loginId.length < 4) {
      $idCheckMessage.text('아이디는 최소 4자 이상으로 합니다.').css('color', 'red');
      $idCheckResult.val('false');
      return;
    }

    $.ajax({
      url: '${pageContext.request.contextPath}/signup/checkID',
      type: 'GET',
      data: { loginId },
      success: function (res) {
        if (!res) {
          $idCheckMessage.text('사용 가능한 아이디입니다.').css('color', 'blue');
          $idCheckResult.val('true');
        } else {
          $idCheckMessage.text('사용 불가능한 아이디입니다.').css('color', 'red');
          $idCheckResult.val('false');
        }
      },
      error: function () {
        $idCheckMessage.text('서버 오류가 발생했습니다.').css('color', 'red');
        $idCheckResult.val('false');
      }
    });
  });

  $loginId.on('input', function () {
    $idCheckMessage.text('아이디 중복 확인이 필요합니다.').css('color', 'gray');
    $idCheckResult.val('false');
  });

  // ---------------- 비밀번호 확인 ----------------
  function syncPwMsg() {
    const p = ($password.val() || '').trim();
    const c = ($passwordCheck.val() || '').trim();
    if (p && c && p === c) {
      $passwordCheckMessage.text('비밀번호가 일치합니다.').css('color', 'blue');
    } else {
      $passwordCheckMessage.text('비밀번호가 일치하지 않습니다.').css('color', 'red');
    }
  }
  $password.on('input', syncPwMsg);
  $passwordCheck.on('input', syncPwMsg);

  // ---------------- 제출 전 검증 ----------------
  $form.on('submit', function (e) {
    if ($idCheckResult.val() !== 'true') {
      e.preventDefault();
      alert('아이디 중복 확인을 완료해주세요.');
      $loginId.focus();
      return;
    }

    if ($password.val() !== $passwordCheck.val()) {
      e.preventDefault();
      alert('비밀번호와 확인이 일치하지 않습니다.');
      $passwordCheck.focus();
      return;
    }

    // 권한 모두 선택했는지
    let ok = true;
    $container.find('.auth-select').each(function () {
      if (!$(this).val()) {
        ok = false;
        return false;
      }
    });
    if (!ok) {
      e.preventDefault();
      alert('요청 권한을 모두 선택해주세요.');
      return;
    }
  });

  // ---------------- 초기 정리 ----------------
  reorderAuthLabels();
  updateAllAuthOptions();
});
</script>

</body>
</html>