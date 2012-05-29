$(function() {
	$("#amount").keyup(function () {
		var value = $(this).val();
		$("#slider-vertical").slider('value', value);
	}).keyup();
	$("#slider-vertical").slider({
	range: "min",
	min: 0,
	max: 400,
	value: 40,
	slide: function (event, ui) {
		$("#amount").val(ui.value);
	}
	});
	$("#amount").val($("#slider-vertical").slider("value"));
});
