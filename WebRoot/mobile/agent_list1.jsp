<%@ page language="java" import="java.sql.Connection,com.jerehnet.webservice.*,org.json.*,java.util.*,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="tags"%>
<%
	String factory = CommonString.getFormatPara(request.getParameter("factory"));
	String catalog = CommonString.getFormatPara(request.getParameter("catalog"));
	String city = CommonString.getFormatPara(request.getParameter("city"));
    String offset = CommonString.getFormatPara(request.getParameter("offset"));
	String tonandmeter = CommonString.getFormatPara(request.getParameter("tonandmeter"));
	String fac_sql="";//产品类别
	Map brandMap = (Map) application.getAttribute("brandMap");
    Map catalogMap = (Map) application.getAttribute("catalogMap");
    Connection connection = null;
	DBHelper dbHelper = DBHelper.getInstance();
    StringBuffer whereStr = new StringBuffer(" and is_show=1");
	if (!"".equals(catalog)) {
			whereStr.append(" id in(select agent_id from pro_agent_products where catalognum like '%"+catalog+"%')");
			
	}
	if (!"".equals(factory)) {  
			whereStr.append(" and agent_fac like '%" +factory +"%' ");
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
		//TDK
		String newTitle="工程机械";
		String newDesc="工程机械";
		String newTitleEnd="工程机械";
		String showtonandmeter="";String keyword="";
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
<title>【底价】工程机械_工程机械价格表_工程机械大全 - 铁臂商城</title>
<meta name="keywords" content="工程机械,工程机械价格表,工程机械产品大全" />
<meta name="description" content="铁臂商城工程机械专区,为您提供工程机械价格、工程机械型号、工程机械图片等详细信息,帮您全面了解工程机械,买工程机械产品就上铁臂商城。" />
<link href="Static/css/style.css" rel="stylesheet" />
<script src="/scripts/jquery-1.7.min.js"></script>
<script src="/scripts/scripts.js"></script>
</head>
<body>
<div style="text-align:center"><a href="http://sany.815.21-sun.com/m/index.html" target="_blank"><img src="Static/img/banner.jpg" alt=""></a></div>
<header>
  <h2 class="logo"><img src="Static/img/logo.png" alt="铁臂商城"></h2>
  <a href="javascript:history.back()" class="bc"><img src="Static/img/back.png"></a> <a href="/brands_list.jsp" class="search">筛选<img src="Static/img/search_ico.png"></a> </header>
<div class="dl_top">
  <ul class="fix">
    <li><a href="javascript:;" class="dl_top_t" id="dl_brand_list"><b></b><%=!"".equals(factory)?CommonString.getFormatPara(brandMap.get(factory)).replace("卡特彼勒","卡特"):"品牌"%></a></li>
    <li><a href="javascript:;" class="dl_top_t" id="dl_area_list"><b></b><%=!"".equals(city)?city:"地区"%></a></li>
    <li class="s"><a href="javascript:;" class="dl_top_t" id="dl_cg_list"><b></b><%=catalog.equals("")?"类别":CommonString.getFormatPara(catalogMap.get(catalog)).replace("挖掘机械","挖掘机")%></a></li>
  </ul>
</div>
<div class="dl_list m10">
  <ul>
    <%	  
		if (searchProducts != null && searchProducts.size() > 0) {
			for (Map oneMap : searchProducts) {
							%>
    <li><a href="#"><img src="<%=CommonString.getFormatPara(oneMap.get("img1"))%>" class="img l" alt="<%=CommonString.getFormatPara(oneMap.get("full_name"))%>" width=552 height=410>
      <div class="r">
        <h3 class="dl_list_t"><%=CommonString.getFormatPara(oneMap.get("full_name"))%></h3>
        <div class="t">主营品牌：<span>[<%=CommonString.getFormatPara(oneMap.get("agent_fac_name"))%>]</span></div>
        <div  class="t">代理区域：<span><%=CommonString.getFormatPara(oneMap.get("city"))%></span></div>
        <div  class="t">详细地址：<span><%=CommonString.getFormatPara(oneMap.get("address"))%></span></div>
      </div>
      </a></li>
   <%}}%>
  </ul>
</div>
<!--下拉遮罩-->
<div class="zy"></div>
<!--品牌下拉列表-->
<div class="dl_brand_list dl_sele fix">
  <ul>
  <%
  String letter = "";
  String catalo_sql="select paf.id,paf.upper_index,paf.name,paf.usern from pro_products pp ,pro_agent_factory paf where pp.factoryid = paf.id group by paf.upper_index,paf.name,paf.usern,paf.id order by paf.upper_index,paf.name 	";
  List <Map>list2 = dbHelper.getMapList(catalo_sql,connection);	
  for(int i = 0; list2 != null && i < list2.size();i++){
			letter = list2.get(i).get("upper_index").toString().toUpperCase();
  %>
    <li><a href="agent_list.jsp?catalog=<%=catalog%>&factory=<%=list2.get(i).get("id").toString()%>" class="selected"><%=letter%>-<%=list2.get(i).get("name").toString()%></a></li>
   <%}%>
  </ul>
  <div class="dl_sele_btm"></div>
   <div class="w755 l">
    <div id="pagination" class="page">
    <tags:page pageBean="<%=pageBean%>" />
    </div>
  </div>
</div>
<!--end品牌下拉列表--> 
<!--区域下拉列表-->
<!--#include virtual="include/city/all.htm"  --> 
<!--end 区域下拉列表 --> 
<!--类别下拉列表-->
<div class="dl_cg_list dl_sele fix">
<h3 class="dl_cg_t">全部产品</h3>
  <div class="l dl_sele_l">
      <ul class="idTabs dl_sele_l_ls">
	<%
	
	if(factory.equals("")){
	fac_sql="select  id,name,full_name,agent_fac,agent_fac_name from pro_agent_factory where agent_fac like '%"+factory+"%' and is_show=1";
	}else{
	fac_sql="select  id,name,full_name,agent_fac,agent_fac_name from pro_agent_factory where is_show=1 ";
	}
		List<Map> fac_list = dbHelper.getMapList(fac_sql,connection) ;
	       for(int i = 0;fac_list != null && i < fac_list.size();i++){
						Map m = fac_list.get(i);
					    String factoryname=(String)CommonString.getFormatPara(m.get("name"));
						String id = CommonString.getFormatPara(m.get("id"));
	%>
      <li><a href="#cg<%=i+1%>" class="selected"><%=factoryname%></a></li>
     <%}%>
    </ul>
  </div>
  <div class="r dl_sele_r">
  <%
		List<Map> fac_sub_list = dbHelper.getMapList(fac_sql,connection) ;
	       for(int j = 0;fac_sub_list != null && j < fac_sub_list.size();j++){
						Map m = fac_sub_list.get(j);
					    String factoryname=(String)CommonString.getFormatPara(m.get("name"));
						String id = CommonString.getFormatPara(m.get("id"));
						String agent_fac = CommonString.getFormatPara(m.get("agent_fac"));
	%>
    <div class="dl_sele_r_ls" id="cg<%=j+1%>">
      <ul>
	  <%
	  String fac_tir_sql="select id,catalognum from pro_agent_products where agent_id="+id;
	  List<Map> fac_tir_list = dbHelper.getMapList(fac_tir_sql,connection) ;
	    for(int k = 0;fac_sub_list != null && k < fac_sub_list.size();k++){
						Map m1 = fac_sub_list.get(k);
					    String catalognum=(String)CommonString.getFormatPara(m1.get("catalognum"));
	  %>
        <li><a href="agent_list.jsp?catalog=<%=agent_fac%>&factory=<%=agent_fac%>"><%=CommonString.getFormatPara(catalogMap.get(catalognum)).replace("挖掘机械","挖掘机")%></a></li>
        <%}%>
      </ul>
    </div>
    <%}%>
  </div>
  <div class="dl_sele_btm"></div>
</div>
<!--end 类别下拉列表-->
<div class="bottomBar">
  <div class="share bdsharebuttonbox"><a href="#" class="bds_more" data-cmd="more">分享</a></div>
  <div class="tel"><a href="tel:4006-521-526"><img src="Static/img/tel_ico.png"><span>4006-521-526</span></a></div>
  <div class="comment"><a href="http://koubei.21-sun.com/"><img src="Static/img/com_btn.png" class="io">评论</a></div>
</div>
<img src="http://hm.baidu.com/hm.gif?si=68a002ecc1238a0d146069ac0b00940e&amp;et=0&amp;nv=0&amp;st=4&amp;lt=1408518877&amp;v=wap-2-0.3&amp;rnd=1876828651" width="0" height="0"  /> <img src="http://c.cnzz.com/wapstat.php?siteid=5923031&r=&rnd=67932853" width="0" height="0"  />
</body>
<script src="Static/js/seajs/sea.js" id="seanode"></script>
<script src="Static/js/seajs/seajs.config.js"></script>
<script type="text/javascript">
var _bdhmProtocol = (("https:" == document.location.protocol) ? " https://" : " http://"); document.write(unescape("%3Cscript src='" + _bdhmProtocol + "hm.baidu.com/h.js%3F68a002ecc1238a0d146069ac0b00940e' type='text/javascript'%3E%3C/script%3E")); </script>
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