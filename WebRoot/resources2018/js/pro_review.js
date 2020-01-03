$(function(){
	
	/**
	 * 测评栏目切换
	 */
	$('.review_nav').on('mouseover','a',function(){
		console.log($(this).index());
		$(this).addClass('on').siblings().removeClass('on');
		$('.review_lm .r_lm').eq($(this).index()).removeClass('hide').siblings().addClass('hide');
	})
	
	
})