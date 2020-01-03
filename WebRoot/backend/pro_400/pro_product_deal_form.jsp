<%@ page language="java" import="java.util.*,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*" pageEncoding="UTF-8"%>
<%
	String tableName = "pro_product_deal_form";
	String tablePrefix = Env.getInstance().getProperty("table_prefix");
	String fileds = "*";
	String channelUUID = CommonString.getFormatPara(request.getParameter("channel_uuid"));
	Map channelMap = (Map)application.getAttribute("channelMap");
	Map catalogMap = (Map)application.getAttribute("catalogMap") ;
	List<Map> brandList = (ArrayList)application.getAttribute("brandList") ;

	DBHelper dbHelper = DBHelper.getInstance() ;
	String whereStr = " and  1=1 ";
	Map adminInfo = (Map)session.getAttribute("adminInfo");
	String orderByStr = " id desc,add_date desc   ";
	Map stateMap = new HashMap() ;
	stateMap.put("0","否") ;
	stateMap.put("1","是") ;
	stateMap.put("-1","全部") ;
	Map call_rsMap = CommonApplication.getEnumChildren("103",application);
	Map call_rsMap2 = CommonApplication.getEnumChildren("106",application);
	String usern = CommonString.getFormatPara(adminInfo.get("usern") ) ;
	List <Map> catalogAppList = (ArrayList<Map>)application.getAttribute("catalogList");
	List <Map> catalogList = CommonApplication.getTreeByPno("0", catalogAppList , "parentid","id");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title><%=Env.getInstance().getProperty("project_name") %>1</title>
<link href="/plugin/ui/ligerUI/ligerUI/skins/Aqua/css/ligerui-all.css" rel="stylesheet" type="text/css" />
<link href="/plugin/ui/ligerUI/ligerUI/skins/Gray/css/all.css" rel="stylesheet" type="text/css" />
<link href="/plugin/ui/ligerUI/ligerUI/skins/ligerui-icons.css" rel="stylesheet" type="text/css" />
<link href="/backend/style/style.css" rel="stylesheet" type="text/css" />
<style type="text/css">
.l-grid-body-table tr td {
	height:25px;
}
</style>
<script src="/plugin/jquery/jquery.min.js" type="text/javascript"></script>
</head>
<body>
<form name="theform" id="theform" method="post">
  <div class="searchForm">
    <div class="searchCondition">
      <div class="searchLeft"  style="width:70px;">品<span class="span2"></span>牌</div>
      <div class="searchRight">
        <select name="factoryid" id="factoryid" class="jr_select" style="width: 152px;">
          <option value="">-请选择-</option>
          <%if(brandList != null){for(Map m : brandList){%>
          <option value="<%=m.get("name")%>"><%=m.get("upper_index")%>：<%=m.get("name")%></option>
          <%}}%>
        </select>
      </div>
      <div class="searchLeft"  style="width:70px;"><font color="red">选择分类</font></div>
      <div class="searchRight">
        <select class="jr_select" id="catalognum" name="catalognum">
          <option value="">--请选择产品类别--</option>
          <%if(catalogList != null){for(Map m : catalogList){%>
          <option value="<%=m.get("name")%>"><%=CommonForm.getSpace(m.get("num").toString(),1)%><%=m.get("name")%></option>
          <%}}%>
        </select>
      </div>
      <div style="clear:left"></div>
      <div class="searchLeft"  style="width:70px;">品牌分类</div>
      <div class="searchRight" >
        <select name="brand_series" id="brand_series" class="jr_select" style="width: 100px;"   >
          <option value="">--请选择--</option>
          <option value="国产系">国产系</option>
          <option value="日韩系">日韩系</option>
          <option value="欧美系">欧美系</option>
          <option value="不确定">不确定</option>
        </select>
      </div>
      <div class="searchLeft" style="width:70px;">新旧程度</div>
      <div class="searchRight" style="margin-left: 4px; width: 100px;">
        <select name="pro_condition" id="pro_condition" class="jr_select" style="width: 100px;">
          <option value="">--请选择--</option>
          <option value="新机">新机</option>
          <option value="二手">二手</option>
          <option value="不确定">不确定</option>
        </select>
      </div>
      <div class="searchLeft"  style="width:70px;">所在地区</div>
      <div class="searchRight">
        <input type="text" style="width: 100px;" class="jr_text" name="area" id="area" />
      </div>
    </div>
  </div>
  <div class="searchBtn">
    <input type="button" class="btn" onclick="doSearch();" value="查询" />
    <input style="margin-left: 5px;" type="button" class="btn" onclick="doClearForm();" value="重置" />
  </div>
  </div>
  <input type="hidden" name="if_tag" id="if_tag" value="test"/>
  <input type="hidden" name="flag_400" id="flag_400" value=""/>
