<%@ page language="java" import="java.util.*,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*" pageEncoding="UTF-8"%><%
	String tableName = "pro_product_form";
	String tablePrefix = Env.getInstance().getProperty("table_prefix");
	String fileds = "*";
	String channelUUID = CommonString.getFormatPara(request.getParameter("channel_uuid"));
	Map channelMap = (Map)application.getAttribute("channelMap");
	Map catalogMap = (Map)application.getAttribute("catalogMap") ;
	 List<Map> brandList = (ArrayList)application.getAttribute("brandList") ;
	DBHelper dbHelper = DBHelper.getInstance() ;
	String whereStr = " and  task1_over = 1 and task2_over = 1 ";
	//如果是未购设备的
	if("291382B1-9F9D-4D60-B645-1D362FFED85B".equals(channelUUID)){
		whereStr = " and task1_over = 1 and task2_over =3 ";
	}else if("9AD9013E-67E1-4FB8-BA60-CBB1D0FF4AE4".equals(channelUUID)){
		whereStr = " and task1_over = 1 and task2_over = 2 ";
	}
	Map adminInfo = (Map)session.getAttribute("adminInfo");
	if("zoomlion_tufang".equals(adminInfo.get("usern"))){
		whereStr += " and factoryid = 1780 ";
	}
	String orderByStr = " add_date desc , id desc ";
	Map stateMap = new HashMap() ;
	stateMap.put("0","否") ;
	stateMap.put("1","是") ;
	stateMap.put("-1","全部") ;
	Map call_rsMap = CommonApplication.getEnumChildren("103",application);
	String usern = CommonString.getFormatPara(adminInfo.get("usern") ) ;
	//广州区域挖掘机订单、重庆区域挖掘机订单、四川区域乐眉、资阳、宜宾、泸州、自贡挖掘机订单、浙江区域挖掘机订单、
	//全国旋挖钻订单、
	//全国破碎锤订单、北京、天津区域除挖掘机以外的订单。
      
	if("mujie".equals(usern)){
			whereStr+=" and ( (catanum like '%101001%' and( contact_address like '%广州%' or contact_address like '%重庆%' or contact_address like '%乐眉%' or contact_address like '%资阳%' or contact_address like '%宜宾%' or contact_address like '%泸州%' or contact_address like '%自贡%' or contact_address like '%自贡%'))" ;
			whereStr += " or catanum like '%105003%' " ;
			whereStr += " or catanum like '%113001%'"  ;
			whereStr += " or (( contact_address like '%北京%' or contact_address like '%天津%') and catanum not like '%101001%'))" ;
	}
	//张嘉迅：山东区域挖掘机订单、湖南区域挖掘机订单、江西区域挖掘机订单
	if("zhangjx".equals(usern)){
			whereStr += " and catanum like '%101001%' and (contact_address like '%山东%' or contact_address like '%湖南%' or contact_address like '%江西%' )" ;
	}
