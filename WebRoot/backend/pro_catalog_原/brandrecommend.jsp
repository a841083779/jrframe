<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.jerehnet.util.common.CommonString"%>
<%@page import="com.jerehnet.util.dbutil.DBHelper"%>
<%
	DBHelper dbHelper = DBHelper.getInstance() ;
	StringBuffer tree = new StringBuffer() ;
	String catalognum = CommonString.getFormatPara(request.getParameter("catalognum")) ;
	List<Map> brands = null ;
	List<Map> hasbrandids = null ;
	String hasbrandsidsstr = "" ;
	if(!"".equals(catalognum)){
		brands = dbHelper.getMapList(" select factoryid,factoryname from pro_products where catalognum like '"+catalognum+"%' and factoryid is not null and factoryname is not null group by factoryid,factoryname order by factoryname ") ;
		hasbrandids = dbHelper.getMapList(" select factoryid from pro_catalog_factory where catalognum = '"+catalognum+"'") ;
	}
	if(null!=hasbrandids){
		for(Map oneMap:hasbrandids){
			hasbrandsidsstr += CommonString.getFormatPara(oneMap.get("factoryid")) +"," ;
		}
	}
	if(null != brands){
		tree.append("{id:'0',name:'品牌推荐',open:true},") ;
		for(Map oneMap:brands){
			if(hasbrandsidsstr.indexOf(CommonString.getFormatPara(oneMap.get("factoryid")))!=-1){
				tree.append("{ id:'"+oneMap.get("factoryid")+"', pId:'0', name:'"+oneMap.get("factoryname")+"',open:true,checked:true},");
			}else{
			tree.append("{ id:'"+oneMap.get("factoryid")+"', pId:'0', name:'"+oneMap.get("factoryname")+"',open:true},");
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
	 data:{'flag':'set_brandrecommend','brandids':powers,'catalognum':<%=catalognum%>},
	 async:false,
	 success:function(msg){
	 	if(jQuery.trim(msg)=='ok'){
	 	  alert("品牌推荐成功！") ;
	 	}
	 }
	}) ;
}
</script>