<%@ page pageEncoding="UTF-8" %>
<%@ page import="java.util.*, java.util.stream.Collectors, com.example.approval24.domain.MenuVO" %>

<%
    List<MenuVO> menus = (List<MenuVO>) session.getAttribute("authMenus");
    if (menus == null) {
        menus = new ArrayList<>();
    }

    // 메뉴 순서대로 정렬 (SEQ 기준, null 안전)
    menus.sort(Comparator.comparingLong(m -> m.getSeq() != null ? m.getSeq() : 0));

    // 부모 메뉴만 추출 (ID null 제외)
    List<MenuVO> parentMenus = menus.stream()
                                    .filter(m -> m.getParentMenuId() == null && m.getMenuId() != null)
                                    .collect(Collectors.toList());
%>

<ul class="navbar-nav bg-gradient-primary sidebar sidebar-dark accordion" id="accordionSidebar">

    <div class="gyeolje24" style="background-color: white;">
        <a class="sidebar-brand d-flex align-items-center justify-content-center text-dark" href="/approval24/">
            <div class="sidebar-brand-icon rotate-n-15">
                <img src="${pageContext.request.contextPath}/resources/assets/img/work24.png" width="40">
            </div>
            <div class="sidebar-brand-text mx-3">결재24</div>
        </a>
    </div>

    <hr class="sidebar-divider my-0">

    <%
        for (MenuVO parent : parentMenus) {

            // 권한 없는 메뉴는 표시 안함
            if (!"Y".equals(parent.getReadYn())) continue;

            // 자식 메뉴 추출 (null 안전)
            List<MenuVO> childMenus = menus.stream()
                                        .filter(m -> m.getParentMenuId() != null && m.getParentMenuId().equals(parent.getMenuId()))
                                        .sorted(Comparator.comparingLong(m -> m.getSeq() != null ? m.getSeq() : 0))
                                        .collect(Collectors.toList());

            String dataTarget = childMenus.isEmpty() ? "" : "#collapse" + parent.getMenuId();
            String dataToggle = childMenus.isEmpty() ? "" : "collapse";
    %>
        <li class="nav-item">
            <a class="nav-link" href="<%= parent.getMenuUrl() != null ? parent.getMenuUrl() : "#" %>" 
               data-toggle="<%= dataToggle %>" 
               data-target="<%= dataTarget %>" 
               aria-expanded="false" aria-controls="collapse<%= parent.getMenuId() %>">
                <span><%= parent.getMenuName() %></span>
            </a>

            <%
                if (!childMenus.isEmpty()) {
            %>
                <div id="collapse<%= parent.getMenuId() %>" class="collapse" aria-labelledby="heading<%= parent.getMenuId() %>" data-parent="#accordionSidebar">
                    <div class="bg-white py-2 collapse-inner rounded">
                        <%
                            for (MenuVO child : childMenus) {
                                if (!"Y".equals(child.getReadYn()) || child.getMenuId() == null) continue;
                        %>
                            <a class="collapse-item" href="<%= child.getMenuUrl() != null ? child.getMenuUrl() : "#" %>"><%= child.getMenuName() %></a>
                        <%
                            }
                        %>
                    </div>
                </div>
            <%
                }
            %>
        </li>
        <hr class="sidebar-divider d-none d-md-block">
    <%
        }
    %>
</ul>

<!-- Bootstrap collapse JS -->
<script>
    document.addEventListener("DOMContentLoaded", function() {
        var collapseElements = document.querySelectorAll('.collapse');
        collapseElements.forEach(function(el) {
            el.addEventListener('show.bs.collapse', function () {
                collapseElements.forEach(function(other) {
                    if (other !== el) {
                        var bsCollapse = bootstrap.Collapse.getInstance(other);
                        if (bsCollapse) bsCollapse.hide();
                    }
                });
            });
        });
    });
</script>
