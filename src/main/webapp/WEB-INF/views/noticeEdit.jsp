<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:useBean id="now" class="java.util.Date" />

<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<title>공지사항 수정 | 결재24</title>
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
						<h1 class="h3 mb-0 text-gray-800">공지사항</h1>
					</div>

					<!-- 카드 -->
					<div class="card shadow mb-4">

						<!-- 상단 버튼 영역: 목록 / 저장 -->
						<div class="card-header py-3 d-flex align-items-center">
							<h6 class="m-0 font-weight-bold text-primary" style="line-height: 1.5;">공지사항 수정</h6>

						</div>


						<div class="card-body">
							<form id="updateNotice" method="post" action="<c:url value='/notice/update'/>" novalidate>
							<input type="hidden" name="noticeId" value="${notice.noticeId}">

								<div class="table-responsive">
									<table class="table table-bordered table-sm kv-table">
										<colgroup>
											<col style="width: 18%;">
											<col style="width: 32%;">
											<col style="width: 18%;">
											<col style="width: 32%;">
										</colgroup>
										<tbody>
											<!-- 제목 -->
											<tr>
												<th scope="col" class="text-dark bg-light font-weight-bold">제목</th>
												<td colspan="3"><input type="text" name="title" id="title"  value="${notice.title}" class="form-control form-control-sm" placeholder="공지 제목을 입력하세요" required maxlength="200"></td>
											</tr>

											<!-- 작성자 / 등록일 -->
											<tr>
												<th scope="col" class="text-dark bg-light font-weight-bold">작성자</th>
												<!-- 나중에 로그인 정보를 가져와 해당 유저의 insert -->
												<td><input type="text" class="form-control form-control-sm" value="${loginuserName}"  readonly>
														<input type="hidden" name="updateId" value="${sessionScope.user}"></td>
												<th scope="col" class="text-dark bg-light font-weight-bold">등록일</th>
												<td>
													<input type="text" class="form-control form-control-sm" value="<fmt:formatDate value='${now}' pattern='yyyy-MM-dd'/>" readonly>
												</td>
											</tr>

											<!-- 내용 -->
											<tr>
												<th scope="col" class="text-dark bg-light font-weight-bold">내용</th>
												<td colspan="3" class="content-cell"><textarea name="content" id="noticeContent"class="form-control" style="min-height: 300px;" placeholder="공지 내용을 입력하세요"  required>${notice.content}</textarea></td>
											</tr>

											<!-- 카테고리 선택 -->
											<tr>
												<th scope="col" class="text-dark bg-light font-weight-bold">카테고리 선택</th>
												<td colspan="3">
												<select class="form-control mr-2" id="complainCategoryId" name="complainCategoryId" style="min-width: 220px;">
													<option value="">전체</option>
														<c:forEach var="list" items="${categoryList}">
														<option value="${list.complainCategoryId}" <c:if test="${filter.complainCategoryId == list.complainCategoryId}">selected</c:if>>${list.categoryName}</option>
													</c:forEach>
												</select>
													
												</td>
											</tr>
										


										</tbody>
									</table>
								</div>
								<div class="d-flex justify-content-end">
								<button type="button" class="btn btn-primary btn-sm mr-4" id="btnSaveBottom">
									<i class="fas fa-save mr-1"></i>수정완료
								</button>
								<a href="${pageContext.request.contextPath}/noticedetail/${noticeId}" class="btn btn-danger btn-sm">
								<i class="fas fa-times-circle mr-1"></i>취소</a>
							</div>
							</form>

						</div>
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
document.addEventListener('DOMContentLoaded', function() {
    const btnSave = document.getElementById('btnSaveBottom');
    const form = document.getElementById('updateNotice');

    btnSave.addEventListener('click', function() {
        const title = document.getElementById('title').value.trim();
        const content = document.getElementById('noticeContent').value.trim();

        if (!title) {
            alert('제목을 입력하세요.');
            document.getElementById('title').focus();
            return;
        }
        if (!content) {
            alert('내용을 입력하세요.');
            document.getElementById('noticeContent').focus();
            return;
        }

        // 중복 제출 방지
        btnSave.disabled = true;

        // 정상 submit
        form.submit();
    });
});
</script>

</body>
</html>
