﻿<%@ page language="java"  pageEncoding="UTF-8"%>
<%@page import="com.jerehnet.util.common.CommonString"%>
<%@page import="com.jerehnet.util.dbutil.PageBean"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@page import="com.jerehnet.util.common.CommonHtml"%>
<%@page import="java.sql.Connection,com.jerehnet.webservice.*,com.jerehnet.util.dbutil.*,java.sql.*,java.util.*"%>
<%@taglib tagdir="/WEB-INF/tags" prefix="tags"%>
<%@ taglib uri="/WEB-INF/classes/oscache.tld" prefix="cache" %><%
	String referer = CommonString.getFormatPara(request.getHeader("referer")) ;
	String flag  = CommonString.getFormatPara(request.getParameter("flag")) ; // product 按类别排序
	String offset = "".equals(CommonString.getFormatPara(request.getParameter("offset")))?"1":CommonString.getFormatPara(request.getParameter("offset")) ;
	String factoryid = CommonString.getFormatPara(request.getParameter("factoryid")) ;
	String catalog = CommonString.getFormatPara(request.getParameter("catalog")) ;
	String season = CommonString.getFormatPara(request.getParameter("season")) ;
	String month= CommonString.getFormatPara(request.getParameter("month")) ;
	String year= CommonString.getFormatPara(request.getParameter("year")) ;
	Map catalogMap = (HashMap)application.getAttribute("catalogMap") ;
	Map brandMap = (HashMap)application.getAttribute("brandMap") ;
	String tonnage = CommonString.getFilterStr(request.getParameter("tonnage")) ;
	String proType=" where is_show=1";
	//参数处理
    if(catalog.equals("0")){catalog="";}if(year.equals("0")){year="";} if(month.equals("0")){month="";}
	if(season.equals("0")){season="";} if(factoryid.equals("0")){factoryid="";} if(tonnage.equals("0")){tonnage="";}
	if(offset.equals("0")){offset="1";} String cachekey = flag+offset ;String show_season="";
