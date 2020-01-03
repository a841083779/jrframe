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
//ads
$('.gg_eff').mouseenter(function(){
	$(this).css('z-index',100).find('.gg_layer').show();
}).mouseleave(function(){
	$(this).removeAttr('style').find('.gg_layer').hide();
});

$('.nav_proCate_layer .npl').mouseenter(function(){
	$(this).addClass('npl_cur');
}).mouseleave(function(){
	$(this).removeClass('npl_cur');
})
//选项卡
$.fn.tab=function(){
	var $key=$(this).find('.j_tab_key'),
		 $val=$(this).find('.j_tab_val');
	$key.first().addClass('cur');
	$val.first().show();
	$key.each(function(index){
		$(this).hover(function(event){
			event.preventDefault();
			$(this).addClass('cur').siblings().removeClass('cur');
			$val.hide().eq(index).show();
			})
		})
	};
$('.j_tab').each(function() { $(this).tab()});

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