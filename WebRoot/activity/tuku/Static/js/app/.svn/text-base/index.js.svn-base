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
      uploader  : '/action/upload_json.jsp?method=single_upload',                         //上传处理程序
      onUploadSuccess : function(file, data){  //上传完成回调 @param(file, data) : 当前文件对象， 服务端返回字符串
			//console.log(data)
			 //setChatImg(data);
			 		    jQuery("#is_image").val('1');

			 var b=eval("("+data+")");
			 var htm =  '<li style="float:left"><img class="img" src="'+b.fullPath+'" width="90" height="60" /><input type="hidden" id="images" name="images"  value="'+b.fullPath+'" /><a href="javascript:void(0);" onclick="removeThis(this);" attrId="0" class="img_delete" style="position:absolute;top:-7px;left:80px;"><img src="http://member.21-sun.com/home/used/images/delete.png" /></a></li>';
			 jQuery("#addImgs_show").append(htm);
		     regEvent();
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



