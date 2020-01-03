/**
 * index
 */
define(function(require) {
   var $ = require('$');
	var base=require('base');
	require('./common');
	//var responsive=require('modules/responsive');

	//屏幕判断
	//console.log(responsive.getType());

	
	require('modules/swiper.css');
	require.async('modules/swiper',function(){
		var mySwiper = new Swiper('.index',{
		  pagination:'.pagination',
		  paginationClickable:true,
		  autoplay:5000,
		  loop:true,
		  autoplayDisableOnInteraction:false
		});	
		$('.arr_left').on('click', function(e){
		  e.preventDefault()
		  mySwiper.swipePrev()
		});
		$('.arr_right').on('click', function(e){
		  e.preventDefault()
		  mySwiper.swipeNext()
		});
		/*resize*/
		$('.tianjian_banner').height($('.swiper-slide').find('img').height()+126);
		$(window).resize(function(){
			$('.tianjian_banner').height($('.swiper-slide').find('img').height()+126);
		});
	});
	
	
	$('.pdcon .pdt').click(function(){
		$(this).next('div.pdc').toggle();
		$('html,body').stop(1,0).animate({scrollTop:$(this).offset().top},0);
	});
	
	$('.tjList li:odd').addClass('odd');

})



