<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<meta charset="UTF-8">
<title>북마크 등록</title>
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

	<!-- Page Wrapper -->
	<div id="wrapper">

		<!-- Sidebar -->
		<%@ include file="/WEB-INF/views/common/sidebar.jsp"%>

		<!-- Content Wrapper -->
		<div id="content-wrapper" class="d-flex flex-column">
			<!-- Main Content -->
			<div id="content">
				<!-- Topbar -->
				<%@ include file="/WEB-INF/views/common/navbar.jsp"%>
				<!-- Begin Page Content -->
				<div class="container-fluid">

					<h1 class="h3 mb-2 text-gray-800">새 북마크 등록</h1>

					<form action="/approval24/bookmark/create" method="post" id="bookmarkForm">
						<div class="card shadow mb-4">
							<div class="card-header py-3 d-flex align-items-center justify-content-between">
								<h6 class="m-0 font-weight-bold text-primary" style="line-height: 1.5;">새 북마크 등록</h6>
							</div>
							<div class="card-body">
								<!-- 북마크 이름 입력 -->
								<div class="d-flex align-items-center mb-3">
									<h5 class="mb-0 mr-4" style="width: 120px;">북마크 이름</h5>
									<input type="text" class="form-control form-control-sm w-50" name="bookmarkName" placeholder="북마크이름을 입력하세요" required>
								</div>

								<input type="hidden" id="accountId" name="accountId" value="${session.user}">

								<!-- 부서 선택 -->
								<div class="d-flex align-items-center mb-4">
									<h5 class="mb-0 mr-4" style="width: 120px;">부서 선택</h5>
									<select id="deptSelect" class="form-select text-dark w-auto" style="min-width: 260px; text-align: center; text-align-last: center;">
										<option value="">-- 부서를 선택하세요 --</option>
										<c:forEach var="dept" items="${depts}">
											<option value="${dept.deptId}">${dept.deptName}</option>
										</c:forEach>
									</select>
								</div>

								<!-- 좌우 2열 영역 -->
								<div class="row">
									<!-- 왼쪽: 계정 목록 -->
									<div class="col-md-6 mb-3">
										<div class="card h-100">
											<div class="card-header py-2">
												<strong>계정 목록</strong>
											</div>
											<div class="card-body p-2">
												<div id="accountList" class="overflow-auto" style="max-height: 360px;"></div>
											</div>
										</div>
									</div>

									<!-- 오른쪽: 선택된 결재 경로 -->
									<div class="col-md-6 mb-3">
										<div class="card h-100">
											<div class="card-header py-2 d-flex align-items-center justify-content-between">
												<strong>선택된 결재 경로</strong>
												<!-- 선택사항: 전체 초기화 버튼 -->
												<!-- <button type="button" class="btn btn-sm btn-outline-secondary" id="btnClearApprovers">초기화</button> -->
											</div>
											<div class="card-body p-2">
												<div id="selectedApprovers">
													<!-- JS에서 ul#approverList가 채워짐 -->
												</div>
											</div>
										</div>
									</div>
								</div>

								<div style="text-align: right;">
									<button type="submit" class="btn btn-primary">북마크 저장</button>
									
								</div>
							</div>
					</form>
					<a href="/approval24/bookmark/list"><button class="btn btn-danger">취소</button></a>
				</div>
				<!-- /.container-fluid -->
			</div>
			<!-- End of Main Content -->



		</div>
		<!-- End of Content Wrapper -->

	</div>
	<!-- End of Page Wrapper -->

	<!-- Scroll to Top Button-->
	<a class="scroll-to-top rounded" href="#page-top"> <i class="fas fa-angle-up"></i>
	</a>
	<!-- Logout Modal-->
	<%@ include file="/WEB-INF/views/common/logoutModal.jsp"%>

	<!-- footer 영역 -->
	<%@ include file="/WEB-INF/views/common/footer.jsp"%>
	<script>
		// 1. 부서 선택 시 해당 부서의 계정 목록을 불러오는 AJAX
		$('#deptSelect')
				.on(
						'change',
						function() {
							var deptId = $(this).val();
							if (deptId) {
								$
										.ajax({
											url : '/approval24/bookmark/accounts', // 컨트롤러의 @PostMapping("/accounts") 매핑
											type : 'POST',
											data : {
												deptId : deptId
											},
											dataType: 'json',  
											success : function(accounts) {
												let html = '<ul class="list-group">';
												 const selectedIds = getSelectedIds(); 
												if (accounts.length > 0) {
													$
															.each(
																	accounts,
																	function(i,
			 																acc) {
																	      const disabled = selectedIds.has(String(acc.accountId));
																	      const label = disabled ? '추가됨' : '추가';
																	      const disAttr = disabled ? 'disabled' : '';
																		
																	      html += `
																	          <li class="list-group-item d-flex justify-content-between align-items-center">
																	            <span class="text-dark">
																	              \${acc.userName} <small class="text-muted">(\${acc.deptName})</small>
																	            </span>
																	            <button type="button" class="btn btn-sm btn-outline-primary js-add-approver"
																	                    data-id="\${acc.accountId}" data-name="\${acc.userName}" \${disAttr}>
																	              \${label}
																	            </button>
																	          </li>`;
																	}); 
												} else {
													html += '<li>해당 부서에 활성 계정이 없습니다.</li></ul>';
												}
												html += '</ul>';
												$('#accountList').html(html);
											},
											error : function() {
												alert('계정 목록을 불러오는 데 실패했습니다.');
											}
										});
							} else {
								$('#accountList').empty();
							}
						});
		
		function ensureApproverList() {
			  if ($('#approverList').length === 0) {
			    $('#selectedApprovers').html('<ul class="list-group" id="approverList"></ul>');
			  }
			}

			function getSelectedIds() {
			  const set = new Set();
			  $('#approverList li').each(function() {
			    const id = String($(this).data('account-id'));
			    if (id) set.add(id);
			  });
			  return set;
			}

			function reindexApprovers() {
			  $('#approverList li').each(function(i) {
			    const order = i + 1;
			    $(this).attr('id', 'appr_' + order);
			    $(this).find('.order').text(order);
			    // hidden name 인덱스 재설정
			    $(this).find('input.seq')
			      .val(order)
			      .attr('name', `approvers[${i}].seqNo`);
			    $(this).find('input.hid-approverId')
			      .attr('name', `approvers[${i}].approverId`);
			    $(this).find('input.hid-type')
			      .attr('name', `approvers[${i}].approverTypeCd`);
			    $(this).find('input.hid-del')
			      .attr('name', `approvers[${i}].delYn`);
			  });
			}

		// 2. '추가' 버튼 클릭 시 결재자 목록에 추가
