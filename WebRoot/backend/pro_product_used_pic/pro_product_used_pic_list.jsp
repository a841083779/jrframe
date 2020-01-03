<%@ page language="java" import="java.util.*,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.DBHelper" pageEncoding="UTF-8"%>
<%
    String tableName = "pro_product_used_pic";
	DBHelper dbHelper = DBHelper.getInstance();
	String fileds = " id,product_id,name,placeflag,img_name,is_show,page_pic_flag";
	// String product_id = CommonString.getFormatPara(request.getParameter("id"));
     String id = CommonString.getFormatPara(request.getParameter("id"));
	String whereStr = " and is_show=1 and product_id = '"+id+"' ";
	String orderByStr = " id desc ";
	List<Map> images = dbHelper.getMapList(" select * from "+tableName+" where product_id = ? order by  id desc ",new Object [] {id});
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title><%=Env.getInstance().getProperty("project_name") %></title>
<link rel="stylesheet" type="text/css" href="/plugin/other/highslide/highslide.css" />
<link href="/backend/style/style.css" rel="stylesheet" type="text/css" />
<script src="/plugin/jquery/jquery.min.js" type="text/javascript"></script>
<style type="text/css">
#upload {
	background-image:url('/plugin/upload/baidu/upload.png');
	margin:5px;
	float:right;
	width:100px;
	height:28px;
	visibility: hidden;
}
#del_img {
	background-image:url('/images/delete.png');
	margin:5px;
	float:right;
	width:28px;
	cursor:pointer;
	height:28px;
	visibility: visible;
}
.shade {
	filter:alpha(opacity=30);
	-moz-opacity:0.3;
	-khtml-opacity: 0.3;
	opacity: 0.3;
	background-color:#fff;
	position: relative;
	width: 130px;
	height: 135px;
	z-index: 4;
	display: none;
}
.blue {
	border: 1px solid blue;
}
.ccc {
	border: 1px solid #ccc;
}
.toobar {
	position: absolute;
	bottom: 0px;
	height: 20px;
	width: 130px;
	border-top: 1px solid #ccc;
}
.single_img {
	border: 1px solid #ccc;
	width: 130px;
	height: 135px;
	float:left;
	margin: 10px 0 10px 18px;
	position:relative;
	cursor: pointer;
	overflow: hidden;
}
.single_img .show_img {
	position:absolute;
	bottom: 25px;
}
</style>
</head>
<body>
<div>
  <div id="flashContainer"></div>
  <div id="del_img"></div>
  <div style="float:left;font-size:12px;position: relative;"><span style="position: absolute; width: 480px; top:14px;"> <span id="setMainImg" style="cursor:pointer; font-weight:bold"><!--  设为主图--></span> （说明：单击选择图片通过删除按钮进行图片删除，拖动图片进行排序。） </span> </div>
  <div id="upload"></div>
  <div style="clear: both;"></div>
</div>
<div style="border: 1px solid #ccc; width: 782px; height: 338px; overflow-y: auto; " id="sortable">
  <%
			if(null!=images&&images.size()>0){
				Map model = null;
				for(int i=0;i<images.size();i++){
					model = images.get(i);
%>
  <div class="single_img" id="<%=model.get("uuid") %>" title="<%=model.get("name") %>">
    <div><img class="show_img" width="130px;" src="<%=CommonString.getFormatPara(model.get("img_name")).indexOf("uploadfiles")==-1?"/uploadfiles/"+CommonString.getFormatPara(model.get("img_name")):CommonString.getFormatPara(model.get("img_name")) %>" /></div>
    <div class="toobar">
      <input myid="<%=model.get("uuid") %>" type="text" class="miaoshu" oldval="<%=(null==model.get("name"))?"":model.get("name") %>" style="border:none; border-right: 1px solid #ccc; width: 100px; height: 18px; " value="<%=(null==model.get("name"))?"":model.get("name") %>" />
      <a href="/uploadfiles/<%=model.get("img_name") %>" onclick="return hs.expand(this)" class="highslide"> <img style="position: absolute; bottom: 0px; right:3px; width: 18px; height: 18px;" src="/images/fangda.gif" /> </a> </div>
    <div class="shade"></div>
  </div>
  <%
				}
			}

		%>
  <div style="clear: left;"></div>
