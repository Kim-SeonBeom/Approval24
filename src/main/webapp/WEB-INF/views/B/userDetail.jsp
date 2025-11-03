<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
                <h1 class="h3 mb-4 text-gray-800">사용자 상세 정보</h1>
                <br>

                <c:if test="${not empty successMessage}">
                    <div class="alert alert-success" role="alert">
                        ${successMessage}
                    </div>
                </c:if>

                <div class="card shadow mb-4">
                    <div class="card-header py-3">
                        <h6 class="m-0 font-weight-bold text-primary">기본 정보: ${user.userName}</h6>
                    </div>
                    <div class="card-body">
                        
                        <div class="table-responsive">
                            <table class="table table-bordered" style="width: 100%; max-width: 800px;">
                                <colgroup>
                                    <col style="width: 20%;">
                                    <col style="width: 30%;">
                                    <col style="width: 20%;">
                                    <col style="width: 30%;">
                                </colgroup>
                                <tbody>
                                    <tr>
                                        <th>사용자 번호 (PK)</th>
                                        <td>${user.userNo}</td>
                                        <th>주민등록번호</th>
                                        <td>${user.userResidentNo}</td>
                                    </tr>
                                    <tr>
                                        <th>이름</th>
                                        <td>${user.userName}</td>
                                        <th>직급</th>
                                        <td>${user.userPositionName}</td>
                                    </tr>
                                    <tr>
                                        <th>이메일</th>
                                        <td colspan="3">${user.userEmail}</td>
                                    </tr>
                                    <tr>
                                        <th>휴대전화</th>
                                        <td>${user.userPhone}</td>
                                        <th>전화번호 (유선)</th>
                                        <td>${user.userTel}</td>
                                    </tr>
                                    <tr>
                                        <th>생성일</th>
                                        <td><fmt:formatDate value="${user.createDt}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                                        <th>수정일</th>
                                        <td><fmt:formatDate value="${user.updateDt}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                                    </tr>
                                    <tr>
                                        <th>생성자 ID</th>
                                        <td>${user.createId}</td>
                                        <th>수정자 ID</th>
                                        <td>${user.updateId}</td>
                                    </tr>
                                    <tr>
                                        <th>상태 (DEL_YN)</th>
                                        <td colspan="3">
                                            <c:choose>
                                                <c:when test="${user.delYn eq 'N'}">
                                                    <span class="badge badge-success">활성</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="badge badge-danger">삭제됨</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>

                        <hr>
                        
                        <div class="d-flex justify-content-end">
                            <a href="${pageContext.request.contextPath}/user/list" class="btn btn-secondary mr-2">목록으로</a>
                            
                            <a href="${pageContext.request.contextPath}/user/edit/${user.userResidentNo}" class="btn btn-warning mr-2">수정</a>
                            
                            <c:if test="${user.delYn eq 'N'}">
                                <form action="${pageContext.request.contextPath}/user/delete/${user.userNo}" method="post" style="display:inline">
                                    <button type="submit" class="btn btn-danger" onclick="return confirm('사용자 [${user.userName}]을(를) 정말로 삭제(비활성화)하시겠습니까?');">삭제</button>
                                </form>
                            </c:if>
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

</body>
</html>