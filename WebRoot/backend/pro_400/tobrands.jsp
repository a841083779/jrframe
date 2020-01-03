<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.jerehnet.util.common.CommonString"%>
<%@page import="com.jerehnet.util.dbutil.DBHelper"%>
<%
	DBHelper dbHelper = DBHelper.getInstance() ;
	StringBuffer tree = new StringBuffer() ;
	String fomId = CommonString.getFormatPara(request.getParameter("fomId")) ;  // 订单 id 
	List<Map> brands = new ArrayList<Map>() ;
	Map map1 = new HashMap() ;
	map1.put("id","133") ;map1.put("name","三一") ;
	brands.add(map1) ;
	Map map2 = new HashMap() ;
	map2.put("id","194") ;
	map2.put("name","现代") ;
	brands.add(map2) ;
	
	Map map3 = new HashMap() ;
	map3.put("id","135") ;
	map3.put("name","龙工") ;
	brands.add(map3) ;
	
	Map map4 = new HashMap() ;
	map4.put("id","209") ;
	map4.put("name","徐工") ;
	brands.add(map4) ;
	
	Map map5 = new HashMap() ;
	map5.put("id","679") ;
	map5.put("name","军恒") ;
	brands.add(map5) ;
	
	Map map6 = new HashMap() ;
	map6.put("id","487") ;
	map6.put("name","江麓") ;
	brands.add(map6) ;
	
	Map map7 = new HashMap() ;
	map7.put("id","192") ;
	map7.put("name","斗山") ;
	brands.add(map7) ;
	
	Map hasbrandids = null ;
	String hasbrandsidsstr = "" ;
	if(!"".equals(fomId)){
		// brands = dbHelper.getMapList("  select name,id from pro_agent_factory where name is not null and name<>'' and flag=1 and  (parent_factoryid is null or parent_factoryid=0) order by name ") ;
		hasbrandids = dbHelper.getMap(" select to_brands from pro_product_form where id = '"+fomId+"'") ;
	}
	if(null!=hasbrandids){
		String[] hasbrands = CommonString.getFormatPara(hasbrandids.get("to_brands")).split(",") ;
		for(String str:hasbrands){
			hasbrandsidsstr += ","+str+"," ;
		}
	}
	if(null != brands){
		tree.append("{id:'-1',name:'已引导品牌',open:true},") ;
		tree.append("{id:'0',name:'引导品牌',open:true},") ;
		for(Map oneMap:brands){
			if(hasbrandsidsstr.indexOf(","+CommonString.getFormatPara(oneMap.get("id")+","))!=-1){
			 	tree.append("{ id:'"+oneMap.get("id")+"', pId:'-1', name:'"+oneMap.get("name")+"',open:true,checked:true},");
			}else{
			tree.append("{ id:'"+oneMap.get("id")+"', pId:'0', name:'"+oneMap.get("name")+"',open:true},");
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
	var powers = ",";
	for(var i=0;i<chks.length;i++){
		powers += chks[i].id+",";
	}
	if(null!=powers&&""!=powers&&powers.indexOf(",")!=-1){
		// powers = powers.substring(0,powers.length-1); 
	}
	jQuery.ajax({
	 url:"/backend/action/ajax_cud.jsp" ,
	 type:"post" ,
	 data:{'flag':'set_tobrands','brandids':powers,'fomId':<%=fomId%>}, 
	 async:false,
	 success:function(msg){ 
	 	if(jQuery.trim(msg)=='ok'){
	 	  alert("品牌推荐成功！") ;
	 	}
	 }
	}) ;
}
</script>