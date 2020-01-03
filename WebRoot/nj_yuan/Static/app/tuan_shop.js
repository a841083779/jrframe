/**
 * 
 */
define(function(require) {
	var $ = require('jquery');
	var base=require('base');
	var com=require('./common');
	
	
	if(base.browser.ie==7){
		$('.sl').each(function(i,e) {
            $(this).find('.cover').height($(this).outerHeight());
        });
	}
	
	//layout
	var mainH = $(window).height()-$('.tuan_top').outerHeight();//主体高度
	$('.mainH').height(mainH);
	$('.ts_menus').height(mainH-$('.ts_left .n').outerHeight());
	$('.sliderBox,.sld_li').height(mainH-90)
	
	//window resize
	$(window).resize(function(){
		
		var ish = $(window).height();
		if(ish>770){
			$('body').addClass('wideScreen');
		}else{
			$('body').removeClass('wideScreen');
		};
		
		var mainH = $(window).height()-$('.tuan_top').outerHeight();//主体高度
		$('.mainH').height(mainH);
		$('.ts_menus').height(mainH-$('.ts_left .n').outerHeight());
		$('.sliderBox,.sld_li').height(mainH-90)
	});
	
	//禁止左侧a标签打开url
	$('.ts_menus a').click(function(e){
		e.preventDefault();
	});
	
	//主体切换
	require('superslide');
	$('.tuan_shopBox').slider({titCell:'.ts_menus li',mainCell:'.tr_wrap',effect:"top",autoPlay:false,trigger:'click'});
	
	//内部切换
	require('slide');
	$(".tr01 .sl").each(function(i){$(".tr01 .sl").slice(i*12,i*12+12).wrapAll('<div class="sld_li"></div>');});//16分组
	$(".tr02 .sl").each(function(i){$(".tr02 .sl").slice(i*12,i*12+12).wrapAll('<div class="sld_li"></div>');});//16分组
	$('.sliderBox').slide({wrap:'.sld_wrap',cell:'.sld_li',auto:false,act:'click'})
	//品牌悬停效果
	$('.sl').mouseenter(function(){
		$(this).find('.cover').stop().animate({top:0},'fast')
	}).mouseleave(function(){
		$(this).find('.cover').stop().animate({top:'100%'},'fast')
	});
		
})

