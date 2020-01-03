<%@ page language="java" import="com.jerehnet.util.freemarker.TemplateUtils,java.io.*,java.util.*,java.sql.*,com.jerehnet.util.dbutil.*,com.jerehnet.util.common.*" pageEncoding="UTF-8"%><%
	Connection connection = null;
	String tablePrefix = Env.getInstance().getProperty("table_prefix");
	DBHelper dbHelper = DBHelper.getInstance();
	Map model = new HashMap();
	String tableName = tablePrefix + "common_template";
	try{
		connection = dbHelper.getConnection();
		String id = CommonString.getFormatPara(request.getParameter("id"));
		String channelUUID = CommonString.getFormatPara(request.getParameter("channel_uuid"));
		if(null!=id&&!"".equals(id)){
			model = dbHelper.getMap(" select * from "+tableName+" where uuid = ? ",new Object [] {id} , connection);
		}
		if("".equals(channelUUID)&&null!=model){
			channelUUID = (String)model.get("channel_uuid");
		}
		/*模板部分*/
		File t = new File(Common.getAbsolutePath(request)+"/template/");
		List<Map> list = new ArrayList<Map>(0);
		TemplateUtils.createTemplateTree(t,list);
		/*模板部分*/
%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <title><%=Env.getInstance().getProperty("project_name") %></title>
    <link rel="stylesheet" type="text/css" href="/plugin/tree/ztree/zTreeStyle/zTreeStyle.css" />
	<link href="/plugin/ui/ligerUI/ligerUI/skins/Aqua/css/ligerui-all.css" rel="stylesheet" type="text/css" />
	<link href="/plugin/ui/ligerUI/ligerUI/skins/Gray/css/all.css" rel="stylesheet" type="text/css" />
	<link href="/plugin/ui/ligerUI/ligerUI/skins/ligerui-icons.css" rel="stylesheet" type="text/css" />
	<link href="/backend/style/style.css" rel="stylesheet" type="text/css" />
	<script src="/plugin/jquery/jquery.min.js" type="text/javascript"></script>
<style type="text/css">
    	#template {
			display: none;
			width: 350px;
			height: 100px;
			border: 1px solid #ccc;
			position: relative;
			top: -124px;
			left: 0px;
			background: #fff;
			overflow-y: scroll;
			overflow-x: hidden;
			z-index: 99999;
		}
		
		#template_close {
			display: none;
			width: 30px;
			height: 16px;
			border: 1px solid #ccc;
			position: relative;
			top: -226px;
			z-index:9999;
			left: 352px;
			cursor: pointer;
			font-weight: bold;
			background-color: #eee;
		}
    </style>
  </head>
  
  <body style="margin: 0;padding: 0; overflow-x: hidden; ">
	<form name="theform" id="theform" action="/backend/action/crud.jsp">
		<div class="formDiv">
				<div class="group">
					<span><img src="/plugin/ui/ligerUI/ligerUI/skins/icons/communication.gif" /></span>
					<span class="groupTitle">基础信息</span>
				</div>
				<div style="clear:left;"></div>
				<div class="formLeft" style="margin-top: 30px;">模板名称</div>
				<div class="formRight" style="margin-top: 30px;">
					<input type="text" dataType='Require' msg='请输入模板名称！' class="jr_text" name="zd_name" id="zd_name" value="<%=CommonString.getFormatPara(model.get("name")) %>" />
				</div>
				<div style="clear:left;"></div>
				<div class="formLeft">模板路径</div>
				<div class="formRight">
					<input type="text" dataType='Require' msg='请输入模板路径！' class="jr_text" name="zd_template_file_name" id="zd_template_file_name" value="<%=CommonString.getFormatPara(model.get("template_file_name")) %>" />
					<div id="template">
						<ul id="ztree" style="margin-top: 3px;" class="ztree"></ul>
					</div>
					<div id="template_close">关闭</div>
				</div>
				<div style="clear:left;"></div>
				<div class="formLeft">生成路径</div>
				<div class="formRight">
					<input type="text" dataType='Require' msg='请输入生成路径！' class="jr_text" name="zd_create_file_name" id="zd_create_file_name" value="<%=CommonString.getFormatPara(model.get("create_file_name")) %>" />
				</div>
				<div style="clear:left;"></div>
				<div class="formLeft">是否详细</div>
				<div class="formRight">
					<%=CommonForm.createIsRadio(CommonString.getFormatPara(model.get("is_detail")), "zd_is_detail") %>
				</div>
				<div style="clear:left;"></div>
		</div>
		<div style="clear: left;"></div>
		<input type="hidden" name="tableName" id="tableName" value="<%=tableName %>" />
		<input type="hidden" name="zd_id" id="zd_id" value="<%=CommonString.getFormatPara(model.get("id")) %>" />
		<input type="hidden" name="zd_channel_uuid" id="zd_channel_uuid" value="<%=channelUUID %>" />
	</form>
  </body>
