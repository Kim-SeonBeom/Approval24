<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<meta charset="UTF-8">
<title>${bookmark.bookmarkName}상세|결재24</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<style>
.approver-box {
	border: 1px dashed #ccc;
	padding: 10px;
	margin-bottom: 10px;
}

.approver-list-item {
	margin-top: 5px;
	border: 1px solid #eee;
	padding: 5px;
}

.readonly-box {
	background: #f8f9fc;
}
</style>
</head>
<body id="page-top">

	<div id="wrapper">
		<%@ include file="/WEB-INF/views/common/sidebar.jsp"%>

		<div id="content-wrapper" class="d-flex flex-column">
			<div id="content">
				<%@ include file="/WEB-INF/views/common/navbar.jsp"%>

				<div class="container-fluid">
					<h1 class="h3 mb-3 text-gray-800">북마크 상세/수정</h1>

					<form id="bookmarkUpdateForm" action="/approval24/bookmark/approver/replace" method="post">

						<!-- 북마크 기본 정보 -->
						<div class="card shadow mb-4">
							<div class="card-header py-3 d-flex align-items-center justify-content-between">
								<h6 class="m-0 font-weight-bold text-primary">기본 정보</h6>
								<div>
									<button type="submit" class="btn btn-primary btn-sm">수정</button>
									<button type="submit" class="btn btn-danger btn-sm" id="btnDelete" name="delYn" value="Y" formaction="/approval24/bookmark/update" formmethod="post">삭제</button>
									<a href="/approval24/bookmark/list" class="btn btn-secondary btn-sm">목록</a>
								</div>
							</div>
							<div class="card-body">
								<div class="d-flex align-items-center mb-3">
									<h5 class="mb-0 mr-4" style="width: 120px;">북마크 이름</h5>
									<input type="text" class="form-control form-control-sm w-50" name="bookmarkName" value="${bookmark.bookmarkName}" required>
								</div>
								<input type="hidden" id="bookmarkId" name="bookmarkId" value="${bookmark.bookmarkId}">
							</div>
						</div>

						<!-- 좌우 2열: 계정 목록 / 선택된 결재 경로 -->
						<div class="row">
							<!-- 왼쪽: 부서 선택 + 계정 목록 -->
							<div class="col-md-6 mb-3">
								<div class="card h-100">
									<div class="card-header py-2 d-flex align-items-center justify-content-between">
										<strong>부서 선택</strong> <select id="deptSelect" class="form-select text-dark w-auto" style="min-width: 260px; text-align: center; text-align-last: center;">
											<option value="">-- 부서를 선택하세요 --</option>
											<c:forEach var="dept" items="${depts}">
												<option value="${dept.deptId}">${dept.deptName}</option>
											</c:forEach>
										</select>

									</div>

									<div class="card-body p-2">
										<div id="accountList" class="list-equal">
											<div class="text-muted small text-center">부서를 선택하면 계정 목록이 표시됩니다.</div>
										</div>
									</div>

								</div>
							</div>

							<!-- 오른쪽: 선택된 결재 경로 -->
							<div class="col-md-6 mb-3">
								<div class="card h-100">
									<div class="card-header py-2 d-flex align-items-center justify-content-between">
										<strong>선택된 결재 경로</strong>
									</div>
									<div class="card-body p-2 list-equal">
										<div id="selectedApprovers">
											<ul class="list-group" id="approverList">
												<!-- 기존 결재자 선반영 -->
												<c:forEach var="appr" items="${bookmark.approvers}" varStatus="st">
													<li id="appr_${st.index+1}" class="list-group-item d-flex justify-content-between align-items-center" data-account-id="${appr.approverId}"><span class="text-dark fw-bold"> 순서 <span class="order">${st.index+1}</span> : ${appr.approverName} <small class="text-muted">(${appr.deptName})</small> <c:if test="${not empty appr.approverTypeCdName}">
																<small class="text-muted">- ${appr.approverTypeCdName}</small>
															</c:if>
													</span>
														<div class="d-flex align-items-center">
															<input type="hidden" class="seq" name="approvers[${st.index}].seqNo" value="${st.index+1}"> <input type="hidden" class="hid-approverId" name="approvers[${st.index}].approverId" value="${appr.approverId}"> <input type="hidden" class="hid-type" name="approvers[${st.index}].approverTypeCd" value="${appr.approverTypeCd}"> <input type="hidden" class="hid-del" name="approvers[${st.index}].delYn" value="N">
															<button type="button" class="btn btn-warning btn-sm ml-3 js-remove-approver">제거</button>
														</div></li>
												</c:forEach>
											</ul>
										</div>
									</div>
								</div>
							</div>
						</div>
					</form>

				</div>
				<!-- /.container-fluid -->
			</div>
			<!-- /#content -->

			<%@ include file="/WEB-INF/views/common/logoutModal.jsp"%>
			<%@ include file="/WEB-INF/views/common/footer.jsp"%>
		</div>
		<!-- /#content-wrapper -->
	</div>
	<!-- /#wrapper -->

	<a class="scroll-to-top rounded" href="#page-top"><i class="fas fa-angle-up"></i></a>

	<script>
  // ================= 공통 유틸 =================
  function ensureApproverList() {
    if ($('#approverList').length === 0) {
      $('#selectedApprovers').html('<ul class="list-group" id="approverList"></ul>');
    }
  }

  function getSelectedIds() {
    const set = new Set();
    $('#approverList li').each(function () {
      const id = String($(this).data('account-id'));
      if (id && id !== 'undefined') set.add(id);
    });
    return set;
  }

  // 순번 + name 인덱스 + 타입(F002/F003/F004) 정리
  function reindexApprovers() {
    console.log("Reindexing Started");

    const $lis  = $('#approverList li');
    const total = $lis.length;

    $lis.each(function (i) {
      const index = i;      // 0-based
      const order = i + 1;  // 1-based

      // DOM id / 순서 텍스트
      $(this).attr('id', 'appr_' + order);
      $(this).find('.order').text(order);

      const namePrefix = 'approvers[' + index + ']';

      $(this).find('input.seq')
        .val(order)
        .attr('name', namePrefix + '.seqNo');
      $(this).find('input.hid-approverId')
        .attr('name', namePrefix + '.approverId');
      $(this).find('input.hid-type')
        .attr('name', namePrefix + '.approverTypeCd');
      $(this).find('input.hid-del')
        .attr('name', namePrefix + '.delYn');

      // ---- 타입 코드 세팅 (서비스 로직 규칙과 맞추기) ----
      let typeCd;

      if (total >= 3) {
        if (i === 0) {
          // 첫 번째: 담당자(F002)
          typeCd = 'F002';
        } else if (i === total - 1) {
          // 마지막: 승인자(F004)
          typeCd = 'F004';
        } else {
          // 중간: 검토자(F003)
          typeCd = 'F003';
        }
      } else {
        // 3명 미만이면 어차피 submit에서 막을 예정
        typeCd = 'F004';
      }

      $(this).find('input.hid-type').val(typeCd);
    });

    console.log("Reindexing Finished");
  }

  // 어떤 submit 버튼이 눌렸는지 기억
  let lastSubmitBtn = null;

  $('#bookmarkUpdateForm button[type="submit"]').on('click', function () {
    lastSubmitBtn = this;
  });

  // 폼 제출 시: 삭제/수정 구분 + 최소 3명 체크
  $('#bookmarkUpdateForm').on('submit', function (e) {
    // 1) 삭제 버튼이면 검증 스킵하고 그대로 전송
    if (lastSubmitBtn && $(lastSubmitBtn).attr('id') === 'btnDelete') {
      console.log('삭제 버튼으로 submit → 결재선 개수 체크 스킵');
      return true; // 그냥 서버로 보냄
    }

    // 2) 수정 버튼일 경우: 최소 3명 체크
    const count = $('#approverList li').length;
    if (count < 3) {
      alert('결재선은 최소 3명 이상 지정해야 합니다.');
      e.preventDefault();
      return false;
    }

    // 3) 순번/타입 재정렬 후 전송
    reindexApprovers();

    const formData = new FormData(this);
    console.log('--- 폼 제출 데이터 확인 시작 ---');
    for (let pair of formData.entries()) {
      console.log(pair[0] + ': ' + pair[1]);
    }
    console.log('--- 폼 제출 데이터 확인 종료 ---');
    // return true; // 생략하면 그냥 submit
  });

  // ================= 왼쪽: 부서 선택 → 계정 목록 로드 =================
  $('#deptSelect').on('change', function () {
    const deptId = $(this).val();

    if (!deptId) {
      $('#accountList').html('<div class="text-muted small text-center">부서를 선택하면 계정 목록이 표시됩니다.</div>');
      return;
    }

    // 로딩 인디케이터
    $('#accountList').html(
      '<div class="d-flex justify-content-center align-items-center" style="height:80px;">' +
      '  <div class="spinner-border text-primary" role="status">' +
      '    <span class="visually-hidden">Loading...</span>' +
      '  </div>' +
      '</div>'
    );

    $.ajax({
      url: '/approval24/bookmark/accounts',
      type: 'POST',
      data: { deptId: deptId },
      dataType: 'json',
      success: function (accounts) {
        let html = '<ul class="list-group">';
        const selectedIds = getSelectedIds();

        if (accounts && accounts.length) {
          accounts.forEach(function (acc) {
            var accountIdStr = String(acc.accountId || '');
            if (!accountIdStr) return;

            var disabled = selectedIds.has(accountIdStr);
            var label    = disabled ? '추가됨' : '추가';
            var disAttr  = disabled ? 'disabled' : '';

            html += ''
              + '<li class="list-group-item d-flex justify-content-between align-items-center">'
              + '  <span class="text-dark">'
              +        acc.userName + ' <small class="text-muted">(' + acc.deptName + ')</small>'
              + '  </span>'
              + '  <button type="button" class="btn btn-sm btn-outline-primary js-add-approver" '
              + '          data-id="' + accountIdStr + '" '
              + '          data-name="' + acc.userName + '" '
              + '          data-dept="' + acc.deptName + '" '
              +            disAttr + '>'
              +        label
              + '  </button>'
              + '</li>';
          });
        } else {
          html += '<li class="list-group-item text-muted">해당 부서에 활성 계정이 없습니다.</li>';
        }

        html += '</ul>';
        $('#accountList').html(html);
      },
      error: function (xhr, status, error) {
        console.error("계정 목록 로드 실패:", status, error, xhr.responseText);
        alert('계정 목록을 불러오는 데 실패했습니다.');
      }
    });
  });

  // ================= 결재자 추가/제거 =================
  function addApprover(accountId, approverName, deptName) {
    ensureApproverList();

    const approverIdStr = String(accountId);
    if (getSelectedIds().has(approverIdStr)) return;

    if (!approverIdStr || parseInt(approverIdStr, 10) === 0 || approverIdStr === 'undefined') {
      console.error("추가하려는 계정 ID가 유효하지 않습니다:", accountId);
      return;
    }

    const currentIdx = $('#approverList li').length;
    const order      = currentIdx + 1;

    const liHtml = ''
      + '<li id="appr_' + order + '" class="list-group-item d-flex justify-content-between align-items-center" '
      + '    data-account-id="' + approverIdStr + '">'
      + '  <span class="text-dark fw-bold">'
      + '    순서 <span class="order">' + order + '</span> : ' + approverName
      + '    <small class="text-muted">(' + (deptName || '') + ')</small>'
      + '  </span>'
      + '  <div class="d-flex align-items-center">'
      + '    <input type="hidden" class="seq" name="approvers[' + currentIdx + '].seqNo" value="' + order + '">'
      + '    <input type="hidden" class="hid-approverId" name="approvers[' + currentIdx + '].approverId" value="' + approverIdStr + '">'
      + '    <input type="hidden" class="hid-type" name="approvers[' + currentIdx + '].approverTypeCd" value="">'
      + '    <input type="hidden" class="hid-del" name="approvers[' + currentIdx + '].delYn" value="N">'
      + '    <button type="button" class="btn btn-warning btn-sm ml-3 js-remove-approver">제거</button>'
      + '  </div>'
      + '</li>';

    $('#approverList').append(liHtml);

    // 추가 직후에도 순번/타입 재정렬
    reindexApprovers();
  }

  // 왼쪽 계정 리스트: 추가 버튼
  $('#accountList').on('click', '.js-add-approver', function () {
    var $btn      = $(this);
    var accountId = $btn.attr('data-id');
    var name      = $btn.attr('data-name');
    var deptName  = $btn.attr('data-dept');

    console.log('Adding approver, accountId = ' + accountId);

    if (!accountId || accountId === 'undefined') {
      console.error('Critical: accountId attribute missing or empty!');
      return;
    }

    addApprover(accountId, name, deptName);

    $btn.prop('disabled', true).text('추가됨');
  });

  // 오른쪽: 제거 버튼
  $('#selectedApprovers').on('click', '.js-remove-approver', function () {
    var $li       = $(this).closest('li');
    var accountId = String($li.data('account-id'));

    $li.remove();

    // 왼쪽 목록의 같은 계정 "추가" 버튼 다시 활성화
    $('#accountList .js-add-approver[data-id="' + accountId + '"]')
      .prop('disabled', false)
      .text('추가');

    // 제거 후에도 순번/타입 재정렬
    reindexApprovers();

    if ($('#approverList li').length === 0) {
      $('#selectedApprovers').html('<ul class="list-group" id="approverList"></ul>');
    }
  });

  // 서버에서 에러 메시지 내려준 경우 알림
  <c:if test="${not empty errorMsg}">
  alert('${errorMsg}');
  </c:if>
</script>

</body>
</html>
