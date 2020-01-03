$(function(){
	//content高度控制
	var windowHeight = $(window).height(),
	headerHeight = window.getComputedStyle(document.getElementsByClassName('header')[0]).height,
	mainHeight = windowHeight - parseFloat(headerHeight);
	$('.content').css('height',mainHeight+'px');
})