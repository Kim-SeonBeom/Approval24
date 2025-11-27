<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/vendor/bootstrap/css/bootstrap.min.css">
    
    <title>접근 거부</title>
    <%@ include file="/WEB-INF/views/common/header.jsp"%>
</head>

<body class="bg-light" style="background: linear-gradient(to right, #126C83, #74BCAA); height: 100vh;">

<div class="h-100 d-flex flex-column justify-content-center">
    <div class="container">

        <div class="row justify-content-center align-items-center">

            <div class="col-xl-8 col-lg-10 col-md-8">

                <div class="card o-hidden border-0 shadow-lg my-5">
                    <div class="card-body p-0">
                        <div class="row justify-content-center">
                            <div class="col-lg-12">
                                <div class="p-5 text-center">
                                    
                                    <h1 class="h2 text-danger mb-4">⛔ 접근 권한 없음</h1>
                                    
                                    <hr class="mb-4">
                                    
                                    <p class="lead text-gray-800">
                                        <c:out value="${error != null ? error : '알수 없는 에러'}" />
                                    </p>
                                    
                                    <a href="${pageContext.request.contextPath}/" class="btn btn-danger btn-user mt-4">
                                       					 홈 페이지로 돌아가기
                                    </a>
                                    
                                    <div class="mt-4">
                                        <a class="small text-muted" href="${pageContext.request.contextPath}/login">로그인 페이지로 이동</a>
                                    </div>
                                    
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </div>
</div>
<%@ include file="/WEB-INF/views/common/footer.jsp"%>
</body>
</html>