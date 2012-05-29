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


$(function() {
	$("#amountWithdraw").keyup(function () {
		var value = $(this).val();
		$("#slider-vertical-withdraw").slider('value', value);
	}).keyup();
	$("#slider-vertical-withdraw").slider({
	range: "min",
	min: 0,
	max: 400,
	value: 40,
	slide: function (event, ui) {
		$("#amountWithdraw").val(ui.value);
	}
	});
	$("#amountWithdraw").val($("#slider-vertical-withdraw").slider("value"));
});
