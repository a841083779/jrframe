<%@ page language="java" import="java.util.*,java.sql.*,com.jerehnet.util.dbutil.*,com.jerehnet.util.common.*" pageEncoding="UTF-8"%><%
	Connection connection = null;
	String tablePrefix = Env.getInstance().getProperty("table_prefix");
	DBHelper dbHelper = DBHelper.getInstance();
	Map model = new HashMap();
	String tableName = "pro_charge_members";
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
	//	List <Map> brandList = (ArrayList)application.getAttribute("brandList");
		List<Map> brandList = (ArrayList)dbHelper.getMapList(" select name,id from pro_agent_factory order by name asc") ;
		List <Map> catalogAppList = (ArrayList<Map>)application.getAttribute("catalogList");
		List <Map> catalogList = CommonApplication.getTreeByPno("0", catalogAppList , "parentid","id");
		Map membercategoryMap = new HashMap() ;
		membercategoryMap.put("列表推荐","列表推荐") ;
		membercategoryMap.put("订单推荐","订单推荐") ;
%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <title><%=Env.getInstance().getProperty("project_name") %></title>
	<link href="/plugin/ui/ligerUI/ligerUI/skins/Aqua/css/ligerui-all.css" rel="stylesheet" type="text/css" />
	<link href="/plugin/ui/ligerUI/ligerUI/skins/Gray/css/all.css" rel="stylesheet" type="text/css" />
	<link href="/plugin/ui/ligerUI/ligerUI/skins/ligerui-icons.css" rel="stylesheet" type="text/css" />
	<link href="/backend/style/style.css" rel="stylesheet" type="text/css" />
	<script src="/plugin/jquery/jquery.min.js" type="text/javascript"></script>
  </head>
  <body style="margin: 0;padding: 0; overflow-x: hidden; ">
	<form name="theform" id="theform" action="/backend/action/crud.jsp">
			<div class="group"> <span><img src="/plugin/ui/ligerUI/ligerUI/skins/icons/communication.gif"/>
		</span> 
		<span class="groupTitle">会员信息</span> </div>
		<div class="formDiv">
				<div class="formLeft">日<span class="span2">&nbsp;</span>期</div>
				<div class="formRight"><input type="text" name="zd_pub_date" id="zd_pub_date" value=""/></div>
				<div style="clear:left;"></div>
				<div class="formLeft">会员名字</div>
				<div class="formRight">
				<input type="text" class="jr_text" style="width:160px;" value="<%=CommonString.getFormatPara(model.get("factoryname")) %>" readonly="readonly" id="zd_factoryname" name="zd_factoryname"/>
				<input type="hidden" name="zd_factoryid" id="zd_factoryid" value="<%=CommonString.getFormatPara(model.get("factoryid")) %>" />
				</div>
				<div style="float:left;margin-top:5px;margin-left:5px;">
				<select class="jr_select" name="factoryname_sel" id="factoryname_sel">
				<option value="">--请选择品牌--</option>
		  				<%if(brandList != null){for(Map m : brandList){%>
                        	<option value="<%=m.get("id")%>"><%=CnToFullSpell.getFullSpell(CommonString.getFormatPara(m.get("name")).substring(0,1)).toUpperCase().substring(0,1)%>-<%=m.get("name")%></option>
                <%}}%>
				</select>
				</div>
				<div style="clear:left;"></div>
				<div class="formLeft">购买地区</div>
				<div class="formRight">
					<input type="text" name="zd_address" id="zd_address" class="jr_text" style="width:160px;" value="<%=CommonString.getFormatPara(model.get("address")) %>" readonly="readonly"/>
				</div>
				<div style="float:left;margin-top:5px;margin-left:5px;">
					<select class="jr_select" name="address_sel" id="address_sel" onchange="selectAddress(this)">
						 <option value="">--重置--</option>
						  <option value="安徽">安徽</option>
				          <option value="北京">北京</option>
				          <option value="重庆">重庆</option>
				          <option value="福建">福建</option>
				          <option value="甘肃">甘肃</option>
				          <option value="广东">广东</option>
				          <option value="广西">广西</option>
				          <option value="贵州">贵州</option>
				          <option value="海南">海南</option>
				          <option value="河北">河北</option>
				          <option value="黑龙江">黑龙江</option>
				          <option value="河南">河南</option>
				          <option value="湖北">湖北</option>
				          <option value="湖南">湖南</option>
				          <option value="内蒙古">内蒙古</option>
				          <option value="江苏">江苏</option>
				          <option value="江西">江西</option>
				          <option value="吉林">吉林</option>
				          <option value="辽宁">辽宁</option>
				          <option value="宁夏">宁夏</option>
				          <option value="青海">青海</option>
				          <option value="山西">山西</option>
				          <option value="山东">山东</option>
				          <option value="上海">上海</option>
				          <option value="四川">四川</option>
				          <option value="天津">天津</option>
				          <option value="西藏">西藏</option>
				          <option value="新疆">新疆</option>
				          <option value="云南">云南</option>
				          <option value="浙江">浙江</option>
				          <option value="陕西">陕西</option>
				          <option value="台湾">台湾</option>
				          <option value="香港">香港</option>
				          <option value="澳门">澳门</option>
				          <option value="海外">海外</option>
					</select>
				</div>
				<div style="clear:left;"></div>
				<div class="formLeft">类别名字</div>
				<div class="formRight">
					<input type="text" class="jr_text" style="width:160px;" name="zd_catalogname" id="zd_catalogname" value="<%=CommonString.getFormatPara(model.get("catalogname")) %>" readonly="readonly"/>
					<input type="hidden" name="zd_catalognum" id="zd_catalognum" />
				</div>
				<div style="float:left;margin-top:5px;margin-left:5px;">
					<select class="jr_select" name="catalogname_sel" id="catalogname_sel">
				      	<option value="">--重置--</option>
		  				<%if(catalogList != null){for(Map m : catalogList){%>
                        	<option value="<%=m.get("num")%>"><%=CommonForm.getSpace(m.get("num").toString(),1)%><%=m.get("name")%></option>
                        <%}}%>
					</select>
				</div>
				<div style="clear:left;"></div>
				<div class="formLeft">会员类别</div>
				<div class="formRight"><%=CommonForm.createCheckbox(membercategoryMap,CommonString.getFormatPara(model.get("membercategory")),"zd_membercategory") %></div>
		</div>
		<div style="clear: left;"></div>
		<input type="hidden" name="tableName" id="tableName" value="<%=tableName %>" />
		<input type="hidden" name="zd_id" id="zd_id" value="<%=CommonString.getFormatPara(model.get("id")) %>" />
	</form>
  </body>
