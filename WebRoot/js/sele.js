$.fn.sele=function(config) {
	var opt={
			act:"click", // mouseenter
			callback:function(){}
		 },
		 this_=this,
		 hidemenu=function(){
			setTimeout(function(){
				$(this_).removeClass('on').find('.sele_').fadeOut(128);
				},100)
			};
	$.extend(opt, config || {}, $(this).data('config') || {});
	//层级处理
	var _all=$('.sele').length;
		
	_all>1 && $(this_).css('z-index',_all-$(this_).index('.sele'));

	//open			
	$(this_).on(opt.act,function(e){
		e.stopPropagation();
		if($(this_).find('.sele_:visible').length){
			hidemenu();
		}else{
			$(this_).addClass('on').find('.sele_').fadeIn(128);
		}
	});
	//close
	if(opt.act!=="click"){
		$(this_).on("mouseleave", function(){
			hidemenu();
			});
		}else{
			$(document).mouseup(function(e){
			  if(!$(this_).is(e.target) && $(this_).has(e.target).length === 0){ 
				hidemenu();
			 }
		})
	};
	$(this_).find('.sele_ a').bind('click',function(e){
		e.stopPropagation();
		if(!$(this).attr('target')){
			e.preventDefault();
			var _val=$(this).data('val') ? $(this).data('val') : $(this).text(), _text=$(this).text();
			$(this_).find('.val_ span').text(_text);
			hidemenu();
			opt.callback(_val, _text)
			};
		});
};