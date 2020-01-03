<%@ page language="java" import="java.util.*,java.sql.*,com.jerehnet.util.dbutil.*,com.jerehnet.util.common.*" pageEncoding="UTF-8"%><%
	Connection connection = null;
	String tablePrefix = Env.getInstance().getProperty("table_prefix");
	DBHelper dbHelper = DBHelper.getInstance();
	Map model = new HashMap();
	String tableName = "pro_agent_factory";
	try{
		connection = dbHelper.getConnection();
		String id = CommonString.getFormatPara(request.getParameter("id"));
		String channelUUID = CommonString.getFormatPara(request.getParameter("channel_uuid"));
		if(null!=id&&!"".equals(id)){
			model = dbHelper.getMap(" select * from "+tableName+" where uuid = ? ",new Object [] {id} , connection);
		}
		if("".equals(channelUUID)&&null!=model){
			channelUUID = (String)model.get("channel_uuid");
		}
		List <Map> brandList = (ArrayList)application.getAttribute("brandList");
		Map levelflagMap = new HashMap();
		levelflagMap.put("0","总代理");
		levelflagMap.put("1","办事处");
		List<Map> dailiList =dbHelper.getMapList(" select id,name from pro_agent_factory where flag = 2 and levelflag = 0 ",connection);
		Map dailiMap = CommonCollection.listToMap(dailiList,"id","name");
		String import_sql = "select count(*) total from pro_agent_products_form where is_import=1 and agent_id=?" ;
		String total_str = CommonString.getFormatPara(dbHelper.getMap(import_sql,new Object[]{model.get("id")}).get("total")) ;
		int total_import = Integer.parseInt(total_str.equals("")?"0":total_str) ;
%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <title><%=Env.getInstance().getProperty("project_name") %></title>
	<link href="/plugin/ui/ligerUI/ligerUI/skins/Aqua/css/ligerui-all.css" rel="stylesheet" type="text/css" />
	<link href="/plugin/ui/ligerUI/ligerUI/skins/Gray/css/all.css" rel="stylesheet" type="text/css" />
	<link href="/plugin/ui/ligerUI/ligerUI/skins/ligerui-icons.css" rel="stylesheet" type="text/css" />
	<link href="/backend/style/style.css" rel="stylesheet" type="text/css" />
	<link rel="stylesheet" type="text/css" href="/plugin/other/highslide/highslide.css" />
	<link rel="stylesheet" type="text/css" href="/plugin/editor/ueditor/themes/default/ueditor.css"/>
	<link rel="stylesheet" href="/plugin/date/My97DatePicker/skin/WdatePicker.css" type="text/css"/>
	<script src="/plugin/jquery/jquery.min.js" type="text/javascript"></script>
	<script type="text/javascript" charset="utf-8" src="/plugin/editor/ueditor/editor_config.js"></script>
	<script type="text/javascript" charset="utf-8" src="/plugin/editor/ueditor/editor_all_min.js"></script>
	<script type="text/javascript" src="/plugin/date/My97DatePicker/WdatePicker.js"></script>
   </head>
  <body style="margin: 0;padding: 0; overflow-x: hidden; overflow-y:scroll;">
	<form name="theform" id="theform" action="/backend/action/crud.jsp">
		<div class="formDiv">
				<div class="group">
				<span>
			    <img src="/plugin/ui/ligerUI/ligerUI/skins/icons/communication.gif"/>
			     </span>
				<span class="groupTitle">代理商基本信息</span>
				</div>
				<div class="formLeft">用<span class="span3">&nbsp;</span>户<span class="span3">&nbsp;</span>名</div>
				<div class="formRight">
					<input onBlur="checkRepeat()" type="text" dataType='Require' msg='请输入用户名' class="jr_text" name="zd_usern" id="zd_usern" value="<%=CommonString.getFormatPara(model.get("usern")) %>" />
				</div>
				<div style="clear:left;"></div>
				<div class="formLeft">原密码</div>
				<div class="formRight">
					<input type="text" dataType='Require' msg='请输入密码' class="jr_text" name="zd_passw_bak" id="zd_passw_bak" value="<%=CommonString.getFormatPara(model.get("passw_bak")) %>" />
				</div>
				<div style="clear:left;"></div>
				<div class="formLeft">代理商简称</div>
				<div class="formRight">
					<input type="text" dataType='Require' msg='请输入代理商简称' class="jr_text" name="zd_name" id="zd_name" value="<%=CommonString.getFormatPara(model.get("name")) %>" />
				</div>
				<div style="clear:left;"></div>
				<div class="formLeft">代理商全称</div>
				<div class="formRight">
					<input type="text" dataType='Require' msg='请输入代理商全称' class="jr_text" name="zd_full_name" id="zd_full_name" value="<%=CommonString.getFormatPara(model.get("full_name")) %>" />
				</div>
				<div style="clear:left;"></div>
				<div class="formLeft">联系电话</div>
				<div class="formRight">
					<input type="text" class="jr_text" name="zd_telphone" id="zd_telphone" value="<%=CommonString.getFormatPara(model.get("telphone")) %>" />
				</div>
				<div style="clear:left;"></div>
				<div class="formLeft">联<span class="span3">&nbsp;</span>系<span class="span3">&nbsp;</span>人</div>
				<div class="formRight">
					<input type="text" class="jr_text" name="zd_concatus" id="zd_concatus" value="<%=CommonString.getFormatPara(model.get("concatus")) %>" />
				</div>
				<div style="clear:left;"></div>
				<div class="formLeft">邮<span class="span2">&nbsp;</span>箱</div>
				<div class="formRight">
					<input type="text" class="jr_text" name="zd_email" id="zd_email" value="<%=CommonString.getFormatPara(model.get("email")) %>" />
				</div>
                <div style="clear:left;"></div>
				<div class="formLeft">传<span class="span2">&nbsp;</span>真</div>
				<div class="formRight" style="width:200px;" >
					<input type="text"  style="width:200px;" class="jr_text" name="zd_fax" id="zd_fax" value="<%=CommonString.getFormatPara(model.get("fax")) %>" />
				</div>
				<div class="formLeft">地<span class="span2">&nbsp;</span>址</div>
				<div class="formRight" >
					<input type="text" style="width:250px;" class="jr_text" name="zd_address" id="zd_address" value="<%=CommonString.getFormatPara(model.get("address")) %>" />
				</div>
                <div style="clear:left;"></div>
				<div class="formLeft">销售QQ</div>
				<div class="formRight" style="width:200px;" >
					<input type="text"  style="width:200px;" class="jr_text" name="zd_saleqq" id="zd_saleqq" value="<%=CommonString.getFormatPara(model.get("saleqq")) %>" />
				</div>
				<div class="formLeft">服务QQ</div>
				<div class="formRight" >
					<input type="text" style="width:250px;" class="jr_text" name="zd_serviceqq" id="zd_serviceqq" value="<%=CommonString.getFormatPara(model.get("serviceqq")) %>" />
				</div>
				<div style="clear:left;"></div>
				<div class="formLeft">公司网址</div>
				<div class="formRight">
					<input type="text" class="jr_text" name="zd_url" id="zd_url" value="<%=CommonString.getFormatPara(model.get("url")) %>" />
				</div>
				<div style="clear:left;"></div>
				<div class="formLeft">公司LOGO</div>
				<div class="formRight" style="width:350px;" >
					<input type="text" class="jr_text" style="width:350px;"  name="zd_logo" id="zd_logo" value="<%=CommonString.getFormatPara(model.get("logo")) %>" />
				</div>
				<div class="formRight" style="position: relative; top:-2px;">
					<input style="float:right;" type="button" class="btn" onclick="chooseFile('zd_logo',700,480);" value="选择图片" />
					<a href="javascript:void(0);" class='highslide' onclick='return smallToBig(this,"zd_logo");'><input style="float:right; margin-right: 5px;" type="button" class="btn" value="预览" /></a>
				</div>
				<div style="clear:left;"></div>
			<div class="formLeft">公司简介</div>
	    <div class="formRight" style="height: 220px; text-align: left;"> 
	      <script type="text/plain" id="editor_introduce" style="width:650px; height:200px;"><%=CommonString.getFormatPara(model.get("introduce")) %></script>
	      <input type="hidden" name="zd_introduce" id="zd_introduce" value='' />
	    </div>
				<div style="clear:left;"></div>
				<div class="formLeft">代理地区</div>
				<div class="formRight">
					<input type="text" class="jr_text" name="zd_city" id="zd_city" value="<%=CommonString.getFormatPara(model.get("city")) %>" />
				</div>
				<div style="clear:left;"></div>
				<div class="formLeft">代理地区电话</div>
				<div class="formRight">
					<input type="text" class="jr_text" name="zd_city_tel" id="zd_city_tel" value="<%=CommonString.getFormatPara(model.get("city_tel")) %>" />
				</div>
					<div style="clear:left;"></div>
				<div class="formLeft">代理品牌</div>
				<div class="formRight">
					<input type="text" class="jr_text" style="width:150px;" name="zd_agent_fac_name" id="zd_agent_fac_name" value="<%=CommonString.getFormatPara(model.get("agent_fac_name")) %>" />
				</div>
                <div class="formRight">
                    <input type="text" class="jr_text" style="width:150px;" name="zd_agent_fac" id="zd_agent_fac" value="<%=CommonString.getFormatPara(model.get("agent_fac")) %>" />
				</div>
				<div style="">
				   	<select class="jr_select" id="factoryid" name="factoryid" onchange="changeValue();">
                    	<option value="">--请选择品牌--</option>
		  				<%if(brandList != null){for(Map m : brandList){%>
                        	<option value="<%=m.get("id")%>"><%=CnToFullSpell.getFullSpell(CommonString.getFormatPara(m.get("name")).substring(0,1)).toUpperCase().substring(0,1)%>-<%=m.get("name")%></option>
                        <%}}%>
		  			</select>
		  			</div>
				<div style="clear:left;"></div>
				<div class="formLeft">厂家图片</div>
				<div class="formRight">
					<input type="text" class="jr_text" style="width:350px;" name="zd_img1" id="zd_img1" value="<%=CommonString.getFormatPara(model.get("img1")) %>" />
				</div>
					<div class="formRight" style="padding-left: 220px; position: relative; top:-2px;">
					<input style="float:right;" type="button" class="btn" onclick="chooseFile('zd_img1',700,480);" value="选择图片" />
					<a href="javascript:void(0);" class='highslide' onclick='return smallToBig(this,"zd_img1");'><input style="float:right; margin-right: 5px;" type="button" class="btn" value="预览" /></a>
				</div>
				<div style="clear:left;"></div>
				<div class="formLeft">是否显示</div>
				<div class="formRight" style="width: 80px;">
					<%=CommonForm.createIsRadio(CommonString.getFormatPara(model.get("is_show")),"zd_is_show") %>
				</div>
				<div class="formLeft">级<span class="span2">&nbsp;</span>别</div>
				<div class="formRight" style="width: 130px;">
					<%
						String levelflag = CommonString.getFormatPara(model.get("levelflag"));
						if("".equals(levelflag)){
							levelflag = "0";
						}
					%>
					<%=CommonForm.createRadio(levelflagMap,levelflag,"zd_levelflag") %>
				</div>
				
				<div class="formLeft">是否为合作客户</div>
				<div class="formRight" style="width: 80px;">
					<%=CommonForm.createIsRadio(CommonString.getFormatPara(model.get("is_cooperate")).equals("")?"0":CommonString.getFormatPara(model.get("is_cooperate")),"zd_is_cooperate") %>
				</div>
				<div class="formRight" style="width: 130px;">
				<%
					if("1".equals(levelflag)){
						%><select name="zd_parent_id" id="zd_parent_id" style="width: 100%;"><%
					}else{
						%><select name="zd_parent_id" id="zd_parent_id" style="width: 100%;display: none;"><%
					}
				%>
						<option value="">--选择总代理--</option>
						<%=CommonForm.createSelect(dailiMap,CommonString.getFormatPara(model.get("parent_id"))) %>
					</select>
				</div>
				<div style="clear:left;"></div>
				<div class="group">
				<span>
			    <img src="/plugin/ui/ligerUI/ligerUI/skins/icons/communication.gif"/>
			     </span>
				<span class="groupTitle">旗舰店基本信息</span>
				</div>
				 <div class="formLeft">是否开通营销宝</div>
				<div class="formRight">
					<%
					 Map listMap = new TreeMap() ;
					listMap.put("0","否") ;
					listMap.put("1","免费版") ;
					listMap.put("2","基础版") ;
					listMap.put("3","高级版") ;
					%>
					<select class="jr_select" name="zd_is_shop" id="zd_is_shop">
					<%=CommonForm.createSelect(listMap,CommonString.getFormatPara(model.get("is_shop")).equals("")?"0":CommonString.getFormatPara(model.get("is_shop"))) %>
					</select>
				</div>
				<div class="formLeft">是否开通旗舰店</div>
				<div class="formRight">
					<select class="jr_select" name="zd_is_qijiandian" id="zd_is_qijiandian">
					<%
						Map selectMap = new TreeMap() ;
						selectMap.put("0","否") ;
						selectMap.put("1","模板一") ;
						selectMap.put("2","模板二") ;
						selectMap.put("3","模板三") ;
					%>
					<%=CommonForm.createSelect(selectMap,CommonString.getFormatPara(model.get("is_qijiandian")).equals("")?"0":CommonString.getFormatPara(model.get("is_qijiandian"))) %>
					</select>
				</div>
				<div style="clear:left;"></div>
				<div class="formLeft">是否定制</div>
				<div class="formRight">
					<%=CommonForm.createIsRadio(CommonString.getFormatPara(model.get("is_made")).equals("")?"0":CommonString.getFormatPara(model.get("is_made")),"zd_is_made")%>
				</div>
				<div class="formLeft">导入订单</div>
				<div class="formRight">
					<input type="button" name="导入" value="导入" <%if(total_import>0 &&(!CommonString.getFormatPara(model.get("is_shop")).equals("") || !CommonString.getFormatPara(model.get("is_shop")).equals("0"))){%>disabled="disabled"<%} %> onclick="imprt_order('<%=CommonString.getFormatPara(model.get("usern")) %>',this);"/>
				</div>
				<div style="clear:left;"></div>				
				<div class="formLeft">试用期增加</div>
				<div class="formRight">
					<input type="button" class="btn" value="增加试用期" onclick="addProbation();" />
				</div>
				<div class="formLeft">到期日期</div>
				<div class="formRight">
					<input type="text" style="width: 200px;" class="jr_text" readonly="readonly" name="zd_probation_date" id="zd_probation_date" value="<%=CommonString.getFormatPara(model.get("probation_date")) %>" />
				</div>
				<div style="clear:left;"></div>
				 <div class="formLeft">旗舰店副标题</div>
				<div class="formRight">
					<input type="text" class="jr_text" style="width:350px;" name="zd_sub_title" id="zd_sub_title" value="<%=CommonString.getFormatPara(model.get("sub_title")) %>" />
				</div>
				<div style="clear:left;"></div>
				<div class="formLeft">旗舰店Banner 图1</div>
				<div class="formRight">
					<input type="text" class="jr_text" style="width:350px;" name="zd_agentbanner" id="zd_agentbanner" value="<%=CommonString.getFormatPara(model.get("agentbanner")) %>" />
				</div>
					<div class="formRight" style="padding-left: 220px; position: relative; top:-2px;">
					<input style="float:right;" type="button" class="btn" onclick="chooseFile('zd_agentbanner',700,480);" value="选择图片" />
					<a href="javascript:void(0);" class='highslide' onclick='return smallToBig(this,"zd_agentbanner");'><input style="float:right; margin-right: 5px;" type="button" class="btn" value="预览" /></a>
				</div>
				<div style="clear:left;"></div>
				<div class="formLeft">旗舰店Banner 图2</div>
				<div class="formRight">
					<input type="text" class="jr_text" style="width:350px;" name="zd_agentbanner2" id="zd_agentbanner2" value="<%=CommonString.getFormatPara(model.get("agentbanner2")) %>" />
				</div>
					<div class="formRight" style="padding-left: 220px; position: relative; top:-2px;">
					<input style="float:right;" type="button" class="btn" onclick="chooseFile('zd_agentbanner2',700,480);" value="选择图片" />
					<a href="javascript:void(0);" class='highslide' onclick='return smallToBig(this,"zd_agentbanner2");'><input style="float:right; margin-right: 5px;" type="button" class="btn" value="预览" /></a>
				</div>
				<div style="clear:left;"></div>
				<div class="formLeft">旗舰店Banner 图3</div>
				<div class="formRight">
					<input type="text" class="jr_text" style="width:350px;" name="zd_agentbanner3" id="zd_agentbanner3" value="<%=CommonString.getFormatPara(model.get("agentbanner3")) %>" />
				</div>
					<div class="formRight" style="padding-left: 220px; position: relative; top:-2px;">
					<input style="float:right;" type="button" class="btn" onclick="chooseFile('zd_agentbanner3',700,480);" value="选择图片" />
					<a href="javascript:void(0);" class='highslide' onclick='return smallToBig(this,"zd_agentbanner3");'><input style="float:right; margin-right: 5px;" type="button" class="btn" value="预览" /></a>
				</div>
				<div style="clear:left;"></div>
				<div class="formLeft">是否显示订单</div>
				<div class="formRight">
					<%=CommonForm.createIsRadio(CommonString.getFormatPara(model.get("show_agent_order")).equals("")?"1":CommonString.getFormatPara(model.get("show_agent_order")),"zd_show_agent_order")%>
				</div> 
		  </div>
		 	<div class="group">
				<span>
			    <img src="/plugin/ui/ligerUI/ligerUI/skins/icons/communication.gif"/>
			     </span>
				<span class="groupTitle">旗舰店SEO</span>
				</div>
		  <div style="clear:left;"></div>
				<div class="formLeft">TITLE</div>
				<div class="formRight">
					<input type="text" class="jr_text" style="width:350px;" name="zd_seo_title" id="zd_seo_title" value="<%=CommonString.getFormatPara(model.get("seo_title")) %>" />
				</div>
		  <div style="clear:left;"></div>
				<div class="formLeft">KEYWORD</div>
				<div class="formRight">
					<input type="text" class="jr_text" style="width:350px;" name="zd_seo_keyword" id="zd_seo_keyword" value="<%=CommonString.getFormatPara(model.get("seo_keyword")) %>" />
				</div>
		  <div style="clear:left;"></div>
				<div class="formLeft">DESC</div>
				<div class="formRight">
					<input type="text" class="jr_text" style="width:350px;" name="zd_seo_desc" id="zd_seo_desc" value="<%=CommonString.getFormatPara(model.get("seo_desc")) %>" />
				</div>
			<div class="group">
				<span>
			    <img src="/plugin/ui/ligerUI/ligerUI/skins/icons/communication.gif"/>
			     </span>
				<span class="groupTitle">签订产品推荐合同</span>
				</div>
				<div style="clear: left;"></div>
				 <div class="formLeft">合同开始日期</div>
				<div class="formRight">
					<input type="text" style="width:150px;" onfocus="WdatePicker()" class="Wdate" name="zd_order_start_time" id="zd_order_start_time" value="<%=CommonString.getFormatPara(model.get("order_start_time")) %>" />
				</div>
			   <div class="formLeft">合同结束日期</div>
				<div class="formRight">
					<input type="text" style="width:150px;" onfocus="WdatePicker()" class="Wdate" name="zd_order_end_time" id="zd_order_end_time" value="<%=CommonString.getFormatPara(model.get("order_end_time")) %>" />
				</div> 
				<div style="clear: left;"></div>
				 <div class="formLeft">经度</div>
				<div class="formRight">
					<input type="text" style="width:150px;" class="jr_text" name="zd_lng" id="zd_lng" value="<%=CommonString.getFormatPara(model.get("lng")) %>" />
				</div>
			   <div class="formLeft">纬度</div>
				<div class="formRight">
					<input type="text" style="width:150px;" class="jr_text" name="zd_lat" id="zd_lat" value="<%=CommonString.getFormatPara(model.get("lat")) %>" />
				</div> 
	        	<div style="clear:left;"></div>
	    		  <div class="formLeft">开通产品订单推荐</div>
				 <div class="formRight">
					<%=CommonForm.createIsRadio(CommonString.getFormatPara(model.get("is_recommend_order")).equals("")?"0":CommonString.getFormatPara(model.get("is_recommend_order")),"zd_is_recommend_order") %>
				</div>
				<div class="group">
				<span>
			    <img src="/plugin/ui/ligerUI/ligerUI/skins/icons/communication.gif"/>
			     </span>
				<span class="groupTitle">扩展信息</span>
				</div>
				  <div style="clear:left;"></div>
						<div class="formLeft">最后修改日期</div>
						<div class="formRight">
							<input type="text" style="width:150px;" class="Wdate" name="last_modified_date" id="last_modified_date" value="<%=CommonString.getFormatPara(model.get("last_modified_date")) %>" readonly />
							<input type="hidden" name="zd_last_modified_date" id="zd_last_modified_date" value="<%=CommonDate.getToday("yyyy-MM-dd HH:mm:ss") %>" />
						</div>
				  <div style="clear:left;"></div>
		<input type="hidden" name="tableName" id="tableName" value="<%=tableName %>" />
		<input type="hidden" name="zd_id" id="zd_id" value="<%=CommonString.getFormatPara(model.get("id")) %>" />
		<input type="hidden" name="zd_flag" id="zd_flag" value="2"/>
		<input type="hidden" name="zd_agent_fac" id="zd_agent_fac" value="<%=CommonString.getFormatPara(model.get("agent_fac")) %>"/>
		<input type="hidden" name="zd_passw" id="zd_passw" value="1"/>
		<input type="hidden" name="is_shop_flag" id="is_shop_flag" value="<%=CommonString.getFormatPara(model.get("is_shop"))%>" />
		<input type="hidden" name="eventAfter" id="eventAfter" value="updateAdAreaAgent,open_mem_shop"/>
	</form>
  </body>
</html>
<script type="text/javascript" src="/plugin/jquery/jquery.form.js"></script>
<script src="/plugin/ui/ligerUI/ligerUI/js/ligerui.min.js" type="text/javascript"></script>
<script src="/backend/scripts/common.js" prefix="<%=tablePrefix %>" type="text/javascript"></script>
<script type="text/javascript" src="/plugin/other/highslide/highslide.min.js"></script>
<script src="/plugin/validator/wofoshan/validator.min.js" type="text/javascript"></script>
<script type="text/javascript">
   function checkRepeat(){
   	var username = document.getElementById('zd_usern').value; 
   	var id = document.getElementById('zd_id').value;    
	
   	jQuery.ajax({
		url:'/backend/action/ajax.jsp?flag=repeatName&username='+username+'&id='+id,
		async:false,
		cache:false,
		success:function(data){
			if($.trim(data)=="ok"){
			}else{
			      $.ligerDialog.warn('用户名重复');
			}
		}
	});	
   
   }
   

	function addProbation(){
		jQuery.post("/backend/action/ajax_cud.jsp",{
			flag : 'addProbation',
			id : '<%=id %>'
		},function(data){
			jQuery("#zd_probation_date").val(data);
		});
	}
	function changeValue(){
		var strs = jQuery("#factoryid option:selected").text() ; // 取得选择的品牌
		var ids = jQuery("#zd_agent_fac").val() ;
		var str = strs.substring(strs.indexOf('-')+1)
		var brand = jQuery("#zd_agent_fac_name").val() ;
		if(''!=jQuery.trim(brand)){
			jQuery("#zd_agent_fac_name").val(brand+","+str) ;
			jQuery("#zd_agent_fac").val(ids+","+jQuery("#factoryid").val()) ;
		}else{
		jQuery("#zd_agent_fac_name").val(str) ;
		jQuery("#zd_agent_fac").val(jQuery("#factoryid").val()) ;
		}
	}
	jQuery("input[name=zd_levelflag]").click(function(){
		if(this.value==1){
			jQuery("#zd_parent_id").show();
		}else{
			jQuery("#zd_parent_id").hide();
		}
	});
	function doSub(){
	//验证是否用户名重复
	var repeat = 0;
	var username = document.getElementById('zd_usern').value;    
	   	var id = document.getElementById('zd_id').value;    

	jQuery.ajax({
		url:'/backend/action/ajax.jsp?flag=repeatName&username='+username+'&id='+id,
		async:false,
		cache:false,
		success:function(data){
			if($.trim(data)=="ok"){
	             repeat=1;
			}else{
			     repeat=0;
			}
		}
	});	     
   if(repeat==0){
   		 $.ligerDialog.warn('用户名重复');
         return false;
    }	
	//验证是否用户名符合规则 
	var guifan = 0;
	jQuery.ajax({
		url:'/backend/action/ajax.jsp?flag=guifan&username='+username,
		async:false,
		cache:false,
		success:function(data){
			if($.trim(data)=="ok"){
	             guifan=1;
			}else{
			     guifan=0;
			}
		}
	});	     
   if(guifan==0){
   		 $.ligerDialog.warn('用户名格式错误,用户名只能为字母数字');
         return false;
    } 		 
		 
    //验证表单及提交
		var rs = Validator.Validate(document.getElementById("theform"),1);
		var result = 0 ;
		if(rs){
			jQuery("#theform").ajaxSubmit({
				type : "POST",
				async : false ,
				success : function(data) {
					var rs = parseInt(jQuery.trim(data), 10);
					result = rs ;
					if (rs > 0 ) {
						jrSuccess("保存成功！");
						<%
						if("".equals(id)){
							%>
						window.location.reload();
							<%
						}
						%>
					} 
				}
			});
		}
		
		
		if(result>0)
		{
		  return true ;
		}
	}
	var ue_introduce = new baidu.editor.ui.Editor({
    	textarea : 'zd_introduce',
    	autoHeightEnabled:false,
    	minFrameHeight:120
    });
    ue_introduce.render('editor_introduce');
    ue_introduce.addListener("selectionchange",function(){
	    var state_introduce = ue_introduce.queryCommandState("source");
	    document.getElementById("zd_introduce").value=ue_introduce.getContent();
	});
	document.getElementById("zd_introduce").value=ue_introduce.getContent();
	hs.graphicsDir = '/plugin/other/highslide/graphics/';
    hs.wrapperClassName = 'wide-border';
	function smallToBig(o,id){
	jQuery(o).attr("href","/uploadfiles/"+jQuery("#"+id).val());
	return hs.expand(o);
	}
	function imprt_order(agent_usern,obj){
		jQuery(obj).attr("disabled","disabled") ;
		jQuery.ajax({
			type:"post",
			url:'/tools/import_agent_order.jsp',
			data:{"usern":agent_usern},
			success:function(msg){
			  if(jQuery.trim(msg)=='ok'){
			  	jrSuccess("导入成功！") ;
			  }
			}
		}) ;
	}
	// 日期控件
// 	jQuery("#zd_order_start_time").ligerDateEditor({width:150});
</script><%
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		dbHelper.freeConnection(connection);
	}
%>