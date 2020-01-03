/*新网站头部需要*/
$(document).ready(function(e) {
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
	//topbar layer
	$('.j_mobile,.j_service,.j_siteNav').mouseenter(function(){
		$(this).addClass('j_hover');
	}).mouseleave(function(){
		$(this).removeClass('j_hover');
	});
	$('.j_proNav').mouseenter(function(){
		$(this).addClass('j_proNav_hover');
	}).mouseleave(function(){
		$(this).removeClass('j_proNav_hover');
	});
	//选择区域
	$('.j_area_box').mouseenter(function(){
		$(this).addClass('j_area_box_hover');
	}).mouseleave(function(){
		$(this).removeClass('j_area_box_hover');
	});
	//产品分类按钮弹层
    $(".scl ul li").hover(function(){
		$(this).toggleClass("cur");
	},function(){
		$(this).removeClass("cur");
	});
	$("a.CloseAllBtn").click(function(){
		$(".nav_proCate").removeClass("bigBtnCur");
		return false;
	});
	$(".nav_proCate").children('.n').click(function(){
		   var par = $(this).parent();
		   var cls = par.attr("class");
		   if(cls.indexOf("bigBtnCur")!=-1){
			   par.removeClass("bigBtnCur");
		   }else{
			   par.addClass("bigBtnCur");
		   }
	 });
});

