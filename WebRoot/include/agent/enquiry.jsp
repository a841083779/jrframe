<%@ page language="java" import="org.json.*,java.util.*,com.jerehnet.util.dbutil.*,com.jerehnet.util.common.*,com.jerehnet.webservice.*" pageEncoding="UTF-8"%><%
	DBHelper dbHelper = DBHelper.getInstance();
	String id = CommonString.getFormatPara(request.getParameter("id"));
	Map agentMap = dbHelper.getMap(" select * from pro_agent_factory where id = ? ",new Object [] {id});
	String objStr = Tools.getMyProvinceAndCity(Common.getIp(request));
	JSONObject obj = new JSONObject(objStr);
	String city = "烟台";
	String province = "山东";
	if(null!=obj&&obj.length()>0){
		province = CommonString.getFormatPara(obj.getString("province"));
		city = CommonString.getFormatPara(obj.getString("city"));
	}
	String nowBrand = CommonString.getFormatPara(request.getParameter("nowBrand"));
	String nowBrandName = CommonString.getFormatPara(request.getParameter("nowBrandName"));
	String nowCatalog = CommonString.getFormatPara(request.getParameter("nowCatalog"));
	String nowCatalogName = CommonString.getFormatPara(request.getParameter("nowCatalogName"));
%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>JSP</title>
<script type="text/javascript" src="/plugin/jquery/jquery.min.js"></script>
<script type="text/javascript" src="/plugin/jquery/jquery.form.js"></script>
<script type="text/javascript" src="/plugin/jquery/jquery.cookies.2.2.0.min.js"></script>
<script type="text/javascript" src="/plugin/area/city/citys.js"></script>
<script type="text/javascript" src="/plugin/validator/wofoshan/validator.alert.js"></script>
<style type="text/css">
* { margin:0px; padding:0px;}
body { font-size:14px; color:#333; font-family:Arial;}
.list_border_bg th,.list_border_bg td { padding:5px; vertical-align:top; line-height:24px;}
.list_border_bg th { text-align:right;} 
.list_border_bg td { color:red;}
.list_border_bg select { padding:2px; border:#adadaf 1px solid; font-family:Arial; font-size:14px;}
.input01 { width:215px; border:#e7e8ea 1px solid; border-color:#adadaf #e7e8ea #e7e8ea #adadaf; padding-left:5px; color:#333; font-family:Arial; font-size:14px; padding:3px;}
</style>
</head>
<body style="overflow: hidden;overflow-x:hidden;overflow-y:hidden;">
  <div class="orderbg" style="margin:0px 0px 0px 10px; padding-top:10px;">
<form action="/action/ajax.jsp?flag=order_to_agent" method="post" name="theform" id="theform">
  <table width="95%" border="0" align="center" cellpadding="0" cellspacing="0" class="list_border_bg">
    <tbody>
    <tr>
      <th height="22" nowrap="nowrap" class="list_cell_bg " colspan="2" style="font-weight:normal; color:#999; text-align:left; padding-left:33px;">
          留下您的联系方式及留言，该代理商将会尽快联系您！
      </th>
    </tr>
    <tr>
      <th width="22%" align="right" nowrap="nowrap">姓　　名：</th>
      <td width="78%" nowrap="nowrap" class="list_cell_bg "><input class="input01" name="user_name" datatype="Require" msg="请输入姓名" type="text" id="user_name" size="30" maxlength="20" />
        *</td>
    </tr>
     <tr>
      <th align="right" nowrap="nowrap">联系电话：</th>
      <td nowrap="nowrap" class="list_cell_bg">
      <input class="input01" type="text" id="contact_tel" name="contact_tel" size="30" maxlength="15" />*
      </td>
    </tr>
          <tr>
            <th align="right" nowrap="nowrap">采购性质：</th>
            <td nowrap="nowrap" class="list_cell_bg ">
              <input name="ifgroup" type="radio" checked="checked" value="个人" />
              <font color="#434343">个人</font>
              <input name="ifgroup" type="radio" value="公司" />
              <font color="#434343">公司</font>
              *</td>
          </tr>
          
                 <tr id="company" style="display: none;">
      <th align="right" nowrap="nowrap">公司名称：</th>
      <td nowrap="nowrap" class="list_cell_bg"><input class="input01" name="company_name" type="text" id="company_name" size="30" maxlength="15" /></td>
    </tr>
          
      <tr>
      <th align="right" nowrap="nowrap">预计购买：</th>
      <td nowrap="nowrap" class="list_cell_bg">
       <select name="buy_time" id="buy_time">
       <option value="102001">1个月内</option><option value="102002">1—3个月</option><option value="102003">4—6个月</option><option value="102004">7—12个月</option><option value="102005">1年后</option><option value="102006">不确定</option>
       </select>
        *</td>
    </tr>
    <tr>
      <th align="right" nowrap="nowrap">留言内容：</th>
      <td colspan="3" class="list_cell_bg">
          <textarea class="input03" onkeypress="if(event.keyCode==13){doSub();}" name="message" style="width: 350px;height:80px; font-size:14px; line-height:18px; padding:3px; border:#e7e8ea 1px solid; border-color:#adadaf #e7e8ea #e7e8ea #adadaf; font-family:Arial; color:#333; resize:none;" id="zd_message">您好，我对<%=agentMap.get("full_name") %>的产品感兴趣，想要咨询，请您给我回复，谢谢。</textarea>
      </td>
    </tr>
    <tr>
      <td height="22" align="center" nowrap="nowrap">&nbsp;</td>
      <td height="22" colspan="3">
        <span class="list_cell_bg" style="margin-left:15px">
          <input type="hidden" name="tableName" id="tableName" value="pro_product_form" />
        </span>
      </td>
    </tr>
  </tbody></table>
  <input type="hidden" name="contact_address" id="contact_address" value="<%=province %><%=city %>" />
  <input type="hidden" name="agentid" id="agentid" value="<%=agentMap.get("id") %>" />
  <input type="hidden" name="agentname" id="agentname" value="<%=agentMap.get("full_name") %>" />
   <input type="hidden" name="factoryid" id="factoryid" value="<%=nowBrand %>" />
   <input type="hidden" name="factoryname" id="factoryname" value="<%=nowBrandName %>" />
   <input type="hidden" name="catanum" id="catanum" value="<%=nowCatalog %>" />
   <input type="hidden" name="cataname" id="cataname" value="<%=nowCatalogName %>" />
    <input type="hidden" name="province" id="province" value="<%=province %>" />
    <input type="hidden" name="city" id="city" value="<%=city %>" />
</form>
</div>
</body>
</html>
<script type="text/javascript">
var xunjia_user = jQuery.cookies.get("xunjia_user");
var xunjia_phone = jQuery.cookies.get("xunjia_phone");
if(null!=xunjia_user){
	jQuery("#user_name").val(xunjia_user);
	jQuery("#contact_tel").val(xunjia_phone);
}
jQuery("input[name=ifgroup]").click(function(){
	if(this.value=="公司"){
		jQuery("#company").show();
	}else{
		jQuery("#company").hide();
	}
});
function doSub(){
	if(!vaPhone()){
		return false;
	}
	var rs = Validator.Validate(document.getElementById("theform"),1);
	if(rs){
		jQuery("#theform").ajaxSubmit({
			type : "POST",
			async : false,
			success : function(data) {
				jQuery.cookies.set("xunjia_user",jQuery("#user_name").val(),{
					hoursToLive : 2
				});
				jQuery.cookies.set("xunjia_phone",jQuery("#contact_tel").val(),{
					hoursToLive : 2
				});
				alert("您的询价信息已经成功发送！");
			}
		});
		parent.jQuery.jBox.close();
	}
}
function vaPhone(){
	var mobile_phone_reg = /^1([\d]{10})$/;
	var connect_reg=/^((0\d{2,3})-)(\d{7,8})(-(\d{3,}))?$/;
	if ((null == jQuery("#contact_tel").val() || jQuery("#contact_tel").val().length == 0)) {
		alert("请输入您的手机或固定电话！");
		setTimeout(function() {
		 	jQuery("#contact_tel").focus();
		},10);
		return false;
	}
	if (jQuery("#contact_tel").val().length != 0 && (!mobile_phone_reg.test(jQuery('#contact_tel').attr("value"))&&!connect_reg.test(jQuery('#contact_tel').attr("value")))) {
		alert("请输入正确的电话号码！如:0535-6792733");
		setTimeout(function() {
			jQuery("#contact_tel").focus();
			jQuery("#contact_tel").select(); 
		},10);
		return false;
	}
	return true;
}
</script>