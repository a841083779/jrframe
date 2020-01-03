<%@ page language="java" import="java.util.*,java.sql.*,com.jerehnet.util.dbutil.*,com.jerehnet.util.common.*,org.json.JSONArray" pageEncoding="UTF-8"%><%
	Connection connection = null;
	DBHelper dbHelper = DBHelper.getInstance();
	Map model = new HashMap();
	String tablePrefix = Env.getInstance().getProperty("table_prefix");
	String tableName = tablePrefix +  "common_channel_subblock";
	String channelUUID = CommonString.getFormatPara(request.getParameter("channel_uuid"));
	List<Map> channelList = (List<Map>)application.getAttribute("channelList");
	try {
		connection = dbHelper.getConnection();
		String id = CommonString.getFormatPara(request.getParameter("id"));
		if (null != id && !"".equals(id)) {
			model = dbHelper.getMap(" select * from " + tableName + " where uuid = ? ", new Object[] { id }, connection);
		}
		
		/*数据样式*/
		Map dataStyle = new TreeMap();
		dataStyle.put("0","列表样式");
		dataStyle.put("1","单条样式");
		/*数据样式*/
		
		/*元素所属栏目*/
		String sql = "";
		if(!"".equals(id)){
			sql = " select pcc.uuid,pcc.name,pcc.parent_uuid,pcacs.subblock_uuid from "+tablePrefix+"common_channel pcc ";
			sql += " left join "+tablePrefix+"common_acl_channel_subblock pcacs ";
			sql += " on pcc.uuid = pcacs.channel_uuid ";
			sql += " and pcacs.subblock_uuid = '"+id+"' ";
		}else{
			sql = " select * from "+tablePrefix+"common_channel ";
		}
		List<Map> channel_subblock = dbHelper.getMapList(sql,connection);
		StringBuffer tree = new StringBuffer();
		String parentUUID = "";
		String UUID = "";
		String name = "";
		String subUUID = "";
		for(Map m : channel_subblock){
			UUID = CommonString.getFormatPara((String)m.get("uuid"));
			subUUID = CommonString.getFormatPara((String)m.get("subblock_uuid"));
			parentUUID = m.get("parent_uuid")==null?"0":(String)m.get("parent_uuid");
			name = CommonString.getFormatPara((String)m.get("name"));
			tree.append("{ id:'"+UUID+"', pId:'"+parentUUID+"', name:'"+name+"'");
			if(parentUUID.toString().equals("4CCDF227-7F10-4E09-A47C-085CCB4A45FF")){
				tree.append(",open:true");
			}
			if(!"".equals(subUUID)||channelUUID.equals(UUID)){
				tree.append(",checked:true");
			}
			tree.append("},");
		}
		/*元素所属栏目*/
		
%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title><%=Env.getInstance().getProperty("project_name")%></title>
		<link rel="stylesheet" type="text/css" href="/plugin/tree/ztree/zTreeStyle/zTreeStyle.css" />
		<link href="/plugin/ui/ligerUI/ligerUI/skins/Aqua/css/ligerui-all.css" rel="stylesheet" type="text/css" />
		<link href="/plugin/ui/ligerUI/ligerUI/skins/Gray/css/all.css" rel="stylesheet" type="text/css" />
		<link href="/plugin/ui/ligerUI/ligerUI/skins/ligerui-icons.css" rel="stylesheet" type="text/css" />
		<link href="/backend/style/style.css" rel="stylesheet" type="text/css" />
		<script src="/plugin/jquery/jquery.min.js" type="text/javascript"></script>
		<style type="text/css">
			#show_field{
				position: relative;
				top:-120px;
				left:-60px; 
				width: 400px; 
				height: 100px; 
				border: 1px solid #ccc; 
				word-break:break-all; 
				background: #fff;
				display: none;
				overflow-y: scroll;
			}
			#template {
				display: none;
				width: 300px;
				height: 240px;
				border: 1px solid #ccc;
				position: relative;
				top: -240px;
				left: 80px;
				background: #fff;
				overflow-y: scroll;
				overflow-x: hidden;
				z-index: 99999;
			}
		</style>
	</head>
	
	<body style="margin: 0;padding: 0; overflow-x: hidden; ">
		<form name="theform" id="theform" action="/backend/action/crud.jsp">
		  <div class="formDiv">
		    <div class="group">
			    <span>
			    	<img src="/plugin/ui/ligerUI/ligerUI/skins/icons/communication.gif" />
			    </span>
		    	<span class="groupTitle">基础信息</span>
		    </div>
		    <div class="formLeft">子块名称</div>
		    <div class="formRight">
		      <input type="text" dataType="Require" msg="请您输入子块名称！" class="jr_text" name="zd_name" id="zd_name" value="<%=CommonString.getFormatPara(model.get("name"))%>" />
		    </div>
		    <div style="clear:left;"></div>
		     <div class="formLeft">数据录入</div>
		    <div class="formRight">
		    	<%
		    		String isData = CommonString.getFormatPara(model.get("is_data"));
		    		if("".equals(isData)){
		    			isData = "0";
		    		}
		    	%>
		      <%=CommonForm.createIsRadio(isData,"zd_is_data")%>
		    </div>
		    <div class="formLeft" style="width: 300px;text-align: left;">（指定该元素数据是从其它位置调取还是自身录入）</div>
		    <div style="clear: left;"></div>
		    <div class="formLeft">数据样式</div>
		    <div class="formRight">
		      <%=CommonForm.createRadio(dataStyle,CommonString.getFormatPara(model.get("style")),"zd_style") %>
		    </div>
		    <div class="formLeft" style="width: 300px; text-align: left;">（数据自身录入是列表数据还是单条数据）</div>
		    <div style="clear: left;"></div>
		    <div class="group">
			    <span>
			    	<img src="/plugin/ui/ligerUI/ligerUI/skins/icons/communication.gif" />
			    </span>
		    	<span class="groupTitle">数据信息</span>
		    </div>
		    <div class="formLeft">键<span class="span3"></span>名<span class="span3"></span>称</div>
		    <div class="formRight">
		      <input type="text" class="jr_text" onkeyup="judgeKeyExist();" name="zd_data_key" id="zd_data_key" value="<%=CommonHtml.getDefault(model.get("data_key"),"infoList")%>" />
		    </div>
		    <div style="clear: left;"></div>
		    <div class="formLeft">SQL语句</div>
		    <div class="formRight" style="height: 50px;">
		      <textarea class="jr_textarea" name="zd_data_sql" id="zd_data_sql" rows="2" cols="77"><%=CommonString.getFormatPara(model.get("data_sql"))%></textarea>
		    </div>
		    <div style="clear:left;"></div>
		    <div class="group">
			    <span>
			    	<img src="/plugin/ui/ligerUI/ligerUI/skins/icons/communication.gif" />
			    </span>
		    	<span class="groupTitle">其它信息</span>
		    </div>
		    <div class="formLeft">是否显示</div>
		    <div class="formRight">
		      <%=CommonForm.createIsRadio(CommonString.getFormatPara(model.get("is_show")),"zd_is_show")%>
		    </div>
		    <div class="formRight" style="text-align: left;">
		    	<input type="button" class="btn" value="所属栏目" id="suoshulanmu" />
	    		<div id="template">
	    			<ul id="ztree" class="ztree"></ul>
	    		</div>
		    </div>
		    <div style="clear: left;"></div>
		  </div>
		  <div style="clear: left;"></div>
		  <input type="hidden" name="tableName" id="tableName" value="<%=tableName%>" />
		  <input type="hidden" name="zd_id" id="zd_id" value="<%=CommonString.getFormatPara(model.get("id")) %>" />
		  <input type="hidden" name="zd_order_no" id="zd_order_no" value="<%=CommonString.getFormatPara(model.get("order_no"))%>" />
		  <input type="hidden" name="zd_template_file_name" id="zd_template_file_name" value="<%=CommonString.getFormatPara(model.get("template_file_name"))%>" />
		  <input type="hidden" name="zd_create_file_name" id="zd_create_file_name" value="<%=CommonString.getFormatPara(model.get("create_file_name"))%>" />
		  <input type="hidden" name="eventAfter" value="saveChannelSubblock" />
		  <input type="hidden" name="channel_uuid" id="channel_uuid" value="" />
		</form>
	</body>
