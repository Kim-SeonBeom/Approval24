<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
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
                <c:set var="isEditMode" value="${user.userNo != null}" />
                <h1 class="h3 mb-4 text-gray-800">
                    <c:choose>
                        <c:when test="${isEditMode}">사용자 정보 수정</c:when>
                        <c:otherwise>사용자 등록</c:otherwise>
                    </c:choose>
                </h1>
                <br>

                <c:if test="${not empty errorMessage}">
                    <div class="alert alert-danger" role="alert">
                        ${errorMessage}
                    </div>
                </c:if>

                <div class="card shadow mb-4">
                    <div class="card-header py-3">
                        <h6 class="m-0 font-weight-bold text-primary">
                            <c:choose>
                                <c:when test="${isEditMode}">정보 수정: ${user.userName}</c:when>
                                <c:otherwise>기본 정보 입력</c:otherwise>
                            </c:choose>
                        </h6>
                    </div>
                    <div class="card-body">
                        
                        <c:url var="formAction" value="${isEditMode ? '/user/edit' : '/user/create'}" />
                        <form:form action="${formAction}" method="post" modelAttribute="user">
                            
                            <c:if test="${isEditMode}">
                                <form:hidden path="userNo"/>
                            </c:if>
                            
                            <div class="form-row">
                                <div class="form-group col-md-6">
                                    <label for="userName">사용자 이름</label>
                                    <form:input path="userName" cssClass="form-control" required="true" placeholder="이름을 입력하세요"/>
                                </div>
                                
                                <div class="form-group col-md-6">
                                    <label for="userResidentNo">주민등록번호</label>
                                    <form:input path="userResidentNo" cssClass="form-control" required="true" 
                                                placeholder="주민번호를 입력하세요 (필수)" 
                                                readonly="${isEditMode ? 'readonly' : 'false'}"
                                                style="${isEditMode ? 'background-color: #e9ecef;' : ''}"/>
                                </div>
                            </div>

                            <div class="form-row">
                                <div class="form-group col-md-6">
                                    <label for="userPositionCd">직급</label>
                                    <form:select path="userPositionCd" cssClass="custom-select" required="true">
                                        <form:option value="" label="-- 선택하세요 --" />
                                        <c:forEach var="code" items="${codes}">
                                            <form:option value="${code.codeId}" label="${code.codeName}" />
                                        </c:forEach>
                                    </form:select>
                                </div>
                                
                                <div class="form-group col-md-6">
                                    <label for="userEmail">이메일</label>
                                    <form:input path="userEmail" type="email" cssClass="form-control" required="true" placeholder="이메일 주소"/>
                                </div>
                            </div>
                            
                            <div class="form-row">
                                <div class="form-group col-md-6">
                                    <label for="userTel">전화번호 (유선)</label>
                                    <form:input path="userTel" cssClass="form-control" placeholder="예: 02-1234-5678"/>
                                </div>
                                
                                <div class="form-group col-md-6">
                                    <label for="userPhone">휴대전화</label>
                                    <form:input path="userPhone" cssClass="form-control" required="true" placeholder="예: 010-1234-5678"/>
                                </div>
                            </div>

                            <hr>
                            
                            <div class="d-flex justify-content-end">
                                <c:choose>
                                    <c:when test="${isEditMode}">
                                        <a href="${pageContext.request.contextPath}/user/detail/${user.userResidentNo}" class="btn btn-secondary mr-2">취소 및 상세 보기</a>
                                        <button type="submit" class="btn btn-warning">수정 완료</button>
                                    </c:when>
                                    <c:otherwise>
                                        <a href="${pageContext.request.contextPath}/user/list" class="btn btn-secondary mr-2">목록으로</a>
                                        <button type="submit" class="btn btn-success">사용자 등록/재활성화</button>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                            
                        </form:form>
                        
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