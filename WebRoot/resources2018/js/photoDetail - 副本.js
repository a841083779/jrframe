$(function(){
	/**
	 * 图片浏览
	 */
	var leng = $('.ps_main').find('.swiper-slide').length;
	var galleryBig = new Swiper('.pb_main',{
		effect:'fade'
	})
	var gallerySmall = new Swiper('.ps_main',{
		navigation: {
      nextEl: '.next',
      prevEl: '.prev',
   	},
		slidesPerView : 'auto',
		spaceBetween : 5,
    loop:true,
		slideToClickedSlide: true,
		on:{
			slideChange:function(){
				galleryBig.slideTo(this.activeIndex%leng)
			}
		}
	})
	
})