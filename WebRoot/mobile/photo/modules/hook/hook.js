/**
 * Hook
 * Version: 0.9
 * Author: zangtao
 */

define(function(require, exports, module) {
	var $ = require('$');
	require('./hook.css');
	
    $.fn.hook = function (config) {
		 var defaults={
			 	callback:null
			 },
			 opt=$.extend({},defaults,config),
			 hookwrap=$(this).get(0),
			 $hook, touchY, moveY, scrollTop, torefresh;
			 
		$(hookwrap).prepend('<div class="hook"><div class="hook-loader"><div class="hook-spinner"></div></div></div>');
		$hook =  $(hookwrap).children('.hook');
		hookwrap.ontouchstart=function(e){
			touchY = e.touches[0].pageY;
			torefresh=false;
		};
		hookwrap.ontouchmove=function(e){
			moveY = parseFloat(touchY-e.touches[0].clientY);
			scrollTop = $(this).scrollTop();
			if (scrollTop<=0 && moveY<-80) {
				$hook.slideDown(200);
				torefresh=true;
			}
		};
		hookwrap.ontouchend=function(e){
			if (torefresh) {
				$hook.stop(1,1).delay(500).slideUp(200, function () {
					if(!opt.callback){
						window.location.reload()
					}else{
						opt.callback()
					}
				})
			}
		}
		hookwrap.ontouchcancel = function(e) {
			e.preventDefault();
			isfresh=false;
		}

    };

})
