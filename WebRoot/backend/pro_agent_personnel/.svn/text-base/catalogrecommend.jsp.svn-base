<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.jerehnet.util.common.CommonString"%>
<%@page import="com.jerehnet.util.dbutil.DBHelper"%>
<%
	DBHelper dbHelper = DBHelper.getInstance() ;
	StringBuffer tree = new StringBuffer() ;
	String facId = CommonString.getFormatPara(request.getParameter("facId")) ;
	List<Map> catalogsList = null ;
	List<Map> hascatalognums = null ;
	String hascatalogsidsstr = "" ;
	if(!"".equals(facId)){
		catalogsList = dbHelper.getMapList("select catalognum,catalogname from pro_products where factoryid=? and is_show=1 and catalognum is not null and catalognum<>'' and catalogname is not null and catalogname<>'' group by catalognum,catalogname order by catalogname ",new Object[]{facId}) ;
		hascatalognums = dbHelper.getMapList(" select catalognum from pro_catalog_factory where factoryid = '"+facId+"'") ;
	}
	if(null!=hascatalognums){
		for(Map oneMap:hascatalognums){
			hascatalogsidsstr += CommonString.getFormatPara(oneMap.get("catalognum")) +"," ;
		}
	}
	if(null != catalogsList){
		tree.append("{id:'0',name:'机型推荐',open:true},") ;
		for(Map oneMap:catalogsList){
			if(hascatalogsidsstr.indexOf(CommonString.getFormatPara(oneMap.get("catalognum")))!=-1){
				tree.append("{ id:'"+oneMap.get("catalognum")+"', pId:'0', name:'"+oneMap.get("catalogname")+"',open:true,checked:true},");
			}else{
			tree.append("{ id:'"+oneMap.get("catalognum")+"', pId:'0', name:'"+oneMap.get("catalogname")+"',open:true},");
			}
		}
	}
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title></title>
	<link rel="stylesheet" type="text/css" href="/plugin/tree/ztree/zTreeStyle/zTreeStyle.css" />
  </head>
  <body>
    <ul id="ztree" style="margin-top: 3px;" class="ztree"></ul>
  </body>
</html>
<script src="/plugin/jquery/jquery.min.js" type="text/javascript"></script>
<script src="/plugin/tree/ztree/jquery.ztree.all-3.1.js" type="text/javascript"></script>
<script src="/backend/scripts/common.js" type="text/javascript"></script>
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
		powers += chks[i].id+",";
	}
	if(null!=powers&&""!=powers&&powers.indexOf(",")!=-1){
		powers = powers.substring(2,powers.length-1);
	}
	jQuery.ajax({
	 url:"/backend/action/ajax_cud.jsp" ,
	 type:"post" ,
	 data:{'flag':'set_catalogrecommend','catalogids':powers,'facId':<%=facId%>},
	 async:false,
	 success:function(msg){
	 	if(jQuery.trim(msg)=='ok'){
	 	  alert("品牌推荐成功！") ;
	 	}
	 }
	}) ;
}
</script>