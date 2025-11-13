<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<title>권한 상세 및 메뉴/부서 관리 | 결재24</title>
<style>
.form-hint {
	font-size: .85rem;
	color: #858796;
}

.table th {
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
					<div class="d-sm-flex align-items-center mb-4">
						<h1 class="mb-2 text-gray-800">권한 상세</h1>
					</div>
					<div class="border-left-primary shadow mb-4" style="max-width: 600px;">
						<div class="card-header py-3">
							<div class="align-items-center mb-1">
								<h5>
									<strong class="text-primary">권한 번호 : </strong> ${authority.authorityId}
								</h5>
								<%-- <strong>설명:</strong> ${authority.description} <br> --%>
							</div>
							<div class="align-items-center mb-1">
								<h5>
									<strong  class="text-primary">권한명 : </strong> ${authority.authorityName}
								</h5>
							</div>
						</div>
					</div>

					<div class="card shadow mb-4">
						<div class="card-header py-3 d-flex align-items-center">
							<h2 class="m-0 font-weight-bold">할당된 메뉴 목록 관리</h2>
						</div>
						<div class="card-body">
							<div class="table-responsive">
								<table class="table table-bordered table-hover table-sm text-center align-middle">
									<colgroup>
										<col style="width: 7%">
										<col>
										<col style="width: 6%">
										<col style="width: 6%">
										<col style="width: 6%">
										<col style="width: 6%">
										<col style="width: 6%">
										<col style="width: 9%">
										<col style="width: 9%">
									</colgroup>
									<thead>

										<tr>
											<th>관리번호</th>
											<th>메뉴명</th>
											<th>조회</th>
											<th>등록</th>
											<th>수정</th>
											<th>삭제</th>
											<th>승인</th>
											<th>업데이트</th>
											<th>제거</th>
										</tr>
									</thead>

									<tbody>
										<c:forEach var="am" items="${authorityMenus}" varStatus="loopStatus">
											<tr>
												<td>${am.menuId}</td>
												<td class="text-left pl-3">${am.menuName}</td>
												<td><input type="checkbox" name="readYn" value="Y" ${am.readYn == 'Y' ? 'checked' : ''} form="updateForm_${loopStatus.index}"></td>
												<td><input type="checkbox" name="createYn" value="Y" ${am.createYn == 'Y' ? 'checked' : ''} form="updateForm_${loopStatus.index}"></td>
												<td><input type="checkbox" name="updateYn" value="Y" ${am.updateYn == 'Y' ? 'checked' : ''} form="updateForm_${loopStatus.index}"></td>
												<td><input type="checkbox" name="deleteYn" value="Y" ${am.deleteYn == 'Y' ? 'checked' : ''} form="updateForm_${loopStatus.index}"></td>
												<td><input type="checkbox" name="approveYn" value="Y" ${am.approveYn == 'Y' ? 'checked' : ''} form="updateForm_${loopStatus.index}"></td>
												<td>
													<form action="<c:url value='/authority/updateMenu'/>" method="post" id="updateForm_${loopStatus.index}" style="display: contents;">

														<input type="hidden" name="authorityId" value="${authority.authorityId}"> <input type="hidden" name="menuId" value="${am.menuId}">
														<button class="btn btn-primary btn-sm" type="submit">변경</button>
													</form>
												</td>
												<td>
													<form action="<c:url value='/authority/deleteMenu'/>" method="post" style="display: inline;">
														<input type="hidden" name="authorityId" value="${authority.authorityId}"> <input type="hidden" name="menuId" value="${am.menuId}"> <input class="btn btn-danger btn-sm" type="submit" value="제거" onclick="return confirm('${am.menuName} 메뉴를 제거하시겠습니까?');">
													</form>
												</td>
											</tr>
										</c:forEach>
										<c:if test="${empty authorityMenus}">
											<tr>
												<td colspan="9" style="text-align: center;">이 권한에 할당된 메뉴가 없습니다.</td>
											</tr>
										</c:if>
									</tbody>
								</table>
							</div>
						</div>
					</div>


					<div class="card shadow mb-4">
						<div class="card-header py-3 d-flex align-items-center">
							<h3 class="m-0 font-weight-bold">미할당 메뉴 등록</h3>
						</div>
						<div class="card-body">

							<c:if test="${empty unassignedMenus}">
								<p>새로 할당할 수 있는 메뉴가 없습니다.</p>
							</c:if>
							<c:if test="${not empty unassignedMenus}">

								<div class="table-responsive">
									<form action="<c:url value='/authority/addMenus'/>" method="post">
										<input type="hidden" name="authorityId" value="${authority.authorityId}">

										<table class="table table-bordered table-hover table-sm text-center align-middle">

											<colgroup>
												<col style="width: 6%">
												<col style="width: 7%">
												<col>
												<col style="width: 6%">
												<col style="width: 6%">
												<col style="width: 6%">
												<col style="width: 6%">
												<col style="width: 6%">

											</colgroup>
											<thead>
												<tr>
													<th>선택</th>
													<th>관리번호</th>
													<th>메뉴명</th>
													<th>조회</th>
													<th>등록</th>
													<th>수정</th>
													<th>삭제</th>
													<th>승인</th>
												</tr>
											</thead>
											<tbody>
												<c:forEach var="menu" items="${unassignedMenus}">
													<tr>
														<td><input type="checkbox" name="menuIds" value="${menu.menuId}"></td>
														<td>${menu.menuId}</td>
														<td class="text-left pl-3">${menu.menuName}</td>
														<td><input type="checkbox" name="readYn_${menu.menuId}" value="Y"></td>
														<td><input type="checkbox" name="createYn_${menu.menuId}" value="Y"></td>
														<td><input type="checkbox" name="updateYn_${menu.menuId}" value="Y"></td>
														<td><input type="checkbox" name="deleteYn_${menu.menuId}" value="Y"></td>
														<td><input type="checkbox" name="approveYn_${menu.menuId}" value="Y"></td>
													</tr>
												</c:forEach>
											</tbody>
										</table>
										<br>
										<div class="text-right">
											<button class="btn btn-primary text-right" type="submit" onclick="return confirm('선택한 메뉴들을 권한에 할당하시겠습니까?');">선택 메뉴 일괄 등록</button>
										</div>
									</form>
								</div>
							</c:if>

						</div>
					</div>
					<div class="row">

						<div class="col-lg-6">

							<div class="card shadow mb-4 h-100">
								<div class="card-header py-3 d-flex align-items-center">
									<h2 class="m-0 font-weight-bold">할당된 부서 목록 관리</h2>
								</div>
								<div class="card-body">
									<c:if test="${empty authorityDepartments}">
										<p>이 권한이 할당된 부서가 없습니다.</p>
									</c:if>
									<c:if test="${not empty authorityDepartments}">
										<div class="table-responsive">
											<table class="table table-bordered table-hover table-sm text-center align-middle">
												<colgroup>
													<col style="width: 20%;">
													<col style="width: 45%;">
													<col style="width: 35%;">

												</colgroup>
												<thead>
													<tr>
														<th>부서 관리번호</th>
														<th>부서명</th>
														<th>제거</th>
													</tr>
												</thead>
												<tbody>
													<c:forEach var="ad" items="${authorityDepartments}">
														<tr>
															<td>${ad.deptId}</td>
															<td>${ad.deptName}</td>
															<td>
																<form action="<c:url value='/authority/removeDepartment'/>" method="post" style="display: inline;">
																	<input type="hidden" name="authorityId" value="${authority.authorityId}"> <input type="hidden" name="deptId" value="${ad.deptId}"> <input class="btn btn-danger btn-sm" type="submit" value="제거" onclick="return confirm('${ad.deptName} 부서에서 이 권한을 제거하시겠습니까?');">
																</form>
															</td>
														</tr>
													</c:forEach>
												</tbody>
											</table>
										</div>
									</c:if>
								</div>
							</div>
						</div>
						<div class="col-lg-6">

							<div class="card shadow mb-4 h-100">
								<div class="card-header py-3 d-flex align-items-center">
									<h2 class="m-0 font-weight-bold">미할당 부서 등록</h2>
								</div>
								<div class="card-body">
									<c:if test="${empty unassignedDepartments}">
										<p>새로 할당할 수 있는 부서가 없습니다.</p>
									</c:if>
									<c:if test="${not empty unassignedDepartments}">
										<div class="table-responsive">
											<form action="<c:url value='/authority/addDepartments'/>" method="post">
												<input type="hidden" name="authorityId" value="${authority.authorityId}">
												<table class="table table-bordered table-hover table-sm text-center align-middle">
													<colgroup>
														<col style="width: 20%;">
														<col style="width: 20%;">
														<col style="width: 60%;">
													</colgroup>
													<thead>
														<tr>
															<th>선택</th>
															<th>부서 관리번호</th>
															<th>부서명</th>

														</tr>
													</thead>
													<tbody>
														<c:forEach var="dept" items="${unassignedDepartments}">
															<tr>
																<td><input type="checkbox" name="deptIds" value="${dept.deptId}"></td>
																<td>${dept.deptId}</td>
																<td>${dept.deptName}</td>

															</tr>
														</c:forEach>
													</tbody>
												</table>

												<br>
												<div class="text-right">
													<button class="btn btn-primary" type="submit" onclick="return confirm('선택한 부서들에 이 권한을 할당하시겠습니까?');">선택 부서 일괄 등록</button>
												</div>
											</form>
										</div>
									</c:if>
								</div>
							</div>
						</div>

					</div>

					<button class="btn btn-secondary" type="button" onclick="location.href='<c:url value="/authority/list"/>'">목록으로</button>
				</div>

			</div>
		</div>
	</div>
</body>
</html>