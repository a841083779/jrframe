<%@ page language="java" import="java.util.*,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*,java.sql.*" pageEncoding="UTF-8"%>
<%
	String usern = CommonString.getFormatPara(request.getParameter("usern"));
	DBHelper dbHelper = DBHelper.getInstance();
	Connection connection = null;
	Map map = null ;
	try{
		connection = dbHelper.getConnection();
	    map = dbHelper.getMap(" select * from pro_agent_factory where usern = ? ",new Object []{usern},connection);
		if(map == null){
			Common.do302(response,"/agent");
			return;
		}
		Integer newsCount = (Integer)dbHelper.getOne(" select count(*) from pro_agent_news where agent_id = ? and is_approval = 1 ",new Object [] {
				map.get("id")
			},connection);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="author" content="design by www.21-sun.com" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<title><%=CommonString.getFormatPara(map.get("full_name"))%>- 代理商旗舰店 - 中国工程机械商贸网</title>
<meta name="keywords" content="<%=CommonString.getFormatPara(map.get("full_name"))%>,<%=CommonString.getFormatPara(map.get("city"))%><%=CommonString.getFormatPara(map.get("agent_fac_name"))%>代理" />
<meta name="description" content="中国工程机械商贸网为您提供<%=CommonString.getFormatPara(map.get("full_name"))%>简介、<%=CommonString.getFormatPara(map.get("full_name"))%>代理品牌、<%=CommonString.getFormatPara(map.get("full_name"))%>经营产品及其他详细资料，帮助您全面了解<%=CommonString.getFormatPara(map.get("full_name"))%>。" />
<link href="/style/style.css" rel="stylesheet" type="text/css" />
<link href="/style/shop.css" rel="stylesheet" type="text/css" />
<link type="text/css" rel="stylesheet" href="/scripts/jBox-v2.3/Skins2/Blue/jbox.css"/>
<script type="text/javascript" src="/scripts/jquery-1.7.min.js"></script>
<script type="text/javascript" src="/scripts/jquery.form.js"></script>
<script type="text/javascript" src="/scripts/scripts.js"></script>
<script src="http://api.map.baidu.com/api?v=1.4" type="text/javascript"></script>
<!--[if (IE 6)]>
<script src="/scripts/iepng.js" type="text/javascript"></script>
<script type="text/javascript">
   EvPNG.fix('div,ul,img,li,input,td,a'); 
</script>
<![endif]-->
</head>
<body class="style01">
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
<!--公司名称-->
<div class="sTop01">
  <div class="contain980 h93px">
    <h2 class="companyName"> <%=CommonString.getFormatPara(map.get("full_name"))%><span class="intro"><%=CommonString.getFormatPara(map.get("sub_title")) %></span> </h2>
    <div class="approve">
      <div class="star"><span class="star01"></span></div>
    </div>
  </div>
</div>
<!--公司名称结束--> 
<!--店铺导航-->
<jsp:include page="nav_top.jsp" flush="true"></jsp:include>
<!--店铺导航结束--> 
<!--主体-->
<div class="shopContain whitebg mb10"> 
  <!--banner-->
  <div class="bannerShow">
  	<%
  		String agentbanner= CommonString.getFormatPara(map.get("agentbanner"));
  		if(!"".equals(agentbanner)&&agentbanner.indexOf("http://")!=-1){
  			agentbanner = agentbanner+"";
  		}else{
  			agentbanner = "/uploadfiles/"+agentbanner;
  		}
  	%>
    <ul class="imgs">
      <li><img src="<%=agentbanner %>" width="960" height="200" onerror="showImgDelay(this,'/images/agentshop_logo.jpg',2);"  /></li>
    </ul>
    <ul class="nums" style="display:none;">
      <li value="1" class="cur"></li>
    </ul>
  </div>
  <!--banner end-->
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
          <div class="intro"> 代理地区：<%=CommonString.getFormatPara(map.get("city"))%> <br />
            代理品牌：<%=CommonString.getFormatPara(map.get("agent_fac_name"))%><br />
            销售电话：<%=CommonString.getFormatPara(map.get("telphone"))%> <br />
            联系人：<%=CommonString.getFormatPara(map.get("concatus"))%><br />
            电子邮件：<a href="mailto:<%=CommonString.getFormatPara(map.get("email"))%>"><%=CommonString.getFormatPara(map.get("email"))%></a><br />
            传真：<%=CommonString.getFormatPara(map.get("fax"))%><br />
            邮政编码：<%=CommonString.getFormatPara(map.get("postcode"))%><br />
            地址：<%=CommonString.getFormatPara(map.get("address"))%> </div>
        </div>
      </div>
      <!--公司资料 结束-->
    </div>
    <!--left end--> 
    <!--right-->
    <div class="shopRight"> 
     <div class="fabu_contain" id="map" style="width: 100%;display: none; height: 540px;">
      </div>
    <!--地图-->
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
<!--<script type="text/javascript" src="/scripts/agent_banner.js"></script>-->
<script type="text/javascript">
	//主营品牌
	jQuery.ajax({
		url:"/action/ajax_list.jsp",
		type:"post",
		data:{"flag":"brandAgentCatalogListShop","agentid":"<%=CommonString.getFormatPara(map.get("id"))%>","agent_fac":"<%=CommonString.getFormatPara(map.get("agent_fac"))%>","agent_fac_name":"<%=CommonString.getFormatPara(map.get("agent_fac_name"))%>","usern":"<%=usern%>"},
		success:function(data){
			jQuery("#brandId").html(jQuery.trim(data));	
			if(jQuery.trim(data)==""){
				jQuery("#brandId").removeClass("agentLeftPart mb10");	
			}
		}
	});
	
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
				alert("提交成功！") ;
				jQuery("#zd_mobile_phone").val("");
				jQuery("#zd_message").val("");
			}
		}) ;
		return false ;
}

