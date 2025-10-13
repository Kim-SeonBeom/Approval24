<%@ page language="java" contentType="text/html; charset=UTF-8"
     pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>고용25 - 결재 상세</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/header.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/pending.css">
    
    <style>
    
    </style>
</head>
<body>

    <jsp:include page="header.jsp" />

    <div class="main-content">
        <div class="status-path">
            <span>홈 &gt; 대기</span>
        </div>

        <div class="reception-info-section">
            <div class="reception-label-column">
                <div class="reception-label-item">접수번호</div>
                <div class="reception-label-item">접수일자</div>
                <div class="reception-label-item">민원사무명</div>
                <div class="reception-label-item">접수부서</div>
                <div class="reception-label-item">전화번호</div>
            </div>
            <div class="reception-detail-column">
                <div class="reception-detail-item">
                    <span class="data-text">20102591069</span>
                </div>
                <div class="reception-detail-item detail-date-line">
                    <div class="date-item">
                        <span class="data-text">2025-10-12</span>
                    </div>
                    <div class="date-item process-deadline-box">
                        <div class="deadline-label">처리기한</div>
                        <span class="data-text">2025-11-16</span>
                    </div>
                </div>
                <div class="reception-detail-item">
                    <span class="data-text">취업지원급 신청</span>
                </div>
                <div class="reception-detail-item detail-department-line">
                    <div class="department-item">
                        <span class="data-text">취업지원 민원과</span>
                    </div>
                    <div class="department-item 담당자-box">
                        <div class="담당자-label">담당자</div>
                        <span class="data-text">이혜성</span>
                    </div>
                </div>
                <div class="reception-detail-item">
                    <span class="data-text">031-848-7406</span>
                </div>
            </div>
        </div>

        <div class="payment-content-section">
            <div class="payment-header">
                <span class="payment-title">결제내용</span>
            </div>
            <div class="payment-body">
                <span class="payment-text">제발 결제좀 해주세요 돈 필요해요 제발요 저 그지란 말이에요</span>
            </div>
            <div class="attachment-section">
                <button class="attachment-button">
                    <span>첨부파일</span>
                </button>
                <div class="attachment-filename">
                    <span>거지 증명서.hwp</span>
                </div>
            </div>
        </div>

        <div class="progress-history-section">
            <div class="progress-history-title">
                <span>진행내역</span>
            </div>
            <div class="progress-table">
                <div class="table-header-row">
                    <div class="table-header-cell">작업종류</div>
                    <div class="table-header-cell">담당자</div>
                    <div class="table-header-cell">부서명</div>
                </div>
                <div class="table-row">
                    <div class="table-cell">접수</div>
                    <div class="table-cell">김선범</div>
                    <div class="table-cell">본부 민원과</div>
                </div>
                <div class="table-row">
                    <div class="table-cell">검토</div>
                    <div class="table-cell">이혜성</div>
                    <div class="table-cell">취업지원 민원과</div>
                </div>
            </div>
        </div>

        <div class="action-buttons">
            <button class="reject-btn">
                <span>반려</span>
            </button>
            <button class="approve-btn">
                <span>승인</span>
            </button>
        </div>
    </div>
    
    </body>
</html>