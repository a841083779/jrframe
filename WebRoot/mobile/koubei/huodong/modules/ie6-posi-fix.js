//ie6-posi-fix
define(function(require, exports, module) {
   var $ = require('$');
	var base=require('base');
	
	$.fn.ie6Fix=function(opt){
		var $this=$(this),
			 posiTop=opt ? opt.posi : $this.css('top')!='auto' ? true : ($this.css('bottom')!='auto' ? false : "noposi"),
			 selfHei=$this.outerHeight(true),
			 $H,	
			 posiVal=opt ? opt.val : (posiTop==="noposi") ? 0 : posiTop ? parseFloat($(this).css('top')) : parseFloat(base.getStyle($(this).get(0),'bottom'));//不设置纵向定位默认top:0
		$this.css('position','absolute');
		function rePosi(window){
			$H=$(window).height();
			$this.css('top',posiTop ? $(window).scrollTop()+posiVal : $H-selfHei-posiVal+$(window).scrollTop());
			};
		rePosi(window);
		$(window).bind('resize',function(){rePosi(window)});
		$(window).bind('scroll',function(){rePosi(window)});
		};

});