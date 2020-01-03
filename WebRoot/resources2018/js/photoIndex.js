$(function(){
	
	$('.allCates .acn').after($('.acLayer'));
	$('.allCates').mouseover(function(){
		$(this).find('.acLayer').show();
	}).mouseleave(function(){
		$(this).find('.acLayer').hide();
	});
	$('.acLayer .acb').mouseenter(function(){
		$(this).addClass('acb_hover');
	}).mouseleave(function(){
		$(this).removeClass('acb_hover');
	});
	$('.acLayer').children('.acb:last').addClass('last')

	/**
	 * 图片展示tab切换
	 */
	
	$('.pic_tab').on('mouseover','a',function(){
		var $this = $(this);
		$this.addClass('on').siblings().removeClass('on');
		var mains = $('.pici_main');
		mains.addClass('hide');
		mains.eq($this.index()).removeClass('hide');
	})
	
})