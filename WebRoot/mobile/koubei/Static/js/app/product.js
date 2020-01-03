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

		/*resize
		$('.index').height($('.swiper-slide').find('img').height());
		$(window).resize(function(){
			$('.index').height($('.swiper-slide').find('img').height());
		});*/
	});
	
	$('.detailT .tool').mouseenter(function(){
		$(this).find('.lk').show();
	}).mouseleave(function(){
		$(this).find('.lk').hide();
	});
	
	require.async('modules/idTabs',function(){
		$(".idTabs").idTabs("!click");
	});
	
	$('.proC .pcc .load_more').click(function(){ 
		var na = $(this).parent().find('.pcc_nr');
		na.toggleClass('height_auto'); 
		if( na.hasClass('height_auto') ){ 
			$(this).html('收起');
			$(this).addClass('add_sqbtn');
		}else{ 
			$(this).html('加载更多'); 
			$(this).removeClass('add_sqbtn');
		} 
	});
	
	

})



