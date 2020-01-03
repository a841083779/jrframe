<%@ page language="java" import="java.util.*,java.sql.*,com.jerehnet.util.dbutil.*,com.jerehnet.util.common.*" pageEncoding="UTF-8"%><%
	Connection connection = null;
	DBHelper dbHelper = DBHelper.getInstance();
	Map model = new HashMap();
	Map enums = new TreeMap();
	String tablePrefix = Env.getInstance().getProperty("table_prefix");
	String tableName = tablePrefix+"common_enum";
	Map adminInfo = (Map)session.getAttribute("adminInfo");
	try{
		connection = dbHelper.getConnection();
		String id = CommonString.getFormatPara(request.getParameter("id"));
		if(null!=id&&!"".equals(id)){
			model = dbHelper.getMap(" select * from "+tableName+" where uuid = ? ",new Object [] {id} , connection);
		}
		
		List<Map> enumList = (List)application.getAttribute("enumList");
		String no = "";
		String name = "";
		enums.put("0","无父枚举");
		for(Map m : enumList){
			no = (String)m.get("no");
			name = (String)m.get("name");
			name = CommonForm.getHtmlSpaceByString((String)m.get("parent_no"))+name;
			enums.put(no,name);
		}
		no = CommonString.getFormatPara(model.get("no"));
		if("".equals(no)){
			no = Common.getNo("0",tableName);
		}
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

	<body style="margin: 0;padding: 0; overflow-x: hidden; ">
    <form name="theform" id="theform" action="/backend/action/crud.jsp">
      <div class="formDiv">
        <div class="group"> <span><img src="/plugin/ui/ligerUI/ligerUI/skins/icons/communication.gif" /></span> <span class="groupTitle">基础信息</span> </div>
        <div style="clear: left;"></div>
        <div class="formLeft">所属类别</div>
        <div class="formRight"><select class="jr_select" name="zd_parent_no" id="zd_parent_no"><%=CommonForm.createSelect(enums,CommonString.getFormatPara(model.get("parent_no"))) %></select></div>
        <div style="clear: left;"></div>
        <div class="formLeft">编号</div>
        <div class="formRight">
          <input type="text" name="zd_no" class="jr_text" readonly="readonly" id="zd_no" value="<%=no %>"  />
        </div>
        <div style="clear: left;"></div>
        <div class="formLeft">名称</div>
        <div class="formRight">
          <input type="text" dataType="Require" msg="请您输入名称！" class="jr_text" name="zd_name" id="zd_name" value="<%=CommonString.getFormatPara(model.get("name")) %>" />
        </div>
        <div style="clear: left;"></div>
        <div class="formLeft">图片</div>
        <div class="formRight">
          <input type="text" readonly="readonly" style="width: 400px;" class="jr_text" name="zd_img" id="zd_img" value="<%=CommonString.getFormatPara(model.get("img")) %>" />
        </div>
		<div class="formRight" style="padding-left: 220px; position: relative; top:-2px;">
			<input style="float:right;" type="button" class="btn" onclick="chooseFile('zd_img',650,280);" value="选择图片" />
			<a href="javascript:void(0);" class='highslide' onclick='return smallToBig(this,"zd_img");'><input style="float:right; margin-right: 5px;" type="button" class="btn" value="预览" /></a>
		</div>
		<div style="clear:left;"></div>
        <div class="group"> <span><img src="/plugin/ui/ligerUI/ligerUI/skins/icons/communication.gif" /></span> <span class="groupTitle">扩展信息</span> </div>
        <div style="clear: left;"></div>
        <div class="formLeft">是否显示</div>
        <div class="formRight"> <%=CommonForm.createIsRadio(CommonString.getFormatPara(model.get("is_show")),"zd_is_show") %> </div>
        <div style="clear: left;"></div>
        <div class="formLeft">系统枚举</div>
        <div class="formRight">
        	<%
        		String isSystem = CommonString.getFormatPara(model.get("is_system"));
        		if("".equals(isSystem)){
        			isSystem = "0";
        		}
        	%>
        	<%=CommonForm.createIsRadio(isSystem,"zd_is_system") %>
        </div>
      </div>
      <div style="clear: left;"></div>
      <input type="hidden" name="zd_order_no" id="zd_order_no" value="<%=CommonString.getFormatPara(model.get("order_no")) %>" />
      <input type="hidden" name="tableName" id="tableName" value="<%=tableName %>" />
      <input type="hidden" name="zd_id" id="zd_id" value="<%=CommonString.getFormatPara(model.get("id")) %>" />
      <input type="hidden" name="eventAfter" id="eventAfter" value="updateApplicationEnum" />
    </form>
</body>
</html>
<script type="text/javascript" src="/plugin/jquery/jquery.form.js"></script>
<script src="/plugin/ui/ligerUI/ligerUI/js/ligerui.min.js" type="text/javascript"></script>
<script src="/backend/scripts/common.js?tab" type="text/javascript"></script>
<script src="/plugin/validator/wofoshan/validator.min.js" type="text/javascript"></script>
<script type="text/javascript" src="/plugin/other/highslide/highslide.min.js"></script>
<script type="text/javascript">
	hs.graphicsDir = '/plugin/other/highslide/graphics/';
	hs.wrapperClassName = 'wide-border';
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

	jQuery(function(){
		jQuery("#zd_parent_no").change(function(){
			jQuery.post("/backend/action/ajax_r.jsp",{'tableName':'<%=tableName%>','flag':'get_no','pno':this.value},function(data){
				jQuery("#zd_no").val(jQuery.trim(data));
			});
		});
	});
	function smallToBig(o,id){
		jQuery(o).attr("href",jQuery("#"+id).val());
		return hs.expand(o);
	}
</script>
<%
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		dbHelper.freeConnection(connection);
	}
%>