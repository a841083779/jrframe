<%@ page language="java" import="java.util.*,java.sql.*,com.jerehnet.util.dbutil.*,com.jerehnet.util.common.*" pageEncoding="UTF-8"%><%
	Connection connection = null;
	String tablePrefix = Env.getInstance().getProperty("table_prefix");
	DBHelper dbHelper = DBHelper.getInstance();
	Map model = new HashMap();
	String tableName = "pro_agent_factory";
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
	<script type="text/javascript" charset="utf-8" src="/plugin/editor/ueditor/editor_config.js"></script>
	<script type="text/javascript" charset="utf-8" src="/plugin/editor/ueditor/editor_all_min.js"></script>
	<link rel="stylesheet" type="text/css" href="/plugin/editor/ueditor/themes/default/ueditor.css"/>
	<link rel="stylesheet" type="text/css" href="/plugin/other/highslide/highslide.css" />
  </head>
  
  <body style="margin: 0;padding: 0; overflow-x: hidden; overflow-y:scroll;">
	<form name="theform" id="theform" action="/backend/action/crud.jsp">
		<div class="formDiv">
				<div class="group">
				<span>
			    <img src="/plugin/ui/ligerUI/ligerUI/skins/icons/communication.gif"/>
			     </span>
				<span class="groupTitle">厂商基本信息</span>
				</div>
				<div class="formLeft">用户名</div>
				<div class="formRight">
					<input type="text" dataType='Require' msg='请输入用户名' class="jr_text" name="zd_usern" id="zd_usern" value="<%=CommonString.getFormatPara(model.get("usern")) %>" />
				</div>
				<div style="clear:left;"></div>
				<div class="formLeft">密<span class="span2">&nbsp;</span>码</div>
				<div class="formRight">
					<input type="text" dataType='Require' msg='请输入密码' class="jr_text" name="zd_passw" id="zd_passw" value="<%=CommonString.getFormatPara(model.get("passw")) %>" />
				</div>
				<div style="clear:left;"></div>
				<div class="formLeft">厂商简称</div>
				<div class="formRight">
					<input type="text" dataType='Require' msg='请输入厂商简称' class="jr_text" name="zd_name" id="zd_name" value="<%=CommonString.getFormatPara(model.get("name")) %>" />
				</div>
				<div style="clear:left;"></div>
				<div class="formLeft">厂商全称</div>
				<div class="formRight">
					<input type="text" dataType='Require' msg='请输入厂商全称' class="jr_text" name="zd_full_name" id="zd_full_name" value="<%=CommonString.getFormatPara(model.get("full_name")) %>" />
				</div>
				<div style="clear:left;"></div>
				<div class="formLeft">联系电话</div>
				<div class="formRight">
					<input type="text" class="jr_text" name="zd_telphone" id="zd_telphone" value="<%=CommonString.getFormatPara(model.get("telphone")) %>" />
				</div>
                <div style="clear:left;"></div>
				<div class="formLeft">短接收信手机号</div>
				<div class="formRight">
					<input type="text" class="jr_text" name="zd_tel_sms" id="zd_tel_sms" value="<%=CommonString.getFormatPara(model.get("tel_sms")) %>" />
				</div>
				<div style="clear:left;"></div>
				<div class="formLeft">邮<span class="span2">&nbsp;</span>箱</div>
				<div class="formRight">
					<input type="text" class="jr_text" name="zd_email" id="zd_email" value="<%=CommonString.getFormatPara(model.get("email")) %>" />
				</div>
				<div style="clear:left;"></div>
				<div class="formLeft">公司网址</div>
				<div class="formRight">
					<input type="text" class="jr_text" name="zd_url" id="zd_url" value="<%=CommonString.getFormatPara(model.get("url")) %>" />
				</div>
				<div style="clear:left;"></div>
				<div class="formLeft">产品展厅网址</div>
				<div class="formRight">
					<input type="text" class="jr_text" name="zd_zturl" id="zd_zturl" value="<%=CommonString.getFormatPara(model.get("zturl")) %>" />
				</div>
				<div style="clear:left;"></div>
			<div class="formLeft">公司简介</div>
	    <div class="formRight" style="height: 220px; text-align: left;"> 
	      <script type="text/plain" id="editor_introduce" style="width:650px; height:200px;"><%=CommonString.getFormatPara(model.get("introduce")) %></script>
	      <input type="hidden" name="zd_introduce" id="zd_introduce" value='' />
	    </div>
				<div style="clear:left;"></div>
				<div class="formLeft">LOGO</div>
				<div class="formRight">
					<input type="text" class="jr_text" name="zd_logo" id="zd_logo" style="width:400px;" readonly="readonly" value="<%=CommonString.getFormatPara(model.get("logo")) %>" />
				</div>
				<div class="formRight" style="padding-left: 220px; position: relative; top:-2px;">
					<input style="float:right;" type="button" class="btn" onclick="chooseFile('zd_logo',700,480);" value="选择图片" />
					<a href="javascript:void(0);" class='highslide' onclick='return smallToBig(this,"zd_logo");'><input style="float:right; margin-right: 5px;" type="button" class="btn" value="预览" /></a>
				</div>
				<div style="clear:left;"></div>
				<div class="formLeft">厂家图片</div>
				<div class="formRight">
					<input type="text" class="jr_text" name="zd_img1" id="zd_img1" style="width:400px;" value="<%=CommonString.getFormatPara(model.get("img1")) %>" readonly="readonly"/>
				</div>
					<div class="formRight" style="padding-left: 220px; position: relative; top:-2px;">
					<input style="float:right;" type="button" class="btn" onclick="chooseFile('zd_img1',700,480);" value="选择图片" />
					<a href="javascript:void(0);" class='highslide' onclick='return smallToBig(this,"zd_img1");'><input style="float:right; margin-right: 5px;" type="button" class="btn" value="预览" /></a>
				</div>
				<div style="clear:left;"></div>
				<div class="formLeft">是否显示</div>
				<div class="formRight">
					<%=CommonForm.createIsRadio(CommonString.getFormatPara(model.get("is_show")),"zd_is_show") %>
				</div>
				<div style="clear:left;"></div>
				<div class="formLeft">国内品牌</div>
				<div class="formRight">
					<%=CommonForm.createIsRadio(CommonString.getFormatPara(model.get("is_inner")),"zd_is_inner") %>
				</div>
				<div style="clear:left;"></div>
				<div class="formLeft">首字母</div>
				<div class="formRight">
					<input type="text" dataType='Require' msg='请输入首字母' class="jr_text" name="zd_upper_index" id="zd_upper_index" value="<%=CommonString.getFormatPara(model.get("upper_index")) %>" />
				</div>
				<div style="clear:left;"></div>
				<div class="formLeft">排<span class="span2">&nbsp;</span>序</div>
				<div class="formRight">
					<input type="text" class="jr_text" name="zd_order_no" id="zd_order_no" value="<%=CommonString.getFormatPara(model.get("order_no")) %>" />
				</div>
				<div style="clear:left;"></div>
				<div class="formLeft">级<span class="span2">&nbsp;</span>别</div>
				<div class="formRight">
					<%=CommonForm.createIsRadio(CommonString.getFormatPara(model.get("levelflag")),"zd_levelflag") %>
				</div>
				<div style="clear:left;"></div>
				<div class="formLeft">销售QQ</div>
				<div class="formRight">
					<input type="text"  class="jr_text" name="zd_saleqq" id="zd_saleqq" value="<%=CommonString.getFormatPara(model.get("saleqq")) %>" />
				</div>
				<div style="clear:left;"></div>
				<div class="formLeft">服务QQ</div>
				<div class="formRight">
					<input type="text" class="jr_text" name="zd_serviceqq" id="zd_serviceqq" value="<%=CommonString.getFormatPara(model.get("serviceqq")) %>" />
				</div>
				<div style="clear:left;"></div>
		</div>
		<div style="clear: left;"></div>
		<input type="hidden" name="tableName" id="tableName" value="<%=tableName %>" />
		<input type="hidden" name="zd_id" id="zd_id" value="<%=CommonString.getFormatPara(model.get("id")) %>" />
		<input type="hidden" name="zd_flag" id="zd_flag" value="1"/>
	</form>
  </body>
</html>
<script type="text/javascript" src="/plugin/jquery/jquery.form.js"></script>
<script src="/plugin/ui/ligerUI/ligerUI/js/ligerui.min.js" type="text/javascript"></script>
<script src="/backend/scripts/common.js" prefix="<%=tablePrefix %>" type="text/javascript"></script>
<script src="/plugin/validator/wofoshan/validator.min.js" type="text/javascript"></script>
<script type="text/javascript" src="/plugin/other/highslide/highslide.min.js"></script>
<script type="text/javascript">
  
	function doSub(){
		var rs = Validator.Validate(document.getElementById("theform"),1);
		var result = 0 ;
		if(rs){
			jQuery("#theform").ajaxSubmit({
				type : "POST",
				async : false ,
				success : function(data) {
					var rs = parseInt(jQuery.trim(data), 10);
					result = rs ;
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
		if(result>0)
		{
		  return true ;
		}
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
	hs.graphicsDir = '/plugin/other/highslide/graphics/';
	hs.wrapperClassName = 'wide-border';
	function smallToBig(o,id){
	jQuery(o).attr("href","/uploadfiles/"+jQuery("#"+id).val());
	return hs.expand(o);
}
</script><%
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		dbHelper.freeConnection(connection);
	}
%>