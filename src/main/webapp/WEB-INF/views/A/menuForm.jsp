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
                        <c:when test="${menu != null && menu.menuId != null}">메뉴 수정</c:when>
                        <c:otherwise>메뉴 등록</c:otherwise>
                    </c:choose>
                </h1>
                <br>

                <div class="card shadow mb-4">
                    <div class="card-body">
                        <form id="menuForm" action="<c:choose>
                                            <c:when test='${menu != null && menu.menuId != null}'>
                                                ${pageContext.request.contextPath}/menu/edit
                                            </c:when>
                                            <c:otherwise>
                                                ${pageContext.request.contextPath}/menu/create
                                            </c:otherwise>
                                            </c:choose>" 
                              method="post">
                            
                            <input type="hidden" name="menuId" value="${menu != null ? menu.menuId : ''}"/>

                            <div class="form-group">
                                <label for="menuName">메뉴명</label>
                                <input type="text" class="form-control" id="menuName" name="menuName" 
                                        value="${menu != null ? menu.menuName : ''}" required>
                            </div>

                            <div class="form-group">
                                <label for="menuUrl">URL</label>
                                <input type="text" class="form-control" id="menuUrl" name="menuUrl" 
                                        value="${menu != null ? menu.menuUrl : ''}">
                            </div>

                            <div class="form-group">
                                <label for="parentMenuId">부모 메뉴</label>
                                <div class="d-flex align-items-center">
                                    <select class="form-control" id="parentMenuId" name="parentMenuId" style="max-width: 300px;">
                                        <option value="">해당사항 없음</option>
                                        <c:forEach var="pm" items="${parentMenus}">
                                            <option value="${pm.menuId}" 
                                                <c:if test="${menu != null && pm.menuId == menu.parentMenuId}">selected</c:if>>
                                                ${pm.menuName}
                                            </option>
                                        </c:forEach>
                                    </select>
                                    <span id="selectedParentId" class="ml-3 text-gray-600 small">
                                        <c:if test="${menu != null && menu.parentMenuId != null}">
                                            선택된 ID: ${menu.parentMenuId}
                                        </c:if>
                                        <c:if test="${menu == null || menu.parentMenuId == null}">
                                            선택된 ID: 없음
                                        </c:if>
                                    </span>
                                </div>
                            </div>

                            <div class="form-group">
                                <label for="seq">정렬순서</label>
                                <input type="number" class="form-control" id="seq" name="seq" 
                                        value="${menu != null ? menu.seq : '100'}"
                                        placeholder="0 이상의 정수만 입력"
                                        min="0" required>
                            </div>

                            <div class="form-group">
                                <label for="popupYn">팝업 여부</label>
                                <select class="form-control" id="popupYn" name="popupYn">
                                    <option value="Y" <c:if test="${menu != null && menu.popupYn == 'Y'}">selected</c:if>>Y</option>
                                    <option value="N" <c:if test="${menu != null && menu.popupYn == 'N'}">selected</c:if>>N</option>
                                </select>
                            </div>

                            <button type="submit" class="btn btn-primary">
                                <c:choose>
                                    <c:when test="${menu != null && menu.menuId != null}">수정</c:when>
                                    <c:otherwise>등록</c:otherwise>
                                </c:choose>
                            </button>
                            <a href="${pageContext.request.contextPath}/menu/list" class="btn btn-secondary">취소</a>
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

<script>
document.addEventListener('DOMContentLoaded', function() {
    const parentSelect = document.getElementById('parentMenuId');
    const idDisplay = document.getElementById('selectedParentId');
    const menuForm = document.getElementById('menuForm'); // 💡 ID로 폼 선택
    const seqInput = document.getElementById('seq'); // 💡 SEQ 입력 필드 선택

    // ---------------------------------------------
    // 1. 부모 메뉴 ID 표시 로직 (기존 로직 유지)
    // ---------------------------------------------
    parentSelect.addEventListener('change', function() {
        const selectedId = this.value;
        if (selectedId === "") {
            idDisplay.textContent = "선택된 ID: 없음";
        } else {
            idDisplay.textContent = "선택된 ID: " + selectedId;
        }
    });

    // ---------------------------------------------
    // 2. 순서(SEQ) 필수 입력 강제 로직 (신규 추가)
    // ---------------------------------------------
    menuForm.addEventListener('submit', function(e) {
        // HTML5 required와 min="0" 속성이 1차 방어를 하지만, 
        // JavaScript로 서버 전송 전 최종 검사하여 안정성을 높입니다.
        const seqVal = seqInput.value.trim();

        // 숫자가 아니거나 (비어있거나) 0보다 작은지 검사
        if (seqVal === '' || !/^\d+$/.test(seqVal) || parseInt(seqVal, 10) < 0) {
            e.preventDefault(); // 폼 제출 중지

            // 사용자에게 알림
            alert("🚨 메뉴 순서(SEQ) 값은 필수 입력 사항입니다.\n0 이상의 정수 값을 입력해 주세요.");
            
            // 오류 필드로 포커스 이동
            seqInput.focus();
            return false;
        }
    });
});
</script>