<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>마이페이지</title>
    <%@ include file="/WEB-INF/views/common/header.jsp"%>
</head>
<body id="page-top">

    <div id="wrapper">

        <%@ include file="/WEB-INF/views/common/sidebar.jsp"%>
        <div id="content-wrapper" class="d-flex flex-column">

            <div id="content">

                <%@ include file="/WEB-INF/views/common/navbar.jsp"%>
                <div class="container-fluid">

                    <div class="d-sm-flex align-items-center justify-content-between mb-4">
                        <h1 class="h3 mb-0 text-gray-800">마이페이지</h1>
                    </div>

                    <div class="card shadow mb-4">
                        <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                            <h6 class="m-0 font-weight-bold text-primary">${loginuserName}님</h6>
                        </div>

                        <div class="card-body">
                            <div class="row align-items-start">
                                
                                <div class="col-lg-6 col-md-4 col-12 d-flex justify-content-center align-items-center">
                                    <div class="w-100">
                                        <h6 class="text-dark font-weight-bold">직원정보</h6>
                                        <table class="table table-bordered" id="dataTable_mypage1" width="100%" cellspacing="0">
                                            <tbody>
                                                <tr>
                                                    <td class="text-dark bg-light font-weight-bold text-center" style="width: 25%;">이름</td>
                                                    <td>${loginuserName}</td>
                                                </tr>
                                                <tr>
                                                    <td class="text-dark bg-light font-weight-bold text-center" style="width: 25%;">회사</td>
                                                    <td>${logininstName}</td>
                                                </tr>
                                                <tr>
                                                    <td class="text-dark bg-light font-weight-bold text-center" style="width: 25%;">부서</td>
                                                    <td>${logindeptName}</td>
                                                </tr>
                                                <tr>
                                                    <td class="text-dark bg-light font-weight-bold text-center" style="width: 25%;">직책</td>
                                                    <td>${totalinfo.codeName}</td>
                                                </tr>
                                                <tr>
                                                    <td class="text-dark bg-light font-weight-bold text-center" style="width: 25%;">전화번호</td>
                                                    <td>${userinfo.userTel}</td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>

                                <div class="col-lg-6 col-md-8 col-12">
                                    <h6 class="text-dark font-weight-bold">계정정보</h6>
                                    <table class="table table-bordered" id="dataTable_mypage2" width="100%" cellspacing="0"> 
                                        <tbody>
                                            <c:choose>
                                                <c:when test="${not empty authList}">
                                                    <c:forEach var="auth" items="${authList}">
                                                        <tr>
                                                            <td class="text-dark bg-light font-weight-bold text-center" style="width: 25%;">권한</td>
                                                            <td>${auth.authorityName}</td>
                                                        </tr>
                                                    </c:forEach>
                                                </c:when>
                                                <c:otherwise>
                                                     <tr>
                                                        <td colspan="2" class="text-center">등록된 권한이 없습니다.</td>
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
            </div>

        </div>

    </div>
    <%@ include file="/WEB-INF/views/common/logoutModal.jsp"%>
    <%@ include file="/WEB-INF/views/common/footer.jsp"%>
</body>
</html>