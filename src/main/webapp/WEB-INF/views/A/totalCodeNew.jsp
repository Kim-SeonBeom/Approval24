<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:useBean id="now" class="java.util.Date" />

<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<title>공통코드 등록 | 결재24</title>
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
						<h1 class="h3 mb-0 text-gray-800">공통코드 등록</h1>
					</div>
					<c:if test="${not empty errorMessage}">
					    <div class="alert alert-warning alert-dismissible fade show" role="alert">
					        ${errorMessage}
					        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
					            <span aria-hidden="true">&times;</span>
					        </button>
					    </div>
					</c:if>

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
							<form id="totalCodeInsertForm" action="/approval24/totalcode/new" method="post">
							

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
												<th scope="col" class="text-dark bg-light font-weight-bold text-center">코드그룹</th>
												<td colspan="1"><input type="text" name="groupId" id="groupId" class="form-control form-control-sm" placeholder="ex) A0" required maxlength="200"></td>
												<th scope="col" class="text-dark bg-light font-weight-bold text-center">코드</th>
												<td colspan="1"><input type="text" name="codeId" id="codeId" class="form-control form-control-sm" placeholder="ex) A001" required></td>
											</tr>

											<tr>
												<th class="text-dark bg-light font-weight-bold text-center">코드명</th>
												<td colspan="3"><input type="tel" class="form-control form-control-sm"
													name="codeName"></td>
											</tr>
											<tr>
												<th class="text-dark bg-light font-weight-bold text-center">코드내용</th>
												<td colspan="3"><input type="tel" class="form-control form-control-sm"
													name="codeDetail"></td>
											</tr>
											
										</tbody>
									</table>
								</div>
							</form>


						</div>
					</div>
					<!-- 하단 버튼 -->
					<div class="d-flex justify-content-between mt-4">
						<a href="${pageContext.request.contextPath}/totalcode" class="btn btn-light"> <i class="fas fa-arrow-left mr-1"></i> 취소</a>
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
    $('#btnSaveTop').on('click', function(e) {
        e.preventDefault();
        
        const form = document.getElementById('totalCodeInsertForm');
        
        // 브라우저 기본 유효성 검사
        if (!form.checkValidity()) {
            form.reportValidity(); 
            return; 
        }

        // 확인창 추가
        if (confirm('작성된 내용을 등록하시겠습니까?')) {
            $('#totalCodeInsertForm').submit();
        } else {
            return false; // 취소 시 아무 동작도 안 함
        }
    });
});
</script>

</body>
</html>
