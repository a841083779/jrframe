$(function(){
	/**
	 * 图片浏览
	 */
	
	function initGallery(){
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
	}
	function initLess(){
		$('.ps_main .swiper-slide').css('margin-left','5px');
		$('.ps_main .swiper-slide').eq(0).addClass('on');
		$('.roll_photo .prev').addClass('hide');
		$('.roll_photo .next').addClass('hide');
		$('.ps_main').on('click','.swiper-slide',function(){
			var thisPic = $(this).index();
			$('.pb_main').find('.swiper-slide').eq(thisPic).removeClass('hide').siblings().addClass('hide');
			$(this).addClass('on').siblings().removeClass('on');
		})
	}
	
	
							var lengs = $('.ps_main').find('.swiper-slide').length;
	if(lengs<=7){
		initLess();
	}else{
		initGallery();
	}
	
	
	
	
	
	
	
	
	$("#wg").click(function(){
	   $('#wg').addClass("on");
	   $('#qt').removeClass("on");
	   $('#xj').removeClass("on");
	  var pid=$('#pro_id').val();
	  var title=$('#title').val();
 	   jQuery.ajax({
			url : '/photo_domain/detail_pic.jsp',
			data : {
				flag : 'wg',
				id : pid,
				title:title
			},
			success : function(data) {
					if($.trim(data)!=""){
						$("#photo_show").html(data);
	var leng = $('.ps_main').find('.swiper-slide').length;
	if(leng<=7){
		initLess();
	}else{
		initGallery();
	}
					}
			}
		});
});
$("#xj").click(function(){
	   $('#wg').removeClass("on");
	   $('#qt').removeClass("on");
	   $('#xj').addClass("on");
 var pid=$('#pro_id').val();
  var title=$('#title').val();
 	   jQuery.ajax({
			url : '/photo_domain/detail_pic.jsp',
			data : {
				flag : 'xj',
				id : pid,
				title:title
			},
			success : function(data) {
					if($.trim(data)!=""){
						$("#photo_show").html(data);
										var leng = $('.ps_main').find('.swiper-slide').length;
	if(leng<=7){
		initLess();
	}else{
		initGallery();
	}	
					}
			}
		});
});
$("#qt").click(function(){
	 $('#wg').removeClass("on");
	   $('#qt').addClass("on");
	   $('#xj').removeClass("on");
 var pid=$('#pro_id').val();
  var title=$('#title').val();
 	   jQuery.ajax({
			url : '/photo_domain/detail_pic.jsp',
			data : {
				flag : 'qt',
				id : pid,
				title:title
			},
			success : function(data) {
					if($.trim(data)!=""){
						$("#photo_show").html(data);
						var leng = $('.ps_main').find('.swiper-slide').length;
	if(leng<=7){
		initLess();
	}else{
		initGallery();
	}
					}
			}
		});
});	
	
	
	 	jQuery.ajax({
			url : '/photo_domain/detail_other_pro.jsp',
			data : {
			
			},
			success : function(data) {
					if($.trim(data)!=""){
						$("#other_pic").html(data);
					}
			}
		});
		
		 var pro_id=$('#pro_id').val();
		jQuery.ajax({
			url : '/photo_domain/ajax.jsp',
			data : {
			    flag : 'xj',
				pro_id : pro_id,
			},
			success : function(data) {
					if($.trim(data)!=""){
						$("#xjcount").html('('+$.trim(data)+'张)');
					}
			}
		});
		
		jQuery.ajax({
			url : '/photo_domain/ajax.jsp',
			data : {
			    flag : 'qt',
				pro_id : pro_id,
			},
			success : function(data) {
					if($.trim(data)!=""){
						$("#qtcount").html('('+$.trim(data)+'张)');
					}
			}
		});
		
		
			/**
	 * 右侧跟随动作
	 */
	$(window).scroll(function(){
		var scrolls = $(this).scrollTop(),
		_top = $('.pro_main').offset().top,
		_max = $('.j_foot').offset().top-$('.pro_right').height();
		
		console.log($('.pro_right').height())
		
		if(scrolls>=_top){
			if(scrolls<_max){
				$('.pro_right').addClass('follow').css('top',scrolls-40+'px');
			}else{
				$('.pro_right').addClass('follow').css('top',_max-50+'px');
			}
		}else{
			$('.pro_right').removeClass('follow').css('top','0px');
		}
	})
	
})