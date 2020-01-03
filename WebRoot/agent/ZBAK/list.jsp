<%@ page language="java" import="org.json.*,java.util.*,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*,java.sql.*,com.jerehnet.webservice.*" pageEncoding="UTF-8"%>
<%@page import="java.net.URLEncoder"%><%
	String province = CommonString.getFormatPara(request.getParameter("province"));
	String city = CommonString.getFormatPara(request.getParameter("city"));
	//如果只有城市
	if(!"".equals(city)&&"".equals(province)){
		province = city;
		city = "";
	}
	String brand = CommonString.getFormatPara(request.getParameter("factoryid"));
	if(!"".equals(CommonString.getFormatPara(request.getParameter("factory")))){
		brand = CommonString.getFormatPara(request.getParameter("factory"));
	}
	String brandName = "";
	String model = CommonString.getFormatPara(request.getParameter("catalogid"));
	String modelName = "";
	DBHelper dbHelper = DBHelper.getInstance();
	Connection connection = null;
	try{
		connection = dbHelper.getConnection();
		if(!"".equals(brand)){
			Map brandMap = dbHelper.getMap(" select name from pro_agent_factory where id = ? ",new Object [] {brand},connection);
			if(null!=brandMap){
				brandName = CommonString.getFormatPara(brandMap.get("name"));
			}
		}
		if(!"".equals(model)){
			Map catalogMap = dbHelper.getMap(" select name from pro_catalog where num = ? ",new Object []{model},connection);
			if(null!=catalogMap){
				modelName = CommonString.getFormatPara(catalogMap.get("name"));
			}
		}
		String likeProvince = province;
		if(!"".equals(likeProvince)&&likeProvince.indexOf(" ")!=-1){
			likeProvince = likeProvince.split(" ")[1];
		}
		String likeCity = city;
		if(!"".equals(likeCity)&&likeCity.indexOf(" ")!=-1){
			likeCity = likeCity.split(" ")[1];
		}
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
		String nowCity = "";
		String nowProvince = "";
		if(null!=obj&&obj.length()>0){
			nowProvince = CommonString.getFormatPara(obj.getString("province"));
			nowCity = CommonString.getFormatPara(obj.getString("city"));
		}
%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>【<%=likeProvince %><%=likeCity %><%=brandName %><%=modelName %>工程机械代理商|挖掘机代理商】 - 中国工程机械商贸网</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="keywords" content="工程机械代理商,挖掘机代理商" />
<meta name="description" content="找工程机械代理商，挖掘机代理商信息尽在中国工程机械商贸网产品中心。" /> 
<meta name="author" content="design by www.21-sun.com" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<link href="/plugin/tip/yitip/css/jquery.yitip.css" rel="stylesheet" type="text/css" />
<link href="../style/style.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="../scripts/jquery-1.7.min.js"></script>
<script type="text/javascript" src="../scripts/scripts.js"></script>
<script type="text/javascript" src="../scripts/jBox-v2.3/jquery.jBox-2.3.min.js"></script>
<script type="text/javascript" src="../scripts/jBox-v2.3/i18n/jquery.jBox-zh-CN.js"></script>
<link type="text/css" rel="stylesheet" href="../scripts/jBox-v2.3/Skins2/Blue/jbox.css" />
<script type="text/javascript" src="/plugin/jquery/jquery.cookies.2.2.0.min.js"></script>
<script type="text/javascript" src="/scripts/citys.js"></script> 
<script type="text/javascript" src="/plugin/tip/yitip/jquery.yitip.js"></script>
<!--[if (IE 6)]>
<link href="/style/pngfix.css" media="screen" rel="stylesheet" type="text/css" />
<![endif]-->
<style type="text/css">
.ConditionTop { width:749px; border:#D5DBE9 1px solid; background-color:#f2f6f7; padding:3px; margin-bottom:10px;}
.cts { width:190px; float:right; padding-top:3px;}
.selectBtn_70 { width:70px; height:22px; color:#fff; background:url(http://product.21-sun.com/images/a_btn_70.gif) no-repeat; cursor:pointer; border:none;}
</style>
</head>
<body>
<!--top-->
<jsp:include page="/include/top.jsp" flush="true" />
<!--面包屑结束--> 
<!--main-->
<div class="contain980 mb10">
<!--left-->
<jsp:include page="/include/agent/left.jsp" flush="true">
	<jsp:param name="province" value="<%=province %>" />
	<jsp:param name="city" value="<%=city %>" />
	<jsp:param name="factoryid" value="<%=brand %>" />
	<jsp:param name="catalog" value="<%=model %>" />
	<jsp:param name="isAuto" value="search" />
</jsp:include>
<!--left end--> 
<!--right-->
<div class="w757 r mb10" style="margin-bottom: 0px;">
  	<%
  		String sql = " select count(id) from pro_agent_factory where flag = 2 and is_show = 1 ";
  		if(!"".equals(likeProvince)){
  			if(!"".equals(likeCity)){
  				sql += "and (  ( city like '%,"+likeProvince+"%' or city like '%"+likeProvince+",%' or city = '"+likeProvince+"' ) ";
  				sql += " or city like '%"+likeCity+"%' )  ";
  			}else{
  				sql += " and ( city like '%"+likeProvince+"%' or city = '"+likeProvince+"' )";
  			}
  		}
  		Integer dlCount = (Integer)dbHelper.getOne(sql,connection);
  	%>
  <div class="agent_part">
    <div class="title">
      <h3><span id="likeProvince"><%=likeProvince %></span><span id="likeCity"><%=likeCity %></span><span id="likeBrandName"><%=brandName %></span><span id="likeCatalogName"><%=modelName %></span>代理商<span class="total">（<span id="dlCount"><%=dlCount %></span>）</span></h3>
    </div>
    <div class="content agent_select">
      <ul>
      <%
      	if("".equals(province)&&"".equals(city)){
      		%>
        <dl style="border-bottom: none;">
          <dt>区域：</dt>
          <dd id="provinces"></dd>
        </dl>
      		<%
      	}else{
      		%>
        <dl>
          <dt>区域：</dt>
          <dd id="provinces"></dd>
        </dl>
      		<%
      	}
      %>
        <dl>
          <dt>城市：</dt>
          <dd id="citys"></dd>
        </dl>
      </ul>
    </div>
  </div>
   <script type="text/javascript">
   		function getSearchProList(){
	   		var pStr = "";
		   	for(var c in cities){
		   		pStr += c+",";
		   	}
		   	pStr = pStr.substring(0,pStr.length-1);
		   	jQuery.ajax({
		   		url : '/tools/ajax.jsp',
		   		data : {
		   			flag : "agentProList",
		   			province : '<%=province %>',
		   			catalog : "<%=model %>",
		   			factoryid : "<%=brand  %>",
		   			myPros : pStr
		   		},
		   		async : false,
		   		type : 'post',
		   		success : function(data){
		   			jQuery("#provinces").html(data);
		   			var nowPro = jQuery("#provinces>a[title='<%=province %>']");
		   			nowPro.addClass("select");
		   			getSearchCityList(nowPro.attr("title"));
		   		}
		   	});
   		}
   		getSearchProList();
   		function getSearchCityList(province){
   			if(typeof(province)=='undefined'){
   				jQuery("#citys").parent().hide();
   				return;
   			}else{
   				jQuery("#citys").parent().show();
   			}
   			var cStr = "";
   			for(var c in cities[province]){
   				cStr += cities[province][c]+",";
   			}
   			cStr = cStr.substring(0,cStr.length-1);
   			jQuery.ajax({
		   		url : '/tools/ajax.jsp',
		   		data : {
		   			flag : "agentCitList",
		   			province : province,
		   			catalog : "<%=model %>",
		   			factoryid : "<%=brand  %>",
		   			myCits : cStr
		   		},
		   		type : 'post',
		   		async : false,
		   		success : function(data){
		   			jQuery("#citys").html(data);
		   			var nowCit = jQuery("#citys>a[title='<%=city %>']");
		   			nowCit.addClass("select");
		   		}
		   	});
   		}
   </script>
   <div class="ConditionTop" style="display: none;">
       <div class="l" style="color:#4f7fd4; width:auto; float:left; line-height:22px; white-space:nowrap;">已设置筛选条件：</div>
		<div class="l" style="width:450px; float:left;">
			<span style="float: left;display: none;" id="conditionProvince"></span>
			<span style="float: left;display: none;" id="conditionCity"></span>
			<span style="float: left;display: none;" id="conditionBrand"></span>
			<span style="float: left;display: none;" id="conditionCatalog"></span>
		</div>
    <div class="cts" style="display: none;">
      <input type="text" name="sowa_q" id="sowa_q" onkeypress="if(event.keyCode==13){sowaAgent();}" style="width:110px; height:18px; line-height:18px; border:#ccc 1px solid;" />
      <input type="button" name="button2" id="button2" value="代理商搜索" class="selectBtn_70" onclick="sowaAgent();" />
    </div>
		
 </div>
  <div class="a_agent_tab">
    <ul>
      <li><a href="#" class="selected">列表查看</a></li>
      <li style="display: none;"><a href="#">地图查看</a></li>
    </ul>
  </div>
  <ul class="agent_ti">
    <li class="g1">代理商</li>
    <li class="g2">代理区域</li>
    <li class="g3">主营品牌</li>
    <li class="g4">在线询价</li>
    <li class="g5">联系电话</li>
  </ul>
  
  <div class="agent_li"><!-- 代理商列表 --></div>
  <div class="paging page" style="float: left;width: 600px;padding: 0;"><!-- ajax分页 --></div>
  
  <script type="text/javascript">
  	function sowaAgent(){
  		var goHtm = jQuery("#sowa_q").val();
    	window.open("http://sowa.21-sun.com/?q="+encodeURIComponent(goHtm)+"&f=supply");
  	}
    var nowBrand = '<%=brand %>';
    var nowBrandName = '<%=brandName %>';
	var nowCatalog = '<%=model %>';
	var nowCatalogName = '<%=modelName %>';
	var nowProvince = '<%=province %>';
	var nowCity = '<%=city %>';
	<%String nowCondition = province + " " + city + " " + brandName + " " + modelName;%>
   	if(nowBrand!=null&&jQuery.trim(nowBrand)!=''){
		jQuery(".ConditionTop").show();
		jQuery(".ConditionTop #conditionBrand").attr("brandId",nowBrand);
		jQuery(".ConditionTop #conditionBrand").show();
		jQuery(".ConditionTop #conditionBrand").html('<em>'+nowBrandName+'</em><a href="javascript:void(0)" title="取消" class="delete" onclick="removeBrand(this);"></a> ');
	}
	
   	if(nowCatalog!=null&&jQuery.trim(nowCatalog)!=''){
  		jQuery(".ConditionTop").show();
  		jQuery(".ConditionTop #conditionCatalog").attr("catalogId",nowCatalog);
  		jQuery(".ConditionTop #conditionCatalog").show();
  		jQuery(".ConditionTop #conditionCatalog").html('<em>'+nowCatalogName+'</em><a href="javascript:void(0)" title="取消" class="delete" onclick="removeCatalog(this);"></a> ');
 	}
   	
   	if(nowProvince!=null&&jQuery.trim(nowProvince)!=''){
		jQuery(".ConditionTop").show();
		jQuery(".ConditionTop #conditionProvince").show();
		jQuery(".ConditionTop #conditionProvince").html('<em>'+nowProvince+'</em><a href="javascript:void(0)" title="取消" class="delete" onclick="removeProvince(this);"></a> ');
	}
   	
   	if(nowCity!=null&&jQuery.trim(nowCity)!=''){
		jQuery(".ConditionTop").show();
		jQuery(".ConditionTop #conditionCity").show();
		jQuery(".ConditionTop #conditionCity").html('<em>'+nowCity+'</em><a href="javascript:void(0)" title="取消" class="delete" onclick="removeCity(this);"></a> ');
	}
   	
   	function removeProvince(o){
		<%
		String noProvinceUrl = "";
		if(!"".equals(brand)){
			noProvinceUrl += "&factoryid="+brand;
		}
		if(!"".equals(model)){
			noProvinceUrl += "&catalogid="+model;
		}
		if(!"".equals(noProvinceUrl)){
			noProvinceUrl = noProvinceUrl.substring(1);
			noProvinceUrl = "/agent/list.jsp?"+noProvinceUrl;
		}else{
			noProvinceUrl = "/agent/list.jsp";
		}
	%>
		window.location.href="<%=noProvinceUrl %>";
	}
   	
   	function removeCity(o){
		<%
		String noCityUrl = "";
		if(!"".equals(brand)){
			noCityUrl += "&factoryid="+brand;
		}
		if(!"".equals(province)){
			noCityUrl += "&province="+province;
		}
		if(!"".equals(model)){
			noCityUrl += "&catalogid="+model;
		}
		if(!"".equals(noCityUrl)){
			noCityUrl = noCityUrl.substring(1);
			noCityUrl = "/agent/list.jsp?"+noCityUrl;
		}else{
			noCityUrl = "/agent/list.jsp";
		}
	%>
		window.location.href="<%=noCityUrl %>";
	}
   	

	function removeBrand(o){
		<%
		String noBrandUrl = "";
		if(!"".equals(city)){
			noBrandUrl += "&city="+city;
		}
		if(!"".equals(province)){
			noBrandUrl += "&province="+province;
		}
		if(!"".equals(model)){
			noBrandUrl += "&catalogid="+model;
		}
		if(!"".equals(noBrandUrl)){
			noBrandUrl = noBrandUrl.substring(1);
			noBrandUrl = "/agent/list.jsp?"+noBrandUrl;
		}else{
			noBrandUrl = "/agent/list.jsp";
		}
	%>
		window.location.href="<%=noBrandUrl %>";
	}
	function removeCatalog(o){
		<%
		String noCatalogUrl = "";
		if(!"".equals(brand)){
			noCatalogUrl += "&factoryid="+brand;
		}
		if(!"".equals(city)){
			noCatalogUrl += "&city="+city;
		}
		if(!"".equals(province)){
			noCatalogUrl += "&province="+province;
		}
		if(!"".equals(noCatalogUrl)){
			noCatalogUrl = noCatalogUrl.substring(1);
			noCatalogUrl = "/agent/list.jsp?"+noCatalogUrl;
		}else{
			noCatalogUrl = "/agent/list.jsp";
		}
		
	%>
		window.location.href="<%=noCatalogUrl %>";
	}
	function setBrand(brand,brandName){
    	nowBrand = brand;
    	nowBrandName = brandName;
    	jQuery("#likeBrandName").html(nowBrandName);
    	getAgentList(0,'search');
    	if(nowBrand!=null&&jQuery.trim(nowBrand)!=''){
	  		jQuery(".ConditionTop").show();
	  		jQuery(".ConditionTop #conditionBrand").attr("brandId",nowBrand);
	  		jQuery(".ConditionTop #conditionBrand").show();
	  		jQuery(".ConditionTop #conditionBrand").html('<em>'+nowBrandName+'</em><a href="javascript:void(0)" title="取消" class="delete" onclick="removeBrand(this);"></a> ');
  		}
    }
    function setCatalog(catalog,catalogName){
    	nowCatalog = catalog;
    	nowCatalogName = catalogName;
    	jQuery("#likeCatalogName").html(nowCatalogName);
    	getAgentList(0,'search');
    	if(nowCatalog!=null&&jQuery.trim(nowCatalog)!=''){
	  		jQuery(".ConditionTop").show();
	  		jQuery(".ConditionTop #conditionCatalog").attr("catalogId",nowCatalog);
	  		jQuery(".ConditionTop #conditionCatalog").show();
	  		jQuery(".ConditionTop #conditionCatalog").html('<em>'+nowCatalogName+'</em><a href="javascript:void(0)" title="取消" class="delete" onclick="removeCatalog(this);"></a> ');
  		}
    }
  	getAgentList(0,'search');
  	function getAgentList(nowPage,isAuto){
  		jQuery(".agent_li").html("<img src='/images/loading.gif' style='margin:200px 0  0 350px;' />");
  		jQuery(".agent_li").height(470);
		var agentObj;
		jQuery.ajax({
			url : "/tools/ajax.jsp",
			data : {
				flag : "agentList",
				nowPage : nowPage ,
				province : nowProvince ,
				city : nowCity ,
				brand : nowBrand ,
				model : nowCatalog ,
				isAuto : isAuto ,
				pageSize : 15	
			},
			type : "post",
			success : function(data){
				agentObj = eval("["+data+"]")[0];
				var agentList = agentObj.list;
				jQuery("#dlCount").html(agentObj.total);
				var agLi = jQuery(".agent_li");
				agLi.html("");
				var htm = '';
				var i_f = 1;
				if(agentList.length<15){
					jQuery(".agent_li").css("height","auto");
				}
				for(var i=0;i<agentList.length;i++){
					if((i%2)==0){
						i_f = 2;
					}else{
						i_f = 1;
					}
					htm += '<ul class="libg0'+i_f+'">';
					htm += '<li class="g1"><a title="'+agentList[i].full_name+'" href="/agent/'+agentList[i].usern+'/" target="_blank">'+agentList[i].full_name+'</a></li>';
					htm += '<li class="g2"><span title="'+agentList[i].city+'">'+agentList[i].city+'</span></li>';
					htm += '<li class="g3"><span title="'+agentList[i].agent_fac_name+'">'+agentList[i].agent_fac_name+'</span></li>';
					htm += '<li class="g4"><a href="javascript:void(0);" onclick="zaiXianXunJia(\''+agentList[i].id+'\');">在线询价</a></li>';
					if(null!=agentList[i].telphone&&agentList[i].telphone!=''){
						htm += '<li class="g5" style="width:130px;overflow:hidden;"><a id="seePhone_'+agentList[i].id+'" href="javascript:void(0);" onclick="lianXiDianHua(\''+agentList[i].id+'\');">点击查看联系电话</a></li>';
					}else{
						htm += '<li class="g5" style="width:130px;overflow:hidden;"><a class="gcur" href="javascript:void(0);">暂无联系方式</a></li>';
					}
					htm += '</ul>';
				}
				agLi.html(htm);
				jQuery(".paging").html("");
				if(jQuery.trim(htm)!=''){
					createPage(agentObj);
				}else{
					jQuery(".agent_li").html("<div style='text-align:center;margin:10px auto;'>没有找到代理商信息？去<a style='color:blue;text-decoration: underline;' href='http://sowa.21-sun.com/?q=<%=URLEncoder.encode(nowCondition,"UTF-8") %>' target='_blank'>搜哇</a>一下吧！</div>");
				}
				jQuery("#treev1").height(jQuery(".w757").height()-120);
				setHover();
			}
		});
	}
	function zaiXianXunJia(id){
		var url = '/include/agent/enquiry.jsp?id='+id;
		if(nowBrand!=''){
			url += "&nowBrand="+nowBrand;
		}
		if(nowBrandName!=''){
			url += "&nowBrandName="+nowBrandName;
		}
		if(nowCatalog!=''){
			url += "&nowCatalog="+nowCatalog;
		}
		if(nowCatalogName!=''){
			url += "&nowCatalogName="+nowCatalogName;
		}
		jQuery.jBox("iframe:"+url,{
			title : "在线询价",
			width : 550,
			height : 380,
			top: '25%',
			buttons : {"确定":true,"关闭":false},
			submit : function(v,h,f){
				if(v){
					var ifrm = jQuery.jBox.getIframe();
					var subSr = ifrm.contentWindow.doSub();
					return false
				}
				return true;
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
			province : '<%=nowProvince %>',
			catalog : xunjia_catalog,
			catalogName : xunjia_catalog_name,
			brand : xunjia_brand ,
			brandName : xunjia_brand_name ,
			city : '<%=nowCity %>',
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
					return false;
				}
				return true;
			}
		});
	}
	function setHover(){
  		 jQuery(".agent_li ul").hover(function(){
			jQuery(this).toggleClass("a_hover");
		},function(){
			jQuery(this).removeClass("a_hover");
		});
  	}
	function createPage(obj){
		var htm = '';
		if(obj.nowPage>1){
			htm += '<a class="pre" href="javascript:void(0);" onclick="getAgentList('+(obj.nowPage-1)+',\'search\');">&nbsp;</a>';
		}else{
			htm += '<a class="pre" href="javascript:void(0);" style="cursor: default;border:none;color:#000;">&nbsp;</a>';
		}
		var left = 0;
		var right = 0;
		var middle = obj.nowPage;
		var rightCount = 0; 
		if(obj.pageCount>10){
			rightCount = obj.pageCount - 5;
			if (middle <= 5 && middle < rightCount) {
				for(var i=0;i<5;i++){
					if((i+1)==obj.nowPage){
						htm += '<span class="current"><b>&nbsp;'+(i+1)+'&nbsp;</b></span>';
					}else{
						htm += '<a class="num" href="javascript:void(0);" onclick="getAgentList('+(i+1)+',\'search\');">&nbsp;'+(i+1)+'&nbsp;</a>';
					}
				}
				if(middle==5){
					htm += '<a class="num" href="javascript:void(0);" onclick="getAgentList('+6+',\'search\');">&nbsp;'+6+'&nbsp;</a>';
					htm += '<a class="num" href="javascript:void(0);" onclick="getAgentList('+7+',\'search\');">&nbsp;'+7+'&nbsp;</a>';
				}
				htm += '<a class="num" href="javascript:void(0);" style="cursor: default;border:none;color:#000;">...</a>';
				htm += '<a class="num" href="javascript:void(0);" onclick="getAgentList('+(obj.pageCount-1)+',\'search\');">&nbsp;'+(obj.pageCount-1)+'&nbsp;</a>';
				htm += '<a class="num" href="javascript:void(0);" onclick="getAgentList('+(obj.pageCount-0)+',\'search\');">&nbsp;'+(obj.pageCount-0)+'&nbsp;</a>';
			}else if( middle > 5 && middle > rightCount){
				htm += '<a class="num" href="javascript:void(0);" onclick="getAgentList('+1+',\'search\');">&nbsp;'+1+'&nbsp;</a>';
				htm += '<a class="num" href="javascript:void(0);" onclick="getAgentList('+2+',\'search\');">&nbsp;'+2+'&nbsp;</a>';
				htm += '<a class="num" href="javascript:void(0);" style="cursor: default;border:none;color:#000;">...</a>';
				if(middle==(rightCount+1)){
					htm += '<a class="num" href="javascript:void(0);" onclick="getAgentList('+(middle-2)+',\'search\');">&nbsp;'+(middle-2)+'&nbsp;</a>';
					htm += '<a class="num" href="javascript:void(0);" onclick="getAgentList('+(middle-1)+',\'search\');">&nbsp;'+(middle-1)+'&nbsp;</a>';
				}
				for(var i = rightCount;i<obj.pageCount;i++){
						if((i+1)==obj.nowPage){
							htm += '<span class="current"><b>&nbsp;'+(i+1)+'&nbsp;</b></span>';
						}else{
							htm += '<a class="num" href="javascript:void(0);" onclick="getAgentList('+(i+1)+',\'search\');">&nbsp;'+(i+1)+'&nbsp;</a>';
						}
					}
				} else {
					htm += '<a class="num" href="javascript:void(0);" onclick="getAgentList('+1+',\'search\');">&nbsp;'+1+'&nbsp;</a>';
					htm += '<a class="num" href="javascript:void(0);" onclick="getAgentList('+2+',\'search\');">&nbsp;'+2+'&nbsp;</a>';
					htm += '<a class="num" href="javascript:void(0);" style="cursor: default;border:none;color:#000;">...</a>';
					htm += '<a class="num" href="javascript:void(0);" onclick="getAgentList('+(middle-2)+',\'search\');">&nbsp;'+(middle-2)+'&nbsp;</a>';
					htm += '<a class="num" href="javascript:void(0);" onclick="getAgentList('+(middle-1)+',\'search\');">&nbsp;'+(middle-1)+'&nbsp;</a>';
					htm += '<span class="current"><b>&nbsp;'+middle+'&nbsp;</b></span>';
					htm += '<a class="num" href="javascript:void(0);" onclick="getAgentList('+(middle+1)+',\'search\');">&nbsp;'+(middle+1)+'&nbsp;</a>';
					htm += '<a class="num" href="javascript:void(0);" onclick="getAgentList('+(middle+2)+',\'search\');">&nbsp;'+(middle+2)+'&nbsp;</a>';
					htm += '<a class="num" href="javascript:void(0);" style="cursor: default;border:none;color:#000;">...</a>';
					htm += '<a class="num" href="javascript:void(0);" onclick="getAgentList('+(obj.pageCount-1)+',\'search\');">&nbsp;'+(obj.pageCount-1)+'&nbsp;</a>';
					htm += '<a class="num" href="javascript:void(0);" onclick="getAgentList('+(obj.pageCount-0)+',\'search\');">&nbsp;'+(obj.pageCount-0)+'&nbsp;</a>';
			}
		}else{
			left = 0;
			right = obj.pageCount;
			for(var i=left;i<right;i++){
				if((i+1)==obj.nowPage){
					htm += '<span class="current"><b>&nbsp;'+(i+1)+'&nbsp;</b></span>';
				}else{
					htm += '<a class="num" href="javascript:void(0);" onclick="getAgentList('+(i+1)+',\'search\');">&nbsp;'+(i+1)+'&nbsp;</a>';
				}
			}
		}
		if(obj.nowPage>=obj.pageCount){
			htm += '<a class="next" href="javascript:void(0);" style="cursor: default;border:none;color:#000;">&nbsp;</a>';
		}else{
			htm += '<a class="next" href="javascript:void(0);" onclick="getAgentList('+(obj.nowPage+1)+',\'search\');">&nbsp;</a>';
		}
		jQuery(".paging").html(htm);
	}
  </script>
  
</div>
<!--right end-->
<div class="clear"></div>
</div>
<!--main end--> 
<div style="clear: left;"></div>
<!--foot--> 
<jsp:include page="/include/foot.jsp" flush="true" />
</body>
</html>
<script type="text/javascript" src="../scripts/scrolltopcontrol.js"></script> 
<script type="text/javascript" src="../scripts/sort.js"></script> 
<script type="text/javascript">
function addCookie(){　 // 加入收藏夹
    if (document.all){
        window.external.addFavorite('http://product.21-sun.com', '21-sun产品中心');
    }else if (window.sidebar){
        window.sidebar.addPanel('21-sun产品中心', 'http://www.product.21-sun.com', "");
    }
}
// 统计用户查询习惯
jQuery.post("/tools/ajax.jsp",{
    	flag : 'customer_agent_view_habit',
    	factoryid : '<%=CommonString.getFormatPara(request.getParameter("factoryid")) %>',
    	catalogid : '<%=CommonString.getFormatPara(request.getParameter("catalogid")) %>',
    	province : '<%=CommonString.getFormatPara(request.getParameter("province")) %>',
    	city : '<%=CommonString.getFormatPara(request.getParameter("city")) %>'
    });

</script> 
<%
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		DBHelper.freeConnection(connection);
	}
%>