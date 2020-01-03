<%@ page language="java" import="java.util.*,java.sql.*,com.jerehnet.util.dbutil.*,com.jerehnet.util.common.*" pageEncoding="UTF-8"%><%
	Connection connection = null;
	String tablePrefix = Env.getInstance().getProperty("table_prefix");
	DBHelper dbHelper = DBHelper.getInstance();
	Map model = new HashMap();
	String tableName = tablePrefix+"machine_brand";
	try{
		connection = dbHelper.getConnection();
		String id = CommonString.getFormatPara(request.getParameter("id"));
		System.out.println("id:"+id);
		String channelUUID = CommonString.getFormatPara(request.getParameter("channel_uuid"));
		if(null!=id&&!"".equals(id)){
			model = dbHelper.getMap(" select * from "+tableName+" where id = ? ",new Object [] {id} , connection);
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
	<link rel="stylesheet" type="text/css" href="/plugin/other/highslide/highslide.css" />
	<link rel="stylesheet" type="text/css" href="/plugin/editor/ueditor/themes/default/ueditor.css"/>
	<link rel="stylesheet" href="/plugin/date/My97DatePicker/skin/WdatePicker.css" type="text/css"/>
	<script src="/plugin/jquery/jquery.min.js" type="text/javascript"></script>
	<script type="text/javascript" charset="utf-8" src="/plugin/editor/ueditor/editor_config.js"></script>
	<script type="text/javascript" charset="utf-8" src="/plugin/editor/ueditor/editor_all_min.js"></script>
	<script type="text/javascript" src="/plugin/date/My97DatePicker/WdatePicker.js"></script>
	
	<script type="text/javascript" src="/plugin/jquery/jquery.form.js"></script>
<script src="/plugin/ui/ligerUI/ligerUI/js/ligerui.min.js" type="text/javascript"></script>
<script src="/backend/scripts/common.js" prefix="<%=tablePrefix %>" type="text/javascript"></script>
<script type="text/javascript" src="/plugin/other/highslide/highslide.min.js"></script>
<script src="/plugin/validator/wofoshan/validator.min.js" type="text/javascript"></script>
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
	

</script>
   </head>
  <body style="margin: 0;padding: 0; overflow-x: hidden; overflow-y:scroll;">
	<form name="theform" id="theform" action="/backend/action/crud.jsp">
		<div class="formDiv">
				<div class="group">
				 <span>
			    	<img src="/plugin/ui/ligerUI/ligerUI/skins/icons/communication.gif"/>
			     </span>
				 <span class="groupTitle">基础信息</span>
				</div>
				
				  <div class="formLeft">厂家简称</div>
				  <div class="formRight">
					<input type="text" dataType='Require' msg='请您输入品牌' class="jr_text" name="zd_name" id="zd_name" value="<%=CommonString.getFormatPara(model.get("name")) %>" />
				  </div>
				<div style="clear:left;"></div>
				<div class="formLeft">厂家全称</div>
				<div class="formRight">
					<input type="text" dataType='Require' msg='请输入代理商全称' class="jr_text" name="zd_full_name" id="zd_full_name" value="<%=CommonString.getFormatPara(model.get("full_name")) %>" />
				</div>
				<div style="clear:left;"></div>
				  <div class="formLeft">首字母</div>
				  <div class="formRight">
					<input type="text"  class="jr_text" name="zd_first_letter" id="zd_first_letter" value="<%=CommonString.getFormatPara(model.get("first_letter")) %>" />
				  </div>
				  <div style="clear:left;"></div>
		
		

				<div class="formLeft">公司LOGO</div>
				<div class="formRight" style="width:490px;" >
					<input type="text" class="jr_text" style="width:350px;"  name="zd_logo" id="zd_logo" value="<%=CommonString.getFormatPara(model.get("logo")) %>" />
					<span style="float:right; margin-right: 5px;color:red;">logo尺寸：98×50</span>
					
				</div>
				<div class="formRight" style="padding-left: 30px; position: relative; top:-2px;">
					<input style="float:right;" type="button" class="btn" onclick="chooseFile('zd_logo',700,480);" value="选择图片" />
					<a href="javascript:void(0);" class='highslide' onclick='return smallToBig(this,"zd_logo");'><input style="float:right; margin-right: 5px;" type="button" class="btn" value="预览" /></a>
				</div>
				<div style="clear:left;"></div>
				
				<!-- <div class="formLeft">厂家图片</div>
				<div class="formRight">
					<input type="text" class="jr_text" style="width:350px;" name="zd_img1" id="zd_img1" value="<%=CommonString.getFormatPara(model.get("img1")) %>" />
				</div>
					<div class="formRight" style="padding-left: 220px; position: relative; top:-2px;">
					<input style="float:right;" type="button" class="btn" onclick="chooseFile('zd_img1',700,480);" value="选择图片" />
					<a href="javascript:void(0);" class='highslide' onclick='return smallToBig(this,"zd_img1");'><input style="float:right; margin-right: 5px;" type="button" class="btn" value="预览" /></a>
				</div>
				<div style="clear:left;"></div> -->

				
				<div class="formLeft">公司简介</div>
			    <div class="formRight" style="height: 220px; text-align: left;"> 
			      <script type="text/plain" id="editor_introduce" style="width:650px; height:200px;"><%=CommonString.getFormatPara(model.get("introduce")) %></script>
			      <input type="hidden" name="zd_introduce" id="zd_introduce" value='' />
			    </div>
					
				<div style="clear:left;"></div>	  
				  <div class="formLeft">是否显示</div>
				  <div class="formRight"> 
				    <%=CommonForm.createIsRadio(CommonString.getFormatPara(model.get("is_show")),"zd_is_show") %> 
				  </div>
				  <div style="clear: left;"></div>
		<input type="hidden" name="tableName" id="tableName" value="<%=tableName %>" />
		 <input type="hidden" name="zd_id" id="zd_id" value="<%=CommonString.getFormatPara(model.get("id")) %>" />
		 <input type="hidden" name="eventAfter" value="updateMachineBrand" />
		
		</div>
	</form>
  </body>
</html>
<script type="text/javascript">
	function smallToBig(o,id){
	jQuery(o).attr("href","/uploadfiles/"+jQuery("#"+id).val());
	return hs.expand(o);
	}
	
	var ue_introduce = new baidu.editor.ui.Editor({
    	textarea : 'zd_introduce',
    	autoHeightEnabled:false,
    	minFrameHeight:120
    });
    ue_introduce.render('editor_introduce');
    ue_introduce.addListener("selectionchange",function(){
	    var state_introduce = ue_introduce.queryCommandState("source");
	    document.getElementById("zd_introduce").value=ue_introduce.getContent();
	});
	document.getElementById("zd_introduce").value=ue_introduce.getContent();
</script>
<%
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		dbHelper.freeConnection(connection);
	}
%>