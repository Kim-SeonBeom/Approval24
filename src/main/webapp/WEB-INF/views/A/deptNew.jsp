<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:useBean id="now" class="java.util.Date" />

<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<title>부서 등록 | 결재24</title>
<style>
/* 표 기반(딱딱한) 작성 레이아웃 */
.kv-table th { width: 140px; background: #f8f9fc; vertical-align: middle; }
.kv-table td { background: #fff; }
/* 상세와 동일한 룩앤필 유지 */
.kv-table .content-cell { white-space: pre-wrap; line-height: 1.6; min-height: 300px; }
/* 파일 리스트 UI 정리 */
.kv-table .attach-cell ul { margin: 0; padding-left: 1rem; }
.kv-table .attach-cell li+li { margin-top: .25rem; }
</style>
</head>
<body id="page-top">

  <div id="wrapper">
    <%@ include file="/WEB-INF/views/common/sidebar.jsp"%>

    <div id="content-wrapper" class="d-flex flex-column">
      <div id="content">
        <%@ include file="/WEB-INF/views/common/navbar.jsp"%>

        <div class="container-fluid">

          <!-- 상단 제목/버튼 -->
          <div class="d-sm-flex align-items-center justify-content-between mb-3">
            <h1 class="h3 mb-0 text-gray-800">부서 등록</h1>
          </div>

          <div class="card shadow mb-4">
            <div class="card-header py-3 d-flex align-items-center">
              <h6 class="m-0 font-weight-bold text-primary" style="line-height: 1.5;">작성 항목</h6>
              <div class="ml-auto">
                <!-- 폼 밖에 있지만 JS로 제출 -->
                <button type="button" class="btn btn-primary btn-sm" id="btnSaveTop">
                  <i class="fas fa-save mr-1"></i>등록
                </button>
                <a href="${pageContext.request.contextPath}/admin/dept" class="btn btn-danger btn-sm">취소</a>
              </div>
            </div>

            <div class="card-body">
              <!-- 부서 등록 폼 -->
              <form id="deptInsertForm" action="/approval24/admin/dept/new" method="post">
                <c:if test="${not empty _csrf}">
                  <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                </c:if>

                <div class="table-responsive">
                  <table class="table table-bordered table-sm kv-table">
                    <colgroup>
                      <col style="width: 18%;">
                      <col style="width: 32%;">
                      <col style="width: 18%;">
                      <col style="width: 32%;">
                    </colgroup>
                    <tbody>

                      <!-- 부서명 -->
                      <tr>
                        <th scope="col" class="text-dark bg-light font-weight-bold">부서명</th>
                        <td colspan="3">
                          <input type="text"
                                 name="deptName"
                                 id="deptName"
                                 class="form-control form-control-sm"
                                 placeholder="부서명을 입력하세요"
                                 required
                                 maxlength="200" />
                        </td>
                      </tr>

                      <!-- 연락처 / 등록일(표시용) -->
                      <tr>
                        <th scope="col" class="text-dark bg-light font-weight-bold">연락처</th>
                        <td>
                          <input type="tel"
                                 name="deptPhone"
                                 id="deptPhone"
                                 class="form-control form-control-sm"
                                 placeholder="010-xxxx-xxxx" />
                        </td>
                        <th>등록일</th>
                        <td>
                          <!-- 표시용(서버에서 SYSDATE로 처리한다면 disabled로 전송 제외) -->
                          <input type="date"
                                 class="form-control"
                                 value="<fmt:formatDate value='${now}' pattern='yyyy-MM-dd'/>"
                                 disabled />
                        </td>
                      </tr>

                      <!-- 소속 기관 체크박스 -->
                      <tr>
                        <th class="text-dark bg-light font-weight-bold">소속 기관</th>
                        <td colspan="3">
                          <div style="display:flex; flex-wrap:wrap; gap:8px 16px; line-height:1.8;">
                            <c:forEach var="inst" items="${getAllInst}">
                              <label class="d-inline-flex align-items-center mb-1">
                                <input type="checkbox"
                                       name="instIds"
                                       value="${inst.instId}"
                                       class="mr-1" />
                                ${inst.instName}
                              </label>
                            </c:forEach>
                          </div>
                        </td>
                      </tr>

                    </tbody>
                  </table>
                </div>
              </form>
            </div>
          </div>

        </div>
      </div>

      <footer class="sticky-footer bg-white">
        <div class="container my-auto">
          <div class="copyright text-center my-auto">
            <span>Copyright &copy; Your Website 2020</span>
          </div>
        </div>
      </footer>
    </div>
  </div>

  <a class="scroll-to-top rounded" href="#page-top"><i class="fas fa-angle-up"></i></a>

  <%@ include file="/WEB-INF/views/common/logoutModal.jsp"%>
  <%@ include file="/WEB-INF/views/common/footer.jsp"%>

<script>
// 등록 버튼 클릭 시 폼 제출
$(document).ready(function() {
  $('#btnSaveTop').on('click', function() {
    const form = document.getElementById('deptInsertForm');
    if (!form.checkValidity()) return;
    $('#deptInsertForm').submit();
  });
});
</script>

</body>
</html>
