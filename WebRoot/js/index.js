$.fn.inputholder=function(){
	var dval=$(this).val();
	$(this).focus(function(){
		$(this).val('').addClass('focus');
		}).blur(function(){
		if($(this).val()==''){
			$(this).val(dval).removeClass('focus');
			}
		});
	};
var inputholder=$('.inputholder');
if(inputholder.length){
	inputholder.each(function() {
      $(this).inputholder()
   })
};
//topbar layer
$('.j_mobile,.j_service,.j_siteNav').mouseenter(function(){
	$(this).addClass('j_hover');
}).mouseleave(function(){
	$(this).removeClass('j_hover');
});
$('.j_proNav').mouseenter(function(){
	$(this).addClass('j_proNav_hover');
}).mouseleave(function(){
	$(this).removeClass('j_proNav_hover');
});
//选择区域
$('.j_area_box').mouseenter(function(){
	$(this).addClass('j_area_box_hover');
}).mouseleave(function(){
	$(this).removeClass('j_area_box_hover');
});
//ads
$('.gg_eff').mouseenter(function(){
	$(this).css('z-index',100).find('.gg_layer').show();
}).mouseleave(function(){
	$(this).removeAttr('style').find('.gg_layer').hide();
});

$('.nav_proCate_layer .npl').mouseenter(function(){
	$(this).addClass('npl_cur');
}).mouseleave(function(){
	$(this).removeClass('npl_cur');
})
//选项卡
$.fn.tab=function(){
	var $key=$(this).find('.j_tab_key'),
		 $val=$(this).find('.j_tab_val');
	$key.first().addClass('cur');
	$val.first().show();
	$key.each(function(index){
		$(this).hover(function(event){
			event.preventDefault();
			$(this).addClass('cur').siblings().removeClass('cur');
			$val.hide().eq(index).show();
			})
		})
	};
$('.j_tab').each(function() { $(this).tab()});

$(".scl ul li").hover(function(){
	$(this).toggleClass("cur");
},function(){
	$(this).removeClass("cur");
});

$("a.CloseAllBtn").click(function(){
	$(".nav_proCate").removeClass("bigBtnCur");
	return false;
});

$(".nav_proCate").children('.n').click(function(){
	   var par = $(this).parent();
	   var cls = par.attr("class");
	   if(cls.indexOf("bigBtnCur")!=-1){
		   par.removeClass("bigBtnCur");
	   }else{
		   par.addClass("bigBtnCur");
	   }
 });

//
$('.ggSlider').slide({
     wrap: 'ul',           //指定包裹元素
     cell: 'li',           //指定切换元素
     effect:'slide',       //切换效果，默认slide，可选slide\fade\toggle
     speed:500,            //切换速度
     start:0,              //起始帧，默认0，即从第一张开始
     auto:true,            //自动播放
     pause:true,           //设置是否鼠标滑过暂停，默认true，触屏下建议设为false
     time:5e3,             //自动播放间隔
     act:"mouseenter",     //导航按钮触发事件
     prev:null,            //指定左箭头，默认无，自动添加'.arrs .arr_prev'
     next:null,            //指定右箭头，默认无，自动添加'.arrs .arr_next'
     imgattr: 'data-src',  //按需加载图片的地址存放属性名称
     callback:function(a,b,c){},   //回调，@param ($this,$b_,n) : 效果元素，切换元素，当前帧序号
     ext:function(a,b,c){},        //扩展，@param ($this,$b_,count) : 效果元素，切换元素，总帧数
     reload:false          //是否重载slide，修改配置并重载slide时该值必须为true
  });	

$('.top_info .j_tab_keylist .j_tab_key:last').addClass('last');

$('.imgEff').find('img').hover(function(){
	$(this).stop().animate({opacity:0.7},160);
},function(){
	$(this).stop().animate({opacity:1},160);
});

$('.ql06 a').each(function(i, e) {
	$(e).tip($('.ql_ewm'),{
		act:'click',
		place:'left-in',
		callback:function(e){}
	})
});