</html>
<script type="text/javascript" src="/plugin/jquery/jquery.form.js"></script>
<script src="/plugin/ui/ligerUI/ligerUI/js/ligerui.min.js" type="text/javascript"></script>
<script src="/backend/scripts/common.js" type="text/javascript"></script>
<script src="/plugin/validator/wofoshan/validator.min.js" type="text/javascript"></script>
<script src="/plugin/tree/ztree/jquery.ztree.all-3.1.js" type="text/javascript"></script>
<script type="text/javascript">
	function doSub(){
		var rs = Validator.Validate(document.getElementById("theform"),1);
		if(rs){
			jQuery("#theform").ajaxSubmit({
				type : "POST",
				async : false ,
				success : function(data) {
					var rs = parseInt(jQuery.trim(data), 10);
					if (rs > 0) {
						jrSuccess("保存成功！");
						<%
						if("".equals(id)){
							%>
						window.location.reload();
							<%
						}
						%>
					} 
				}
			});
		}
	}
	var zTreeNodes = [
	          		<%
	          		Map m = null;
	          		int size = list.size();
	          		String abFile = "";
	          		String realPah = application.getRealPath("/template");
	          		for(int i=0;i<size;i++){
	          			m = (Map)list.get(i);
	          			abFile = (String)m.get("absolute");
	          			abFile = abFile.replace(realPah,"");
	          			abFile = abFile.replace("\\","/");
	          			out.print("{");
	          			out.print("id:'"+m.get("id")+"',");
	          			out.print("pId:'"+m.get("pId")+"',");
	          			out.print("name:'"+m.get("self")+"'");
	          			if(!m.get("isDirectory").equals(true)){
	          				out.print(",click:\"chooseTemplate('"+abFile+"');\"");
	          			}else{
	          				out.print(",open:true");
	          			}
	          			out.print("}");
	          			if(i!=(size-1)){
	          				out.print(",");
	          			}
	          		}
	          		%>
	          	];

	          	
	          	var setting = {
	          		view: {
	          			dblClickExpand: false,
	          			showLine: true,
	          			selectedMulti: false,
	          			expandSpeed: (jQuery.browser.msie && parseInt($.browser.version)<=6)?"":"fast"
	          		},
	          		data: {
	          			simpleData: {
	          				enable:true,
	          				idKey: "id",
	          				pIdKey: "pId",
	          				rootPId: "template"
	          			}
	          		}
	          	};
	          	jQuery.fn.zTree.init(jQuery("#ztree"), setting, zTreeNodes);
	          	function chooseTemplate(file){
	          		jQuery("#zd_template_file_name").val(file);
	          		jQuery("#zd_create_file_name").val(file);
	          	}
	          	
	          	function showDiv(){
	          		hideDiv();
	          		jQuery("#template,#template_close").show();
	          	}
	          	
	          	function hideDiv(){
	          		jQuery("#template,#template_close").hide();
	          	}
	          	
	          	jQuery("#template_close").click(function(){
	          		hideDiv();
	          	});
	          	
	          	jQuery("#zd_template_file_name").click(function(){
	          		var dis = jQuery("#template").css("display");
	          		if(dis=='none'){
	          			showDiv();
	          		}
	          	});
</script><%
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		dbHelper.freeConnection(connection);
	}
%>