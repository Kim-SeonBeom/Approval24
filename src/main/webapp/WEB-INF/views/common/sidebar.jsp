<%@page pageEncoding="UTF-8" %>
<!-- Sidebar -->
        <ul class="navbar-nav bg-gradient-primary sidebar sidebar-dark accordion" id="accordionSidebar">

            <!-- Sidebar - Brand -->
            <div class="gyeolje24" style="background-color: white;">
            <a class="sidebar-brand d-flex align-items-center justify-content-center text-dark" href="/approval24/">
                <div class="sidebar-brand-icon rotate-n-15">
                    <img src="${pageContext.request.contextPath}/resources/assets/img/work24.png" width= 40px;>
                </div>
                <div class="sidebar-brand-text mx-3">결재24</div>
            </a>
            </div>
            
            <!-- Divider -->
            <hr class="sidebar-divider my-0">

            <!-- Nav Item - Dashboard -->
            <li class="nav-item">
    			<a class="nav-link" href="/approval24/">
        			<img src="${pageContext.request.contextPath}/resources/assets/img/home.svg" class="nav-icon-blur" style="width: 18px; margin-right: 3px; ">
        		<span>메인</span></a>
			</li>

            <!-- Divider -->
            <hr class="sidebar-divider">
            
            <!-- Nav Item - Dropdown -->
            <li class="nav-item">
                <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapsePages"
                    aria-expanded="true" aria-controls="collapsePages">
                    <img src="${pageContext.request.contextPath}/resources/assets/img/side_search.svg" class="nav-icon-blur" style="width: 18px; margin-right: 3px;">
                    <span>실업급여</span>
                </a>
                <div id="collapsePages" class="collapse" aria-labelledby="headingPages" data-parent="#accordionSidebar">
                    <div class="bg-white py-2 collapse-inner rounded">
                    	<h6 class="collapse-header">처리 현황</h6>
                        <a class="collapse-item" href="/approval24/tables">대기</a>
                        <a class="collapse-item" href="/approval24/tables">반려</a>
                        <a class="collapse-item" href="/approval24/tables">승인</a>
                    </div>
                </div>
            </li>
            
            
            <!-- Nav Item - Tables -->
            <li class="nav-item">
                <a class="nav-link" href="/approval24/tables">
                   <img src="${pageContext.request.contextPath}/resources/assets/img/side_search.svg" class="nav-icon-blur" style="width: 18px; margin-right: 3px;">
                    <span>실업인정</span></a>
            </li>
            
            <!-- Nav Item - Tables -->
            <li class="nav-item">
                <a class="nav-link" href="/approval24/tables">
                    <img src="${pageContext.request.contextPath}/resources/assets/img/side_search.svg" class="nav-icon-blur" style="width: 18px; margin-right: 3px;">
                    <span>조기 재취업수당</span></a>
            </li>
               <!-- Divider -->
            <hr class="sidebar-divider d-none d-md-block">
            
            <!-- Nav Item - notice -->
            <li class="nav-item">
                <a class="nav-link" href="/approval24/notice">
                    <img src="${pageContext.request.contextPath}/resources/assets/img/notice.svg" class="nav-icon-blur" style="width: 18px; margin-right: 3px;">
                    <span>공지사항</span></a>
            </li>
            
            <hr class="sidebar-divider d-none d-md-block">
            
            <!-- Sidebar Search -->
            <form
                class="d-none d-sm-inline-block form-inline mr-auto ml-md-3 my-2 my-md-0 mw-100 navbar-search">
                <div class="input-group" style="margin: 10px 10px 10px -3px;">
                    <input type="text" class="form-control bg-light border-0 small" placeholder="Search for..."
                    aria-label="Search" aria-describedby="basic-addon2">
                    <div class="input-group-append">
                        <button class="btn btn-primary" type="button" style="background-color:gray;">
                           <i class="fas fa-search fa-sm"></i>
                        </button>
                    </div>
                 </div>
            </form>
                    
            <hr class="sidebar-divider d-none d-md-block">

            <!-- Sidebar Toggler (Sidebar) -->
            <div class="text-center d-none d-md-inline">
                <button class="rounded-circle border-0" id="sidebarToggle"></button>
            </div>

        </ul>