%> 
<cache:cache  cron="* * * */15 *">
<%
	String whereStr = "where  1=1 " ;
	String catalogname = "" ;
	if("product".equals(flag)){
		catalogname = "热门产品" ;
	}
	if("grab".equals(flag)){
		whereStr+="  and catanum like '%101001%'" ;
		catalogname = "挖掘机" ;
	}
	if("loader".equals(flag)){
		whereStr+="   and catanum like '%101002%'";
		catalogname = "装载机" ;
	}
	if("bulldozer".equals(flag)){
		whereStr+="   and catanum like '%101003%'";
		catalogname = "推土机" ;
	}
	if("grader".equals(flag)){
		whereStr+="   and catanum like '%101005%'";
		catalogname = "平地机" ;
	}
	if("crane".equals(flag)){
		whereStr+="  and catanum like '%102%'";
		catalogname = "起重机" ;
	}
	if("roller".equals(flag)){
		whereStr+="  and catanum like '%106001%'";
		catalogname = "压路机" ;
	}
	if(!"".equals(factoryid)){
		whereStr =whereStr+ "and factoryid='"+factoryid+"'"  ;
	}
	if(!"".equals(catalog)){
		whereStr+=" and catanum like '"+catalog+"%'" ;
		proType+=" and catalognum like '"+catalog+"%'";
	}
	if(!year.equals("")){whereStr=whereStr+" and DATEPART(year, add_date)="+year;}
	if(!month.equals("")){whereStr=whereStr+" and DATEPART(month, add_date)="+month;}
	if(!season.equals("")){
         if(season.equals("1")){show_season="一"; whereStr=whereStr+" and (DATEPART(month, add_date)=1 or DATEPART(month, add_date)=2 or DATEPART(month, add_date)=3)";} 
		 if(season.equals("2")){show_season="二"; whereStr=whereStr+" and (DATEPART(month, add_date)=4 or DATEPART(month, add_date)=5 or DATEPART(month, add_date)=6)";} 
		 if(season.equals("3")){show_season="三"; whereStr=whereStr+" and (DATEPART(month, add_date)=7 or DATEPART(month, add_date)=8 or DATEPART(month, add_date)=9)";}
		 if(season.equals("4")){show_season="四"; whereStr=whereStr+" and (DATEPART(month, add_date)=10 or DATEPART(month, add_date)=11 or DATEPART(month, add_date)=12)";} 
	}
	if(tonnage.equals("1")) proType+=" and tonandmeter <=13   and tonandmeter >=1"; 
	if(tonnage.equals("2")) proType+=" and tonandmeter <30   and tonandmeter >=14"; 
	if(tonnage.equals("3")) proType+=" and tonandmeter >=30"; 
	//查询新
	DBHelper dbHelper = DBHelper.getInstance();
    Connection connection = null;
	int k=0;
	try{
  	connection = dbHelper.getConnection();	
	String topCount="";
	String topSql="SELECT top 10 allCount,img2,factoryname,catalogname,name,file_name,factoryid,catalognum,id,view_count,introduce from (SELECT COUNT(*) AS allCount,product_id from pro_product_form "+whereStr+"  GROUP BY product_id having  product_id!=0  ) as h inner JOIN( SELECT img2,factoryname,catalogname,name,file_name,factoryid,catalognum,id,view_count,introduce FROM pro_products "+proType+" ) AS j ON  j.id=h.product_id and h.product_id not in (SELECT top "+(Integer.parseInt(offset)-1)*10+" id from (SELECT COUNT(*) AS allCount,product_id from pro_product_form "+whereStr+"  GROUP BY product_id having  product_id!=0  ) as h inner JOIN( SELECT factoryid,id FROM pro_products "+proType+" ) AS j ON  j.id=h.product_id ORDER BY h.allCount DESC) ORDER BY h.allCount DESC ";
	if(tonnage.equals("")){
	topCount="SELECT count(product_id) as newsCount from (SELECT  product_id from pro_product_form  "+whereStr+" GROUP BY product_id having product_id!=0 ) t ";
	}else{
	topCount="SELECT count(product_id) as newsCount from (SELECT  product_id from pro_product_form  "+whereStr+" GROUP BY product_id having product_id!=0 and product_id in (select id from pro_products"+proType+")) t ";
	}
	//查询
	List <Map> allProducts = dbHelper.getMapList(topSql,connection);
	ResultSet rsCounts = dbHelper.executeQuery(topCount);
    while (rsCounts!=null && rsCounts.next()){k=rsCounts.getInt("newsCount");}
	int totalPage = k / 10 + (k % 10 > 0 ? 1 : 0);
	
	//TDK
	String tdk_title="【"+(String)(year.equals("")?"":year+"年")+(String)(month.equals("")?"":month+"月")+(String)(show_season.equals("")?"":show_season+"季度")+(factoryid.equals("")?"":CommonString.getFormatPara(brandMap.get(factoryid)))+(catalog.equals("")?"":CommonString.getFormatPara(catalogMap.get(catalog)))+"排行榜】"+(factoryid.equals("")?"":CommonString.getFormatPara(brandMap.get(factoryid)))+(catalog.equals("")?"":CommonString.getFormatPara(catalogMap.get(catalog)))+"产品排名 - 铁臂排行榜";
	String tdk_keywords=(String)(!year.equals("")&&!factoryid.equals("")?year+"年"+CommonString.getFormatPara(brandMap.get(factoryid))+"排行榜,":"")+(String)(!year.equals("")&&!catalog.equals("")?year+"年"+CommonString.getFormatPara(catalogMap.get(catalog))+"排行榜,":"")+(String)(!year.equals("")&&!catalog.equals("")&&!factoryid.equals("")?year+"年"+CommonString.getFormatPara(brandMap.get(factoryid))+CommonString.getFormatPara(catalogMap.get(catalog))+"排行榜,":"")+(String)(!month.equals("")||!season.equals("")?(String)(year.equals("")?"":year+"年")+(String)(month.equals("")?"":month+"月")+(String)(show_season.equals("")?"":show_season+"季度")+(factoryid.equals("")?"":CommonString.getFormatPara(brandMap.get(factoryid)))+(catalog.equals("")?"":CommonString.getFormatPara(catalogMap.get(catalog)))+"排行榜,":"")+(String)(catalog.equals("")?"":CommonString.getFormatPara(catalogMap.get(catalog))+"排行榜,")+(String)(factoryid.equals("")?"":CommonString.getFormatPara(brandMap.get(factoryid))+"排行榜,");
	tdk_keywords=tdk_keywords.substring(0,tdk_keywords.length());
	String tdk_desc="铁臂商城为您提供最新的"+(String)(year.equals("")?"":year+"年")+(String)(month.equals("")?"":month+"月")+(String)(show_season.equals("")?"":show_season+"季度")+(factoryid.equals("")?"":CommonString.getFormatPara(brandMap.get(factoryid)))+(catalog.equals("")?"":CommonString.getFormatPara(catalogMap.get(catalog)))+"排行榜, "+(String)(year.equals("")?"":year+"年")+(String)(month.equals("")?"":month+"月")+(String)(show_season.equals("")?"":show_season+"季度")+(factoryid.equals("")?"":CommonString.getFormatPara(brandMap.get(factoryid)))+(catalog.equals("")?"":CommonString.getFormatPara(catalogMap.get(catalog)))+"排行榜产品排名, 帮您实时了解"+(String)(year.equals("")?"":year+"年")+(String)(month.equals("")?"":month+"月")+(String)(show_season.equals("")?"":show_season+"季度")+(factoryid.equals("")?"":CommonString.getFormatPara(brandMap.get(factoryid)))+(catalog.equals("")?"":CommonString.getFormatPara(catalogMap.get(catalog)))+"产品排名变化，买"+(factoryid.equals("")?"":CommonString.getFormatPara(brandMap.get(factoryid)))+(catalog.equals("")?"":CommonString.getFormatPara(catalogMap.get(catalog)))+"就上铁臂商城。";
 %><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title><%=tdk_title%></title>
<meta name="keywords" content="<%=tdk_keywords%>" />
<meta name="description" content="<%=tdk_desc%>" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="author" content="design by www.21-sun.com" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<link href="../style/style.css" rel="stylesheet" type="text/css" />
<link href="/style/new_style.css" rel="stylesheet" type="text/css" />

<script type="text/javascript" src="/scripts/jquery-1.7.min.js"></script>
<script type="text/javascript" src="/scripts/scripts.js"></script>
</head>
<body>
<!--top-->
<jsp:include page="/include/top.jsp" flush="true"></jsp:include>
<jsp:include page="tongji.jsp" flush="true" />
<!--面包屑-->
<div class="contain980 mb10">
  <h3 class="breadCrumbs"><a href="http://top.21-sun.com/">铁臂排行榜</a> &gt;&gt; 
  <%if(!year.equals("")){%>  
  <a href="/pro_<%=year%>_0_0_0_0_0.htm"><%=year%></a> &gt;&gt; 
  <%}%>
  <%if(!month.equals("")){%>
  <a href="/pro_<%=year.equals("")?"0":year%>_<%=month%>_0_0_0_0.htm"><%=month%>月份</a> &gt;&gt; 
  <%}%>
  <%if(!season.equals("")){%>
  <a href="/pro_<%=year.equals("")?"0":year%>_0_<%=show_season%>_0_0_0.htm"><%=show_season%>季度</a> &gt;&gt; 
  <%}%>
  <%if(!factoryid.equals("")){%>
  <a href='/pro_<%=year.equals("")?"0":year%>_0_0_<%=factoryid%>_0_0.htm'><%=CommonString.getFormatPara(brandMap.get(factoryid))%></a> &gt;&gt;  
  <%}%>
  <%if(!catalog.equals("")){%>
  <a href='/pro_<%=year.equals("")?"0":year%>_0_0_0_<%=catalog%>_0.htm'><%=CommonString.getFormatPara(catalogMap.get(catalog))%></a> &gt;&gt;  
  <%}%>
  <%if(!month.equals("")||!season.equals("")||!factoryid.equals("")||!catalog.equals("")||!year.equals("")){%>
  <%=year.equals("")?"":year+"年"%><%=month.equals("")?"":month+"月份"%><%=show_season.equals("")?"":show_season+"季度"%><%=CommonString.getFormatPara(brandMap.get(factoryid))%><%=CommonString.getFormatPara(catalogMap.get(catalog))%>排行
  <%}%>
  
  <%if(!catalogname.equals("")){%>
  <%=catalogname %>排名
  <%}%>
  </h3>
</div>
<!--面包屑结束--> 
<!--main-->
<div class="contain980 mb10">

  <div class="brand_crumbss"> 
    <a href="http://top.21-sun.com/" >排行榜首页</a>
    <a href="/brand_list.jsp">品牌排行榜</a> 
    <a href="/pro_list.jsp" >产品排行榜</a> 
    <a href="/pro_0_0_0_0_101001_0.htm">挖掘机排行榜</a>
    <a  href="/pro_0_0_0_0_101002_0.htm">装载机排行榜</a>
  </div>

<%
  if(null!=allProducts && allProducts.size()>0){
  	   String cataNum="";
	   String cataName="";
	  int i=((Integer.parseInt(offset)-1)*10)+1 ;
	  for(Map oneMap:allProducts){
	  cataNum=CommonString.getFormatPara(oneMap.get("catalognum"));
	   if(cataNum.length()>6){cataNum=cataNum.substring(0,6);}
	   cataName=CommonString.getFormatPara(catalogMap.get(cataNum));
		  %>
<div class="<%=(i<=3&&("".equals(offset)||"0".equals(offset)||"1".equals(offset)))?"rl top3":"rl" %>"> <em><%=i %></em>
  <div class="img"><a href="http://product.21-sun.com/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")) %>" target="_blank"><img src="http://product.21-sun.com/uploadfiles/<%=CommonString.getFormatPara(oneMap.get("img2")) %>" width="131" height="84" title="<%=CommonString.getFormatPara(oneMap.get("factoryname")) %><%=CommonString.getFormatPara(oneMap.get("name"))%><%=CommonString.getFormatPara(oneMap.get("catalogname")) %>" onerror="showImgDelay(this,'/uploadfiles/no_big.gif',2);" /></a></div>
  <div class="rlRight" style="position:relative">
    <div class="rlt">
      <h2><a title="<%=CommonString.getFormatPara(oneMap.get("factoryname")) %><%=CommonString.getFormatPara(oneMap.get("name"))%><%=CommonString.getFormatPara(oneMap.get("catalogname")) %>" href="http://product.21-sun.com/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")) %>" target="_blank"><%=CommonString.getFormatPara(oneMap.get("factoryname")) %><%=CommonString.getFormatPara(oneMap.get("name"))%><%=CommonString.getFormatPara(oneMap.get("catalogname")) %></a></h2>
      <span>关注指数：<%=Integer.parseInt(CommonString.getFormatPara(oneMap.get("allCount")))*15%></span> </div>
      <div class="rli"><%=CommonString.substringByte(CommonHtml.filterHTML(CommonString.getFormatPara(oneMap.get("introduce"))),220)+"..." %><a href="http://product.21-sun.com/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")) %>" target="_blank"><font color="red"><strong>详细信息</strong></font></a></div>
      <div class="tag_list"><a target="_blank"  title="<%=CommonString.getFormatPara(oneMap.get("factoryname"))%>" href="http://product.21-sun.com/products/prolist.jsp?factory=<%=CommonString.getFormatPara(oneMap.get("factoryid"))%>"><%=CommonString.getFormatPara(oneMap.get("factoryname"))%></a><b>|</b><a target="_blank"  href="http://product.21-sun.com/products/prolist.jsp?factory=<%=CommonString.getFormatPara(oneMap.get("factoryid"))%>&catalog=<%=cataNum%>" title="<%=CommonString.getFormatPara(oneMap.get("factoryname")).replace("卡特彼勒","卡特")%><%=cataName%>"><%=CommonString.getFormatPara(oneMap.get("factoryname")).replace("卡特彼勒","卡特")%><%=cataName%></a></div>
  </div>
