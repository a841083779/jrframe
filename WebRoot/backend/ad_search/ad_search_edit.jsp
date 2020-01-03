<%@ page language="java" import="java.util.*,java.sql.*,com.jerehnet.util.dbutil.*,com.jerehnet.util.common.*" pageEncoding="UTF-8"%><%
	Connection connection = null;
	//String tablePrefix = Env.getInstance().getProperty("table_prefix");
	String tablePrefix = "" ;
	DBHelper dbHelper = DBHelper.getInstance();
	Map model = new HashMap();
	String tableName = "ad_search";
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
%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <title><%=Env.getInstance().getProperty("project_name") %></title>
	<link href="/plugin/ui/ligerUI/ligerUI/skins/Aqua/css/ligerui-all.css" rel="stylesheet" type="text/css" />
	<link href="/plugin/ui/ligerUI/ligerUI/skins/Gray/css/all.css" rel="stylesheet" type="text/css" />
	<link href="/plugin/ui/ligerUI/ligerUI/skins/ligerui-icons.css" rel="stylesheet" type="text/css" />
	<link href="/backend/style/style.css" rel="stylesheet" type="text/css" />
	<script src="/plugin/jquery/jquery.min.js" type="text/javascript"></script>
  </head>
  
  <body style="margin: 0;padding: 0; overflow-x: hidden; ">
	<form name="theform" id="theform" action="/backend/action/crud.jsp">
		<div class="formDiv">
		<div class="group">
			<span>
		    <img src="/plugin/ui/ligerUI/ligerUI/skins/icons/communication.gif"/>
		     </span>
			<span class="groupTitle">关键词搜索信息</span>
			</div>
				<div class="formLeft">标<span class="span2">&nbsp;</span>题</div>
				<div class="formRight">
					<input type="text" dataType='Require' msg='请输入标题' class="jr_text" name="zd_title" id="zd_title" value="<%=CommonString.getFormatPara(model.get("title")) %>" />
				</div>
				<div style="clear:left;"></div>
				<div class="formLeft">内<span class="span2">&nbsp;</span>容</div>
				<div class="formRight">
				 <textarea style="heigth:50px;" id="zd_intro" name="zd_intro" class="jr_textarea" dataType='Require' msg='请输入内容' ><%=CommonString.getFormatPara(model.get("intro")) %></textarea>
				</div>
				<div style="clear:left;height:30px;"></div>
				<div class="formLeft">链<span class="span2">&nbsp;</span>接</div>
				<div class="formRight">
					<input type="text" dataType='Require' msg='请输入链接' class="jr_text" name="zd_url" id="zd_url" value="<%=CommonString.getFormatPara(model.get("url")) %>" />
				</div>
				<div style="clear:left;"></div>
				<div class="formLeft">关&nbsp;&nbsp;键&nbsp;&nbsp;词</div>
				<div class="formRight">
					<input type="text" dataType='Require' msg='请输入关键词' class="jr_text" name="zd_keyword" id="zd_keyword" value="<%=CommonString.getFormatPara(model.get("keyword")) %>" />
				</div>
				<div style="clear:left;"></div>
		</div>
		<div style="clear: left;"></div>
		<input type="hidden" name="tableName" id="tableName" value="<%=tableName %>" />
		<input type="hidden" name="zd_id" id="zd_id" value="<%=CommonString.getFormatPara(model.get("id")) %>" />
		<input type="hidden" name="zd_flag" id="zd_flag" value="10" />  <!-- 10 属于产品中心 -->
	</form>
  </body>
</html>
<script type="text/javascript" src="/plugin/jquery/jquery.form.js"></script>
<script src="/plugin/ui/ligerUI/ligerUI/js/ligerui.min.js" type="text/javascript"></script>
<script src="/backend/scripts/common.js" prefix="<%=tablePrefix %>" type="text/javascript"></script>
<script src="/plugin/validator/wofoshan/validator.min.js" type="text/javascript"></script>
<script type="text/javascript">
	function doSub(){
		var rs = Validator.Validate(document.getElementById("theform"),1);
		if(rs){
			jQuery("#theform").ajaxSubmit({
				type : "POST",
				async : false ,
				success : function(data) {
					var rs = parseInt(jQuery.trim(data), 10);
					if (rs > 0 ) {
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
</script><%
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		dbHelper.freeConnection(connection);
	}
%>