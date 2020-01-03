<%@ page language="java" import="java.util.*,java.sql.*,com.jerehnet.util.dbutil.*,com.jerehnet.util.common.*" pageEncoding="UTF-8"%><%
	Connection connection = null;
	String tablePrefix = Env.getInstance().getProperty("table_prefix");
	DBHelper dbHelper = DBHelper.getInstance();
	Map model = new HashMap();
	String tableName = "pro_index_data";
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
	
	  Map positionMap = new HashMap() ;
	  positionMap.put("0","普通店铺") ;
	  positionMap.put("1","代理商旗舰店") ;
	  positionMap.put("2","旗舰店") ; 
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
  <body style="margin: 0;padding: 0; overflow-x: hidden; ">
	<form name="theform" id="theform" action="/backend/action/crud.jsp">
		<div class="formDiv">
					<div class="group">
					<span>
				    <img src="/plugin/ui/ligerUI/ligerUI/skins/icons/communication.gif"/>
				     </span>
					<span class="groupTitle">基础信息</span>
					</div>
				<div class="formLeft">标题</div>
				<div class="formRight">
					<input type="text" class="jr_text" name="zd_title" id="zd_title" value="<%=CommonString.getFormatPara(model.get("title")) %>" />
				</div>
				<div style="clear:left;"></div>
					<div class="formLeft">短标题</div>
				<div class="formRight">
					<input type="text" class="jr_text" name="zd_sub_title" id="zd_sub_title" value="<%=CommonString.getFormatPara(model.get("sub_title")) %>" />
				</div>
				<div style="clear:left;"></div>
				<div class="formLeft">摘要</div>
				<div class="formRight">
					<input type="text" class="jr_text" name="zd_summary" id="zd_summary" value="<%=CommonString.getFormatPara(model.get("summary")) %>" />
				</div>				
				<div style="clear:left;"></div>
				<div class="formLeft">序号</div>
				<div class="formRight">
					<input type="text" class="jr_text" name="zd_order_no"  Style="width:100px;float: left;" id="zd_order_no" value="<%=CommonString.getFormatPara(model.get("order_no")) %>" />
				</div>
				<div style="clear:left;"></div>
				<div class="formLeft">链接</div>
				<div class="formRight">
					<input type="text" class="jr_text" name="zd_url" id="zd_url" value="<%=CommonString.getFormatPara(model.get("url")) %>" />
				</div>
				<div style="clear:left;"></div>
				 <div class="formLeft">图片</div>
				<div class="formRight">
		          <input type="text" style="width: 400px;" class="jr_text" name="zd_img" id="zd_img" value="<%=CommonString.getFormatPara(model.get("img")) %>" />
		        </div>
				<div class="formRight" style="padding-left: 220px; position: relative; top:-2px;">
					<input style="float:right;" type="button" class="btn" onclick="chooseFile('zd_img',700,480);" value="选择图片" />
					<a href="javascript:void(0);" class='highslide' onclick='return smallToBig(this,"zd_img");'><input style="float:right; margin-right: 5px;" type="button" class="btn" value="预览" /></a>
				</div>
				<div style="clear:left;"></div>
			
				<div class="formLeft">显<span class="span3">&nbsp;</span>示</div>
				<div class="formRight">
					<%=CommonForm.createIsRadio(CommonString.getFormatPara(model.get("is_pub")),"zd_is_pub") %>
				</div>
				<div style="clear:left;"></div>
				<div class="formLeft">旗舰店铺</div>
				<div class="formRight" style="width: 300px;" >
					<%
					String position = CommonString.getFormatPara(model.get("sort_flag"));
					if(position==null || position.equals("")){
						position = "0";
					}
				%>
				<%=CommonForm.createRadio(positionMap,position,"zd_sort_flag") %>
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