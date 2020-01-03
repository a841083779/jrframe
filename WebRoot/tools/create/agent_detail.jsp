<%@ page language="java" import="java.sql.Connection,com.jerehnet.webservice.*,org.json.*,java.util.*,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="tags"%>
<%
     String agent_id = CommonString.getFormatPara(request.getParameter("agent_id"));
	 String factory = CommonString.getFormatPara(request.getParameter("factory"));
	String catalog = CommonString.getFormatPara(request.getParameter("catalog"));
	String city = CommonString.getFormatPara(request.getParameter("city"));
	String tonandmeter = CommonString.getFormatPara(request.getParameter("tonandmeter"));
	String catalog_city="";
	String catalog_province="";
	   Connection connection = null;
	
	try{
	   
	     DBHelper dbHelper = DBHelper.getInstance();
	     connection = dbHelper.getConnection();
		 Map brandMap = (Map) application.getAttribute("brandMap");
		  Map brandMap2 = (Map) application.getAttribute("brandMap2");
         Map catalogMap = (Map) application.getAttribute("catalogMap");
		  Map cityMap = (Map) application.getAttribute("cityMap");
		if (!"".equals(city)) {  
		    String[] province=city.split("-");
          catalog_province=province[0] ;//省
          catalog_city=province[1];	//市
		  
		 catalog_province=CommonString.getFormatPara(cityMap.get(catalog_province));
		 catalog_city= CommonString.getFormatPara(cityMap.get(catalog_city));
	}
		
		
			String showtonandmeter = ""; 
		if ("grab_1_13".equals(tonandmeter)) {
			showtonandmeter = "小挖(1T~13T)";
		} else if ("grab_14_30".equals(tonandmeter)) {
			showtonandmeter = "中挖(14T~30T)";
		} else if ("grab_30_1".equals(tonandmeter)) {    
			showtonandmeter = "大挖(30T以上)";
		} else if ("loader_1_3".equals(tonandmeter)) {
			showtonandmeter = "3T以下";
		} else if ("loader_3_01".equals(tonandmeter)) {
			showtonandmeter = "3T";
		} else if ("loader_3_5".equals(tonandmeter)) {
			showtonandmeter = "3T~5T";
		} else if("loader_5_1".equals(tonandmeter)){
			showtonandmeter = "5T以上";
		}else if ("crane_1_16".equals(tonandmeter)) {
			showtonandmeter = "16T以下";
		} else if ("crane_20_70".equals(tonandmeter)) {
			showtonandmeter = "20T~70T";
		} else if ("crane_70_1".equals(tonandmeter)) {
			showtonandmeter = "70T以上";
		} else {
			showtonandmeter = "";
		}
			//代理商
			String where="";
			if(!agent_id.equals("")){ where=" and id="+agent_id;}
		List<Map> list = dbHelper.getMapList("select  id,full_name,name,city,agent_fac,agent_fac_name,address,img1,intro,concatus,email from pro_agent_factory where is_show=1"+where,connection) ;
		String intro="";//公司简介
		String citys="";
		String email="";
		String address="";
		String concatus="";
		
		catalogMap.put("104002011","其他环卫机械");
		catalogMap.put("119001","其他煤炭机械");
		catalogMap.put("103015","水泥运输车");
		catalogMap.put("104002","其他养护机械");
		catalogMap.put("105017","强夯机液压步履式桩架");
		catalogMap.put("103005002","布料机");
		catalogMap.put("103002","混凝土搅拌站");
		catalogMap.put("103018","拖泵");
		catalogMap.put("103001","泵车");
		catalogMap.put("103019","搅拌运输车");
		catalogMap.put("103018001","柴油拖泵");
		catalogMap.put("103018002","电动拖泵");
		catalogMap.put("101001001","履带式挖掘机");
		catalogMap.put("102008","履带式起重机");
		catalogMap.put("101003001","履带式推土机");
		
	    	//代理商代理品牌图片
		List<Map> pro_list = dbHelper.getMapList("select top 2 id,factoryid,catalognum,img2 from pro_products where id in(select product_id from pro_agent_products where agent_id="+agent_id+" ) and is_show=1",connection) ;
		
		 String comp_name="";
		 String agent_fac_name="";
		 String agent_fac_catalognum="";
		 String[] agent_fac_catalognname=null;
		for (Map comp_Map : list) {comp_name=CommonString.getFormatPara(comp_Map.get("full_name"));agent_fac_name=CommonString.getFormatPara(comp_Map.get("agent_fac_name"));
		  agent_fac_catalognum=CommonString.getFormatPara(comp_Map.get("catalognum"));
		 agent_fac_catalognname=agent_fac_catalognum.split(",");
		}
		
		System.out.println(agent_fac_catalognname[0]);
		
%><!DOCTYPE html>
<html>
<head>
<meta content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no" name="viewport" />
<meta content="yes" name="apple-mobile-web-app-capable" />
<meta content="black" name="apple-mobile-web-app-status-bar-style" />
<meta content="telephone=no" name="format-detection" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="author" content="design by www.21-sun.com" />
<title>【电话】<%=catalog_province.equals("")?"":catalog_province.equals(catalog_city)?"":catalog_province%><%=catalog_city.equals("")?"":catalog_city%><%=agent_fac_name.equals("")?"":agent_fac_name%>代理商_<%=comp_name.equals("")?"":comp_name%></title>
<meta name="keywords" content="<%=catalog_province.equals("")?"":catalog_province.equals(catalog_city)?"":catalog_province%><%=catalog_city.equals("")?"":catalog_city%><%=agent_fac_name.equals("")?"":agent_fac_name%>代理商,<%=comp_name.equals("")?"":comp_name%>,<%=catalog_province.equals("")?"":catalog_province.equals(catalog_city)?"":catalog_province%><%=catalog_city.equals("")?"":catalog_city%><%=agent_fac_name.equals("")?"":agent_fac_name%>" />
<meta name="description" content="<%=comp_name.equals("")?"":comp_name%>是<%=catalog_province.equals("")?"":catalog_province.equals(catalog_city)?"":catalog_province%><%=catalog_city.equals("")?"":catalog_city%><%=agent_fac_name.equals("")?"":agent_fac_name%>代理商,代理经营<%=agent_fac_name.equals("")?"":agent_fac_name%>系列产品." /><link href="Static/css/style.css" rel="stylesheet" />
<script src="/scripts/jquery-1.7.min.js"></script>
<script src="/scripts/scripts.js"></script>
</head>
<body>

<header>
  <h2 class="logo"><img src="Static/img/logo.png" alt="铁臂商城"></h2>
  <a href="javascript:history.back()" class="bc"><img src="Static/img/back.png"></a> <a href="/brands_list.jsp" class="search">筛选<img src="Static/img/search_ico.png"></a> </header>
<div class="dl_top">
  <ul class="fix">
    <li><a href="javascript:;" class="dl_top_t" id="dl_brand_list"><b></b><%=!"".equals(factory)?CommonString.getFormatPara(brandMap.get(factory)).replace("卡特彼勒","卡特"):"品牌"%></a></li>
    <li><a href="javascript:;" class="dl_top_t" id="dl_area_list"><b></b><%=!"".equals(catalog_city)?catalog_city:"地区"%></a></li>
    <li class="s"><a href="javascript:;" class="dl_top_t" id="dl_cg1_list"><b></b><%=catalog.equals("")?"类别":showtonandmeter.equals("")?CommonString.getFormatPara(catalogMap.get(catalog)).replace("挖掘机械","挖掘机"):showtonandmeter%></a></li>
  </ul>
</div>
<div class="dl_list">
  <ul>
  <%
  if (list != null && list.size() > 0) {
			for (Map oneMap : list) {
			 intro=CommonString.getFormatPara(oneMap.get("intro"));
			 citys=CommonString.getFormatPara(oneMap.get("city"));
		     email=CommonString.getFormatPara(oneMap.get("email"));
		     address=CommonString.getFormatPara(oneMap.get("address"));
		     concatus=CommonString.getFormatPara(oneMap.get("concatus"));
			 String agent_fac_name1=CommonString.getFormatPara(oneMap.get("agent_fac_name"));
			String agent_fac_names[]=agent_fac_name1.split(",");
  %>
    <li><a href="#">
	<img src="http://product.21-sun.com/uploadfiles/<%=CommonString.getFormatPara(oneMap.get("img1"))%>" class="img l" alt="<%=CommonString.getFormatPara(oneMap.get("full_name"))%>" />
      <div class="r">
        <h3 class="dl_list_t"><%=CommonString.getFormatPara(oneMap.get("full_name"))%></h3>
         <div class="t">主营品牌：<span>
		<%
		for(int i=0;i<agent_fac_names.length;i++){
		%>
		[<%=agent_fac_names[i]%>]
		<%}%>
		</span></div>
        <div  class="t">代理区域：<span><%=citys%></span></div>
        <div  class="t">详细地址：<span><%=address%></span></div>
      </div>
      </a></li>
	  <%}}%>
  </ul>
</div>
<!--产品推荐-->
<jsp:include page="/include/mobile/include_agent_220.htm" flush="true" /> 

<div class="dl_p">
<h3>关于我们</h3>
<p>&nbsp;&nbsp;&nbsp;&nbsp;<%=intro%></p>
</div>
<div class="dl_p">
<h3>联系方式</h3>
<p>联系人：<%=concatus%> <br>
代理地区：<%=citys%> <br>
地址：<%=address%> <br>
邮箱：<%=email%> </p>
</div>
<h3 class="dl_top_t dl_cg_z" id="dl_cg_list" style="position:static; margin-top:10px;">全部产品</h3>
<!--下拉遮罩-->
<div class="zy"></div>
<!--品牌下拉列表-->
<jsp:include page="/include/mobile/catalog_num.htm" flush="true" /> 
<!--end品牌下拉列表--> 
<!--区域下拉列表-->
<jsp:include page="/include/mobile/city.jsp" flush="true">
            <jsp:param value="<%=catalog%>" name="catalog"/>
            <jsp:param value="<%=factory%>" name="factory"/>
            </jsp:include>
<!--end 区域下拉列表 --> 
<!--类别下拉列表-->
<div class="dl_cg1_list dl_brand1_list  dl_sele fix">
  <jsp:include page="/include/mobile/catalog_lie.jsp" flush="true">
            <jsp:param value="<%=city%>" name="city"/>
            <jsp:param value="<%=factory%>" name="factory"/>
            </jsp:include>
  <div class="dl_sele_btm"></div>
</div>
<!--end 类别下拉列表-->
 <div class="dl_cg_list dl_sele fix">
<h3 class="dl_cg_t">全部产品</h3>
<%
for (Map oneMapss : list) {
String fac_ids=CommonString.getFormatPara(oneMapss.get("agent_fac"));
String fac_ids_all[]=fac_ids.split(",");


%>
  <div class="l dl_sele_l">
    <ul class="idTabs dl_sele_l_ls">
	
	<%
	int count=1;
	for(int i=0;i<fac_ids_all.length;i++){
	
	%>
	<li><a href="#cg<%=count%>" ><%=CommonString.getFormatPara(brandMap.get(fac_ids_all[i])).replace("卡特彼勒","卡特")%></a></li><%count++;}%>
    </ul>
  </div>
  <div class="r dl_sele_r">
 <%
	int count1=1;
	for(int i=0;i<fac_ids_all.length;i++){
	String fac_ids1=CommonString.getFormatPara(fac_ids_all[i]);
	%>
    <div class="dl_sele_r_ls" id="cg<%=count1%>">
      <ul>
	  <%
	  String agent_pro_sql="select catalognum from pro_agent_products  where factory_id like '%"+fac_ids1+"%' and catalognum!='' group by catalognum";
	  List <Map> agent_pro_list = dbHelper.getMapList(agent_pro_sql,connection);	
	  for(Map m1:agent_pro_list){
	  String cataolgnum=CommonString.getFormatPara(m1.get("catalognum"));
	  %>
	  <li><a href="agent_list.jsp?catalog=<%=cataolgnum%>&factory=<%=fac_ids_all[i]%><%=city.equals("")?"":"&city="+city%>"><%= CommonString.getFormatPara(catalogMap.get(cataolgnum)).replace("挖掘机械","挖掘机")%></a></li>
		<%count++;}%>
      </ul>
    </div>
	<%}}%>
  
  </div>
  <div class="dl_sele_btm"></div>
</div>
<div class="bottomBar">
  <div class="share bdsharebuttonbox"><a href="#" class="bds_more" data-cmd="more">分享</a></div>
  <div class="tel"><a href="tel:4006-521-526"><img src="Static/img/tel_ico.png"><span>4006-521-526</span></a></div>
  <div class="comment"><a href="http://koubei.21-sun.com/"><img src="Static/img/com_btn.png" class="io">评论</a></div>
</div>
<img src="http://hm.baidu.com/hm.gif?si=68a002ecc1238a0d146069ac0b00940e&amp;et=0&amp;nv=0&amp;st=4&amp;lt=1408518877&amp;v=wap-2-0.3&amp;rnd=1876828651" width="0" height="0"  /> <img src="http://c.cnzz.com/wapstat.php?siteid=5923031&r=&rnd=67932853" width="0" height="0"  />
<jsp:include page="/include/mobile/cnzz.jsp" flush="true"></jsp:include>
</body>
<script src="Static/js/seajs/sea.js" id="seanode"></script>
<script src="Static/js/seajs/seajs.config.js"></script>
<script>
	var jrChannel='0#0';
	seajs.use('app/index.js');
	seajs.use('app/brands.js');
</script>
</html>
<%
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		DBHelper.freeConnection(connection);
	}
%>