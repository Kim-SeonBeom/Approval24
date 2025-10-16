$(document).on('click', '#dataTable tbody tr.clickable-row', function(e) {
	if ($(e.target).closest('a, button, input, [data-no-row-click]').length)
		return;

	const url = $(this).data('href');
	if (url) {
		window.location.assign(url);
	}
});