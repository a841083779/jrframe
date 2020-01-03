<%@ page language="java"
	import="java.util.*,java.sql.*,com.jerehnet.util.dbutil.*,com.jerehnet.util.common.*"
	pageEncoding="UTF-8"%>
<%
		Connection connection = null;
	    DBHelper dbHelper = DBHelper.getInstance();
		String tablePrefix = Env.getInstance().getProperty("table_prefix");
		String uuid = CommonString.getFormatPara(request.getParameter("uuid"));
        
		try {
				Map model = null;
		        connection = dbHelper.getConnection();
				Map formMap = dbHelper.getMap(" select factoryname,factoryid,cataname,product_name,product_id,message,catanum from pro_product_form where uuid = ? ",new Object [] {uuid},connection);
				List<Map> proList= (ArrayList)(dbHelper.getMapList(" select id,name from pro_products where factoryid =  "+CommonString.getFormatPara(formMap.get("factoryid")),connection));
				List<Map> agentList=(ArrayList)(dbHelper.getMapList(" select id,name from pro_agent_factory where is_cooperate = 1  or id=16859    order by name asc",connection));
		     	List<Map> brandList = (ArrayList)application.getAttribute("brandList") ;
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title><%=Env.getInstance().getProperty("project_name") %></title>
<link href="/plugin/ui/ligerUI/ligerUI/skins/Aqua/css/ligerui-all.css" rel="stylesheet" type="text/css" />
<link href="/plugin/ui/ligerUI/ligerUI/skins/Gray/css/all.css" rel="stylesheet" type="text/css" />
<link href="/plugin/ui/ligerUI/ligerUI/skins/ligerui-icons.css" rel="stylesheet" type="text/css" />
<link href="/backend/style/style.css" rel="stylesheet" type="text/css" />
<script src="/plugin/jquery/jquery.min.js" type="text/javascript"></script>
</head>
<body style="margin: 0; padding: 0; overflow-x: hidden;">
<form name="theform" id="theform" action="/backend/action/after_own.jsp">
  <div class="formDiv">
    <div class="group"> <span> <img src="/plugin/ui/ligerUI/ligerUI/skins/icons/communication.gif" /> </span> <span class="groupTitle">订单推送</span> </div>
    <!--第一个-->
    <div class="formLeft" style="width:60px;"> 合作客户1 </div>
    <div class="formRight" style="width:140px; ">
      <select name="factory_id" id="factory_id" class="jr_select" style="width: 140px;">
        <option value="">-请选择-</option>
         <!--<option value="16137">中远投资</option>
       <option value="282">广西松宇</option>-->
        <%if(agentList != null){for(Map m : agentList){%>
        <option value="<%=m.get("id")%>"><%=m.get("name")%></option>
        <%}}%>
      </select>
    </div>
    <div class="formLeft"  style="width:60px;"> 所属厂家 </div>
    <div class="formRight" style="width: 100px">
      <input style="width: 100px" type="hidden" class="jr_text" name="company_name" id="company_name" value="<%=CommonString.getFormatPara(formMap.get("factoryname")) %>" />
      <select name="brand_id" id="brand_id" class="jr_select" style="width: 100px;" onchange="document.getElementById('company_name').value=options[selectedIndex].text">
        <option value="">-请选择-</option>
        <% 
				String facId=CommonString.getFormatPara(formMap.get("factoryid"));
				if(brandList != null){for(Map m : brandList){ 
				%>
        <option value="<%=m.get("id")%>" <%if(facId.equals(Integer.toString((Integer)m.get("id")))){%> selected="selected" <%}%> ><%=m.get("name")%></option>
        <%}}%>
      </select>
    </div>
    <div class="formLeft" style="width:60px;"> 所属分类 </div>
    <div class="formRight" style="width: 100px">
      <input style="width: 100px" type="text" readonly="readonly" class="jr_text" name="cata_name" id="cata_name" value="<%=CommonString.getFormatPara(formMap.get("cataname")) %>" />
    </div>
    <div class="formLeft" style="width:60px;"> 产品型号 </div>
    <div class="formRight" style="width: 100px">
      <input style="width: 100px" type="hidden" class="jr_text" name="pro_name" id="pro_name" value="<%=CommonString.getFormatPara(formMap.get("product_name")) %>" />
      <select name="pro_id" id="pro_id" class="jr_select" style="width: 100px;" onchange="document.getElementById('pro_name').value=options[selectedIndex].text">
        <option value="">-请选择-</option>
        <% 
				String proId=CommonString.getFormatPara(formMap.get("product_id"));
				if(proList != null){for(Map m : proList){ 
				%>
        <option value="<%=m.get("id")%>" <%if(proId.equals(Integer.toString((Integer)m.get("id")))){%> selected="selected" <%}%> ><%=m.get("name")%></option>
        <%}}%>
      </select>
    </div>
    <div class="formLeft" style="width:60px;"> 留言内容 </div>
    <div class="formRight" style="width: 170px">
      <input style="width: 170px" type="text" class="jr_text" name="jr_message" id="jr_message" value="<%=CommonString.getFormatPara(formMap.get("message")).equals("")?"我对该产品感兴趣，请联系我":CommonString.getFormatPara(formMap.get("message")) %>" />
    </div>
    <div style="clear: left;"></div>
    <div class="formLeft" style="width:60px;"> 合作客户2 </div>
    <div class="formRight" style="width:140px; ">
      <select name="factory_id2" id="factory_id2" class="jr_select" style="width: 140px;">
        <option value="">-请选择-</option>
         <!--<option value="16137">中远投资</option>
       <option value="282">广西松宇</option>-->
        <%if(agentList != null){for(Map m : agentList){%>
        <option value="<%=m.get("id")%>"><%=m.get("name")%></option>
        <%}}%>
      </select>
    </div>
    <div class="formLeft"  style="width:60px;"> 所属厂家 </div>
    <div class="formRight" style="width: 100px">
      <input style="width: 100px" type="hidden" class="jr_text" name="company_name2" id="company_name2" value="<%=CommonString.getFormatPara(formMap.get("factoryname")) %>" />
      <select name="brand_id2" id="brand_id2" class="jr_select" style="width: 100px;" onchange="document.getElementById('company_name2').value=options[selectedIndex].text">
        <option value="">-请选择-</option>
        <% 
				if(brandList != null){for(Map m : brandList){ 
				%>
        <option value="<%=m.get("id")%>" <%if(facId.equals(Integer.toString((Integer)m.get("id")))){%> selected="selected" <%}%> ><%=m.get("name")%></option>
        <%}}%>
      </select>
    </div>
    <div class="formLeft" style="width:60px;"> 所属分类 </div>
    <div class="formRight" style="width: 100px">
      <input style="width: 100px" type="text" readonly="readonly" class="jr_text" name="cata_name2" id="cata_name2" value="<%=CommonString.getFormatPara(formMap.get("cataname")) %>" />
    </div>
    <div class="formLeft" style="width:60px;"> 产品型号 </div>
    <div class="formRight" style="width: 100px">
      <input style="width: 100px" type="hidden" class="jr_text" name="pro_name2" id="pro_name2" value="<%=CommonString.getFormatPara(formMap.get("product_name")) %>" />
      <select name="pro_id2" id="pro_id2" class="jr_select" style="width: 100px;" onchange="document.getElementById('pro_name2').value=options[selectedIndex].text">
        <option value="">-请选择-</option>
        <% 
			if(proList != null){for(Map m : proList){ 
		%>
        <option value="<%=m.get("id")%>" <%if(proId.equals(Integer.toString((Integer)m.get("id")))){%> selected="selected" <%}%> ><%=m.get("name")%></option>
        <%}}%>
      </select>
    </div>
    <div class="formLeft" style="width:60px;"> 留言内容 </div>
    <div class="formRight" style="width: 170px">
      <input style="width: 170px" type="text" class="jr_text" name="jr_message2" id="jr_message2" value="<%=CommonString.getFormatPara(formMap.get("message")).equals("")?"我对该产品感兴趣，请联系我":CommonString.getFormatPara(formMap.get("message")) %>" />
    </div>
    <div style="clear: left;"></div>
    <!--第二个-->
    <div class="formLeft" style="width:60px;"> 合作客户3 </div>
    <div class="formRight" style="width:140px; ">
      <select name="factory_id3" id="factory_id3" class="jr_select" style="width: 140px;">
        <option value="">-请选择-</option>
       <!-- <option value="16137">中远投资</option>
        <option value="282">广西松宇</option>-->
        <%if(agentList != null){for(Map m : agentList){%>
        <option value="<%=m.get("id")%>"><%=m.get("name")%></option>
        <%}}%>
      </select>
    </div>
    <div class="formLeft"  style="width:60px;"> 所属厂家 </div>
    <div class="formRight" style="width: 100px">
      <input style="width: 100px" type="hidden" class="jr_text" name="company_name3" id="company_name3" value="<%=CommonString.getFormatPara(formMap.get("factoryname")) %>" />
      <select name="brand_id3" id="brand_id3" class="jr_select" style="width: 100px;" onchange="document.getElementById('company_name3').value=options[selectedIndex].text">
        <option value="">-请选择-</option>
        <% 
				if(brandList != null){for(Map m : brandList){ 
				%>
        <option value="<%=m.get("id")%>" <%if(facId.equals(Integer.toString((Integer)m.get("id")))){%> selected="selected" <%}%> ><%=m.get("name")%></option>
        <%}}%>
      </select>
    </div>
    <div class="formLeft" style="width:60px;"> 所属分类 </div>
    <div class="formRight" style="width: 100px">
      <input style="width: 100px" type="text" readonly="readonly" class="jr_text" name="cata_name3" id="cata_name3" value="<%=CommonString.getFormatPara(formMap.get("cataname")) %>" />
    </div>
    <div class="formLeft" style="width:60px;"> 产品型号 </div>
    <div class="formRight" style="width: 100px">
      <input style="width: 100px" type="hidden" class="jr_text" name="pro_name3" id="pro_name3" value="<%=CommonString.getFormatPara(formMap.get("product_name")) %>" />
      <select name="pro_id3" id="pro_id3" class="jr_select" style="width: 100px;" onchange="document.getElementById('pro_name3').value=options[selectedIndex].text">
        <option value="">-请选择-</option>
        <% 
				if(proList != null){for(Map m : proList){ 
		%>
        <option value="<%=m.get("id")%>" <%if(proId.equals(Integer.toString((Integer)m.get("id")))){%> selected="selected" <%}%> ><%=m.get("name")%></option>
        <%}}%>
      </select>
    </div>
    <div class="formLeft" style="width:60px;"> 留言内容 </div>
    <div class="formRight" style="width: 170px">
      <input style="width: 170px" type="text" class="jr_text" name="jr_message3" id="jr_message3" value="<%=CommonString.getFormatPara(formMap.get("message")).equals("")?"我对该产品感兴趣，请联系我":CommonString.getFormatPara(formMap.get("message")) %>" />
    </div>
    <div style="clear: left;"></div>
    <!--第三个-->
    <div class="formLeft" style="width:60px;"> 合作客户4 </div>
    <div class="formRight" style="width:140px; ">
      <select name="factory_id4" id="factory_id4" class="jr_select" style="width: 140px;">
        <option value="">-请选择-</option>
        <!--<option value="16137">中远投资</option>
        <option value="282">广西松宇</option>-->
        <%if(agentList != null){for(Map m : agentList){%>
        <option value="<%=m.get("id")%>"><%=m.get("name")%></option>
        <%}}%>
      </select>
    </div>
    <div class="formLeft"  style="width:60px;"> 所属厂家 </div>
    <div class="formRight" style="width: 100px">
      <input style="width: 100px" type="hidden" class="jr_text" name="company_name4" id="company_name4" value="<%=CommonString.getFormatPara(formMap.get("factoryname")) %>" />
      <select name="brand_id4" id="brand_id4" class="jr_select" style="width: 100px;" onchange="document.getElementById('company_name4').value=options[selectedIndex].text">
        <option value="">-请选择-</option>
        <%  if(brandList != null){for(Map m : brandList){  %>
        <option value="<%=m.get("id")%>" <%if(facId.equals(Integer.toString((Integer)m.get("id")))){%> selected="selected" <%}%> ><%=m.get("name")%></option>
        <%}}%>
      </select>
    </div>
    <div class="formLeft" style="width:60px;"> 所属分类 </div>
    <div class="formRight" style="width: 100px">
      <input style="width: 100px" type="text" readonly="readonly" class="jr_text" name="cata_name4" id="cata_name4" value="<%=CommonString.getFormatPara(formMap.get("cataname")) %>" />
    </div>
    <div class="formLeft" style="width:60px;"> 产品型号 </div>
    <div class="formRight" style="width: 100px">
      <input style="width: 100px" type="hidden" class="jr_text" name="pro_name4" id="pro_name4" value="<%=CommonString.getFormatPara(formMap.get("product_name")) %>" />
      <select name="pro_id4" id="pro_id4" class="jr_select" style="width: 100px;" onchange="document.getElementById('pro_name4').value=options[selectedIndex].text">
        <option value="">-请选择-</option>
        <% if(proList != null){for(Map m : proList){ %>
        <option value="<%=m.get("id")%>" <%if(proId.equals(Integer.toString((Integer)m.get("id")))){%> selected="selected" <%}%> ><%=m.get("name")%></option>
        <%}}%>
      </select>
    </div>
    <div class="formLeft" style="width:60px;"> 留言内容 </div>
    <div class="formRight" style="width: 170px">
      <input style="width: 170px" type="text" class="jr_text" name="jr_message4" id="jr_message4" value="<%=CommonString.getFormatPara(formMap.get("message")).equals("")?"我对该产品感兴趣，请联系我":CommonString.getFormatPara(formMap.get("message")) %>" />
    </div>
    <div style="clear: left;"></div>
    <!--第四个-->
    <div class="formLeft" style="width:60px;"> 合作客户5 </div>
    <div class="formRight" style="width:140px; ">
      <select name="factory_id5" id="factory_id5" class="jr_select" style="width: 140px;">
        <option value="">-请选择-</option>
        <!-- <option value="16137">中远投资</option>
       <option value="282">广西松宇</option>-->
        <%if(agentList != null){for(Map m : agentList){%>
        <option value="<%=m.get("id")%>"><%=m.get("name")%></option>
        <%}}%>
      </select>
    </div>
    <div class="formLeft"  style="width:60px;"> 所属厂家 </div>
    <div class="formRight" style="width: 100px">
      <input style="width: 100px" type="hidden" class="jr_text" name="company_name5" id="company_name5" value="<%=CommonString.getFormatPara(formMap.get("factoryname")) %>" />
      <select name="brand_id5" id="brand_id5" class="jr_select" style="width: 100px;" onchange="document.getElementById('company_name5').value=options[selectedIndex].text">
        <option value="">-请选择-</option>
        <%  if(brandList != null){for(Map m : brandList){  %>
        <option value="<%=m.get("id")%>" <%if(facId.equals(Integer.toString((Integer)m.get("id")))){%> selected="selected" <%}%> ><%=m.get("name")%></option>
        <%}}%>
      </select>
    </div>
    <div class="formLeft" style="width:60px;"> 所属分类 </div>
    <div class="formRight" style="width: 100px">
      <input style="width: 100px" type="text" readonly="readonly" class="jr_text" name="cata_name5" id="cata_name5" value="<%=CommonString.getFormatPara(formMap.get("cataname")) %>" />
    </div>
    <div class="formLeft" style="width:60px;"> 产品型号 </div>
    <div class="formRight" style="width: 100px">
      <input style="width: 100px" type="hidden" class="jr_text" name="pro_name5" id="pro_name5" value="<%=CommonString.getFormatPara(formMap.get("product_name")) %>" />
      <select name="pro_id5" id="pro_id5" class="jr_select" style="width: 100px;" onchange="document.getElementById('pro_name5').value=options[selectedIndex].text">
        <option value="">-请选择-</option>
        <%  if(proList != null){for(Map m : proList){ %>
        <option value="<%=m.get("id")%>" <%if(proId.equals(Integer.toString((Integer)m.get("id")))){%> selected="selected" <%}%> ><%=m.get("name")%></option>
        <%}}%>
      </select>
    </div>
    <div class="formLeft" style="width:60px;"> 留言内容 </div>
    <div class="formRight" style="width: 170px">
      <input style="width: 170px" type="text" class="jr_text" name="jr_message5" id="jr_message5" value="<%=CommonString.getFormatPara(formMap.get("message")).equals("")?"我对该产品感兴趣，请联系我":CommonString.getFormatPara(formMap.get("message")) %>" />
    </div>
    <div style="clear: left;"></div>
  
	
	
	
  </div>
  <input type="hidden" name="pro_uuid" id="pro_uuid" value="<%=uuid %>" />
  <input type="hidden" name="eventAfter" id="eventAfter" value="updateAgentFormsss,updateOrderForm" />
  <input type="hidden" name="tableName" id="tableName" value="pro_product_form" />
</form>
</body>
</html>
<script type="text/javascript" src="/plugin/jquery/jquery.form.js"></script>
<script src="/plugin/ui/ligerUI/ligerUI/js/ligerui.min.js" type="text/javascript"></script>
<script src="/backend/scripts/common.js" type="text/javascript"></script>
<script src="/plugin/validator/wofoshan/validator.min.js" type="text/javascript"></script>
<script type="text/javascript">
	function doSub(){
		//var rs = Validator.Validate(document.getElementById("theform"),1);
		var rs=1;
		if(rs){
			jQuery("#theform").ajaxSubmit({
				type : "POST",
				async : false ,
				success : function(data) {
						jrSuccess("发送成功！");			
				}
			});
		}
	}
</script>
<script type="text/javascript" language="javascript">
   //选择合作客户加载合作客户品牌   
   jQuery(function(){
		jQuery("#factory_id").change(function(){
		    var factoryId=this.value;
			jQuery.post("/backend/action/ajax_r.jsp",{'factoryId':factoryId,'flag':'getBrand'},function(data){
			   $("#brand_id").html(jQuery.trim(data));
			    $("#pro_name").val('');
			});
		});
	});
	//选择品牌加载该品牌的产品
	jQuery(function(){
		jQuery("#brand_id").change(function(){
		     var brandId=this.value;
			 jQuery.post("/backend/action/ajax_r.jsp",{'brandId':brandId,catalognum:<%=CommonString.getFormatPara(formMap.get("catanum")) %>,'flag':'getPro'},function(data){
				$("#pro_id").html(jQuery.trim(data));
			 });
		});
	});
	
	
	//选择合作客户加载合作客户品牌   
   jQuery(function(){
		jQuery("#factory_id2").change(function(){
		    var factoryId=this.value;
			jQuery.post("/backend/action/ajax_r.jsp",{'factoryId':factoryId,'flag':'getBrand'},function(data){
			   	$("#brand_id2").html(jQuery.trim(data));
				 $("#pro_name2").val('');
			});
		});
	});
	//选择品牌加载该品牌的产品
	jQuery(function(){
		jQuery("#brand_id2").change(function(){
		     var brandId=this.value;
			 jQuery.post("/backend/action/ajax_r.jsp",{'brandId':brandId,catalognum:<%=CommonString.getFormatPara(formMap.get("catanum")) %>,'flag':'getPro'},function(data){
				$("#pro_id2").html(jQuery.trim(data));
			 });
		});
	});
	
   //选择合作客户加载合作客户品牌   
   jQuery(function(){
		jQuery("#factory_id3").change(function(){
		    var factoryId=this.value;
			jQuery.post("/backend/action/ajax_r.jsp",{'factoryId':factoryId,'flag':'getBrand'},function(data){
			   $("#brand_id3").html(jQuery.trim(data));
			    $("#pro_name3").val('');
			});
		});
	});
	//选择品牌加载该品牌的产品
	jQuery(function(){
		jQuery("#brand_id3").change(function(){
		     var brandId=this.value;
			 jQuery.post("/backend/action/ajax_r.jsp",{'brandId':brandId,catalognum:<%=CommonString.getFormatPara(formMap.get("catanum")) %>,'flag':'getPro'},function(data){
				$("#pro_id3").html(jQuery.trim(data));
			 });
		});
	});
	
	//选择合作客户加载合作客户品牌   
   jQuery(function(){
		jQuery("#factory_id4").change(function(){
		    var factoryId=this.value;
			jQuery.post("/backend/action/ajax_r.jsp",{'factoryId':factoryId,'flag':'getBrand'},function(data){
			   $("#brand_id4").html(jQuery.trim(data));
			   $("#pro_name4").val('');
			});
		});
	});
	//选择品牌加载该品牌的产品
	jQuery(function(){
		jQuery("#brand_id4").change(function(){
		     var brandId=this.value;
			 jQuery.post("/backend/action/ajax_r.jsp",{'brandId':brandId,catalognum:<%=CommonString.getFormatPara(formMap.get("catanum")) %>,'flag':'getPro'},function(data){
				$("#pro_id4").html(jQuery.trim(data));
			 });
		});
	});
	
	
	//选择合作客户加载合作客户品牌   
   jQuery(function(){
		jQuery("#factory_id5").change(function(){
		    var factoryId=this.value;
			jQuery.post("/backend/action/ajax_r.jsp",{'factoryId':factoryId,'flag':'getBrand'},function(data){
			   $("#brand_id5").html(jQuery.trim(data));
               $("#pro_name5").val('');
			});
		});
	});
	//选择品牌加载该品牌的产品
	jQuery(function(){
		jQuery("#brand_id5").change(function(){
		     var brandId=this.value;
			 jQuery.post("/backend/action/ajax_r.jsp",{'brandId':brandId,catalognum:<%=CommonString.getFormatPara(formMap.get("catanum")) %>,'flag':'getPro'},function(data){
				$("#pro_id5").html(jQuery.trim(data));

			 });
		});
	});
	

    </script>
<%
	} catch (Exception e) {
		e.printStackTrace();
	} finally {
		dbHelper.freeConnection(connection);
	}
%>