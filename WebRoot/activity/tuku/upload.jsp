<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>uploadify</title>
   <link href="/plugin/upload/uploadify/uploadify.css" rel="stylesheet" type="text/css" />
	<script src="/scripts/jquery.min.js" type="text/javascript"></script>
  </head>
  
  <body style="padding: 0;margin: 0; display: none;">
    <input type="file" name="file_upload" id="file_upload" />
    <div id="fileDiv" style="display:none;"></div>
    <iframe src="http://<%=request.getParameter("domain") %>/proxy.jsp?callback=<%=request.getParameter("callback") %>&beforeCallback=<%=request.getParameter("beforeCallback") %>&errorCallback=<%=request.getParameter("errorCallback") %>" id="proxy" style="display: none;"></iframe>
  </body>
</html>
<script type="text/javascript" src="/plugin/upload/uploadify/swfobject.js"></script>
<script type="text/javascript" src="/plugin/upload/uploadify/jquery.uploadify.v2.1.4.min.js"></script>
<script type="text/javascript">
	var imgs = "";
	var fileDesc = "<%=request.getParameter("fileExt") %>";
	var fileExt = "";
	var tempArr = fileDesc.split(",");
	for(var i=0;i<tempArr.length;i++){
		fileExt += "*."+tempArr[i]+";";
	}
	var url = "/action/upload_normal.jsp";
	url = escape(url);
	jQuery("#file_upload").uploadify({
			uploader : '/plugin/upload/uploadify/uploadify.swf',// 指定uploadify.swf路径
			script : url,
			queueID : 'fileDiv',// 上传效果显示层的ID
			queueSizeLimit : <%=request.getParameter("counts") %>,// 当允许多文件生成时，设置选择文件的个数
			fileDesc : fileDesc ,
			method : "GET" ,
			fileExt : fileExt , // 控制可上传文件的扩展名，启用本项时需同时声明fileDesc
			auto : true,// 是否自动上传，即选择了文件即刻上传。
			multi : <%=request.getParameter("multi") %>, // 是否允许同时上传多文件，默认false
			simUploadLimit : <%=request.getParameter("counts") %>,// 多文件上传时，同时上传文件数目限制
			width:<%=request.getParameter("buttonImgWidth") %>,
			height:<%=request.getParameter("buttonImgHeight") %>,
			buttonImg : '<%=request.getParameter("buttonImg") %>',// 按钮图片
			removeCompleted : false,// 完成后，是否取消进度条
			sizeLimit : <%=request.getParameter("sizeLimit") %>,// 文件大小限制 byte 5M
			expressInstall : '/plugin/upload/uploadify/expressInstall.swf',
			onSelect : function(){
				//如果带#号
				if(document.getElementById("proxy").src.indexOf("#")!=-1){
					//重新分配#号
					document.getElementById("proxy").src=document.getElementById("proxy").src.split("#")[0]+"#_begin";
				}else{
					//直接添加参数
					document.getElementById("proxy").src=document.getElementById("proxy").src+"#_begin";
				}
			},
			onInit : function(){
				jQuery("body").show();
			},
			onComplete : function(evt, queueID, fileObj, response, data) {
				imgs += response+",";
			},
			onError : function(id, errorObj, fileObj) {
				var maxSize = <%=request.getParameter("sizeLimit") %>;
				var nowSize = fileObj.size;
				if(nowSize>maxSize){
					var tip = "您上传的文件为"+Math.floor((nowSize/1024/1024)*1000)+"KB\r\n";
					tip += "超出允许上传的最大文件大小"+Math.floor((maxSize/1024/1024)*1000)+"KB\r\n";
					tip += "请您重新选择文件上传";
					alert(tip);
				}else{
					alert(' 文件上传失败！');
					window.location.reload();
				}
				//如果带#号
				if(document.getElementById("proxy").src.indexOf("#")!=-1){
					//重新分配#号
					document.getElementById("proxy").src=document.getElementById("proxy").src.split("#")[0]+"#_error";
				}else{
					//直接添加参数
					document.getElementById("proxy").src=document.getElementById("proxy").src+"#_error";
				}
			},
			onAllComplete : function(filesUploaded,errors,allBytesLoaded,speed,a){
				if(imgs.indexOf("extError")!=-1){
					alert("该类型不允许被上传！");
					imgs = "";
					return;
				}
				if(""!=imgs&&imgs.indexOf(",")!=-1){
					imgs = imgs.substring(0,imgs.length-1);
				}
				//如果带#号
				if(document.getElementById("proxy").src.indexOf("#")!=-1){
					//重新分配#号
					document.getElementById("proxy").src=document.getElementById("proxy").src.split("#")[0]+"#"+imgs;
				}else{
					//直接添加参数
					document.getElementById("proxy").src=document.getElementById("proxy").src+"#"+imgs;
				}
				imgs = "";
			}
		});
</script>