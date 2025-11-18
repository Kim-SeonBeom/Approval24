<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<!-- index 경로 설정 - 임시 개발용 사용자 정보 -->
<c:remove var="loginUser" scope="session" />


<!-- header 영역 -->
<head>
<title>민원처리 시스템</title>
<%@ include file="/WEB-INF/views/common/header.jsp"%>

</head>


<body id="page-top">


	<!-- index 영역 -->
	<c:choose>
		<c:when test="${not empty sessionScope.user}">
			<c:if test="${logindeptName ne '인사팀'}"> 
				<%@ include file="/WEB-INF/views/jspf/index.jspf"%>
			 </c:if>
			<!-- 나중에 부서명으로 수정 -->
			<c:if test="${logindeptName eq '인사팀'}">
				<%@ include file="/WEB-INF/views/jspf/index_hr.jspf"%>
				</c:if>
		</c:when>
		<c:otherwise>
			<c:redirect url="/login"/>
		</c:otherwise>
	</c:choose>

	<!-- Logout Modal-->
	<%@ include file="/WEB-INF/views/common/logoutModal.jsp"%>
	<!-- footer 영역 -->
	<%@ include file="/WEB-INF/views/common/footer.jsp"%>


</body>
</html>