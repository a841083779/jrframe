<%@ page language="java" import="java.sql.Connection,org.json.*,java.util.*,com.jerehnet.util.dbutil.*,com.jerehnet.util.common.*,com.jerehnet.webservice.*" pageEncoding="UTF-8"%><%
	DBHelper dbHelper = DBHelper.getInstance();
	Connection connection = null;
	String id = CommonString.getFormatPara(request.getParameter("id"));
	try{
		connection = dbHelper.getConnection();
		Map agentMap = dbHelper.getMap(" select * from pro_agent_factory where id = ? ",new Object [] {id});
		String objStr = Tools.getMyProvinceAndCity(Common.getIp(request));
		JSONObject obj = new JSONObject(objStr);
		String city = "烟台";
		String province = "山东";
		if(null!=obj&&obj.length()>0){
			province = CommonString.getFormatPara(obj.getString("province"));
			city = CommonString.getFormatPara(obj.getString("city"));
		}
		List<Map> catalogs = dbHelper.getMapList(" select id,name,num from pro_catalog where len(num) = 3 ",connection);
		List<Map> brands = dbHelper.getMapList(" select id,name from pro_agent_factory where flag = 1 and is_show = 1 ",connection);
		String name = "";
		String pinyin = "";
		for(Map m : brands){
			name = CommonString.getFormatPara(m.get("name"));
			pinyin = CnToFullSpell.getFirstSpell(name).substring(0,1);
			m.put("pinyin",pinyin);
		}
		Collections.sort(brands,new java.util.Comparator(){
			public int compare(Object o1, Object o2) {
				Map m1 = (Map)o1;
				Map m2 = (Map)o2;
				return m1.get("pinyin").toString().compareTo(m2.get("pinyin").toString());
			}
		});
		LinkedHashMap brandMap = new LinkedHashMap();
		for(Map m : brands){
			pinyin = CommonString.getFormatPara(m.get("pinyin"));
			if(pinyin.matches("[A-Z]")){
				brandMap.put(CommonString.getFormatPara(m.get("id")), pinyin+ " " + CommonString.getFormatPara(m.get("name")));
			}
		}
		String agent_fac = CommonString.getFormatPara(agentMap.get("agent_fac"));
		String [] agentFacArr = null;
		if(!"".equals(agent_fac)){
			agentFacArr = agent_fac.split(",");
			if(null!=agentFacArr&&agentFacArr.length>1){
				agent_fac = agentFacArr[0];
			}
		}
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
  
  <body style="overflow: hidden;">
  <form action="" name="theform" id="theform">
	<div class="orderbg" style="margin:0px 0px 0px 10px; padding-top:10px;">
    <table width="95%" border="0" align="center" cellpadding="0" cellspacing="0" class="list_border_bg">
      <tbody>
      <tr>
      	<th colspan="2" style="font-weight:normal; color:#999; text-align:left; padding-left:20px;">
      		输入您的姓名和电话，即可查看此代理商联系信息
      	</th>
      </tr>
      <tr>
        <th align="right">意向品牌：</th>
        <td nowrap="nowrap" class="list_cell_bg ">
        	<select name="brand" id="brand" style="width: 225px;" datatype="Require" msg="请选择品牌">
	          <option value="">--品牌--</option>
	          <%=CommonForm.createSelect(brandMap,agent_fac) %>
	        </select>*
        </td>
      </tr>
      <tr>
        <th align="right">意向类型：</th>
        <td nowrap="nowrap" class="list_cell_bg ">
        	<select name="catalog" id="catalog" style="width: 225px;" datatype="Require" msg="请选择类型">
	          <option value="">--类型--</option>
	          <%
	         	List<Map> sub_catalogs = null;
		  		for(Map m : catalogs){
		  			sub_catalogs = dbHelper.getMapList(" select id,name,num from pro_catalog where len(num) = 6 and num like '"+m.get("num")+"%' ",connection);
		  			%><option value="<%=m.get("num") %>"><%=m.get("name") %></option><%
		  			if(null!=sub_catalogs&&sub_catalogs.size()>0){
		  				for(Map m1 : sub_catalogs){
		  					%><option value="<%=m1.get("num") %>">&nbsp;&nbsp;&nbsp;&nbsp;<%=m1.get("name") %></option><%
		  				}
		  			}
		  		}
	          %>
	        </select>*
        </td>
      </tr>
      <tr>
        <th align="right">姓<span style="margin-left: 30px;"></span>名：</th>
        <td nowrap="nowrap" class="list_cell_bg "><input onkeypress="if(event.keyCode==13){jQuery('#zd_mobile_phone').focus();}" class="input01" name="zd_name" datatype="Require" msg="请输入姓名" type="text" id="zd_name" size="30" maxlength="20" />*</td>
      </tr>
       <tr>
        <th align="right">联系电话：</th>
        <td nowrap="nowrap" class="list_cell_bg"><input onkeypress="if(event.keyCode==13){doSub();}" class="input01" name="zd_mobile_phone" type="text" id="zd_mobile_phone" size="30" maxlength="15" />*</td>
      </tr>
    </tbody>
    </table>
</div>
</form>
  </body>
</html>
<script type="text/javascript">
var xunjia_user = jQuery.cookies.get("xunjia_user");
var xunjia_phone = jQuery.cookies.get("xunjia_phone");
var xunjia_zuoji = jQuery.cookies.get("xunjia_zuoji");
var xunjia_shouji = jQuery.cookies.get("xunjia_shouji");
if(null!=xunjia_user){
	jQuery("#zd_name").val(xunjia_user);
	jQuery("#zd_mobile_phone").val(xunjia_phone);
	jQuery("#zuoji").val(xunjia_zuoji);
	jQuery("#shouji").val(xunjia_shouji);
}
function doSub(){
	if(!vaPhone()){
		return false;
	}
	var rs = Validator.Validate(document.getElementById("theform"),1);
	if(rs){
		jQuery.cookies.set("xunjia_user",jQuery("#zd_name").val(),{
					hoursToLive : 2
				});
		jQuery.cookies.set("xunjia_phone",jQuery("#zd_mobile_phone").val(),{
					hoursToLive : 2
				});
		jQuery.cookies.set("xunjia_zuoji",jQuery("#zuoji").val(),{
					hoursToLive : 2
				});
		jQuery.cookies.set("xunjia_shouji",jQuery("#shouji").val(),{
					hoursToLive : 2
				});
		jQuery.cookies.set("xunjia_catalog",jQuery("#catalog").val(),{
					hoursToLive : 2
				});
		var xunjia_catalog_name = document.getElementById("catalog").options[document.getElementById("catalog").selectedIndex].innerHTML;
		xunjia_catalog_name = xunjia_catalog_name.replace("&nbsp;","");
		xunjia_catalog_name = xunjia_catalog_name.replace("&nbsp;","");
		xunjia_catalog_name = xunjia_catalog_name.replace("&nbsp;","");
		xunjia_catalog_name = xunjia_catalog_name.replace("&nbsp;","");
		jQuery.cookies.set("xunjia_catalog_name",xunjia_catalog_name,{
					hoursToLive : 2
				});
		jQuery.cookies.set("xunjia_brand",jQuery("#brand").val(),{
					hoursToLive : 2
				});
		var xunjia_brand_name = document.getElementById("brand").options[document.getElementById("brand").selectedIndex].innerHTML;
		if(xunjia_brand_name.indexOf(" ")!=-1){
			xunjia_brand_name = xunjia_brand_name.split(" ")[1];
		}
		jQuery.cookies.set("xunjia_brand_name",xunjia_brand_name,{
					hoursToLive : 2
				});
		parent.seePhone('<%=id %>'); 
		jQuery.ajax({
		  url:'/tools/ajax.jsp' ,
		  type:'post' ,
		  async:true,
		  data:{
		     flag:'pro_agent_phone_view',
		     province:'<%=province%>',
		     city:'<%=city%>',
		     brand:jQuery("#brand").val(),
		     catalog:jQuery("#catalog").val(),
		     name:jQuery("#zd_name").val(),
		     mobile_phone:jQuery("#zd_mobile_phone").val()
		     },
		  success:function(msg){}
		});
		parent.jQuery.jBox.close();
	}
}

function vaPhone(){
	var mobile_phone_reg = /^1([\d]{10})$/;
	var connect_reg=/^((0\d{2,3})-)(\d{7,8})(-(\d{3,}))?$/;
	if ((null == jQuery("#zd_mobile_phone").val() || jQuery("#zd_mobile_phone").val().length == 0)) {
		alert("请输入您的手机或固定电话！");
		setTimeout(function() {
		 	jQuery("#zd_mobile_phone").focus();
		},10);
		return false;
	}
	if (jQuery("#zd_mobile_phone").val().length != 0 && (!mobile_phone_reg.test(jQuery('#zd_mobile_phone').attr("value"))&&!connect_reg.test(jQuery('#zd_mobile_phone').attr("value")))) {
		alert("请输入正确的电话号码！如:0535-6792733");
		setTimeout(function() {
			jQuery("#zd_mobile_phone").focus();
			jQuery("#zd_mobile_phone").select(); 
		},10);
		return false;
	}
	return true;
}
</script>
<%
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		DBHelper.freeConnection(connection);
	}
%>