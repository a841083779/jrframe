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

	/*更多品牌展开*/
	$('.line_brand').on('click','.height',function(){
		if($('.line_brand .brand_box').hasClass('all')){
			$('.line_brand .brand_box').removeClass('all');
			$('.te').text('更多');
		}else{
			$('.line_brand .brand_box').addClass('all');
			$('.te').text('收起');
		}
	})
	

	
})