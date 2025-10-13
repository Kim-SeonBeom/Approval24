<%@ page language="java" contentType="text/html; charset=UTF-8"
     pageEncoding="UTF-8"%>
<%-- JSTL Core 및 Functions 라이브러리 선언 --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


<%-- 카테고리 활성화 로직 (요청 속성 또는 파라미터 확인) --%>
<c:choose>
    <c:when test="${not empty category}">
        <c:set var="currentCategory" value="${category}" />
    </c:when>
    <c:when test="${not empty param.category}">
        <c:set var="currentCategory" value="${param.category}" />
    </c:when>
    <c:otherwise>
        <c:set var="currentCategory" value="전체" />
    </c:otherwise>
</c:choose>

<header class="header">
    <div class="top-bar">
        <div class="gov-logo-1"></div>
        <span class="unofficial-gov-notice">이 누리집은 대한민국 비공식 전자정부 누리집입니다.</span>
    </div>

    <div class="frame-7">
        <div class="frame-47">
            <div class="logo-image"></div>
            <span class="logo-text">고용25</span>
        </div>

        <div class="frame-9">
            <div class="frame-8">
                <span class="notification-btn">알림</span>
                <c:choose>
                    <c:when test="${empty user || empty user.id}">
                        <a href="${pageContext.request.contextPath}/auth/user/login" class="login-group">
                            <img src="${pageContext.request.contextPath}/resources/images/login.png" alt="로그인 아이콘">
                            <span class="login-btn">로그인</span>
                        </a>
                    </c:when>
                    <c:otherwise>
                        <div class="logged-in-group dropdown-toggle" id="mypageDropdown" data-dropdown-menu>
                            <span class="user-avatar">
                                ${fn:substring(user.id, 0, 1)}${fn:substring(user.id, 2, 3)}
                            </span>
                            <span class="user-name">${user.id}</span>
                        </div>

                        <div class="dropdown-menu" aria-labelledby="mypageDropdown">
                            <div class="menu-header">
                                <span class="avatar-large">
                                    ${fn:substring(user.id, 0, 1)}${fn:substring(user.id, 2, 3)}
                                </span>
                                <p class="id-display">${user.id}</p>
                            </div>
                            <hr>

                            <div class="account-list">
                                <c:forEach var="otherAccount" items="${accessibleAccounts}">
                                    <a href="javascript:void(0)" class="menu-item account-switch-item" data-id="${otherAccount.id}">
                                        <span class="avatar-small">
                                            ${fn:substring(otherAccount.id, 0, 1)}${fn:substring(otherAccount.id, 2, 3)}
                                        </span>
                                        <span class="account-id-text">${otherAccount.id}</span>
                                    </a>
                                </c:forEach>
                                <hr>

                                <a href="#" class="menu-item link-action">
                                    <span class="icon">➕</span>
                                    <span>다른 계정 추가</span>
                                </a>
                                <a href="${pageContext.request.contextPath}/auth/user/logout" class="menu-item link-action">
                                    <span class="icon">➡️</span>
                                    <span>로그아웃</span>
                                </a>
                            </div>
                            <hr>

                            <a href="${pageContext.request.contextPath}/mypage" class="menu-item">마이페이지</a>
                            <a href="${pageContext.request.contextPath}/settings" class="menu-item">설정</a>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>

        <div class="search-container">
            <input type="text" class="search-input-field" placeholder="검색어를 입력하세요">
            <button class="search-button-container">
                <span class="search-button-text">검색</span>
            </button>
        </div>
    </div>

    <div class="category-menu">
        <a href="?category=전체" class="category-btn-all <c:if test='${currentCategory eq "전체"}'>active</c:if>">
            <span>전체</span>
        </a>
        <a href="?category=신청" class="category-btn-apply <c:if test='${currentCategory eq "신청"}'>active</c:if>">
            <span>신청</span>
        </a>
        <a href="?category=대기" class="category-btn-waiting <c:if test='${currentCategory eq "대기"}'>active</c:if>">
            <span>대기</span>
        </a>
        <a href="?category=완료" class="category-btn-complete <c:if test='${currentCategory eq "완료"}'>active</c:if>">
            <span>완료</span>
        </a>
        <a href="?category=반려" class="category-btn-rejected <c:if test='${currentCategory eq "반려"}'>active</c:if>">
            <span>반려</span>
        </a>
    </div>
</header>