<%@ page language="java" import="java.util.*,com.jerehnet.util.common.*" pageEncoding="UTF-8"%><%
	String tableName = "pro_tuan_image";
	String fileds = "id,add_date,file_size,uuid,old_name,new_name,file_type";
	String whereStr = "";
	String orderByStr = " id desc ";
	Map adminInfo = (Map)session.getAttribute("adminInfo");
	String group_id = CommonString.getFormatPara(request.getParameter("group_id")) ;
	
	Map extensions = new LinkedHashMap();
	extensions.put("","--请选择--");
	extensions.put(".jpg",".jpg");
	extensions.put(".png",".png");
	extensions.put(".gif",".gif");
	extensions.put(".bmp",".bmp");
	extensions.put(".doc",".doc");
	extensions.put(".docx",".docx");
	extensions.put(".ppt",".ppt");
	extensions.put(".pptx",".pptx");
	extensions.put(".xls",".xls");
	extensions.put(".xlsx",".xlsx");
	extensions.put(".pdf",".pdf");
%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <title><%=Env.getInstance().getProperty("project_name") %></title>
    <link rel="stylesheet" type="text/css" href="/plugin/other/highslide/highslide.css" />
	<link href="/plugin/ui/ligerUI/ligerUI/skins/Aqua/css/ligerui-all.css" rel="stylesheet" type="text/css" />
	<link href="/plugin/ui/ligerUI/ligerUI/skins/Gray/css/all.css" rel="stylesheet" type="text/css" />
	<link href="/plugin/ui/ligerUI/ligerUI/skins/ligerui-icons.css" rel="stylesheet" type="text/css" />
	<link href="/backend/style/style.css" rel="stylesheet" type="text/css" />
	<script src="/plugin/jquery/jquery.min.js" type="text/javascript"></script>
  </head>
  <body>
  	<div class="searchForm">
  		<div class="searchCondition" style="width: 65%;">
	  		<div class="searchLeft">上传日期</div>
	  		<div class="searchRight">
	  			<input type="text" name="add_date" id="add_date" />
	  		</div>
	  		<div class="searchLeft">扩<span class="span3"></span>展<span class="span3"></span>名</div>
	  		<div class="searchRight">
	  			<select name="new_name" style="width: 100px;" class="jr_select" id="new_name">
	  				<%=CommonForm.createSelect(extensions,"") %>
	  			</select>
	  		</div>
	  		<div style="clear:left;"></div>
	  		<div class="searchLeft">是否加水印</div>
	  		<div class="searchRight">
	  				<%=CommonForm.createIsRadio("1","wartermark") %>
	  		</div>
  		</div>
  		<div class="searchBtn" style="width: 30%;">
  			<input type="button" class="btn" onclick="doSearch();" value="查询" />
  			<input type="button" class="btn" onclick="doClearForm();" value="重置" />
  		</div>
  	</div>
  	<div style="clear: left;"></div>
	<div class="l-loading" style="display: block" id="pageloading"></div> 
	<div id="maingrid" style="margin: 0; padding: 0"></div>
	<div style="display: none;"></div>
  </body>
