<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:useBean id="now" class="java.util.Date" />

<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<title>담당자배정 등록 | 결재24</title>
<style>
/* 표 기반(딱딱한) 작성 레이아웃 */
.kv-table th {
	width: 140px;
	background: #f8f9fc;
	vertical-align: middle;
}

.kv-table td {
	background: #fff;
}

/* 상세와 동일한 룩앤필 유지 */
.kv-table .content-cell {
	white-space: pre-wrap;
	line-height: 1.6;
	min-height: 300px; /* 상세와 동일한 최소 높이 */
}

/* 파일 리스트 UI 정리 */
.kv-table .attach-cell ul {
	margin: 0;
	padding-left: 1rem;
}

.kv-table .attach-cell li+li {
	margin-top: .25rem;
}
</style>
</head>
<body id="page-top">

	<div id="wrapper">
		<!-- Sidebar -->
		<%@ include file="/WEB-INF/views/common/sidebar.jsp"%>
		<!-- End of Sidebar -->

		<!-- Content Wrapper -->
		<div id="content-wrapper" class="d-flex flex-column">

			<!-- Main Content -->
			<div id="content">
				<!-- Topbar -->
				<%@ include file="/WEB-INF/views/common/navbar.jsp"%>
				<!-- End of Topbar -->

				<!-- Begin Page Content -->
				<div class="container-fluid">

					<!-- 상단 제목/버튼 -->
					<div class="d-sm-flex align-items-center justify-content-between mb-3">
						<h1 class="h3 mb-0 text-gray-800">담당자배정 등록</h1>
					</div>

					<!-- 카드 -->
					<div class="card shadow mb-4">

						<!-- 상단 버튼 영역: 등록 -->
						<div class="card-header py-3 d-flex align-items-center">
							<h6 class="m-0 font-weight-bold text-primary" style="line-height: 1.5;">작성 항목</h6>
							<div class="ml-auto">
								<button type="button" class="btn btn-primary btn-sm" id="btnSaveTop">
									<i class="fas fa-save mr-1"></i>등록
								</button>
							</div>

						</div>


						<div class="card-body">
							<form id="managerAssignmentForm" action="/approval24/MA/new" method="post">
							<input type="hidden" id="instId" name="instId" value="${instName.instId}">

								<div class="table-responsive">
									<table class="table table-bordered table-sm kv-table">
										<colgroup>
											<col style="width: 18%;">
											<col style="width: 32%;">
											<col style="width: 18%;">
											<col style="width: 32%;">
										</colgroup>
										<tbody>
											<tr>
											  <th class="text-dark bg-light font-weight-bold text-center align-middle">기관명</th>
											  <td colspan="3">
											  	<input type="text" name="instName" id="instName" class="form-control form-control-sm" value="${instName.instName}" readonly>
											  </td>
											</tr>
											<tr>
											  <th class="text-dark bg-light font-weight-bold text-center align-middle">부서명</th>
											  <td colspan="3">
											    <select name="deptId" id="deptId" class="form-control form-control-sm">
											      <option value="">-- 부서 선택 --</option>
											      <c:forEach var="dept" items="${deptByInst}">
											        <option value="${dept.deptId}"
											          <c:if test="${MAInfo.deptId == dept.deptId}">selected="selected"</c:if>>
											          ${dept.deptName}
											        </option>
											      </c:forEach>
											    </select>
											  </td>
											</tr>
											
											<tr>
											  <th class="text-dark bg-light font-weight-bold text-center align-middle">민원서식명</th>
											  <td colspan="3">
											    <select name="complainCategoryId" id="complainCategoryId" class="form-control form-control-sm">
											      <option value="">-- 민원서식 선택 --</option>
											      <c:forEach var="category" items="${categoryByDept}">
											        <option value="${category.complainCategoryId}"
											          <c:if test="${MAInfo.complainCategoryId == category.complainCategoryId}">selected="selected"</c:if>>
											          ${category.categoryName}
											        </option>
											      </c:forEach>
											    </select>
											  </td>
											</tr>
											
											<tr>
											  <th class="text-dark bg-light font-weight-bold text-center align-middle">사용자 이름</th>
											  <td>
											    <select name="userName" id="userNameSelect" class="form-control form-control-sm">
											      <option value="">-- 사용자 선택 --</option>
											    </select>
											  </td>
											
											  <th class="text-dark bg-light font-weight-bold text-center align-middle">로그인 ID</th>
											  <td>
											    <select name="accountId" id="accountId" class="form-control form-control-sm">
											      <option value="">-- 로그인계정 선택 --</option>
											    </select>
											  </td>
											</tr>

										</tbody>

									</table>
								</div>
							</form>


						</div>
					</div>
					<!-- 하단 버튼 -->
					<div class="d-flex justify-content-between mt-4">
						<a href="${pageContext.request.contextPath}/MA" class="btn btn-light"> <i class="fas fa-arrow-left mr-1"></i> 취소</a>
					</div>
				</div>
				<!-- /.container-fluid -->
			</div>
			<!-- End of Main Content -->

		</div>
		<!-- End of Content Wrapper -->
	</div>
	<!-- End of Page Wrapper -->

	<!-- Scroll to Top Button-->
	<a class="scroll-to-top rounded" href="#page-top"><i class="fas fa-angle-up"></i></a>

	<!-- Logout Modal -->
	<%@ include file="/WEB-INF/views/common/logoutModal.jsp"%>

	<!-- footer 영역 (JS) -->
	<%@ include file="/WEB-INF/views/common/footer.jsp"%>



