<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*,com.jerehnet.util.common.CommonString,com.jerehnet.util.common.CommonApplication,java.util.LinkedHashMap,java.util.List,java.util.Map,com.jerehnet.util.common.Common,com.jerehnet.util.dbutil.DBHelper" errorPage="" %>
<%@page import="com.jerehnet.util.common.CommonHtml"%><%
String usern = CommonString.getFormatPara(request.getParameter("usern"));
DBHelper dbHelper = DBHelper.getInstance();
Connection connection = null;
String factoryid = "" ;
try{
	connection = dbHelper.getConnection();
	Map map = dbHelper.getMap(" select * from pro_agent_factory where usern = ? ",new Object []{usern},connection);
	if(map == null){
		Common.do302(response,"/agent");
		return;
	}
	if(map != null && !CommonString.getFormatPara(map.get("is_qijiandian")).equals("3")){ // 使用模板二
		Common.do302(response,"/agent/"+CommonString.getFormatPara(request.getParameter("usern"))+"/");
		return;	
	}
	factoryid = CommonString.getFormatPara(map.get("agent_fac")) ;  // 代理的品牌
	String agentid =CommonString.getFormatPara(map.get("id")) ;  // 代理商的品牌
	String sel_sql = " select * from pro_agent_product_vi where factoryid in("+factoryid.substring(0,factoryid.length()-1)+") and recommend=1 and agentid=?" ;
	List<Map> productsList = null ;
	if(!"".equals(factoryid)){
		if(factoryid.charAt(factoryid.length()-1)==','){
			productsList = dbHelper.getMapList(sel_sql,new Object[]{agentid}) ;
		}else{
		sel_sql = " select  * from pro_agent_product_vi where factoryid in("+factoryid.replace(",,",",")+") and recommend=1 and agentid=?" ;
		productsList = dbHelper.getMapList(sel_sql,new Object[]{agentid}) ;
		}
	}
// 预计购买时间
LinkedHashMap buyTimeMap = (LinkedHashMap)CommonApplication.getEnumChildrenLink("102",application) ;
Integer newsCount = (Integer)dbHelper.getOne(" select count(*) from pro_agent_news where agent_id = ? and is_approval = 1 ",new Object [] {
		map.get("id")
	},connection);

String whereStr = "";
String offset = CommonString.getFormatPara(request.getParameter("offset"));
String agent_area = CommonString.getFormatPara(map.get("city")) ;  // 代理商代理地区
String agent_factory = CommonString.getFormatPara(map.get("agent_fac")) ;  // 代理品牌
String[] agent_factorys = null ;
String agent_factory_str = "" ;
 if(agent_factory.length()>0 && agent_factory.indexOf(",")>0){
	 agent_factorys = agent_factory.split(",") ;
 }else{
	 whereStr+=" and factoryid="+agent_factory ;
 }
 if(null!=agent_factorys){
	 for(int i=0;i<agent_factorys.length;i++){
		 if(agent_factorys[i].length()>0 ){
			 agent_factory_str+=agent_factorys[i]+"," ;
		 }
	 }
 }
 if(agent_factory_str.length()>0 && agent_factory_str.lastIndexOf(",")!=0){
	 agent_factory_str = agent_factory_str.substring(0,agent_factory_str.length()-1) ;
 }
 if(agent_factory_str.length()>0){
	 whereStr += " and factoryid in("+agent_factory_str+")" ;
 }
 if(agent_area.length()>0 && agent_area.indexOf(",")==-1){ 
	  whereStr+= " and contact_address like'%"+agent_area+"%'" ;
 }
 String where = "" ;
 if(agent_area.length()>0 && agent_area.indexOf(",")>0){  // 代理多个区域
	 String[] agent_areas = agent_area.split(",") ;
	 for(int i=0;i<agent_areas.length;i++){
		 where+=" or contact_address like '%"+agent_areas[i]+"%'" ;
	 }
 }
 if(where.length()>0 && where.indexOf("or")>0){
	 where = where.replaceFirst("or","") ;
 }
 if(where.length()>0){
	 whereStr+= " and ( "+where+" )" ;
 }
String show_agent_order = CommonString.getFormatPara(map.get("show_agent_order")) ;

//订单
String orderSql = "select top 15 * from pro_product_form where 1=1 "+whereStr+" order by add_date desc";
List<Map> orderList = dbHelper.getMapList(orderSql,connection);
%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"> 
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="author" content="design by www.21-sun.com" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<title><%="在线询价_"+CommonString.getFormatPara(map.get("full_name"))%>-中国工程机械商贸网</title>
<meta name="keywords" content="在线询价,<%= CommonString.getFormatPara(map.get("full_name"))%>,工程机械" />
<meta name="description" content="中国工程机械商贸网提供<%= CommonString.getFormatPara(map.get("full_name"))%>在线询价栏目，让您对<%= CommonString.getFormatPara(map.get("full_name"))%>更加了解，欢迎光临<%= CommonString.getFormatPara(map.get("full_name"))%>品牌旗舰店。" />
<link href="/style/style.css" rel="stylesheet" type="text/css" />
<link href="/style/shop02.css" rel="stylesheet" type="text/css" />
<link type="text/css" rel="stylesheet" href="/scripts/jBox-v2.3/Skins2/Blue/jbox.css"/>
<script type="text/javascript" src="/scripts/jquery-1.7.min.js"></script>
<script type="text/javascript" src="/scripts/jquery.form.js"></script>
<script type="text/javascript" src="/scripts/scripts.js"></script>
<!--[if (IE 6)]>
<script src="/scripts/iepng.js" type="text/javascript"></script>
<script type="text/javascript">
EvPNG.fix('div,ul,img,li,input,td,a'); 
</script>
<![endif]-->
<script type="text/javascript" src="/scripts/pinyin.js"></script>
</head>
<body class="style02">
<!--top-->
<jsp:include page="/brandshop/include/top.jsp" flush="true"></jsp:include>
<!--top end--> 
<!--面包屑-->
<div class="sTop00 whitebg">
  <div class="contain980">
    <h3 class="breadCrumbs">您现在所在的位置：<a href="/">工程机械产品中心</a> &gt;&gt; <a href="/agent/">代理商专区</a> &gt;&gt; <%=CommonString.getFormatPara(map.get("full_name")) %></h3>
  </div>
</div>
<!--面包屑结束-->
<div class="sTop01">
  <div class="contain980 h93px">
    <h2 class="companyName"> <%=CommonString.getFormatPara(map.get("full_name"))%><span class="intro"><%=CommonString.getFormatPara(map.get("sub_title")) %></span> </h2>
    <div class="approve">
      <div class="star"><span class="star01"></span></div>
    </div>
  </div>
      <!--banner-->
       <!-- 三张banner图 -->
     <%
     String agentbanner =CommonString.getFormatPara(map.get("agentbanner"))  ;
     String agentbanner2 =CommonString.getFormatPara(map.get("agentbanner2"))  ;
     String agentbanner3 =CommonString.getFormatPara(map.get("agentbanner3"))  ;
     %>
     <jsp:include page="agent_banners.jsp" flush="true">
      <jsp:param value="<%=agentbanner%>" name="agentbanner"/>
      <jsp:param value="<%=agentbanner2 %>" name="agentbanner2"/>
      <jsp:param value="<%=agentbanner3%>" name="agentbanner3"/>
     </jsp:include>
      <!--banner end-->
</div>
<!--店铺导航-->
<jsp:include page="nav_top.jsp" flush="true">
<jsp:param name="flag" value="0"/>
</jsp:include>
<!--店铺导航结束--> 
<!--主体-->
<div class="shopContain whitebg mb10">
  <div class="h10px c"></div>
  <div class="w100 l shopLeftbg"> 
    <!--left-->
    <div class="shopLeft"> 
      <!--代理产品-->
      <div class="brand">
        <div class="sTitle">
          <h2>代理品牌</h2>
        </div>
        <div class="sContent" id="brandId"> </div>
      </div>
      <!--代理产品 结束-->
      <div class="w100 l h10px whitebg"></div>
      <!--公司资料-->
      <div class="sLeftPart companyInfo">
        <div class="sTitle">
          <h2>公司资料</h2>
        </div>
        <div class="sContent">
          <h3 class="companyName"><%=CommonString.getFormatPara(map.get("full_name"))%></h3>
          <span class="approve">官方认证旗舰店（第1年）</span>
          <div class="star"><span class="star01"></span></div>
          <div class="intro"> 
           <%=CommonString.getFormatPara(map.get("city")).equals("")?"":"代理地区："+CommonString.getFormatPara(map.get("city"))+" <br />"%>
            <%=CommonString.getFormatPara(map.get("agent_fac_name")).equals("")?"":"代理品牌："+CommonString.getFormatPara(map.get("agent_fac_name"))+"<br />"%>
            <%=CommonString.getFormatPara(map.get("telphone")).equals("")?"":"销售电话："+CommonString.getFormatPara(map.get("telphone"))+"<br />"%>
            <%=CommonString.getFormatPara(map.get("concatus")).equals("")?"":"联系人："+CommonString.getFormatPara(map.get("concatus"))+"<br />"%>
           <%
           	if(!"".equals(CommonString.getFormatPara(map.get("email")))){
           		%>
           		  电子邮件：<a href="mailto:<%=CommonString.getFormatPara(map.get("email"))%>">
                          <%=CommonString.getFormatPara(map.get("email"))%></a><br />
           		<%
           	}
           %>

            <%=CommonString.getFormatPara(map.get("fax")).equals("")?"":"传真："+CommonString.getFormatPara(map.get("fax"))+"<br />"%>
               <!--   邮政编码：<%=CommonString.getFormatPara(map.get("postcode"))%><br />  -->
           <%=CommonString.getFormatPara(map.get("address")).equals("")?"":" 地址："+CommonString.getFormatPara(map.get("address"))%> 
          </div>
        </div>
      </div>
      <!--公司资料 结束--> 
      
    </div>
    <!--left end--> 
    <!--right-->
    <div class="shopRight"> 
      <!--推荐产品-->
      <div class="sRightPart">
        <div class="sTitle" id="recommendProT">
          <h2>推荐产品</h2>
          <span class="more"><a href="/agentshop03/njgj/agent_products.htm">查看更多产品</a></span> </div>
        <div id="recommendPro" class="sContent">
          <ul class="slist">
           <%
           	if(null!=productsList && productsList.size()>0){
           		for(Map oneMap:productsList){
           			%>
           	 <li>
              <div class="img"><a href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")) %>" target="_blank" title="<%=CommonString.getFormatPara(oneMap.get("factoryname"))+CommonString.getFormatPara(oneMap.get("name"))+CommonString.getFormatPara(oneMap.get("catalogname")) %>"><img src="<%="/uploadfiles/"+CommonString.getFormatPara(oneMap.get("img2")) %>" onerror="showImgDelay(this,'/uploadfiles/no_small.gif',2);" width="176px" height="147px" alt="<%=CommonString.getFormatPara(oneMap.get("factoryname"))+CommonString.getFormatPara(oneMap.get("name"))+CommonString.getFormatPara(oneMap.get("catalogname"))  %>" /></a></div>
              <h3><a href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")) %>" target="_blank" title="<%=CommonString.getFormatPara(oneMap.get("factoryname"))+CommonString.getFormatPara(oneMap.get("name"))+CommonString.getFormatPara(oneMap.get("catalogname"))  %>"><%=CommonString.getFormatPara(oneMap.get("factoryname"))+CommonString.getFormatPara(oneMap.get("name"))+CommonString.getFormatPara(oneMap.get("catalogname"))  %></a></h3>
              <a href="javascript:;" onclick="showinquery('<%=CommonString.getFormatPara(oneMap.get("id")) %>','<%=CommonString.getFormatPara(oneMap.get("factoryid")) %>','133')" class="btn">我要询价</a> 
            </li>
           			<%
           		}
           	}
           %>
          </ul>
        </div>
      </div>
      <!--主营产品-->
      <div class="sRightPart">
        <div class="sTitle">
          <h2>主营产品</h2>
          <span class="more"><a href="/agentshop03/<%=usern%>/agent_products.htm">查看更多产品</a></span> </div>
        <jsp:include page="/include/agent/agentshop_products.jsp" flush="true">
        <jsp:param name="agentid" value='<%=CommonString.getFormatPara(map.get("id"))%>'></jsp:param>
        <jsp:param name="usern" value='<%=usern%>'></jsp:param>
        <jsp:param name="flag" value='agentshop03'></jsp:param>
        </jsp:include>
      </div>
      <!--公司简介-->
      <div class="sRightPart">
        <div class="sTitle">
          <h2>公司简介</h2>
          <span class="more"><a href="/agentshop03/<%=usern%>/introduce.htm">查看更多详情</a></span> </div>
        <div class="sContent companyInfo">
          <div class="img"><a href="/agentshop03/<%=usern%>/introduce.htm"><img src="/uploadfiles/<%=CommonString.getFormatPara(map.get("img1"))%>" onerror="showImgDelay(this,'/uploadfiles/no_big.gif',2);" width="246" height="168" /></a></div>
          <div class="intro">
            <p class="text"><%=(CommonHtml.filterHTML(CommonString.getFormatPara(map.get("introduce"))).length()>=220)?CommonHtml.filterHTML(CommonString.getFormatPara(map.get("introduce"))).substring(0,220)+"...":CommonHtml.filterHTML(CommonString.getFormatPara(map.get("introduce")))%><a target="_blank" href="/agentshop03/<%=usern%>/introduce.htm" title="查看详情" class="ablue"><b>[查看详情]</b></a></p>
            <a href="javascript:void(0)" title="免费询价" class="l mr20" onclick="showinquery('','370','')"><img src="/images/simg_btn01.gif" alt="免费询价" width="188" height="45" /></a> <a href="/admin/login.jsp" target="_blank" title="代理商登录" class="l comlogin">代理商登录</a> </div>
        </div>
      </div>
      <!--在线询价-->
		<jsp:include page="agent_order.jsp" flush="true"></jsp:include>
	  <!--在线询价结束-->
  <!-- 订单 ajax  -->
	 <div class="sRightPart list08" id="show_agent_order">
        <div class="sTitle">
          <h2>产品订单<a name="order" id="order"></a></h2>
        </div>
        <ul class="ti">
          <li class="i1">编号</li>
          <li class="i2">询价产品</li>
          <li class="i3">联系人</li>
          <li class="i4">电话</li>
          <li class="i5">询价品牌</li>
          <li class="i6">询价区域</li>
          <li class="i7">询价时间</li>
        </ul>
        <div class="li" id="showAgentOrders">
        	<%
        		if(orderList!=null&& orderList.size()>0){
        			int i = 0;
        			for(Map m:orderList){
        				String orderId = CommonString.getFormatPara(m.get("id"));
        				String orderFactoryname = CommonString.getFormatPara(m.get("factoryname"));
        				String orderProduct_name = CommonString.getFormatPara(m.get("product_name"));
        				String orderCataname = CommonString.getFormatPara(m.get("cataname"));
        				String orderName = CommonString.getFormatPara(m.get("name"));
        				String orderProvince = CommonString.getFormatPara(m.get("province"));
        				String orderCity = CommonString.getFormatPara(m.get("city"));
        				String orderAdd_date= CommonString.getFormatPara(m.get("add_date"));
        				String orderContact_tel= CommonString.getFormatPara(m.get("contact_tel"));
        				String orderMobile_phonel= CommonString.getFormatPara(m.get("mobile_phone"));
        				orderContact_tel = "".equals(orderMobile_phonel)?orderContact_tel:orderMobile_phonel ;
        	    		if(orderContact_tel.length()>7&&orderContact_tel.length()<=20){
        	    			orderContact_tel = orderContact_tel.substring(0,3)+"***"+orderContact_tel.substring(orderContact_tel.length()-3) ;
        	    		}else if(orderContact_tel.length()>3){
        	    			orderContact_tel = orderContact_tel.substring(0,4)+"***" ;
        	    		}else
        	    		{
        	    			orderContact_tel = orderContact_tel+"***" ;
        	    		}
        	%>
        		<ul class="libg0<%=i%2 %>">
				<li class='i1'><%=i+1 %></li>
				<li class='i2'><a href='/inquiry/detail_for_<%=orderId %>.htm' target='_blank'><%=orderFactoryname+orderProduct_name+orderCataname %></a></li>
				<li class='i3'><%=orderName.substring(0,1)+"***" %></li>
				<li class='i4'><%=orderContact_tel %></li>
				<li class='i5'><%=orderFactoryname %></li>        
	            <li class='i6'><%=orderProvince+orderCity %></li>
	            <li class='i7'><%=orderAdd_date.substring(0,16) %></li>
				</ul>
        	<% i++;}}else{	%>
        	<ul><li style='width:100%;'>暂无订单</li></ul>
        	<%
        		}
        	%>
		</div>
      </div>
    </div>
    <!--right end-->
    <div class="w100 l shopLeftLine"></div>
  </div>
  <div class="clear"></div>
</div>
<!--主体 结束--> 
<!--foot-->
<div class="shopFoot"> 
<jsp:include page="/include/foot.jsp" flush="true"></jsp:include>
</div>
<!--foot end-->
<div style="display:none"> 
  <script src="http://s17.cnzz.com/stat.php?id=2697829&web_id=2697829" language="JavaScript"></script> 
  <script src='http://w.cnzz.com/c.php?id=30058227&l=3' language='JavaScript'></script> 
</div>
</body>
<script type="text/javascript" src="/scripts/citys.js"></script>
<script type="text/javascript" src="/scripts/rememberAccount.js"></script>
<script type="text/javascript">	
// 订单 end 
	jQuery("#zd_message").text("您好，我对<%=CommonString.getFormatPara(map.get("full_name"))%>的产品感兴趣，想要咨询，请您给我回复，谢谢。");
function submitYN(event) {
	var mobile_phone_reg = /^1([\d]{10})$/;
	 var connect_reg=/^((0\d{2,3})-)(\d{7,8})(-(\d{3,}))?$/;
	 // var connect_reg = /^(([0\+]\d{2,3}-)?(0\d{2,3})-)?(\d{7,8})(-(\d{3,}))?|(0([\d]{10}))$/;
	var emailreg = /^([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+@([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+\.[a-zA-Z]{2,3}$/;
	if (null == jQuery("#zd_name").val() || jQuery("#zd_name").val().length == 0) {
		jQuery.jBox.tip("请输入您的姓名!");
		setTimeout(function() {
			jQuery("#zd_name").focus();
		},
		0);
		return false;
	}
	if ((null == jQuery("#zd_mobile_phone").val() || jQuery("#zd_mobile_phone").val().length == 0)) {
		jQuery.jBox.tip("请输入您的手机或固定电话！");
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
		jQuery.jBox.tip("请输入正确的电话号码!");
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
				//  询价成功，把用户名和电话放入 cookie 中
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

function showinquery(pid,agentid,factoryid){
		jQuery.jBox("iframe:/include/products/product_order_agent.jsp?productid="+pid+"&factoryid="+factoryid+"&agentid="+agentid+"&agentName="+encodeURIComponent("<%=CommonString.getFormatPara(map.get("name")) %>"), {
	title: "在线询价",
	width: 720,
	height: 450,
	iframeScrolling : 'no',
	buttons: { '关闭': false }
	});
	jQuery(".jbox-button-panel").attr("style","display:none;") ;
}
	// 把下过订单的信息取出
jQuery(function(){
	var order_name = jQuery.trim(unescape(GetCookie("order_name"))) ;  // 订单人
    var order_phone = jQuery.trim(GetCookie("order_phone")) ;  // 订单电话
    if(''!=order_name && null!=order_name &&'null' != order_name){
    	jQuery("#zd_name").val(order_name) ;
    }
    if(''!=order_phone && null!=order_phone && "null"!=order_phone){
    	jQuery("#zd_mobile_phone").val(order_phone) ;
    }
   	setTimeout(function(){
		if(jQuery.trim(jQuery("#recommendPro ul").html())==''){	
			jQuery("#recommendProT").parent("div").remove() ;  // 如果没有推荐产品则隐藏推荐产品标题
		}
		},0) ;
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
})	
</script>
<script type="text/javascript" src="/scripts/scrolltopcontrol.js"></script>
<script type="text/javascript" src="/scripts/jBox-v2.3/jquery.jBox-2.3.min.js"></script>
<script type="text/javascript" src="/scripts/jBox-v2.3/i18n/jquery.jBox-zh-CN.js"></script>
</html>
<%
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		dbHelper.freeConnection(connection);
	}
%>