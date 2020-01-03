<%@ page language="java" import="java.util.*,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*,java.sql.*,com.jerehnet.webservice.*,org.json.*" pageEncoding="UTF-8"%><%
	String usern = CommonString.getFormatPara(request.getParameter("usern"));
	DBHelper dbHelper = DBHelper.getInstance();
	Connection connection = null;
	try{
		connection = dbHelper.getConnection();
		Map map = dbHelper.getMap(" select * from pro_agent_factory where usern = ? ",new Object []{usern},connection);
		if(map == null){
			Common.do302(response,"/agent");
			return;
		}
		Integer is_shop = CommonString.getFormatInt(map.get("is_shop"));
		if(is_shop.equals(2)||is_shop.equals(3)){
			Common.do302(response,"/agentshop/"+CommonString.getFormatPara(map.get("usern"))+"/");
			return;
		}
		// 预计购买时间
		LinkedHashMap buyTimeMap = (LinkedHashMap)CommonApplication.getEnumChildrenLink("102",application) ;
		String ip  = request.getHeader("x-forwarded-for");
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("X-Real-IP");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("Proxy-Client-IP");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("WL-Proxy-Client-IP");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getRemoteAddr();
		}
		Object [] pArr = WEBServiceUtil.executeDynamic("Area","getMyProvinceAndCity",new Object [] {
				ip
		});
		String objStr = (String)pArr[0];
		JSONObject obj = new JSONObject(objStr);
		String city = "";
		String province = "";
		if(null!=obj&&obj.length()>0){
			province = CommonString.getFormatPara(obj.getString("province"));
			city = CommonString.getFormatPara(obj.getString("city"));
		}
		Integer newsCount = (Integer)dbHelper.getOne(" select count(*) from pro_agent_news where agent_id = ? and is_approval = 1 ",new Object [] {
				map.get("id")
			},connection);
%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="author" content="design by www.21-sun.com" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<title>工程机械--中国工程机械商贸网</title>
<link href="/style/style.css" rel="stylesheet" type="text/css" />
<link type="text/css" rel="stylesheet" href="/scripts/jBox-v2.3/Skins2/Blue/jbox.css"/>
<script type="text/javascript" src="/scripts/jquery-1.7.min.js"></script>
<script type="text/javascript" src="/scripts/jquery.form.js"></script>
<script type="text/javascript" src="/scripts/scripts.js"></script>
<script type="text/javascript" src="/scripts/citys.js"></script>
<script type="text/javascript" src="/plugin/jquery/jquery.cookies.2.2.0.min.js"></script>
<script type="text/javascript" src="/scripts/jBox-v2.3/jquery.jBox-2.3.min.js"></script>
<script type="text/javascript" src="/scripts/jBox-v2.3/i18n/jquery.jBox-zh-CN.js"></script>
<script type="text/javascript" src="/scripts/rememberAccount.js"></script>
<script type="text/javascript" src="/plugin/tip/yitip/jquery.yitip.js"></script>
</head>
<body>
<!--top-->
<jsp:include page="/include/top.jsp" flush="true" />
<!--面包屑-->
<div class="contain980 mb10">
  <h3 class="breadCrumbs">您现在所在的位置：<a href="/">工程机械产品中心</a> &gt;&gt; <a href="/agent/">代理商专区</a> &gt;&gt; <%=CommonString.getFormatPara(map.get("full_name")) %></h3>