</form>
<div style="clear: left;"></div>
<div class="l-loading" style="display: block" id="pageloading"></div>
<div id="maingrid" style="margin: 0; padding: 0"></div>
<div style="display: none;">
  <input type="hidden" name="channel_uuid" id="channel_uuid" value="<%=channelUUID %>" />
  <input type="hidden" name="if_tag" id="if_tag" value="test"/>
</div>
</body>
</html>
<script src="/plugin/ui/ligerUI/ligerUI/js/ligerui.min.js" type="text/javascript"></script>
<script src="/backend/scripts/common.js" prefix="<%=tablePrefix %>" type="text/javascript"></script>
<script type="text/javascript">

</script>
<script type="text/javascript">
	var isData = [{ is_deal: 1, text: '是' }, { is_deal: 0, text: '否'}];
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
		url = "/backend/action/liger.jsp";
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
					checkbox : true,
					selectRowButtonOnly : true,
					parms : params,
					rownumbers : true,
					toolbar : {
												items : [  {
									text : '删除',
									click : function(){
										toolbarDel({
											channel_uuid:'<%=channelUUID %>'
										});
									},
									icon : 'delete'
								}]
					},
					enabledEdit: true,
					onAfterEdit:function(e){
					  if(e.column.columnname=='is_deal'){ 
					  		jQuery.ajax({
					  			url:'/backend/action/ajax_cud.jsp',
					  			data:{
					  				flag:'isDeal',
					  				uid:e.record.uuid,
					  				value:e.value
					  			},
					  			type:'post'
					  		}) ;
					  } 
					  if(e.column.columnname=='deal_desc'){
					  var _value = jQuery.trim(e.value) ;
					  if(''!=_value){
					  		jQuery.ajax({
					  			url:'/backend/action/ajax_cud.jsp',
					  			data:{
					  				flag:'isDeal_desc',
					  				uid:e.record.uuid,
					  				value:_value
					  			},
					  			type:'post'
					  		}) ;					  	
					  }
					}
					}
				});
		jQuery("#pageloading").hide();
	});
	//列数组
	columnsArr =  [ 
		{ display : 'ID', name : 'id', align : 'center' , type : 'string' , width : 50 , render : function(row){
	    return "<a class='link' href='javascript:void(0);' onclick='addAndEdit("+row.__index+");'>"+row.id+"</a>";			}
		} ,
		{ display : '省份', name : 'province', align : 'center' , type : 'string' , width : 60 } ,
	 	{ display : '地区', name : 'city', align : 'center' , type : 'string' , width : 75 } ,
		{ display : '联系人', name : 'name', align : 'center' , type : 'string' , width : 65 } ,
		{ display : '电话', name : 'contact_tel', align : 'center' , type : 'string' , width : 115 } ,
	    { display : '品牌', name : 'factoryname', align : 'center' , type : 'string' , width : 80  } ,
		{ display : '询价产品', align : 'center' , type : 'string' , width : 90 , render : function(row){
				return row.product_name;
			}
		} ,
		{ display : '类别', name : 'cataname', align : 'center' , type : 'string' , width : 100 } ,
		{ display : '品牌分类', name : 'brand_series', align : 'center' , type : 'string' , width : 80 } ,
		{ display : '新旧程度', name : 'pro_condition', align : 'left' , type : 'string' , width : 80 } ,

		{ display : '备注', name : 'remark', align : 'left' , type : 'string' , width : 250 } ,

	];
	function dosubmit(obj){
	
	  jrConfirm("是否已选好导出条件？否则数据量会很大",function(v){
	   if(v){
		  jQuery("#if_tag").val(obj) ;
		  jQuery("#theform").attr("action","/backend/pro_product_form/order_list_excel_new.jsp") ;
		  jQuery("#theform").attr("method","post") ;
		  jQuery("#theform").submit() ;
		 } 
		   });
		  
	}
	
	function dosubmitOld(obj){
		  jQuery("#if_tag").val(obj) ;
		  jQuery("#theform").attr("action","/backend/pro_product_form/order_list_excel.jsp") ;
		  jQuery("#theform").attr("method","post") ;
		  jQuery("#theform").submit() ;
	}
	function addTask1(uuid){

		jrWindow("/backend/pro_400_task1/pro_400_task1_edit.jsp?form_uuid="+uuid+"&f=list","添加任务",650,420);
	}
	function addTask2(uuid){
		jrWindow("/backend/pro_400_task2/pro_400_task2_edit.jsp?form_uuid="+uuid+"&f=list","添加任务",650,520);
	}
	function openWin(id){
		var addUrl = '/backend/pro_400/pro_product_form_edit.jsp?id='+id;
		var iWidth = 830;
		var iHeight = 600;
		var iTop = (window.screen.height - 30 - iHeight) / 2;
		var iLeft = (window.screen.width - 10 - iWidth) / 2;
		window
				.open(
						addUrl,
						parseInt(1000 * Math.random()),
						"height="
								+ iHeight
								+ ",width="
								+ iWidth
								+ ",top="
								+ iTop
								+ ",left="
								+ iLeft
								+ ",toolbar=no,menubar=no,scrollbars=no, resizable=no,location=no, status=no");
	}
	//购买时间
	    var buy_time = '' ;
        jQuery(function(){
        	jQuery.ajax({
        	type:"post" ,
        	dateType:'json',
        	url:"/action/ajax.jsp" ,
        	data:{"flag":"order_buy_time"} ,
        	success:function(data){
        	data = jQuery.trim(data) ;
        	data = jQuery.parseJSON(data);
        	buy_time = data ;
        }
        	}) ;
        }) ;
		
		//删除新
		function toolbarOrderDelNew(arg) {
			if (arg == undefined || arg == null) {
			   arg = {};
		    }
		    var checkedRows = grid.getCheckedRows();
		    if (checkedRows.length <= 0) {
			   return;
		    }
		    var idList=""; var uidList="";
		 	for (var i = 0; i < checkedRows.length; i++) {
				idList += "" + checkedRows[i].id + ",";
				uidList += "" + checkedRows[i].uuid + ",";
		    }
			if (idList.indexOf(",") != -1) {
				idList = idList.substring(0, idList.length - 1);
			}
			if (uidList.indexOf(",") != -1) {
				uidList = uidList.substring(0, uidList.length - 1);
			}
		    var url = "/backend/pro_400/delete_order.jsp?uuid="+uidList+"&id="+idList;
		    jrWindow(url, "删除订单", 600, 150);
		}
		
		
		
		//删除
		function toolbarOrderDel(arg) {
		if (arg == undefined || arg == null) {
			arg = {};
		}
		var checkedRows = grid.getCheckedRows();
		if (checkedRows.length <= 0) {
			return;
		}
		// 遍历所有的选中行，如果是没有UUID，则移除
		jQuery.each(checkedRows, function(index, data) {
			if (this.uuid == undefined) {
				jrDeleteRow(this.__index);
			}
		});
		jrConfirm("确定删除选中项吗？", function(v) {
			if (v) {
				var checkedRows = grid.getCheckedRows();
				var idStr = "";
				for (var i = 0; i < checkedRows.length; i++) {
					idStr += "'" + checkedRows[i].uuid + "',";
				}
				if (idStr.indexOf(",") != -1) {
					idStr = idStr.substring(0, idStr.length - 1);
				}
				arg.del_id = idStr;
				if(undefined==arg.tableName){
					arg.tableName = tableName;
				}
				executeOrderDel(arg);
			}
		});
	}
     	function executeOrderDel(arg){
		arg.flag = "updateProductOrderDelete";
		jQuery.ajax({
			url : '/backend/action/ajax_r.jsp',
			data : arg,
			type : 'post',
			async : false,
			cache : false,
			success : function(data) {
				grid.loadData();
			}
		});
	}	
		
	 function getBuyTime(buytime_flag){
        var showtime = "" ;
     	jQuery(buy_time).each(function(i,n){
     	if(jQuery.trim(buytime_flag)==jQuery.trim(n.no)){
     	    showtime = n.name 
          	return false ;
          }else if(jQuery.trim(buytime_flag)=='jinqi'){
           showtime='近期' ;
         	}else{
           showtime='-' ;
         	}
     	}) ;
     	return showtime ;
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
	    var factoryid = jQuery("#factoryid").val() ;
		if(''!=jQuery.trim(factoryid))
		{
		  conditionStr += " and factoryname  like '%"+factoryid+"%'";
		}
	    var catalognum = jQuery("#catalognum").val() ;
		if(''!=jQuery.trim(catalognum))
		{
		  conditionStr += " and cataname like '%"+catalognum+"%'";
		}
		var brand_series = jQuery("#brand_series").val() ;
		if(''!=jQuery.trim(brand_series))
		{
		  conditionStr += " and brand_series = '"+brand_series+"'";
		}
		var pro_condition = jQuery("#pro_condition").val() ;
		if(''!=jQuery.trim(pro_condition))
		{
		  conditionStr += " and pro_condition = '"+pro_condition+"'";
		}
		var area = jQuery("#area").val() ;
		if(''!=jQuery.trim(area))
		{
		  conditionStr += "  and  ( province like '%"+area+"%' or city like '%"+area+"%') ";
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
       jQuery("#catanum option:eq(0)").attr("selected",true) ;
       jQuery("#factoryid option:eq(0)").attr("selected",true) ;
	}


</script>