</html>
<script type="text/javascript" src="/plugin/jquery/jquery.form.js"></script>
<script src="/plugin/ui/ligerUI/ligerUI/js/ligerui.min.js" type="text/javascript"></script>
<script src="/backend/scripts/common.js" type="text/javascript"></script>
<script src="/plugin/validator/wofoshan/validator.min.js" type="text/javascript"></script>
<script src="/plugin/tree/ztree/jquery.ztree.all-3.1.js" type="text/javascript"></script>
<script type="text/javascript">
	jQuery("#suoshulanmu").click(function(){
		var lmnr = jQuery.trim(jQuery(this).val());
		if(lmnr=='所属栏目'){
			jQuery("#template").show();
			jQuery(this).val("隐藏栏目");
		}else{
			jQuery("#template").hide();
			jQuery(this).val("所属栏目");
		}
	});
	function doSub(){
		var channel_uuid = "";
		var ckNodes = ztree.getCheckedNodes(true);
		for(var i=0;i<ckNodes.length;i++){
			channel_uuid += ckNodes[i].id + ",";
		}
		channel_uuid = jQuery.trim(channel_uuid);
		if(channel_uuid.indexOf(",")!=-1){
			channel_uuid = channel_uuid.substring(0,channel_uuid.length-1);
		}
		jQuery("#channel_uuid").val(channel_uuid);
		jQuery("#theform").ajaxSubmit({
			type : "POST",
            async : false ,
			success : function(data) {
				var rs = parseInt(jQuery.trim(data), 10);
				if (rs > 0) {
					jrSuccess("保存成功！");
					<%
					if("".equals(CommonString.getFormatPara(model.get("id")))){
						%>
					window.location.reload();
						<%
					}
					%>
				} 
			}
		});
	}

	jQuery("input[name=zd_is_data]").click(function(){
		if(this.checked&&this.value==1){
			if(undefined!=jQuery("#zd_style1").attr("checked")){
				jQuery("#zd_data_sql").val(createSingleSQL());
			}else{
				jQuery("#zd_data_sql").val('');
			}
		}else{
			jQuery("#zd_data_sql").val('');
		}
	});
	jQuery("input[name=zd_style]").click(function(){
		if(this.checked&&this.value==1){
			if(undefined!=jQuery("#zd_is_data0").attr("checked")){
				jQuery("#zd_data_sql").val(createSingleSQL());
			}else{
				jQuery("#zd_data_sql").val('');
			}
		}else{
			jQuery("#zd_data_sql").val('');
		}
	});
	var setting = {
		check: {
			enable: true
		},
		data: {
			simpleData: {
				enable: true
			}
		}
	};
	var zTreeNodes = [
		<%=tree.toString() %>
	];
	var ztree = jQuery.fn.zTree.init(jQuery("#ztree"), setting, zTreeNodes);
</script>
<%
	} catch (Exception e) {
		e.printStackTrace();
	} finally {
		dbHelper.freeConnection(connection);
	}
%>