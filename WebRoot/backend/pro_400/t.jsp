<%@ page language="java" import="java.util.*,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*" pageEncoding="UTF-8"%>
<%
	String tableName = "pro_product_form";
	String tablePrefix = Env.getInstance().getProperty("table_prefix");
	String fileds = "is_special,catanum,is_send,id,province,city,name,mobile_phone,factoryname,product_name,cataname,add_date,call_rs,factoryid,is_success,is_first,product_id,uuid,contact_address,call_rs_task2";
	String channelUUID = CommonString.getFormatPara(request.getParameter("channel_uuid"));
	Map channelMap = (Map)application.getAttribute("channelMap");
	Map catalogMap = (Map)application.getAttribute("catalogMap") ;
	DBHelper dbHelper = DBHelper.getInstance() ;
	List<Map> brandList = (ArrayList)application.getAttribute("brandList") ;
	brandList =  dbHelper.getMapList(" select id,name,upper_index from pro_agent_factory where is_show=1 and flag=1 order by upper_index,id asc") ;
	Collections.sort(brandList,new Comparator(){
		public int compare(Object o1, Object o2) {
			Map o1Map = (Map)o1;
			Map o2Map = (Map)o2;
			return o1Map.get("upper_index").toString().compareTo(o2Map.get("upper_index").toString());
		}
	 });
	String whereStr = " and  ( task1_over = 0 or task2_over = 0 ) and is_deleted=0";
	Map adminInfo = (Map)session.getAttribute("adminInfo");
	//中联土方
	if("zoomlion_tufang".equals(adminInfo.get("usern"))){
		whereStr += " and factoryid = 1780 ";
	}else if("xcmg_waji".equals(adminInfo.get("usern"))){
		whereStr += " and factoryid = 209 and catanum like '101001%' ";
	}
	String orderByStr = " id desc,add_date desc   ";
	Map stateMap = new HashMap() ;
	stateMap.put("0","否") ;
	stateMap.put("1","是") ;
	stateMap.put("-1","全部") ;
	Map call_rsMap = CommonApplication.getEnumChildren("103",application);
	Map call_rsMap2 = CommonApplication.getEnumChildren("106",application);
	String usern = CommonString.getFormatPara(adminInfo.get("usern") ) ;
	//广州区域挖掘机订单、重庆区域挖掘机订单、四川区域乐眉、资阳、宜宾、泸州、自贡挖掘机订单、浙江区域挖掘机订单、
	//全国旋挖钻订单、
	//全国破碎锤订单、北京、天津区域除挖掘机以外的订单。
      
	if("mujie".equals(usern)){
			//whereStr+=" and ( (catanum like '%101001%' and( contact_address like '%广州%' or contact_address like '%重庆%' or contact_address like '%乐眉%' or contact_address like '%资阳%' or contact_address like '%宜宾%' or contact_address like '%泸州%' or contact_address like '%自贡%' or contact_address like '%自贡%'))" ;
			//whereStr += " or catanum like '%105003%' " ;
			//whereStr += " or catanum like '%113001%'"  ;
			//whereStr += " or (( contact_address like '%北京%' or contact_address like '%天津%') and catanum not like '%101001%'))" ;
	}
	//张嘉迅：山东区域挖掘机订单、湖南区域挖掘机订单、江西区域挖掘机订单
	if("zhangjx".equals(usern)){
			//whereStr += " and catanum like '%101001%' and (contact_address like '%山东%' or contact_address like '%湖南%' or contact_address like '%江西%' )" ;
	}
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
      <div class="searchLeft" style="width:70px;">订<span class="span3"></span>单<span class="span3"></span>人</div>
      <div class="searchRight">
        <input type="text" style="width: 80px;" class="jr_text" name="name" id="name" />
      </div>
      <div class="searchLeft" style="width:70px;">订购时间</div>
      <div class="searchRight" >
        <input type="text" style="width: 50px;"  name="start_date" id="start_date" />
      </div>
      <div class="searchLeft" style="width:10px;">&nbsp;~</div>
      <div class="searchRight" >
        <input type="text" style="width: 50px;"  name="end_date" id="end_date" />
      </div>
      <div class="searchLeft" style="width:70px;">订单编号</div>
      <div class="searchRight">
        <input type="text" name="start_form_id" id="start_form_id" style="width:80px;" class="jr_text" />
        ~
        <input type="text" name="end_form_id" id="end_form_id" style="width:80px;" class="jr_text" />
      </div>
      <div class="searchRight" style="margin-left: 5px; width: 80px;">
        <select name="orderbywhat" id="orderbywhat" class="jr_select" style="width: 100px;">
          <option value="add_date">-时间排序-</option>
          <option value="factoryname">-厂家排序-</option>
          <option value="contact_address">-省份排序-</option>
          <option value="catanum">-机种排序-</option>
        </select>
      </div>
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
      <div class="searchLeft"  style="width:70px;">品<span class="span2"></span>牌</div>
      <div class="searchRight">
        <select name="factoryid" id="factoryid" class="jr_select" style="width: 152px;">
          <option value="">-请选择-</option>
          <%if(brandList != null){for(Map m : brandList){%>
          <option value="<%=m.get("id")%>"><%=m.get("upper_index")%>：<%=m.get("name")%></option>
          <%}}%>
        </select>
      </div>
      <div class="searchLeft"  style="width:70px;">手机号</div>
      <div class="searchRight">
        <input type="text" style="width: 100px;" class="jr_text" name="tel" id="tel" />
      </div>
      <div class="searchLeft"  style="width:70px;">所在地区</div>
      <div class="searchRight">
        <input type="text" style="width: 100px;" class="jr_text" name="contact_address" id="contact_address" />
      </div>
      <div style="clear:left"></div>
      <div class="searchLeft"  style="width:70px;">吨位选择</div>
      <div class="searchRight" >
        <select name="tonandmeter" id="tonandmeter" class="jr_select" style="width: 100px;"  onchange="jQuery('#zd_tonandmeter').val(jQuery.trim(jQuery('#tonandmeter').find('option:selected').val()));getProName(this.options[this.selectedIndex].value);">
          <option value="">请选择吨位</option>
          <option value="0">3T以下(装机)</option>
          <option value="1">3T(装机)</option>
          <option value="2">3T～5T(装机)</option>
          <option value="3">5T以上(装机)</option>
          <option value="4">1T～13T(挖机)</option>
          <option value="5">14T～30T(挖机)</option>
          <option value="6">30T以上(挖机)</option>
        </select>
        <input type="hidden" class="jr_text" name="zd_tonandmeter" id="zd_tonandmeter" value="" style="width:270px" />
      </div>
      <div class="searchLeft" style="width:70px;">第一次</div>
      <div class="searchRight" style="margin-left: 4px; width: 100px;">
        <select name="call_rs" id="call_rs" class="jr_select" style="width: 100px;">
          <option value="">--呼叫结果--</option>
          <%=CommonForm.createSelect(call_rsMap,"") %>
        </select>
      </div>
      <div class="searchLeft" style="width:70px;">第二次</div>
      <div class="searchRight" style="margin-left: 4px; width: 100px;">
        <select name="call_rs2" id="call_rs2" class="jr_select" style="width: 100px;">
          <option value="">--呼叫结果--</option>
          <%=CommonForm.createSelect(call_rsMap2,"") %>
        </select>
      </div>
      <div class="searchLeft"  style="width:70px;">产品名称</div>
      <div class="searchRight">
        <input type="text" style="width: 100px;" class="jr_text" name="product_name" id="product_name" />
      </div>
      <div class="searchLeft"  style="width:70px;">搜索类别</div>
      <div class="searchRight">
        <input type="text" style="width: 100px;" class="jr_text" name="cataname" id="cataname" />
      </div>
      <div style="clear:left"></div>
      <div class="searchLeft" style="width:70px;">是否处理</div>
      <div class="searchRight"> <%=CommonForm.createRadio(stateMap,"-1","state") %> </div>
      <div class="searchLeft" style="width:70px;">是否推送</div>
      <div class="searchRight"> <%=CommonForm.createRadio(stateMap,"-1","is_success") %> </div>
      <div class="searchLeft" style="width:70px;">主动咨询</div>
      <div class="searchRight"> <%=CommonForm.createRadio(stateMap,"-1","is_first") %> </div>
      <div class="searchLeft" style="width:10px;">&nbsp;</div>
      <div class="searchLeft" style="width:70px;">订单来源</div>
      <div class="searchRight">
        <div class="jr_radio_group">
          <input class="jr_radio" type="radio" name="from_source" id="from_source0" value="1">
          <label for="is_first0">PC端</label>
          <input class="jr_radio" type="radio" name="from_source" id="from_source1" value="0">
          <label for="is_first1">手机端</label>
          <input class="jr_radio" type="radio" name="from_source" id="from_source2" value="2">
          <label for="is_first2">全部</label>
        </div>
      </div>
	  <%if(usern.equals("zhangjx")||usern.equals("zengfc")){%>
	     <div style="clear:left"></div>
	  <div class="searchLeft" style="width:70px;">卡特分类</div>
	  <div class="searchRight">
        <select name="cat_catalog" id="cat_catalog" class="jr_select" style="width: 100px;"  >
          <option value="">请选择分类</option>
          <option value="0">GCI</option>
          <option value="1">NPI</option>
          <option value="2">BCP</option>
        </select>
      </div>
	  
	  	 <div class="searchLeft" style="width:70px;">来自竞价</div>
      <div class="searchRight">
        <div class="jr_radio_group">
          <input class="jr_radio" type="radio" name="from_baidu" id="from_baidu0" value="1">
          <label for="from_baidu0">是</label>
          <input class="jr_radio" type="radio" name="from_baidu" id="from_baidu1" value="0">
          <label for="from_baidu1">否</label>
          <input class="jr_radio" type="radio" name="from_baidu" id="from_baidu2" value="2">
          <label for="from_baidu2">全部</label>
        </div>
      </div>
	  
	  <!--
	  <div class="searchLeft" style="width:70px;">提交IP</div>
      <div class="searchRight" >
        <input type="text" style="width: 120px;"  name="add_ip" id="add_ip" />
      </div>
	  -->
	  <div class="searchLeft" style="width:70px;">cat手机</div>
      <div class="searchRight"> <%=CommonForm.createRadio(stateMap,"-1","is_cat_phone") %> </div>
	  
	  

	  
	  <%}%>
      <div class="searchRight">
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
					  			items : [ {
									text:"删除至订单仓库",
									click:function(){
									toolbarOrderDelNew({
											channel_uuid:'<%=channelUUID %>'
										});
		 
									},
									icon:"delete"
								},    
								{
									text : '导出',
									click : function(){
										dosubmit(1);
									},
									icon : 'add'
								},   
								{
									text : '一键导出',
									click : function(){
										  dosubmitOld(2);
									},
									icon : 'add'
								}
								]
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
		{ display : '省份', name : 'province', align : 'left' , type : 'string' , width : 55 } ,
	 	{ display : '地区', name : 'city', align : 'left' , type : 'string' , width : 70 } ,
		{ display : '联系人', name : 'name', align : 'center' , type : 'string' , width : 55 } ,
		{ display : '电话', name : 'mobile_phone', align : 'center' , type : 'string' , width : 95 } ,
	    { display : '所属厂家', name : 'factoryname', align : 'left' , type : 'string' , width : 70 ,render:function(row){
	   	     return "<a href='../goto.jsp?flag=2&id="+row.factoryid+"' target='_blank'>"+(row.factoryname==null?"":row.factoryname)+"</a>" ;
	        }
	    } ,
		{ display : '询价产品', align : 'left' , type : 'string' , width : 75 , render : function(row){
				//return row.factoryname+row.product_name+row.cataname;
				return row.product_name;
			}
		} ,
		{ display : '所属分类', name : 'cataname', align : 'left' , type : 'string' , width : 100 } ,
		{ display : '询价时间', name : 'add_date', align : 'center' , type : 'string' , width : 130 ,render:function(row){
		      return (row.add_date.length>=19)?row.add_date.substr(0,19):row.add_date ;
		  }
		},
		<%
			//如果是任务1
			if("85CC0544-A55E-478D-B064-34E73B1FA60D".equals(channelUUID)){
				%>
		{ display : '外呼结果', name : 'call_rs', align : 'center' , type : 'string' , width : 80 , render : function(row){
				if(null==row.call_rs||'null'==row.call_rs||''==row.call_rs){
					return '<span style="color:red;"><a class="link" href="javascript:void(0);" onclick="addTask1(\''+row.uuid+'\');">未外呼</a></span>';
				}
				var colorArr = {'103001':'#F00','103003':'#CCC','103005':'#00F','103006':'#0F0','103007':'#0FF'};
				return "<span style='color:"+colorArr[row.call_rs]+"'><a class='link' href='javascript:void(0);' onclick='addTask1(\""+row.uuid+"\");'>"+getEnum(row.call_rs)+"</a></span>";
			}
		} ,
				<%
			}else if("DC843F5C-5930-4074-860E-478BAA1CE83C".equals(channelUUID)){//如果是任务2
				%>
				{ display : '是否联系及结果', name : 'is_buy_self', align : 'center' , type : 'string' , width : 100 , render : function(row){
						if(row.is_link==0||row.is_link=='0'){
							return '未联系';
						}else{
							if(row.is_buy_self==2||row.is_buy_self=='2'){
								return '<span style="color:red;">联系中<span>';
							}else if(row.is_buy_self==1||row.is_buy_self=='1'){
								return '<span style="color:blue;">已购买</span>';
							}else{
								return '未购买';
							}
						}
					}
				} ,
				{ display : '外呼结果', name : 'call_rs_task2', align : 'center' , type : 'string' , width : 80 , render : function(row){
						if(null==row.call_rs_task2||'null'==row.call_rs_task2||''==row.call_rs_task2){
							return '<span style="color:red;"><a class="link" href="javascript:void(0);" onclick="addTask2(\''+row.uuid+'\');">未外呼</a></span>';
						}
						var colorArr = {'103001':'#F00','103003':'#CCC','103005':'#00F','103006':'#0F0','103007':'#0FF'};
						return "<span style='color:"+colorArr[row.call_rs_task2]+"'><a class='link' href='javascript:void(0);' onclick='addTask2(\""+row.uuid+"\");'>"+getEnum(row.call_rs_task2)+"</a></span>";
					}
				} ,
						<%
			}else{
				%>
		{ display : '第一次外呼', name : 'call_rs', align : 'center' , type : 'string' , width : 80 , render : function(row){
				if(null==row.call_rs||'null'==row.call_rs||''==row.call_rs){
					//return '<span style="color:red;"><a class='link' href='javascript:void(0);' onclick='addTask1(\""+row.uuid+"\");'>未外呼</a></span>';
					return '<span style="color:red;"><a  class="link" href="javascript:void(0);" onclick="addTask1(\''+row.uuid+'\');">未外呼</a></span>';
				}
				var colorArr = {'103001':'#F00','103003':'#CCC','103005':'#00F','103006':'#0F0','103007':'#0FF'};
				return "<span style='color:"+colorArr[row.call_rs]+"'><a class='link' href='javascript:void(0);' onclick='addTask1(\""+row.uuid+","+row.id+"\");'>"+getEnum(row.call_rs)+"</a></span>";
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
				<%
			}
		%>		
		{ display : '合作推送', name : '', align : 'center' , type : 'string' , width : 50,render:function(row){
			if(row.push_order==1){
				return "";
			}else{
	  		return "<a class='link' href='javascript:void(0);' onclick='pushOrder("+row.__index+");'>推送</a>";
			}
    	   } 
	    } ,

    
		{ display : '短信发送', name : 'is_send', align : 'center' , type : 'string' , width : 50,render:function(row){
		  return "<a href='javascript:void(0);' onclick='sendSms("+row.__index+");'>"+(row.is_send=="1"?"<font color='green'>已发送</font>":"<font color='red'>未发送</font>")+"</a>";
	    	} 
		} ,
		
		
		{ display : 'app分配状态', name : 'buy_type', align : 'center' , type : 'string' , width : 80,render:function(row){
		if(row.factoryid=="14238"||row.factoryid=="1777"||row.factoryid=="16683"||row.factoryid=="16566"||row.factoryid=="141"||row.factoryid=="154" ){
				
				var operateStr="";
			    $.ajax({
				async:false,
				type:"post",
				url:"/backend/action/ajax_r.jsp",
				data:{flag:"appOrderState",factoryid:row.factoryid,orderid:row.mobile_phone},
				success:function(result){
					operateStr=$.trim(result);
				}
			    });
				if(operateStr=='未分配'){
				    operateStr=operateStr+"||"+"<a class='link' href='javascript:void(0);' onclick='sendApp("+row.__index+");'>发送</a>";
				}
			    return operateStr;
				
			}else{
				return "-";
			}		
    	  } 
		} ,
		
	    { display : '是否推送', name : 'is_success', align : 'center' , type : 'string' , width : 90,render:function(row){
			if(row.factoryid=="174"||row.factoryid=="138"||row.factoryid=="133"||row.factoryid=="139"){
				if(row.is_success=="1"){
					   if(row.is_special=="1"){
						    return "是 <%	if("zhangjx".equals(usern)){%>(活动)<%}%>";
					   }else{
						    return "是";
					   }
				}else{
					 return "<font color='#FF0000'>否</font>";
				}
			
				
			}else{
			    return "";
			}
			
    	   } 
	    } ,
 
		
		<%	if("zhangjx".equals(usern)){%>
	    { display : '订单推送', name : '', align : 'center' , type : 'string' , width : 140,render:function(row){
			if(row.factoryid=="174"){
				return "<a class='link' href='javascript:void(0);' onclick='sendOrder("+row.__index+",1);'>推送</a>"+"&nbsp;||&nbsp;"+"<a class='link' href='javascript:void(0);' onclick='sendOrder("+row.__index+",6);'>活动推送</a>";
			}else if(row.factoryid=="138"){
				return "<a class='link' href='javascript:void(0);' onclick='sendOrder("+row.__index+",2);'>推送</a>";
			}else if(row.factoryid=="133"){
				return "<a class='link' href='javascript:void(0);' onclick='sendOrder("+row.__index+",3);'>推送</a>";
			}else if(row.factoryid=="139"){
				return "<a class='link' href='javascript:void(0);' onclick='sendOrder("+row.__index+",4);'>精准</a>"+"||"+"<a class='link' href='javascript:void(0);' onclick='sendOrder("+row.__index+",5);'>不精准</a>";
			}else{
				return "";
			}		
    	  } 
	   } ,
			<%}else{%>
				    { display : '订单推送', name : '', align : 'center' , type : 'string' , width : 80,render:function(row){
			if(row.factoryid=="174"){
				return "<a class='link' href='javascript:void(0);' onclick='sendOrder("+row.__index+",1);'>推送</a>";
			}else if(row.factoryid=="138"){
				return "<a class='link' href='javascript:void(0);' onclick='sendOrder("+row.__index+",2);'>推送</a>";
			}else if(row.factoryid=="133"){
				return "<a class='link' href='javascript:void(0);' onclick='sendOrder("+row.__index+",3);'>推送</a>";
			}else if(row.factoryid=="139"){
				return "<a class='link' href='javascript:void(0);' onclick='sendOrder("+row.__index+",4);'>精准</a>"+"||"+"<a class='link' href='javascript:void(0);' onclick='sendOrder("+row.__index+",5);'>不精准</a>";
			}else{
				return "";
			}		
    	  } 
	   } ,
			<%}%>

	    { display : '主动咨询', name : 'is_first', align : 'center' , type : 'string' , width : 50,render:function(row){
				return row.is_first=="1"?"是":"<font color='#FF0000'>否</font>";
		
			
    	   } 
	    } 

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
	function addTask1(obj){
    
	    var kk = obj.split(",")
		jrWindow("/backend/pro_400_task1/pro_400_task1_edit.jsp?id="+kk[1]+"&form_uuid="+kk[0]+"&f=list","添加任务",650,420);
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
	//短信发送
	function sendSms(index){
		var row = grid.getRow(index);
		var url = "/backend/function/send_sms/send.jsp?city="+row.city+"&province="+row.province+"&order_id="+row.id+"&factoryid="+row.factoryid+"&param="+encodeURIComponent(row.contact_address+row.name+row.mobile_phone+"询"+row.factoryname+row.product_name+row.cataname);
		//var url = "/backend/pro_400/send.jsp?productid="+row.id+"&city="+row.city+"&province="+row.province+"&order_id="+row.id+"&factoryid="+row.factoryid+"&param="+encodeURIComponent(row.contact_address+row.name+row.mobile_phone+"询"+row.factoryname+row.product_name+row.cataname);
		jrWindow(url, "短信发送", 600, 300);
	}
	//进行订单推送
	function pushOrder(index){
		var row = grid.getRow(index);
		var url = "/backend/pro_agent_factory/order_push.jsp?uuid="+row.uuid;
		//var url = "/backend/pro_400/send.jsp?productid="+row.id+"&city="+row.city+"&province="+row.province+"&order_id="+row.id+"&factoryid="+row.factoryid+"&param="+encodeURIComponent(row.contact_address+row.name+row.mobile_phone+"询"+row.factoryname+row.product_name+row.cataname);
		jrWindow(url, "订单推送", 1000, 400);
	}
	
		//订单推送
	function sendOrder(index,flag){
		var row = grid.getRow(index);
		var url ="";
		if(flag=="1"){
		   url = "/tools/order_interface/cat_admin.jsp?uuid="+row.uuid;
		}else if(flag=="2"){
		   url = "/tools/order_interface/shangong_admin.jsp?uuid="+row.uuid;
		}else if(flag=="3"){
		   		   url = "/tools/order_interface/sany_admin.jsp?uuid="+row.uuid;
		}else if(flag=="4"){
		   		   url = "/tools/order_interface/xiagong_admin.jsp?uuid="+row.uuid+"&comfirm=1";
		}else if(flag=="5"){
		   		   url = "/tools/order_interface/xiagong_admin.jsp?uuid="+row.uuid+"&comfirm=2";
		}else if(flag=="6"){
		   url = "/tools/order_interface/cat_admin_new.jsp?uuid="+row.uuid;
		}
		if((flag=="5"||flag=="4") ){
			
			 $.ajax({
		        url:"/backend/action/ajax_r.jsp",
		        type:"post",
				cache:false,
		        data:{"flag":"checkRepeat","mobile_phone":row.mobile_phone},
		        success:function(data){
					if($.trim(data)=='norepeat'){
						    jrWindow(url, "订单推送", 900, 600);
					}else{
						if(confirm("该人订单已推送过，确认推送该订单?")){
                            jrWindow(url, "订单推送", 900, 600);
		                }
					}
		        }
	         });
			

			
		}else{
		jrWindow(url, "订单推送", 900, 600);
		}
	}
	
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
	    		title:'修改' 
	    	},row.id);
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
		var tonandmeter=jQuery("#zd_tonandmeter").val();
          if(tonandmeter=='0'){
             conditionStr += " and product_id in(select id from pro_products where tonandmeter <3 and catalognum like '101002%') ";
        }else if(tonandmeter=='1'){
            conditionStr += " and product_id in(select id from pro_products where tonandmeter =3 and catalognum like '101002%')";
       }else if(tonandmeter=='2'){
	      	conditionStr += " and product_id in(select id from pro_products where tonandmeter > 3 and tonandmeter <5 and catalognum like '101002%') ";
       }else if(tonandmeter=='3'){
	      	conditionStr += " and product_id in(select id from pro_products where tonandmeter > 5 and catalognum like '101002%')";
       }else if(tonandmeter=='4'){
	        conditionStr += " and product_id in(select id from pro_products where tonandmeter > 1 and tonandmeter <13 and catalognum like '101001%')";
       }else if(tonandmeter=='5'){
	        conditionStr += " and  product_id in(select id from pro_products where tonandmeter > 14 and tonandmeter <30 and catalognum like '101001%') ";
       }else if(tonandmeter=='6'){
	       conditionStr += " and  product_id in(select id from pro_products where tonandmeter >30 and catalognum like '101001%') ";
       }          		
              
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

	
		var name = jQuery("#name").val();
		if(''!=jQuery.trim(name)){
			conditionStr += " and name like '%"+name+"%' ";
		}
	
		var contact_address = jQuery("#contact_address").val();
		if(''!=jQuery.trim(contact_address)){
			conditionStr += " and province like '%"+contact_address+"%' ";
		}
		//var catalogname = jQuery("#catalogname").val() ;
		//if(''!=jQuery.trim(catalogname))
		//{
		//  conditionStr += " and cataname like '%"+catalogname+"%' ";
		//}
		var cataname = jQuery("#cataname").val() ;
		if(''!=jQuery.trim(cataname))
		{
		  conditionStr += " and cataname like '%"+cataname+"%' ";
		}
		
		var add_ip = jQuery("#add_ip").val() ;
		if(add_ip=='undefined'||add_ip==undefined){add_ip='';}
		if(''!=add_ip){
		   conditionStr += " and add_ip = '"+add_ip+"' " ; 
		}
		
		var call_rs = jQuery("#call_rs").val() ;
		if(''!=call_rs){
		   conditionStr += " and call_rs = '"+call_rs+"' " ; 
		}
		var call_rs2 = jQuery("#call_rs2").val() ;
		if(''!=call_rs2){
		   conditionStr += " and call_rs_task2 = '"+call_rs2+"' " ; 
		}
		var factoryid = jQuery("#factoryid").val() ;
		if(''!=jQuery.trim(factoryid))
		{
		  conditionStr += " and factoryid='"+factoryid+"'";
		}
		var state = jQuery("input[name='state']:checked").val();
		if(''!=jQuery.trim(state) && '-1'!= jQuery.trim(state)){
			conditionStr += " and state = '"+state+"' ";
		}
		var is_success  = jQuery("input[name='is_success']:checked").val();
		var from_source  = jQuery("input[name='from_source']:checked").val();
		var is_first  = jQuery("input[name='is_first']:checked").val();
		var is_cat_phone  = jQuery("input[name='is_cat_phone']:checked").val();
		
		var from_baidu  = jQuery("input[name='from_baidu']:checked").val();
        if('1'== jQuery.trim(from_baidu)){
			conditionStr += " and  (add_user='baidu'  and (source_uuid  ='' or source_uuid is null) ) ";
		}else if('0'== jQuery.trim(from_baidu)){
		    conditionStr += " and  ( (add_user!='baidu' or add_user='' or add_user is null   )  or  (add_user='baidu' and source_uuid  !=''  and  source_uuid is not null ) )";
		}
		
	    if('1'== jQuery.trim(is_cat_phone)){
			conditionStr += " and is_special  = '1' ";
		}else if('0'== jQuery.trim(is_cat_phone)){
			conditionStr += " and (is_special  is null  or  is_special=''  or  is_special='0' )  ";
		}
		
		
		if('1'== jQuery.trim(is_success)){
			conditionStr += " and is_success  = '1' ";
		}else if('0'== jQuery.trim(is_success)){
			conditionStr += " and (is_success  is null  or  is_success=''  or  is_success='0' )  ";
		}
		
		if('174'==jQuery.trim(factoryid)){

		if('1'== jQuery.trim(from_source)){  //pc端
               	
			if('1'== jQuery.trim(is_first)){  //主动
				conditionStr +=  "and  ( is_first=1  or add_user ='baidu' )";
			}else if('0'== jQuery.trim(is_first)){ //引导
				conditionStr +=  "and  ((is_first  is null  or  is_first=''  or  is_first='0' or  is_first=0 ) and  (add_user! ='baidu' or add_user  is null  or  add_user=''  )  and add_user not like '%mobile%'  )";
			}else{  //其他所有
				conditionStr += " and  (add_user not like '%mobile%' or add_user='' or add_user is null  ) ";
			}					
			 
		}else if('0'== jQuery.trim(from_source)){  //手机端
            
			if('1'== jQuery.trim(is_first)){  //主动
				conditionStr += " and  add_user like '%mobile%' and (push_order!= 1 or  push_order is null  )";
			}else if('0'== jQuery.trim(is_first)){ //引导
				conditionStr += " and  add_user like '%mobile%'  and push_order = 1 ";
			}else{  //其他所有
				conditionStr +=" and add_user like '%mobile%' ";
			}	
			 
		}else{  //全部
		
			if('1'== jQuery.trim(is_first)){  //主动
				conditionStr += "and ((   is_first=1  ) or ( add_user   like '%mobile%' and (push_order!= 1 or  push_order is null  )  ) or add_user like '%baidu%' )"; 
			}else if('0'== jQuery.trim(is_first)){ //引导
				conditionStr += " and  (((is_first  is null  or  is_first=''  or  is_first='0' or  is_first=0 ) and  (add_user! ='baidu' or add_user  is null  or  add_user=''  )  and add_user not like '%mobile%'  )    or (add_user   like '%mobile%' and push_order=1)  ) ";
			}else{  //其他所有
				
			}	
		}
		
		}else{
		

		if('1'== jQuery.trim(from_source)){  //pc端
               	
			if('1'== jQuery.trim(is_first)){  //主动
				conditionStr +=  "and  ( is_first=1  or add_user ='baidu' )";
			}else if('0'== jQuery.trim(is_first)){ //引导
				conditionStr +=  "and  ((is_first  is null  or  is_first=''  or  is_first='0' or  is_first=0 ) and  (add_user! ='baidu' or add_user  is null  or  add_user=''  )  and add_user not like '%mobile%'  )";
			}else{  //其他所有
				conditionStr += " and  (add_user not like '%mobile%' or add_user='' or add_user is null  ) ";
			}					
			 
		}else if('0'== jQuery.trim(from_source)){  //手机端
            
			if('1'== jQuery.trim(is_first)){  //主动
				conditionStr += " and  add_user like '%mobile%' and (push_order!= 1 or  push_order is null  )";
			}else if('0'== jQuery.trim(is_first)){ //引导
				conditionStr += " and  add_user like '%mobile%'  and push_order = 1 ";
			}else{  //其他所有
				conditionStr +=" and add_user like '%mobile%' ";
			}	
			 
		}else{  //全部
		
			if('1'== jQuery.trim(is_first)){  //主动
				conditionStr += "and ((   is_first=1  ) or ( add_user   like '%mobile%' and (push_order!= 1 or  push_order is null  )  ) or add_user like '%baidu%' )"; 
			}else if('0'== jQuery.trim(is_first)){ //引导
				conditionStr += " and  (((is_first  is null  or  is_first=''  or  is_first='0' or  is_first=0 ) and  (add_user! ='baidu' or add_user  is null  or  add_user=''  )  and add_user not like '%mobile%'  )    or (add_user   like '%mobile%' and push_order=1)  ) ";
			}else{  //其他所有
				
			}	
		}		
			
		}
		
		var catalognum = jQuery.trim(jQuery("#catalognum").val()) ;
		if(''!=catalognum){
			 conditionStr += " and catanum like '"+catalognum+"%'";
		}
		var tel = jQuery("#tel").val();
		if(''!=jQuery.trim(tel)){
			conditionStr += " and mobile_phone like '%"+tel+"%' ";
		}
		var orderbywhat = jQuery("#orderbywhat").val() ;
		if(''!=orderbywhat){
		   orderBy = orderbywhat + " desc" ; 
		}
		var product_name = jQuery("#product_name").val();
		if(''!=jQuery.trim(product_name)){
			conditionStr += " and product_name like '%"+product_name+"%' ";
		}

		
		
		var cat_catalog = jQuery("#cat_catalog").val();
		if(''!=jQuery.trim(cat_catalog)){
			if(cat_catalog=='0'){
			    conditionStr += " and product_id in(25477,23911,23910,23909,23908,23907,19946,11366,9555,9554,9553,9552,9551,9550,9548,9547,3525,3503,522,445,407,403,400,390,378) ";
			}
			if(cat_catalog=='1'){
			   conditionStr += " and product_id in(23922,21959,20473,20735,21524,21958,21960,23364,23371,23369,20472,20440) ";

			}
			if(cat_catalog=='2'){
			  	conditionStr += " and product_id in(23915,21525,21959,21514,20163,20164,9546,325,574,588,4561,590) ";
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
		 // alert(jQuery(".searchForm select option:eq(0)").html()) ;
       jQuery("#catanum option:eq(0)").attr("selected",true) ;
       jQuery("#factoryid option:eq(0)").attr("selected",true) ;
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
      // 添加至某引导品牌
      function toBrands(fomId){
       if(fomId.toString().length>0){
       jrWindow("/backend/pro_400/tobrands.jsp?fomId="+fomId,"引导品牌",300,400);
     }
      }
	  
	  
	//厂家推送订单列表
	function factoryList(index){
		var row = grid.getRow(index);
		var url = "/backend/pro_400/factory_order_list.jsp?uuid="+row.uuid;
		jrWindow(url, "厂家推送订单列表", 600, 300);
	}
	
	
    //代理商推送订单列表
	function agentList(index){
		var row = grid.getRow(index);
		var url = "/backend/pro_400/agent_order_list.jsp?id="+row.id;
		//var url = "/backend/pro_400/send.jsp?productid="+row.id+"&city="+row.city+"&province="+row.province+"&order_id="+row.id+"&factoryid="+row.factoryid+"&param="+encodeURIComponent(row.contact_address+row.name+row.mobile_phone+"询"+row.factoryname+row.product_name+row.cataname);
		jrWindow(url, "代理商推送订单列表", 600, 300);
	}
	
	//推送到app
	function sendApp(index){
		    var row = grid.getRow(index);
			$.ajax({
				async:false,
				type:"post",
				url:"/backend/action/ajax_r.jsp",
				data:{flag:"sendAppOrder",id:row.id,factoryid:row.factoryid,catanum:row.catanum,province:row.province,proid:row.product_id,city:row.city},
				success:function(result){
					alert("已推送");
				}
			});
	}
</script>