</div>
<!--面包屑结束--> 
<!--广告-->
<div class="contain980 mb10"><img src="/images/ad04.jpg" width="980" height="60" /></div>
<!--广告结束--> 
<!--main-->
<div class="contain980 mb10">
  <div class="asiteTop mb10">
    <div class="wfull l">
      <div class="comInfo">
        <h2 class="l"><%=CommonString.getFormatPara(map.get("full_name"))%></h2>
        <span class="r"><%if(!CommonString.getFormatPara(map.get("logo")).equals("")){%><img src="/uploadfiles/<%=CommonString.getFormatPara(map.get("logo"))%>" width="172" height="46" /><%}%></span> </div>
      <!--<div class="tel l">销售专线：<%=CommonString.getFormatPara(map.get("telphone"))%></div>-->
        <%
      	if(newsCount>0){
      		%><ul class="agentNav r" style="width: 583px;"><%
      	}else{
      		%><ul class="agentNav r"><%
      	}
      %>
        <li><a href="/agent/<%=usern%>/">代理商首页</a></li>
        <li><a href="/agent/<%=usern%>/introduce.shtm">公司简介</a></li>
        <li><a href="/agent/<%=usern%>/agent_products.shtm">代理机型</a></li>
        <li class="anSelect"><a href="/agent/<%=usern%>/agent_message.shtm">在线询价</a></li>
        <%
        	if(newsCount>0){
        		%>
        		 <li><a href="/agent/<%=usern%>/agent_news.shtm">企业动态</a></li>
        		<%
        	}
        %>
      </ul>
    </div>
  </div>
  <!--left-->
  <div class="w270 l"> 
    <!--公司介绍-->
    <div class="agentInfo mb10">
      <div class="agentInfobg">
        <h2><%=CommonString.getFormatPara(map.get("full_name"))%></h2>
        <div class="agentInfoDetail">
         <%if(!CommonString.getFormatPara(map.get("city")).equals("")){%>代理地区：<%=CommonString.getFormatPara(map.get("city"))%> <br /><%}%>
          <%if(!CommonString.getFormatPara(map.get("address")).equals("")){%>地址：<%=CommonString.getFormatPara(map.get("address"))%><br /><%}%>
          <%if(!CommonString.getFormatPara(map.get("postcode")).equals("")){%>邮编：<%=CommonString.getFormatPara(map.get("postcode"))%> 　 <br /><%}%>
         <%if(!CommonString.getFormatPara(map.get("concatus")).equals("")){%> 联系人：<%=CommonString.getFormatPara(map.get("concatus"))%> <br /><%}%>
          <%if(!CommonString.getFormatPara(map.get("area")).equals("")){%>主要经营：<%=CommonString.getFormatPara(map.get("area")).length()>=100?CommonString.getFormatPara(map.get("area")).substring(0,100)+"...":CommonString.getFormatPara(map.get("area"))%><br /><%}%>
         <%if(!CommonString.getFormatPara(map.get("agent_fac_name")).equals("")){%> 代理品牌：<font><%=CommonString.getFormatPara(map.get("agent_fac_name"))%></font><%}%>
         </div>
        <div class="more01 blue">
        	        <%
        	if("".equals(CommonString.getFormatPara(map.get("mobile_phone")))){
        		%>
        <div class="agent_li" style="width: auto; border: none;"><ul style="border: none;"><li class="g5"><a id="seePhone_<%=map.get("id") %>" style="text-align: left;" href="javascript:void(0);" onclick="lianXiDianHua('<%=map.get("id") %>');">点击查看联系电话</a></li></ul></div>
        		<%
        	}else{
        		%>
        <div class="agent_li" style="width: auto; border: none;"><ul style="border: none;"><li class="g5" style="width:130px;overflow:hidden;text-align: left;"><a class="gcur" href="javascript:void(0);">暂无联系方式</a></li></ul></div>
        		<%
        	}
        %>
       <div style="float: right;"><a href="/agent/<%=usern%>/introduce.shtm">更多介绍 &gt;&gt;</a></div>
       </div>
      </div>
    </div>
    <!--公司介绍结束--> 
    <!--主营品牌-->
    <div class="agentLeftPart mb10" id="brandId">
      
    </div>
    <!--主营品牌结束--> 
  </div>
  <!--left end--> 
  <!--right-->
  <div class="w697 r"> 
    <!--免费询价-->
