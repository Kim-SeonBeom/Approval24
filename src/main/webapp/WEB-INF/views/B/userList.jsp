<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<title>사용자목록</title>
    <%@ include file="/WEB-INF/views/common/header.jsp"%>
    <style>
        .pagination { display: flex; padding-left: 0; list-style: none; }
        .page-item.active .page-link { color: #fff; background-color: #007bff; border-color: #007bff; }
        .page-link { padding: .5rem .75rem; color: #007bff; background-color: #fff; border: 1px solid #dee2e6; }
    </style>
</head>
<body id="page-top">

<div id="wrapper">
    <%@ include file="/WEB-INF/views/common/sidebar.jsp"%>

    <div id="content-wrapper" class="d-flex flex-column">
        <div id="content">
            <%@ include file="/WEB-INF/views/common/navbar.jsp"%>

            <div class="container-fluid">
                <h1 class="h3 mb-2 text-gray-800">사용자 관리</h1>
                <br>

                <!-- 검색 카드 -->
                <div class="card shadow mb-4">
                    <div class="card-header py-3 d-flex justify-content-between align-items-center">
                        <h6 class="m-0 font-weight-bold text-primary">검색 및 필터링</h6>
                        <button class="btn btn-primary btn-sm" type="submit" form="userFilterForm">검색</button>
                    </div>

                    <div class="card-body">
                        <form id="userFilterForm" action="${pageContext.request.contextPath}/user/list" method="get">
								


								<!-- 등록/수정일 -->
                            <div class="form-group row mb-3">
                                <label class="col-sm-2 col-form-label font-weight-bold text-center">등록/수정일</label>
                                <div class="col-sm-10 form-inline">
                                    <select class="form-control mr-2" id="dateType" name="dateType" style="width:120px;">
                                        <option value="createDt" ${filter.dateType == 'createDt' ? 'selected' : ''}>등록일</option>
                                        <option value="updateDt" ${filter.dateType == 'updateDt' ? 'selected' : ''}>수정일</option>
                                    </select>

                                    <input type="date" class="form-control mr-2" name="createDtStr"
                                           value="${filter.createDt}" style="width:180px;">
                                    <span class="mx-1">~</span>
                                    <input type="date" class="form-control ml-2" name="updateDtStr"
                                           value="${filter.updateDt}" style="width:180px;">
                                </div>
                            </div>

                            <!-- 삭제여부 -->
                            <div class="form-group row mb-3">
                                <label class="col-sm-2 col-form-label font-weight-bold text-center">삭제여부</label>
                                <div class="col-sm-10">
                                    <div class="form-check form-check-inline">
                                        <input class="form-check-input" type="radio" name="delYn" value="Y" ${filter.delYn == 'Y' ? 'checked' : ''}>
                                        <label class="form-check-label">삭제</label>
                                    </div>
                                    <div class="form-check form-check-inline">
                                        <input class="form-check-input" type="radio" name="delYn" value="N" ${filter.delYn == 'N' ? 'checked' : ''}>
                                        <label class="form-check-label">사용</label>
                                    </div>
                                    <div class="form-check form-check-inline">
                                        <input class="form-check-input" type="radio" name="delYn" value="" ${empty filter.delYn ? 'checked' : ''}>
                                        <label class="form-check-label">전체</label>
                                    </div>
                                </div>
                            </div>

                            <!-- 이름 -->
                            <div class="form-group row mb-3">
                                <label class="col-sm-2 col-form-label font-weight-bold text-center">이름</label>
                                <div class="col-sm-10">
                                    <input type="text" class="form-control w-25" name="userName"
                                           value="${filter.userName}" placeholder="이름 입력">
                                </div>
                            </div>

                            <!-- 직급 -->
                            <div class="form-group row mb-3">
                                <label class="col-sm-2 col-form-label font-weight-bold text-center">직급</label>
                                <div class="col-sm-10">
                                    <input type="text" class="form-control w-25" name="userPositionName"
                                           value="${filter.userPositionName}" placeholder="직급 입력">
                                </div>
                            </div>

                            <!-- 계정 상태 -->
                            <div class="form-group row mb-3">
                                <label class="col-sm-2 col-form-label font-weight-bold text-center">계정 상태</label>
                                <div class="col-sm-10">
                                    <select name="accountStatusCd" class="custom-select w-25">
                                        <option value="">-- 선택하세요 --</option>
                                        <c:forEach var="accountStatusCd" items="${accountStatusCd}">
                                            <option value="${accountStatusCd.codeId}"
                                                ${filter.accountStatusCd == accountStatusCd.codeId ? 'selected' : ''}>
                                                ${accountStatusCd.codeName}
                                            </option>
                                        </c:forEach>
                                    </select>
                                </div>
                            </div>

                            <!-- 이메일 -->
                            <div class="form-group row mb-3">
                                <label class="col-sm-2 col-form-label font-weight-bold text-center">이메일</label>
                                <div class="col-sm-10">
                                    <input type="text" class="form-control w-50" name="userEmail"
                                           value="${filter.userEmail}" placeholder="이메일 입력">
                                </div>
                            </div>

                            <input type="hidden" name="page" value="${filter.page}">
                            <input type="hidden" name="size" value="${filter.size}">

                        </form>
                    </div>
                </div> <!-- 검색 카드 끝 -->

                <!-- 사용자 목록 -->
                <div class="card shadow mb-4">
                    <div class="card-header py-3 d-flex justify-content-between">
                        <h6 class="m-0 font-weight-bold text-primary">사용자 목록</h6>
                        <a class="btn btn-primary btn-sm" href="${pageContext.request.contextPath}/user/create">+ 사용자 등록</a>
                    </div>

                    <div class="card-body">
							<c:choose>
								<c:when test="${not empty errorMessage}">
									<div class="alert alert-danger text-center" role="alert">
										${errorMessage}</div>
								</c:when>
								<c:otherwise>
									<c:if test="${empty userList}">
										<div class="text-center text-muted py-4">
											검색 조건을 입력하고 <b>검색</b>을 눌러주세요.
										</div>
									</c:if>
								</c:otherwise>
							</c:choose>


							<c:if test="${not empty userList}">
                            <div class="mb-2 text-left text-muted">총 <b>${totalCount}</b>건</div>

                            <div class="table-responsive">
                                <table class="table table-bordered table-hover table-sm text-center">
                                    <thead class="thead-light">
                                    <tr>
                                        <th>번호</th>
                                        <th>이름</th>
                                        <th>직급</th>
                                        <th>이메일</th>
                                        <th>전화번호</th>
                                        <th>등록일</th>
                                        <th>수정일</th>
                                        <th>삭제여부</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <c:forEach var="item" items="${userList}" varStatus="status">
                                        <tr class="clickable-row"
                                            data-href="${pageContext.request.contextPath}/user/detail/${item.userNo}"
                                            style="cursor:pointer;">
                                            <td>${(filter.page - 1) * filter.size + status.index + 1}</td>
                                            <td>${item.userName}</td>
                                            <td>${item.userPositionName}</td>
                                            <td class="text-left pl-3">${item.userEmail}</td>
                                            <td>${item.userPhone}</td>
                                            <td><fmt:formatDate value="${item.createDt}" pattern="yyyy-MM-dd"/></td>
                                            <td><fmt:formatDate value="${item.updateDt}" pattern="yyyy-MM-dd"/></td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${item.delYn == 'Y'}"><span class="badge badge-secondary">삭제</span></c:when>
                                                    <c:when test="${item.delYn == 'N'}"><span class="badge badge-success">사용</span></c:when>
                                                    <c:otherwise><span class="badge badge-light">${item.delYn}</span></c:otherwise>
                                                </c:choose>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                    </tbody>
                                </table>
                            </div>

                            <!-- 페이지네이션 -->
                            <c:set var="curr" value="${filter.page}" />
                            <c:set var="last" value="${totalPages}" />

                            <nav class="mt-3">
                                <ul class="pagination justify-content-center">

                                    <!-- Prev -->
                                    <li class="page-item ${curr <= 1 ? 'disabled' : ''}">
                                        <a class="page-link"
                                           href="<c:url value='/user/list'><c:param name='page' value='${curr-1}'/></c:url>">이전</a>
                                    </li>

                                    <!-- Page numbers -->
                                    <c:forEach begin="1" end="${last}" var="p">
                                        <li class="page-item ${p == curr ? 'active' : ''}">
                                            <a class="page-link"
                                               href="<c:url value='/user/list'><c:param name='page' value='${p}'/></c:url>">${p}</a>
                                        </li>
                                    </c:forEach>

                                    <!-- Next -->
                                    <li class="page-item ${curr >= last ? 'disabled' : ''}">
                                        <a class="page-link"
                                           href="<c:url value='/user/list'><c:param name='page' value='${curr+1}'/></c:url>">다음</a>
                                    </li>

                                </ul>
                            </nav>
                        </c:if>

                    </div>
                </div> <!-- 목록 카드 끝 -->

            </div>
        </div>

        <%@ include file="/WEB-INF/views/common/footer.jsp"%>
    </div>
</div>

<script>
document.addEventListener('click', function(e) {
    const tr = e.target.closest('.clickable-row');
    if (tr && tr.dataset.href) {
        location.href = tr.dataset.href;
    }
});
</script>

</body>
</html>
