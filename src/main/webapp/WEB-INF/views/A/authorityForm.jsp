<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
                <h1 class="h3 mb-2 text-gray-800">
                    <c:choose>
                        <c:when test="${authority != null && authority.authorityId != null}">권한 수정</c:when>
                        <c:otherwise>권한 등록</c:otherwise>
                    </c:choose>
                </h1>
                <br>

                <div class="card shadow mb-4">
                    <div class="card-body">
                        <form action="<c:choose>
                                        <c:when test='${authority != null && authority.authorityId != null}'>
                                            ${pageContext.request.contextPath}/authority/edit
                                        </c:when>
                                        <c:otherwise>
                                            ${pageContext.request.contextPath}/authority/create
                                        </c:otherwise>
                                      </c:choose>"
                              method="post">
                            
                            <input type="hidden" name="authorityId" value="${authority != null ? authority.authorityId : ''}"/>

                            <div class="form-group">
                                <label for="authorityName">권한명</label>
                                <input type="text" class="form-control" id="authorityName" name="authorityName"
                                       value="${authority != null ? authority.authorityName : ''}" required>
                            </div>

                            <div class="form-group">
                                <label for="isSystem">시스템권한 여부</label>
                                <select class="form-control" id="isSystem" name="isSystem">
                                    <option value="N" <c:if test="${authority != null && authority.isSystem == 'N'}">selected</c:if>>N</option>
                                	<option value="Y" <c:if test="${authority != null && authority.isSystem == 'Y'}">selected</c:if>>Y</option>
                                </select>
                            </div>

                            <button type="submit" class="btn btn-primary">
                                <c:choose>
                                    <c:when test="${authority != null && authority.authorityId != null}">수정</c:when>
                                    <c:otherwise>등록</c:otherwise>
                                </c:choose>
                            </button>
                            <a href="${pageContext.request.contextPath}/authority/list" class="btn btn-secondary">취소</a>
                        </form>
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