function addApprover(accountId, approverName) {
  ensureApproverList();

  // 이미 선택돼 있으면 무시
  if (getSelectedIds().has(String(accountId))) return;

  const currentIdx = $('#approverList li').length; // 0-based
  const order = currentIdx + 1;

  const liHtml = `
    <li id="appr_\${order}" class="list-group-item d-flex justify-content-between align-items-center"
        data-account-id="\${accountId}">
      <span class="text-dark fw-bold">순서 <span class="order">\${order}</span> : \${approverName}</span>
      <div class="d-flex align-items-center">
        <input type="hidden" class="seq" name="approvers[\${currentIdx}].seqNo" value="\${order}">
        <input type="hidden" class="hid-approverId" name="approvers[\${currentIdx}].approverId" value="\${accountId}">
        <input type="hidden" class="hid-type" name="approvers[\${currentIdx}].approverTypeCd" value="AP01">
        <input type="hidden" class="hid-del" name="approvers[\${currentIdx}].delYn" value="N">
        <button type="button" class="btn btn-warning btn-sm ml-3 js-remove-approver">제거</button>
      </div>
    </li>`;

  $('#approverList').append(liHtml);
}

// 계정 리스트 "추가" 버튼
$('#accountList').on('click', '.js-add-approver', function () {
  const accountId = String($(this).data('id'));
  const approverName = $(this).data('name');

  addApprover(accountId, approverName);

  // 중복 추가 방지 (선택됨 표기)
  $(this).prop('disabled', true).text('추가됨');
});

// ---------- 제거 ----------
$('#selectedApprovers').on('click', '.js-remove-approver', function () {
  const $li = $(this).closest('li');
  const accountId = String($li.data('account-id'));

  // li 제거
  $li.remove();

  // 같은 계정의 "추가" 버튼 다시 활성화
  $('#accountList .js-add-approver[data-id="' + accountId + '"]')
    .prop('disabled', false)
    .text('추가');

  // 순번/name 재정렬
  reindexApprovers();

  // 모두 없어지면 비우기(선택)
  if ($('#approverList li').length === 0) {
    $('#selectedApprovers').empty();
  }
});

<c:if test="${not empty errorMsg}">
alert('${errorMsg}');
</c:if>
	</script>
</body>
</html>