<div style="font-size:14px; height:15px; line-height:12px; padding:10px 0px 10px 15px;font-weight:bold; background:#f1f1f1">
在线询价</div>
<div class="orderbg" style="margin:0px 0px 0px 10px;">
  <form action="/action/order_save.jsp" method="post" name="theform" id="theform" onsubmit="return submitYN(this);">
    <table width="95%"  border="0" align="center" cellpadding="0" cellspacing="0" class="list_border_bg" style="margin-top:15px;">
      <tr>
        <th height="22" align="right" nowrap="nowrap" class="list_left_title">姓&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;名：</th>
        <td height="22" nowrap="nowrap" class="list_cell_bg "><input class="input01" name="zd_name" type="text" id="zd_name" size="30" maxlength="20" />
          *</td>
      </tr>
       <tr>
        <th align="right" nowrap="nowrap" class="list_cell_bg" style="padding:10px 0px;">手机/固话：</th>
        <td nowrap="nowrap" class="list_cell_bg"><input class="input01" name="zd_mobile_phone" type="text" id="zd_mobile_phone" size="30" maxlength="15" />
          *</td>
      </tr>
      <tr>
      <th height="22" align="right" nowrap="nowrap" class="list_left_title">地&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;区：</th>
     <td><select name="zd_province" id="zd_province" onChange="set_city(this,this.value,theform.zd_city,'');" style="width:87px;"  dataType="Require"  msg="请选择省份">
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
        <select  name="zd_city" id="zd_city"  style="width:100px;" dataType="Require"  msg="请选择城市">
          <option value="">选择城市</option>
        </select>*</td></tr>
               <tr>
              <th height="22" align="right" nowrap="nowrap" class="list_left_title" style="padding:5px 0px;">采购性质：</th>
              <td height="22" nowrap="nowrap" class="list_cell_bg "><input class="input01" name="zd_ifgroup" type="radio" checked value="个人" />
                <font color="#434343">个人</font>
                <input class="input01" name="zd_ifgroup" type="radio"  value="公司" />
                <font color="#434343">公司</font>
                <input type="text" value="公司名字" id="zd_company" name="zd_company" style="display:none;" />
                *</td>
            </tr>
        <tr>
        <th align="right" nowrap="nowrap" class="list_cell_bg" style="padding:5px 0px;">预计购买时间：</th>
        <td nowrap="nowrap" class="list_cell_bg">
     	 <select name="zd_buy_time" id="zd_buy_time" >
     	 <%=CommonForm.createSelect(buyTimeMap,"1个月内")	 %>
     	 </select>
          *</td>
      </tr>
      <tr>
        <th height="22" align="right" nowrap="nowrap" class="list_left_title">留言内容：</th>
        <td height="22" colspan="3" class="list_cell_bg" style="padding:0 0 10px 0;"><textarea class="input03" name="zd_message" cols="77" rows="5"  id="zd_message"></textarea></td>
      </tr>
      <tr>
        <td height="22" align="center" nowrap="nowrap" >&nbsp;</td>
        <td height="22" colspan="3" style="padding-top:5px; padding-left:10px;">
        <input class="orderBtn01" name="Submit" type="submit" value="提交"/>
          <span class="list_cell_bg" style="margin-left:15px">
        <!--   <input name="zd_id" type="hidden" id="zd_id" value="0" />  -->
          <%
					String mytag = CommonString.getFormatPara(request.getParameter("mytag"));
					if("".equals(mytag)){
						mytag = "3";
					}
				%>
          <input type="hidden" name="tableName" id="tableName" value="pro_product_form"/>
          </span></td>
      </tr>
    </table>
    <input type="hidden" name="zd_contact_address" id="zd_contact_address" />
    <input type="hidden" name="zd_agentid" id="zd_agentid" value="<%=CommonString.getFormatPara(map.get("id")) %>"/>
    <input type="hidden" name="zd_agentname" id="zd_agentname" value="<%=CommonString.getFormatPara(map.get("name")) %>"/>
    <input type="hidden" name="zd_ifgroup" id="zd_ifgroup" value="个人"/>
          <!-- 属于公司或个人 -->
  </form>
