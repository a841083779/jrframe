<%@ page language="java" import="java.util.*,com.jerehnet.util.common.*" pageEncoding="UTF-8"%><%
	String tableName = ""+Env.getInstance().getProperty("table_prefix")+"common_upload";
	String fileds = "id,add_date,file_size,uuid,old_name,new_name,file_type";
	String whereStr = "";
	String orderByStr = " id desc ";
	Map factoryInfo = (Map)session.getAttribute("factoryInfo");
	Map extensions = new LinkedHashMap();
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
	<link href="/admin/style/style.css" rel="stylesheet" type="text/css" />
	<script src="/plugin/jquery/jquery.min.js" type="text/javascript"></script>
  </head>
  <body>
  	<div class="searchForm">
  		<div class="searchCondition">
	  		<div class="searchLeft">上传日期</div>
	  		<div class="searchRight">
	  			<input type="text" name="add_date" id="add_date" />
	  		</div>
	  		<div class="searchLeft">扩<span class="span3"></span>展<span class="span3"></span>名</div>
	  		<div class="searchRight">
	  			<div style="margin-top: 2px;">
	  			<%=CommonForm.createCheckbox(extensions,"","new_name") %>
	  			</div>
	  		</div>
  		</div>
  		<div class="searchBtn">
  			<input type="button" class="btn" onclick="doSearch();" value="查询" />
  			<input type="button" class="btn" onclick="doClearForm();" value="重置" />
  		</div>
  	</div>
  	<div style="clear: left;"></div>
	<div class="l-loading" style="display: block;" id="pageloading"></div> 
	<div id="maingrid" style="margin: 0; padding: 0"></div>
	<div style="display: none;"></div>
  </body>
</html>
<script src="/plugin/ui/ligerUI/ligerUI/js/ligerui.min.js" type="text/javascript"></script>
<script src="/admin/scripts/dialog.js" type="text/javascript"></script>
<script type="text/javascript" src="/plugin/upload/uploadify/swfobject.js"></script>
<script type="text/javascript" src="/plugin/upload/uploadify/jquery.uploadify.v2.1.4.min.js"></script>
<script src="/admin/scripts/common.js" type="text/javascript"></script>
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
	var url = "/admin/action/liger.jsp";
	params.push({'name':'tableName','value':tableName});
	params.push({'name':'fileds','value':fields});
	params.push({'name':'whereStr','value':whereStr});
	params.push({'name':'orderBy','value':orderBy});
	grid = jQuery("#maingrid").ligerGrid({
		columns : [ 
					{ display : '原文件名', name : 'old_name', align : 'left' , type : 'string' , width : 150 } ,
					{ display : '现文件名(单击地址查看)', name : 'new_name', align : 'left' , type : 'string' , width : 400 , render : function(row){
							if(row.file_type==1){
								return "<a class='link' href='"+row.new_name+"' class='highslide' onclick='return hs.expand(this)'>"+row.new_name+"</a>";
							}
							return row.new_name;
						}
					} ,
					{ display : '上传日期', name : 'add_date', align : 'center' , type : 'date' , width : 150 } ,
					{ display : '文件大小', name : 'file_size', align : 'right' , type : 'float' , width : 100 , render : function(row){
							return changeTwoDecimal(row.file_size/1024)+"KB";
						}
					} ,
					{ display : '扩展名', align : 'center' ,width : 80 , render : function(row){
							var nname = row.new_name;
							nname = nname.substring(nname.indexOf('.'));
							return nname;
						}
					} ,
					{ display : '文件类型', name : 'file_type', align : 'center' , type : 'file' , width : 100 } 
		] ,
		url : url, 
		pageSize : 20,
		width : '99%',
		height : '98%',
		parms : params,
		checkbox : true,
		selectRowButtonOnly : true,
		rownumbers : true ,
					toolbar : {
			items : [{ 
					text:'<input id="file_upload" type="file" name="file_upload" />'
				} , { 
					text: '删除', 
					click: function(){
						toolbarDel({
							channel_no:'101007'
						});
					}, 
					icon: 'delete' 
				}
			]
		}
	});
	jQuery("#pageloading").hide();
	var urlUpload = "/admin/action/upload.jsp?uuid=<%=factoryInfo.get("uuid") %>&flag=base";
	urlUpload = escape(urlUpload);
	jQuery("#file_upload").uploadify({
		uploader : '/plugin/upload/uploadify/uploadify.swf',// 指定uploadify.swf路径
		script : urlUpload,// 后台处理的请求的servlet,同时传递参数,由于servlet只能接收一个参数，所以将两个参数合并成一个。
		method : 'get',
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
	
	function changeTwoDecimal(x){
		var f_x = parseFloat(x);
		if (isNaN(f_x)){
			alert('function:changeTwoDecimal->parameter error');
			return false;
		}
		var f_x = Math.round(x*100)/100;
		return f_x;
	}
	jQuery("#add_date").ligerDateEditor({width:150});
	/*列表页条件查询*/
	function doSearch(){
		params = [];
		conditionStr = "";
		var new_nameChecked = jQuery("input[name=new_name]:checked");
		if(new_nameChecked.length>0){
			jQuery.each(new_nameChecked,function(index,data){
				if(index==0){
					conditionStr += " and new_name like '%"+this.value+"%' ";
				}else{
					conditionStr += " or new_name like '%"+this.value+"%' ";
				}
			});
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
	/*列表页清空查询*/
	function doClearForm(){
		jQuery(".searchForm input:text").val('');
		jQuery(".searchForm input:checkbox").removeAttr("checked");
	}
</script>