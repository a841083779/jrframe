/**
 * index
 */
define(function(require) {
   var $ = require('$');
	var base=require('base');
	require('./common');
	//var responsive=require('modules/responsive');

	//屏幕判断
	//console.log(responsive.getType());

	require('modules/validator.js');
	require('modules/swiper.css');
	require('modules/upload/upload');

	require.async('modules/swiper',function(){
		var mySwiper = new Swiper('.index',{
		  pagination:'.pagination',
		  paginationClickable:true,
		  autoplay:5000,
		  loop:true,
		  autoplayDisableOnInteraction:false
		});	
		$('.arr_left').on('click', function(e){
		  e.preventDefault()
		  mySwiper.swipePrev()
		})
		$('.arr_right').on('click', function(e){
		  e.preventDefault()
		  mySwiper.swipeNext()
		})

		/*resize*/
		$('.index').height($('.swiper-slide').find('img').height());
		$(window).resize(function(){
			$('.index').height($('.swiper-slide').find('img').height());
		});
	});
	
	   $("#upload").uploadify({
      auto     : true,                       //自动上传，false可以多选，true只能传一张（或者pc上一次选多张）
      width    : 120,                         //选择按钮宽度
      height   : 30,    
	  fileTypeExts:"*.gif; *.jpg; *.png",     //格式筛选
	  type:"h5",                                  //指定上传方式，当传入‘h5’时会忽略屏幕判断直接使用h5方式上传
      buttonText: '选择图片',  	  //选择按钮高度
      uploader  : '/action/control.jsp?method=single_upload',                         //上传处理程序
      onUploadSuccess : function(file, data){  //上传完成回调 @param(file, data) : 当前文件对象， 服务端返回字符串
			console.log(data)
			setChatImg(data);
			}       
   });	
   
   
    
   
   function setChatImg(data){
          var b=eval("("+data+")");
		  $("#mig_show").attr("src",b.fullPath);
		$("#zd_image").val(b.fullPath);
		
	}
		
	function loginOut(){
	$.post("/action/ajax_mobile.jsp",{message:"exit"},function(data){
		if($.trim(data)=="loginOut"){
			window.location.href="/";
		}
	});
}
	



})



