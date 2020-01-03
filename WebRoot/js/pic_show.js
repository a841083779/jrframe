$(function(){
	
	console.log($('.xn_text').find('.kpic'))
	
	$('.kpic').each(function(){
		console.log()
		$(this).find('img').css('margin-top','-'+$(this).find('img').height()/2+'px');
	})
	
	//附默认值
	$('.count_pics').text($('.ps_main').find('img').length);
	$('.this_pic').text('1');
	$('.des_all2').text($('.xn_text').find('.kpic').eq(0).find('img').attr('data-des'));
	
	$('.kpics_box').on('click','.kpic',function(){
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
//					console.log($(galleryBig.slides[this.activeIndex]).find('img').attr('data-des'))
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