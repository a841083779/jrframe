<%@ page language="java" import="java.util.*,java.sql.*,com.jerehnet.util.dbutil.*,com.jerehnet.util.common.*" pageEncoding="UTF-8"%><%
	Connection connection = null;
	String tablePrefix = Env.getInstance().getProperty("table_prefix");
	DBHelper dbHelper = DBHelper.getInstance();
	Map model = new HashMap();
	String tableName = "pro_product_form";
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
		List<Map> brandList = (ArrayList)application.getAttribute("brandList") ;
		Collections.sort(brandList,new Comparator(){
			public int compare(Object o1, Object o2) {
				Map o1Map = (Map)o1;
				Map o2Map = (Map)o2;
				return o1Map.get("upper_index").toString().compareTo(o2Map.get("upper_index").toString());
			}
		 });
%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <title><%=Env.getInstance().getProperty("project_name") %></title>
    <meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
	<link href="/plugin/ui/ligerUI/ligerUI/skins/Aqua/css/ligerui-all.css" rel="stylesheet" type="text/css" />
	<link href="/plugin/ui/ligerUI/ligerUI/skins/Gray/css/all.css" rel="stylesheet" type="text/css" />
	<link href="/plugin/ui/ligerUI/ligerUI/skins/ligerui-icons.css" rel="stylesheet" type="text/css" />
	<link href="/backend/style/style.css" rel="stylesheet" type="text/css" />
	<script src="/plugin/jquery/jquery.min.js" type="text/javascript"></script>
  </head>
  
  <body style="margin: 0;padding: 0;">
  <div style="overflow-x:hidden;overflow-y:scroll; height: 600px; *position:relative;">
	<form name="theform" id="theform" action="/backend/action/crud.jsp">
		<div class="formDiv">
			<div class="group">
				<span><img src="/plugin/ui/ligerUI/ligerUI/skins/icons/communication.gif"/></span>
				<span class="groupTitle">第一次外呼任务</span>
				<%
					if(CommonString.getFormatPara(model.get("call_rs")).equals("103002")){
					%><span><input type="button" style="float: right; position: relative; top:-2px;" class="btn" value="导出EXCEL" onclick="dosubmit();"/></span><%	
					}
				%>
			</div>
			<div class="formRight" style="height: 220px;">
				<div id="first_task" style="margin-left: 3px;"></div>
			</div>
			<div style="clear:left;"></div>
			<div class="group">
				<span><img src="/plugin/ui/ligerUI/ligerUI/skins/icons/communication.gif"/></span>
				<span class="groupTitle">第二次外呼任务</span>
			</div>
			<div class="formRight" style="height: 200px;">
				<div id="second_task" style="margin-left: 3px;"></div>
			</div>
			<div style="clear:left;"></div>
				<div class="group">
					<span><img src="/plugin/ui/ligerUI/ligerUI/skins/icons/communication.gif"/></span>
					<span class="groupTitle">订单详细信息</span>
				</div>
				<div style="clear:left;"></div>
				<div class="formLeft">订<span class="span3"></span>单<span class="span3"></span>人</div>
				<div class="formRight" style="width: 250px;">
					<input type="text" style="width: 100%;" readonly="readonly" class="jr_text" name="zd_name" id="zd_name" value="<%=CommonString.getFormatPara(model.get("name")) %>"/>
				</div>
				<div class="formLeft">联系电话</div>
				<div class="formRight" style="width: 250px;">
					<input  type="text" style="width: 100%;" readonly="readonly" class="jr_text" name="zd_mobile_phone" id="zd_mobile_phone" value="<%=CommonString.getFormatPara(model.get("mobile_phone")) %>" />
				</div>
				<div style="clear:left;"></div>
				<div class="formLeft">所在地区</div>
				<div class="formRight" style="width: 250px;">
					<input type="text" style="width: 100%;" readonly="readonly" class="jr_text" name="zd_contact_address" id="zd_contact_address" value="<%=CommonString.getFormatPara(model.get("contact_address")) %>" />
				</div>
				<div class="formLeft">询价品牌</div>
				<div class="formRight" style="width: 250px;">
					<input type="text" style="width: 100%;" readonly="readonly" class="jr_text" name="zd_factoryname" id="zd_factoryname" value="<%=CommonString.getFormatPara(model.get("factoryname")) %>" />
				</div>
				<div style="clear:left;"></div>
				<div class="formLeft">询价类别</div>
				<div class="formRight" style="width: 250px;">
					<input style="width: 100%;" type="text" readonly="readonly" class="jr_text" name="zd_cataname" id="zd_cataname" value="<%=CommonString.getFormatPara(model.get("cataname")) %>" />
				</div>
				<div class="formLeft">产品名称</div>
				<div class="formRight" style="width: 250px;">
					<input type="text" style="width: 100%;" readonly="readonly" class="jr_text" name="zd_product_name" id="zd_product_name" value="<%=CommonString.getFormatPara(model.get("product_name")) %>" />
				</div>
				<div style="clear:left;"></div>
				<div class="formLeft">询价时间</div>
				<div class="formRight" style="width: 250px;">
					<input type="text" style="width: 100%;" readonly="readonly" class="jr_text" name="zd_add_date" id="zd_add_date" value="<%=CommonString.getFormatPara(model.get("add_date")).replace(".0","") %>" />
				</div>
				<div style="clear:left;"></div>
				<div class="formLeft">高质客户</div>
				<div class="formRight" style="width: 250px;">
						<%=CommonForm.createIsRadio(CommonString.getFormatPara(model.get("is_high_quality")),"zd_is_high_quality") %>
				</div>
				<div class="formLeft">是否推送</div>
				<div class="formRight" style="width: 250px;">
					<%=CommonForm.createIsRadio(CommonString.getFormatPara(model.get("is_push")),"zd_is_push") %>
				</div>
				<div style="clear:left;"></div>
				<div class="formLeft">留言内容</div>
				<div class="formRight" style="height: 120px; text-align: left;">
					<textarea  style="width:618px; height:100px;" class="jr_textarea" readonly="readonly"><%=CommonString.getFormatPara(model.get("message")) %></textarea>
				</div>
				<div style="clear:left;"></div>
				<div class="formLeft" style="padding-top: 3px;">至<span class="span3"></span>其<span class="span3"></span>它</div>
				<div class="formRight" style="text-align: left;">
					<select id="other_brand">
						<option value="">--请选择其它品牌--</option>
					<%if(brandList != null){for(Map m : brandList){%>
                        	<option value="<%=m.get("id")%>"><%=m.get("upper_index")%>：<%=m.get("name")%></option>
                        <%}}%>
					</select>
				</div>
				<div class="formRight" style="text-align: left;">
					<input class="btn" type="button" onclick="recommendToOtherBrand();" value="发送" style="text-align: center;" />
				</div>
				<div style="clear:left;"></div>
		</div>
		<div style="clear: left;"></div>
		<div style="margin-top: 200px;"></div>
		<input type="hidden" name="tableName" id="tableName" value="<%=tableName %>" />
		<input type="hidden" name="zd_id" id="zd_id" value="<%=CommonString.getFormatPara(model.get("id")) %>" />
		<input type="hidden" name="zd_channel_uuid" id="zd_channel_uuid" value="<%=channelUUID %>" />
	</form>
	</div>
  </body>
