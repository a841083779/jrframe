/*
J_sele

v0.9

*/
define(function(require, exports, module) {
   var $ = require('$');
	require('./sele.css');
	
	$.fn.sele=function(config) {
		var def={
				act:"mouseenter",
				fn:null
				},
		   opt=$.extend(def, config || {}, $(this).data('config') || {}),
			 val;
		$(this).on(opt.act,function(){sele_show(this,opt.act)}).on('mouseleave',function(){sele_hide(this)});
		function sele_show(me,evt){
			$(me).find('.sele_').stop(1,0).slideDown(128).children('a').unbind().bind('click',function(event){
				event.stopPropagation();
				if(!$(this).attr('target')){
					event.preventDefault();
					if($(me).find('.btn').length){
						$(me).find('.btn').attr('href',$(this).attr('href'))
					};
					$(this).parent().hide().parents('.sele').find('span').text($(this).text());
					$(this).parent().children('a').unbind();
					if(opt.fn){
						val=$(this).text();
						opt.fn(val)
						};
				};
			})
		};
		function sele_hide(me){
			$(me).find('.sele_').stop(1,0).slideUp(128)
		};
	};
	
	
});