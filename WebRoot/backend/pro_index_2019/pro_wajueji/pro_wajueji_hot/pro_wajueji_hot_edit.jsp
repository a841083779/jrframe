<%@ page language="java" import="java.util.*,java.sql.*,com.jerehnet.util.dbutil.*,com.jerehnet.util.common.*" pageEncoding="UTF-8"%><%
	Connection connection = null;
	String tablePrefix = Env.getInstance().getProperty("table_prefix");
	DBHelper dbHelper = DBHelper.getInstance();
	Map model = new HashMap();
	String tableName = "pro_spec_data";
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
	
	  Map typeMap = new HashMap() ;
	  typeMap.put("1","卡特彼勒") ;
	  typeMap.put("2","三一") ;
	  typeMap.put("3","山东临工") ; 
	  typeMap.put("4","徐工") ; 
	  typeMap.put("5","小松") ; 
	  
	  
%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <title><%=Env.getInstance().getProperty("project_name") %></title>
	<link href="/plugin/ui/ligerUI/ligerUI/skins/Aqua/css/ligerui-all.css" rel="stylesheet" type="text/css" />
	<link href="/plugin/ui/ligerUI/ligerUI/skins/Gray/css/all.css" rel="stylesheet" type="text/css" />
	<link href="/plugin/ui/ligerUI/ligerUI/skins/ligerui-icons.css" rel="stylesheet" type="text/css" />
	<link href="/backend/style/style.css" rel="stylesheet" type="text/css" />
	<script src="/plugin/jquery/jquery.min.js" type="text/javascript"></script>
	<script type="text/javascript" src="/plugin/date/My97DatePicker/WdatePicker.js"></script>
  </head>
  
  <style>.formRight{margin-bottom: 20px;}</style>
  <body style="margin: 0;padding: 0; overflow-x: hidden; overflow-y: auto; ">
	<form name="theform" id="theform" action="/backend/action/crud.jsp">
		<div class="formDiv">
					<div class="group">
					<span>
				    <img src="/plugin/ui/ligerUI/ligerUI/skins/icons/communication.gif"/>
				     </span>
					<span class="groupTitle">基础信息</span>
					</div>
				<div class="formLeft">热门机型</div>
				<div class="formRight">
					<input type="text" class="jr_text" name="zd_title" id="zd_title" value="<%=CommonString.getFormatPara(model.get("title")) %>" />
				</div>
				<div style="clear:left;"></div>
					<div class="formLeft">热门机型链接</div>
				<div class="formRight">
					<input type="text" class="jr_text" name="zd_title_url" id="zd_title_url" value="<%=CommonString.getFormatPara(model.get("title_url")) %>" />
				</div>
				<div style="clear:left;"></div>
				<div class="formLeft">询价链接</div>
				<div class="formRight">
					<input type="text" class="jr_text" name="zd_url1" id="zd_url1" value="<%=CommonString.getFormatPara(model.get("url1")) %>" />
				</div>		
				<div style="clear:left;"></div>
				<div class="formLeft">口碑链接</div>
				<div class="formRight">
					<input type="text" class="jr_text" name="zd_url2" id="zd_url2" value="<%=CommonString.getFormatPara(model.get("url2")) %>" />
				</div>		
				<div style="clear:left;"></div>
				<div class="formLeft">图库链接</div>
				<div class="formRight">
					<input type="text" class="jr_text" name="zd_url3" id="zd_url3" value="<%=CommonString.getFormatPara(model.get("url3")) %>" />
				</div>				
				<div style="clear:left;"></div>
				<div class="formLeft">序号</div>
				<div class="formRight">
					<input type="text" class="jr_text" name="zd_order_no"  Style="width:100px;float: left;" id="zd_order_no" value="<%=CommonString.getFormatPara(model.get("order_no")) %>" />
				</div>
				<div style="clear:left;"></div>
				<div class="formLeft">显<span class="span3">&nbsp;</span>示</div>
				<div class="formRight">
					<%=CommonForm.createIsRadio(CommonString.getFormatPara(model.get("is_pub")),"zd_is_pub") %>
				</div>
				
				<div style="clear:left;"></div>
				<div class="formLeft">是否为新产品</div>
				<div class="formRight">
					<%=CommonForm.createIsRadio(CommonString.getFormatPara(model.get("is_display")),"zd_is_display") %>
				</div>
				<div style="clear:left;"></div>
				<div class="formLeft">所属品牌</div>
				<div class="formRight" >
					<select id='zd_type' name="zd_type" onchange="set_modelParam(this)">
						<%if(CommonString.getFormatPara(model.get("type")).equals("1")||CommonString.getFormatPara(model.get("type")).equals("")){%>
							<option  value = "1"  selected = "selected" >卡特彼勒</option>
						<%}else{%>
							<option  value = "1"  >卡特彼勒</option>
						<%}%>
						<%if(CommonString.getFormatPara(model.get("type")).equals("2")){%>
							<option  value = "2"  selected = "selected" >三一</option>
						<%}else{%>
							<option  value = "2"  >三一</ option >
						<%}%>
						<%if(CommonString.getFormatPara(model.get("type")).equals("3")){%>
							<option  value = "3"  selected = "selected" >山东临工</option>
						<%}else{%>
							<option  value = "3"  >山东临工</ option >
						<%}%>
						<%if(CommonString.getFormatPara(model.get("type")).equals("4")){%>
							<option  value = "4"  selected = "selected" >徐工</option>
						<%}else{%>
							<option  value = "4"  >徐工</ option >
						<%}%>
						<%if(CommonString.getFormatPara(model.get("type")).equals("5")){%>
							<option  value = "5"  selected = "selected" >小松</option>
						<%}else{%>
							<option  value = "5"  >小松</ option >
						<%}%>
					</select>
				</div>
				<div style="clear:left;"></div>
				<div class="formLeft">发布日期</div>
				<div class="formRight" style="width:120px;">
				<%
					String pubDate = CommonString.getFormatPara(model.get("pub_date"));
					if(pubDate==null || pubDate.equals("")){
						pubDate = CommonDate.getToday("yyyy-MM-dd");
					}
					
					%>
					<input type="text" name="zd_pub_date" id="zd_pub_date" class="Wdate" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'});" value="<%=pubDate %>">
				</div>
		</div>
		<div style="clear: left;"></div>
		<input type="hidden" name="tableName" id="tableName" value="<%=tableName %>" />
		<input type="hidden" name="zd_id" id="zd_id" value="<%=CommonString.getFormatPara(model.get("id")) %>" />
		<input type="hidden" name="zd_channel_uuid" id="zd_channel_uuid" value="<%=channelUUID%>" />
	</form>
  </body>