</div>
</body>
</html>
<script src="/backend/scripts/common.js" type="text/javascript"></script>
<script type="text/javascript" charset="utf-8" src="/plugin/upload/baidu/editor_all_min.js"></script>
<script type="text/javascript" charset="utf-8" src="/plugin/upload/baidu/image.js"></script>
<script type="text/javascript" src="/plugin/other/highslide/highslide.min.js"></script>
<script src="/plugin/ui/jqueryUI/jquery-ui-1.8.20.custom.min.js"></script>
<script type="text/javascript">
	jQuery("#sortable").sortable({
		stop : function(event, ui) {
			doSort();
		}
	});
	function doSort(){
		var sortHtml = "";
		var myid = "";
		jQuery.each(jQuery("#sortable>div"),function(index,data){
			myid =  jQuery(this).attr("id");
			if(myid==undefined){
				return;
			}
			sortHtml +=myid+",";
		});
		sortHtml = sortHtml.substring(0,sortHtml.length-1);
		jQuery.ajax({
			url:"/backend/action/ajax_cud.jsp",
			type:"post",
			data:{'flag':'saveSort',"tableName":"pro_product_used_pic","sortId":sortHtml},
			async:false,
			cache:false
		});
	}
	jQuery("#sortable").disableSelection();
	jQuery(".single_img .show_img").click(function(){
		var obj = jQuery(this).parent().parent();
		obj.removeClass("ccc");
		obj.addClass("blue");
		obj.css("border","1px solid blue");
		obj.find(".shade").show();
	});
	jQuery(".shade").click(function(){
		var obj = jQuery(this).parent();
		obj.removeClass("blue");
		obj.addClass("ccc");
		obj.css("border","1px solid #ccc");
		obj.find(".shade").hide();
	});
	hs.graphicsDir = '/plugin/other/highslide/graphics/';
	hs.wrapperClassName = 'wide-border';
	var imageData = [],          //用于保存从服务器返回的图片信息数组
	selectedImageCount = 0;  //当前已选择的但未上传的图片数量
	//创建Flash相关的参数集合
	var flashOptions = {
		container:"flashContainer",                                                    //flash容器id
		url:'/backend/action/upload.jsp',                                           // 上传处理页面的url地址
		ext:'{}',                                 //可向服务器提交的自定义参数列表
		fileType:'{"description":"图片", "extension":"*.gif;*.jpeg;*.png;*.jpg"}',     //上传文件格式限制
		flashUrl:'/plugin/upload/baidu/imageUploader.swf',                                                  //上传用的flash组件地址
		width:780,          //flash的宽度
		height:150,         //flash的高度
		gridWidth:121,     // 每一个预览图片所占的宽度
		gridHeight:120,    // 每一个预览图片所占的高度
		picWidth:100,      // 单张预览图片的宽度
		picHeight:100,     // 单张预览图片的高度
		uploadDataFieldName:'picdata',    // POST请求中图片数据的key
		picDescFieldName:'pictitle',      // POST请求中图片描述的key
		maxSize:2,                         // 文件的最大体积,单位M
		compressSize:1,                   // 上传前如果图片体积超过该值，会先压缩,单位M
		maxNum:32,                         // 单次最大可上传多少个文件
		backgroundUrl:'',                 // flash界面的背景图片,留空默认
		listBackgroundUrl:'',            // 单个预览框背景，留空默认
		buttonUrl:'',                     // 上传按钮背景，留空默认
		compressSide:0,                 //等比压缩的基准，0为按照最长边，1为按照宽度，2为按照高度
		compressLength:900        //能接受的最大边长，超过该值Flash会自动等比压缩
	};
	var callbacks={
		selectFileCallback: function(selectFiles){
			selectedImageCount += selectFiles.length;
			if(selectedImageCount){
				jQuery("#upload").css("visibility","visible");
			}
		},
		deleteFileCallback: function(delFiles){
			selectedImageCount -= delFiles.length;
			if (!selectedImageCount) {
				jQuery("#upload").css("visibility","visible");
			}
		},
		uploadCompleteCallback: function(data){
			imageData.push(data.info);
			selectedImageCount--;
		},
		uploadErrorCallback: function (data){
			
		},
		allCompleteCallback: function(){
			saveImgToDb();
		}
	};
	imageUploader.init(flashOptions,callbacks);
	
	/*将图片保存到数据库*/
	function saveImgToDb(){
		var str = "[";
		for(var i=0;i<imageData.length;i++){
			str += jQuery.trim(imageData[i])+",";
		}
		if(str.indexOf(",")!=-1){
			str = jQuery.trim(str);
			str = str.substring(str,str.length-1);
		}
		str+="]";
		var data = {
			flag : 'saveUsedProImg',
			pro_id : '<%=id %>',
			channel_no : '',
			imgStr : str
		};
		doAjax("/backend/action/ajax_cud.jsp",data,function(data){
			if(jQuery.trim(data)=='ok'){
				window.location.reload();
			}
		});
	}
	
	function doSub(){
		parent.nowDialog.close();
	}
	
	jQuery(".miaoshu").blur(function(){
		var oldval = jQuery(this).attr("oldval");
		var selfval = this.value;
		var id = jQuery(this).attr("myid");
		if(oldval!=selfval){
			jQuery.post("/backend/action/ajax_cud.jsp",{
				'flag':'commonUpdate',
				'tableName':'pro_product_used_pic',
				'id':id,
				'key':'title',
				'value':selfval
			});
		}
	});
	jQuery("#del_img").click(function(){
		var blue = jQuery(".blue");
		if(blue.length<=0){
			alert("请单击选择您要删除的图片");
			return;
		}
		jrConfirm("确定要删除选中的"+blue.length+"张图片吗？",function(v){
			if(v){
				var ids = "";
				jQuery.each(blue,function(index,data){
					ids += "'"+this.getAttribute('id')+"',";
				});
				if(ids.indexOf(',')!=-1){
					ids=ids.substring(0,ids.length-1);
				}
				jQuery.ajax({
					url:'/backend/action/ajax_cud.jsp',
					data:{'flag':'groupDel','ids':ids,'tableName':'pro_product_used_pic'},
					type:'post',
					async:false,
					success:function(data){
						if(jQuery.trim(data)=='ok'){
							window.location.reload();
						}
					}
				});	
			}
		});
	});
	
	jQuery("#setMainImg").click(function(){
		var blue = jQuery(".blue");
		if(blue.length<=0){
			alert("请单击选择您要设置为主图的图片");
			return;
		}
		jrConfirm("确定要把选中的图片设置为主图吗？",function(v){
			if(v){
				var imgSrc = "";
				jQuery.each(blue,function(index,data){
					imgSrc = this.getAttribute('title');
					return false;
				});
				if(imgSrc.indexOf(',')!=-1){
					imgSrc=ids.substring(0,ids.length-1);
				}
				jQuery.ajax({
					url:'/backend/action/ajax_cud.jsp',
					data:{'flag':'setMainImg','imgSrc':imgSrc,'tableName':'zoomlion_parts','parts_uuid':'<%=id%>'},
					type:'post',
					async:false,
					success:function(data){
						if(jQuery.trim(data)=='ok'){
							//window.location.reload();
						}
					}
				});	
			}
		});
	});
</script>