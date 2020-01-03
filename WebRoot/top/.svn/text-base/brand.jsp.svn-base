<%@ page language="java"  pageEncoding="UTF-8"%><%@page import="com.jerehnet.util.common.CommonString"%><%@page import="com.jerehnet.util.dbutil.PageBean"%><%@page import="java.util.List"%><%@page import="java.util.Map"%><%@page import="com.jerehnet.util.common.CommonHtml"%><%@taglib tagdir="/WEB-INF/tags" prefix="tags"%><%@ taglib uri="/WEB-INF/classes/oscache.tld" prefix="cache" %><%@page import="java.sql.Connection,com.jerehnet.webservice.*,com.jerehnet.util.dbutil.*,java.sql.*,java.util.*"%><%
	String referer = CommonString.getFormatPara(request.getHeader("referer")) ;
	String flag  = CommonString.getFormatPara(request.getParameter("flag")) ; // 标识 brand 按品牌排序 product 按产品排序
	String offset = "".equals(CommonString.getFormatPara(request.getParameter("offset")))?"0":CommonString.getFormatPara(request.getParameter("offset")) ;
	String catalog = CommonString.getFilterStr(request.getParameter("catalog")) ;
	String year = CommonString.getFilterStr(request.getParameter("year")) ;
	String month = CommonString.getFilterStr(request.getParameter("month")) ;
    String season = CommonString.getFilterStr(request.getParameter("season")) ;
	String area = CommonString.getFilterStr(request.getParameter("area")) ;
	String tonnage = CommonString.getFilterStr(request.getParameter("tonnage")) ;
	Map catalogMap = (HashMap)application.getAttribute("catalogMap") ;
	Map brandMap = (HashMap)application.getAttribute("brandMap") ;
%>
 	<cache:cache  cron="* * * */15 *">
