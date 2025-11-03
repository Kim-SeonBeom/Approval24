<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
    <%@ include file="/WEB-INF/views/common/header.jsp"%>
    <style>
        .sortable { cursor: pointer; }
        .sort-icon { margin-left: 5px; }
    </style>
</head>
<body id="page-top">

<div id="wrapper">

    <%@ include file="/WEB-INF/views/common/sidebar.jsp"%>
    <div id="content-wrapper" class="d-flex flex-column">
        <div id="content">

            <%@ include file="/WEB-INF/views/common/navbar.jsp"%>
            <div class="container-fluid">
                <h1 class="h3 mb-2 text-gray-800">권한 관리</h1>
                <br>

                <div class="row mb-3">
                    <div class="col-md-4">
                        <form id="filterForm" action="${pageContext.request.contextPath}/authority/list" method="get">
                            <input type="hidden" name="sortField" value="${currentSortField}">
                            <input type="hidden" name="sortOrder" value="${currentSortOrder}">
                            
                            <div class="input-group">
                                <select class="custom-select" id="deptFilter" name="deptId">
                                    <option value="" ${currentDeptId == null ? 'selected' : ''}>-- 전체 부서 --</option>
                                    <c:forEach var="dept" items="${allDepartments}">
                                        <option value="${dept.deptId}" ${currentDeptId == dept.deptId ? 'selected' : ''}>
                                            ${dept.deptName}
                                        </option>
                                    </c:forEach>
                                </select>
                                <div class="input-group-append">
                                    <button class="btn btn-primary" type="submit">필터링</button>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>

                <div class="card shadow mb-4">
                    <div class="card-header py-3 d-flex justify-content-between">
                        <h6 class="m-0 font-weight-bold text-primary">전체 권한 목록</h6>
                        <button class="btn btn-primary btn-sm" id="authorityCreate" style="font-size: 1rem; padding: 0.25rem 0.75rem;">+ 권한 등록</button>
                    </div>
                    <div class="card-body">
                        <div class="table-responsive">
                            <table class="table table-bordered" width="100%" cellspacing="0">
                                <thead>
                                    <tr>
                                        <th class="sortable" data-field="AUTHORITY_ID">
                                            권한ID
                                            <c:if test="${currentSortField eq 'AUTHORITY_ID'}">
                                                <i class="fas sort-icon <c:choose><c:when test="${currentSortOrder eq 'ASC'}">fa-sort-up</c:when><c:otherwise>fa-sort-down</c:otherwise></c:choose>"></i>
                                            </c:if>
                                        </th>
                                        <th>권한명</th>
                                        <th class="sortable" data-field="CREATE_DT">
                                            생성일
                                            <c:if test="${currentSortField eq 'CREATE_DT'}">
                                                <i class="fas sort-icon <c:choose><c:when test="${currentSortOrder eq 'ASC'}">fa-sort-up</c:when><c:otherwise>fa-sort-down</c:otherwise></c:choose>"></i>
                                            </c:if>
                                        </th>
                                        <th class="sortable" data-field="UPDATE_DT">
                                            수정일
                                            <c:if test="${currentSortField eq 'UPDATE_DT'}">
                                                <i class="fas sort-icon <c:choose><c:when test="${currentSortOrder eq 'ASC'}">fa-sort-up</c:when><c:otherwise>fa-sort-down</c:otherwise></c:choose>"></i>
                                            </c:if>
                                        </th>
                                        <th>시스템권한</th>
                                        <th>관리</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:set var="emptyList" value="${fn:trim('')}" />
                                    <c:forEach var="auth" items="${authorities}">
                                        <tr>
                                            <td>${auth.authorityId}</td>
                                            <td>
                                                <a href="${pageContext.request.contextPath}/authority/detail/${auth.authorityId}">
                                                    ${auth.authorityName}
                                                </a>
                                            </td>
                                            <td>${auth.createDt}</td>
                                            <td>${auth.updateDt}</td>
                                            <td>${auth.isSystem}</td>
                                            <td>
                                                <a class="btn btn-sm btn-warning" href="${pageContext.request.contextPath}/authority/edit/${auth.authorityId}">수정</a>
                                                <form action="${pageContext.request.contextPath}/authority/delete/${auth.authorityId}" method="post" style="display:inline" onsubmit="return confirm('정말로 권한 [${auth.authorityName}]을(를) 삭제하시겠습니까?');">
                                                    <button type="submit" class="btn btn-sm btn-danger">삭제</button>
                                                </form>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                    <c:if test="${empty authorities}">
                                        <tr>
                                            <td colspan="6" class="text-center">조회된 권한 정보가 없습니다.</td>
                                        </tr>
                                    </c:if>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>

            </div>
        </div>

        <%@ include file="/WEB-INF/views/common/footer.jsp"%>
    </div>
</div>

<a class="scroll-to-top rounded" href="#page-top"><i class="fas fa-angle-up"></i></a>
<%@ include file="/WEB-INF/views/common/logoutModal.jsp"%>

<script>
    $(document).ready(function() {
        var contextPath = "${pageContext.request.contextPath}";

        $("#authorityCreate").on('click', function() {
            window.location.href = contextPath + "/authority/create";
        });

        // 💡 1. 부서 드롭다운 변경 시 자동 필터링 (submit 버튼 누르는 것을 대체)
        $("#deptFilter").on('change', function() {
            $("#filterForm").submit();
        });
        
        // 💡 2. 테이블 헤더 클릭 시 정렬 기능
        $(".sortable").on('click', function() {
            var newSortField = $(this).data('field');
            var currentSortField = $('input[name="sortField"]').val();
            var currentSortOrder = $('input[name="sortOrder"]').val();
            var newSortOrder = 'ASC';

            // 현재 필드를 다시 클릭한 경우, 정렬 순서를 반전
            if (newSortField === currentSortField) {
                newSortOrder = (currentSortOrder === 'ASC') ? 'DESC' : 'ASC';
            }

            // 숨겨진 필드 값 업데이트
            $('input[name="sortField"]').val(newSortField);
            $('input[name="sortOrder"]').val(newSortOrder);
            
            // 폼 제출
            $("#filterForm").submit();
        });
    });
</script>

</body>
</html>