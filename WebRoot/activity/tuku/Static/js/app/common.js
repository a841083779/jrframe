/**
 * common
 */
define(function(require) {
	var $ = require('$');
	var base=require('base');
	//var res=require('modules/responsive');
	//gotop
	$('body').on('click','.gotop',function(){$('html,body').stop().animate({scrollTop:'0'},300)});
	//fontsizer
	var $speech=$('.myart'),defaultsize=parseFloat($speech.css('font-size'));
	$('#switcher a').click(function(){
		var num=parseFloat($speech.css('font-size'));
		switch(this.id){
			case'small':num/=1.4;
			break;
			case'big':num*=1.4;
			break;
			default:num=defaultsize;
		}
		$speech.css('font-size',num+'px');
	});
	// placeholder
	var $placeholder=$('.placeholder');
	if($placeholder.length && !('placeholder' in document.createElement('input'))){
		$placeholder.each(function(index, element) {
			var placeval=$(this).attr('placeholder');
			$(this).val(placeval).on({
				'blur':function(){
				if($.trim($(this).val())===''){$(this).val(placeval).removeClass('on')}
				},
				'focus':function(){
					if($(this).val()===placeval){$(this).val('').addClass('on')}
					}});
		});
	};
	//fadeIn
	$(function(){
		//page
		$('.opc0').animate({'opacity':'1'},'fast');
	});
	
	//menu
	require.async('modules/mmenu',function(){
		$('#menu').mmenu({
			position:'left',
			slidingSubmenus:false
		});
	});
	$('.searchBtn').click(function(){
		$('#searchContainer').toggle();
	});
	$('.gotop').click(function(){$('html,body').stop().animate({scrollTop:'0'},300)});	
	
	require.async('modules/bdshare',function(bds){
	  bds({
		title:'',  //分享标题，默认当前页title
		desc:'',   //分享简介，默认空
		url:'',    //分享url，默认当前页url
		tag:'',    //分享配置标签，默认全局配置，设置此项将仅适配有对应data-tag属性的分享按钮组
		size:'24',   //分享图标大小，默认16px，可选16\24\32
		style:'',  //分享图标类型，默认0，可选0\1\2
		mini : ''  //更多图标显示列数，默认两列，可选1\2
	   });
	});
	
	var bh = $('.bottomBar .comment').height()
		var th = $('.bottomBar .tel').height()
		$('.bottomBar').height(bh);
		$('.bottomBar .share').height(bh);
		$('.bottomBar .share .bds_more').css('padding-top',$('.bottomBar .share').width());
		$('.bottomBar .share,.bottomBar .comment').css('margin-top',-bh/2);
		$('.bottomBar .tel').css('margin-top',(bh-th)/2);
		$(window).resize(function(){
			var bh = $('.bottomBar .comment').height()
			var th = $('.bottomBar .tel').height()
			$('.bottomBar').height(bh);
			$('.bottomBar .share').height(bh);
			$('.bottomBar .share .bds_more').css('padding-top',$('.bottomBar .share').width());
			$('.bottomBar .share,.bottomBar .comment').css('margin-top',-bh/2);
			$('.bottomBar .tel').css('margin-top',(bh-th)/2);
		});
		
	$('nav .more').mouseenter(function(){
		$(this).find('.box').show();
	}).mouseleave(function(){
		$(this).find('.box').hide();
	});
	
	$('.kb_tab_list ._t4').mouseenter(function(){
		$(this).find('.box').show();
	}).mouseleave(function(){
		$(this).find('.box').hide();
	});
	
	$.fn.inputholder=function(){
	var dval=$(this).val();
	$(this).focus(function(){
		$(this).val('').addClass('focus');
		}).blur(function(){
		if($(this).val()==''){
			$(this).val(dval).removeClass('focus');
			}
		});
	};
	var inputholder=$('.inputholder');
	if(inputholder.length){
		inputholder.each(function() {
		  $(this).inputholder()
	   })
	};
	
})