<%
    //参数处理
    if(catalog.equals("0")){catalog="";}
	if(year.equals("0")){year="";} 
	if(month.equals("0")){month="";}
	if(season.equals("0")){season="";} 
	if(offset.equals("0")){offset="1";} 
	if(area.equals("0")){area="";} 
	if(tonnage.equals("0")){tonnage="";} 	
	String show_season="";
    String factoryType="";
	String proType="";
	String proTypeSql="";
	String cachekey = flag+offset ;
	//查询新
    DBHelper dbHelper = DBHelper.getInstance();
    Connection connection = null;
    String whereStr=" is_deleted=0 ";
	int k=0;
	if(!area.equals("")){factoryType=" and is_inner="+(Integer.parseInt(area)-1);} 
	if(!catalog.equals("")){whereStr=whereStr+" and catanum like '"+catalog+"%'";}
	if(!year.equals("")){whereStr=whereStr+" and DATEPART(year, add_date)="+year;}
	if(!month.equals("")){whereStr=whereStr+" and DATEPART(month, add_date)="+month;}
	if(!season.equals("")){
         if(season.equals("1")){show_season="一"; whereStr=whereStr+" and (DATEPART(month, add_date)=1 or DATEPART(month, add_date)=2 or DATEPART(month, add_date)=3)";} 
		 if(season.equals("2")){show_season="二"; whereStr=whereStr+" and (DATEPART(month, add_date)=4 or DATEPART(month, add_date)=5 or DATEPART(month, add_date)=6)";} 
		 if(season.equals("3")){show_season="三"; whereStr=whereStr+" and (DATEPART(month, add_date)=7 or DATEPART(month, add_date)=8 or DATEPART(month, add_date)=9)";}
		 if(season.equals("4")){show_season="四"; whereStr=whereStr+" and (DATEPART(month, add_date)=10 or DATEPART(month, add_date)=11 or DATEPART(month, add_date)=12)";} 
	}
	String topSql="";
	String topCount="";
	try{
  	connection = dbHelper.getConnection();	
    topSql="SELECT  top 10 allCount,factoryid,name,full_name,logo,english_name,usern,introduce from (SELECT  COUNT(*) AS allCount,factoryid from pro_product_form  WHERE "+whereStr+" GROUP BY factoryid ) as h INNER JOIN ( SELECT name,full_name,logo,id,english_name,usern,view_count,introduce  FROM pro_agent_factory WHERE flag=1 "+factoryType+") AS j ON  j.id=h.factoryid AND h.factoryid NOT IN  (SELECT  top "+(Integer.parseInt(offset)-1)*10+" factoryid from (SELECT  COUNT(*) AS allCount,factoryid from pro_product_form  WHERE "+whereStr+" GROUP BY factoryid ) as h INNER JOIN ( SELECT id  FROM pro_agent_factory WHERE flag=1 "+factoryType+") AS j ON  j.id=h.factoryid   ORDER BY (h.allCount) DESC ) ORDER BY (h.allCount) DESC ";   
	//修改
	if(area.equals("")){
	  topCount="SELECT count(*) as newsCount from (SELECT  factoryid from pro_product_form  where "+whereStr+" GROUP BY factoryid having factoryid!=0   AND factoryid IS NOT NULL) t ";
	}else{
	   topCount="SELECT count(*) as newsCount from (SELECT  factoryid from pro_product_form  where "+whereStr+" GROUP BY factoryid having factoryid!=0   AND factoryid IS NOT NULL and factoryid in (select id from pro_agent_factory where flag=1 "+factoryType+" )) t ";
	}
	ResultSet rsCounts = dbHelper.executeQuery(topCount);

    while (rsCounts!=null && rsCounts.next()){k=rsCounts.getInt("newsCount");}
	int totalPage = k / 10 + (k % 10 > 0 ? 1 : 0);
	List<Map> allBrands =dbHelper.getMapList(topSql,connection);
	
	//TDK
	String tdk_title="【"+(String)(year.equals("")?"":year+"年")+(String)(month.equals("")?"":month+"月")+(String)(show_season.equals("")?"":show_season+"季度")+(catalog.equals("")?"":CommonString.getFormatPara(catalogMap.get(catalog)))+"品牌排行榜】"+(catalog.equals("")?"":CommonString.getFormatPara(catalogMap.get(catalog)))+"品牌排名 - 铁臂排行榜";
	String tdk_keywords=(String)(year.equals("")?"":year+"年"+(catalog.equals("")?"":CommonString.getFormatPara(catalogMap.get(catalog)))+"品牌排行榜,")+(String)(month.equals("")?"":year+"年"+month+"月"+(catalog.equals("")?"":CommonString.getFormatPara(catalogMap.get(catalog)))+"品牌排行榜,")+(catalog.equals("")?"":CommonString.getFormatPara(catalogMap.get(catalog))+"品牌排行榜,")+(catalog.equals("")?"":CommonString.getFormatPara(catalogMap.get(catalog)))+"品牌排名 ";
	String tdk_desc="铁臂商城为您提供最新的"+(String)(year.equals("")?"":year+"年")+(String)(month.equals("")?"":month+"月")+(String)(show_season.equals("")?"":show_season+"季度")+(catalog.equals("")?"":CommonString.getFormatPara(catalogMap.get(catalog)))+"品牌排行榜, "+(String)(year.equals("")?"":year+"年")+(String)(month.equals("")?"":month+"月")+(String)(show_season.equals("")?"":show_season+"季度")+(catalog.equals("")?"":CommonString.getFormatPara(catalogMap.get(catalog)))+"品牌排名, 帮您实时了解"+(String)(year.equals("")?"":year+"年")+(String)(month.equals("")?"":month+"月")+(String)(show_season.equals("")?"":show_season+"季度")+(catalog.equals("")?"":CommonString.getFormatPara(catalogMap.get(catalog)))+"品牌排名变化，买"+(catalog.equals("")?"":CommonString.getFormatPara(catalogMap.get(catalog)))+"就上铁臂商城。";
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

  <div class="brand_crumbss"> 
    <a href="http://top.21-sun.com/" >排行榜首页</a>
    <a href="/brand_list.jsp">品牌排行榜</a> 
    <a href="/pro_list.jsp" >产品排行榜</a> 
    <a href="/pro_0_0_0_0_101001_0.htm">挖掘机排行榜</a>
    <a  href="/pro_0_0_0_0_101002_0.htm">装载机排行榜</a>
  </div>

  <h3 class="breadCrumbs"><a href="http://top.21-sun.com/">铁臂排行榜</a> &gt;&gt;  
  <%if(!year.equals("")){%>  
  <a href="/brand_<%=year%>_0_0_0_0.htm"><%=year%></a> &gt;&gt; 
  <%}%>
  <%if(!month.equals("")){%>
  <a href="/brand_<%=year.equals("")?"0":year%>_<%=month%>_0_0_0.htm"><%=month%>月份</a> &gt;&gt; 
  <%}%>
  <%if(!season.equals("")){%>
  <a href="/brand_<%=year.equals("")?"0":year%>_0_<%=season%>_0_0.htm"><%=show_season%>季度</a> &gt;&gt; 
  <%}%>
  <%if(!catalog.equals("")){%>
  <a href='/brand_<%=year.equals("")?"0":year%>_0_0_<%=catalog%>_0.htm'><%=CommonString.getFormatPara(catalogMap.get(catalog))%></a> &gt;&gt;  
  <%}%>
  <%if(!month.equals("")||!season.equals("")||!catalog.equals("")||!year.equals("")){%>
  <%=year.equals("")?"":year+"年"%><%=month.equals("")?"":month+"月份"%><%=show_season.equals("")?"":show_season+"季度"%><%=CommonString.getFormatPara(catalogMap.get(catalog))%>排行
  <%}%>
  </h3>
</div>
<!--面包屑结束--> 
<!--main-->
<div class="contain980 mb10">
<%
  if(null!=allBrands && allBrands.size()>0){
	  int i=((Integer.parseInt(offset)-1)*10)+1 ;
	  for(Map oneMap:allBrands){
		  %>
<div class="<%=(i<=3&&("".equals(offset)||"0".equals(offset)||"1".equals(offset)))?"rl top3":"rl" %>"> <em><%=i %></em>
  <div class="img jlb"><a href="http://product.21-sun.com/brand/<%=CommonString.getFormatPara(oneMap.get("usern")) %>/" target="_blank"><img src="http://product.21-sun.com/uploadfiles/<%=CommonString.getFormatPara(oneMap.get("logo")) %>" width="131" height="84" title="<%=CommonString.getFormatPara(oneMap.get("full_name")) %>" onerror="showImgDelay(this,'/uploadfiles/no_small.gif',2);" /></a></div>
  <div class="rlRight">
    <div class="rlt">
      <h2><a title="<%=CommonString.getFormatPara(oneMap.get("full_name")) %>" href="http://product.21-sun.com/brand/<%=CommonString.getFormatPara(oneMap.get("usern")) %>/" target="_blank"><%=CommonString.getFormatPara(oneMap.get("full_name")) %></a></h2>
      <span>专注指数：<%=CommonString.getFormatPara(oneMap.get("allCount")) %></span> </div>
    <div class="rli"><%=CommonString.substringByte(CommonHtml.filterHTML(CommonString.getFormatPara(oneMap.get("introduce"))),225)+"..." %><a href="http://product.21-sun.com/brand/<%=CommonString.getFormatPara(oneMap.get("usern")) %>/" target="_blank"><strong><font color="red">详细信息</font></strong></a></div>
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
	  if(month.equals("")){month="0";}
	  if(year.equals("")){year="0";}
	  if(season.equals("")){season="0";}
	   if(area.equals("")){area="0";}
	%>
    <tags:page_bra_rank catalog="<%=catalog %>" area="<%=area%>"   nowPage="<%=Integer.parseInt(offset)%>" month="<%=month%>" year="<%=year%>" season="<%=season%>" total="<%=k%>" totalPage="<%=totalPage%>"/>
  </div>
</div>
<!--翻页-->
<div class="clear"></div>
<!--main end--> 
<!--foot-->
<jsp:include page="/include/foot.jsp" flush="true"></jsp:include>
<jsp:include page="/include/koubei_ad.jsp" flush="false"/>
<script type="text/javascript" src="/scripts/sort.js"></script> 
<!--end of foot--> 

<style type="text/css">
/*对联广告*/
/*左侧*/
#ads01 { position:fixed; left:0px; top:80px; z-index:999999; width:42px; height:350px;}
* html #ads01 {position:absolute; left:expression(eval(document.documentElement.scrollLeft)); top:expression(eval(document.documentElement.scrollTop)+100);}
/*右侧*/
.hide { display:none;}
.ads_big { display:none;}
#ads01.ads_hover,#ads02.ads_hover { width:95px!important;}
.ads_hover .ads_small { display:none;}
.ads_hover .ads_big { display:block;}
/*对联广告结束*/
</style>



<script type="text/javascript">
<%
 if(referer.indexOf("brand.jsp")!=-1){
	 %>
	    //jQuery('html, body').animate({scrollTop: 215}, 0);
	 <%
 }
%>
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