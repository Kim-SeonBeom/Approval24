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
							<form id="managerAssignmentForm" action="/approval24/admin/MA/new" method="post">
							

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
											  <th class="text-dark bg-light font-weight-bold">기관명</th>
											  <td colspan="3">
											    <select name="instId" id="instId" class="form-control form-control-sm">
											      <option value="">-- 기관 선택 --</option>
											      <c:forEach var="inst" items="${getAllInst}">
											        <option value="${inst.instId}"
											          <c:if test="${MAInfo.instId == inst.instId}">selected="selected"</c:if>>
											          ${inst.instName}
											        </option>
											      </c:forEach>
											    </select>
											  </td>
											</tr>
											
											<tr>
											  <th class="text-dark bg-light font-weight-bold">부서명</th>
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
											  <th class="text-dark bg-light font-weight-bold">민원서식명</th>
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
												<th class="text-dark bg-light font-weight-bold">로그인ID</th>
												<td colspan="1">
												  <select name="accountId" id="accountId" class="form-control form-control-sm">
												    <option value="">-- 로그인계정 선택 --</option>
												    <c:forEach var="account" items="${accountByDept}">
												      <option value="${account.accountId}"
												        <c:if test="${MAInfo.accountId == account.accountId}">selected="selected"</c:if>>
												        ${account.loginId}
												      </option>
												    </c:forEach>
												  </select>
												</td>

												<th scope="col" class="text-dark bg-light font-weight-bold">사용자이름</th>
												<td colspan="1">
												  <select name="userName" id="userName" class="form-control form-control-sm">
												    <option value="">-- 사용자이름 --</option>
												    <c:forEach var="account" items="${accountByDept}">
												      <option value="${account.accountId}"
												        <c:if test="${MAInfo.accountId == account.accountId}">selected="selected"</c:if>>
												        ${account.userName}
												      </option>
												    </c:forEach>
												  </select>
												</td>
											</tr>

											<tr>
											  <th class="text-dark bg-light font-weight-bold">삭제여부</th>
											  <td colspan="6">
											    <div class="d-flex align-items-center" style="gap:16px;">
											      <label class="d-inline-flex align-items-center mb-0" for="delYnN">
											        <input type="radio" id="delYnN" name="delYn" value="N"
											          <c:if test="${MAInfo.delYn == 'N'}">checked="checked"</c:if> />
											        <span class="ml-1">사용</span>
											      </label>
											
											      <label class="d-inline-flex align-items-center mb-0" for="delYnY">
											        <input type="radio" id="delYnY" name="delYn" value="Y"
											          <c:if test="${MAInfo.delYn == 'Y'}">checked="checked"</c:if> />
											        <span class="ml-1">삭제</span>
											      </label>
											    </div>
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
						<a href="${pageContext.request.contextPath}/admin/MA" class="btn btn-light"> <i class="fas fa-arrow-left mr-1"></i> 취소</a>
					</div>
				</div>
				<!-- /.container-fluid -->
			</div>
			<!-- End of Main Content -->

			<!-- Footer -->
			<footer class="sticky-footer bg-white">
				<div class="container my-auto">
					<div class="copyright text-center my-auto">
						<span>Copyright &copy; Your Website 2020</span>
					</div>
				</div>
			</footer>
			<!-- End of Footer -->

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
$(document).ready(function() {
    $('#btnSaveTop').on('click', function(e) {
        e.preventDefault();
        
        const form = document.getElementById('managerAssignmentForm');
        
        // 브라우저 기본 유효성 검사
        if (!form.checkValidity()) {
            form.reportValidity(); 
            return; 
        }

        // 확인창 추가
        if (confirm('작성된 내용을 등록하시겠습니까?')) {
            $('#managerAssignmentForm').submit();
        } else {
            return false; // 취소 시 아무 동작도 안 함
        }
    });
});


$(function() {
  const ctx = '${pageContext.request.contextPath}';

  // 기관 변경 → 부서 로드
  $('#instId').on('change', function () {
    const instId = $(this).val();

    const $dept = $('#deptId').empty()
                 .append('<option value="">-- 부서 선택 --</option>');

    // 기관 미선택 시 클리어하고 종료
    if (!instId) return;

    $.getJSON(ctx + '/admin/MA/depts', { inst_id: instId })
      .done(function (list) {
        if (!list || !list.length) {
          // 예: $('#deptMsg').text('부서 없음');
          return;
        }
        list.forEach(function (d) {
          $dept.append($('<option>', { value: d.deptId, text: d.deptName }));
        });

        // 기관 변경 시, 하위 셀렉트 초기화
        $('#complainCategoryId').empty().append('<option value="">-- 민원서식 선택 --</option>');
        $('#accountId').empty().append('<option value="">-- 로그인계정 선택 --</option>');
        $('#userName').empty().append('<option value="">-- 사용자이름 --</option>');
      })
      .fail(function (xhr, status, err) {
        console.error('부서 로드 실패:', status, err, xhr.responseText);
        alert('부서 목록을 불러오지 못했습니다. (네트워크/권한/URL 확인)');
      });
  });

  // 부서 변경 → 서식/계정 로드
  $('#deptId').on('change', function () {
    const deptId = $(this).val();

    // 서식
    $.getJSON(ctx + '/admin/MA/categories', { dept_id: deptId })
      .done(function (list) {
        const $cat = $('#complainCategoryId').empty()
                      .append('<option value="">-- 민원서식 선택 --</option>');
        (list || []).forEach(function (c) {
          $cat.append($('<option>', { value: c.complainCategoryId, text: c.categoryName }));
        });
      })
      .fail(function (xhr, s, e) {
        console.error('category fail', s, e, xhr.responseText);
      });

    // 계정(로그인ID + 사용자이름 둘 다) 로드
    $.getJSON(ctx + '/admin/MA/accounts', { dept_id: deptId })
      .done(function (list) {
        const $acc  = $('#accountId').empty()
                       .append('<option value="">-- 로그인계정 선택 --</option>');
        const $user = $('#userName').empty()
                       .append('<option value="">-- 사용자이름 --</option>');

        (list || []).forEach(function (a) {
          // 로그인ID 셀렉트
          $acc.append($('<option>', {
            value: a.accountId,
            text: a.loginId
          }));
          // 사용자이름 셀렉트
          $user.append($('<option>', {
            value: a.accountId,
            text: a.userName
          }));
        });

        // 부서 바뀌면 두 셀렉트 동기 초기화
        $('#accountId').val('');
        $('#userName').val('');
      })
      .fail(function (xhr, s, e) {
        console.error('account fail', s, e, xhr.responseText);
      });
  });

  // 두 셀렉트 동기화 (같은 accountId 사용)
  $('#accountId').on('change', function() {
    $('#userName').val($(this).val());
  });
  $('#userName').on('change', function() {
    $('#accountId').val($(this).val());
  });
});

</script>

</body>
</html>
