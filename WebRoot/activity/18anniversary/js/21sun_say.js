$(function(){
		
	/**
	 * 提示框 开启/关闭
	 */
	$('body').on('click',function(){
		$('.tip_mask').fadeIn().removeClass('hide');
	})
	$('.close_it').on('click',function(){
		$(this).parents('.tip_mask').fadeOut(function(){
			$(this).addClass('hide');
		});
	})
})