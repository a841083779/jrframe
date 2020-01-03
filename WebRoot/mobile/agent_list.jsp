<%@ page language="java" import="java.sql.Connection,com.jerehnet.webservice.*,org.json.*,java.util.*,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="tags"%>
<%
	String factory = CommonString.getFormatPara(request.getParameter("factory"));
	String catalog = CommonString.getFormatPara(request.getParameter("catalog"));
	String city = CommonString.getFormatPara(request.getParameter("city"));
    String offset = CommonString.getFormatPara(request.getParameter("offset"));
	String tonandmeter = CommonString.getFormatPara(request.getParameter("tonandmeter"));
	String fac_sql="";//产品类别
	String catalog_city="";
	String catalog_city_no="";
	String catalog_province="";
	Map brandMap = (Map) application.getAttribute("brandMap");
    Map catalogMap = (Map) application.getAttribute("catalogMap");
     Map cityMap = (Map) application.getAttribute("cityMap");
	
    Connection connection = null;
	DBHelper dbHelper = DBHelper.getInstance();
    StringBuffer whereStr = new StringBuffer("  and flag = 2 and is_show=1");
	if (!"".equals(catalog)) {
			whereStr.append(" and  id in(select agent_id from pro_agent_products where catalognum like '%"+catalog+"%')");
			
	}
	if (!"".equals(factory)) {  
			whereStr.append(" and agent_fac like '%" +factory +"%' ");
	}
		if (!"".equals(city)) {  
		    String[] province=city.split("-"); 
		  catalog_province=province[0] ;//省
          catalog_city=province[1];	//市
		  catalog_city_no=province[1];	//市
		 catalog_province=CommonString.getFormatPara(cityMap.get(catalog_province));
		 catalog_city= CommonString.getFormatPara(cityMap.get(catalog_city));
			whereStr.append(" and ( city like '%" + catalog_city+"%' or address like '%" +catalog_city +"%' or city like '%" +catalog_province+"%' or address like '%" +catalog_province+"%') ");
	}
		//拆分吨位
		String[] parttonandmeters = null;
		String firsttonandmeter = "";
		String sectonandmeter = "";
		if (!"".equals(tonandmeter) && !"undefined".equals(tonandmeter)) {
			parttonandmeters = tonandmeter.split("_");
			firsttonandmeter = parttonandmeters[1];
			sectonandmeter = parttonandmeters[2];
			if ("0".equals(parttonandmeters[2])) {
				//whereStr.append(" and tonandmeter < " + firsttonandmeter);
			} else if ("1".equals(parttonandmeters[2])) {
				//whereStr.append(" and tonandmeter >" + firsttonandmeter);
			} else if ("01".equals(parttonandmeters[2])) {
				//whereStr.append(" and tonandmeter =" + firsttonandmeter);
			} else {
			//	whereStr.append(" and tonandmeter between " + firsttonandmeter + " and " + parttonandmeters[2]);
			}
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
	try{
	    connection = dbHelper.getConnection();
		PageBean pageBean = new PageBean(); // 分页程序
		pageBean.setPageSize(6); // 每页显示条数
		pageBean.setCondition(whereStr.toString());
		Integer nowPage = 1;
		if("".equals(offset) || Integer.parseInt(offset)<=0){
			offset = "0" ;
		}
		if (!"".equals(offset) && !"0".equals(offset)) {
			nowPage = Integer.parseInt(offset) / pageBean.getPageSize() + 1;
		}
		pageBean.setNowPage(nowPage);
		String url = CommonString.getFormatPara(request.getQueryString());
		if (!"".equals(url)) {
			if (url.indexOf("offset") != -1 && url.indexOf("&") == -1) {
				url = "";
			} else if (url.indexOf("offset") != -1) {
				url = "&" + url.substring(url.indexOf("&") + 1);
			} else {
				url = "&" + url;
			}
		}
		pageBean.setOrderBy(" view_count desc"); // 点击量排序
		pageBean.setParams(url);
		pageBean.setIsShowSql(false);
		pageBean.setFields(" id,full_name,name,city,agent_fac_name,address,img1");
		pageBean.setTableName("pro_agent_factory");
		List<Map> searchProducts = pageBean.getDatas(connection); // 根据条件查出的产品
		
		
		String catalognum_new=catalog;
		String catalogName="";
			Map catalog_numNew=null;
		
			 catalog_numNew = dbHelper.getMap("select catalog_num from pro_catalog where num='"+catalog+"' and  is_show=1 ",connection) ;
			
			if(catalog_numNew!=null&&catalog_numNew.size()>0){
		    catalognum_new=CommonString.getFormatPara(catalog_numNew.get("catalog_num"));}
			whereStr.append(" and catalognum_new like '%" + catalognum_new + "%'");
			catalogName=CommonString.getFormatPara(catalogMap.get(catalog)).replace("挖掘机械","挖掘机");
	
			//代理商
		List<Map> list = dbHelper.getMapList("select  name,full_name,lng,lat,city,address,telphone,concatus from pro_agent_factory where agent_fac like'%"+factory+"%' ",connection) ;
		//所有类别
		List<Map> list1 = dbHelper.getMapList("select  name,num from pro_catalog where parentid=0 order by id desc",connection) ;
		
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
		
	
		
%><!DOCTYPE html>
<html>
<head>
<meta content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no" name="viewport" />
<meta content="yes" name="apple-mobile-web-app-capable" />
<meta content="black" name="apple-mobile-web-app-status-bar-style" />
<meta content="telephone=no" name="format-detection" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="author" content="design by www.21-sun.com" />
<%if(city.equals("")&&factory.equals("")&&catalog.equals("")){%>
<title>【电话】工程机械代理商_工程机械代理商信息大全 - 铁臂商城</title>
<%}else{%>
<title>【电话】<%=catalog_province.equals("")?"":catalog_province.equals(catalog_city)?"":catalog_province%><%=catalog_city.equals("")?"":catalog_city%><%=factory.equals("")?"":CommonString.getFormatPara(brandMap.get(factory)).replace("卡特彼勒","卡特")%><%=catalog.equals("")?"":!showtonandmeter.equals("")?showtonandmeter:CommonString.getFormatPara(catalogMap.get(catalog)).replace("挖掘机械","挖掘机")%>代理商_<%=catalog_province.equals("")?"":catalog_province.equals(catalog_city)?"":catalog_province%><%=catalog_city.equals("")?"":catalog_city%><%=factory.equals("")?"":CommonString.getFormatPara(brandMap.get(factory)).replace("卡特彼勒","卡特")%><%=catalog.equals("")?"":!showtonandmeter.equals("")?showtonandmeter:CommonString.getFormatPara(catalogMap.get(catalog)).replace("挖掘机械","挖掘机")%>代理商信息大全 - 铁臂商城</title>
<%}%>
<%if(city.equals("")&&factory.equals("")&&catalog.equals("")){%>
<meta name="keywords" content="工程机械代理商,工程机械代理商信息,工程机械,代理商" />
<%}else{%>
<meta name="keywords" content="<%=catalog_province.equals("")?"":catalog_province.equals(catalog_city)?"":catalog_province%><%=catalog_city.equals("")?"":catalog_city%><%=factory.equals("")?"":CommonString.getFormatPara(brandMap.get(factory)).replace("卡特彼勒","卡特")%><%=catalog.equals("")?"":!showtonandmeter.equals("")?showtonandmeter:CommonString.getFormatPara(catalogMap.get(catalog)).replace("挖掘机械","挖掘机")%>代理商,<%=catalog_province.equals("")?"":catalog_province.equals(catalog_city)?"":catalog_province%><%=catalog_city.equals("")?"":catalog_city%>代理商,<%=factory.equals("")?"":CommonString.getFormatPara(brandMap.get(factory)).replace("卡特彼勒","卡特")%>代理商,<%=catalog.equals("")?"":!showtonandmeter.equals("")?showtonandmeter:CommonString.getFormatPara(catalogMap.get(catalog)).replace("挖掘机械","挖掘机")%>代理商,代理商" />
<%}%>
<%if(city.equals("")&&factory.equals("")&&catalog.equals("")){%>
<meta name="description" content="寻找【工程机械代理商】请上铁臂商城。铁臂商城拥有全国各个地区的代理商信息,是工程机械最全的代理商平台。 " /> 
<%}else{%>
<meta name="description" content="寻找【<%=catalog_province.equals("")?"":catalog_province.equals(catalog_city)?"":catalog_province%><%=catalog_city.equals("")?"":catalog_city%><%=factory.equals("")?"":CommonString.getFormatPara(brandMap.get(factory)).replace("卡特彼勒","卡特")%><%=catalog.equals("")?"":!showtonandmeter.equals("")?showtonandmeter:CommonString.getFormatPara(catalogMap.get(catalog)).replace("挖掘机械","挖掘机")%>代理商】请上铁臂商城。铁臂商城拥有全国各个地区的代理商信息,是<%=catalog_province.equals("")?"":catalog_province.equals(catalog_city)?"":catalog_province%><%=catalog_city.equals("")?"":catalog_city%><%=factory.equals("")?"":CommonString.getFormatPara(brandMap.get(factory)).replace("卡特彼勒","卡特")%><%=catalog.equals("")?"":!showtonandmeter.equals("")?showtonandmeter:CommonString.getFormatPara(catalogMap.get(catalog)).replace("挖掘机械","挖掘机")%>最全的代理商平台。 " /> 
<%}%>
<link href="Static/css/style.css" rel="stylesheet" />
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
<div class="dl_list m10">
<%if (searchProducts != null && searchProducts.size() > 0) {%>
  <ul>
    <%	  
		
			for (Map oneMap : searchProducts) {
			String agent_fac_name=CommonString.getFormatPara(oneMap.get("agent_fac_name"));
			String agent_fac_names[]=agent_fac_name.split(",");
							%>
    <li><a href="agent_detail.jsp?agent_id=<%=CommonString.getFormatPara(oneMap.get("id"))%><%=catalog.equals("")?"":"&catalog="+catalog%><%=factory.equals("")?"":"&factory="+factory%><%=city.equals("")?"":"&city="+city%>">
	<img src="http://product.21-sun.com/uploadfiles/<%=CommonString.getFormatPara(oneMap.get("img1"))%>" class="img l" alt="<%=CommonString.getFormatPara(oneMap.get("full_name"))%>" width=552 height=410 onerror="showImgDelay(this,'/uploadfiles/no_big.jpg',2);">
      <div class="r">
        <h3 class="dl_list_t"><%=CommonString.getFormatPara(oneMap.get("full_name"))%></h3>
        <div class="t">主营品牌：<span>
		<%
		for(int i=0;i<agent_fac_names.length;i++){
		%>
		[<%=agent_fac_names[i]%>]
		<%}%>
		</span></div>
        <div  class="t">代理区域：<span><%=CommonString.getFormatPara(oneMap.get("city"))%></span></div>
        <div  class="t">详细地址：<span><%=CommonString.getFormatPara(oneMap.get("address"))%></span></div>
      </div>
      </a></li>
   <%}%>
  </ul>
    
    <div id="paging" class="paging">
  <tags:page_mobile pageBean="<%=pageBean%>" />
  </div>
  <%}else{%>
  <ul>
   <div style="font-size: 17px;">您查找的地区暂时没有<font style="font-weight: bold;"><%=factory.equals("")?"":CommonString.getFormatPara(brandMap.get(factory)).replace("卡特彼勒","卡特")%><%=catalog.equals("")?"":CommonString.getFormatPara(catalogMap.get(catalog)).replace("挖掘机械","挖掘机")%></font>代理商,为您推荐以下代理商：</div>
 
    <%	 
	  StringBuffer wheres = new StringBuffer("   flag = 2 and is_show=1");
	       if(!factory.equals("")){	wheres.append("  and  agent_fac like'%"+factory+"%' ");}
		    if(!catalog.equals("")){wheres.append(" and  id in(select agent_id from pro_agent_products where catalognum like '%"+catalog+"%')");}
			List<Map> list_tuijian = dbHelper.getMapList("select  top 10 id,full_name,name,city,agent_fac_name,address,img1 from pro_agent_factory where "+wheres,connection) ;

            if(list_tuijian.size()==0){
			list_tuijian = dbHelper.getMapList("select  top 10 id,full_name,name,city,agent_fac_name,address,img1 from pro_agent_factory where flag = 2 and is_show=1",connection);
			}
			for (Map oneMap : list_tuijian) {
			String agent_fac_name=CommonString.getFormatPara(oneMap.get("agent_fac_name"));
			String agent_fac_names[]=agent_fac_name.split(",");
							%>
    <li><a href="agent_detail.jsp?agent_id=<%=CommonString.getFormatPara(oneMap.get("id"))%><%=catalog.equals("")?"":"&catalog="+catalog%><%=factory.equals("")?"":"&factory="+factory%><%=city.equals("")?"":"&city="+city%>">
	<img src="http://product.21-sun.com/uploadfiles/<%=CommonString.getFormatPara(oneMap.get("img1"))%>" class="img l" alt="<%=CommonString.getFormatPara(oneMap.get("full_name"))%>" width=552 height=410  onerror="showImgDelay(this,'/uploadfiles/no_big.jpg',2);"  >
      <div class="r">
        <h3 class="dl_list_t"><%=CommonString.getFormatPara(oneMap.get("full_name"))%></h3>
        <div class="t">主营品牌：<span>
		<%
		for(int i=0;i<agent_fac_names.length;i++){
		%>
		[<%=agent_fac_names[i]%>]
		<%}%>
		</span></div>
        <div  class="t">代理区域：<span><%=CommonString.getFormatPara(oneMap.get("city"))%></span></div>
        <div  class="t">详细地址：<span><%=CommonString.getFormatPara(oneMap.get("address"))%></span></div>
      </div>
      </a></li>
   <%}%>
  </ul>
  <%}%>
</div>
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
  <jsp:include page="/include/mobile/catalogLie.jsp" flush="true">
            <jsp:param value="<%=city%>" name="city"/>
            <jsp:param value="<%=factory%>" name="factory"/>
            </jsp:include>
  <div class="dl_sele_btm"></div>
</div>
<!--end 类别下拉列表-->
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