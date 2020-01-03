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
	
	/**
	 * tip出现及消失 
	 */
	$('.line_title .price i').on('mouseenter',function(){
		$(this).siblings('.pri_tip').fadeIn(100);
	})
	$('.line_title .price i').on('mouseleave',function(){
		$(this).siblings('.pri_tip').fadeOut(100);
	})
	
	/**
	 * 列表展开
	 */
	$('.shm_con').on('click','.zk_list',function(){
		
		//var $this = $(this),
		//thisList = $(this).parents('.brand_item').find('.bi_table').eq(0);
		//if(thisList.hasClass('on')){
			//thisList.removeClass('on');
			//$this.find('span').text('展开全部');
		//}else{
			//thisList.addClass('on');
			//$this.find('span').text('收起所有');
		//}
	})
	
	
})