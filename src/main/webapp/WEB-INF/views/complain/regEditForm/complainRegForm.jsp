<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<title>민원 접수 등록 | 결재24</title>
<style>
.required::after {
	content: " *";
	color: #e74a3b;
}

.readonly-box {
	background: #f8f9fc;
}

.form-hint {
	font-size: .85rem;
	color: #858796;
}

.table th {
	width: 18%;
	background: #f8f9fc;
	vertical-align: middle;
}
</style>
</head>

<body id="page-top">
	<div id="wrapper">

		<%@ include file="/WEB-INF/views/common/sidebar.jsp"%>

		<div id="content-wrapper" class="d-flex flex-column">
			<div id="content">
				<%@ include file="/WEB-INF/views/common/navbar.jsp"%>

				<div class="container-fluid mb-4">

					<!-- Heading -->
					<div class="d-sm-flex align-items-center justify-content-between mb-4">
						<h1 class="h3 mb-0 text-gray-800">민원 접수 등록</h1>
					</div>

					<form id="loanApplyForm" method="post" action="${pageContext.request.contextPath}/complain/new">

						<div class="card shadow mb-4">
							<div class="card-header py-3 d-flex align-items-center">
								<h6 class="m-0 font-weight-bold text-primary text-nowarp mr-4">민원 서식 선택</h6>
								<select id="complainCategoryId" name="complainCategoryId" class="form-control form-control-sm w-auto ml-4">
									<option value="">--신청하실 민원을 선택해주세요--</option>
									<c:forEach var="category" items="${categoryList}">
										<option value="${category.complainCategoryId}">${category.categoryName}</option>
									</c:forEach>
								</select>
							</div>
						</div>

						<%@ include file="/WEB-INF/views/complain/regEditForm/complainUserInfo.jsp"%>

						<div class="d-flex justify-content-between mt-4">
							<a href="${pageContext.request.contextPath}" class="btn btn-light"> <i class="fas fa-arrow-left mr-1"></i> 취소
							</a>
							<div>
								<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#submitModal">
									<i class="fas fa-paper-plane mr-1"></i> 신청
								</button>
							</div>
						</div>
					</form>
				</div>



			</div>
			<!-- /.container-fluid -->
		</div>
		<!-- /#content -->

		<%@ include file="/WEB-INF/views/common/footer.jsp"%>
	</div>
	<!-- /#content-wrapper -->
	<!-- /#wrapper -->

	<%@ include file="/WEB-INF/views/common/logoutModal.jsp"%>

	<!-- Submit Modal -->
	<div class="modal fade" id="submitModal" tabindex="-1" role="dialog" aria-labelledby="submitModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="submitModalLabel">제출</h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">입력하신 내용으로 신청을 제출할까요?</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
					<button type="button" class="btn btn-primary" id="btnSubmitConfirm">제출</button>
				</div>
			</div>
		</div>
	</div>

	<script>
	document.addEventListener("DOMContentLoaded", function () {
		  const submitBtn = document.getElementById("btnSubmitConfirm");
		  const form = document.getElementById("loanApplyForm");

		  submitBtn.addEventListener("click", function () {
		    const inputs = form.querySelectorAll("input, select, textarea");
		     for (const el of inputs) {
		      if (!el.value.trim()) {
		        alert("필수 정보를 모두 입력해주세요.");
		        el.focus();
		        return;
		      }
		    }
		    form.submit();
		  });
		});
	</script>

</body>
</html>