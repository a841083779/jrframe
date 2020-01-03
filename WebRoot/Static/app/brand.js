/**
 * index
 */
define(function(require) {
	var $ = require('jquery');
	var base=require('base');
	require('./common');
	
	var ish = $(window).height();
	if(ish>770){
		$('body').addClass('wideScreen');
	}else{
		$('body').removeClass('wideScreen');
	};
	$(window).resize(function(){
		var ish = $(window).height();
		if(ish>770){
			$('body').addClass('wideScreen');
		}else{
			$('body').removeClass('wideScreen');
		};
		$('.brand_scroll').scrollBar({
			width:5
		});
	})
	
	$('.smd_img').each(function(i,e) {
		var h = $(this).parent().height();
		var w = $(this).parent().width();
		$(this).height(h).width(w).css('line-height',h+'px').find('img').css('max-height',h+'px');
    });
	
	$('.smd_logo').each(function() {
        var w = $(this).parent().width();
		$(this).width(w-2);
    });
	
	/*require('img-auto');
	$('.smd_img').imgAuto(function(){
	  //alert('回调')
	})*/
	
	//fullpage
	require('mousewheel');
	//插入导航
	(function() {
		if (base.getType() === 'Pc') {
			var _nav = '<ul class="circles">';
			for (var i = 0; i < $('.full_section').length; i++) {
				if (!i) {
					_nav += '<li class="current circles'+i+'"></li>';
				} else {
					_nav += '<li class="circles'+i+'"></li>';
				}

			};
			_nav += '</ul>';
			$('body').append(_nav);
		}
	})();
	var fullPageNav = $('.circles'), //翻屏按钮
		fullPageSection = $('.full_section'), //整屏元素
		duration = 480,
		footer = $('.footer'),
		windowH = $(window).height() - $('.head').height(),
		footerShow = false,
		pagelock = false,
		animate = { //每一屏的进出场动画
			sec1: {
				show: function($this) {

				},
				hide: function($this) {

				}
			},
			sec2: {
				show: function($this) {

				},
				hide: function($this) {

				}
			},
			sec3: {
				show: function($this) {

				},
				hide: function($this) {

				}
			},
			sec4: {
				show: function($this) {

				},
				hide: function($this) {

				}
			},
			sec5: {
				show: function($this) {

				},
				hide: function($this) {

				}
			},
			sec6: {
				show: function($this) {

				},
				hide: function($this) {

				}
			},
			sec7: {
				show: function($this) {

				},
				hide: function($this) {

				}
			},
			footer: {
				show: function() {
					$('.full_box').stop().animate({
						'top': -footer.outerHeight()
					}, duration, 'swing', function() {
						pagelock = false;
					});
					footer.stop().animate({
						'bottom': 0
					}, duration, 'swing', function() {
						pagelock = false;
					});
					footerShow = true;
				},
				hide: function() {
					$('.full_box').stop().animate({
						'top': 0
					}, duration, 'swing', function() {
						pagelock = false;
					});
					footer.stop().animate({
						'bottom': -footer.outerHeight()
					}, duration, 'swing', function() {
						pagelock = false;
					});
					footerShow = false;
				}
			}
		},
		current = 0,
		oldPage = 0,
		goPage = function(direct) {
			//翻页
			//判断是不是在页脚
			if (footerShow) {
				   animate.footer.hide();
				}
				
			$('.full_wrap').stop().animate({
				top: -current * windowH
			}, duration, 'swing', function() {
				//console.log('解锁')
				pagelock = false;
			});
			//圆点
			$('.circles li').eq(current).addClass('current').siblings().removeClass('current');
			//回调
			animate['sec' + (current + 1)].show(fullPageSection.eq(current));
			animate['sec' + (oldPage + 1)].hide(fullPageSection.eq(oldPage));
		},
		fullPageInit = function() {
			//页面高度
			$('.full_body').height(windowH);
			fullPageSection.fadeIn(duration);
			//滚轮驱动
			fullPageSection.each(function(i, e) {
				$(e).mousewheel(function(e) {
					if (pagelock) {
						//console.log('锁定')
						return false;
					}
					oldPage = current;
					current = current - e.deltaY;
					//第一页向上滚
					if (current < 0) {
						current = 0;
						return false;
					}
					pagelock = true;
					//隐藏底部
					if (e.deltaY > 0 && footerShow) {
						current = fullPageSection.size() - 1;
						animate.footer.hide();
						return false;
					}
					//显示底部
					if (current >= fullPageSection.size()) {
						current = fullPageSection.size() - 1;
						if (e.deltaY < 0 && !footerShow) {
							animate.footer.show();
						}
						return false;
					}
					goPage();
					return false;
				});
			});
			//圆点驱动
			if (fullPageNav.find('li').size() == fullPageSection.size()) {
				console.log('圆点驱动')
				fullPageNav.on('click', 'li', function(e) {
					e.preventDefault();
					oldPage = current;
					current = $(this).index();
					goPage();
				});
			};
			$(window).on('resize', function() {
				windowH = $(this).height() - $('.head').height();
			});
			$('.footer').mousewheel(function(e) {
				if (e.deltaY === 1) {
					animate.footer.hide();
				} else if (e.deltaY === -1) {
					animate.footer.show();
				}
				return false;
			});
		};
	//启动 
	if (base.getType() == "Pc") {
		//上一页下一页
		if ($('.fullpage_prev').size() && $('.fullpage_next').size()) {
			$('body').on('click', '.fullpage_prev', function() {
					oldPage = current;
					current--;
					//隐藏底部
					if (current < 0) {
						current = 0;
						if (footerShow) {
							current = fullPageSection.size() - 1;
							animate.footer.hide();
						}
						return false;
					}
					goPage();
				})
				.on('click', '.fullpage_next', function() {
					oldPage = current;
					current++;
					//显示底部
					if (current >= fullPageSection.size()) {
						current = fullPageSection.size() - 1;
						if (!footerShow) {
							animate.footer.show();
						}
						return false;
					}
					goPage();
				});
		}
		//pc启动
		fullPageInit();
	} else {
		//非pc全显示
		for (anim in animate) {
			if (anim != 'footer') {
				animate[anim]['show']();
			}
		}
	}
	
	$('.sm_dl').mouseenter(function(e) {
		$(this).find('.smd_logo').stop(1,1).animate({'bottom':'0'});
		$(this).find('.smd_plist').stop(1,1).animate({'bottom':'0'});
	}).mouseleave(function(e) {
		$(this).find('.smd_logo').stop(1,1).animate({'bottom':'-100%'});
		$(this).find('.smd_plist').stop(1,1).animate({'bottom':'-100%'});
	});
	
	require('scroll-bar');
    $('.brand_scroll').scrollBar({
		width:5
	});
	$('.brand_other .scroll_bar').height($('.brand_scroll').height());
	
	/*$('.smd_img').each(function(i,e) {
		var h = $(this).parent().height();
		var w = $(this).parent().width()
		$(this).addClass('smd_img_center').height(h).find('img').css({'margin-top':-(h/2)+'px','margin-left':-(w/2)+'px'})
    });*/
	
	
})

