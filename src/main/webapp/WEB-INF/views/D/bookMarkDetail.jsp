<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>${bookmark.bookmarkName} 상세 정보</title>
    <style>
        table, th, td { border: 1px solid black; border-collapse: collapse; padding: 8px; }
        .section { margin-top: 20px; }
        .button-group { margin-top: 10px; }
        .approver-row { position: relative; }
        .remove-approver { cursor: pointer; background: #ff4d4d; color: white; border: none; padding: 5px 8px; border-radius: 3px; font-weight: bold; }
    </style>
</head>
<body>
    <h1>북마크 상세 정보 📋</h1>
    
    <%-- 🛑 기본 정보 및 북마크 이름 수정/삭제 폼 --%>
    <div class="section">
        <h3>기본 정보 및 관리</h3>
        <p><strong>ID:</strong> ${bookmark.bookmarkId}</p>
        <p><strong>생성일:</strong> ${bookmark.createDt}</p>
        
        <%-- 1. 북마크 이름 수정 폼 --%>
        <form action="/approval24/bookmark/update" method="post" style="display:inline;">
            <input type="hidden" name="bookmarkId" value="${bookmark.bookmarkId}">
            <label for="newName">북마크 이름 수정:</label>
            <input type="text" id="newName" name="bookmarkName" value="${bookmark.bookmarkName}" required>
            <button type="submit">이름 수정</button>
        </form>
        
        <%-- 2. 북마크 논리적 삭제 폼 --%>
        <form action="/approval24/bookmark/update" method="post" style="display:inline; margin-left: 15px;" 
              onsubmit="return confirm('정말 이 북마크를 삭제하시겠습니까? (논리적 삭제)');">
            <input type="hidden" name="bookmarkId" value="${bookmark.bookmarkId}">
            <input type="hidden" name="delYn" value="Y"> <button type="submit" style="background-color: #ffcccc;">북마크 삭제</button>
        </form>
    </div>

    <%-- 🛑 결재자 목록 수정 폼 (JavaScript로 개별 삭제 처리) --%>
    <div class="section">
        <h3>결재자 목록 수정 (교체)</h3>
        
        <form action="/approval24/bookmark/approver/replace" method="post" id="approverUpdateForm">
            <input type="hidden" name="bookmarkId" value="${bookmark.bookmarkId}">
            
            <table id="approverTable">
                <thead>
                    <tr>
                        <th>순번</th>
                        <th>결재자 ID</th>
                        <th>이름</th>
                        <th>부서</th>
                        <th>유형 코드</th>
                        <th>유형 이름</th>
                        <th>제거</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="appr" items="${bookmark.approvers}" varStatus="status">
                        <tr class="approver-row" data-seq="${appr.seqNo}">
                            <td>${status.index + 1}</td>
                            <td>${appr.approverId}</td>
                            <td>${appr.approverName}</td> 
                            <td>${appr.deptName}</td> 
                            <td>${appr.approverTypeCd}</td>
                            <td>${appr.approverTypeCdName}</td>
                            <td>
                                <button type="button" class="remove-approver">X</button>
                            </td>
                            
                            <%-- ⭐️ 서버로 전송될 Hidden Field (JS에서 인덱스 재정렬 필요) ⭐️ --%>
                            <input type="hidden" name="approvers[${status.index}].approverId" value="${appr.approverId}">
                            <input type="hidden" name="approvers[${status.index}].approverTypeCd" value="${appr.approverTypeCd}">
                            </tr>
                    </c:forEach>
                </tbody>
            </table>
            
            <button type="submit" class="button-group">결재자 목록 최종 수정 반영</button>
        </form>
    </div>
    
    <p style="margin-top: 30px;"><a href="/approval24/bookmark/list">목록으로 돌아가기</a></p>

    <script>
    document.addEventListener('DOMContentLoaded', function() {
        
        // 1. 'X' 버튼 클릭 이벤트 리스너 설정
        document.querySelectorAll('.remove-approver').forEach(button => {
            button.addEventListener('click', function() {
                if (confirm('이 결재자를 목록에서 제거하시겠습니까? (수정 반영 시 삭제됩니다)')) {
                    const row = this.closest('tr');
                    row.remove(); // 화면에서 행 제거
                    reindexApprovers(); // 인덱스 재정렬 함수 호출
                }
            });
        });

        // 2. 폼 제출 전 인덱스를 재정렬하여 DTO 바인딩 오류 방지
        function reindexApprovers() {
            const tableBody = document.querySelector('#approverTable tbody');
            let index = 0;
            
            tableBody.querySelectorAll('tr').forEach(row => {
                // 행 안에 있는 모든 Hidden Input을 찾아서 인덱스를 업데이트
                row.querySelectorAll('input[type="hidden"]').forEach(input => {
                    const name = input.getAttribute('name');
                    if (name && name.startsWith('approvers[')) {
                        // 예: approvers[0].approverId -> approvers[새인덱스].approverId
                        input.name = name.replace(/approvers\[\d+\]/g, 'approvers[' + index + ']');
                    }
                });
                
                // 테이블의 순번도 업데이트 (시각적인 요소)
                row.querySelector('td:first-child').textContent = index + 1;
                index++;
            });
        }
    });
    </script>
</body>
</html>