</html>
<script src="/plugin/ui/ligerUI/ligerUI/js/ligerui.min.js" type="text/javascript"></script>
<script type="text/javascript" src="/plugin/upload/uploadify/swfobject.js"></script>
<script type="text/javascript" src="/plugin/upload/uploadify/jquery.uploadify.v2.1.4.min.js"></script>
<script src="/backend/scripts/common.js" type="text/javascript"></script>
<script type="text/javascript" src="/plugin/other/highslide/highslide.min.js"></script>
<script type="text/javascript">
	hs.graphicsDir = '/plugin/other/highslide/graphics/';
	hs.wrapperClassName = 'wide-border';
	var grid;
	var tableName = "<%=tableName %>";
	var fields = "<%=fileds %>";
	var whereStr = "<%=whereStr %>";
	var orderBy = "<%=orderByStr %>";
	var columnsArr = [];
	var url = "";
	var conditionStr = "";
	var params = [];
	jQuery.ligerDefaults.Grid.formatters['date'] = function (content , column) {
		return content.substring(0,content.indexOf(' '));
	}
	jQuery.ligerDefaults.Grid.formatters['is'] = function (content , column) {
		if(content==1){
			return '是';
		}
		return '<span style="color:red;">否</span>';
	}
	jQuery.ligerDefaults.Grid.formatters['file'] = function (content , column) {
		if(content==1){
			return '图片';
		}
		return '文件';
	}
	jQuery.ligerDefaults.Grid.formatters['sex'] = function (content , column) {
		if(content==1){
			return '男';
		}
		return '女';
	}
	var url = "/backend/action/liger.jsp";
	params.push({'name':'tableName','value':tableName});
	params.push({'name':'fileds','value':fields});
	params.push({'name':'whereStr','value':whereStr});
	params.push({'name':'orderBy','value':orderBy});
	grid = jQuery("#maingrid").ligerGrid({
		columns : [ 
					{ display : '现文件名', name : 'new_name', align : 'left' , type : 'string' , frozen : true , width : 150 , render : function(row){
							if(row.file_type==1){
								return "<a style='color:#000;text-decoration: underline;' href='/uploadfiles"+row.new_name+"' class='highslide' onclick='return hs.expand(this)'>"+row.new_name+"</a>";
							}
							return row.new_name;
						}
					} ,
					{ display : '选择', name : 'old_name', align : 'center' , width : 50 , frozen : true , render : function(rowdata, rowindex, value){
						return "<img src='/backend/images/iconSelectResource.gif' onclick='chooseThis(\""+rowdata.new_name+"\");' border='0' style='margin-top:3px; cursor:pointer;' />";
					}},
					{ display : '原文件名', name : 'old_name', align : 'left' , type : 'string' , width : 400 } ,
					{ display : '上传日期', name : 'add_date', align : 'center' , type : 'date' , width : 150 } ,
					{ display : '文件大小', name : 'file_size', align : 'right' , type : 'float' , width : 100 } ,
					{ display : '文件类型', name : 'file_type', align : 'center' , type : 'file' , width : 100 } 
		] ,
		url : url, 
		pageSize : 20,
		width : '99%',
		height : '98%',
		checkbox : true,
		parms : params,
		selectRowButtonOnly : true,
		rownumbers : true ,
					toolbar : {
			items : [{
				 text: '<input id="file_upload" type="file" name="file_upload" />'
				} , { 
					text: '删除', 
					click: function(){
						toolbarDel();
					}, 
					icon: 'delete' 
				}
			]
		}
	});
	var iswartermark = jQuery("input[name='wartermark']:checked").val() ;
	jQuery("#pageloading").hide();
	 jQuery("input[name='wartermark']").change(function(){  // 动态改变是否加水印
		iswartermark = jQuery(this).val() ;
		jQuery.ajax({
			type:"post",
			url:"/backend/action/ajax_cud.jsp" ,
			data:"flag=iswartermark&ismark="+iswartermark,
			success:function(){}
		});
	}) ;
	var urlUpload = "/backend/action/tuan_upload.jsp?uuid=<%=adminInfo.get("uuid") %>&flag=base&group_id=<%=group_id%>";
	urlUpload = escape(urlUpload);
	jQuery("#file_upload").uploadify({
		uploader : '/plugin/upload/uploadify/uploadify.swf',// 指定uploadify.swf路径
		script : urlUpload,// 后台处理的请求的servlet,同时传递参数,由于servlet只能接收一个参数，所以将两个参数合并成一个。
		cancelImg : '/scripts/uploadify/cancel.png',// 取消的按钮图
		queueID : 'fileDiv',// 上传效果显示层的ID
		queueSizeLimit : 10,// 当允许多文件生成时，设置选择文件的个数
		fileDesc : 'jpg,gif,png,bmp',
		fileExt : '*.jpg;*.gif;*.png;*.bmp;', // 控制可上传文件的扩展名，启用本项时需同时声明fileDesc
		auto : true,// 是否自动上传，即选择了文件即刻上传。
		multi : true, // 是否允许同时上传多文件，默认false
		simUploadLimit : 3,// 多文件上传时，同时上传文件数目限制
		width:40,
		height:20,
		buttonImg : '/plugin/upload/uploadify/upload.gif',// 按钮图片
		displayData : 'percentage',// 上传效果
		removeCompleted : true,// 完成后，是否取消进度条
		sizeLimit : 1024 * 1024 * 5,// 文件大小限制 byte 5M
		expressInstall : '/scripts/uploadify/expressInstall.swf',
		onSelect : function(){
			jQuery("#pageloading").show();
		},
		onProgress : function(){
			
		},
		onComplete : function(evt, queueID, fileObj, response, data) {
			
		},
		onError : function(id, errorObj, fileObj) {
			jrWarn("文件上传失败，文件最大不能超过5MB，请您重新上传！");
			jQuery("#pageloading").hide();
		},
		onAllComplete : function(filesUploaded,errors,allBytesLoaded,speed){
			grid.loadData();
			jQuery("#pageloading").hide();
		}
	});
	jQuery("#file_upload").parent().parent().css("padding","0");
	function chooseThis(img){
		parent.document.getElementById("<%=CommonString.getFormatPara(request.getParameter("id")) %>").value = img;
		parent.jQuery.ligerDialog.hide();
	}
	/*列表页条件查询*/
	function doSearch(){
		params = [];
		conditionStr = "";
		var new_name = jQuery("#new_name").val();
		if(''!=jQuery.trim(new_name)){
			conditionStr += " and new_name like '%"+new_name+"%' ";
		}
		var add_date = jQuery("#add_date").val();
		if(''!=jQuery.trim(add_date)){
			conditionStr += " and Datename(year,add_date)+'-'+Datename(month,add_date)+'-'+Datename(day,add_date) = '"+add_date+"' ";
		}
		params.push({'name':'tableName','value':tableName});
		params.push({'name':'fileds','value':fields});
		params.push({'name':'whereStr','value':conditionStr});
		params.push({'name':'orderBy','value':orderBy});
		grid.options.parms=params;
		grid.loadData();
	}
	jQuery("#add_date").ligerDateEditor({width:100});
	/*列表页清空查询*/
	function doClearForm(){
		jQuery(".searchForm input:text").val('');
		jQuery(".searchForm input:checkbox").removeAttr("checked");
	}
	function doSub(){
	  return true ;
	}
</script>