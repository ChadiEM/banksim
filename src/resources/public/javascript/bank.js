(function() {
	$('#Tab a').click(function (e) {
		e.preventDefault();
		$(this).tab('show');
	})
}).call(this);
