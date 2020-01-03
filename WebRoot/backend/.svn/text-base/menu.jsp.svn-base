<%@ page language="java" import="java.util.*,com.jerehnet.util.dbutil.*,com.jerehnet.util.common.*" pageEncoding="UTF-8"%><%
	String tablePrefix = Env.getInstance().getProperty("table_prefix");
	String sql = " select uuid,parent_uuid,name,action_link from "+tablePrefix+"common_channel "; 
	sql += " order by order_no desc ";
	Map adminInfo = (Map)session.getAttribute("adminInfo");
	if(adminInfo.get("usern").toString().equals("admin")){
		sql = " select uuid,parent_uuid,name,action_link from "+tablePrefix+"common_channel "; 
		sql += " order by order_no desc ";
	}else if(adminInfo.get("role_uuid").toString().equals("4CCDF227-7F10-4E09-A47C-085CCB4A45FF")){//如果角色为空的话
		sql = " select pcc.uuid,pcc.parent_uuid,pcc.name,pcc.action_link  ";
		sql += " from "+tablePrefix+"common_channel pcc , "+tablePrefix+"common_role_resource pcrr ";
		sql += " where pcc.uuid = pcrr.resource_uuid and pcrr.usern = '"+adminInfo.get("usern")+"' order by pcc.order_no desc";
	}else{
		sql = " select pcc.uuid,pcc.parent_uuid,pcc.name,pcc.action_link  ";
		sql += " from "+tablePrefix+"common_channel pcc , "+tablePrefix+"common_role_resource pcrr ";
		sql += " where pcc.uuid = pcrr.resource_uuid and pcrr.role_uuid = '"+adminInfo.get("role_uuid")+"'  order by pcc.order_no desc";
	}
	List<Map> channels = DBHelper.getInstance().getMapList(sql);
	StringBuffer tree = new StringBuffer();
	String parentUUID = "";
	String UUID = "";
	String actionLink = "";
	String name = "";
	for(Map m : channels){
		UUID = (String)m.get("uuid");
		parentUUID = m.get("parent_uuid")==null?"0":(String)m.get("parent_uuid");
		actionLink = (String)m.get("action_link");
		name = (String)m.get("name");
		tree.append("{ id:'"+UUID+"', pId:'"+parentUUID+"', name:'"+name+"'");
		if(!"".equals(actionLink)){
			tree.append(",click:\"parAddTab('"+UUID+"','"+name+"','"+actionLink+"?channel_uuid="+UUID+"');\"");
		}
		if(parentUUID.toString().equals("4CCDF227-7F10-4E09-A47C-085CCB4A45FF")){
			tree.append(",open:true");
		}
		tree.append("},");
	}
	if(tree.length()>1&&tree.indexOf(",")!=-1){
		tree.setLength(tree.length()-1);
	}
%><!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>菜单</title>
	<link rel="stylesheet" type="text/css" href="/plugin/tree/ztree/zTreeStyle/zTreeStyle.css" />
  </head>
  
  <body>
    <ul id="ztree" style="margin-top: 3px;" class="ztree"></ul>
  </body>
</html>
<script src="/plugin/jquery/jquery.min.js" type="text/javascript"></script>
<script src="/plugin/tree/ztree/jquery.ztree.all-3.1.js" type="text/javascript"></script>
<script type="text/javascript">

var zTreeNodes = [
	<%=tree.toString() %>
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
			rootPId: "0"
		}
	}
};

jQuery.fn.zTree.init(jQuery("#ztree"), setting, zTreeNodes);

function parAddTab(tbid,name,url){
	if(url.indexOf('/?channel_uuid')!=-1){
		return;
	}
	window.parent.f_addTab(tbid,name,url);
}
</script>