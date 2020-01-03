<%@ page language="java" import="java.util.*,java.sql.*,com.jerehnet.util.dbutil.*,com.jerehnet.util.common.*" pageEncoding="UTF-8"%>
<%@page import="com.jerehnet.action.PoolManager"%><%
	Connection connection = null;
	DBHelper dbHelper = DBHelper.getInstance();
	Map model = new HashMap();
	Map enumMap = new TreeMap();
	String tableName = "pro_category";
	String channelUUID = CommonString.getFormatPara(request.getParameter("channel_uuid"));
	String category = CommonString.getFormatPara(request.getParameter("category"));
	Map adminInfo = (Map)session.getAttribute("adminInfo");
	try{
		String id = CommonString.getFormatPara(request.getParameter("id"));
		if(null!=id&&!"".equals(id)){
			model = dbHelper.getMap(" select * from "+tableName+" where uuid = ? ",new Object[]{id});
		}
		if("".equals(channelUUID)&&null!=model){
			channelUUID = (String)model.get("channel_uuid");
		}
		String no = "";
		String name = "";
		no = CommonString.getFormatPara(model.get("no"));
	
		
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
	<title><%=Env.getInstance().getProperty("project_name") %></title>
	<link rel="stylesheet" type="text/css" href="/plugin/other/highslide/highslide.css" />
	<link href="/plugin/ui/ligerUI/ligerUI/skins/Aqua/css/ligerui-all.css" rel="stylesheet" type="text/css" />
	<link href="/plugin/ui/ligerUI/ligerUI/skins/Gray/css/all.css" rel="stylesheet" type="text/css" />
	<link href="/plugin/ui/ligerUI/ligerUI/skins/ligerui-icons.css" rel="stylesheet" type="text/css" />
	<link href="/backend/style/style.css" rel="stylesheet" type="text/css" />
	<script src="/plugin/jquery/jquery.min.js" type="text/javascript"></script>
	<script type="text/javascript" charset="utf-8" src="/plugin/editor/ueditor/editor_config.js"></script>
	<script type="text/javascript" charset="utf-8" src="/plugin/editor/ueditor/editor_all_min.js"></script>
	<link rel="stylesheet" type="text/css" href="/plugin/editor/ueditor/themes/default/ueditor.css"/>
	</head>

	<body style="margin: 0;padding: 0;">
    <form name="theform" id="theform" action="/backend/action/crud.jsp?enumNo=106013">
      <div class="formDiv">
        <div class="group"> <span><img src="/plugin/ui/ligerUI/ligerUI/skins/icons/communication.gif" /></span> <span class="groupTitle">基础信息</span> </div>
        <div class="formLeft"><span style="color:#F00">* </span>项目名称</div>
        <div class="formRight">
          <input type="text" style="width:140px" dataType="Require" msg="请输入项目名称" class="jr_text" name="zd_name" id="zd_name" value="<%=CommonString.getFormatPara(model.get("name")) %>" maxlength="50"/>
        </div>

     </div>
      <input type="hidden" name="zd_order_no" id="zd_order_no" value="<%=CommonString.getFormatPara(model.get("order_no")) %>" />
      <input type="hidden" name="zd_parent_no" id="zd_parent_no" value="<%=CommonString.getFormatPara(model.get("parent_no")).equals("")?category:CommonString.getFormatPara(model.get("parent_no")) %>" />
      <input type="hidden" name="tableName" id="tableName" value="<%=tableName %>" />
      <input type="hidden" name="zd_id" id="zd_id" value="<%=CommonString.getFormatPara(model.get("id")) %>" />
    </form>
</body>
</html>
<script type="text/javascript" src="/plugin/jquery/jquery.form.js"></script>
<script src="/plugin/ui/ligerUI/ligerUI/js/ligerui.min.js" type="text/javascript"></script>
<script src="/backend/scripts/common.js?tab" type="text/javascript"></script>
<script src="/plugin/validator/wofoshan/validator.min.js" type="text/javascript"></script>
<script type="text/javascript" src="/plugin/other/highslide/highslide.min.js"></script>
<script type="text/javascript" src="http://resource.21-sun.com/plugin/upload/jr_upload.js"></script>
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
	

</script>
<%
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		dbHelper.freeConnection(connection);
	}
%>