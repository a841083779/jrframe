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
				Map formMap = dbHelper.getMap(" select * from pro_product_form where uuid = ? ",new Object [] {uuid},connection);
				List<Map> proList= (ArrayList)(dbHelper.getMapList(" select * from pro_products where factoryid =  "+CommonString.getFormatPara(formMap.get("factoryid")),connection));
				List<Map> agentList=(ArrayList)(dbHelper.getMapList(" select * from pro_agent_factory where is_cooperate = 1 order by name asc",connection));
		     	List<Map> brandList = (ArrayList)application.getAttribute("brandList") ;
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title><%=Env.getInstance().getProperty("project_name") %></title>
<link href="/plugin/ui/ligerUI/ligerUI/skins/Aqua/css/ligerui-all.css"
			rel="stylesheet" type="text/css" />
<link href="/plugin/ui/ligerUI/ligerUI/skins/Gray/css/all.css"
			rel="stylesheet" type="text/css" />
<link href="/plugin/ui/ligerUI/ligerUI/skins/ligerui-icons.css"
			rel="stylesheet" type="text/css" />
<link href="/backend/style/style.css" rel="stylesheet" type="text/css" />
<script src="/plugin/jquery/jquery.min.js" type="text/javascript"></script>
</head>
<body style="margin: 0; padding: 0; overflow-x: hidden;">
<form name="theform" id="theform" action="/backend/action/after_own.jsp">

  <div class="formDiv">
    <div class="group"> <span> <img src="/plugin/ui/ligerUI/ligerUI/skins/icons/communication.gif" /> </span> <span class="groupTitle">订单推送</span> </div>
    <div class="formLeft"> 合作客户 </div>
    <div class="formRight" style="width:300px; ">
	  <select name="factory_id" id="factory_id" class="jr_select" style="width: 300px;">
		  		 <option value="">-请选择-</option>
		  		<%if(agentList != null){for(Map m : agentList){%>
                        	<option value="<%=m.get("id")%>"><%=m.get("name")%></option>
                <%}}%>
	   </select>
    </div>
    <div style="clear: left;"></div>
    <div style="clear: left;"></div>
    <div class="formLeft"> 所属厂家 </div>
    <div class="formRight" style="width: 300px">
      <input style="width: 300px" type="hidden" class="jr_text" name="company_name" id="company_name" value="<%=CommonString.getFormatPara(formMap.get("factoryname")) %>" />
	  	  <select name="brand_id" id="brand_id" class="jr_select" style="width: 300px;" onchange="document.getElementById('company_name').value=options[selectedIndex].text">
		  		 <option value="">-请选择-</option>
		  		<% 
				String facId=CommonString.getFormatPara(formMap.get("factoryid"));
				if(brandList != null){for(Map m : brandList){ 
				%>
                      <option value="<%=m.get("id")%>" <%if(facId.equals(Integer.toString((Integer)m.get("id")))){%> selected="selected" <%}%> ><%=m.get("name")%></option>
                <%}}%>			
	      </select>
    </div>
    <div style="clear: left;"></div>
    <div class="formLeft"> 所属分类 </div>
    <div class="formRight" style="width: 300px">
      <input style="width: 300px" type="text" readonly="readonly" class="jr_text" name="cata_name" id="cata_name" value="<%=CommonString.getFormatPara(formMap.get("cataname")) %>" />
    </div>
    <div style="clear: left;"></div>
    <div class="formLeft"> 产品型号 </div>
    <div class="formRight" style="width: 300px">
      <input style="width: 300px" type="hidden" class="jr_text" name="pro_name" id="pro_name" value="<%=CommonString.getFormatPara(formMap.get("product_name")) %>" />
	  	  	  <select name="pro_id" id="pro_id" class="jr_select" style="width: 300px;" onchange="document.getElementById('pro_name').value=options[selectedIndex].text">
		  		 <option value="">-请选择-</option>
		  		<% 
				String proId=CommonString.getFormatPara(formMap.get("product_id"));
				if(proList != null){for(Map m : proList){ 
				%>
                      <option value="<%=m.get("id")%>" <%if(proId.equals(Integer.toString((Integer)m.get("id")))){%> selected="selected" <%}%> ><%=m.get("name")%></option>
                <%}}%>		
	      </select>
    </div>
	    <div style="clear: left;"></div>
    <div class="formLeft"> 留言内容 </div>
    <div class="formRight" style="width: 300px">
      <input style="width: 300px" type="text" class="jr_text" name="jr_message" id="jr_message" value="<%=CommonString.getFormatPara(formMap.get("message")) %>" />
    </div>
  </div>
  </div>
  		<input type="hidden" name="pro_uuid" id="pro_uuid" value="<%=uuid %>" />
		<input type="hidden" name="eventAfter" id="eventAfter" value="updateAgentFormsss" />
  	    <input type="hidden" name="tableName" id="tableName" value="pro_product_form" />
</form>
</body>
</html>
<script type="text/javascript" src="/plugin/jquery/jquery.form.js"></script>
<script src="/plugin/ui/ligerUI/ligerUI/js/ligerui.min.js"
	type="text/javascript"></script>
<script src="/backend/scripts/common.js" type="text/javascript"></script>
<script src="/plugin/validator/wofoshan/validator.min.js"
	type="text/javascript"></script>
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
			   document.getElementById("brand_id").innerHTML = (jQuery.trim(data));
			});
		});
	});
	//选择品牌加载该品牌的产品
	jQuery(function(){
		jQuery("#brand_id").change(function(){
		     var brandId=this.value;
			 jQuery.post("/backend/action/ajax_r.jsp",{'brandId':brandId,catalognum:<%=CommonString.getFormatPara(formMap.get("catanum")) %>,'flag':'getPro'},function(data){
				document.getElementById("pro_id").innerHTML = (jQuery.trim(data));
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