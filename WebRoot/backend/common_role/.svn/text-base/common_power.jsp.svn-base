<%@ page language="java" import="java.util.*,java.sql.*,com.jerehnet.util.dbutil.*,com.jerehnet.util.common.*" pageEncoding="UTF-8"%><%
	Connection conn = null;
	String tablePrefix = Env.getInstance().getProperty("table_prefix");
	DBHelper dbHelper = DBHelper.getInstance();
	StringBuffer tree = new StringBuffer();
	String roleUUID = "";
	try{
		conn = dbHelper.getConnection();
		Map role = dbHelper.getMap(" select uuid from "+tablePrefix+"common_role where uuid = ? ",new Object [] {CommonString.getFormatPara(request.getParameter("id"))},conn);
		roleUUID = (String)role.get("uuid");
		List<Map> channelList = dbHelper.getMapList(" select uuid,name,parent_uuid from "+tablePrefix+"common_channel where is_show = 1 order by uuid ",conn);
		List<Map> roleList = dbHelper.getMapList(" select resource_uuid from "+tablePrefix+"common_role_resource where role_uuid = ? ",new Object [] {roleUUID},conn);
		Map powerMap = new HashMap();
		for(Map m : roleList){
			powerMap.put(m.get("resource_uuid").toString(),true);
		}
		for(Map m : channelList){
			if(null!=powerMap.get(m.get("uuid").toString())){
				tree.append("{ id:'"+m.get("uuid")+"', pId:'"+m.get("parent_uuid")+"', name:'"+m.get("name")+"',open:true,checked:true},");
			}else{
				tree.append("{ id:'"+m.get("uuid")+"', pId:'"+m.get("parent_uuid")+"', name:'"+m.get("name")+"',open:true},");
			}
		}
		if(null!=tree&&tree.length()>1){
			tree.setLength(tree.length()-1);
		}
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		dbHelper.freeConnection(conn);
	}
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title><%=Env.getInstance().getProperty("project_name") %></title>
	<link rel="stylesheet" type="text/css" href="/plugin/tree/ztree/zTreeStyle/zTreeStyle.css" />
  </head>
  
  <body>
    <ul id="ztree" style="margin-top: 3px;" class="ztree"></ul>
  </body>
</html>
<script src="/plugin/jquery/jquery.min.js" type="text/javascript"></script>
<script src="/plugin/tree/ztree/jquery.ztree.all-3.1.js" type="text/javascript"></script>
<script src="/backend/scripts/common.js" prefix="<%=tablePrefix %>" type="text/javascript"></script>
<script type="text/javascript">
var zTreeNodes = [
	<%=tree %>
];
var setting = {
	view: {
		dblClickExpand: false,
		showLine: true,
		selectedMulti: false,
		expandSpeed: ($.browser.msie && parseInt($.browser.version)<=6)?"":"fast"
	},
	data: {
		simpleData: {
			enable:true,
			idKey: "id",
			pIdKey: "pId",
			rootPId: "0"
		}
	},
	check: {
		enable : true
	}
};
var zTree = jQuery.fn.zTree.init(jQuery("#ztree"), setting, zTreeNodes);
function doSub(dialog){
	var chks = zTree.getCheckedNodes(true);
	var powers = "";
	for(var i=0;i<chks.length;i++){
		powers += "'"+chks[i].id+"',";
	}
	if(null!=powers&&""!=powers&&powers.indexOf(",")!=-1){
		powers = powers.substring(0,powers.length-1);
	}
	jQuery.ajax({
		url:'/backend/action/ajax_cud.jsp',
		type:'post',
		data:{'flag':'set_power','power':powers,'role_uuid':'<%=roleUUID %>'},
		async:false,
		success:function(data){
			if(jQuery.trim(data)=='ok'){
				jrAlert("权限设置成功！");
				dialog.close();
			}else{
				jrAlert("权限设置失败！");
			}
		}
	});
}
</script>