%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <title><%=Env.getInstance().getProperty("project_name") %>1</title>
	<link href="/plugin/ui/ligerUI/ligerUI/skins/Aqua/css/ligerui-all.css" rel="stylesheet" type="text/css" />
	<link href="/plugin/ui/ligerUI/ligerUI/skins/Gray/css/all.css" rel="stylesheet" type="text/css" />
	<link href="/plugin/ui/ligerUI/ligerUI/skins/ligerui-icons.css" rel="stylesheet" type="text/css" />
	<link href="/backend/style/style.css" rel="stylesheet" type="text/css" />
    <style type="text/css">
	.l-grid-body-table tr td{
	 height:25px;
	}
	</style>
	<script src="/plugin/jquery/jquery.min.js" type="text/javascript"></script>
  </head>
  <body>
  <form name="theform" id="theform" method="post">
  	<div class="searchForm">
  		<div class="searchCondition">
  		  	<div class="searchLeft">订<span class="span3"></span>单<span class="span3"></span>人</div>
		  		<div class="searchRight">
		  			<input type="text" style="width: 100px;" class="jr_text" name="name" id="name" />
		  		</div>
		  		<div class="searchLeft">订购时间</div>
		  		<div class="searchRight">
		  			<input type="text" style="width: 100px;"  name="start_date" id="start_date" />
		  		</div>
		  			<div class="searchLeft" style="width:10px;">&nbsp;~</div>
		  		<div class="searchRight">
		  			<input type="text" style="width: 100px;"  name="end_date" id="end_date" />
		  		</div>
		  		<div class="searchLeft" style="margin-left: 3px;">所属厂家</div>
		  		<div class="searchRight">
		  			<input type="text" style="width: 150px;" class="jr_text" name="factoryname" id="factoryname" />
		  		</div>
		  			<div style="clear:left"></div>
		  		<div class="searchLeft">所属分类</div>
		  		<div class="searchRight">
		  			<input type="text" style="width: 100px;" class="jr_text" name="catalogname" id="catalogname" />
		  		</div>
		  		<div class="searchLeft">订单编号</div>
		  		<div class="searchRight">
			  		<input type="text" name="start_form_id" id="start_form_id" style="width:150px;" class="jr_text" />~
			  		<input type="text" name="end_form_id" id="end_form_id" style="width:150px;" class="jr_text" />
		  		</div>
		  		 <div class="searchLeft">品<span class="span2"></span>牌</div>
		  		<div class="searchRight">
		  		<select name="factoryid" id="factoryid" class="jr_select" style="width: 152px;">
		  		 <option value="">-请选择-</option>
		  		<%if(brandList != null){for(Map m : brandList){%>
                        	<option value="<%=m.get("id")%>"><%=m.get("upper_index")%>：<%=m.get("name")%></option>
                        <%}}%>
		  		 </select>
		  		</div>
		  		<div style="clear:left;"></div>
		  		<div class="searchLeft">所在地区</div>
		  		<div class="searchRight">
		  			<input type="text" style="width: 100px;" class="jr_text" name="contact_address" id="contact_address" />
		  		</div>
		  		<div class="searchRight" style="margin-left: 12px; width: 100px;">
			  		<select name="orderbywhat" id="orderbywhat" class="jr_select" style="width: 100px;">
				  		 <option value="add_date">-时间排序-</option>
				  		 <option value="factoryname">-厂家排序-</option>
				  		 <option value="contact_address">-省份排序-</option>
				  		 <option value="catanum">-机种排序-</option>
			  		 </select>
		  		</div>
		  		<div class="searchRight" style="margin-left: 10px; width: 100px;">
			  		<select name="is_high_quality" id="is_high_quality" class="jr_select" style="width: 100px;">
			  			<option value="">--是否高质--</option>
			  			<%
			  				Map isMap = new HashMap();
			  				isMap.put("0","否");
			  				isMap.put("1","是");
			  			%>
			  			<%=CommonForm.createSelect(isMap,"") %>
			  		 </select>
		  		</div>
		  		<div class="searchLeft" style="width:10px;">&nbsp;</div>
		  		<div class="searchRight">
		  			<input type="button" value="导出EXCEL" onclick="dosubmit(1);"/>
		  			<input type="button" value="一键导出EXCEL" title="导出前一天16点至第二天16点的订单" onclick="dosubmit(2);"/>
		  		</div>
  		</div>
  		<div class="searchBtn">
  			<input type="button" class="btn" onclick="doSearch();" value="查询" />
  			<input style="margin-left: 5px;" type="button" class="btn" onclick="doClearForm();" value="重置" />
  		</div>
  	</div>
  	<input type="hidden" name="if_tag" id="if_tag" value="test"/>
  	<input type="hidden" name="flag_400" id="flag_400" value="flag_400"/>
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
<script src="/plugin/other/highslide/highslide.min.js" type="text/javascript"></script>
<script src="/backend/scripts/common.js" prefix="<%=tablePrefix %>" type="text/javascript"></script>
<script type="text/javascript">
	hs.graphicsDir = '/plugin/other/highslide/graphics/';
	hs.wrapperClassName = 'wide-border';
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
					checkbox : false,
					selectRowButtonOnly : true,
					parms : params,
					rownumbers : true,
					toolbar : null
				});
		jQuery("#pageloading").hide();
	});
	//列数组
	columnsArr =  [ 
		{ display : 'ID', name : 'id', align : 'center' , type : 'string' , width : 50 , render : function(row){
				return "<a class='link' href='javascript:void(0);' onclick='openWin(\""+row.uuid+"\");'>"+row.id+"</a>";
			}
		} ,
		{ display : '联系人', name : 'name', align : 'center' , type : 'string' , width : 80 } ,
		{ display : '电话', name : 'mobile_phone', align : 'center' , type : 'string' , width : 100 } ,
		{ display : '所在地区', name : 'contact_address', align : 'left' , type : 'string' , width : 100 } ,
		{ display : '询价产品', align : 'left' , type : 'string' , width : 200 , render : function(row){
				return row.factoryname+row.product_name+row.cataname;
			}
		} ,
		{ display : '询价时间', name : 'add_date', align : 'center' , type : 'string' , width : 150 ,render:function(row){
		      return (row.add_date.length>=19)?row.add_date.substr(0,19):row.add_date ;
		  }
		}
		<%
			//如果是利润结算
			if("DCED306B-3981-4D7F-AB09-0AFBC89D97C7".equals(channelUUID)){
				%>
,
		{ display : '外呼结果', name : 'call_rs', align : 'center' , type : 'string' , width : 80 , render : function(row){
				if(null==row.call_rs||'null'==row.call_rs||''==row.call_rs){
					return '<span style="color:red;">未外呼</span>';
				}
				var colorArr = {'103001':'#F00','103003':'#CCC','103005':'#00F','103006':'#0F0','103007':'#0FF'};
				return "<span style='color:"+colorArr[row.call_rs]+"'>"+getEnum(row.call_rs)+"</span>";
			}
		} ,
		{ display : '是否高质', name : 'is_high_quality', align : 'center' , type : 'is' , width : 70} ,
		{ display : '是否推送', name : 'is_push', align : 'center' , type : 'is' , width : 60 } ,
		{ display : '返利', name : 'rebate', align : 'right' , type : 'int' , width : 120 , render : function(row){
				return 3000+"元";
			} ,
			totalSummary : {
				render : function (suminf, column, cell){
					return '<div>合计:'+(cell.Rows.length*3000)+'元</div>';
				},
				align: 'right'
			}
		} ,
		{ display : '购机凭证', align : 'center' , type : 'is' , width : 60 , render : function(row){
				return '<a href="/images/n_ads05.jpg" class="link"class="highslide" onclick="return hs.expand(this)">购机凭证</a>';
			}
		} ,
		{ display : '导出', align : 'center' , type : 'string' , width : 60 , render : function(row){
				if(row.call_rs=='103002'){
					return "<a class='link' href='/backend/pro_product_form/order_list_excel.jsp?if_tag=2&formUUID="+row.uuid+"' target='_blank'>导出</a>";
				}
				return '待外呼';
			}
		} 
				<%
			//如果购买的是其他设备
			}else if("9AD9013E-67E1-4FB8-BA60-CBB1D0FF4AE4".equals(channelUUID)){
				%>
			,
			{ display : '其它品牌', name : 'other_brand', align : 'center' , type : 'string' , width : 70} ,
			{ display : '其它类型', name : 'other_category', align : 'center' , type : 'string' , width : 70} ,
			{ display : '其它型号', name : 'other_model', align : 'center' , type : 'string' , width : 70} ,
			{ display : '其它价格', name : 'other_price', align : 'center' , type : 'string' , width : 70} ,
			{ display : '意向品牌', name : 'intention_brand', align : 'center' , type : 'string' , width : 70} ,
			{ display : '意向类型', name : 'intention_category', align : 'center' , type : 'string' , width : 70} ,
			{ display : '意向型号', name : 'intention_model', align : 'center' , type : 'string' , width : 70} ,
			{ display : '意向价格', name : 'intention_price', align : 'center' , type : 'string' , width : 70} 
				<%
			//如果是未购设备
			}else if("291382B1-9F9D-4D60-B645-1D362FFED85B".equals(channelUUID)){
				%>
			,
			{ display : '意向品牌', name : 'intention_brand', align : 'center' , type : 'string' , width : 70} ,
			{ display : '意向类型', name : 'intention_category', align : 'center' , type : 'string' , width : 70} ,
			{ display : '意向型号', name : 'intention_model', align : 'center' , type : 'string' , width : 70} ,
			{ display : '意向价格', name : 'intention_price', align : 'center' , type : 'string' , width : 70} 
				<%
			}
		%>
		
	];
	function dosubmit(obj){
		  jQuery("#if_tag").val(obj) ;
		  jQuery("#theform").attr("action","/backend/pro_product_form/order_list_excel.jsp") ;
		  jQuery("#theform").attr("method","post") ;
		  jQuery("#theform").submit() ;
	}
	function addTask1(uuid){
		jrWindow("/backend/pro_400_task1/pro_400_task1_edit.jsp?form_uuid="+uuid+"&f=list","添加任务",650,500);
	}
	function addTask2(uuid){
		jrWindow("/backend/pro_400_task2/pro_400_task2_edit.jsp?form_uuid="+uuid+"&f=list","添加任务",650,500);
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
	
	//增加和编辑的方法
	function addAndEdit(index){
 	
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
		var start_form_id = jQuery("#start_form_id").val();
		var end_form_id = jQuery("#end_form_id").val();
		if(''!=start_form_id&&''!=end_form_id){
			conditionStr += " and id between '"+start_form_id+"' and '"+end_form_id+"' ";
		}else if(''!=start_form_id){
			conditionStr += " and id >= "+start_form_id;
		}else if(''!=end_form_id){
			conditionStr += " and id <= "+end_form_id;
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
		var factoryname = jQuery("#factoryname").val();
		if(''!=jQuery.trim(factoryname)){
			conditionStr += " and factoryname like '%"+factoryname+"%' ";
		}
		var cataname = jQuery("#cataname").val();
		if(''!=jQuery.trim(cataname)){
			conditionStr += " and cataname like '%"+cataname+"%' ";
		}
		var is_high_quality = jQuery("#is_high_quality").val();
		if(''!=jQuery.trim(is_high_quality)){
			conditionStr += " and is_high_quality = "+is_high_quality;
		}
		var name = jQuery("#name").val();
		if(''!=jQuery.trim(name)){
			conditionStr += " and name like '%"+name+"%' ";
		}
		var product_name = jQuery("#product_name").val();
		if(''!=jQuery.trim(product_name)){
			conditionStr += " and product_name like '%"+product_name+"%' ";
		}
		var contact_address = jQuery("#contact_address").val();
		if(''!=jQuery.trim(contact_address)){
			conditionStr += " and contact_address like '%"+contact_address+"%' ";
		}
		var state = jQuery("input[type='radio']:checked").val();
		if(''!=jQuery.trim(state) && '-1'!= jQuery.trim(state)){
			conditionStr += " and state = '"+state+"' ";
		}
		var catalogname = jQuery("#catalogname").val() ;
		if(''!=jQuery.trim(catalogname))
		{
		  conditionStr += " and cataname like '%"+catalogname+"%' ";
		}
		var call_rs = jQuery("#call_rs").val() ;
		if(''!=call_rs){
		   conditionStr += " and call_rs = '"+call_rs+"' " ; 
		}
		var factoryid = jQuery("#factoryid").val() ;
		if(''!=jQuery.trim(factoryid))
		{
		  conditionStr += " and factoryid='"+factoryid+"'";
		}
		var orderbywhat = jQuery("#orderbywhat").val() ;
		if(''!=orderbywhat){
		   orderBy = orderbywhat + " desc" ; 
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
	function dosubmit(obj){
	  jQuery("#if_tag").val(obj) ;
	  jQuery("#theform").attr("action","/backend/pro_product_form/order_list_excel.jsp") ;
	  jQuery("#theform").attr("method","post") ;
	  jQuery("#theform").submit() ;
	}
	// 1 省份 1 月份
	function showTOP10orders(obj){
	  jrWindow("/backend/pro_product_form/top10orders.jsp?if_tag="+obj,obj=="1"?"省份订单量前10位":"月份订单量前10位","600","360") ;
	}
	jQuery("#start_date").ligerDateEditor({width:150});
	jQuery("#end_date").ligerDateEditor({width:150});
		// 回车提交表单
	 document.onkeydown=function(event){ 
        e = event ? event :(window.event ? window.event : null); 
        if(e.keyCode==13){ 
            //执行的方法  
            doSearch();
        } 
        }
</script>