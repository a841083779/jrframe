/**
 * 
 */
define(function(require) {
	var $ = require('jquery');
	var base=require('base');
	var com=require('./common');
	
	/*$('.pro_top_hd').find('li').on('click',function(){
		$(this).addClass('cur').siblings('li').removeClass('cur');
	})*/
var words=$(".tdlp_dtitle").html();
words=words.replace("代理商","");
words=words.replace("口碑","");
words=words.replace("图片","");
$(".tdlp_dtitle").html(words);
	//头部漂浮
	var _top = $('.pro_top_hd').offset().top;
	$(window).scroll(function(){
		var scrolls = $(this).scrollTop();
		if(scrolls > _top){
			$('.pro_top_hd').addClass('smartfloat');
		}else{
			$('.pro_top_hd').removeClass('smartfloat');
		};
	});

	
	require('superslide');
	$(".pro_dt_p1 ._top").slider({titCell:".hd li",mainCell:".bd ul",effect:"leftLoop",vis:4,scroll:1,autoPlay:false,interTime:4000}); 
	$(".pro_dt_p1 ._top").find('li').hover(function(){
		var img_src=$(this).find('img').attr('src');
		$(".pro_dt_p1 ._top").find('._img img').attr('src',img_src)
	})

	
	
})