<!-- End of Sidebar -->

<!-- <script>
    document.addEventListener('DOMContentLoaded', function() {
        var navItems = document.querySelectorAll('.navbar-nav .nav-item');
        
        var storedActiveLink = localStorage.getItem('activeSidebarLink');

        //  활성화 스타일을 적용하고 초기화하는 핵심 함수 
        function applyActiveStyles(targetLink, isInitialLoad) {
            
            navItems.forEach(function(item) {
                var link = item.querySelector('.nav-link');
                var img = item.querySelector('.nav-icon-blur');
                var span = item.querySelector('span');

                if (link && img && span) {
                    var linkPath = link.getAttribute('href');
                    var originalSrc = img.getAttribute('src');

                    // 1. 모든 항목의 스타일 초기화 (비활성 상태)
                    link.style.backgroundColor = ''; 
                    // 💡 글자색 인라인 스타일을 ''로 설정하여 CSS에 위임합니다.
                    span.style.color = ''; 
                    
                    // 이미지 필터 및 투명도 복구 (CSS가 제어하도록 인라인 스타일을 제거)
                    img.style.filter = ''; 
                    img.style.opacity = '';
                    span.style.opacity = '';

                    // 이미지 경로 복구 (2.svg -> .svg)
                    if (originalSrc.endsWith('2.svg')) {
                        img.setAttribute('src', originalSrc.replace('2.svg', '.svg'));
                    }

                    // 2. 타겟 링크와 일치하는 항목에 활성 스타일 적용
                    if (link === targetLink || (!targetLink && linkPath === storedActiveLink)) {
                        
                        // 스타일 적용: 흰색 배경, 파란색 글자
                        link.style.backgroundColor = 'white'; 
                        span.style.color = '#4e73df'; 
                        span.style.opacity = '1'; // 활성화 시 선명하게
                        
                        // 이미지 경로 변경: .svg -> 2.svg
                        if (originalSrc.endsWith('.svg') && !originalSrc.endsWith('2.svg')) {
                            var newSrc = originalSrc.replace('.svg', '2.svg');
                            img.setAttribute('src', newSrc);
                        }
                        img.style.filter = 'none';
                        img.style.opacity = '1'; // 활성화 시 선명하게
                    }
                }
            });

            // 3. 초기 로드가 아닌 클릭 이벤트라면, 로컬 저장소 업데이트
            if (!isInitialLoad && targetLink) {
                 localStorage.setItem('activeSidebarLink', targetLink.getAttribute('href'));
            }
        }


        //  A. 페이지 로드 시 상태 확인 및 적용 
        if (storedActiveLink) {
            var targetLinkOnLoad = document.querySelector('a.nav-link[href="' + storedActiveLink + '"]');
            // 로컬 저장소에 저장된 링크와 현재 페이지 URL이 일치하는지 추가 확인 (선택 사항)
            if (targetLinkOnLoad && targetLinkOnLoad.getAttribute('href') === window.location.pathname) {
                 applyActiveStyles(targetLinkOnLoad, true); // true = 초기 로드
            } else {
                 // 페이지 이동 후, URL이 저장된 링크와 다를 경우 저장된 링크를 초기화 (필요하다면)
                 // localStorage.removeItem('activeSidebarLink');
            }
        }
       
        // B. 클릭 이벤트 리스너 추가 
        navItems.forEach(function(item) {
            var link = item.querySelector('.nav-link');
            
            if (link) {
                link.addEventListener('click', function(event) {
                    // 스타일 적용 (클릭 시 로컬 저장소에 저장까지 포함)
                    applyActiveStyles(link, false); // false = 클릭 이벤트
                    
                    // 페이지 이동은 기본 동작으로 허용
                });
            }
        });
    });
</script> -->