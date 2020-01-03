﻿<%@ page language="java" import="java.util.*,java.sql.*,com.jerehnet.util.dbutil.*,com.jerehnet.util.common.*" pageEncoding="UTF-8"%>
<%
	String tableName = "pro_product_form";
	String tablePrefix = Env.getInstance().getProperty("table_prefix");
	String channelUUID = CommonString.getFormatPara(request.getParameter("channel_uuid"));
	String agent_id=CommonString.getFormatPara(request.getParameter("agent_id"));
		Map adminInfo = (Map)session.getAttribute("adminInfo");

	String fileds = "*";
	String whereStr = "and is_deleted=0";
	 if(CommonString.getFormatPara(adminInfo.get("id")).equals("41")){
		  whereStr += "and factoryid=16775";
		 }
	String orderByStr = " id desc ";
	Map stateMap = new HashMap() ;
	stateMap.put("0","否") ;
	stateMap.put("1","是") ;
	stateMap.put("-1","全部") ;
	List <Map> brandList = (ArrayList)application.getAttribute("brandList");
	Map channelMap = (Map)application.getAttribute("channelMap");
	Map catalogMap = (Map)application.getAttribute("catalogMap") ;
	List <Map> catalogAppList = (ArrayList<Map>)application.getAttribute("catalogList");
	List <Map> catalogList = CommonApplication.getTreeByPno("0", catalogAppList , "parentid","id");
	Connection connection = null;
	DBHelper dbHelper = DBHelper.getInstance();
	List<Map> agentList=new ArrayList<Map>();
	try {
	connection = dbHelper.getConnection();
	String wheres="";
	
	agentList=(ArrayList)(dbHelper.getMapList(" select * from pro_agent_factory where is_cooperate = 1 and flag=1",connection));
    if(CommonString.getFormatPara(adminInfo.get("id")).equals("41")){
		agentList=(ArrayList)(dbHelper.getMapList(" select * from pro_agent_factory where id=16775",connection));
    }
	String agentListInfo="";
	
	for(Map m : agentList){
	   agentListInfo+="{ text:'"+m.get("name")+"',id:"+m.get("id")+"},";
	}
	if(agentList.size()>0){
	agentListInfo=agentListInfo.substring(0,agentListInfo.length()-1);
	}
	
	Map callRsMap = (Map)CommonApplication.getEnumChildren("106",application);
	//Map callRsMap = (Map)CommonApplication.getEnumChildren("103",application);
	Map seriesMap = (Map)CommonApplication.getEnumChildren("108",application);
	Map conditionMap = (Map)CommonApplication.getEnumChildren("109",application);

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title><%=Env.getInstance().getProperty("project_name") %></title>
<link href="/plugin/ui/ligerUI/ligerUI/skins/Aqua/css/ligerui-all.css" rel="stylesheet" type="text/css" />
<link href="/plugin/ui/ligerUI/ligerUI/skins/Gray/css/all.css" rel="stylesheet" type="text/css" />
<link href="/plugin/ui/ligerUI/ligerUI/skins/ligerui-icons.css" rel="stylesheet" type="text/css" />
<link href="/backend/style/style.css" rel="stylesheet" type="text/css" />
<style type="text/css">
.l-grid-body-table tr td {
	height:30px;
}
</style>
<script src="/plugin/jquery/jquery.min.js" type="text/javascript"></script>
</head>
<body>
<div id="layout">
  <div position="left" title="代理商列表" id="mainmenu">
    <ul id="maintree">
    </ul>
  </div>
  <div position="center" title="订单列表" id="navtab1" >
    <form name="theform" id="theform" method="post">
      <div class="searchForm">
      <div class="searchCondition" style="width:98%">
        <div class="searchCondition" style="width:95%">
          <div class="searchLeft">外呼结果</div>
          <div class="searchRight" style="width: 150px;">
            <select style="width: 100%;" class="jr_select" name="call_rs" id="call_rs">
              <option value="">--全部结果--</option>
              <%=CommonForm.createSelect(callRsMap,"") %>
            </select>
          </div>
          <div class="searchLeft"><span id="buy_brand">回访记录</span></div>
          <div class="searchRight" >
            <input type="text" style="width: 150px;" name="special_remark" id="special_remark"  />
          </div>
          <div class="searchLeft">订单人</div>
          <div class="searchRight">
            <input type="text"  name="name" id="name" style="width: 150px;" />
          </div>
          <div style="clear:left;"></div>
          <div class="searchLeft">所在地区</div>
          <div class="searchRight">
            <input style="width: 150px;" type="text"  name="contact_address" id="contact_address"   />
          </div>
          <div class="searchLeft">是否成交</div>
          <div class="searchRight" style="width: 150px;">
            <input type="radio" id="is_deal_0" name="is_deal" value="" checked='checked'/>
            全部
            <input type="radio" id="is_deal_1" name="is_deal" value="1" />
            是
            <input type="radio" id="is_deal_2" name="is_deal" value="0" />
            否 </div>
          <div class="searchLeft">是否星标</div>
          <div class="searchRight" style="width: 150px;">
            <input type="radio" id="is_star_0" name="is_star" value="" checked='checked'/>
            全部
            <input type="radio" id="is_star_1" name="is_star" value="1" />
            是
            <input type="radio" id="is_star_2" name="is_star" value="0" />
            否 </div>
          <div style="clear:left;"></div>
          <div class="searchLeft">品牌分类</div>
          <div class="searchRight" style="width: 150px;">
            <%
	String brand_series = "";
    if(brand_series.equals("")){brand_series="";}						
%>
            <select style="width: 100%;" class="jr_select" name="brand_series" id="brand_series" onchange="document.getElementById('brand_series').value=options[selectedIndex].value">
              <option value="">--全部品牌--</option>
              <%=CommonForm.createSelect(seriesMap,brand_series) %>
            </select>
          </div>
          <div class="searchLeft">新旧程度</div>
          <div class="searchRight" style="width: 150px;">
    <%
	String pro_condition = "";	
    if(pro_condition.equals("")){pro_condition="";}												
    %>
            <select style="width: 100%;" class="jr_select" name="pro_condition" id="pro_condition" onchange="document.getElementById('pro_condition').value=options[selectedIndex].value">
              <option value="">--全部产品--</option>
              <%=CommonForm.createSelect(conditionMap,pro_condition) %>
            </select>
          </div>
          <div class="searchLeft">联系电话</div>
          <div class="searchRight" style="width: 150px;">
            <input  type="text" style="width: 100%;"  name="mobile_phone" id="mobile_phone"  />
          </div>
          <div style="clear:left;"></div>
          <div class="searchLeft" >订购时间</div>
          <div class="searchRight" >
            <input type="text" style="width: 50px;"  name="start_date" id="start_date" />
          </div>
          <div class="searchLeft" style="width:10px;">&nbsp;~</div>
          <div class="searchRight" >
            <input type="text" style="width: 50px;"  name="end_date" id="end_date" />
          </div>
          <input type="hidden"   name="factoryId"  id="factoryId" value="0"/>
          <div class="searchLeft" style="width:70px;">是否推送</div>
          <div class="searchRight"> <%=CommonForm.createRadio(stateMap,"-1","is_push") %> </div>
          <div style="clear:left;"></div>
  
          <div class="searchLeft" style="width:70px;">合作时间</div>
          <div class="searchRight" >
            <input type="text" style="width: 70px;"  name="cooperate_start_date" id="cooperate_start_date" />
          </div>
          <div class="searchLeft" style="width:10px;">&nbsp;~</div>
          <div class="searchRight" >
            <input type="text" style="width: 70px;"  name="cooperate_end_date" id="cooperate_end_date" />
          </div>
          <div class="searchLeft">合作时间内</div>
          <div class="searchRight" style="margin-top:3px;">
            <input type="radio" id="cooperate_0" name="cooperate" value="" checked='checked'/>
            全部
            <input type="radio" id="cooperate_1" name="cooperate" value="1" />
            是
            <input type="radio" id="cooperate_2" name="cooperate" value="0" />
            否 </div>
			
			
			<div class="searchLeft">推送成功</div>
          <div class="searchRight" style="margin-top:3px;">
            <input type="radio" id="is_success_0" name="is_success" value="" checked='checked'/>
            全部
            <input type="radio" id="is_success_1" name="is_success" value="1" />
            是
            <input type="radio" id="is_success_2" name="is_success" value="0" />
            否 </div>
			
			
			
	<div style="clear:left"></div>
      <div class="searchLeft"  style="width:70px;"><font color="red">选择分类</font></div>
      <div class="searchRight">
        <select class="jr_select" id="catalognum" name="catalognum">
          <option value="">--请选择产品类别--</option>
          <%if(catalogList != null){for(Map m : catalogList){%>
          <option value="<%=m.get("num")%>"><%=CommonForm.getSpace(m.get("num").toString(),1)%><%=m.get("name")%></option>
          <%}}%>
        </select>
      </div>
			
			
          <div class="searchLeft" style="width:70px; margin-left:10px;">
            <input type="button" class="btn" onclick="doSearch();" value="查询" />
          </div>
          <div class="searchRight">
            <input style="margin-left: 5px;" type="button" class="btn" onclick="doClearForm();" value="重置" />
          </div>
          <div class="searchLeft" style="width:10px;">&nbsp;</div>
          <div class="searchRight">
            <!--
		  			<input type="button" value="导出EXCEL" onclick="dosubmit(1);"/>
					
		  			<input type="button" value="一键导出EXCEL" title="导出前一天16点至第二天16点的订单" onclick="dosubmit(2);"/>
					-->
          </div>
        </div>
      </div>
      <input type="hidden" name="if_tag" id="if_tag" value="test"/>
      <input type="hidden" name="flag_400" id="flag_400" value=""/>
      <input type="hidden" name="cooperate_start_date" id="cooperate_start_date" value=""/>
      <input type="hidden" name="cooperate_end_date" id="cooperate_end_date" value=""/>
    </form>
    <div style="clear: left;"></div>
    <div class="l-loading" style="display: block" id="pageloading"></div>
    <div id="maingrid" style="margin: 0; padding: 0"></div>
  </div>
  <div style="display: none;"> </div>
</div>
</body>
</html>
<script src="/plugin/ui/ligerUI/ligerUI/js/ligerui.min.js" type="text/javascript"></script>
<script src="/backend/scripts/common.js" prefix="<%=tablePrefix %>" type="text/javascript"></script>
<script type="text/javascript">
    var layout = $("#layout").ligerLayout({ leftWidth: 200,topHeight:40,bottomHeight :40});  
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
		params.push({'name':'fields','value':fields});
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
                    //2014-10-11 临时删除
					toolbar : {
						items : [{
									text : '导出',
									click : function(){
										dosubmit(1);
									},
								icon : 'add'
								}, {
									text : '删除',
									click : function(){
										toolbarDel({
											channel_uuid:'<%=channelUUID %>'
										});
									},
									icon : 'delete'
								}]
					}
				});
		jQuery("#pageloading").hide();
	});
	//列数组
	columnsArr =  [ 
	{ display : 'ID', name : 'id', align : 'center' , type : 'string' , width : 50 ,render:function(row){
	    return "<a class='link' href='javascript:void(0);' >"+row.id+"</a>";
	  }
	} ,
	{ display : '省份', name : 'province', align : 'left' , type : 'string' , width : 55 } ,
	{ display : '地区', name : 'city', align : 'left' , type : 'string' , width : 70 } ,
	{ display : '订单人', name : 'name', align : 'left' , type : 'string' , width : 50 } ,
	{ display : '手机号码', name : 'mobile_phone', align : 'left' , type : 'string' , width : 90 } ,
	{ display : '所属厂家', name : 'factoryname', align : 'left' , type : 'string' , width : 80 ,render:function(row){
	   	return "<a href='javascript:void(0);' target='_blank'>"+(row.factoryname==null?"":row.factoryname)+"</a>" ;
	 }
	} ,
	{ display : '订购产品', name : 'product_name', align : 'left' , type : 'string' , width : 100 ,render:function(row){
	   return "<a href='/inquiry/detail_for_"+row.id+".htm' target='_blank'>"+(row.product_name==null?"":row.product_name)+"</a>" ;
	  }
	} ,
	{ display : '所属分类', name : 'cataname', align : 'left' , type : 'string' , width : 100 } ,
	{ display : '预计购买时间', name : 'buy_time', align : 'center' , type : 'string' , width : 80,render:function(row){
				return  getBuyTime(row.buy_time) ;
	} } ,
	{ display : '订购时间', name : 'add_date', align : 'center' , type : 'string' , width : 130 ,render:function(row){
	      return (row.add_date.length>=19)?row.add_date.substr(0,19):row.add_date ;
	  }
	} ,
	{ display : '第二次外呼', name : 'call_rs_task2', align : 'center' , type : 'string' , width : 80 , render : function(row){
				if(null==row.call_rs_task2||'null'==row.call_rs_task2||''==row.call_rs_task2){
						return '<span style="color:red;"><a class="link" href="javascript:void(0);" onclick="addTask2(\''+row.uuid+'\');">未外呼</a></span>';
				}
				var colorArr = {'103001':'#F00','103003':'#CCC','103005':'#00F','103006':'#0F0','103007':'#0FF'};
				return "<span style='color:"+colorArr[row.call_rs_task2]+"'><a class='link' href='javascript:void(0);' onclick='addTask2(\""+row.uuid+"\");'>"+getEnum(row.call_rs_task2)+"</a></span>";
			}
	} ,

		
	{ display : '成交品牌', name : 'deal_factoryname', align : 'center' , type : 'string' , width : 60 , render : function(row){
	
	   if(null==row.deal_factoryname||'null'==row.deal_factoryname||''==row.deal_factoryname||'请选择品牌--'==row.deal_factoryname||'选择-'==row.deal_factoryname||('106003'==row.call_rs_task2)||('106006'==row.call_rs_task2)||('106005'==row.call_rs_task2)||('106004'==row.call_rs_task2)||('106001'==row.call_rs_task2)){
		       return  '无';
			}
				return row.deal_factoryname;
			}} , 	
	
	
	{ display : '是否成交', name : 'is_deal', align : 'center' , type : 'is' , width : 60 } , 
    { display : '品牌分类', name : 'brand_series', align : 'center' , type : 'string' , width : 80, render : function(row){
	       if(null==row.brand_series||'null'==row.brand_series||''==row.brand_series||('108004'==row.brand_series&&'106003'==row.call_rs_task2)||('108004'==row.brand_series&&'106006'==row.call_rs_task2)||('108004'==row.brand_series&&'106004'==row.call_rs_task2)||('108004'==row.brand_series&&'106005'==row.call_rs_task2)||('108004'==row.brand_series&&'106001'==row.call_rs_task2)){
		       return  '无';
			}return ""+getEnum(row.brand_series)+"";
			} } , 	
    { display : '新旧程度', name : 'pro_condition', align : 'center' , type : 'string' , width : 80, render : function(row){
	   if(null==row.pro_condition||'null'==row.pro_condition||''==row.pro_condition||('109003'==row.pro_condition&&'106003'==row.call_rs_task2)||('109003'==row.pro_condition&&'106006'==row.call_rs_task2)||('109003'==row.pro_condition&&'106004'==row.call_rs_task2)||('109003'==row.pro_condition&&'106005'==row.call_rs_task2)||('109003'==row.pro_condition&&'106001'==row.call_rs_task2)){
		       return  '无';
			}
				return ""+getEnum(row.pro_condition)+"";
	} } ,	
	
	{ display : '成交型号', name : 'deal_proid', align : 'center' , type : 'string' , width : 80, render : function(row){
	  
	   if(null==row.deal_proid||'null'==row.deal_proid||''==row.deal_proid||('106003'==row.call_rs_task2)||('106006'==row.call_rs_task2)||('106005'==row.call_rs_task2)||('106004'==row.call_rs_task2)||('106001'==row.call_rs_task2)){
		       return  '无';
			}
				return ""+getProduct(row.deal_proid)+"";
                        }} ,
   { display : '用户跟踪结果', name : 'follow_content', align : 'center' , type : 'string' , width : 80} ,
   { display : '回访记录', name : 'special_remark', align : 'center' , type : 'string' , width : 80} ,	
	{ display : '备注信息', name : 'call_result1', align : 'left' , type : 'string' , width : 100 } 

	];
	
	//查看推送的订单信息
	function orderListView(index){      
		  jrWindow("/backend/pro_product_form/pro_product_form_cooperate_list.jsp?agent_id="+index,"订单信息",1150,500) ;
	}
	
	
	//增加和编辑的方法
	function addAndEdit(index){
    	if(undefined==index){//如果是增加
    	    toolbarAdd({
	    		width:800,
	    		height:520,
	    		title:'增加',
	    		fileName:"/backend/pro_product_form/pro_product_form_cooperate_list" ,
	    		params : {
	    			channel_uuid : ""
	    		}
	    	});
    	}else{//如果是修改
    		var row = grid.getRow(index);
    	    toolbarAdd({
	    		width:800,
	    		height:520,
	    		title:'修改',
	    	    fileName:"/backend/pro_product_form/pro_product_form_cooperate_list" 
	    	},row.uuid);
    	}
    }
	jQuery(".searchForm input[type=text]").keypress(function(e){
		if(e.keyCode==13){
			doSearch();
		}
	});
	/*列表页条件查询*/
	function doSearch(factoryId){
	    if( factoryId!=undefined){
	       jQuery("#factoryId").val(factoryId);
        }
		params = [];
		conditionStr = "";
		conditionStr += " and factoryid = "+jQuery("#factoryId").val()+" ";
		var is_push  = jQuery("input[name='is_push']:checked").val();
		//alert(is_push);
		if('1'== jQuery.trim(is_push)){
			conditionStr += " and push_order  = '1' ";
		}else if('0'== jQuery.trim(is_push)){
			conditionStr += " and (push_order  is null  or  push_order=''  or  push_order='0' )  ";
		}
		
		
		//外呼结果
		
		var call_rs = jQuery("#call_rs").val();
		if(''!=jQuery.trim(call_rs)){
		    //2014.11.05
		    if(call_rs=='106001'){
		       //call_rs='103001';
		       conditionStr += " and call_rs_task2  in ('106001','103001')";
		    }else if(call_rs=='106006'){
		       //call_rs='103007';
		       conditionStr += " and call_rs_task2  in ('106006','103007')";
		    }else if(call_rs=='106005'){
		       //call_rs='103003';
		       conditionStr += " and call_rs_task2  in ('106005','103003')";
		    }else{
		       conditionStr += " and call_rs_task2 ='"+call_rs+"'";
		    }
			//conditionStr += " and call_rs_task2 ='"+call_rs+"'";
		}
		//回访记录
		var special_remark = jQuery("#special_remark").val();
		if(''!=jQuery.trim(special_remark)){
			conditionStr += " and special_remark like '%"+special_remark+"%'";
		}
		//订单人
		var name = jQuery("#name").val();
		if(''!=jQuery.trim(name)){
			conditionStr += " and user_name like '%"+name+"%'";
		}
		//所在地区
		var contact_address = jQuery("#contact_address").val();
		if(''!=jQuery.trim(contact_address)){
			conditionStr += " and contact_address like '%"+contact_address+"%'";
		}
		
		//是否成交
		var is_deal = jQuery.trim(jQuery("input[name='is_deal']:checked").val());
		if(''!=jQuery.trim(is_deal)){
			conditionStr += " and is_deal ='"+is_deal+"'";
		}
		//品牌分类
		
		var brand_series = jQuery("#brand_series").val();
		if(''!=jQuery.trim(brand_series)){
			conditionStr += " and brand_series ='"+brand_series+"'";
		}
		
		//新旧程度
		
		var pro_condition = jQuery("#pro_condition").val();
		if(''!=jQuery.trim(pro_condition)){
			conditionStr += " and pro_condition ='"+pro_condition+"'";
		}
		//是否星标
		var is_star = jQuery.trim(jQuery("input[name='is_star']:checked").val());
		if(''!=jQuery.trim(is_star)){
			conditionStr += " and is_star ='"+is_star+"'";
		}
		
		var is_success = jQuery.trim(jQuery("input[name='is_success']:checked").val());
	      if('1'== jQuery.trim(is_success)){
			conditionStr += " and is_success  = '1' ";
		}else if('0'== jQuery.trim(is_success)){
			conditionStr += " and (is_success  is null  or  is_success=''  or  is_success='0' )  ";
		}
		

		
		
		//联系电话
		var mobile_phone = jQuery("#mobile_phone").val();
		if(''!=jQuery.trim(mobile_phone)){
			conditionStr += " and mobile_phone like '%"+mobile_phone+"%'";
		}
		
		
		
		
		
		
		var start_date = jQuery("#start_date").val();
		if(''!=jQuery.trim(start_date)){
			conditionStr += " and add_date >='"+start_date+" 00:00:00'";
		}
		var end_date = jQuery("#end_date").val() ;
		if(''!=jQuery.trim(end_date))
		{
		   conditionStr += " and add_date <='"+end_date+" 23:59:59'";
		}
		
		var catalognum = jQuery("#catalognum").val() ;
		if(''!=jQuery.trim(catalognum))
		{
		   conditionStr += " and catanum like '"+catalognum+"%'";
		}
		
		var cooperate = jQuery.trim(jQuery("input[name='cooperate']:checked").val()) ;
		if(''!=cooperate){
			var cooperate_start_date = jQuery("#cooperate_start_date").val();
		    var cooperate_end_date = jQuery("#cooperate_end_date").val();

		   if('1'==cooperate){
			conditionStr += " and add_date >='"+cooperate_start_date+" 00:00:00'";
		    conditionStr += " and add_date <='"+cooperate_end_date+" 23:59:59'";

		   }else if('0'==cooperate){
		   	  	 conditionStr += " and( add_date <='"+cooperate_start_date+" 00:00:00'  or add_date >='"+cooperate_end_date+" 23:59:59')";
			}
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
		//jQuery("#catanum option:eq(0)").attr("selected",true) ;
        //jQuery("#factoryid option:eq(0)").attr("selected",true) ;
	}
		function openWin(id){
		jrWindow("/backend/pro_agent_factory/pro_agent_products_edit.jsp?id="+id,"导入产品",900,600);	
	}
	//时间
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
	//左侧树
		var nodeId = ""; 
   	    var currentNode={};
	    var tree = $("#maintree").ligerTree({
    	nodeWidth :230,
        data: [<%= agentListInfo%>],
        checkbox: false,
        onSelect: function (node)
        {   
		   doSearch(node.data.id);
		   
		   jQuery.ajax({
    	      type:'post',
              url:'/action/ajax.jsp',
    	      data:{flag:'cooperate_start_date',id:node.data.id} ,
    	      success:function(msg){
			    jQuery("#cooperate_start_date").val(msg);
				
    	      }
		     });
		   
		   jQuery.ajax({
    	      type:'post',
              url:'/action/ajax.jsp',
    	      data:{flag:'cooperate_end_date',id:node.data.id} ,
    	      success:function(msg){
			    jQuery("#cooperate_end_date").val(msg);
				
    	      } 
         });
		   
        },
        onContextmenu: function (node, e)
        {    
            nodeId = node.data.realId; 
            currentNode=node.data;
            rootTreeAdd.show({ top: e.pageY, leftt: e.pageX });
            return false;
        }
    }); 
	
	jQuery("#start_date").ligerDateEditor({width:130}); 
	jQuery("#end_date").ligerDateEditor({width:130});
	
	 //导出
	  function dosubmit(obj){
	  jQuery("#if_tag").val(2) ;
	  jQuery("#theform").attr("action","/backend/pro_agent_factory/order_list_excel_s.jsp?factoryId="+jQuery("#factoryId").val()) ;
	  jQuery("#theform").attr("method","post") ;
	  jQuery("#theform").submit() ;
	}
	
	//查看订单结果
	function showResult(index){
	    var row = grid.getRow(index);
		var url = "/backend/pro_agent_factory/call_back_show.jsp?uuid="+row.uuid;
		//var url = "/backend/pro_400/send.jsp?productid="+row.id+"&city="+row.city+"&province="+row.province+"&order_id="+row.id+"&factoryid="+row.factoryid+"&param="+encodeURIComponent(row.contact_address+row.name+row.mobile_phone+"询"+row.factoryname+row.product_name+row.cataname);
		jrWindow(url, "订单结果", 500, 200);
	}
	
	//第二次外呼
		function addTask2(uuid){
		jrWindow("/backend/pro_400_task2/pro_400_task2_edit.jsp?form_uuid="+uuid+"&f=list","添加任务",650,420);
	}
	
	function getProduct(key) {
var product_name = null;
	var value = null;
	if (null == product_name) {// 如果枚举时空，则从服务器取回，否则，直接拿本地的
		jQuery.ajax({
					url : '/backend/action/ajax_r.jsp',
					data : {
						'flag' : 'get_Pro',
						'productid' : key
					},
					async : false,
					cache : true,
					type : 'post',
					success : function(data) {
						product_name = data;
						
					}
				});
	}
	
	value = product_name;
	return value;
}
	
</script>
<%
    } catch (Exception e) {
		e.printStackTrace();
	} finally {
		dbHelper.freeConnection(connection);
	}
%>