<script>
$(function () {
	  const ctx = '${pageContext.request.contextPath}';
	  const $dept = $('#deptId');
	  const $cat  = $('#complainCategoryId');
	  const $acc  = $('#accountId');
	  const $user = $('#userNameSelect');

	  let accountListCache = [];

	  function loadDepts(instId, preselectDeptId) {
	    $dept.empty().append('<option value="">-- 부서 선택 --</option>');
	    $cat.empty().append('<option value="">-- 민원서식 선택 --</option>');
	    $acc.empty().append('<option value="">-- 로그인계정 선택 --</option>');
	    $user.empty().append('<option value="">-- 사용자 선택 --</option>');
	    accountListCache = [];

	    if (!instId) return;

	    $.getJSON(ctx + '/MA/depts', { inst_id: instId })
	      .done(function (list) {
	        (list || []).forEach(function (d) {
	          const sel = (preselectDeptId && String(preselectDeptId) === String(d.deptId)) ? ' selected' : '';
	          $dept.append('<option value="'+ d.deptId + '"' + sel + '>' + d.deptName + '</option>');
	        });

	        // 수정모드에서 부서가 이미 정해져 있으면, 하위(서식/계정)도 이어서 채움
	        if (preselectDeptId) {
	          $dept.trigger('change');
	        }
	      })
	      .fail(function (xhr, s, e) {
	        console.error('부서 로드 실패:', s, e, xhr.responseText);
	        alert('부서 목록을 불러오지 못했습니다.');
	      });
	  }

	  function fillAccountSelectByUser(userName) {
	    $acc.empty().append('<option value="">-- 로그인계정 선택 --</option>');
	    if (!userName) return;

	    const filtered = accountListCache.filter(function (a) {
	      return a.userName === userName;
	    });

	    filtered.forEach(function (a) {
	      const sel = (initAccId && String(initAccId) === String(a.accountId)) ? ' selected' : '';
	      $acc.append(
	        '<option value="'+ a.accountId + '"' + sel + '>' +
	        a.loginId +
	        '</option>'
	      );
	    });
	  }

	  // 초기 1회: hidden instId로 부서 로드
	  const initInstId  = $('#instId').val();                  // hidden에서 읽음
	  const initDeptId  = '${MAInfo != null ? MAInfo.deptId : ""}';
	  const initCatId   = '${MAInfo != null ? MAInfo.complainCategoryId : ""}';
	  const initAccId   = '${MAInfo != null ? MAInfo.accountId : ""}';
	  const initUserName= '${MAInfo != null ? MAInfo.userName : ""}';

	  if (initInstId) {
	    loadDepts(initInstId, initDeptId);
	  }

	  // 기존 기관부서 변경 → 서식/사용자 로드
	  $('#deptId').on('change', function () {
	    const deptId = $(this).val();

	    // 서식
	    $.getJSON(ctx + '/MA/categories', { dept_id: deptId })
	      .done(function (list) {
	        $cat.empty().append('<option value="">-- 민원서식 선택 --</option>');
	        (list || []).forEach(function (c) {
	          const sel = (initCatId && String(initCatId) === String(c.complainCategoryId)) ? ' selected' : '';
	          $cat.append('<option value="'+ c.complainCategoryId + '"' + sel + '>' + c.categoryName + '</option>');
	        });
	      });

	    // 계정
	    const instId = $('#instId').val();
	    $.getJSON(ctx + '/MA/accounts', { inst_id: instId, dept_id: deptId })
	      .done(function (list) {
	        accountListCache = list || [];

	        $user.empty().append('<option value="">-- 사용자 선택 --</option>');
	        const userNameSet = new Set();
	        accountListCache.forEach(function (a) {
	          if (a.userName) {
	            userNameSet.add(a.userName);
	          }
	        });

	        Array.from(userNameSet).forEach(function (name) {
	          const sel = (initUserName && String(initUserName) === String(name)) ? ' selected' : '';
	          $user.append('<option value="'+ name + '"' + sel + '>' + name + '</option>');
	        });

	        $acc.empty().append('<option value="">-- 로그인계정 선택 --</option>');

	        if (initUserName) {
	          fillAccountSelectByUser(initUserName);
	        }
	      });
	  });

	  $user.on('change', function () {
	    const selectedName = $(this).val();
	    fillAccountSelectByUser(selectedName);
	  });

	  // 저장 버튼
	  $('#btnSaveTop').on('click', function (e) {
	    e.preventDefault();
	    const form = document.getElementById('managerAssignmentForm');
	    if (!form.checkValidity()) { form.reportValidity(); return; }
	    if (confirm('작성된 내용을 등록하시겠습니까?')) $('#managerAssignmentForm').submit();
	  });
	});


</script>

</body>
</html>
