<%@ page language="java" import="java.util.*,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*,java.sql.*,com.jerehnet.webservice.*,org.json.*" pageEncoding="UTF-8"%><%
	String usern = CommonString.getFormatPara(request.getParameter("usern"));
		if(usern.equals("hfxy")){
%>
    <script>
	window.location.href="/agentstore/hfxy/";
	</script>
<%	
	}
	DBHelper dbHelper = DBHelper.getInstance();
	Connection connection = null;
	try{
		connection = dbHelper.getConnection();
		Map map = dbHelper.getMap(" select * from pro_agent_factory where usern = ? ",new Object []{usern},connection);
		if(map == null){
			Common.do302(response,"/agent");
			return;
		}
		Integer is_shop = CommonString.getFormatInt(map.get("is_qijiandian"));
		/*
		if(is_shop.equals(1)){
			Common.do302(response,"/agentshop/"+CommonString.getFormatPara(map.get("usern"))+"/");
			return;
		}
		*/
		// 预计购买时间
		LinkedHashMap buyTimeMap = (LinkedHashMap)CommonApplication.getEnumChildrenLink("102",application) ;
		String ip  = Common.getIp(request);
		String jsonStr = Tools.getMyProvinceAndCity(ip);
		String city = "";
		String province = "";
		if(!CommonString.getFormatPara(jsonStr).equals("")){
			JSONObject obj = new JSONObject(jsonStr);
			if(null!=obj&&obj.length()>0){
				province = CommonString.getFormatPara(obj.getString("province"));
				city = CommonString.getFormatPara(obj.getString("city"));
			}
		}
		Integer newsCount = (Integer)dbHelper.getOne(" select count(*) from pro_agent_news where agent_id = ? and is_approval = 1 ",new Object [] {
				map.get("id")
			},connection);
		List<Map> areas = dbHelper.getMapList(" SELECT area_id,area_name FROM comm_area WHERE parent_area_id = 0 ",connection);
	//代理品牌
	String dali_brand="";
	//代理产品
    String dali_pro="";
	String agent_fac_id_list=CommonString.getFormatPara(map.get("agent_fac"));
    String fac_ids_list[]=agent_fac_id_list.split(",");
	    for(int i=0;i<fac_ids_list.length;i++){
		    if(!fac_ids_list[i].equals("")){
			Map facInfo = dbHelper.getMap(" select name,usern from pro_agent_factory where id = "+fac_ids_list[i],connection);
			   dali_brand+=CommonString.getFormatPara(facInfo.get("name"));
			       List<Map> proInfo = dbHelper.getMapList("select catalognum,catalogname from pro_agent_product_vi where agentid = '"+CommonString.getFormatPara(map.get("id"))+"' and factoryid = '"+fac_ids_list[i]+"'  group by catalognum,catalogname order by catalognum",connection);
                             for(Map oneMap : proInfo){
							  dali_pro+=CommonString.getFormatPara(facInfo.get("name"))+CommonString.getFormatPara(oneMap.get("catalogname"));
		
					 }
			}
		}
%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="author" content="design by www.21-sun.com" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<title>【电话】<%=CommonString.getFormatPara(map.get("city"))%><%=dali_brand%>代理商_<%=CommonString.getFormatPara(map.get("full_name"))%></title>
<meta name="keywords" content="<%=CommonString.getFormatPara(map.get("city"))%><%=dali_brand%>代理商,<%=CommonString.getFormatPara(map.get("full_name"))%>,<%=CommonString.getFormatPara(map.get("city"))%><%=dali_brand%>" />
<meta name="description" content="<%=CommonString.getFormatPara(map.get("full_name"))%>是<%=CommonString.getFormatPara(map.get("city"))%><%=dali_brand%>代理商,代理经营<%=CommonString.getFormatPara(map.get("city"))%><%=dali_pro%>系列产品." />
<link href="/style/style.css" rel="stylesheet" type="text/css" />
<link type="text/css" rel="stylesheet" href="/scripts/jBox-v2.3/Skins2/Blue/jbox.css"/>
<script type="text/javascript" src="/scripts/jquery-1.7.min.js"></script>
<script type="text/javascript" src="/scripts/jquery.form.js"></script>
<script type="text/javascript" src="/scripts/scripts.js"></script>
<script type="text/javascript" src="/scripts/citys.js"></script>
<script type="text/javascript" src="/scripts/pinyin.js"></script>
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
  <h3 class="breadCrumbs"><a href="/">铁臂商城</a> &gt;&gt; <a href="/agent/">代理商专区</a> &gt;&gt; <%=CommonString.getFormatPara(map.get("full_name")) %></h3>
</div>
<!--面包屑结束--> 
<!--广告-->
<!-- <div class="contain980 mb10"><img src="/images/ad04.jpg" width="980" height="60" /></div> -->
<!--广告结束--> 
<!--main-->
<div class="contain980 mb10">
  <div class="asiteTop mb10">
    <div class="wfull l">
      <div class="comInfo">
        <h2 class="l"><%=CommonString.getFormatPara(map.get("full_name"))%></h2>
                <style>
        .soSpan{
         background: none repeat scroll 0 0 #E3EDF7;
	    border: 1px solid #BBBBBB;
	    color: #2D66B5;
	    display: block;
	    float: right;
	    height: 21px;
	    line-height: 21px;
	    margin-top: 10px;
	    padding: 0 15px;
	    text-align: center;
	    width: auto;
	    cursor:pointer ;
	    }
        </style>
         <span style='<%=(CommonString.getFormatPara(map.get("is_qijiandian")).equals("1")&&!CommonString.getFormatPara(map.get("is_made")).equals("1"))?"":"display:none;" %>' class="soSpan" onclick="window.open('http://<%=CommonString.getFormatPara(map.get("usern")) %>.product.21-sun.com')">进入<%=CommonString.getFormatPara(map.get("name"))%>官方旗舰店</span>
        <span class="r"><%if(!CommonString.getFormatPara(map.get("logo")).equals("")){%><img src="/uploadfiles/<%=CommonString.getFormatPara(map.get("logo"))%>" width="172" height="46" /><%}%></span> </div>
      <!--<div class="tel l">销售专线：<%=CommonString.getFormatPara(map.get("telphone"))%></div>-->
        <%if(newsCount>0){%><ul class="agentNav r" style="width: 703px;">
		<%}else{%><ul class="agentNav r" style="width: 583px;">
		<%}%>
        <li><a href="/agent/<%=usern%>/">代理商首页</a></li>
        <li><a href="/agent/<%=usern%>/introduce.shtm">公司简介</a></li>
        <li><a href="/agent/<%=usern%>/agent_products.shtm">代理机型</a></li>
        <li class="anSelect"><a href="/agent/<%=usern%>/agent_message.shtm">在线询价</a></li>
		<li><a href="/agent/agent_inquiry.jsp?usern=<%=usern%>">代理价格</a></li>
        <%if(newsCount>0){%><li><a href="/agent/<%=usern%>/agent_news.shtm">企业动态</a></li><%}%>
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
               <%if(!CommonString.getFormatPara(map.get("agent_fac")).equals("")){%> 代理品牌：
		 <%
		    String agent_fac_ids=CommonString.getFormatPara(map.get("agent_fac"));
			String fac_ids[]=agent_fac_ids.split(",");
			for(int i=0;i<fac_ids.length;i++){
			   if(!fac_ids[i].equals("")){
			   Map facInfo = dbHelper.getMap(" select name,usern from pro_agent_factory where id = "+fac_ids[i],connection);
		 %>
		 <font><a href="/brand/<%=CommonString.getFormatPara(facInfo.get("usern"))%>/"><%=CommonString.getFormatPara(facInfo.get("name"))%></a></font>
		 <%}}}%>
         </div>
        <div class="more01 blue">
        <%if("".equals(CommonString.getFormatPara(map.get("mobile_phone")))){%>
        <div class="agent_li" style="width: auto; border: none;"><ul style="border: none;"><li class="g5"><a id="seePhone_<%=map.get("id") %>" style="text-align: left;" href="javascript:void(0);" onclick="lianXiDianHua('<%=map.get("id") %>');">点击查看联系电话</a></li></ul></div>
        <%}else{%>
        <div class="agent_li" style="width: auto; border: none;"><ul style="border: none;"><li class="g5" style="width:130px;overflow:hidden;text-align: left;"><a class="gcur" href="javascript:void(0);">暂无联系方式</a></li></ul></div>
        <%}%>
       <div style="float: right;"><a href="/agent/<%=usern%>/introduce.shtm">更多介绍 &gt;&gt;</a></div>
       </div>
      </div>
    </div>
    <!--公司介绍结束--> 
    <!--主营品牌-->
    <div class="agentLeftPart mb10" id="brandId"></div>
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
        <td height="22" nowrap="nowrap" class="list_cell_bg "><input class="input01" name="zd_name" type="text" id="zd_name" size="30" maxlength="20" />*</td>
      </tr>
       <tr>
        <th align="right" nowrap="nowrap" class="list_cell_bg" style="padding:10px 0px;">手机/固话：</th>
        <td nowrap="nowrap" class="list_cell_bg"><input class="input01" name="zd_mobile_phone" type="text" id="zd_mobile_phone" size="30" maxlength="15" />*</td>
      </tr>
      <tr>
      <th height="22" align="right" nowrap="nowrap" class="list_left_title">地&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;区：</th>
     <td><select name="zd_province" id="zd_province" onChange="set_my_city(this);" style="width:87px;"  dataType="Require"  msg="请选择省份">
          <%
         			if(null!=areas&&areas.size()>0){
         				for(Map m : areas){
         					%><option value="<%=CommonString.getFormatPara(m.get("area_name")) %>" area_id="<%=CommonString.getFormatPara(m.get("area_id")) %>"><%=CommonString.getFormatPara(m.get("area_name")) %></option><%
         				}
         			}
         		%>
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
	 <input type="hidden" name="zd_contact_address" id="zd_contact_address" value="<%=province %><%=city %>" />
    <input type="hidden" name="zd_province" id="zd_province" value="<%=province %>" />
    <input type="hidden" name="zd_city" id="zd_city" value="<%=city %>" />
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
	jQuery("#zd_province").change();
	set_my_city(document.getElementById("zd_province"),city);
	// jQuery("#zd_contact_address").val(province+city) ;
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
    
    function set_my_city(o,cked){
		var area_id = o.options[o.selectedIndex].getAttribute("area_id");
		jQuery.ajax({
			url : '/tools/ajax.jsp',
			async : false,
			type : 'post',
			data : {
				flag : 'get_city',
				p : area_id
			},
			success : function(data){
				var arr = eval(data);
				var zd_city = document.getElementById("zd_city");
				zd_city.length = 1;
				var opt;
				var aname;
				var hname;
				for(var i=0;i<arr.length;i++){
					aname = arr[i].area_name;
					hname = aname;
					aname = codefans_net_CC2PY(aname).substring(0,1)+"-"+aname;
					opt = new Option(aname,hname);
					if(aname.indexOf(cked)!=-1){
						opt.selected = true;
					}
					zd_city.options.add(opt);
				}
			}
		});
	}
	jQuery(function(){
		jQuery("#zd_province option").each(function(){
			jQuery(this).text(codefans_net_CC2PY(jQuery(this).text()).substring(0,1)+"-"+jQuery(this).text());
		}) ;
	}) ;
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