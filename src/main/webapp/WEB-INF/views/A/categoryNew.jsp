<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:useBean id="now" class="java.util.Date" />

<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<title>민원서식 등록 | 결재24</title>
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
						<h1 class="h3 mb-0 text-gray-800">민원서식 등록</h1>
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
							<form id="categoryInsertForm" action="/approval24/category/new" method="post">
							

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
												<th scope="col" class="text-dark bg-light font-weight-bold text-center">민원서식명</th>
												<td colspan="3"><input type="text" name="categoryName" id="categoryName" class="form-control form-control-sm" required maxlength="200"></td>
											</tr>
											<tr>
												<th scope="col" class="text-dark bg-light font-weight-bold text-center">유형코드</th>
												<td colspan="1"><input type="text" name="categoryCd" id="categoryCd" class="form-control form-control-sm" required maxlength="200"></td>
												<th scope="col" class="text-dark bg-light font-weight-bold text-center">처리소요일</th>
												<td colspan="1"><input type="text" name="dueDt" id="dueDt" class="form-control form-control-sm" placeholder="숫자만 입력하세요." required maxlength="200"></td>
											</tr>
											
											<tr>	
												<th class="text-dark bg-light font-weight-bold text-center">서식 URL</th>
												<td colspan="3"><input type="tel" class="form-control form-control-sm"
													name="categoryUrl"></td>
											</tr>
											<!-- 소속 부서 체크박스 -->
						                      <tr>
						                        <th class="text-dark bg-light font-weight-bold text-center">소속 부서</th>
						                        <td colspan="3">
						                          <div style="display:flex; flex-wrap:wrap; gap:8px 16px; line-height:1.8;">
						                            <c:forEach var="dept" items="${getAllDept}">
						                              <label class="d-inline-flex align-items-center mb-1">
						                                <input type="checkbox"
						                                       name="deptIds"
						                                       value="${dept.deptId}"
						                                       class="mr-1" />
						                                ${dept.deptName}
						                              </label>
						                            </c:forEach>
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
						<a href="${pageContext.request.contextPath}/category" class="btn btn-light"> <i class="fas fa-arrow-left mr-1"></i> 취소</a>
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

$(document).ready(function() {

  // 저장 버튼 클릭
  $('#btnSaveTop').on('click', function(e) {
    e.preventDefault();

    const form = document.getElementById('categoryInsertForm');
    const code = $('#categoryCd').val().trim();

    if (!form.checkValidity()) {
      form.reportValidity();
      return;
    }

    if (!code) {
      alert('유형코드를 입력하세요.');
      $('#categoryCd').focus();
      return;
    }

    if (!confirm('작성된 내용을 등록하시겠습니까?')) {
      return;
    }

    // 공통코드 존재 여부 AJAX 확인
    $.ajax({
      url: '/approval24/totalcode/check', // Controller에서 codeId 존재 여부 리턴하는 매핑
      type: 'GET',
      data: { codeId: code },
      success: function(exists) {
        if (exists) {
          // 존재하면 등록 수행
          $('#categoryInsertForm')[0].submit();
        } else {
          // 없으면 경고창
          alert('입력한 유형코드는 공통코드에 존재하지 않습니다.');
          $('#categoryCd').focus();
        }
      },
      error: function() {
        alert('코드 확인 중 오류가 발생했습니다.');
      }
    });
  });

});
</script>

</body>
</html>
