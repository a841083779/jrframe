<%@ page language="java" import="java.sql.Connection,com.jerehnet.webservice.*,org.json.*,java.util.*,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="tags"%>
<%
	String factory = CommonString.getFormatPara(request.getParameter("factory"));
	String catalog = CommonString.getFormatPara(request.getParameter("catalog"));
	String city = CommonString.getFormatPara(request.getParameter("city"));
    String offset = CommonString.getFormatPara(request.getParameter("offset"));
	String tonandmeter = CommonString.getFormatPara(request.getParameter("tonandmeter"));
	String catalog_second="";
	Map brandMap = (Map) application.getAttribute("brandMap");
    Map catalogMap = (Map) application.getAttribute("catalogMap");
    Connection connection = null;
	DBHelper dbHelper = DBHelper.getInstance();
    StringBuffer whereStr = new StringBuffer(" and is_show=1");
	if(catalog.equals("")){catalog="101001";}
	catalog_second=catalog;
	if(catalog.length()>6){catalog_second=catalog.substring(0,6);}
	if (!"".equals(catalog)) {
			whereStr.append(" and catalognum like '" + catalog + "%'");
			//catalogName=CommonString.getFormatPara(catalogMap.get(catalog));
	}
	if (!"".equals(factory)) {  
			whereStr.append(" and factoryid=" + factory);
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
				whereStr.append(" and tonandmeter < " + firsttonandmeter);
			} else if ("1".equals(parttonandmeters[2])) {
				whereStr.append(" and tonandmeter >" + firsttonandmeter);
			} else if ("01".equals(parttonandmeters[2])) {
				whereStr.append(" and tonandmeter =" + firsttonandmeter);
			} else {
				whereStr.append(" and tonandmeter between " + firsttonandmeter + " and " + parttonandmeters[2]);
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
		pageBean.setFields(" id,factoryname,name,introduce,catalogname,file_name,img2,factoryid,catalognum,price_start,price_end,view_count");
		pageBean.setTableName("pro_products");
		List<Map> searchProducts = pageBean.getDatas(connection); // 根据条件查出的产品
		
	
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
		//TDK
		String newTitle="工程机械";
		String newDesc="工程机械";
		String newTitleEnd="工程机械";
		String keyword="";
		String keywords1="";String keywords2="";String keywords3="";String keywords4="";String keywords5="";
		if(!"".equals(factory)){keywords1=CommonString.getFormatPara(brandMap.get(factory))+"价格表,";}
        if(!"".equals(catalog)){keywords2=CommonString.getFormatPara(catalogMap.get(catalog))+"价格表,";}
		if(!"".equals(catalog)&&!"".equals(factory)){keywords3=CommonString.getFormatPara(brandMap.get(factory)).replace("卡特彼勒","卡特")+CommonString.getFormatPara(catalogMap.get(catalog))+"价格表";}
		if(!"".equals(catalog)&&!"".equals(factory)&&!"".equals(showtonandmeter)){keywords5=showtonandmeter +("".equals(factory) ? "" : CommonString.getFormatPara(brandMap.get(factory)).replace("卡特彼勒","卡特"))+CommonString.getFormatPara(catalogMap.get(catalog))+",";}
		String newKeyWord=keywords5+keywords4+keywords2+keywords1+keywords3;
		if(newKeyWord.equals("")){newKeyWord="工程机械,工程机械价格表,工程机械产品大全";}
		else if(newKeyWord.endsWith(",")){newKeyWord=newKeyWord.substring(0,newKeyWord.length()-1);}
		
		if(!"".equals(factory)&&!"".equals(catalog)){
		       newTitle=keyword+showtonandmeter +("".equals(factory) ? "" : CommonString.getFormatPara(brandMap.get(factory)).replace("卡特彼勒","卡特"))+CommonString.getFormatPara(catalogMap.get(catalog));
		       newDesc=("".equals(factory) ? "" : CommonString.getFormatPara(brandMap.get(factory)).replace("卡特彼勒","卡特"))+CommonString.getFormatPara(catalogMap.get(catalog));
		       newTitleEnd=keyword+showtonandmeter +("".equals(factory) ? "" : CommonString.getFormatPara(brandMap.get(factory)).replace("卡特彼勒","卡特"))+CommonString.getFormatPara(catalogMap.get(catalog));
		}else if(!"".equals(factory)||!"".equals(catalog)){
		
		   newTitle=keyword+showtonandmeter +("".equals(factory) ? "" : CommonString.getFormatPara(brandMap.get(factory)))+CommonString.getFormatPara(catalogMap.get(catalog));
		   newDesc=("".equals(factory) ? "" : CommonString.getFormatPara(brandMap.get(factory)))+CommonString.getFormatPara(catalogMap.get(catalog));
		   if("".equals(catalog)){
		   		   newTitleEnd=keyword+showtonandmeter +("".equals(factory) ? "" : CommonString.getFormatPara(brandMap.get(factory)))+CommonString.getFormatPara(catalogMap.get(catalog))+"产品";
		   }else{
		   		   newTitleEnd=keyword+showtonandmeter +("".equals(factory) ? "" : CommonString.getFormatPara(brandMap.get(factory)))+CommonString.getFormatPara(catalogMap.get(catalog));
		   }
		}
		
		String catalognum_new=catalog;
		String catalogName="";
			Map catalog_numNew=null;
		
			 catalog_numNew = dbHelper.getMap("select catalog_num from pro_catalog where num='"+catalog+"' and  is_show=1 ",connection) ;
			
			if(catalog_numNew!=null&&catalog_numNew.size()>0){
		    catalognum_new=CommonString.getFormatPara(catalog_numNew.get("catalog_num"));}
			whereStr.append(" and catalognum_new like '%" + catalognum_new + "%'");
			catalogName=CommonString.getFormatPara(catalogMap.get(catalog)).replace("挖掘机械","挖掘机");
			 
		
		
			//国内品牌
			String fac_where="";
			if(!catalog.equals("")){fac_where=" and  catalognum_new like '%"+catalognum_new+"%'";}
		    List<Map> list = dbHelper.getMapList("select name,id,is_inner from pro_agent_factory where id in(select distinct(pro_products.factoryid) from pro_products  where is_show=1 "+fac_where+" ) and is_inner=1 order by view_count desc",connection) ;
		       System.out.println("select name,id,is_inner from pro_agent_factory where id in(select distinct(pro_products.factoryid) from pro_products  where is_show=1 "+fac_where+" ) and is_inner=1 order by view_count desc");
		     //国外品牌
		    List<Map> list1 = dbHelper.getMapList("select name,id,is_inner from pro_agent_factory where id in(select distinct(pro_products.factoryid) from pro_products  where is_show=1  "+fac_where+") and is_inner=0  order by view_count desc",connection) ;
		
		
%><!DOCTYPE html>
<html>
<head>
<meta content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no" name="viewport" />
<meta content="yes" name="apple-mobile-web-app-capable" />
<meta content="black" name="apple-mobile-web-app-status-bar-style" />
<meta content="telephone=no" name="format-detection" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="author" content="design by www.21-sun.com" />
<title>【底价】<%=newTitle%>_<%=newTitle%>价格表_<%=newTitleEnd%>大全 - 铁臂商城</title>
<meta name="keywords" content="<%=newKeyWord%>" />
<meta name="description" content="铁臂商城<%=newDesc%>专区,为您提供<%=newDesc%>价格、<%=newDesc%>型号、<%=newDesc%>图片等详细信息,帮您全面了解<%=newDesc%>,买<%=newDesc%>产品就上铁臂商城。" />
<link href="Static/css/style.css" rel="stylesheet" />
<script src="http://product.21-sun.com/scripts/jquery-1.7.min.js"></script>
<script src="http://product.21-sun.com/scripts/scripts.js"></script>
</head>
<body>
<%	if("".equals(factory)&&"".equals(catalog)){%>
  <div style="text-align:center"><a href="http://sany.815.21-sun.com/m/index.html" target="_blank"><img src="Static/img/banner.jpg" alt=""></a></div>
<%}%>
<header>
  <h2 class="logo"><img src="Static/img/logo.png" alt="铁臂商城"></h2>
  <a href="javascript:history.back()" class="bc"><img src="Static/img/back.png"></a>
  <a href="/brands_list.jsp<%=catalog.equals("")?"":"?catalog="+catalog%>" class="search">筛选<img src="Static/img/search_ico.png"></a>
</header>
<nav>
  <ul>
    <li><a href="/index.jsp?catalog=101001" <%if(catalog.equals("101001")){%>class="cur"<%}%>>挖掘机</a></li>
    <li><a href="/index.jsp?catalog=101002" <%if(catalog.equals("101002")){%>class="cur"<%}%>>装载机</a></li>
    <li><a href="/index.jsp?catalog=101005" <%if(catalog.equals("101005")){%>class="cur"<%}%>>平地机</a></li>
    <li><a href="/catalog_more.jsp?catalog=<%=catalog%><%=factory.equals("")?"":"&factory="+factory%><%=city.equals("")?"":"&city="+city%>" <%if(!catalog.equals("101005") &&!catalog.equals("101002")&& !catalog.equals("101001")){%>class="cur"<%}%> >更多</a>
     <!-- <div class="box">
        <a href="/index.jsp?catalog=101003">推土机</a>
        <a href="/index.jsp?catalog=104001">摊铺机</a>
        <a href="/index.jsp?catalog=107">叉车</a>
        <a href="/index.jsp?catalog=102">起重机</a>
        <a href="/index.jsp?catalog=106001">压路机</a>
      </div>-->
    </li>
  </ul>
</nav>
<div class="g_sear m10">
  <h3 class="g_s_t">高级搜索</h3>
  <div class="g_sear_c">
    <div class="brand_sl fix">
      <div class="sele m_brand l mp">
        <div class="_val"><b class="r s_l"></b><span><%=!"".equals(factory)?CommonString.getFormatPara(brandMap.get(factory)).replace("卡特彼勒","卡特"):"品牌"%></span></div>
        <div class="_option hide">
			<%if(list1!=null&&list1.size()>0){%>
          <h3 class="brand_cg_t">国外品牌</h3>
          <ul class="fix mbrandList">
		  <%
		 for(int i = 0;list1 != null && i < list1.size();i++){
						Map m = list1.get(i);
					    String factoryname=(String)CommonString.getFormatPara(m.get("name"));
						String id = CommonString.getFormatPara(m.get("id"));
		 %>
            <li><a href="index.jsp?factory=<%=id%><%=catalog.equals("")?"":"&catalog="+catalog%>"  <%if(id.equals(factory)){%>class="cur"<%}%> target="_self"><%=factoryname%></a></li>
			<%}%>
          </ul>
		  <%}%>
		  <%if(list!=null&&list.size()>0){%>
          <h3 class="brand_cg_t">国内品牌</h3>
          <ul class="fix mbrandList">
		   <%
		 for(int i = 0;list != null && i < list.size();i++){
						Map m = list.get(i);
					    String factoryname=(String)CommonString.getFormatPara(m.get("name"));
						String id = CommonString.getFormatPara(m.get("id"));
		 %>
            <li><a href="index.jsp?factory=<%=id%><%=catalog.equals("")?"":"&catalog="+catalog%>"  <%if(id.equals(factory)){%>class="cur" <%}%> target="_self"><%=factoryname%></a></li>
            <%}%>
          </ul>
		  <%}%>
        </div>
      </div>
	  
      <div class="sele m_cg l mp">
        <div class="_val"><b class="r s_l"></b><span><%=catalog.equals("")?"类别":showtonandmeter.equals("")?CommonString.getFormatPara(catalogMap.get(catalog)).replace("挖掘机械","挖掘机"):showtonandmeter%></span></div>        
      </div>
	 
      <div class="m_dl l mp"><b class="r s_l"></b><a href="agent_list.jsp">代理商</a></div>
    </div>
	<!--三级类别-->
	<%if(catalog_second.equals("101001")){%>
    <div class="m_cg_list">
    <ul class="fix">
	<li><a href="index.jsp?catalog=101001<%=factory.equals("")?"":"&factory="+factory%>&amp;tonandmeter=grab_1_13" target="_self">小挖(1T～13T)</a></li>
    <li><a href="index.jsp?catalog=101001<%=factory.equals("")?"":"&factory="+factory%>&amp;tonandmeter=grab_14_30" target="_self">中挖(14T～30T)</a></li>
    <li><a  href="index.jsp?catalog=101001<%=factory.equals("")?"":"&factory="+factory%>&amp;tonandmeter=grab_30_1" target="_self">大挖(30T以上)</a></li>
    <li><a href="index.jsp?catalog=101001001<%=factory.equals("")?"":"&factory="+factory%>" target="_self"> 履带式挖掘机</a></li>
    <li><a href="index.jsp?catalog=101001004<%=factory.equals("")?"":"&factory="+factory%>" target="_self" > 轮式挖掘机</a></li>
    <li><a href="index.jsp?catalog=101001006<%=factory.equals("")?"":"&factory="+factory%>" target="_self"> 正铲挖掘机</a></li>
    <li><a  href="index.jsp?catalog=101001007<%=factory.equals("")?"":"&factory="+factory%>" target="_self"> 其它挖掘机 </a></li>
    </ul>
    </div>
	<%}%>
	<%if(catalog_second.equals("101002")){%>
    <div class="m_cg_list">
    <ul class="fix">
    <li><a href="index.jsp?catalog=101002007<%=factory.equals("")?"":"&factory="+factory%>" target="_self"> 轮式装载机</a></li>
    <li><a href="index.jsp?catalog=101002004<%=factory.equals("")?"":"&factory="+factory%>" target="_self" > 其它装载机</a></li>
    <li><a href="index.jsp?catalog=101002006<%=factory.equals("")?"":"&factory="+factory%>" target="_self"> 履带式装载机</a></li>
    <li><a  href="index.jsp?catalog=101002010<%=factory.equals("")?"":"&factory="+factory%>" target="_self"> 叉装机 </a></li>
	<li><a href="index.jsp?catalog=101002<%=factory.equals("")?"":"&factory="+factory%>&amp;tonandmeter=loader_1_3" target="_self">3T以下</a></li>
    <li><a href="index.jsp?catalog=101002<%=factory.equals("")?"":"&factory="+factory%>&amp;tonandmeter=loader_3_01" target="_self">3T</a></li>
    <li><a  href="index.jsp?catalog=101002<%=factory.equals("")?"":"&factory="+factory%>&amp;tonandmeter=loader_3_5" target="_self">3T～5T</a></li>
	<li><a  href="index.jsp?catalog=101002<%=factory.equals("")?"":"&factory="+factory%>&amp;tonandmeter=loader_5_1" target="_self">5T以上</a></li>
    </ul>
    </div>
	<%}%>
	<%if(catalog_second.equals("102")){%>
    <div class="m_cg_list">
    <ul class="fix">
	<li><a href="index.jsp?catalog=102<%=factory.equals("")?"":"&factory="+factory%>&amp;tonandmeter=crane_1_16" target="_self">16T以下</a></li>
    <li><a href="index.jsp?catalog=102<%=factory.equals("")?"":"&factory="+factory%>&amp;tonandmeter=crane_20_70" target="_self">20T～70T</a></li>
    <li><a  href="index.jsp?catalog=102<%=factory.equals("")?"":"&factory="+factory%>&amp;tonandmeter=crane_70_1" target="_self">70T以上</a></li>
    </ul>
    </div>
	<%}%> 
	<%if(catalog_second.equals("101003")){%>
    <div class="m_cg_list">
    <ul class="fix">
	<li><a href="index.jsp?catalog=101003001<%=factory.equals("")?"":"&factory="+factory%>" target="_self">履带式推土机</a></li>
    <li><a href="index.jsp?catalog=101003004<%=factory.equals("")?"":"&factory="+factory%>" target="_self">轮式推土机</a></li>
    </ul>
    </div>
	<%}%> 
	<%if(catalog_second.equals("104001")){%>
    <div class="m_cg_list">
    <ul class="fix">
	<li><a href="index.jsp?catalog=104001005<%=factory.equals("")?"":"&factory="+factory%>" target="_self">滑模摊铺机</a></li>
    <li><a href="index.jsp?catalog=104001004<%=factory.equals("")?"":"&factory="+factory%>" target="_self">熨平板</a></li>
	<li><a href="index.jsp?catalog=104001002<%=factory.equals("")?"":"&factory="+factory%>" target="_self">履带式摊铺机</a></li>
    <li><a href="index.jsp?catalog=104001001<%=factory.equals("")?"":"&factory="+factory%>" target="_self">轮式摊铺机</a></li>
    </ul>
    </div>
	<%}%>
	<%if(catalog_second.equals("106001")){%>
    <div class="m_cg_list">
    <ul class="fix">
	<li><a href="index.jsp?catalog=106001009<%=factory.equals("")?"":"&factory="+factory%>" target="_self">振动压路机</a></li>
    <li><a href="index.jsp?catalog=106001008<%=factory.equals("")?"":"&factory="+factory%>" target="_self">静碾压路机</a></li>
	<li><a href="index.jsp?catalog=106001006<%=factory.equals("")?"":"&factory="+factory%>" target="_self">冲击式压路机</a></li>
    <li><a href="index.jsp?catalog=106001005<%=factory.equals("")?"":"&factory="+factory%>" target="_self">轮胎压路机</a></li>
	<li><a href="index.jsp?catalog=106001004<%=factory.equals("")?"":"&factory="+factory%>" target="_self">光轮压路机</a></li>
    <li><a href="index.jsp?catalog=106001003<%=factory.equals("")?"":"&factory="+factory%>" target="_self">三轮压路机</a></li>
	<li><a href="index.jsp?catalog=106001002<%=factory.equals("")?"":"&factory="+factory%>" target="_self">双钢轮压路机</a></li>
    <li><a href="index.jsp?catalog=106001001<%=factory.equals("")?"":"&factory="+factory%>" target="_self">单钢轮压路机</a></li>
    </ul>
    </div>
	<%}%> 
            
  </div>
</div>
<ul class="proList">
   <%	 
        String orderCount="";
		if (searchProducts != null && searchProducts.size() > 0) {
			for (Map oneMap : searchProducts) {
  %>
  <li>
    <a href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name"))%>?" title="<%=CommonString.getFormatPara((String) oneMap.get("factoryname")+(String) oneMap.get("name")+(String)oneMap.get("catalogname"))%>" class="int">
      <img onerror="showImgDelay(this,'/uploadfiles/no_small.gif',2);"  src="/uploadfiles/<%=CommonString.getFormatPara(oneMap.get("img2")).replace("image","")%>">
      <div class="n"><%=CommonString.getFormatPara((String) oneMap.get("factoryname")+(String) oneMap.get("name")+(String)oneMap.get("catalogname"))%></div>
      <div class="p">
	  参考价格：
	  <%if(CommonString.getFormatPara(oneMap.get("price_start")).equals("0")&&CommonString.getFormatPara(oneMap.get("price_end")).equals("0")){%>
	    <font>面议</font>
	  <%}else{%>
	      <font><%=CommonString.getFormatPara(oneMap.get("price_start")).equals("0")?"0":CommonString.getFormatPara(oneMap.get("price_start"))%>-<%=CommonString.getFormatPara(oneMap.get("price_start")).equals("0")?"未定":CommonString.getFormatPara(oneMap.get("price_start"))%>万</font>
	  <%}%>
	  </div>
	  
	  <%
	      Map one_Count = dbHelper.getMap("  select  count(id) as counts from pro_product_form where product_id="+CommonString.getFormatPara(oneMap.get("id")));
	      if(one_Count !=null ){
	         orderCount=CommonString.getFormatPara(one_Count.get("counts"));
	
	}
	  %>
      <div class="num"><span>询价：<%=orderCount%>次</span><span>浏览：<%=CommonString.getFormatPara(oneMap.get("view_count"))%>次</span></div>
    </a>
    <dl class="btn">
      <dd class="b1"><a href="tel:4006-521-526"><img src="Static/img/btn_tel.png">询问底价</a></dd>
      <dd class="b2"><a href="/form.jsp?pid=<%=CommonString.getFormatPara(oneMap.get("id"))%>"><img src="Static/img/btn_buy.png">立即订购</a></dd>
    </dl>
  </li>
  <%}}else{%>
   <div style="text-align:center;">暂无符合条件的产品,为您推荐其他热门产品</div>
      <%
        String whereStrSql="";
        if(!catalog.equals("")){whereStrSql=" and catalognum like '" + catalog + "%'";}
     	List<Map> hotList = dbHelper.getMapList("select top 6 id,factoryname,name,introduce,catalogname,file_name,img2,factoryid,catalognum,price_start,price_end,view_count  from pro_products where 1=1"+whereStrSql+"order by view_count desc");
		if (hotList != null && hotList.size() > 0) {
			for (Map oneMap : hotList) {
  %>
    <li>
    <a href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name"))%>" title="<%=CommonString.getFormatPara((String) oneMap.get("factoryname")+(String) oneMap.get("name")+(String)oneMap.get("catalogname"))%>" class="int">
      <img onerror="showImgDelay(this,'/uploadfiles/no_small.gif',2);"  src="/uploadfiles/<%=CommonString.getFormatPara(oneMap.get("img2")).replace("image","")%>">
      <div class="n"><%=CommonString.getFormatPara((String) oneMap.get("factoryname")+(String) oneMap.get("name")+(String)oneMap.get("catalogname"))%></div>
      <div class="p">
	  参考价格：
	  <%if(CommonString.getFormatPara(oneMap.get("price_start")).equals("0")&&CommonString.getFormatPara(oneMap.get("price_end")).equals("0")){%>
	    <font>面议</font>
	  <%}else{%>
	      <font><%=CommonString.getFormatPara(oneMap.get("price_start")).equals("0")?"0":CommonString.getFormatPara(oneMap.get("price_start"))%>-<%=CommonString.getFormatPara(oneMap.get("price_start")).equals("0")?"未定":CommonString.getFormatPara(oneMap.get("price_start"))%>万</font>
	  <%}%>
	  </div>
	  
	  <%
	      Map one_Count_other = dbHelper.getMap("  select  count(id) as counts from pro_product_form where product_id="+CommonString.getFormatPara(oneMap.get("id")));
	      if(one_Count_other !=null ){
	         orderCount=CommonString.getFormatPara(one_Count_other.get("counts"));
	
	}
	  %>
      <div class="num"><span>询价：<%=orderCount%>次</span><span>浏览：<%=CommonString.getFormatPara(oneMap.get("view_count"))%>次</span></div>
    </a>
    <dl class="btn">
      <dd class="b1"><a href="tel:4006-521-526"><img src="Static/img/btn_tel.png">询问底价</a></dd>
      <dd class="b2"><a href="/form.jsp?pid=<%=CommonString.getFormatPara(oneMap.get("id"))%>"><img src="Static/img/btn_buy.png">立即订购</a></dd>
    </dl>
  </li>
   <%}}}%>
</ul>
<div class="paging">
    <tags:page_mobile pageBean="<%=pageBean%>" />

</div>
<div class="bottomBar">
  <div class="share bdsharebuttonbox"><a href="#" class="bds_more" data-cmd="more">分享</a></div>
  <div class="tel"><a href="tel:4006-521-526"><img src="Static/img/tel_ico.png"><span>4006-521-526</span></a></div>
  <div class="comment"><a href="http://koubei.21-sun.com/"><img src="Static/img/com_btn.png" class="io">评论</a></div>
</div>
<%@ include file="hm.jsp" %>
<%
_HMT _hmt = new _HMT("68a002ecc1238a0d146069ac0b00940e");
_hmt.setDomainName("m.product.21-sun.com");
_hmt.setHttpServletObjects(request, response);
String _hmtPixel = _hmt.trackPageview();
%>
<img src="<%= _hmtPixel %>" width="0" height="0"  />

<%@ include file="cs.jsp" %>
<%CS cs = new CS(5923031);cs.setHttpServlet(request,response);
String imgurl = cs.trackPageView();%> 
<img src="<%= imgurl %>" width="0" height="0"  />
<jsp:include page="/include/mobile/cnzz.jsp" flush="true"></jsp:include>
</body>
<script src="Static/js/seajs/sea.js" id="seanode"></script>
<script src="Static/js/seajs/seajs.config.js"></script>

<script>
	var jrChannel='0#0';
	seajs.use('app/index.js');
</script>
</html>
<%
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		DBHelper.freeConnection(connection);
	}
%>