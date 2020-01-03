/*
 * lazyload.js
 * v1.0
 * 可用性升级
 * 2014-08-01
 */
define(function(require, exports, module) {
	var $ = require('$');
	require('img-loaded');
	
	$.fn.lazyload = function(config) {
		var opt = {
			effect: "show",        // show , fadeIn 
			firstCount: 1,	       //第一次加载数量
			everyCount: 1,	       //以后每次加载
			distance: 100          //进入视野距离
		},
		wrap = $(this),
		elements = wrap.is($(window)) ? $('img[data-lazy]') : wrap.find('img[data-lazy]');

		if(!elements.length) return;
		
		$.extend( opt, config || {});
		
		
		
		//初始加载	
		for (i = 0; i < opt.firstCount; i++) {
			if(i>elements.length) return;
			elements.eq(i).attr("src", elements.eq(i).data('lazy')).data('lazy', 'finish');
		};
		
		lazyload_(wrap);
		
		wrap.bind({
			'scroll':function() {
				lazyload_(this)
			},
			'resize':function() {
				lazyload_(this)
			}
		});
	
		function lazyload_(wrap_) {
			elements = elements.filter(function(){
				if($(this).data('lazy') !='finish'){
					return this;
				}
			});
			if (!elements.length) {
				$(wrap_).unbind();
				return;
			};
			$(wrap_).imagesLoaded(function(){
				
				if (elements.eq(0).offset().top < ($(wrap_).height() + $(wrap_).scrollTop() + opt.distance)) {
					for (i = 0; i < opt.everyCount; i++) {
						if(i>elements.length) return;
						
						elements.eq(i).hide().attr("src", elements.eq(i).data('lazy')).data('lazy', 'finish')[opt.effect](opt.effectspeed);
					}
					lazyload_(wrap_)
				}
			})
		}
	};

})