</html>
<script type="text/javascript" src="/plugin/jquery/jquery.form.js"></script>
<script src="/plugin/ui/ligerUI/ligerUI/js/ligerui.min.js" type="text/javascript"></script>
<script src="/backend/scripts/common.js" prefix="<%=tablePrefix %>" type="text/javascript"></script>
<script src="/plugin/validator/wofoshan/validator.min.js" type="text/javascript"></script>
<script type="text/javascript">
	jQuery(function(){
		jQuery("#address_sel option").each(function(){  // 地区
			if(jQuery.trim(jQuery(this).text())=='<%=CommonString.getFormatPara(model.get("address"))%>'){
				jQuery(this).attr("selected","selected") ;
			}
		}) ;
		jQuery("#factoryname_sel option").each(function(){	  // 品牌
			if(jQuery.trim(jQuery(this).text()).indexOf(jQuery("#zd_factoryname").val())!=-1){
				jQuery(this).attr("selected","selected") ;
			}
		}) ;
	}) ;
	function doSub(){
		var rs = Validator.Validate(document.getElementById("theform"),1);
		if(rs){
			jQuery("#theform").ajaxSubmit({
				type : "POST",
				async : false ,
				success : function(data) {
					var rs = parseInt(jQuery.trim(data), 10);
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
	}
	jQuery("#factoryname_sel").change(function(){
		var index = jQuery(this).get(0).selectedIndex ;
		if(jQuery.trim(jQuery(this).get(0).options[index].value)!=''){
			jQuery("#zd_factoryname").val(jQuery(this).get(0).options[index].text.substring(2)) ;
			jQuery("#zd_factoryid").val(jQuery(this).get(0).options[index].value) ;
		}
	}) ;
	function selectAddress(obj){
	 var value = jQuery("#zd_address").val()==''?'':jQuery("#zd_address").val()+"," ;
		var index = jQuery(obj).get(0).selectedIndex ;
		if(jQuery.trim(jQuery(obj).get(0).options[index].value)!=''){
			jQuery("#zd_address").val(value+jQuery(obj).get(0).options[index].text) ;
		}else{
			jQuery("#zd_address").val('') ;
		}
	}
	jQuery("#catalogname_sel").change(function(){	
	  var index = jQuery(this).get(0).selectedIndex ;
	  var value = jQuery.trim(jQuery("#zd_catalogname").val())==''?'':jQuery.trim(jQuery("#zd_catalogname").val())+',' ;
	  var numValue = jQuery.trim(jQuery("#zd_catalognum").val())==''?'':jQuery.trim(jQuery("#zd_catalognum").val())+',' ;
		if(jQuery.trim(jQuery(this).get(0).options[index].value)!=''){
			jQuery("#zd_catalogname").val(value+jQuery.trim(jQuery(this).get(0).options[index].text)) ;
			jQuery("#zd_catalognum").val(numValue+jQuery(this).get(0).options[index].value) ;
		}else{
			jQuery("#zd_catalogname").val('') ;
			jQuery("#zd_catalognum").val('') ;
		}
	}) ;
	jQuery("#zd_pub_date").ligerDateEditor({width:150});
	jQuery("#zd_pub_date").val('<%=CommonDate.getFormatDate("yyyy-MM-dd",model.get("pub_date"))%>') ;
</script><%
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		dbHelper.freeConnection(connection);
	}
%>