function showinquery(pid,agentid,factoryid){
	jQuery.jBox("iframe:/include/products/product_order_agent.jsp?productid="+pid+"&factoryid="+factoryid+"&agentid="+agentid+"&agentName=<%=CommonString.getFormatPara(map.get("name")) %>", {
	title: "在线询价",
	width: 720,
	height: 450,
	iframeScrolling : 'no',
	buttons: { '关闭': false }
	});
	jQuery(".jbox-button-panel").attr("style","display:none;") ;
}
	jQuery(function(){
	 jQuery.ajax({
    	type:'post',
    	url:'/action/ajax.jsp',
    	data:{flag:'getAgentViewCount',agentId:'<%=CommonString.getFormatPara(map.get("id"))%>'} ,
    	success:function(msg){
    	}
    }) ;
	}) ;
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
<%
String lng = CommonString.getFormatPara(map.get("lng"));
String lat = CommonString.getFormatPara(map.get("lat"));
%>
<script type="text/javascript">
//jQuery("#map").height(jQuery("#map").width()/2.5);
var map;
var marker;
function initialize() {
	map = new BMap.Map('map');
	map.enableDragging();
	map.enableScrollWheelZoom();
	map.addControl(new BMap.NavigationControl());  //添加默认缩放平移控件
	map.addControl(new BMap.NavigationControl({anchor: BMAP_ANCHOR_TOP_RIGHT, type: BMAP_NAVIGATION_CONTROL_SMALL}));  //右上角，仅包含平移和缩放按钮
	map.addControl(new BMap.NavigationControl({anchor: BMAP_ANCHOR_BOTTOM_LEFT, type: BMAP_NAVIGATION_CONTROL_PAN}));  //左下角，仅包含平移按钮
	map.addControl(new BMap.NavigationControl({anchor: BMAP_ANCHOR_BOTTOM_RIGHT, type: BMAP_NAVIGATION_CONTROL_ZOOM}));  //右下角，仅包含缩放按钮
	var p = new BMap.Point('<%=lng%>','<%=lat%>'); //--------------------------------------
	myp = p;
	map.centerAndZoom(p,8);
	var myCity = new BMap.LocalCity();
	myCity.get(myFun);
}

function myFun(result){
    var cityName = result.name;
    var _cp = new BMap.Point('<%=lng%>','<%=lat%>'); //--------------------------------------
     map.setCenter(_cp);
    map.setZoom(11);
    jQuery("#map").show();
    setTimeout(function(){
    <%
    	if("".equals(lng)&&"".equals(lat)){
    		%>
	lng = map.getCenter().lng;
   	lat = map.getCenter().lat;
    		<%
    	}
    %>
    	addMarket();
    },1000);
}
var lng = '<%=lng %>';
var lat = '<%=lat %>';
var _p;
jQuery(function(){
	initialize()
});
function addMarket(){
	_p = new BMap.Point(lng,lat);
	map.setCenter(_p);
    map.setZoom(11);
	marker = new BMap.Marker(_p);
	map.addOverlay(marker);
	var label = new BMap.Label("<%=CommonString.getFormatPara(map.get("name"))%>",{offset:new BMap.Size(20,-10)});
	marker.setLabel(label);
}
</script>