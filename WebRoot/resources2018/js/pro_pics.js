$(function(){
	/**
	 * 相关机型控制
	 */
	$('.o_or_c').on('click',function(){
		
		if($('.pico_main .inner').hasClass('have2')){
			$('.pico_main .inner').removeClass('have2');
			$(this).text('收起');
		}else{
			$('.pico_main .inner').addClass('have2');
			$(this).text('展开');
		}
		
	})
	
	
	
	/**
	 * 图片展示
	 */
	$('.count_pics').text($('.pic_main').find('img').length);
	$('.this_pic').text('1');
	$('.des_all2').text($('.xn_text').find('.kpic').eq(0).find('img').attr('data-des'));
	
	$('.pic_main').on('click','.kpic',function(){
		$('.gallery').fadeIn().removeClass('hide');
		initGallery($(this).attr('data-index')*1);
	})
	
	$('.gclose_btn').on('click',function(){
		$('.gallery').fadeOut(function(){
			$(this).addClass('hide');
		});
	})
	
	function initGallery(index){
		var galleryBig = new Swiper('.pb_main',{
			navigation: {
	      nextEl: '.next',
	      prevEl: '.prev',
	   	},
	   	on: {
		    slideChange: function(){
		    	$('.this_pic').text(this.activeIndex+1);
		    	$('.des_all2').text($(galleryBig.slides[this.activeIndex]).find('img').attr('data-des'));
		    },
		  },
		})
		var gallerySmall = new Swiper('.ps_main',{
			slidesPerView : 9,
			spaceBetween : 10,
			centeredSlides : true,
			slideToClickedSlide: true,
		})
		galleryBig.controller.control = gallerySmall;
		gallerySmall.controller.control = galleryBig;
		galleryBig.slideTo(index, 0, false);
	}
})