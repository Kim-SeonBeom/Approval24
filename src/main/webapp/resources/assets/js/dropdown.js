        <script>
        $(document).ready(function(){
        	var currentPath = window.location.pathname;
        	
        	$('.collapse-item').each(function(){
        		var itemHref = $(this).attr('href');
        		
        		if (itemHref && currentPath.indexOf(itemHref) === 0){
        			$(this).addClass('bg-gray-500');
        			
        			var $collapseDiv = $(this).closest('.collapse');
        			$collapseDiv.addClass('show');
        			
        			$collapseDiv.prev('.nav-link.collapsed')
        									.removeClass('collapsed')
        									.attr('aria-expanded', 'true');
        			
        			$collapseDiv.closest('.nav-item').addClass('active');

        		}
        	});
        	// 나머지 비활
        	$('.sidebar .nav-item:not(:has(.collapse)) > .nav-link').each(function() {
        		var linkHref = $(this).attr('href');
        		
        		if (linkHref === currentPath) {
        			$(this).closest('.nav-item').addClass('active');
        		}
        	});
        });
        </script>