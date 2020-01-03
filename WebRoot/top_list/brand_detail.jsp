<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<%@page import="com.jerehnet.util.common.CommonString"%>
<%@page import="com.jerehnet.util.common.CommonDate"%>
<%@page import="com.jerehnet.util.dbutil.PageBean"%>
<%@page import="java.sql.Connection,com.jerehnet.webservice.*,com.jerehnet.util.dbutil.*,java.sql.*,java.util.*"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="tags" %>
<%@ taglib uri="/WEB-INF/classes/oscache.tld" prefix="cache"%>
<%  
    //接收参数
    DBHelper dbHelper = DBHelper.getInstance();
    Connection connection = null;
	Map catalogMap = (HashMap)application.getAttribute("catalogMap") ;
    String catalog = CommonString.getFilterStr(request.getParameter("catalog")) ;
	String year = CommonString.getFilterStr(request.getParameter("year")) ;
	String month = CommonString.getFilterStr(request.getParameter("month")) ;
    String season = CommonString.getFilterStr(request.getParameter("season")) ;
	String area = CommonString.getFilterStr(request.getParameter("area")) ;
	String tonnage = CommonString.getFilterStr(request.getParameter("tonnage")) ;
	String show_season="";
	String show_tonandmeter="";
	//参数预处理
	if(catalog.equals("0")){catalog="";}if(year.equals("0")){year="";} if(month.equals("0")){month="";}if(season.equals("0")){season="";}if(area.equals("0")){area="";} if(tonnage.equals("0")){tonnage="";} 	
	int persent=200;
	//查询条件
	String whereStr=" is_deleted=0";
	String factoryType="";
	String proType="";
	String proTypeSql="";
	if(!area.equals("")){factoryType=" and is_inner="+(Integer.parseInt(area)-1);}
	
	//不详细产品属性
	if(tonnage.equals("")){
	if(!catalog.equals("")){whereStr=whereStr+" and catanum like '"+catalog+"%'"; persent=150;}
	if(!year.equals("")){whereStr=whereStr+" and DATEPART(year, add_date)="+year; persent=150;}
	if(!month.equals("")){whereStr=whereStr+" and DATEPART(month, add_date)="+month; persent=10;}
	if(!season.equals("")){
         if(season.equals("1")){show_season="一"; whereStr=whereStr+" and (DATEPART(month, add_date)=1 or DATEPART(month, add_date)=2 or DATEPART(month, add_date)=3)";} 
		 if(season.equals("2")){show_season="二"; whereStr=whereStr+" and (DATEPART(month, add_date)=4 or DATEPART(month, add_date)=5 or DATEPART(month, add_date)=6)";} 
		 if(season.equals("3")){show_season="三"; whereStr=whereStr+" and (DATEPART(month, add_date)=7 or DATEPART(month, add_date)=8 or DATEPART(month, add_date)=9)";}
		 if(season.equals("4")){show_season="四"; whereStr=whereStr+" and (DATEPART(month, add_date)=10 or DATEPART(month, add_date)=11 or DATEPART(month, add_date)=12)";} 
	     persent=40;
	}
	}
	//详细产品属性
	else if(!tonnage.equals("")){
	    persent=10;
	    if(tonnage.equals("1")) proType+=" and b.tonandmeter <=13   and b.tonandmeter >=1"; 
		if(tonnage.equals("2")) proType+=" and b.tonandmeter <30   and b.tonandmeter >=14"; 
		if(tonnage.equals("3")) proType+=" and b.tonandmeter >=30"; 
	    if(!year.equals("")){proType=proType+" and DATEPART(year, a.add_date)="+year; }
	    if(!month.equals("")){proType=proType+" and DATEPART(month, a.add_date)="+month; }
	    if(!season.equals("")){
          if(season.equals("1")){show_season="一"; proType=proType+" and (DATEPART(month, a.add_date)=1 or DATEPART(month, a.add_date)=2 or DATEPART(month, a.add_date)=3)";} 
		  if(season.equals("2")){show_season="二"; proType=proType+" and (DATEPART(month, a.add_date)=4 or DATEPART(month, a.add_date)=5 or DATEPART(month, a.add_date)=6)";} 
		  if(season.equals("3")){show_season="三"; proType=proType+" and (DATEPART(month, a.add_date)=7 or DATEPART(month, a.add_date)=8 or DATEPART(month, a.add_date)=9)";}
		  if(season.equals("4")){show_season="四"; proType=proType+" and (DATEPART(month, a.add_date)=10 or DATEPART(month, a.add_date)=11 or DATEPART(month, a.add_date)=12)";} 
        }
	    if(!catalog.equals("")){proType=proType+" and a.catanum like '"+catalog+"%'";}
		proTypeSql="select b.factoryid,count(b.id) as allCount from pro_product_form a inner join pro_products b on a.product_id = b.id  AND a.is_deleted = 0 "+proType+" group by b.factoryid ";
	}
	
	try{
	String sql="";
  	connection = dbHelper.getConnection();
	if(tonnage.equals("")){
	    sql="SELECT top 10 allCount,factoryid,name,full_name,logo,english_name,usern from (SELECT COUNT(*) AS allCount,factoryid from pro_product_form  WHERE "+whereStr+" GROUP BY factoryid ) as h INNER JOIN ( SELECT name,full_name,logo,id,english_name,usern,view_count  FROM pro_agent_factory WHERE flag=1 "+factoryType+") AS j ON  j.id=h.factoryid ORDER BY (h.allCount) DESC ";   
	}else{
	    sql="SELECT top 10 allCount,factoryid,name,full_name,logo,english_name,usern from ("+proTypeSql+") as h INNER JOIN ( SELECT name,full_name,logo,id,english_name,usern,view_count  FROM pro_agent_factory WHERE flag=1 "+factoryType+") AS j ON  j.id=h.factoryid ORDER BY (h.allCount) DESC ";   
	}
	//查询
	List <Map>list = dbHelper.getMapList(sql,connection);
	//TDK
	String tdk_title="【"+(String)(year.equals("")?"":year+"年")+(String)(month.equals("")?"":month+"月")+(String)(show_season.equals("")?"":show_season+"季度")+(catalog.equals("")?"":CommonString.getFormatPara(catalogMap.get(catalog)))+(area.equals("1")?"国外":"")+(area.equals("2")?"国内":"")+"品牌排行榜】"+(catalog.equals("")?"":CommonString.getFormatPara(catalogMap.get(catalog)))+(area.equals("1")?"国外":"")+(area.equals("2")?"国内":"")+"品牌排名 - 铁臂商城排行榜";
	String tdk_keywords=(String)(year.equals("")?"":year+"年"+(catalog.equals("")?"":CommonString.getFormatPara(catalogMap.get(catalog)))+(area.equals("1")?"国外":"")+(area.equals("2")?"国内":"")+"品牌排行榜,")+(String)(month.equals("")?"":year+"年"+month+"月"+(catalog.equals("")?"":CommonString.getFormatPara(catalogMap.get(catalog)))+(area.equals("1")?"国外":"")+(area.equals("2")?"国内":"")+"品牌排行榜,")+(catalog.equals("")?"":CommonString.getFormatPara(catalogMap.get(catalog))+(area.equals("1")?"国外":"")+(area.equals("2")?"国内":"")+"品牌排行榜,")+(catalog.equals("")?"":CommonString.getFormatPara(catalogMap.get(catalog)))+(area.equals("1")?"国外":"")+(area.equals("2")?"国内":"")+"品牌排名 ";
	String tdk_desc="铁臂商城为您提供最新的"+(String)(year.equals("")?"":year+"年")+(String)(month.equals("")?"":month+"月")+(String)(show_season.equals("")?"":show_season+"季度")+(catalog.equals("")?"":CommonString.getFormatPara(catalogMap.get(catalog)))+(area.equals("1")?"国外":"")+(area.equals("2")?"国内":"")+"品牌排行榜, "+(String)(year.equals("")?"":year+"年")+(String)(month.equals("")?"":month+"月")+(String)(show_season.equals("")?"":show_season+"季度")+(catalog.equals("")?"":CommonString.getFormatPara(catalogMap.get(catalog)))+(area.equals("1")?"国外":"")+(area.equals("2")?"国内":"")+"品牌排名, 帮您实时了解"+(String)(year.equals("")?"":year+"年")+(String)(month.equals("")?"":month+"月")+(String)(show_season.equals("")?"":show_season+"季度")+(catalog.equals("")?"":CommonString.getFormatPara(catalogMap.get(catalog)))+(area.equals("1")?"国外":"")+(area.equals("2")?"国内":"")+"品牌排名变化，买"+(catalog.equals("")?"":CommonString.getFormatPara(catalogMap.get(catalog)))+"就上铁臂商城。";
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

  <div class="brand_crumbss"> 
  <a href="http://top.21-sun.com/" >排行榜首页</a>
  <a class="now" href="/brand_list.jsp">品牌排行榜</a> 
  <a href="/pro_list.jsp" >产品排行榜</a> 
  <a href="/pro_0_0_0_0_101001_0.htm">挖掘机排行榜</a>
  <a href="/pro_0_0_0_0_101002_0.htm">装载机排行榜</a>
  </div>

  <!--left-->
  <div class="w210 l np_left newLeft">
      <jsp:include page="/include/rank/left_catalog.jsp" flush="false"></jsp:include>   
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
      <h1><strong><%=year.equals("")?"":year+"年"%><%=month.equals("")?"":month+"月份"%><%=season.equals("")?"":show_season+"季度"%><%=catalog.equals("")?"工程机械":CommonString.getFormatPara(catalogMap.get(catalog))%>品牌排行榜</strong></h1> 
      <div style="position:absolute;top:6px;right:8px;"><a target="_blank" href="/blist_<%=year.equals("")?"0":year%>_<%=month.equals("")?"0":month%>_<%=season.equals("")?"0":season%>_<%=catalog.equals("")?"0":catalog%>_<%=area.equals("")?"0":area%>_1.htm" title="更多<%=year.equals("")?"":year+"年"%><%=month.equals("")?"":month+"月份"%><%=season.equals("")?"":show_season+"季度"%><%=catalog.equals("")?"工程机械":CommonString.getFormatPara(catalogMap.get(catalog))%>品牌排行榜">更多</a></div>     
	  </div>
	  <p><strong>按年份：</strong>
	  <a <%if(year.equals("")){%>class="now"<%}%> href="/brand_0_0_0_<%=catalog.equals("")?"0":catalog%>_<%=area.equals("")?"0":area%>.htm">总榜</a>
	  <a <%if(year.equals("2014")){%>class="now"<%}%> href="/brand_2014_0_0_<%=catalog.equals("")?"0":catalog%>_<%=area.equals("")?"0":area%>.htm">2014</a>
	  <a <%if(year.equals("2013")){%>class="now"<%}%> href="/brand_2013_0_0_<%=catalog.equals("")?"0":catalog%>_<%=area.equals("")?"0":area%>.htm">2013</a>
	  <a <%if(year.equals("2012")){%>class="now"<%}%> href="/brand_2012_0_0_<%=catalog.equals("")?"0":catalog%>_<%=area.equals("")?"0":area%>.htm">2012</a>
	  <a <%if(year.equals("2011")){%>class="now"<%}%> href="/brand_2011_0_0_<%=catalog.equals("")?"0":catalog%>_<%=area.equals("")?"0":area%>.htm">2011</a>
	  <a <%if(year.equals("2010")){%>class="now"<%}%> href="/brand_2010_0_0_<%=catalog.equals("")?"0":catalog%>_<%=area.equals("")?"0":area%>.htm">2010</a>
	  <a <%if(year.equals("2009")){%>class="now"<%}%> href="/brand_2009_0_0_<%=catalog.equals("")?"0":catalog%>_<%=area.equals("")?"0":area%>.htm">2009</a>
	  <a <%if(year.equals("2008")){%>class="now"<%}%> href="/brand_2008_0_0_<%=catalog.equals("")?"0":catalog%>_<%=area.equals("")?"0":area%>.htm">2008</a> </p>
	  <%if(!year.equals("")){%>
      <p> <strong>按月份：
	  </strong>
	  <a <%if(month.equals("")){%>class="now"<%}%>  href="/brand_<%=year.equals("")?"0":year%>_0_0_<%=catalog.equals("")?"0":catalog%>_<%=area.equals("")?"0":area%>.htm">全年</a>
	  <a <%if(month.equals("1")){%>class="now"<%}%>  href="/brand_<%=year.equals("")?"0":year%>_1_0_<%=catalog.equals("")?"0":catalog%>_<%=area.equals("")?"0":area%>.htm">1月</a>
	  <a <%if(month.equals("2")){%>class="now"<%}%>  href="/brand_<%=year.equals("")?"0":year%>_2_0_<%=catalog.equals("")?"0":catalog%>_<%=area.equals("")?"0":area%>.htm">2月</a>
	  <a <%if(month.equals("3")){%>class="now"<%}%>  href="/brand_<%=year.equals("")?"0":year%>_3_0_<%=catalog.equals("")?"0":catalog%>_<%=area.equals("")?"0":area%>.htm">3月</a>
	  <a <%if(month.equals("4")){%>class="now"<%}%>  href="/brand_<%=year.equals("")?"0":year%>_4_0_<%=catalog.equals("")?"0":catalog%>_<%=area.equals("")?"0":area%>.htm">4月</a>
	  <a <%if(month.equals("5")){%>class="now"<%}%>  href="/brand_<%=year.equals("")?"0":year%>_5_0_<%=catalog.equals("")?"0":catalog%>_<%=area.equals("")?"0":area%>.htm">5月</a>
	  <a <%if(month.equals("6")){%>class="now"<%}%>  href="/brand_<%=year.equals("")?"0":year%>_6_0_<%=catalog.equals("")?"0":catalog%>_<%=area.equals("")?"0":area%>.htm">6月</a>
	  <a <%if(month.equals("7")){%>class="now"<%}%>  href="/brand_<%=year.equals("")?"0":year%>_7_0_<%=catalog.equals("")?"0":catalog%>_<%=area.equals("")?"0":area%>.htm">7月</a>
	  <a <%if(month.equals("8")){%>class="now"<%}%>  href="/brand_<%=year.equals("")?"0":year%>_8_0_<%=catalog.equals("")?"0":catalog%>_<%=area.equals("")?"0":area%>.htm">8月</a>
	  <a <%if(month.equals("9")){%>class="now"<%}%>  href="/brand_<%=year.equals("")?"0":year%>_9_0_<%=catalog.equals("")?"0":catalog%>_<%=area.equals("")?"0":area%>.htm">9月</a>
	  <a <%if(month.equals("10")){%>class="now"<%}%>  href="/brand_<%=year.equals("")?"0":year%>_10_0_<%=catalog.equals("")?"0":catalog%>_<%=area.equals("")?"0":area%>.htm">10月</a>
	  <a <%if(month.equals("11")){%>class="now"<%}%>  href="/brand_<%=year.equals("")?"0":year%>_11_0_<%=catalog.equals("")?"0":catalog%>_<%=area.equals("")?"0":area%>.htm">11月</a>
	  <a <%if(month.equals("12")){%>class="now"<%}%>  href="/brand_<%=year.equals("")?"0":year%>_12_0_<%=catalog.equals("")?"0":catalog%>_<%=area.equals("")?"0":area%>.htm">12月</a></p>
      <%}%>
	  <%if(!year.equals("")){%>
	  <p> <strong>按季度：</strong>
	  <a <%if(season.equals("")){%>class="now"<%}%> href="/brand_<%=year.equals("")?"0":year%>_0_0_<%=catalog.equals("")?"0":catalog%>_<%=area.equals("")?"0":area%>.htm">全年</a>
	  <a <%if(season.equals("1")){%>class="now"<%}%> href="/brand_<%=year.equals("")?"0":year%>_0_1_<%=catalog.equals("")?"0":catalog%>_<%=area.equals("")?"0":area%>.htm">一季度</a>
	  <a <%if(season.equals("2")){%>class="now"<%}%> href="/brand_<%=year.equals("")?"0":year%>_0_2_<%=catalog.equals("")?"0":catalog%>_<%=area.equals("")?"0":area%>.htm">二季度</a>
	  <a <%if(season.equals("3")){%>class="now"<%}%> href="/brand_<%=year.equals("")?"0":year%>_0_3_<%=catalog.equals("")?"0":catalog%>_<%=area.equals("")?"0":area%>.htm">三季度</a>
	  <a <%if(season.equals("4")){%>class="now"<%}%> href="/brand_<%=year.equals("")?"0":year%>_0_4_<%=catalog.equals("")?"0":catalog%>_<%=area.equals("")?"0":area%>.htm">四季度</a>
	  </p>
      <%}%>
	  <p><strong>按国家：</strong>
	  <a <%if(area.equals("2")){%>class="now"<%}%> href="/brand_<%=year.equals("")?"0":year%>_<%=month.equals("")?"0":month%>_<%=season.equals("")?"0":season%>_<%=catalog.equals("")?"0":catalog%>_2.htm">国内</a>
	  <a <%if(area.equals("1")){%>class="now"<%}%> href="/brand_<%=year.equals("")?"0":year%>_<%=month.equals("")?"0":month%>_<%=season.equals("")?"0":season%>_<%=catalog.equals("")?"0":catalog%>_1.htm">国外</a>
	  </p>

	  
	  <%if(!catalog.equals("")||!year.equals("")||!month.equals("")||!season.equals("")){%>
      <p class="brand_right_sx"><strong>已选条件：</strong> 
	  <%if(!year.equals("")){%><a href="/brand_0_<%=month.equals("")?"0":month%>_<%=season.equals("")?"0":season%>_<%=catalog.equals("")?"0":catalog%>_<%=area.equals("")?"0":area%>.htm"><%=year%><em></em></a><%}%>
	  <%if(!month.equals("")){%><a href="/brand_<%=year.equals("")?"0":year%>_0_<%=season.equals("")?"0":season%>_<%=catalog.equals("")?"0":catalog%>_<%=area.equals("")?"0":area%>.htm"><%=month%>月份<em></em></a><%}%>
	  <%if(!season.equals("")){%><a href="/brand_<%=year.equals("")?"0":year%>_<%=month.equals("")?"0":month%>_0_<%=catalog.equals("")?"0":catalog%>_<%=area.equals("")?"0":area%>.htm"><%=show_season%>季度<em></em></a><%}%>
	  <%if(!catalog.equals("")){%><a href="/brand_<%=year.equals("")?"0":year%>_<%=month.equals("")?"0":month%>_<%=season.equals("")?"0":season%>_0_<%=area.equals("")?"0":area%>.htm"><%=CommonString.getFormatPara(catalogMap.get(catalog))%><em></em></a></p><%}%>
	  <%if(!area.equals("")){%><a href="/brand_<%=year.equals("")?"0":year%>_<%=month.equals("")?"0":month%>_<%=season.equals("")?"0":season%>_<%=catalog.equals("")?"0":catalog%>_0.htm"><%=area.equals("1")?"国外":"国内"%><em></em></a><%}%>	 
	 <%}%>
    </div>
    
    <div class="brand_content_box">
      <div class="brand_content_box_li brand_content_box_head">
        <div class="brand_content_l1">排名</div>
        <div class="brand_content_l2">LOGO</div>
        <div class="brand_content_l3">品牌</div>
        <div class="brand_content_l4">全称</div>
        <div class="brand_content_l5">品牌指数</div>
      </div>
      <%
	   if(list != null && list.size() > 0){
	            int i=1;String no="";
				for(Map m : list){	
				          if(!CommonString.getFormatPara(m.get("allCount")).equals("")){
                 if(i<=9){no="0"+i;}else{no="10";}				
      %>
      <div class="brand_content_box_li brand_content_box_body">
        <div class="brand_content_l1"><strong class="top"><%=no%></strong></div>
        <div class="brand_content_l2"><a title="<%=CommonString.getFormatPara(m.get("name"))%>" target="_blank" style="line-height:0px;" href="http://product.21-sun.com/brand/<%=CommonString.getFormatPara(m.get("usern"))%>/"><img  onerror="showImgDelay(this,'/uploadfiles/no_big.gif',2);" title="<%=CommonString.getFormatPara(m.get("name"))%>" alt="<%=CommonString.getFormatPara(m.get("name"))%>" width="70" src="http://product.21-sun.com/uploadfiles/<%=CommonString.getFormatPara(m.get("logo"))%>"></a></div>
        <div style="overflow:hidden;" class="brand_content_l3">
          <div style="height:35px;line-height:50px;"><a title="<%=CommonString.getFormatPara(m.get("name"))%>" href="http://product.21-sun.com/brand/<%=CommonString.getFormatPara(m.get("usern"))%>/" target="_blank"><%=CommonString.getFormatPara(m.get("name"))%></a></div>
          <div style="height:35px;line-height:20px;"><a title="<%=CommonString.getFormatPara(m.get("english_name"))%>" href="http://product.21-sun.com/brand/<%=CommonString.getFormatPara(m.get("usern"))%>/" target="_blank"><%=CommonString.getFormatPara(m.get("english_name"))%></a></div>
        </div>
        <div style="overflow:hidden;" class="brand_content_l4"><a title="<%=CommonString.getFormatPara(m.get("full_name"))%>" href="http://product.21-sun.com/brand/<%=CommonString.getFormatPara(m.get("usern"))%>/" target="_blank"><%=CommonString.getFormatPara(m.get("full_name"))%></a></div>
        <div class="brand_content_l5">
          <p><span style="width:<%=Integer.parseInt(CommonString.getFormatPara(m.get("allCount")))/persent%>%"></span></p>
          <div><%=Integer.parseInt(CommonString.getFormatPara(m.get("allCount")))*9%></div>
        </div>
      </div>
      <%i++;}}}else{%>
      <div align="center" style="padding-top:10px;padding-bottom:10px;"> 暂无相关排行</div>
      <%}%>
    </div>
    

    
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