<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<!-- index 경로 설정 - 임시 개발용 사용자 정보 -->
<c:remove var="loginUser" scope="session"/>
<c:if test="${empty loginUser}">
    <jsp:useBean id="tempUser" class="java.util.HashMap" scope="session"/>
    <c:set target="${tempUser}" property="userName" value="정동윤"/>
    <c:set target="${tempUser}" property="departmentName" value="인사 팀"/>
	<c:set target="${tempUser}" property="work" value="실업급여 신청"/>
    <c:set var="loginUser" value="${tempUser}" scope="session"/>
</c:if>

<!-- header 영역 -->
<head>
 <title>결재해조</title>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<!-- 테이블 hover -->
<style>
tbody tr:hover {
  background-color: #f5f5f5;
  color: blue;
}
</style>
</head>


<body id="page-top">


<!-- index 영역 -->
<c:if test="${loginUser.departmentName ne '인사 팀'}">
<%@ include file="/WEB-INF/views/jspf/index.jspf" %>
</c:if>
<c:if test="${loginUser.departmentName eq '인사 팀'}">
<%@ include file="/WEB-INF/views/jspf/index_hr.jspf" %>
</c:if>

<!-- Logout Modal-->
<%@ include file="/WEB-INF/views/common/logoutModal.jsp" %>
<!-- footer 영역 -->
<%@ include file="/WEB-INF/views/common/footer.jsp" %>



<script>
$(document).on('click', '#dataTable_index tbody tr.clickable-row', function (e) {
  if ($(e.target).closest('a, button, input, [data-no-row-click]').length) return;

  const url = $(this).data('href');
  if (url) {
    window.location.assign(url);
  }
});
</script>
    
</body>
</html>