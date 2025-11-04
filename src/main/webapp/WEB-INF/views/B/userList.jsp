<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
    <%@ include file="/WEB-INF/views/common/header.jsp"%>
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

                <div class="card shadow mb-4">
                    <div class="card-header py-3">
                        <h6 class="m-0 font-weight-bold text-primary">검색 및 필터링</h6>
                    </div>
                    <div class="card-body">
                        <form id="userFilterForm" action="${pageContext.request.contextPath}/user/list" method="get">
                            <div class="form-row align-items-end">
                                
                                <div class="col-md-3 mb-3">
                                    <label for="userNameFilter">사용자 이름</label>
                                    <input type="text" class="form-control" id="userNameFilter" name="userName" 
                                           value="${filter.userName}" placeholder="이름 입력">
                                </div>
                                
                                <div class="col-md-3 mb-3">
                                    <label for="userEmailFilter">이메일</label>
                                    <input type="email" class="form-control" id="userEmailFilter" name="userEmail" 
                                           value="${filter.userEmail}" placeholder="이메일 입력">
                                </div>

                                <div class="col-md-2 mb-3">
                                    <label for="userPositionCdFilter">직급</label>
                                    <select class="custom-select" id="userPositionCdFilter" name="userPositionCd">
    <option value="">-- 전체 직급 --</option>
    
    <c:forEach var="pos" items="${codes}"> 
        <option value="${pos.codeId}" ${filter.userPositionCd eq pos.codeId ? 'selected' : ''}>
            ${pos.codeName}
        </option>
    </c:forEach>
</select>
                                </div>
                                
                                <div class="col-md-2 mb-3">
                                    <label for="delYnFilter">삭제 여부</label>
                                    <select class="custom-select" id="delYnFilter" name="delYn">
                                        <option value="">-- 전체 --</option>
                                        <option value="N" ${filter.delYn eq 'N' ? 'selected' : ''}>활성 (N)</option>
                                        <option value="Y" ${filter.delYn eq 'Y' ? 'selected' : ''}>삭제됨 (Y)</option>
                                    </select>
                                </div>

                                <div class="col-md-2 mb-3">
                                    <button class="btn btn-primary btn-block" type="submit">검색</button>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
                
                <div class="card shadow mb-4">
                    <div class="card-header py-3 d-flex justify-content-between">
                        <h6 class="m-0 font-weight-bold text-primary">사용자 목록 (${fn:length(users)}명)</h6>
                        <a href="${pageContext.request.contextPath}/user/create" class="btn btn-primary btn-sm" style="font-size: 1rem; padding: 0.25rem 0.75rem;">+ 사용자 등록</a>
                    </div>
                    <div class="card-body">
                        <div class="table-responsive">
                            <table class="table table-bordered" width="100%" cellspacing="0">
                                <thead>
                                    <tr>
                                        <th>번호</th>
                                        <th>이름</th>
                                        <th>직급</th>
                                        <th>이메일</th>
                                        <th>연락처</th>
                                        <th>등록일</th>
                                        <th>상태</th>
                                        <th>관리</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:choose>
                                        <c:when test="${not empty users}">
                                            <c:forEach var="user" items="${users}" varStatus="status">
                                                <tr>
                                                    <td>${user.userNo}</td>
                                                    
                                                    <td>
                                                        <a href="${pageContext.request.contextPath}/user/detail/${user.userResidentNo}">
                                                            ${user.userName}
                                                        </a>
                                                    </td>
                                                    
                                                    <td>${user.userPositionName}</td>
                                                    <td>${user.userEmail}</td>
                                                    <td>${user.userPhone}</td> <td><fmt:formatDate value="${user.createDt}" pattern="yyyy-MM-dd"/></td>
                                                    <td>
                                                        <c:choose>
                                                            <c:when test="${user.delYn eq 'Y'}">
                                                                <span class="badge badge-danger">삭제</span>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <span class="badge badge-success">활성</span>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </td>
                                                    <td>
                                                        <a href="${pageContext.request.contextPath}/user/edit/${user.userResidentNo}" class="btn btn-sm btn-warning">수정</a>
                                                        
                                                        <c:if test="${user.delYn eq 'N'}">
                                                            <form action="${pageContext.request.contextPath}/user/delete/${user.userNo}" method="post" style="display:inline" onsubmit="return confirm('사용자 [${user.userName}]을(를) 정말로 삭제(비활성화)하시겠습니까?');">
                                                                <button type="submit" class="btn btn-sm btn-danger">삭제</button>
                                                            </form>
                                                        </c:if>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </c:when>
                                        <c:otherwise>
                                            <tr>
                                                <td colspan="8" class="text-center">조회된 사용자 정보가 없습니다.</td>
                                            </tr>
                                        </c:otherwise>
                                    </c:choose>
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
    // 페이지 로드 시 검색 필터의 현재 값을 유지하기 위해 Controller에서 ModelAttribute로 'filter'를 받습니다.
</script>

</body>
</html>