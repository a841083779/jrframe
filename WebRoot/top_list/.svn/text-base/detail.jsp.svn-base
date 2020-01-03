<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<%@page import="com.jerehnet.util.common.CommonString"%>
<%@page import="com.jerehnet.util.common.CommonDate"%>
<%@page import="com.jerehnet.util.common.CommonHtml"%>
<%@page import="com.jerehnet.util.dbutil.PageBean"%>
<%@page import="java.sql.Connection,com.jerehnet.webservice.*,com.jerehnet.util.dbutil.*,java.sql.*,java.util.*"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="tags" %>
<%@ taglib uri="/WEB-INF/classes/oscache.tld" prefix="cache"%>
<%  
    DBHelper dbHelper = DBHelper.getInstance();
    Connection connection = null;
	String factory=CommonString.getFilterStr(request.getParameter("factory")) ;
    String catalog = CommonString.getFilterStr(request.getParameter("catalog")) ;
	String year = CommonString.getFilterStr(request.getParameter("year")) ;
	String month = CommonString.getFilterStr(request.getParameter("month")) ;
    String season = CommonString.getFilterStr(request.getParameter("season")) ;
	String tonnage = CommonString.getFilterStr(request.getParameter("tonnage")) ;
	String show_season="";
	String proType="";
	String tonnageName="";
	Map catalogMap = (HashMap)application.getAttribute("catalogMap") ;
	Map brandMap = (HashMap)application.getAttribute("brandMap") ;
	if(catalog.equals("0")){catalog="";}if(year.equals("0")){year="";}if(month.equals("0")){month="";}
	if(season.equals("0")){season="";} if(factory.equals("0")){factory="";}if(tonnage.equals("0")){tonnage="";}
	String whereStr=" is_deleted=0 and product_id!=0";
    String whereStrOther="is_deleted=0 and product_id!=0";
    if(tonnage.equals("1")){proType+=" where tonandmeter <=13   and tonandmeter >=1"; tonnageName="小挖";}
	if(tonnage.equals("2")){proType+=" where tonandmeter <30   and tonandmeter >=14"; tonnageName="中挖";}
	if(tonnage.equals("3")){proType+=" where tonandmeter >=30"; tonnageName="大挖";}
	if(!factory.equals("")){whereStr=whereStr+" and factoryid ="+factory;}
	if(!catalog.equals("")){whereStr=whereStr+" and catanum like '"+catalog+"%'";  whereStrOther=whereStrOther+" and catanum like '"+catalog+"%'";}
	if(!year.equals("")){whereStr=whereStr+" and DATEPART(year, add_date)="+year;}
	if(!month.equals("")){whereStr=whereStr+" and DATEPART(month, add_date)="+month;}
	if(!season.equals("")){
         if(season.equals("1")){show_season="一"; whereStr=whereStr+" and (DATEPART(month, add_date)=1 or DATEPART(month, add_date)=2 or DATEPART(month, add_date)=3)";} 
		 if(season.equals("2")){show_season="二"; whereStr=whereStr+" and (DATEPART(month, add_date)=4 or DATEPART(month, add_date)=5 or DATEPART(month, add_date)=6)";} 
		 if(season.equals("3")){show_season="三"; whereStr=whereStr+" and (DATEPART(month, add_date)=7 or DATEPART(month, add_date)=8 or DATEPART(month, add_date)=9)";}
		 if(season.equals("4")){show_season="四"; whereStr=whereStr+" and (DATEPART(month, add_date)=10 or DATEPART(month, add_date)=11 or DATEPART(month, add_date)=12)";} 
	}	
	try{
  	connection = dbHelper.getConnection();
	String sql="SELECT top 10 allCount,img2,factoryname,catalogname,name,file_name,factoryid,catalognum,id,view_count,introduce from (SELECT  COUNT(*) AS allCount,product_id from pro_product_form  WHERE  "+whereStr+" GROUP BY product_id) as h inner JOIN ( SELECT img2,factoryname,catalogname,name,file_name,factoryid,catalognum,id,view_count,introduce FROM pro_products  "+proType+") AS j ON  j.id=h.product_id ORDER BY h.allCount DESC  ";   
	String sqlOther="SELECT top 10 allCount,img2,factoryname,catalogname,name,file_name,factoryid,catalognum,id,view_count,introduce from (SELECT  COUNT(*) AS allCount,product_id from pro_product_form  WHERE  "+whereStrOther+" GROUP BY product_id) as h inner JOIN ( SELECT img2,factoryname,catalogname,name,file_name,factoryid,catalognum,id,view_count,introduce FROM pro_products ) AS j ON  j.id=h.product_id ORDER BY h.allCount DESC  ";   


	//查询
	List <Map> list = dbHelper.getMapList(sql,connection);
	String tdk_title="";String tdk_keywords="";String tdk_desc="";
	
    //TDK
	if(tonnage.equals("")){
	tdk_title="【"+(String)(year.equals("")?"":year+"年")+(String)(month.equals("")?"":month+"月")+(String)(show_season.equals("")?"":show_season+"季度")+(factory.equals("")?"":CommonString.getFormatPara(brandMap.get(factory)))+(catalog.equals("")?"":CommonString.getFormatPara(catalogMap.get(catalog)))+"排行榜】"+(factory.equals("")?"":CommonString.getFormatPara(brandMap.get(factory)))+(catalog.equals("")?"":CommonString.getFormatPara(catalogMap.get(catalog)))+"产品排名 - 铁臂商城排行榜";
	tdk_keywords=(String)(!year.equals("")&&!factory.equals("")?year+"年"+CommonString.getFormatPara(brandMap.get(factory))+"排行榜,":"")+(String)(!year.equals("")&&!catalog.equals("")?year+"年"+CommonString.getFormatPara(catalogMap.get(catalog))+"排行榜,":"")+(String)(!year.equals("")&&!catalog.equals("")&&!factory.equals("")?year+"年"+CommonString.getFormatPara(brandMap.get(factory))+CommonString.getFormatPara(catalogMap.get(catalog))+"排行榜,":"")+(String)(!month.equals("")||!season.equals("")?(String)(year.equals("")?"":year+"年")+(String)(month.equals("")?"":month+"月")+(String)(show_season.equals("")?"":show_season+"季度")+(factory.equals("")?"":CommonString.getFormatPara(brandMap.get(factory)))+(catalog.equals("")?"":CommonString.getFormatPara(catalogMap.get(catalog)))+"排行榜,":"")+(String)(catalog.equals("")?"":CommonString.getFormatPara(catalogMap.get(catalog))+"排行榜,")+(String)(factory.equals("")?"":CommonString.getFormatPara(brandMap.get(factory))+"排行榜,");
	tdk_keywords=tdk_keywords.substring(0,tdk_keywords.length());
	tdk_desc="铁臂商城为您提供最新的"+(String)(year.equals("")?"":year+"年")+(String)(month.equals("")?"":month+"月")+(String)(show_season.equals("")?"":show_season+"季度")+(factory.equals("")?"":CommonString.getFormatPara(brandMap.get(factory)))+(catalog.equals("")?"":CommonString.getFormatPara(catalogMap.get(catalog)))+"排行榜, "+(String)(year.equals("")?"":year+"年")+(String)(month.equals("")?"":month+"月")+(String)(show_season.equals("")?"":show_season+"季度")+(factory.equals("")?"":CommonString.getFormatPara(brandMap.get(factory)))+(catalog.equals("")?"":CommonString.getFormatPara(catalogMap.get(catalog)))+"排行榜产品排名, 帮您实时了解"+(String)(year.equals("")?"":year+"年")+(String)(month.equals("")?"":month+"月")+(String)(show_season.equals("")?"":show_season+"季度")+(factory.equals("")?"":CommonString.getFormatPara(brandMap.get(factory)))+(catalog.equals("")?"":CommonString.getFormatPara(catalogMap.get(catalog)))+"产品排名变化，买"+(factory.equals("")?"":CommonString.getFormatPara(brandMap.get(factory)))+(catalog.equals("")?"":CommonString.getFormatPara(catalogMap.get(catalog)))+"就上铁臂商城。";
    }else{
	tdk_title="【"+(String)(year.equals("")?"":year+"年")+(String)(month.equals("")?"":month+"月")+(String)(show_season.equals("")?"":show_season+"季度")+(factory.equals("")?"":CommonString.getFormatPara(brandMap.get(factory)))+tonnageName+"排行榜】"+(factory.equals("")?"":CommonString.getFormatPara(brandMap.get(factory)))+tonnageName+"产品排名 - 铁臂商城排行榜";
	tdk_keywords=(String)(!year.equals("")&&!factory.equals("")?year+"年"+CommonString.getFormatPara(brandMap.get(factory))+"排行榜,":"")+(String)(!year.equals("")&&!catalog.equals("")?year+"年"+CommonString.getFormatPara(catalogMap.get(catalog))+"排行榜,":"")+(String)(!year.equals("")&&!catalog.equals("")&&!factory.equals("")?year+"年"+CommonString.getFormatPara(brandMap.get(factory))+CommonString.getFormatPara(catalogMap.get(catalog))+"排行榜,":"")+(String)(!month.equals("")||!season.equals("")?(String)(year.equals("")?"":year+"年")+(String)(month.equals("")?"":month+"月")+(String)(show_season.equals("")?"":show_season+"季度")+(factory.equals("")?"":CommonString.getFormatPara(brandMap.get(factory)))+tonnageName+"排行榜,":"")+(String)(catalog.equals("")?"":CommonString.getFormatPara(catalogMap.get(catalog))+"排行榜,")+(String)(factory.equals("")?"":CommonString.getFormatPara(brandMap.get(factory))+"排行榜,");
	tdk_keywords=tdk_keywords.substring(0,tdk_keywords.length());
	tdk_desc="铁臂商城为您提供最新的"+(String)(year.equals("")?"":year+"年")+(String)(month.equals("")?"":month+"月")+(String)(show_season.equals("")?"":show_season+"季度")+(factory.equals("")?"":CommonString.getFormatPara(brandMap.get(factory)))+tonnageName+"排行榜, "+(String)(year.equals("")?"":year+"年")+(String)(month.equals("")?"":month+"月")+(String)(show_season.equals("")?"":show_season+"季度")+(factory.equals("")?"":CommonString.getFormatPara(brandMap.get(factory)))+tonnageName+"排行榜产品排名, 帮您实时了解"+(String)(year.equals("")?"":year+"年")+(String)(month.equals("")?"":month+"月")+(String)(show_season.equals("")?"":show_season+"季度")+(factory.equals("")?"":CommonString.getFormatPara(brandMap.get(factory)))+tonnageName+"产品排名变化，买"+(factory.equals("")?"":CommonString.getFormatPara(brandMap.get(factory)))+tonnageName+"就上铁臂商城。";
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title><%=tdk_title%></title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="keywords" content="<%=tdk_keywords%>" />
<meta name="description" content="<%=tdk_desc%>" />
<meta name="author" content="design by www.21-sun.com" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<link href="/style/style.css" rel="stylesheet" type="text/css" />
<link href="/style/new_style.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="/scripts/jquery-1.7.min.js"></script>
<script type="text/javascript" src="/scripts/scripts.js"></script>
<!-- jbox -->
<script type="text/javascript" src="/scripts/jBox-v2.3/jquery.jBox-2.3.min.js"></script>
<script type="text/javascript" src="/scripts/jBox-v2.3/i18n/jquery.jBox-zh-CN.js"></script>
<link type="text/css" rel="stylesheet" href="/scripts/jBox-v2.3/Skins2/Blue/jbox.css" />
</head>
<body>
<!--top-->
<jsp:include page="/include/top.jsp" flush="true"></jsp:include>
<!--面包屑-->
<div class="contain980 mb10">
  <h3 class="breadCrumbs"> <a href="http://top.21-sun.com/">铁臂商城排行榜</a> &gt;&gt;
  <%if(!year.equals("")){%>  
  <a href="/pro_<%=year%>_0_0_0_0_0.htm"><%=year%></a> &gt;&gt; 
  <%}%>
  <%if(!month.equals("")){%>
  <a href="/pro_<%=year.equals("")?"0":year%>_<%=month%>_0_0_0_0.htm"><%=month%>月份</a> &gt;&gt; 
  <%}%>
  <%if(!season.equals("")){%>
  <a href="/pro_<%=year.equals("")?"0":year%>_0_<%=season%>_0_0_0.htm"><%=show_season%>季度</a> &gt;&gt; 
  <%}%>
  <%if(!factory.equals("")){%>
  <a href='/pro_<%=year.equals("")?"0":year%>_0_0_<%=factory%>_0_<%=tonnage.equals("")?"0":tonnage%>.htm'><%=CommonString.getFormatPara(brandMap.get(factory))%></a> &gt;&gt;  
  <%}%>
  <%if(!catalog.equals("")){%>
  <a href='/pro_<%=year.equals("")?"0":year%>_0_0_0_<%=catalog%>_<%=tonnage.equals("")?"0":tonnage%>.htm'><%=CommonString.getFormatPara(catalogMap.get(catalog))%></a> &gt;&gt;  
  <%}%>
  <%if(!month.equals("")||!season.equals("")||!factory.equals("")||!catalog.equals("")||!year.equals("")){%>
  <%=year.equals("")?"":year+"年"%><%=month.equals("")?"":month+"月份"%><%=show_season.equals("")?"":show_season+"季度"%><%=CommonString.getFormatPara(brandMap.get(factory))%><%=CommonString.getFormatPara(catalogMap.get(catalog))%>排行
  <%}%>
  </h3>
</div>
<!--面包屑结束--> 
<!--main-->
<div class="contain980 mb10">

  <div class="brand_crumbss"> 
    <a href="http://top.21-sun.com/" >排行榜首页</a>
    <a href="/brand_list.jsp">品牌排行榜</a> 
    <a <%if(!catalog.equals("101001")&&!catalog.equals("101002")){%>class="now"<%}%>  href="/pro_list.jsp" >产品排行榜</a> 
    <a <%if(catalog.equals("101001")){%>class="now"<%}%> href="/pro_0_0_0_0_101001_0.htm">挖掘机排行榜</a>
    <a <%if(catalog.equals("101002")){%>class="now"<%}%> href="/pro_0_0_0_0_101002_0.htm">装载机排行榜</a>
  </div>

  <!--left-->
  <div class="w210 l np_left newLeft">
      <jsp:include flush="true" page="/include/rank/left_brand.jsp" >
	        <jsp:param value="<%=year%>" name="year"/>
            <jsp:param value="<%=month%>" name="month"/>
			<jsp:param value="<%=season%>" name="season"/>
			<jsp:param value="<%=catalog%>" name="catalog"/>
	  </jsp:include>
  </div>
  <!--left end--> 
  <!--right-->
  <div class="w757 r np_right mb10 newRight">
    <div class="brand_right_js">
      <script type="text/javascript">
	  $(document).ready(function() {
        $('.pbtn').click(function(){
			if($(this).hasClass('pbon')){
				$(this).removeClass('pbon');
				$(this).parent().next('.plmore').hide();
			}else{
				$(this).addClass('pbon');
				$(this).parent().next('.plmore').show();
			}
		})
      });
	  </script>
	 <div style="position:relative;">
      <h1><strong><%=year.equals("")?"":year+"年"%><%=month.equals("")?"":month+"月份"%><%=season.equals("")?"":show_season+"季度"%><%=factory.equals("")?"":CommonString.getFormatPara(brandMap.get(factory))%><%=catalog.equals("")?"工程机械":CommonString.getFormatPara(catalogMap.get(catalog))%>产品排行榜</strong></h1>
	  <div style="position:absolute;top:6px;right:8px;"><a target="_blank" href="/plist_<%=year.equals("")?"0":year%>_<%=month.equals("")?"0":month%>_<%=season.equals("")?"0":season%>_<%=factory.equals("")?"0":factory%>_<%=catalog.equals("")?"0":catalog%>_<%=tonnage.equals("")?"0":tonnage%>_1.htm" title="更多<%=year.equals("")?"":year+"年"%><%=month.equals("")?"":month+"月份"%><%=season.equals("")?"":show_season+"季度"%><%=factory.equals("")?"":CommonString.getFormatPara(brandMap.get(factory))%><%=catalog.equals("")?"工程机械":CommonString.getFormatPara(catalogMap.get(catalog))%>产品排行榜">更多</a></div>     
	 </div>
	 <p><strong>按类别：</strong>
	  <a <%if(catalog.equals("")){%> class="now" <%}%> href="/pro_<%=year.equals("")?"0":year%>_0_0_<%=factory.equals("")?"0":factory%>_0_0.htm">不限</a>
      <a <%if(catalog.equals("101001")){%> class="now" <%}%> href="/pro_<%=year.equals("")?"0":year%>_0_0_<%=factory.equals("")?"0":factory%>_101001_0.htm">挖掘机</a>
      <a <%if(catalog.equals("101002")){%> class="now" <%}%> href="/pro_<%=year.equals("")?"0":year%>_0_0_<%=factory.equals("")?"0":factory%>_101002_0.htm">装载机</a>
      <a <%if(catalog.equals("102")){%> class="now" <%}%> href="/pro_<%=year.equals("")?"0":year%>_0_0_<%=factory.equals("")?"0":factory%>_102_0.htm">起重机</a>
      <a <%if(catalog.equals("101003")){%> class="now" <%}%> href="/pro_<%=year.equals("")?"0":year%>_0_0_<%=factory.equals("")?"0":factory%>_101003_0.htm">推土机</a>
      <a <%if(catalog.equals("103")){%> class="now" <%}%> href="/pro_<%=year.equals("")?"0":year%>_0_0_<%=factory.equals("")?"0":factory%>_103_0.htm">混凝土</a>
      <a <%if(catalog.equals("106001")){%> class="now" <%}%> href="/pro_<%=year.equals("")?"0":year%>_0_0_<%=factory.equals("")?"0":factory%>_106001_0.htm">压路机</a>
      <a <%if(catalog.equals("101005")){%> class="now" <%}%> href="/pro_<%=year.equals("")?"0":year%>_0_0_<%=factory.equals("")?"0":factory%>_101005_0.htm">平地机</a>
      <a <%if(catalog.equals("105003")){%> class="now" <%}%> href="/pro_<%=year.equals("")?"0":year%>_0_0_<%=factory.equals("")?"0":factory%>_105003_0.htm">旋挖钻</a>
      <a <%if(catalog.equals("113003")){%> class="now" <%}%> href="/pro_<%=year.equals("")?"0":year%>_0_0_<%=factory.equals("")?"0":factory%>_113003_0.htm">破碎锤</a>
      <a <%if(catalog.equals("104001")){%> class="now" <%}%> href="/pro_<%=year.equals("")?"0":year%>_0_0_<%=factory.equals("")?"0":factory%>_104001_0.htm">摊铺机</a>
	  <span class="pbtn"></span></p>
      <jsp:include page="/include/rank/more_catalog.jsp" flush="true"></jsp:include>
      <p><strong>按年份：</strong>
	  <a <%if(year.equals("")){%>class="now"<%}%> href="/pro_0_0_0_<%=factory.equals("")?"0":factory%>_<%=catalog.equals("")?"0":catalog%>_<%=tonnage.equals("")?"0":tonnage%>.htm">总榜</a>
	  <a <%if(year.equals("2014")){%>class="now"<%}%> href="/pro_2014_0_0_<%=factory.equals("")?"0":factory%>_<%=catalog.equals("")?"0":catalog%>_<%=tonnage.equals("")?"0":tonnage%>.htm">2014</a>
	  <a <%if(year.equals("2013")){%>class="now"<%}%> href="/pro_2013_0_0_<%=factory.equals("")?"0":factory%>_<%=catalog.equals("")?"0":catalog%>_<%=tonnage.equals("")?"0":tonnage%>.htm">2013</a>
	  <a <%if(year.equals("2012")){%>class="now"<%}%> href="/pro_2012_0_0_<%=factory.equals("")?"0":factory%>_<%=catalog.equals("")?"0":catalog%>_<%=tonnage.equals("")?"0":tonnage%>.htm">2012</a>
	  <a <%if(year.equals("2011")){%>class="now"<%}%> href="/pro_2011_0_0_<%=factory.equals("")?"0":factory%>_<%=catalog.equals("")?"0":catalog%>_<%=tonnage.equals("")?"0":tonnage%>.htm">2011</a>
	  <a <%if(year.equals("2010")){%>class="now"<%}%> href="/pro_2010_0_0_<%=factory.equals("")?"0":factory%>_<%=catalog.equals("")?"0":catalog%>_<%=tonnage.equals("")?"0":tonnage%>.htm">2010</a>
	  <a <%if(year.equals("2009")){%>class="now"<%}%> href="/pro_2009_0_0_<%=factory.equals("")?"0":factory%>_<%=catalog.equals("")?"0":catalog%>_<%=tonnage.equals("")?"0":tonnage%>.htm">2009</a>
	  <a <%if(year.equals("2008")){%>class="now"<%}%> href="/pro_2008_0_0_<%=factory.equals("")?"0":factory%>_<%=catalog.equals("")?"0":catalog%>_<%=tonnage.equals("")?"0":tonnage%>.htm">2008</a> </p>
	  <%if(!year.equals("")){%>
      <p> <strong>按月份：
	  </strong>
	  <a <%if(month.equals("")){%>class="now"<%}%>  href="/pro_<%=year.equals("")?"0":year%>_0_0_<%=factory.equals("")?"0":factory%>_<%=catalog.equals("")?"0":catalog%>_<%=tonnage.equals("")?"0":tonnage%>.htm">全年</a>
	  <a <%if(month.equals("1")){%>class="now"<%}%>  href="/pro_<%=year.equals("")?"0":year%>_1_0_<%=factory.equals("")?"0":factory%>_<%=catalog.equals("")?"0":catalog%>_<%=tonnage.equals("")?"0":tonnage%>.htm">1月</a>
	  <a <%if(month.equals("2")){%>class="now"<%}%>  href="/pro_<%=year.equals("")?"0":year%>_2_0_<%=factory.equals("")?"0":factory%>_<%=catalog.equals("")?"0":catalog%>_<%=tonnage.equals("")?"0":tonnage%>.htm">2月</a>
	  <a <%if(month.equals("3")){%>class="now"<%}%>  href="/pro_<%=year.equals("")?"0":year%>_3_0_<%=factory.equals("")?"0":factory%>_<%=catalog.equals("")?"0":catalog%>_<%=tonnage.equals("")?"0":tonnage%>.htm">3月</a>
	  <a <%if(month.equals("4")){%>class="now"<%}%>  href="/pro_<%=year.equals("")?"0":year%>_4_0_<%=factory.equals("")?"0":factory%>_<%=catalog.equals("")?"0":catalog%>_<%=tonnage.equals("")?"0":tonnage%>.htm">4月</a>
	  <a <%if(month.equals("5")){%>class="now"<%}%>  href="/pro_<%=year.equals("")?"0":year%>_5_0_<%=factory.equals("")?"0":factory%>_<%=catalog.equals("")?"0":catalog%>_<%=tonnage.equals("")?"0":tonnage%>.htm">5月</a>
	  <a <%if(month.equals("6")){%>class="now"<%}%>  href="/pro_<%=year.equals("")?"0":year%>_6_0_<%=factory.equals("")?"0":factory%>_<%=catalog.equals("")?"0":catalog%>_<%=tonnage.equals("")?"0":tonnage%>.htm">6月</a>
	  <a <%if(month.equals("7")){%>class="now"<%}%>  href="/pro_<%=year.equals("")?"0":year%>_7_0_<%=factory.equals("")?"0":factory%>_<%=catalog.equals("")?"0":catalog%>_<%=tonnage.equals("")?"0":tonnage%>.htm">7月</a>
	  <a <%if(month.equals("8")){%>class="now"<%}%>  href="/pro_<%=year.equals("")?"0":year%>_8_0_<%=factory.equals("")?"0":factory%>_<%=catalog.equals("")?"0":catalog%>_<%=tonnage.equals("")?"0":tonnage%>.htm">8月</a>
	  <a <%if(month.equals("9")){%>class="now"<%}%>  href="/pro_<%=year.equals("")?"0":year%>_9_0_<%=factory.equals("")?"0":factory%>_<%=catalog.equals("")?"0":catalog%>_<%=tonnage.equals("")?"0":tonnage%>.htm">9月</a>
	  <a <%if(month.equals("10")){%>class="now"<%}%>  href="/pro_<%=year.equals("")?"0":year%>_10_0_<%=factory.equals("")?"0":factory%>_<%=catalog.equals("")?"0":catalog%>_<%=tonnage.equals("")?"0":tonnage%>.htm">10月</a>
	  <a <%if(month.equals("11")){%>class="now"<%}%>  href="/pro_<%=year.equals("")?"0":year%>_11_0_<%=factory.equals("")?"0":factory%>_<%=catalog.equals("")?"0":catalog%>_<%=tonnage.equals("")?"0":tonnage%>.htm">11月</a>
	  <a <%if(month.equals("12")){%>class="now"<%}%>  href="/pro_<%=year.equals("")?"0":year%>_12_0_<%=factory.equals("")?"0":factory%>_<%=catalog.equals("")?"0":catalog%>_<%=tonnage.equals("")?"0":tonnage%>.htm">12月</a></p>
      <%}%>
	  <%if(!year.equals("")){%>
	  <p> <strong>按季度：</strong>
	  <a <%if(season.equals("")){%>class="now"<%}%> href="/pro_<%=year.equals("")?"0":year%>_0_0_<%=factory.equals("")?"0":factory%>_<%=catalog.equals("")?"0":catalog%>_<%=tonnage.equals("")?"0":tonnage%>.htm">全年</a>
	  <a <%if(season.equals("1")){%>class="now"<%}%> href="/pro_<%=year.equals("")?"0":year%>_0_1_<%=factory.equals("")?"0":factory%>_<%=catalog.equals("")?"0":catalog%>_<%=tonnage.equals("")?"0":tonnage%>.htm">一季度</a>
	  <a <%if(season.equals("2")){%>class="now"<%}%> href="/pro_<%=year.equals("")?"0":year%>_0_2_<%=factory.equals("")?"0":factory%>_<%=catalog.equals("")?"0":catalog%>_<%=tonnage.equals("")?"0":tonnage%>.htm">二季度</a>
	  <a <%if(season.equals("3")){%>class="now"<%}%> href="/pro_<%=year.equals("")?"0":year%>_0_3_<%=factory.equals("")?"0":factory%>_<%=catalog.equals("")?"0":catalog%>_<%=tonnage.equals("")?"0":tonnage%>.htm">三季度</a>
	  <a <%if(season.equals("4")){%>class="now"<%}%> href="/pro_<%=year.equals("")?"0":year%>_0_4_<%=factory.equals("")?"0":factory%>_<%=catalog.equals("")?"0":catalog%>_<%=tonnage.equals("")?"0":tonnage%>.htm">四季度</a>
	  </p>
	   <%}%>
	   
	   
	  <%if(catalog.equals("101001")){%>
	  <p> <strong>挖掘机：</strong>
	  <a <%if(tonnage.equals("1")){%>class="now"<%}%> href="/pro_<%=year.equals("")?"0":year%>_<%=month.equals("")?"0":month%>_<%=season.equals("")?"0":season%>_<%=factory.equals("")?"0":factory%>_<%=catalog.equals("")?"0":catalog%>_1.htm">小挖</a>
	  <a <%if(tonnage.equals("2")){%>class="now"<%}%> href="/pro_<%=year.equals("")?"0":year%>_<%=month.equals("")?"0":month%>_<%=season.equals("")?"0":season%>_<%=factory.equals("")?"0":factory%>_<%=catalog.equals("")?"0":catalog%>_2.htm">中挖</a>
	  <a <%if(tonnage.equals("3")){%>class="now"<%}%> href="/pro_<%=year.equals("")?"0":year%>_<%=month.equals("")?"0":month%>_<%=season.equals("")?"0":season%>_<%=factory.equals("")?"0":factory%>_<%=catalog.equals("")?"0":catalog%>_3.htm">大挖</a>
	  </p>
	  <%}%>
	   
	   
   	  <%if(!catalog.equals("")||!year.equals("")||!month.equals("")||!season.equals("")||!factory.equals("")){%>
      <p class="brand_right_sx"><strong>已选条件：</strong> 
	  <%if(!year.equals("")){%><a href="/pro_0_<%=month.equals("")?"0":month%>_<%=season.equals("")?"0":season%>_<%=factory.equals("")?"0":factory%>_<%=catalog.equals("")?"0":catalog%>_<%=tonnage.equals("")?"0":tonnage%>.htm"><%=year%><em></em></a><%}%>
	  <%if(!month.equals("")){%><a href="/pro_<%=year.equals("")?"0":year%>_0_<%=season.equals("")?"0":season%>_<%=factory.equals("")?"0":factory%>_<%=catalog.equals("")?"0":catalog%>_<%=tonnage.equals("")?"0":tonnage%>.htm"><%=month%>月份<em></em></a><%}%>
	  <%if(!season.equals("")){%><a href="/pro_<%=year.equals("")?"0":year%>_<%=month.equals("")?"0":month%>_0_<%=factory.equals("")?"0":factory%>_<%=catalog.equals("")?"0":catalog%>_<%=tonnage.equals("")?"0":tonnage%>.htm"><%=show_season%>季度<em></em></a><%}%>
	  <%if(!factory.equals("")){%><a href="/pro_<%=year.equals("")?"0":year%>_<%=month.equals("")?"0":month%>_<%=season.equals("")?"0":season%>_0_<%=catalog.equals("")?"0":catalog%>_<%=tonnage.equals("")?"0":tonnage%>.htm"><%=CommonString.getFormatPara(brandMap.get(factory))%><em></em></a><%}%>
	  <%if(!catalog.equals("")){%><a href="/pro_<%=year.equals("")?"0":year%>_<%=month.equals("")?"0":month%>_<%=season.equals("")?"0":season%>_<%=factory.equals("")?"0":factory%>_0_<%=tonnage.equals("")?"0":tonnage%>.htm"><%=CommonString.getFormatPara(catalogMap.get(catalog))%><em></em></a><%}%>
      <%if(!tonnage.equals("")){%><a href="/pro_<%=year.equals("")?"0":year%>_<%=month.equals("")?"0":month%>_<%=season.equals("")?"0":season%>_<%=factory.equals("")?"0":factory%>_<%=catalog.equals("")?"0":catalog%>_0.htm">
	  <%if(tonnage.equals("1")){%>小挖<%}%><%if(tonnage.equals("2")){%>中挖<%}%><%if(tonnage.equals("3")){%>大挖<%}%>
	  <em></em></a><%}%>	
	</p>
	<%}%>

    </div>
    <!--border-right: #dddddd 1px solid;height: 84px; -->
    <%
	   if(list != null && list.size() > 0){
	   String cataNum="";
	   String cataName="";
	   int i=1;
	   for(Map m : list){
	   cataNum=CommonString.getFormatPara(m.get("catalognum"));
	   if(cataNum.length()>6){cataNum=cataNum.substring(0,6);}
	   cataName=CommonString.getFormatPara(catalogMap.get(cataNum));
       String intro=CommonHtml.filterHTML(CommonString.getFormatPara(m.get("introduce"))); 
       if(intro.length()>65){intro=intro.substring(0,65)+"...";}  
	   
	%>
	<div class="rl <%if(i<=3){%>top3<%}%>">   
	  <em style="width:45px;"><%=i%></em>
      <div class="img"><a title="<%=CommonString.getFormatPara(m.get("factoryname"))%><%=CommonString.getFormatPara(m.get("name"))%><%=CommonString.getFormatPara(m.get("catalogname"))%>" target="_blank" href="http://product.21-sun.com/proDetail/<%=CommonString.getFormatPara(m.get("file_name"))%>"><img alt="<%=CommonString.getFormatPara(m.get("factoryname"))%><%=CommonString.getFormatPara(m.get("name"))%><%=CommonString.getFormatPara(m.get("catalogname"))%>" width="131" height="84" onerror="showImgDelay(this,'/uploadfiles/no_big.gif',2);" title="<%=CommonString.getFormatPara(m.get("factoryname"))%><%=CommonString.getFormatPara(m.get("name"))%><%=CommonString.getFormatPara(m.get("catalogname"))%>" src="http://product.21-sun.com/uploadfiles/<%=CommonString.getFormatPara(m.get("img2"))%>"></a></div>
      <div class="rlRight">
        <div class="rlt">
          <h2><a title="<%=CommonString.getFormatPara(m.get("factoryname"))%><%=CommonString.getFormatPara(m.get("name"))%><%=CommonString.getFormatPara(m.get("catalogname"))%>" target="_blank" href="http://product.21-sun.com/proDetail/<%=CommonString.getFormatPara(m.get("file_name"))%>"><%=CommonString.getFormatPara(m.get("factoryname"))%><%=CommonString.getFormatPara(m.get("name"))%><%=CommonString.getFormatPara(m.get("catalogname"))%></a></h2>
          <span>关注指数：<%=Integer.parseInt(CommonString.getFormatPara(m.get("allCount")))*13%></span> </div>
        <div class="rli"><%=intro.equals("")?"暂无详细描述<br>":intro%><a title="<%=CommonString.getFormatPara(m.get("factoryname"))%><%=CommonString.getFormatPara(m.get("name"))%><%=CommonString.getFormatPara(m.get("catalogname"))%>" target="_blank" href="http://product.21-sun.com/proDetail/<%=CommonString.getFormatPara(m.get("file_name"))%>"><font color="red"><strong>详细信息</strong></font></a></div>
        <div class="tag"><a title="<%=CommonString.getFormatPara(m.get("factoryname"))%>" target="_blank" href="http://product.21-sun.com/products/prolist.jsp?factory=<%=CommonString.getFormatPara(m.get("factoryid"))%>"><%=CommonString.getFormatPara(m.get("factoryname"))%></a><b>|</b><a target="_blank"  href="http://product.21-sun.com/products/prolist.jsp?factory=<%=CommonString.getFormatPara(m.get("factoryid"))%>&catalog=<%=cataNum%>" title="<%=CommonString.getFormatPara(m.get("factoryname"))%><%=cataName%>"><%=CommonString.getFormatPara(m.get("factoryname"))%><%=cataName%></a></div>
      </div>
    </div>
	<%i++;}}else{

	%>
	      <div align="center" style="padding-top:10px;padding-bottom:10px;"> 暂无相关排行，为您推荐该类别其他品牌排行榜</div>
		  
	   <%
	   	List <Map> listOther = dbHelper.getMapList(sqlOther,connection);

	   if(listOther != null && listOther.size() > 0){
	   String cataNum="";
	   String cataName="";
	   int i=1;
	   for(Map m : listOther){
	   cataNum=CommonString.getFormatPara(m.get("catalognum"));
	   if(cataNum.length()>6){cataNum=cataNum.substring(0,6);}
	   cataName=CommonString.getFormatPara(catalogMap.get(cataNum));
       String intro=CommonHtml.filterHTML(CommonString.getFormatPara(m.get("introduce"))); 
       if(intro.length()>65){intro=intro.substring(0,65)+"...";}  
	   %>
	   
	   	<div class="rl <%if(i<=3){%>top3<%}%>">   
	  <em style="width:45px;"><%=i%></em>
      <div class="img"><a title="<%=CommonString.getFormatPara(m.get("factoryname"))%><%=CommonString.getFormatPara(m.get("name"))%><%=CommonString.getFormatPara(m.get("catalogname"))%>" target="_blank" href="http://product.21-sun.com/proDetail/<%=CommonString.getFormatPara(m.get("file_name"))%>"><img alt="<%=CommonString.getFormatPara(m.get("factoryname"))%><%=CommonString.getFormatPara(m.get("name"))%><%=CommonString.getFormatPara(m.get("catalogname"))%>" width="131" height="84" onerror="showImgDelay(this,'/uploadfiles/no_big.gif',2);" title="<%=CommonString.getFormatPara(m.get("factoryname"))%><%=CommonString.getFormatPara(m.get("name"))%><%=CommonString.getFormatPara(m.get("catalogname"))%>" src="http://product.21-sun.com/uploadfiles/<%=CommonString.getFormatPara(m.get("img2"))%>"></a></div>
      <div class="rlRight">
        <div class="rlt">
          <h2><a title="<%=CommonString.getFormatPara(m.get("factoryname"))%><%=CommonString.getFormatPara(m.get("name"))%><%=CommonString.getFormatPara(m.get("catalogname"))%>" target="_blank" href="http://product.21-sun.com/proDetail/<%=CommonString.getFormatPara(m.get("file_name"))%>"><%=CommonString.getFormatPara(m.get("factoryname"))%><%=CommonString.getFormatPara(m.get("name"))%><%=CommonString.getFormatPara(m.get("catalogname"))%></a></h2>
          <span>关注指数：<%=Integer.parseInt(CommonString.getFormatPara(m.get("allCount")))*13%></span> </div>
        <div class="rli"><%=intro.equals("")?"暂无详细描述<br>":intro%><a title="<%=CommonString.getFormatPara(m.get("factoryname"))%><%=CommonString.getFormatPara(m.get("name"))%><%=CommonString.getFormatPara(m.get("catalogname"))%>" target="_blank" href="http://product.21-sun.com/proDetail/<%=CommonString.getFormatPara(m.get("file_name"))%>"><font color="red"><strong>详细信息</strong></font></a></div>
        <div class="tag"><a target="_blank"  title="<%=CommonString.getFormatPara(m.get("factoryname"))%>" href="http://product.21-sun.com/products/prolist.jsp?factory=<%=CommonString.getFormatPara(m.get("factoryid"))%>"><%=CommonString.getFormatPara(m.get("factoryname"))%></a><b>|</b><a target="_blank"  href="http://product.21-sun.com/products/prolist.jsp?factory=<%=CommonString.getFormatPara(m.get("factoryid"))%>&catalog=<%=cataNum%>" title="<%=CommonString.getFormatPara(m.get("factoryname")).replace("卡特彼勒","卡特")%><%=cataName%>"><%=CommonString.getFormatPara(m.get("factoryname")).replace("卡特彼勒","卡特")%><%=cataName%></a></div>
      </div>
    </div>
	   
	   
    <%i++;}}}%>
  </div>
  <!--right end-->
<div class="clear"></div>
</div>
<!--main end--> 
<!--foot-->
<jsp:include page="/include/foot.jsp" flush="true"/>
<!--end of foot-->
<script type="text/javascript" src="/scripts/sort.js"></script>
<script type="text/javascript">
$('.brand_content_box .brand_content_box_li:last').css('border-bottom-width',0);
</script>
</body>
</html>
<%
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		DBHelper.freeConnection(connection);
	}
%>