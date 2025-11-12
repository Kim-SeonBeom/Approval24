<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
    <title>결재 이력</title>
</head>
<body id="page-top">
<div id="wrapper">
    <%@ include file="/WEB-INF/views/common/sidebar.jsp"%>
    <div id="content-wrapper" class="d-flex flex-column">
        <div id="content">
            <%@ include file="/WEB-INF/views/common/navbar.jsp"%>

            <div class="container-fluid">
                <h1 class="h3 mb-2 text-gray-800">결재 이력</h1>

                <div class="card shadow mb-4">
                    <div class="card-header py-3 d-flex align-items-center justify-content-between">
                        <h2 class="h5 m-0 font-weight-bold text-primary">결재 이력 조회</h2>
                    </div>
                    <div class="card-body">
                        <!-- 검색 필터 -->
                        <form method="get" action="/approval24/history/list" style="text-align: right;">
                            <label>결재 상태:</label>
                            <select name="approvalStatusCd">
                                <option value="">전체</option>
                                <c:forEach var="status" items="${statusCodeList}">
                                    <option value="${status.codeId}" ${filterMap.approvalStatusCd == status.codeId ? 'selected' : ''}>
                                        ${status.codeName}
                                    </option>
                                </c:forEach>
                            </select>

                            <label style="margin-left:30px;">결재 구분:</label>
                            <select name="categoryCd">
                                <option value="">전체</option>
                                <c:forEach var="category" items="${categoryCodeList}">
                                    <option value="${category.codeId}" ${filterMap.categoryCd == category.codeId ? 'selected' : ''}>
                                        ${category.codeName}
                                    </option>
                                </c:forEach>
                            </select>

                            <label style="margin-left:30px;">페이지당:</label>
                            <select name="pageSize" onchange="this.form.submit()">
                                <option value="5" ${pageInfo.pageSize == 5 ? 'selected' : ''}>5</option>
                                <option value="10" ${pageInfo.pageSize == 10 ? 'selected' : ''}>10</option>
                                <option value="15" ${pageInfo.pageSize == 15 ? 'selected' : ''}>15</option>
                            </select>

                            <button type="submit" class="btn btn-primary text-white">검색</button>
                        </form>

                        <hr>

                        <!-- 결재 이력 목록 -->
                        <div class="table-responsive">
                            <table class="table table-bordered" width="100%" cellspacing="0">
                                <thead>
                                    <tr>
                                        <th>번호</th>
                                        <th>결재 구분</th>
                                        <th>결재 상태</th>
                                        <th>결재자 유형</th>
                                        <th>처리일자</th>
                                        <th>의견</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:choose>
                                        <c:when test="${not empty historyList}">
                                            <c:forEach var="item" items="${historyList}" varStatus="status">
                                                <tr style="cursor:pointer;" 
                                                    <c:if test="${not empty item.url}">
                                                        onclick="window.open('${item.url}','_blank');"
                                                    </c:if>>
                                                    <td>${status.index + 1}</td>
                                                    <td>${item.categoryName}</td>
                                                    <td>${item.approvalStatusName}</td>
                                                    <td>${item.approverTypeName}</td>
                                                    <td><fmt:formatDate value="${item.processDt}" pattern="yyyy-MM-dd HH:mm" /></td>
                                                    <td>${item.approvalComment}</td>
                                                </tr>
                                            </c:forEach>
                                        </c:when>
                                        <c:otherwise>
                                            <tr>
                                                <td colspan="6">조회된 결재 이력이 없습니다.</td>
                                            </tr>
                                        </c:otherwise>
                                    </c:choose>
                                </tbody>
                            </table>
                        </div>

                        <!-- 페이징 -->
                        <c:if test="${pageInfo.totalPages > 1}">
                        <nav aria-label="Page navigation example">
                          <ul class="pagination justify-content-center">
                            <!-- 이전 -->
                            <c:url var="prevUrl" value="/approval24/history/list">
                                <c:param name="page" value="${pageInfo.page - 1}" />
                                <c:if test="${filterMap.approvalStatusCd != null and filterMap.approvalStatusCd != ''}">
                                    <c:param name="approvalStatusCd" value="${filterMap.approvalStatusCd}" />
                                </c:if>
                                <c:if test="${filterMap.categoryCd != null and filterMap.categoryCd != ''}">
                                    <c:param name="categoryCd" value="${filterMap.categoryCd}" />
                                </c:if>
                                <c:param name="pageSize" value="${pageInfo.pageSize}" />
                            </c:url>
                            <li class="page-item ${pageInfo.page == 1 ? 'disabled' : ''}">
                                <a class="page-link" href="${prevUrl}" tabindex="-1">Previous</a>
                            </li>

                            <!-- 페이지 번호 -->
                            <c:forEach begin="1" end="${pageInfo.totalPages}" var="p">
                                <c:url var="pageUrl" value="/approval24/history/list">
                                    <c:param name="page" value="${p}" />
                                    <c:if test="${filterMap.approvalStatusCd != null and filterMap.approvalStatusCd != ''}">
                                        <c:param name="approvalStatusCd" value="${filterMap.approvalStatusCd}" />
                                    </c:if>
                                    <c:if test="${filterMap.categoryCd != null and filterMap.categoryCd != ''}">
                                        <c:param name="categoryCd" value="${filterMap.categoryCd}" />
                                    </c:if>
                                    <c:param name="pageSize" value="${pageInfo.pageSize}" />
                                </c:url>
                                <li class="page-item ${p == pageInfo.page ? 'active' : ''}">
                                    <a class="page-link" href="${pageUrl}">${p}</a>
                                </li>
                            </c:forEach>

                            <!-- 다음 -->
                            <c:url var="nextUrl" value="/approval24/history/list">
                                <c:param name="page" value="${pageInfo.page + 1}" />
                                <c:if test="${filterMap.approvalStatusCd != null and filterMap.approvalStatusCd != ''}">
                                    <c:param name="approvalStatusCd" value="${filterMap.approvalStatusCd}" />
                                </c:if>
                                <c:if test="${filterMap.categoryCd != null and filterMap.categoryCd != ''}">
                                    <c:param name="categoryCd" value="${filterMap.categoryCd}" />
                                </c:if>
                                <c:param name="pageSize" value="${pageInfo.pageSize}" />
                            </c:url>
                            <li class="page-item ${pageInfo.page == pageInfo.totalPages ? 'disabled' : ''}">
                                <a class="page-link" href="${nextUrl}">Next</a>
                            </li>
                          </ul>
                        </nav>

                        <!-- 현재 페이지 정보 -->
                        <div class="text-center mt-2">
                            현재 <strong>${pageInfo.page}</strong> 페이지 / 전체 <strong>${pageInfo.totalPages}</strong> 페이지
                        </div>
                        </c:if>

                    </div>
                </div>

            </div>
        </div>
        
        <div class="d-flex justify-content-between align-items-center mt-3">
    <div>
        <form id="pageSizeForm" method="get" action="/approval24/history/list">
            <input type="hidden" name="approvalStatusCd" value="${filterMap.approvalStatusCd}">
            <input type="hidden" name="categoryCd" value="${filterMap.categoryCd}">
            <select name="pageSize" onchange="this.form.submit()" class="form-select form-select-sm">
                <option value="5" ${pageInfo.pageSize == 5 ? 'selected' : ''}>5개씩</option>
                <option value="10" ${pageInfo.pageSize == 10 ? 'selected' : ''}>10개씩</option>
                <option value="15" ${pageInfo.pageSize == 15 ? 'selected' : ''}>15개씩</option>
            </select>
        </form>
    </div>

    <div>
        <ul class="pagination mb-0">
            <c:forEach var="i" begin="${pageInfo.startPage}" end="${pageInfo.endPage}">
                <li class="page-item ${i == pageInfo.page ? 'active' : ''}">
                    <a class="page-link"
                       href="?page=${i}&pageSize=${pageInfo.pageSize}&approvalStatusCd=${filterMap.approvalStatusCd}&categoryCd=${filterMap.categoryCd}">
                        ${i}
                    </a>
                </li>
            </c:forEach>
        </ul>
    </div>

    <div>
        <span>현재 ${pageInfo.page} / ${pageInfo.totalPages} 페이지</span>
    </div>
</div>
        

        <footer class="sticky-footer bg-white">
            <div class="container my-auto">
                <div class="copyright text-center my-auto">
                    <span>행정 &copy; 결재24 2025</span>
                </div>
            </div>
        </footer>
    </div>
</div>

<a class="scroll-to-top rounded" href="#page-top"> <i class="fas fa-angle-up"></i> </a>
<%@ include file="/WEB-INF/views/common/logoutModal.jsp"%>
<%@ include file="/WEB-INF/views/common/footer.jsp"%>

</body>
</html>