/*$('.j_com_banner').each(function() {
    $(this).slide({
	   wrap: 'ul',           //指定包裹元素
	   cell: 'li',           //指定切换元素
	   effect:'slide',       //切换效果，默认slide，可选slide\fade\toggle
	   speed:500,            //切换速度
	   start:0,              //起始帧，默认0，即从第一张开始
	   auto:true,            //自动播放
	   pause:true,           //设置是否鼠标滑过暂停，默认true，触屏下建议设为false
	   time:5e3,             //自动播放间隔
	   act:"mouseenter",     //导航按钮触发事件
	   prev:null,            //指定左箭头，默认无，自动添加'.arrs .arr_prev'
	   next:null,            //指定右箭头，默认无，自动添加'.arrs .arr_next'
	   imgattr: 'data-src',  //按需加载图片的地址存放属性名称
	   callback:function(a,b,c){},   //回调，@param ($this,$b_,n) : 效果元素，切换元素，当前帧序号
	   ext:function(a,b,c){},        //扩展，@param ($this,$b_,count) : 效果元素，切换元素，总帧数
	   reload:false          //是否重载slide，修改配置并重载slide时该值必须为true
	});
});
*/
$('.jcr01').each(function() {
    $(this).slide({
	   wrap: 'ul',           //指定包裹元素
	   cell: 'li',           //指定切换元素
	   effect:'slide',       //切换效果，默认slide，可选slide\fade\toggle
	   speed:500,            //切换速度
	   start:0,              //起始帧，默认0，即从第一张开始
	   auto:true,            //自动播放
	   pause:true,           //设置是否鼠标滑过暂停，默认true，触屏下建议设为false
	   time:5e3,             //自动播放间隔
	   act:"mouseenter",     //导航按钮触发事件
	   prev:null,            //指定左箭头，默认无，自动添加'.arrs .arr_prev'
	   next:null,            //指定右箭头，默认无，自动添加'.arrs .arr_next'
	   imgattr: 'data-src',  //按需加载图片的地址存放属性名称
	   callback:function(a,b,c){},   //回调，@param ($this,$b_,n) : 效果元素，切换元素，当前帧序号
	   ext:function(a,b,c){},        //扩展，@param ($this,$b_,count) : 效果元素，切换元素，总帧数
	   reload:false          //是否重载slide，修改配置并重载slide时该值必须为true
	});
});	  
/*
$('.jcr01_long').each(function() {
    $(this).slide({
	   wrap: 'ul',           //指定包裹元素
	   cell: 'li',           //指定切换元素
	   effect:'slide',       //切换效果，默认slide，可选slide\fade\toggle
	   speed:500,            //切换速度
	   start:0,              //起始帧，默认0，即从第一张开始
	   auto:true,            //自动播放
	   pause:true,           //设置是否鼠标滑过暂停，默认true，触屏下建议设为false
	   time:5e3,             //自动播放间隔
	   act:"mouseenter",     //导航按钮触发事件
	   prev:null,            //指定左箭头，默认无，自动添加'.arrs .arr_prev'
	   next:null,            //指定右箭头，默认无，自动添加'.arrs .arr_next'
	   imgattr: 'data-src',  //按需加载图片的地址存放属性名称
	   callback:function(a,b,c){},   //回调，@param ($this,$b_,n) : 效果元素，切换元素，当前帧序号
	   ext:function(a,b,c){},        //扩展，@param ($this,$b_,count) : 效果元素，切换元素，总帧数
	   reload:false          //是否重载slide，修改配置并重载slide时该值必须为true
	});
});*/
  
$('.j_s3 .j_com_right,.j_s5 .j_com_right').each(function() {
    $(this).find('.jcr03:eq(0)').css('width','198px');
});
$('.j_s3 .j_com_right,.j_s5 .j_com_right').each(function() {
    $(this).find('.jcr03:eq(1)').css('width','199px');
});

$('.j_brand').sele({act:"click",
  callback:function(val,text){
	  $("#factory").val(val);
	  //点击选项后的回调,val是data-val的值，text是a标签内文字
  }    
})

$('.j_catalog').sele({act:"click",
  callback:function(val,text){
	  $("#catalog").val(val);
	  //点击选项后的回调,val是data-val的值，text是a标签内文字
  }    
})

 /*$('.hb_bd_box').scroll({
     direct: 'left',            // 自动播放方向，可选left | right
     mode: '',                  // 特殊模式，可选 hero(全屏三图滚动) | unloop（不循环）
     num: 99,                   // 滚动个数，默认99，即能显示几个显示几个
     auto: true,                // 自动播放
     time: 5e3,                 // 自动播放间隔
     speed: 256,                // 滚动速度
     step: 1,                   // 每次滚动个数
     wrap: 'ul',                // 指定滚动包裹元素
     cell: 'li',                // 指定滚动元素
     prev: '.hb_prev',                // 指定向左按钮，默认无，将添加 '.arrs .arr_prev'
     next: '.hb_next',                // 指定向右按钮，默认无，将添加 '.arrs .arr_next' 
     callback: function(a){},   // 回调 @param (nowStep)
     ext: function(a,b,c){}     // 扩展 @param (this, showNumber, allStep)
  });*/
  
  $(".hb_bd").slider({ mainCell:".hb_bd_box ul",effect:"leftLoop",vis:5,scroll:5,autoPlay:false,autoPage:true,interTime:4000,prevCell:".hb_prev",nextCell:".hb_next"});
  $(".hb_bd").find('.hb_arr').click(function(){
  	return false;
  });
  
  $('.part_box li:last').addClass('last');
  
  $('.pic01 li').hover(function(){
	  $("div.text", this).stop().animate({top:'0px'},{queue:false,duration:160});
  }, function() {
	  $("div.text", this).stop().animate({top:'92px'},{queue:false,duration:160});
  });
  $('.pic02 li').hover(function(){
	  $("div.text", this).stop().animate({top:'0px'},{queue:false,duration:160});
  }, function() {
	  $("div.text", this).stop().animate({top:'94px'},{queue:false,duration:160});
  });
  
  //foot js
  $('.gotop').click(function(){$('html,body').stop().animate({scrollTop:'0'},300)});
  $('.j_foot01 li:last,.side_box li:last').css('border-right-width','0');
  $('.sl_box li:last').css('border-bottom-width','0');
  $('.sideLayer .p_btn').click(function(){
	if($(this).hasClass('p_btn_hide')){
		$(this).removeClass('p_btn_hide');
		$(this).prev('.sl_box').slideDown('fast');
		$('.sideLayer').animate({marginTop:5},300);
	}else{
		$(this).addClass('p_btn_hide');
		$(this).prev('.sl_box').slideUp('fast');
		$('.sideLayer').animate({marginTop:200},300);
	}
  });
  $('.side_box .close').click(function(){
	 	$(this).parent('.side_box').hide();
	 })
/*1000响应用*/	 
$('.j_s3 .j_com_right,.j_s4 .j_com_right,.j_s5 .j_com_right,.j_s6 .j_com_right').each(function() {
    $(this).find('.jcr02:last').addClass('last');
	$(this).find('.jcr03:last').addClass('last');
});	 
$('.j_used_list li:last').addClass('last');
  