</html>
<script type="text/javascript" src="/plugin/jquery/jquery.form.js"></script>
<script src="/plugin/ui/ligerUI/ligerUI/js/ligerui.min.js" type="text/javascript"></script>
<script src="/backend/scripts/common.js" prefix="<%=tablePrefix %>" type="text/javascript"></script>
<script src="/plugin/validator/wofoshan/validator.min.js" type="text/javascript"></script>
<script type="text/javascript">
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
	jQuery.ligerDefaults.Grid.formatters['is'] = function(content, column) {
		if (content == 1) {
			return '是';
		}
		return '否';
	};
	function openTask2(id){
		var addUrl = '/backend/pro_400_task2/pro_400_task2_edit.jsp?form_uuid=<%=id %>';
		if(typeof(id)!='undefined'){
			addUrl += '&id='+id;
		}
		var iWidth = 630;
		var iHeight = 460;
		var iTop = (window.screen.height - 30 - iHeight) / 2;
		var iLeft = (window.screen.width - 10 - iWidth) / 2;
		jrWindow(addUrl,'第二次外呼任务',iWidth,iHeight);
		return;
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
								+ ",toolbar=no,menubar=no,scrollbars=yes, resizable=no,location=no, status=no");
	}
	function openTask1(id){
		var addUrl = '/backend/pro_400_task1/pro_400_task1_edit.jsp?form_uuid=<%=id %>';
		if(typeof(id)!='undefined'){
			addUrl += '&id='+id;
		}
		var iWidth = 630;
		var iHeight = 200;
		var iTop = (window.screen.height - 30 - iHeight) / 2;
		var iLeft = (window.screen.width - 10 - iWidth) / 2;
		jrWindow(addUrl,'第一次外呼任务',iWidth,iHeight);
		return;
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
	var columnsArr = [
		{ display : 'ID', name : 'id', align : 'center' , type : 'string' , width : 80 , render : function(row){
				return "<a class='link' href='javascript:void(0);' onclick='openTask1(\""+row.uuid+"\");'>"+row.id+"</a>";
			}
		},
		{ display : '外呼时间', name : 'call_date', align : 'center' , type : 'string' , width : 100 , render : function(row){
				return row.call_date.replace('.0','');
			}
		},
		{ display : '外呼结果', name : 'call_rs', align : 'center' , type : 'string' , width : 100 , render : function(row){
				return getEnum(row.call_rs);
			}
		},
		{ display : '公司/个人', name : 'is_company', align : 'center' , type : 'string' , width : 80 , render : function(row){
				if(row.is_company=='1'||row.is_company==1){
					return '公司';
				}
				return '个人';
			}
		},
		{ display : '订单类型', name : 'order_type', align : 'center' , type : 'string' , width : 140 , render : function(row){
				return getEnum(row.order_type);
			}
		}
	];
	var params = [];
	params.push({'name':'tableName','value':'pro_400_task1'});
	params.push({'name':'fileds','value':'*'});
	params.push({'name':'whereStr','value':' and form_uuid = \'<%=id %>\' '});
	params.push({'name':'orderBy','value':' id desc '});
	jQuery("#first_task").ligerGrid({
		columns : columnsArr,
		url : '/backend/action/liger.jsp',
		pageSize : 20,
		width : 800,
		height : 200,
		selectRowButtonOnly : true,
		rownumbers : true,
		toolbar : null,
		parms : params,
		checkbox : false ,
		toolbar : {
			items : [{
				text : '增加',
				click : function(){
					openTask1();
				},
				icon : 'add'
			}]
		}
	});
	columnsArr = [
		{ display : 'ID', name : 'id', align : 'center' , type : 'string' , width : 60 , render : function(row){
				return "<a class='link' href='javascript:void(0);' onclick='openTask2(\""+row.uuid+"\");'>"+row.id+"</a>";
			}
		},
		{ display : '外呼时间', name : 'call_date', align : 'center' , type : 'string' , width : 100 , render : function(row){
				return row.call_date.replace('.0','');
			}
		},
		{ display : '是否联系', name : 'is_link', align : 'center' , type : 'is' , width : 80 },
		{ display : '是否购买该机', name : 'is_buy_self', align : 'center' , type : 'string' , width : 80 , render : function(row){
				if(row.is_buy_self==0||row.is_buy_self=='0'){
					return '未购买';
				}else if(row.is_buy_self==1||row.is_buy_self=='1'){
					return '已购买';
				}else{
					return '联系中';
				}
			}
		},
		{ display : '是否购买', name : 'is_buy', align : 'center' , type : 'is' , width : 80 },
		{ display : '购机品牌', name : 'brand', align : 'center' , type : 'string' , width : 80 },
		{ display : '购机类型', name : 'category', align : 'center' , type : 'string' , width : 80 },
		{ display : '购机型号', name : 'model', align : 'center' , type : 'string' , width : 80 },
		{ display : '购机价格', name : 'price', align : 'center' , type : 'float' , width : 80 },
		{ display : '是否有意向', name : 'is_intention', align : 'center' , type : 'is' , width : 80 },
		{ display : '计划购机时间', name : 'plan_to_buy', align : 'center' , type : 'is' , width : 80 , render : function(row){
				return getEnum(row.plan_to_buy);
			}
		}
	];
	params = [];
	params.push({'name':'tableName','value':'pro_400_task2'});
	params.push({'name':'fileds','value':'*'});
	params.push({'name':'whereStr','value':' and form_uuid = \'<%=id %>\' '});
	params.push({'name':'orderBy','value':' id desc '});
	jQuery("#second_task").ligerGrid({
		columns : columnsArr,
		url : '/backend/action/liger.jsp',
		pageSize : 20,
		width : 800,
		height : 200,
		selectRowButtonOnly : true,
		rownumbers : true,
		toolbar : null,
		parms : params,
		checkbox : false,
		toolbar : {
			items : [{
				text : '增加',
				click : function(){
					openTask2();
				},
				icon : 'add'
			}]
		}
	});
	function dosubmit(){
		window.open("/backend/pro_product_form/order_list_excel.jsp?if_tag=2&formUUID=<%=id %>");
	}
	function recommendToOtherBrand(){
		var ched = document.getElementById("other_brand").options[document.getElementById("other_brand").selectedIndex].innerHTML;
		if(ched.indexOf("：")!=-1){
			ched = ched.split("：")[1];
		}
		var rs = confirm("确定要将该条订单推荐到"+ched+"吗？");
		if(rs){
			jQuery.ajax({
				url : "/backend/action/ajax_cud.jsp" ,
				type : 'post' ,
				async : false ,
				data : {
					flag : 'recommend_to_other_brand' ,
					id : '<%=id %>' ,
					other_brand_id : jQuery("#other_brand").val() ,
					other_brand_name : ched
				} ,
				success : function(data){
					if(jQuery.trim(data)=='ok'){
						alert("推送成功！");
					}else{
						alert("推送失败！");
					}
				}
			});	
		}
	}
</script><%
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		DBHelper.freeConnection(connection);
	}
%>