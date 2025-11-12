document.addEventListener('DOMContentLoaded', function () {
  // 클릭 의도 기록 - 그대로 유지
  document.addEventListener('click', function (e) {
    var a = e.target.closest('a');
    if (!a) return;

    if (a.classList.contains('collapse-item')) {
      var container = a.closest('.collapse');
      if (container && container.id) {
        sessionStorage.setItem('keepCollapse', '1');
        sessionStorage.setItem('lastOpenCollapse', container.id);
      }
    } else {
      sessionStorage.removeItem('keepCollapse');
      sessionStorage.removeItem('lastOpenCollapse');
    }
  }, true);

  // 고정
  var keep = sessionStorage.getItem('keepCollapse') === '1';
  var last = sessionStorage.getItem('lastOpenCollapse');

  if (keep && last) {
    var el = document.getElementById(last);
    if (el && !el.classList.contains('show')) {
      var opened = document.querySelectorAll('.collapse.show');
      for (var i = 0; i < opened.length; i++) {
        var other = opened[i];
        if (other !== el) {
          other.classList.remove('show');

          var togglers = document.querySelectorAll('[data-target="#' + other.id + '"], [data-bs-target="#' + other.id + '"]');
          for (var j = 0; j < togglers.length; j++) {
            var toggler = togglers[j];
            toggler.classList.add('collapsed');
            toggler.setAttribute('aria-expanded', 'false');
          }
        }
      }

      // 대상 섹션을 즉시 펼침(애니메이션 없음)
      el.classList.add('show');
      el.style.height = '';

      // 해당 토글러도 펼쳐진 상태로 업데이트
      var parentTogglers = document.querySelectorAll('[data-target="#' + last + '"], [data-bs-target="#' + last + '"]');
      for (var k = 0; k < parentTogglers.length; k++) {
        var pt = parentTogglers[k];
        pt.classList.remove('collapsed');
        pt.setAttribute('aria-expanded', 'true');
      }
    }
  }
});