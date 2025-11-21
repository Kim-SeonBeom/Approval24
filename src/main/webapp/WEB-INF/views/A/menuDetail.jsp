<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
    <%@ include file="/WEB-INF/views/common/header.jsp"%>
    <title>메뉴 상세보기</title>
</head>
<body id="page-top">

	<div id="wrapper">
		<%@ include file="/WEB-INF/views/common/sidebar.jsp"%>
		<div id="content-wrapper" class="d-flex flex-column">
			<div id="content">
				<%@ include file="/WEB-INF/views/common/navbar.jsp"%>

				<div class="container-fluid">
					<h1 class="h3 mb-2 text-gray-800">메뉴 상세보기</h1>
					<br>

					<div class="card shadow mb-4">
						<div class="card-header py-3 d-flex justify-content-between align-items-center">
							<h6 class="m-0 font-weight-bold text-primary">${menu.menuName} 상세 정보</h6>
							
                            <div>
                                <a href="${pageContext.request.contextPath}/menu/edit/${menu.menuId}" class="btn btn-primary btn-sm mr-2">
                                    <i class="fas fa-edit mr-1"></i>수정
                                </a>
                                <button type="button" class="btn btn-danger btn-sm" onclick="confirmDelete(${menu.menuId})">
                                    <i class="fas fa-trash mr-1"></i>삭제
                                </button>
                            </div>
						</div>
						
						<div class="card-body">
                            
                            <table class="table table-bordered">
                                <tr>
									<th class="text-center w-25">메뉴 관리 번호 (ID)</th>
									<td class="text-center">${menu.menuId}</td>
								</tr>
								<tr>
									<th class="text-center w-25">메뉴명</th>
									<td class="text-center">
                                        <c:choose>
                                            <c:when test="${not empty menu.menuName}">${menu.menuName}</c:when>
                                            <c:otherwise>-</c:otherwise>
                                        </c:choose>
                                    </td>
								</tr>
								<tr>
									<th class="text-center w-25">상위 메뉴</th>
									<td class="text-center">
										<c:choose>
											<c:when test="${not empty menu.parentMenuName}">
                                                ${menu.parentMenuName} (${menu.parentMenuId})
											</c:when>
											<c:otherwise>
												<span class="text-secondary">최상위 메뉴 (-)</span>
											</c:otherwise>
										</c:choose>
									</td>
								</tr>
                                
                                <tr>
									<th class="text-center w-25">메뉴 URL</th>
									<td class="text-center">
                                        <c:choose>
                                            <c:when test="${not empty menu.menuUrl}">${menu.menuUrl}</c:when>
                                            <c:otherwise>-</c:otherwise>
                                        </c:choose>
                                    </td>
								</tr>
                                <tr>
									<th class="text-center w-25">메뉴 순서 (SEQ)</th>
									<td class="text-center">
                                        <c:choose>
                                            <c:when test="${menu.seq != null}">${menu.seq}</c:when>
                                            <c:otherwise>-</c:otherwise>
                                        </c:choose>
                                    </td>
								</tr>
                                
                                <tr>
									<th class="text-center w-25">팝업 여부 (POPUP_YN)</th>
									<td class="text-center">
                                        <c:choose>
                                            <c:when test="${menu.popupYn eq 'Y'}"><span class="badge badge-primary">팝업</span></c:when>
                                            <c:when test="${menu.popupYn eq 'N'}"><span class="badge badge-secondary">일반</span></c:when>
                                            <c:otherwise>-</c:otherwise>
                                        </c:choose>
                                    </td>
								</tr>
                                <tr>
									<th class="text-center w-25">사용 여부 (DEL_YN)</th>
									<td class="text-center">
                                        <c:choose>
                                            <c:when test="${menu.delYn eq 'N'}"><span class="badge badge-success">사용</span></c:when>
                                            <c:when test="${menu.delYn eq 'Y'}"><span class="badge badge-danger">미사용</span></c:when>
                                            <c:otherwise>-</c:otherwise>
                                        </c:choose>
                                    </td>
								</tr>

                                <tr>
									<th class="text-center w-25">생성일</th>
									<td class="text-center">
                                        <c:choose>
                                            <c:when test="${menu.createDt != null}"><fmt:formatDate value="${menu.createDt}" pattern="yyyy-MM-dd HH:mm" /></c:when>
                                            <c:otherwise>-</c:otherwise>
                                        </c:choose>
                                    </td>
								</tr>
								<tr>
									<th class="text-center w-25">수정일</th>
									<td class="text-center">
                                        <c:choose>
                                            <c:when test="${menu.updateDt != null}"><fmt:formatDate value="${menu.updateDt}" pattern="yyyy-MM-dd HH:mm" /></c:when>
                                            <c:otherwise>-</c:otherwise>
                                        </c:choose>
                                    </td>
								</tr>
							</table>

							<br>
							<a href="${pageContext.request.contextPath}/menu/list" class="btn btn-secondary">목록으로</a>
						</div>
					</div>

				</div>
			</div>
			<%@ include file="/WEB-INF/views/common/footer.jsp"%>
		</div>
	</div>

    <form id="deleteForm" action="${pageContext.request.contextPath}/menu/delete/${menu.menuId}" method="post"></form>

<script>
    /**
     * 삭제 버튼 클릭 시 확인 창을 띄우고 POST 요청을 전송합니다.
     */
    function confirmDelete(menuId) {
        if (confirm('정말로 메뉴 [ID: ' + menuId + ']를 삭제하시겠습니까?')) {
            // POST 요청으로 삭제를 처리하는 폼을 전송합니다.
            document.getElementById('deleteForm').submit();
        }
    }
</script>
</body>
</html>