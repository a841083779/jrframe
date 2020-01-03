// JavaScript Document
//首页产品分类
$('.nav_proCate_layer .npl').mouseenter(function(){
	$(this).addClass('npl_cur');
}).mouseleave(function(){
	$(this).removeClass('npl_cur');
})

//banner
$(".txd_ggSlider").slider({titCell:".hd ul",mainCell:".bd ul",effect:"left",autoPlay:true,autoPage:true,interTime:3000});

//旗舰店
$(".tdx_qjdScroll .bd li").each(function(i){ jQuery(".tdx_qjdScroll .bd li").slice(i*8,i*8+8).wrapAll("<ul></ul>");});
$(".tdx_qjdScroll").slider({titCell:".hd ul",mainCell:".bd .qjd_cell",effect:"left",autoPlay:true,autoPage:true,interTime:4000});
$('.tdx_qjdScroll .bd li').hover(function(e) {
	$(this).find('.img2').stop(1,1).animate({"left":"0px"},600);
},function(e) {
	$(this).find('.img2').stop(1,1).animate({"left":"130px"},600);
});

//热门品牌
$(".txd_hot_brandScroll").slider({titCell:".hd ul",mainCell:".bd ul",effect:"left",autoPlay:true,autoPage:true,interTime:4000});

//首页产品
$('.txd_mpro_list li').hover(function(e) {
	$(this).find('.mp_price').show();
		
},function(e) {
	$(this).find('.mp_price').hide();
	
});

//热门品牌-横向
$(".iptab_brandScroll").slider({titCell:".hd ul",mainCell:".bd ul",effect:"left",autoPlay:true,autoPage:true,interTime:4000,vis:6});