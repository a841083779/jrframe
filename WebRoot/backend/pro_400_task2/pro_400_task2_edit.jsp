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
	String tableName = "pro_400_task2";
	String f = CommonString.getFormatPara(request.getParameter("f"));
	try{
		connection = dbHelper.getConnection();
		String id = CommonString.getFormatPara(request.getParameter("id"));
		String formUUID = CommonString.getFormatPara(request.getParameter("form_uuid"));
		if(null!=id&&!"".equals(id)){
			model = dbHelper.getMap(" select * from "+tableName+" where uuid = ? ",new Object [] {id} , connection);
		}
		if("".equals(formUUID)&&null!=model){
			formUUID = (String)model.get("form_uuid");
		}
		Map formMap = dbHelper.getMap(" select * from pro_product_form where uuid = ? ",new Object [] {formUUID},connection);
		Map plan_to_buyMap = (Map)CommonApplication.getEnumChildren("102",application);
		Map callRsMap = (Map)CommonApplication.getEnumChildren("106",application);
		Map seriesMap = (Map)CommonApplication.getEnumChildren("108",application);
		Map conditionMap = (Map)CommonApplication.getEnumChildren("109",application);
		LinkedHashMap isBuyMap = new LinkedHashMap();
		isBuyMap.put("1","已购买");
		isBuyMap.put("0","未购买");
		isBuyMap.put("2","联系中");
		LinkedHashMap isIntentionMap = new LinkedHashMap();
		isIntentionMap.put("0","无");
		isIntentionMap.put("1","有");
		String contents=CommonString.getFormatPara(formMap.get("call_result2"));
		if(contents==null||contents.equals("")){
		contents=CommonString.getFormatPara(formMap.get("message"));
		}
		List<Map> brandList = (ArrayList)application.getAttribute("brandList") ;
		List<Map> proList=null;
		if(CommonString.getFormatPara(formMap.get("deal_factoryid")).equals("")&&!CommonString.getFormatPara(formMap.get("factoryid")).equals("")){
	    proList= (ArrayList)(dbHelper.getMapList(" select id,name from pro_products where is_show=1 and  factoryid =  "+CommonString.getFormatPara(formMap.get("factoryid")),connection));
		}else if(!CommonString.getFormatPara(formMap.get("deal_factoryid")).equals("")&&!CommonString.getFormatPara(formMap.get("factoryid")).equals("")){
	    proList= (ArrayList)(dbHelper.getMapList(" select id,name from pro_products where is_show=1 and  (factoryid =  "+CommonString.getFormatPara(formMap.get("factoryid"))+" or factoryid="+CommonString.getFormatPara(formMap.get("deal_factoryid"))+")",connection));       
	    }else{
		 proList= (ArrayList)(dbHelper.getMapList(" select id,name from pro_products where is_show=1 ",connection));       
		}
%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <title><%=Env.getInstance().getProperty("project_name") %></title>
	<link href="/plugin/ui/ligerUI/ligerUI/skins/Aqua/css/ligerui-all.css" rel="stylesheet" type="text/css" />
	<link href="/plugin/ui/ligerUI/ligerUI/skins/Gray/css/all.css" rel="stylesheet" type="text/css" />
	<link href="/plugin/ui/ligerUI/ligerUI/skins/ligerui-icons.css" rel="stylesheet" type="text/css" />
	<link href="/backend/style/style.css" rel="stylesheet" type="text/css" />
	<script src="/plugin/jquery/jquery.min.js" type="text/javascript"></script>
	<style type="text/css">
	#youyixiang{
		display:none;
	}
	#weigouyuanyin1{
		display:none;
	}
	#weigouyuanyin2{
		display:none;
	}
	#xunjia{
		display:none;
	}
	#yixiang{
		display:none;
	}
	#chenggong{
		display:none;
	}
	</style>
  </head>
  
  <body style="margin: 0;padding: 0; overflow-x: hidden; overflow-y: scroll; ">
	<form name="theform" id="theform" action="/backend/action/crud.jsp">
		<div class="formDiv">
				<div class="group">
					<span><img src="/plugin/ui/ligerUI/ligerUI/skins/icons/communication.gif"/></span>
					<span class="groupTitle">外呼情况信息</span>
				</div>
	
				<div class="formLeft">外呼结果</div>
				<div class="formRight" style="width: 180px;">
				    	<%
						String outResult = CommonString.getFormatPara(formMap.get("call_rs_task2"));						
						if(outResult.equals("103001")){
							outResult = "106001";
						}
					    %>
				
					<select style="width: 100%;" class="jr_select" name="zd_call_rs_task2" id="zd_call_rs_task2">
						<%=CommonForm.createSelect(callRsMap,outResult) %>
					</select>
				</div>
			   <div style="clear:left;"></div>
			   <div class="formLeft">留言内容</div>
			   <div class="formRight" style="height: 80px; text-align: left;">
				    <textarea  style="width:478px; height:80px;" class="jr_textarea" name="jr_textarea" id="jr_textarea" ><%=contents %></textarea>
			    </div>
				<div style="clear:left;"></div>
				
				<div id="result" style="display:<%if(CommonString.getFormatPara(formMap.get("last_buy")).equals("")){%>none<%}else{%>block<%}%>">
				<div class="formLeft"><span id="buy_brand">最后购买产品</span></div>
				<div class="formRight" style="width: 180px;">
					<input type="text" style="width: 478px;"  class="jr_text" name="jr_last_buy" id="jr_last_buy" value="<%=CommonString.getFormatPara(formMap.get("last_buy")) %>" />
				</div>
				<div style="clear:left;"></div>
				</div>	
				<div class="formLeft"><span id="buy_brand">客户跟踪结果</span></div>
				<div class="formRight" style="width: 180px;">
					<input type="text" style="width: 478px;" readonly="readonly"  class="jr_text" name="" id="" value="<%=CommonString.getFormatPara(formMap.get("follow_content")) %>" />
				</div>
				<div style="clear:left;"></div>
				<div class="formLeft"><span id="buy_brand">回访记录</span></div>
				<div class="formRight" style="width: 180px;">
					<input type="text" style="width: 478px;"  class="jr_special_remark" name="jr_special_remark" id="jr_special_remark" value="<%=CommonString.getFormatPara(formMap.get("special_remark")) %>" />
				</div>
				<div style="clear:left;"></div>
				<div id="chenggong">
					<div class="formLeft">是否联系</div>
					<div class="formRight" style="width: 180px;">
						<%=CommonForm.createIsRadio(CommonString.getFormatPara(formMap.get("is_link")),"main_is_link") %>
					</div>
					<div class="formLeft">购买该机</div>
					<div class="formRight goumaigaiji" style="width: 180px;">
						<%=CommonForm.createRadio(isBuyMap,CommonString.getFormatPara(formMap.get("is_buy_self")),"main_is_buy_self") %>
					</div>
				</div>
				<div style="clear:left;"></div>
				<div id="xunjia">
				<div class="group">
					<span><img src="/plugin/ui/ligerUI/ligerUI/skins/icons/communication.gif"/></span>
					<span class="groupTitle">询价设备信息</span>
				</div>
				<div id="weigouyuanyin1">
				<div class="formLeft">未购原因</div>
				<div class="formRight" style="width: 180px; height: 60px;">
					<textarea class="jr_textarea" style="width: 480px;" name="main_not_buy_reson1" id="main_not_buy_reson1"><%=CommonString.getFormatPara(formMap.get("not_buy_reson1")) %></textarea>
				</div>
				</div>
				<div style="clear:left;"></div>
				<div id="goumai">
				<div class="formLeft"><span id="buy_brand">购买品牌</span></div>
				<div class="formRight" style="width: 180px;">
			
		  <select disabled="true" name="" id="" class="jr_select" style="width: 100%" onchange="document.getElementById('main_brand').value=options[selectedIndex].text">
		  		 <option value="">-请选择-</option>
		  		<% 
				String facId=CommonString.getFormatPara(formMap.get("factoryid"));
				if(brandList != null){for(Map m : brandList){ 
				%>
                      <option value="<%=m.get("id")%>" <%if(facId.equals(Integer.toString((Integer)m.get("id")))){%> selected="selected" <%}%> ><%=m.get("name")%></option>
                <%}}%>			
	      </select>
								
				</div>
				<div class="formLeft"><span id="buy_category">购买类型</span></div>
				<div class="formRight" style="width: 180px;">
					<%
						String category = CommonString.getFormatPara(formMap.get("category"));
						if("".equals(category)){
							category = CommonString.getFormatPara(formMap.get("cataname"));
						}
					%>
					<input type="text" style="width: 100%;"  class="jr_text" name="main_category" id="main_category" value="<%=category %>" />
				</div>
				<div style="clear:left;"></div>
				<div class="formLeft"><span id="buy_model">购买型号</span></div>
				<div class="formRight" style="width: 180px;">
				 <select disabled="true" name="" id="" class="jr_select" style="width: 100%" onchange="document.getElementById('main_model').value=options[selectedIndex].text">
		  		     <option value="">-请选择-</option>
		  	        	<% 
				        String proId=CommonString.getFormatPara(formMap.get("product_id"));
				        if(proList != null){for(Map m : proList){ 
				        %>
                     <option value="<%=m.get("id")%>" <%if(proId.equals(Integer.toString((Integer)m.get("id")))){%> selected="selected" <%}%> ><%=m.get("name")%></option>
                <%}}%>		
	              </select>
				</div>
			<div style="clear:left;"></div>	
			
			<div class="formLeft"><span id="buy_brand">成交品牌</span></div>
			<div class="formRight" style="width: 180px;">
		    <select  name="brand_id" id="brand_id" class="jr_select" style="width: 100%" onchange="document.getElementById('jr_deal_factoryname').value=options[selectedIndex].text">
		  		 <option value="">-请选择-</option>
		  		<% 
				String deal_brand=CommonString.getFormatPara(formMap.get("factoryid"));
				if(!CommonString.getFormatPara(formMap.get("deal_factoryid")).equals("")){
				    deal_brand=CommonString.getFormatPara(formMap.get("deal_factoryid"));
				}
				if(brandList != null){for(Map m : brandList){ 
				%>
                <option value="<%=m.get("id")%>" <%if(deal_brand.equals(Integer.toString((Integer)m.get("id")))){%> selected="selected" <%}%> ><%=m.get("name")%></option>
                <%}}%>			
	        </select>				
			</div>
				
				
			    <div class="formLeft"><span id="buy_model">成交型号</span></div>
				<div class="formRight" style="width: 180px;">
				<select  name="pro_id" id="pro_id" class="jr_select" style="width: 100%" onchange="document.getElementById('jr_deal_model').value=options[selectedIndex].text">
		  		     <option value="">-请选择-</option>
		  	         <% 
				        String deal_pro=CommonString.getFormatPara(formMap.get("product_id"));				
				        if(!CommonString.getFormatPara(formMap.get("deal_proid")).equals("")){
				                  deal_pro=CommonString.getFormatPara(formMap.get("deal_proid"));
				        }				   
			         	if(proList != null){for(Map m : proList){ 
				     %>
                     <option value="<%=m.get("id")%>" <%if(deal_pro.equals(Integer.toString((Integer)m.get("id")))){%> selected="selected" <%}%> ><%=m.get("name")%></option>
                     <%}}%>		
	            </select>
			    </div>
				
				
				</div>
				</div>
				<div style="clear:left;"></div>
				<div id="qita" style="display:none;">
				<div class="group">
					<span><img src="/plugin/ui/ligerUI/ligerUI/skins/icons/communication.gif"/></span>
					<span class="groupTitle">其它设备信息</span>
				</div>
				<div class="formLeft">购买其它</div>
				<div class="formRight is_buy_show" style="width: 80px;">
					<%=CommonForm.createIsRadio(CommonString.getFormatPara(formMap.get("is_buy")),"main_is_buy") %>
				</div>
				<div class="formRight" style="width: 380px; text-align: left; padding-top: 3px;">
					（如未购买订单询价设备，选择是否购买其它品牌和设备）
				</div>
				<div style="clear:left;"></div>
				<div id="weigouyuanyin2">
					<div class="formLeft">未购原因</div>
					<div class="formRight" style="width: 180px; height: 60px;">
						<textarea class="jr_textarea" style="width: 480px;" name="main_not_buy_reson2" id="main_not_buy_reson2"><%=CommonString.getFormatPara(formMap.get("not_buy_reson2")) %></textarea>
					</div>
				</div>
				<div style="clear:left;"></div>
					<div id="subqita">
						<div class="formLeft"><span id="buy_brand">其它品牌</span></div>
						<div class="formRight" style="width: 180px;">
							<input type="text" style="width: 100%;" class="jr_text" name="main_other_brand" id="main_other_brand" value="<%=CommonString.getFormatPara(formMap.get("other_brand")) %>" />
						</div>
						<div class="formLeft"><span id="buy_category">其它类型</span></div>
						<div class="formRight" style="width: 180px;">
							<input type="text" style="width: 100%;" class="jr_text" name="main_other_category" id="main_other_category" value="<%=CommonString.getFormatPara(formMap.get("other_category")) %>" />
						</div>
						<div style="clear:left;"></div>
						<div class="formLeft"><span id="buy_model">其它型号</span></div>
						<div class="formRight" style="width: 180px;">
							<input type="text" style="width: 100%;" class="jr_text" name="main_other_model" id="main_other_model" value="<%=CommonString.getFormatPara(formMap.get("other_model")) %>" />
						</div>
						<div class="formLeft"><span id="buy_price">其它价格</span></div>
						<div class="formRight" style="width: 180px;">
							<input type="text" style="width: 100%;" class="jr_text" name="main_other_price" id="main_other_price" value="<%=CommonString.getFormatPara(formMap.get("other_price")) %>" />
						</div>
					</div>
				</div>
				<%-- 备注 --%>
                <!--
				<div style="clear:left;"></div>
				<div class="group">
					<span><img src="/plugin/ui/ligerUI/ligerUI/skins/icons/communication.gif"/></span>
					<span class="groupTitle">备注信息</span>
				</div>
				<div class="formLeft">备<span class="span2"></span>注</div>
				<%
				if("list".equals(f)){
					%><div class="formRight" style="width: 180px; height: 50px;"><%
				}else{
					%><div class="formRight" style="width: 180px;"><%
				}
				%>
					<textarea style="width: 480px;" class="jr_textarea" name="zd_remark" id="zd_remark"><%=CommonString.getFormatPara(formMap.get("call_result2")) %></textarea>
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
					<input type="text" style="width: 100%;" readonly="readonly" class="jr_text" name="name" id="name" value="<%=CommonString.getFormatPara(formMap.get("name")) %>"/>
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
				<div style="clear:left;"></div>
				
				
				<div class="formLeft">是否成交</div>
				<div class="formRight" style="width: 180px;">
						<%
							String is_deal = CommonString.getFormatPara(formMap.get("is_deal"));
							if("".equals(is_deal)){
								is_deal = "0";
							}
						%>
						<%=CommonForm.createIsRadio(is_deal,"is_deal") %>
				</div>
				<div class="formLeft">是否星标</div>
				<div class="formRight" style="width: 180px;">
				    <%
							String is_star = CommonString.getFormatPara(formMap.get("is_star"));
							if("".equals(is_star)){
								is_star = "0";
							}
					%>
					<%=CommonForm.createIsRadio(is_star,"is_star") %>
				</div>
				<div style="clear:left;"></div>
				
				<div class="formLeft">品牌分类</div>
				<div class="formRight" style="width: 180px;">
						<%
						String brand_series = CommonString.getFormatPara(formMap.get("brand_series"));
                        if(brand_series.equals("")){brand_series="108004";}						
						%>
					<select style="width: 100%;" class="jr_select" name="brand_series" id="brand_series" onchange="document.getElementById('jr_brand_series').value=options[selectedIndex].value">
						<%=CommonForm.createSelect(seriesMap,brand_series) %>
					</select>
				</div>
				<div class="formLeft">新旧程度</div>
				<div class="formRight" style="width: 180px;">
						<%
						String pro_condition = CommonString.getFormatPara(formMap.get("pro_condition"));	
                        if(pro_condition.equals("")){pro_condition="109003";}												
						%>
					<select style="width: 100%;" class="jr_select" name="pro_condition" id="pro_condition" onchange="document.getElementById('jr_pro_condition').value=options[selectedIndex].value">
						<%=CommonForm.createSelect(conditionMap,pro_condition) %>
					</select>					
				</div>
				<div style="clear:left;"></div>
				
				
				
			    <%
					}
				%>
				
		</div>
		<div style="clear: left;"></div>
		<input type="hidden" name="main_brand" id="main_brand"  value="<%=CommonString.getFormatPara(formMap.get("factoryname"))%>"/>
	    <input type="hidden" name="main_model" id="main_model"  value="<%=CommonString.getFormatPara(formMap.get("product_name"))%>"/>
		<input type="hidden" name="formID" id="formID" value="<%=CommonString.getFormatPara(formMap.get("id"))%>" />

		<input type="hidden" name="jr_deal_factoryid" id="jr_deal_factoryid"  value="<%=CommonString.getFormatPara(formMap.get("deal_factoryid"))%>"/>
	    <input type="hidden" name="jr_deal_factoryname" id="jr_deal_factoryname"  value="<%=CommonString.getFormatPara(formMap.get("deal_factoryname"))%>"/>
		<input type="hidden" name="jr_deal_model" id="jr_deal_model"  value="<%=CommonString.getFormatPara(formMap.get("deal_model"))%>"/>
		<input type="hidden" name="jr_deal_proid" id="jr_deal_proid"  value="<%=CommonString.getFormatPara(formMap.get("deal_proid"))%>"/>
		<input type="hidden" name="jr_brand_series" id="jr_brand_series"  value="<%=CommonString.getFormatPara(formMap.get("brand_series"))%>" />
		<input type="hidden" name="jr_pro_condition" id="jr_pro_condition"  value="<%=CommonString.getFormatPara(formMap.get("pro_condition"))%>" />

		
		<input type="hidden" name="tableName" id="tableName" value="<%=tableName %>" />
		<input type="hidden" name="zd_id" id="zd_id" value="<%=CommonString.getFormatPara(model.get("id")) %>" />
		<input type="hidden" name="zd_form_uuid" id="zd_form_uuid" value="<%=formUUID %>" />
		<input type="hidden" name="jr_user" id="jr_user" value="<%=add_user %>" />
		<input type="hidden" name="eventAfter" id="eventAfter" value="updateFormTask2Count" />
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
		var zd_call_rs_task2 = jQuery("#zd_call_rs_task2").val();
		//如果是无效号码确认是否删除106005
		if(zd_call_rs_task2==106005){
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
		return 'no_refresh';
	}
		//选择品牌加载该品牌的产品
	jQuery(function(){
		jQuery("#brand_id").change(function(){
		     var brandId=this.value;
			 $("#jr_deal_factoryid").val(brandId);
			 jQuery.post("/backend/action/ajax_r.jsp",{'brandId':brandId,'flag':'getPro'},function(data){
				document.getElementById("pro_id").innerHTML = (jQuery.trim(data));
			 });
		});
	});
	
	//选择产品赋上厂家id
	jQuery(function(){
		jQuery("#pro_id").change(function(){
		     var proId=this.value;
			 $("#jr_deal_proid").val(proId);
		});
	});
	//是否购买其它
	jQuery("input[name=main_is_buy]").click(function(){
		//已购买其它
		if(this.value==1||this.value=='1'){
			jQuery("#weigouyuanyin2").hide();
			jQuery("#subqita").show();
		}else{//未购买其它
			jQuery("#weigouyuanyin2").show();
			jQuery("#subqita").hide();
		}
	});
	//是否有意向
	jQuery("input[name=main_is_intention]").click(function(){
		//如果有意向
		if(this.value==1||this.value=='1'){
			jQuery("#youyixiang").show();
		}else{//如果无意向
			jQuery("#youyixiang").hide();
		}
	});
	//是否购买该机选项
	jQuery("input[name=main_is_buy_self]").click(function(){
		//未购买
		if(this.value==0||this.value=='0'){
			jQuery("#xunjia").show();
			jQuery("#goumai").hide();
			jQuery("#weigouyuanyin1").show();
			jQuery("#qita").show();
			jQuery("#yixiang").show();
		}else if(this.value==1||this.value=='1'){//已购买
			jQuery("#xunjia").show();
			jQuery("#goumai").show();
			jQuery("#weigouyuanyin1").hide();
			jQuery("#qita").hide();
			jQuery("#yixiang").show();
		}else{//联系中
			jQuery("#xunjia,#qita").hide();
			jQuery("#yixiang").hide();
		}
	});
	//是否联系单击
	jQuery("input[name=main_is_link]").click(function(){
		//如果已联系
		if(this.value==1||this.value=='1'){
			jQuery(".goumaigaiji .jr_radio_group *").show();
			jQuery("#main_is_buy_self0").click();
			jQuery("#main_not_buy_reson1").val("");
		}else{//如果未联系
			//只显示未购
			jQuery(".goumaigaiji .jr_radio_group *").hide();
			jQuery("#main_is_buy_self1").click();
			jQuery("#main_is_buy_self1").show();
			jQuery("#main_is_buy_self1").next().show();
			jQuery("#main_not_buy_reson1").val("代理商未联系");
			jQuery("#main_is_buy1").click();
		}
	});
	//外呼结果变化事件
	jQuery("#zd_call_rs_task2").change(function(){
		//如果是成功的话
		//if(this.value==106001||this.value=='106001'){
			//jQuery("#xunjia,#yixiang,#chenggong").show();
			//jQuery("#main_is_buy_self2").click();
		//}else{
			//jQuery("#xunjia,#yixiang,#chenggong").hide();
		//}
		
		//如果是成功的话
		if(this.value==106002||this.value=='106002'){    
			jQuery("#result").show();
		}else{
			jQuery("#result").hide();
		}
	});
	jQuery("input[name=main_is_link]:checked").click();
	jQuery("input[name=main_is_buy_self]:checked").click();
	jQuery("input[name=main_is_buy]:checked").click();
	jQuery("input[name=main_is_intention]:checked").click();
	
</script><%
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		DBHelper.freeConnection(connection);
	}
%>