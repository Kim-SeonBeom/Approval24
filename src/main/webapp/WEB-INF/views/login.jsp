<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <title>로그인</title>
    <%@ include file="/WEB-INF/views/common/header.jsp"%>
</head>

<body class="bg-light" style="background: linear-gradient(to right, #126C83, #74BCAA); height: 100vh;">

<div class="h-100 d-flex flex-column justify-content-center">
    <div class="container">

        <!-- Outer Row -->
        <div class="row justify-content-center align-items-center">

            <div class="col-xl-10 col-lg-12 col-md-9">

                <div class="card o-hidden border-0 shadow-lg my-5">
                    <div class="card-body p-0 h-100">
                        <!-- Nested Row within Card Body -->
                        <div class="row h-100">
                            <div class="col-lg-6 d-none d-lg-flex bg-login-image d-flex justify-content-center align-items-center h-100">
                                <img src="${pageContext.request.contextPath}/resources/assets/img/two_go_dragon.png"
                                     class="w-50" />
                            </div>
                            <div class="col-lg-6">
                                <div class="p-5">
                                    <div class="text-center" >
                                        <h1 class="h4 text-gray-900 mb-4" action="">민원 처리 시스템</h1>
                                    </div>

										<c:if test="${not empty error}">
											<div class="alert " role="alert" style="margin: 0;padding: 0 ;">
												<c:out value="${error}" />
											</div>
										</c:if>
										<!-- 로그인 폼 -->
                                    <form class="user" action="${pageContext.request.contextPath}/login" method="post">
                                        <div class="form-group">
                                            <input type="text" name="loginId" class="form-control form-control-user"
                                                   id="InputId" aria-describedby="IdHelp" placeholder="아이디" required>
                                        </div>
                                        <div class="form-group">
                                            <input type="password" name="password" class="form-control form-control-user"
                                                   id="InputPassword" placeholder="비밀번호" required>
                                        </div>
                                        <button type="submit" class="btn btn-success btn-user btn-block">로그인</button>
                                        <hr>
                                    </form>

                                    <div class="text-center">
                                        <a class="small" href="${pageContext.request.contextPath}/signup/Form">계정이 없으신가요?</a>
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