</div>
<%
		  i++ ;
	  }
  }
%>
<!--翻页-->
<div class="wfull l">
  <div id="pagination" class="page">
    <%
	  if(catalog.equals("")){catalog="0";}
	  if(factoryid.equals("")){factoryid="0";}
	  if(month.equals("")){month="0";}
	  if(year.equals("")){year="0";}
	  if(season.equals("")){season="0";}
	  if(tonnage.equals("")){tonnage="0";}
	%>
    <tags:page_pro_rank catalog="<%=catalog %>" tonnage="<%=tonnage%>" factory="<%=factoryid%>"  nowPage="<%=Integer.parseInt(offset)%>" month="<%=month%>" year="<%=year%>" season="<%=season%>" total="<%=k%>" totalPage="<%=totalPage%>"/>
  </div>
</div>
<!--翻页-->
<div class="clear"></div>
<!--main end--> 
<!--foot-->
<jsp:include page="/include/foot.jsp" flush="true"></jsp:include>
<script type="text/javascript" src="/scripts/sort.js"></script> 
<!--end of foot--> 
<script type="text/javascript">
<% if(referer.indexOf("products.jsp")!=-1){%>
	    //jQuery('html, body').animate({scrollTop: 215}, 0);
	 <% }%>
</script>
<div style="display:none"> <script type="text/javascript">var cnzz_protocol = (("https:" == document.location.protocol) ? " https://" : " http://");document.write(unescape("%3Cspan id='cnzz_stat_icon_5953945'%3E%3C/span%3E%3Cscript src='" + cnzz_protocol + "s11.cnzz.com/stat.php%3Fid%3D5953945' type='text/javascript'%3E%3C/script%3E"));</script> </div>
</body>
</html>
<%
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		DBHelper.freeConnection(connection);
	}
%>
</cache:cache>