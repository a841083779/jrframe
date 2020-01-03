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
		})
		$('.arr_right').on('click', function(e){
		  e.preventDefault()
		  mySwiper.swipeNext()
		})

		/*resize*/
		$('.index').height($('.swiper-slide').find('img').height());
		$(window).resize(function(){
			$('.index').height($('.swiper-slide').find('img').height());
		});
	});

})



