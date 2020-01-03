<%@ page language="java" import="java.util.*,java.sql.*,com.jerehnet.util.dbutil.*,com.jerehnet.util.common.*" pageEncoding="UTF-8"%>
<%
	Connection connection = null;
	String tablePrefix = Env.getInstance().getProperty("table_prefix");
	DBHelper dbHelper = DBHelper.getInstance();
	Map model = new HashMap();
	String tableName = "pro_agent_factory";
	try{
		connection = dbHelper.getConnection();
		Map agentInfo = (Map)session.getAttribute("agentInfo");
		if(agentInfo != null){
			model = dbHelper.getMap(" select * from "+tableName+" where usern = ? ",new Object [] {agentInfo.get("usern")} , connection);
		}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title><%=Env.getInstance().getProperty("project_name") %></title>
<link href="/plugin/ui/ligerUI/ligerUI/skins/Aqua/css/ligerui-all.css" rel="stylesheet" type="text/css" />
<link href="/plugin/ui/ligerUI/ligerUI/skins/Gray/css/all.css" rel="stylesheet" type="text/css" />
<link href="/plugin/ui/ligerUI/ligerUI/skins/ligerui-icons.css" rel="stylesheet" type="text/css" />
<link href="/admin/style/style.css" rel="stylesheet" type="text/css" />
<script src="/plugin/jquery/jquery.min.js" type="text/javascript"></script>
<script type="text/javascript" charset="utf-8" src="/plugin/editor/ueditor/editor_config.js"></script>
<script type="text/javascript" charset="utf-8" src="/plugin/editor/ueditor/editor_all_min.js"></script>
<link rel="stylesheet" type="text/css" href="/plugin/editor/ueditor/themes/default/ueditor.css"/>
</head>

<body style="margin: 0;padding: 0; overflow-x: scroll; overflow-y:scroll ">
<form name="theform" id="theform" action="/admin/action/crud.jsp">
  <div class="formDiv">
    <div class="formLeft">帐　　号</div>
    <div class="formRight">
      <input type="text" dataType='Require' msg='请输入帐号' class="jr_text" name="zd_usern" id="zd_usern" value="<%=CommonString.getFormatPara(model.get("usern")) %>"  readonly="readonly"/>
    </div>
    <div style="clear:left;"></div>
    <div class="formLeft">简　　称</div>
    <div class="formRight">
      <input type="text" dataType='Require' msg='请输入厂商简称' class="jr_text" name="zd_name" id="zd_name" value="<%=CommonString.getFormatPara(model.get("name")) %>" />
    </div>
    <div style="clear:left;"></div>
    <div class="formLeft">全　　称</div>
    <div class="formRight">
      <input type="text" dataType='Require' msg='请输入厂商全称' class="jr_text" name="zd_full_name" id="zd_full_name" value="<%=CommonString.getFormatPara(model.get("full_name")) %>" />
    </div>
    <div style="clear:left;"></div>
    <div class="formLeft">联系电话</div>
    <div class="formRight">
      <input type="text" class="jr_text" name="zd_telphone" id="zd_telphone" value="<%=CommonString.getFormatPara(model.get("telphone")) %>" />
    </div>
    <div style="clear:left;"></div>
    <div class="formLeft">邮　　箱</div>
    <div class="formRight">
      <input type="text" class="jr_text" name="zd_email" id="zd_email" value="<%=CommonString.getFormatPara(model.get("email")) %>" />
    </div>
    <div style="clear:left;"></div>
    <div class="formLeft">公司网址</div>
    <div class="formRight">
      <input type="text" class="jr_text" name="zd_url" id="zd_url" value="<%=CommonString.getFormatPara(model.get("url")) %>" />
    </div>
    <div style="clear:left;"></div>
    <div class="formLeft">公司简介</div>
    <div class="formRight" style="height: 220px; text-align: left;"> 
      <script type="text/plain" id="editor_introduce" style="width:555px; height:200px;"><%=CommonString.getFormatPara(model.get("introduce")) %></script>
      <input type="hidden" name="zd_introduce" id="zd_introduce" value="" />
    </div>
    <div style="clear:left;"></div>
    <div style="text-align:center; padding:2px 0px 20px 0px;"><input type="button" class="btn" onclick="doSub();" value="保存" style="float:none"/></div>
  </div>
  <div style="clear: left;"></div>
  <input type="hidden" name="tableName" id="tableName" value="<%=tableName %>" />
  <input type="hidden" name="zd_id" id="zd_id" value="<%=CommonString.getFormatPara(model.get("id")) %>" />
</form>
</body>
</html>
<script type="text/javascript" src="/plugin/jquery/jquery.form.js"></script>
<script src="/plugin/ui/ligerUI/ligerUI/js/ligerui.min.js" type="text/javascript"></script>
<script src="/admin/scripts/common.js" prefix="<%=tablePrefix %>" type="text/javascript"></script>
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
						if("".equals(agentInfo.get("usern"))){
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
	var ue_introduce = new baidu.editor.ui.Editor({
    	textarea : 'zd_introduce',
    	autoHeightEnabled:false,
    	minFrameHeight:120,
		 toolbars:[
            ['FullScreen', 'Source', '|', 'Undo', 'Redo', '|',
                'Bold', 'Italic', 'Underline', 'StrikeThrough','RemoveFormat', 'FormatMatch','|',
                'BlockQuote', '|', 'PastePlain', '|', 'ForeColor', 'BackColor', 'InsertOrderedList', 'InsertUnorderedList','SelectAll', 'ClearDoc', '|', 'CustomStyle',
                'Paragraph', '|','FontFamily', 'FontSize', '|', 'Indent', '|',
                'JustifyLeft', 'JustifyCenter', 'JustifyRight', 'JustifyJustify']
        ]
    });
    ue_introduce.render('editor_introduce');
	document.getElementById("zd_introduce").value = ue_introduce.getContent();
    ue_introduce.addListener("selectionchange",function(){
	    var state_introduce = ue_introduce.queryCommandState("source");
		document.getElementById("zd_introduce").value = ue_introduce.getContent();
	});
</script>
<%
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		dbHelper.freeConnection(connection);
	}
%>