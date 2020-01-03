/*
J_lazyload

v0.9

*/
define(function(require, exports, module) {
   var $ = require('$');

$.fn.lazyload = function(options) {
	var settings = {
		wrap: window,
		effect: "show",
		original: "original",
		firstCount: 1,	//第一次加载数量
		everyCount: 1,	//以后每次加载
		moveScrollTop: 100 //进入视野距离
	};
	options || $.extend(settings, options);
	var elements = this;
	for (i = 0; i < settings.firstCount; i++) {
		$(elements[i]).attr("src", $(elements[i]).attr(settings.original)).attr(settings.original, "finish");
	};
	lazyload_(settings.wrap);
	$(settings.wrap).bind({
		'scroll':function() {
			lazyload_(this)
			},
		'resize':function() {
			lazyload_(this)
			}
		});

	function lazyload_(wrap) {
		var wrap_ = wrap;
		elements = elements.filter(function(){
			if($(this).attr(settings.original) !='finish'){
				return this;
				}
			});
		if (!elements.length) {
			$(wrap_).unbind();
			return;
		};
		if ($(elements[0]).offset().top < ($(wrap_).height() + $(wrap_).scrollTop() + settings.moveScrollTop)) {
			for (i = 0; i < settings.everyCount; i++) {
				$(elements[i]).hide().attr("src", $(elements[i]).attr(settings.original)).attr(settings.original, "finish")[settings.effect](settings.effectspeed);
			}
		}
	}
};

})