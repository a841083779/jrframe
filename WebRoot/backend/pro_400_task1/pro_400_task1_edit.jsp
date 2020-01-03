<%@ page language="java" import="java.util.*,java.sql.*,com.jerehnet.util.dbutil.*,com.jerehnet.util.common.*" pageEncoding="UTF-8"%><%
	Connection connection = null;
	String tablePrefix = Env.getInstance().getProperty("table_prefix");
	DBHelper dbHelper = DBHelper.getInstance();
	Map model = new HashMap();
	String add_user="";
	        Map adminInfo = (Map)session.getAttribute("adminInfo");
	        if(null!=adminInfo){
					add_user=(String)(adminInfo.get("usern"));
				}else{
					add_user=("none");
	}
	//String tableName = "pro_400_task1";
	String tableName = "pro_product_form";
	String f = CommonString.getFormatPara(request.getParameter("f"));
	try{
		connection = dbHelper.getConnection();
		String id = CommonString.getFormatPara(request.getParameter("id"));
		String formUUID = CommonString.getFormatPara(request.getParameter("form_uuid"));
		/*
		if(null!=id&&!"".equals(id)){
			model = dbHelper.getMap(" select * from "+tableName+" where uuid = ? ",new Object [] {id} , connection);
		}
		if("".equals(formUUID)&&null!=model){
			formUUID = (String)model.get("form_uuid");
		}
		*/
		Map formMap = dbHelper.getMap(" select * from pro_product_form where id = ? ",new Object [] {id},connection);
		//公司还是个人
		Map c_or_g = new HashMap();
		c_or_g.put("0","个人");
		c_or_g.put("1","公司");
		Map callRsMap = (Map)CommonApplication.getEnumChildren("103",application);
		Map orderTypeMap = (Map)CommonApplication.getEnumChildren("104",application);
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
		<div class="formDiv">
		          <!--
				<div class="formLeft">外呼时间</div>
				<div class="formRight" style="width: 180px;">
					<%
						String callDate = CommonString.getFormatPara(model.get("call_date")).replace(".0","");
						if("".equals(callDate)){
							callDate = CommonDate.getToday("yyyy-MM-dd HH:mm:ss");
						}
					%>
					<input type="text" style="width: 100%;" readonly="readonly" class="jr_text" name="zd_call_date" id="zd_call_date" value="<%=callDate %>" />
				</div>
				-->
				
				<div class="formLeft">外呼结果</div>
				<div class="formRight" style="width: 180px;">
					<select style="width: 100%;" class="jr_select" name="zd_call_rs" id="zd_call_rs">
						<%=CommonForm.createSelect(callRsMap,CommonString.getFormatPara(formMap.get("call_rs"))) %>
					</select>
				</div>
				<div class="formLeft">订单类型</div>
				<div class="formRight" style="width: 180px;">
					<%
						String orderType = CommonString.getFormatPara(model.get("order_type"));
						if("".equals(orderType)){
							orderType = "104002";
						}
					%>
					<select style="width: 100%;" class="jr_select" name="" id="">
						<%=CommonForm.createSelect(orderTypeMap,orderType) %>
					</select>
				</div>
				<div style="clear:left;"></div>
				
				<div class="formLeft">公司个人</div>
				<div class="formRight" style="width: 180px;">
					<%
						String isCompany = CommonString.getFormatPara(model.get("is_company"));
						if("".equals(isCompany)){
							isCompany = "0";
						}
					%>
					<select style="width: 100%;" class="jr_select" name="" id=""><%=CommonForm.createSelect(c_or_g,isCompany) %></select>
				</div>
				<div style="clear:left;"></div>
				<!--
				<div class="formLeft">备<span class="span2"></span>注</div>
				<%
					if("list".equals(f)){
						%><div class="formRight" style="width: 480px; height: 50px;"><%
					}else{
						%><div class="formRight" style="width: 480px; "><%
					}
				%>
					<textarea style="width: 100%;" class="jr_textarea" name="zd_remark" id="zd_remark"><%=CommonString.getFormatPara(formMap.get("call_result1")) %></textarea>
				</div>
				-->
				<div style="clear:left;"></div>
				<%
					if("list".equals(f)){
						%>
				<div class="group">
					<span><img src="/plugin/ui/ligerUI/ligerUI/skins/icons/communication.gif"/></span>
					<span class="groupTitle">订单详细信息</span>
				</div>
				<div style="clear:left;"></div>
				<div class="formLeft">订<span class="span3"></span>单<span class="span3"></span>人</div>
				<div class="formRight" style="width: 180px;">
					<input type="text" style="width: 100%;" readonly="readonly" class="jr_text" name="name" id="name" value='<%=CommonString.getFormatPara(formMap.get("name")) %>'/>
				</div>
				<div class="formLeft">联系电话</div>
				<div class="formRight" style="width: 180px;">
					<input  type="text" style="width: 100%;" readonly="readonly" class="jr_text" name="mobile_phone" id="mobile_phone" value="<%=CommonString.getFormatPara(formMap.get("mobile_phone")) %>" />
				</div>
				<div style="clear:left;"></div>
				<div class="formLeft">所在地区</div>
				<div class="formRight" style="width: 180px;">
					<input type="text" style="width: 100%;" readonly="readonly" class="jr_text" name="contact_address" id="contact_address" value="<%=CommonString.getFormatPara(formMap.get("contact_address")) %>" />
				</div>
				<div class="formLeft">询价品牌</div>
				<div class="formRight" style="width: 180px;">
					<input type="text" style="width: 100%;" readonly="readonly" class="jr_text" name="factoryname" id="factoryname" value="<%=CommonString.getFormatPara(formMap.get("factoryname")) %>" />
				</div>
				<div style="clear:left;"></div>
				<div class="formLeft">询价类别</div>
				<div class="formRight" style="width: 180px;">
					<input style="width: 100%;" type="text" readonly="readonly" class="jr_text" name="cataname" id="cataname" value="<%=CommonString.getFormatPara(formMap.get("cataname")) %>" />
				</div>
				<div class="formLeft">产品名称</div>
				<div class="formRight" style="width: 180px;">
					<input type="text" style="width: 100%;" readonly="readonly" class="jr_text" name="product_name" id="product_name" value="<%=CommonString.getFormatPara(formMap.get("product_name")) %>" />
				</div>
				<div style="clear:left;"></div>
				<div class="formLeft">询价时间</div>
				<div class="formRight" style="width: 180px;">
					<input type="text" style="width: 100%;" readonly="readonly" class="jr_text" name="add_date" id="add_date" value="<%=CommonString.getFormatPara(formMap.get("add_date")).replace(".0","") %>" />
				</div>
		
				<div style="clear:left;"></div>
			<div class="formLeft">留言内容</div>
			<div class="formRight" style="height: 100px; text-align: left;">
				<textarea  style="width:478px; height:80px;" class="jr_textarea" name="jr_textarea" id="jr_textarea" ><%=CommonString.getFormatPara(formMap.get("message")) %></textarea>
			</div>
			
	<div style="clear: left;"></div>
    <div class="formLeft"> 备注信息 </div>
    <div class="formRight" style="width: 300px">
      <input style="width: 480px" type="text" class="jr_text" name="zd_call_result1" id="zd_call_result1" value="<%=CommonString.getFormatPara(formMap.get("call_result1")) %>" />
    </div>
			<div style="clear:left;"></div>
				<%
					}
				%>
				
		</div>
		<div style="clear: left;"></div>
		<input type="hidden" name="tableName" id="tableName" value="<%=tableName %>" />
		<input type="hidden" name="zd_id" id="zd_id" value="<%=CommonString.getFormatPara(formMap.get("id")) %>" />
 		<input type="hidden" name="jr_user" id="jr_user" value="<%=add_user %>" />
		<input type="hidden" name="log_id" id="log_id" value="<%=id %>" />
		<input type="hidden" name="eventAfter" id="eventAfter" value="updateFormCallRs,order_log,doLog" />
		
	</form>
  </body>
</html>
<script type="text/javascript" src="/plugin/jquery/jquery.form.js"></script>
<script src="/plugin/ui/ligerUI/ligerUI/js/ligerui.min.js" type="text/javascript"></script>
<script src="/backend/scripts/common.js" prefix="<%=tablePrefix %>" type="text/javascript"></script>
<script src="/plugin/validator/wofoshan/validator.min.js" type="text/javascript"></script>
<script type="text/javascript">
	function doSub(){
		var rs = Validator.Validate(document.getElementById("theform"),1);
		var zd_call_rs = jQuery("#zd_call_rs").val();
        //如果是无效号码确认是否删除
		if(zd_call_rs==103003){
	       if(confirm("是否将此订单信息拉黑删除?")){

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
		}else{
   		
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
		return true;
	}
</script><%
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		dbHelper.freeConnection(connection);
	}
%>