</html>
<script type="text/javascript" src="/plugin/jquery/jquery.form.js"></script>
<script src="/plugin/ui/ligerUI/ligerUI/js/ligerui.min.js" type="text/javascript"></script>
<script src="/backend/scripts/common.js" prefix="<%=tablePrefix %>" type="text/javascript"></script>
<script src="/plugin/validator/wofoshan/validator.min.js" type="text/javascript"></script>
<script src="/plugin/other/highslide/highslide.min.js" type="text/javascript"></script>
<script type="text/javascript" src="http://resource.21-sun.com/plugin/upload/jr_upload.js"></script>
<script type="text/javascript">
	hs.graphicsDir = '/plugin/other/highslide/graphics/';
	hs.wrapperClassName = 'wide-border';
	function smallToBig(o,id){
		var sor = jQuery("#"+id).val();
		if(sor.indexOf('news')>-1){
			jQuery(o).attr("href",jQuery("#"+id).val());
		}else{
			jQuery(o).attr("href","/uploadfiles/"+jQuery("#"+id).val());
		}
		return hs.expand(o);
	}
	
	function doSub(){
	   var result = 0 ;
		var rs = Validator.Validate(document.getElementById("theform"),1);
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
	
</script><%
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		dbHelper.freeConnection(connection);
	}
%>