</div>
<script type="text/javascript">
jQuery("#zd_message").text("您好，我对<%=CommonString.getFormatPara(map.get("full_name"))%>的产品感兴趣，想要咨询，请您给我回复，谢谢。");
function submitYN(event) {
	var mobile_phone_reg = /^1([\d]{10})$/;
	 var connect_reg=/^((0\d{2,3})-)(\d{7,8})(-(\d{3,}))?$/;
	 // var connect_reg = /^(([0\+]\d{2,3}-)?(0\d{2,3})-)?(\d{7,8})(-(\d{3,}))?|(0([\d]{10}))$/;
	var emailreg = /^([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+@([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+\.[a-zA-Z]{2,3}$/;
	if (null == jQuery("#zd_name").val() || jQuery("#zd_name").val().length == 0) {
		alert("请输入您的姓名!");
		setTimeout(function() {
			jQuery("#zd_name").focus();
		},
		0);
		return false;
	}
	if ((null == jQuery("#zd_mobile_phone").val() || jQuery("#zd_mobile_phone").val().length == 0)) {
		alert("请输入您的手机或固定电话！");
		setTimeout(function() {
		 	jQuery("#zd_mobile_phone").focus();
		},
		10);
		return false;
	}
	if(jQuery("#zd_ifgroup").val()=='公司'){
		if(jQuery("#zd_company").val()=='公司名字' || jQuery.trim(jQuery("#zd_company").val())==''){
			jQuery.jBox.tip("请输入公司名字") ;
			jQuery("#zd_company").focus() ;
			return false ;
		}
	}
	if (jQuery("#zd_mobile_phone").val().length != 0 && (!mobile_phone_reg.test(jQuery('#zd_mobile_phone').attr("value"))&&!connect_reg.test(jQuery('#zd_mobile_phone').attr("value")))) {
		alert("请输入正确的电话号码!");
		setTimeout(function() {
			jQuery("#zd_mobile_phone").focus();
			jQuery("#zd_mobile_phone").select(); 
		},
		10);
		return false;
	}
	jQuery("#zd_contact_address").val(jQuery("#zd_province").val()+jQuery("#zd_city").val()) ;
	jQuery("#theform").ajaxSubmit(function(msg){
			if("0"!=jQuery.trim(msg)){
				jQuery.jBox.tip("提交成功！") ;
					// 询价成功，把用户名和电话放入 cookie 中
				 SetCookie("order_name",jQuery("#zd_name").val()) ;
				 SetCookie("order_phone",jQuery("#zd_mobile_phone").val()) ;
				jQuery("#zd_mobile_phone").val("");
				jQuery("#zd_message").val("");
			}
		}) ;
		return false ;
}
jQuery.getScript("http://int.dpool.sina.com.cn/iplookup/iplookup.php?format=js",function(){
	var province = remote_ip_info["province"];
	var city = remote_ip_info["city"];
	jQuery("#zd_province option:contains("+province+")").attr("selected",true);
	set_city(document.getElementById("zd_province"),document.getElementById("zd_province").value,document.theform.zd_city,'');
	document.getElementById("zd_city").value = city;
	 jQuery("#zd_contact_address").val(province+city) ;
}) ;

</script>
    <!--免费询价结束--> 
  </div>
  <!--right end-->
  <div class="clear"></div>
</div>
<!--main end--> 
<!--foot-->
<jsp:include page="/include/foot.jsp" flush="true" />
<!--end of foot-->
<script type="text/javascript" src="/scripts/sort.js"></script>
<script language="javascript" type="text/javascript">
	//主营品牌
	jQuery.ajax({
		url:"/action/ajax_list.jsp",
		type:"post",
		data:{"flag":"brandAgentCatalogList","agentid":"<%=CommonString.getFormatPara(map.get("id"))%>","agent_fac":"<%=CommonString.getFormatPara(map.get("agent_fac"))%>","agent_fac_name":"<%=CommonString.getFormatPara(map.get("agent_fac_name"))%>","usern":"<%=usern%>"},
		success:function(data){
			jQuery("#brandId").html(jQuery.trim(data));	
			if(jQuery.trim(data)==""){
				jQuery("#brandId").removeClass("agentLeftPart mb10");	
			}
		}
	});
	jQuery.getScript("http://int.dpool.sina.com.cn/iplookup/iplookup.php?format=js",function(){
		var province = remote_ip_info["province"];
		var city = remote_ip_info["city"];
		jQuery("#zd_contact_address").val(province+city) ;
	 }) ;
		jQuery("#zd_mobile_phone").focus(function(){
			jQuery(this).val("") ;
		});
	
	function checkYZ(){
		if(""==jQuery.trim(jQuery("#zd_message").val()) || "填写您的询价内容，我们的工作人员会及时和您联系"==jQuery.trim(jQuery("#zd_message").val())){
			alert("请输入询价内容！") ;
			setTimeout("jQuery('#zd_message').focus() ;",0) ;
			return false ;
			}
		if(""==jQuery.trim(jQuery("#zd_mobile_phone").val()) || "留下联系方式，与您及时联系"==jQuery.trim(jQuery("#zd_mobile_phone").val())){
			alert("请输入您的联系方式！") ;
			jQuery("#zd_mobile_phone").focus() ;
			return false ;
		}
		jQuery("#zd_name").val(jQuery("#zd_mobile_phone").val()) ;
		// return false ;
	}
		// 把下过订单的信息取出
jQuery(function(){
	var order_name = jQuery.trim(unescape(GetCookie("order_name"))) ;  // 订单人
    var order_phone = jQuery.trim(GetCookie("order_phone")) ;  // 订单电话
    if(''!=order_name && null!=order_name && "null"!=order_name){
    	jQuery("#zd_name").val(order_name) ;
    }
    if(''!=order_phone && null!=order_phone && "null"!=order_name){
    	jQuery("#zd_mobile_phone").val(order_phone) ;
    }
})
jQuery("input:radio").bind("click",function(){
	jQuery("#zd_ifgroup").val(jQuery(this).val()) ;  // 个人或公司
	if(jQuery(this).val()=='公司'){
		jQuery("#zd_company").attr("style","width:150px;") ;
	}else{
		jQuery("#zd_company").attr("style","display:none;") ;
	}
}) ;
jQuery("#zd_company").focus(function(){
	if(jQuery(this).val()=='公司名字'){
	   jQuery(this).val("") ;
	}
});

	function lianXiDianHua(id){
		var xunjia_user = jQuery.cookies.get("xunjia_user");
		if(null!=xunjia_user){
			seePhone(id);
			return;
		}
		jQuery.jBox("iframe:/include/agent/show_phone.jsp?id="+id,{
			title : "查看联系电话",
			width : 400,
			height : 290,
			top: '35%',
			buttons : {"确定":true,"关闭":false},
			submit : function(v,h,f){
				if(v){
					var ifrm = jQuery.jBox.getIframe();
					var subSr = ifrm.contentWindow.doSub();
					return subSr;
				}
			}
		});
	}
	function seePhone(id){
		jQuery.post("/tools/ajax.jsp",{flag:'viewPhoneClickCount',id:id});
		var xunjia_user = jQuery.cookies.get("xunjia_user");
		var xunjia_phone = jQuery.cookies.get("xunjia_phone");
		var xunjia_catalog = jQuery.cookies.get("xunjia_catalog");
		var xunjia_catalog_name = jQuery.cookies.get("xunjia_catalog_name");
		var xunjia_brand = jQuery.cookies.get("xunjia_brand");
		var xunjia_brand_name = jQuery.cookies.get("xunjia_brand_name");
		jQuery.post("/tools/ajax.jsp",{
			flag : 'seePhone',
			name : xunjia_user,
			mobile_phone : xunjia_phone,
			province : '<%=province %>',
			city : '<%=city %>',
			catalog : xunjia_catalog,
			catalogName : xunjia_catalog_name,
			brand : xunjia_brand ,
			brandName : xunjia_brand_name ,
			id : id
		},function(data){
			jQuery("#seePhone_"+id).addClass("gcur");
			jQuery("#seePhone_"+id).html(data);
			jQuery("#seePhone_"+id).attr("tip_title",data);
			jQuery("#seePhone_"+id).removeAttr("onclick");
			jQuery("#seePhone_"+id).yitip();
			var singleTitleTip = jQuery("#seePhone_"+id).yitip("api");
			singleTitleTip.setPosition("rightMiddle");
		});
	}
		jQuery.ajax({
    	type:'post',
    	url:'/action/ajax.jsp',
    	data:{flag:'getAgentViewCount',agentId:'<%=CommonString.getFormatPara(map.get("id"))%>'} ,
    	success:function(msg){
    	}
    });
</script>
</body>
</html>
<%
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		dbHelper.freeConnection(connection);
	}
%>