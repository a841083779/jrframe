/**
 * index
 */
define(function(require) {
	var $ = require('$');
	var base=require('base');
	require('./common');
	require('upload_a/upload');
	
	require.async('sele_bg',function(){
	  $('.kba_prono_lg').sele({
		 max:99,                   // 页面内select效果最大个数，z-index层级即从此开始递减
		 act:"click",              // 触发下拉动作，可选click | mouseenter
		 callback:function(a, b){
			 $('.optbg_1').hide();
			$('#catalog').val(a);
			 var factory=$('#factory').val();;
			 var catalog=a;
			$.post("/mobile/koubei/tools/ajax_getPro.jsp",{factory:factory,catalog:catalog},function(data){
		    $("#optbg_3").html(data);
		});
		 } // 点击下拉a标签回调，@param(_val, _text)
	   });
	});
	require.async('sele_bg',function(){
	  $('.kba_probrd').sele({
		 max:88,                   // 页面内select效果最大个数，z-index层级即从此开始递减
		 act:"click",              // 触发下拉动作，可选click | mouseenter
		 callback:function(a, b){
			 $('.optbg_1').hide();
			 var factory=a;
			 var catalog=$('#catalog').val();
			$.post("/mobile/koubei/tools/ajax_getPro.jsp",{factory:factory,catalog:catalog},function(data){
		    $("#optbg_3").html(data);
		});
			 
		 } // 点击下拉a标签回调，@param(_val, _text)
	   });
	});
	require.async('sele_bg',function(){
	  $('.kba_procat').sele({
		 max:77,                   // 页面内select效果最大个数，z-index层级即从此开始递减
		 act:"click",              // 触发下拉动作，可选click | mouseenter
		 callback:function(a, b){
			 $('.optbg_1').hide();
			 $('#product_id').val(a); 
		 } // 点击下拉a标签回调，@param(_val, _text)
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
		
})

