<%@ page language="java" import="java.util.*,com.jerehnet.util.common.*" pageEncoding="UTF-8"%>
<%@page import="com.jerehnet.util.dbutil.DBHelper"%>
<%
	String tableName = "pro_product_form";
	String tablePrefix = Env.getInstance().getProperty("table_prefix");
	String fileds = "id,add_date,factoryname,cataname,name,product_name,contact_address,contact_tel,state,mobile_phone,product_id";
	String channelUUID = CommonString.getFormatPara(request.getParameter("channel_uuid"));
	Map channelMap = (Map)application.getAttribute("channelMap");
	Map catalogMap = (Map)application.getAttribute("catalogMap") ;
	Map brandMap = (HashMap)application.getAttribute("brandMap") ;
	DBHelper dbHelper = DBHelper.getInstance() ;
	
	Map factoryInfo = (Map)session.getAttribute("factoryInfo");
	String whereStr = " and factoryid = '"+factoryInfo.get("id")+"' ";
	  if(CommonString.getFormatPara(factoryInfo.get("id")).equals("749")){ // 洛阳友建 只显示 河南和甘肃的订单
		 //   whereStr += " and ( province like '河南%' or province like '甘肃%')" ;
		  //  whereStr += " or factoryid='1187'" ;
	  //	  whereStr = "and ( factoryid = '"+factoryInfo.get("id")+"' or factoryid='1187')" ;
 	  }
	  if(CommonString.getFormatPara(factoryInfo.get("id")).equals("1187")){  // 如果是东方红 则取两家的订单（洛阳友建 和 东方红）
		  // whereStr += " or factoryid='749'" ;
		//  whereStr = "and ( factoryid = '"+factoryInfo.get("id")+"' or factoryid='749')" ;
	  }
	String factoryid = CommonString.getFormatPara(factoryInfo.get("id")) ;
	String orderByStr = " id desc ";
	CommonForm commonForm = new CommonForm() ;
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
	<title><%=Env.getInstance().getProperty("project_name") %></title>
	<link href="/plugin/ui/ligerUI/ligerUI/skins/Aqua/css/ligerui-all.css" rel="stylesheet" type="text/css" />
	<link href="/plugin/ui/ligerUI/ligerUI/skins/Gray/css/all.css" rel="stylesheet" type="text/css" />
	<link href="/plugin/ui/ligerUI/ligerUI/skins/ligerui-icons.css" rel="stylesheet" type="text/css" />
	<link rel="stylesheet" href="/plugin/dialog/jBox/Skins/Blue/jbox.css" type="text/css"></link>
	<link href="/admin/style/style.css" rel="stylesheet" type="text/css" />
	<style type="text/css">
.l-grid-body-table tr td { height:25px; }
</style>
	<script src="/plugin/jquery/jquery.min.js" type="text/javascript"></script>
	<script type="text/javascript" src="/plugin/dialog/jBox/jquery.jBox-2.3.min.js"></script></head>
	<body>
<form name="theform" id="theform" method="get">
      <div class="searchForm">
    <div class="searchCondition" style="width:750px">
          <div class="searchLeft">订单人</div>
          <div class="searchRight">
        <input type="text" style="width: 60px;" class="jr_text" name="name" id="name" />
      </div>
          <div class="searchLeft">订购时间</div>
          <div class="searchRight" style="width:120px;">
        <input type="text" style="width: 80px;"  name="start_date" id="start_date" />
      </div>
          <div class="searchLeft" style="width:10px;">&nbsp;~</div>
          <div class="searchRight">
        <input type="text" style="width: 80px;"  name="end_date" id="end_date" />
      </div>
      <div class="searchLeft">分类</div>
          <div class="searchRight">
        <input type="text" style="width: 120px;" class="jr_text" name="catalogname" id="catalogname" />
      </div>
        </div>
        <div style="clear:left;"></div>
    <div class="searchBtn" style="width:180px">
          <input style="margin-right:10px;" type="button" class="btn" onclick="doSearch();" value="查询" /><input type="button" class="btn" onclick="dosubmit();" value="导出" title="导出前一天16点到今天16点的订单" />
        </div>
  </div>
      <input type="hidden" name="if_tag" id="if_tag" value="test"/>
      <input type="hidden" name="factoryid" id="factoryid" value="<%=factoryid %>" />
    </form>
<div style="clear: left;"></div>
<div class="l-loading" style="display: block" id="pageloading"></div>
<div id="maingrid" style="margin: 0; padding: 0"></div>
<div style="display: none;">
      <input type="hidden" name="channel_uuid" id="channel_uuid" value="<%=channelUUID %>" />
    </div>
</body>
</html>
<script src="/plugin/ui/ligerUI/ligerUI/js/ligerui.min.js" type="text/javascript"></script>
<script src="/admin/scripts/common.js" prefix="<%=tablePrefix %>" type="text/javascript"></script>
<script type="text/javascript">
	var grid;
	var tableName = "<%=tableName %>";
	var fields = "<%=fileds %>";
	var whereStr = "<%=whereStr %>";
	var orderBy = "<%=orderByStr %>";
	var columnsArr = [];
	var url = "";
	var conditionStr = "";
	var params = [];
	jQuery(function() {
		jQuery.ligerDefaults.Grid.formatters['date'] = function(content,
				column) {
			return content.substring(0, content.indexOf(' '));
		}
		jQuery.ligerDefaults.Grid.formatters['is'] = function(content,
				column) {
			if (content == 1) {
				return '是';
			}
			return '否';
		}
		jQuery.ligerDefaults.Grid.formatters['sex'] = function(content,
				column) {
			if (content == 1) {
				return '男';
			}
			return '女';
		}
		url = "/admin/action/liger.jsp";
		params.push({'name':'tableName','value':tableName});
		params.push({'name':'fileds','value':fields});
		params.push({'name':'whereStr','value':whereStr});
		params.push({'name':'orderBy','value':orderBy});
		grid = jQuery("#maingrid").ligerGrid({
					columns : columnsArr,
					url : url,
					pageSize : 20,
					width : '99%',
					height : '98%',
					checkbox : false,
					selectRowButtonOnly : true,
					parms : params,
					rownumbers : true
				});
		jQuery("#pageloading").hide();
	});
	//列数组
	columnsArr =  [ 
	{ display : '所在地区', name : 'contact_address', align : 'center' , type : 'string' , width : 90 } ,
	{ display : '订单人', name : 'name', align : 'left' , type : 'string' , width : 60 ,render:function(row){
		return "<a class='link' href='javascript:void(0);' onclick='addAndEdit("+row.__index+");'>"+row.name+"</a>" ;
		}
	} ,
	{ display : '品牌', name : 'factoryname', align : 'center' , type : 'string' , width : 60 } ,
	{ display : '订购产品', name : 'product_name', align : 'left' , type : 'string' , width : 80 ,render:function(row){
	   return "<a href='../goto.jsp?flag=1&id="+row.product_id+"' target='_blank'>"+(row.product_name==null?"":row.product_name)+"</a>" ;
	  }
	} ,
	{ display : '所属分类', name : 'cataname', align : 'left' , type : 'string' , width : 100 } ,
	{ display : '手机号码', name : 'mobile_phone', align : 'center' , type : 'string' , width : 100 ,render:function(row){
		return  (row.state==0?"<a class='link' href='javascript:;' onclick='showTel(this,"+(row.mobile_phone==null?row.contact_tel:row.mobile_phone)+")' showid="+row.uuid+">查看</a>":(row.mobile_phone==null?row.contact_tel:row.mobile_phone)) ;
	  }} ,
	{ display : '订购时间', name : 'add_date', align : 'center' , type : 'string' , width : 130 ,render:function(row){
	      return (row.add_date.length>=19)?row.add_date.substr(0,19):row.add_date ;
	  }},
	 	{ display : '处理意见', name : 'dispose_ps', align : 'center' , width : 50,render:function(row){
	 		return "<a href='javascript:;' style='"+((row.dispose_ps!=''&&row.dispose_ps!=null)?"color:green":"")+"' class='link' onclick=inputPs('"+row.uuid+"')>意见</a>" ;
	 	} }
	];
	
	//增加和编辑的方法
	function addAndEdit(index){
    	if(undefined==index){//如果是增加
    	    toolbarAdd({
	    		width:700,
	    		height:620,
	    		title:'增加',
	    		params : {
	    			channel_uuid : "<%=channelUUID %>"
	    		}
	    	});
    	}else{//如果是修改
    		var row = grid.getRow(index);
    	    toolbarAdd({
	    		width:800,
	    		height:620,
	    		title:'查看',
				folderName:"factory/pro_product_form"
	    	},row.uuid);
    	}
    }
	jQuery(".searchForm input[type=text]").keypress(function(e){
		if(e.keyCode==13){
			doSearch();
		}
	});
	/*列表页条件查询*/
	function doSearch(){
		params = [];
		conditionStr = "";
		var start_date = jQuery("#start_date").val();
		if(''!=jQuery.trim(start_date)){
			conditionStr += " and add_date >='"+start_date+" 00:00:00'";
		}
		var end_date = jQuery("#end_date").val() ;
		if(''!=jQuery.trim(end_date))
		{
		   conditionStr += " and add_date <='"+end_date+" 23:59:59'";
		}
		var name = jQuery("#name").val();
		if(''!=jQuery.trim(name)){
			conditionStr += " and name like '%"+name+"%' ";
		}
		var catalogname = jQuery("#catalogname").val() ;
		if(''!=jQuery.trim(catalogname))
		{
		  conditionStr += " and cataname like '%"+catalogname+"%' ";
		}
		params.push({'name':'tableName','value':tableName});
		params.push({'name':'fileds','value':fields});
		params.push({'name':'whereStr','value':whereStr+conditionStr});
		params.push({'name':'orderBy','value':orderBy});
		grid.options.parms=params;
		grid.loadData();
	}
	
	/*列表页清空查询*/
	function doClearForm(){
		jQuery(".searchForm input:text").val('');
		 // alert(jQuery(".searchForm select option:eq(0)").html()) ;
       jQuery("#catanum option:eq(0)").attr("selected",true) ;
       jQuery("#factoryid option:eq(0)").attr("selected",true) ;
	}
	// 1 省份 1 月份
	function showTOP10orders(obj){
	  jrWindow("/admin/pro_product_form/top10orders.jsp?if_tag="+obj,obj=="1"?"省份订单量前10位":"月份订单量前10位","600","360") ;
	}
	jQuery("#start_date").ligerDateEditor({width:120});
	jQuery("#end_date").ligerDateEditor({width:120});
	
	function dosubmit(){
	 jQuery("#if_tag").val("1") ;
	  jQuery("#theform").attr("action","order_list_excel.jsp") ;
	  jQuery("#theform").attr("method","post") ;
	  jQuery("#theform").submit() ;
	}
		function  showTel(obj,phone){
	var uuid = jQuery(obj).attr("showid") ;  // 更改操作，更改该条订单的状态 
	if(jQuery.trim(uuid)!=''){
		jQuery.ajax({
			type:"post" ,
			url:"/admin/action/ajax_cud.jsp" ,
			data:{"flag":"changeOrderState","idStr":uuid} ,
			success:function(msg){
				
			}
		}) ;
	}
	jQuery(obj).parent().text(phone) ;
	}
	function inputPs(uuid){
	jQuery.ajax({
		type:'post',
		url:'/admin/action/ajax_r.jsp',
		async:false ,
		data:{flag:'inputDisposePs',uuid:uuid},
		success:function(msg){
			var html = "<div style='padding:10px;'>处理意见：<input type='text' maxlength='50' value='"+jQuery.trim(msg)+"' style='width:200px;height:30px;' id='dispose_ps' name='dispose_ps' /></div>";
		   jQuery.jBox(html,{title:'请输入处理意见',submit:function(v,h,f){
			_inputPs_app(f.dispose_ps,uuid) ;
		   }}) ;
		}
	}) ;
	}
	function _inputPs_app(msg,uuid){
	  if(typeof(msg)!='undefined'){
	  	jQuery.ajax({
	  		url:'/admin/action/ajax_r.jsp',
	  		type:'post',
	  		data:{flag:'inputDisposePs_app',msg:jQuery.trim(msg),uuid:uuid} ,
	  		async:true,
	  		success:function(msg){
	  			
	  		}
	  	}) ;
	  }
	}
</script>