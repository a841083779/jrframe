<%@page import="com.jerehnet.util.dbutil.DBHelper"%><%@ page language="java"  pageEncoding="UTF-8"%><%@page import="com.jerehnet.util.common.CommonString"%><%@page import="com.jerehnet.util.dbutil.PageBean"%><%@page import="java.util.List"%><%@page import="java.util.Map"%><%@page import="com.jerehnet.util.common.CommonHtml"%><%@taglib tagdir="/WEB-INF/tags" prefix="tags"%><%@ taglib uri="/WEB-INF/classes/oscache.tld" prefix="cache" %><%
	String referer = CommonString.getFormatPara(request.getHeader("referer")) ;
	String catalognum  = CommonString.getFormatPara(request.getParameter("catalognum")) ; // 类型
	String offset  = "0" ; // 
	String cachekey = catalognum ;
	String catalogName = "";
%>
<cache:cache  cron="* * */5 * *">
<%
	DBHelper dbHelper = DBHelper.getInstance();

	//
	String whereStr = "";
	if(catalognum!=null && !catalognum.equals("")){
		whereStr = " and catalognum  like '"+catalognum+"%'";
		//类型名称
		List<Map> allcatalogsList = dbHelper.getMapList("select name,num from pro_catalog where len(num) = 6");
		if(allcatalogsList!=null && allcatalogsList.size()>0){
			for(Map m:allcatalogsList){
				if(m.get("num").equals(catalognum)){
					catalogName = m.get("name").toString();
				}
			}
		}
	}
	String sql = "select top 20  factoryid,sum(view_count) as sumCount from pro_products where 1=1 "+whereStr+"   group by factoryid  order by sum(view_count) desc";

	List<Map> brandList = dbHelper.getMapList(sql);
	
 %><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>【<%=catalogName %>品牌排名|<%=catalogName %>品牌排行榜】 - 中国工程机械商贸网</title>
<meta name="keywords" content="<%=catalogName %>品牌排名,<%=catalogName %>品牌排行榜" />
<meta name="description" content="<%=catalogName %>品牌排名、<%=catalogName %>品牌排行榜，品牌排名是经过销量、销售额、企业品牌知名度等综合数据进行权威统计。品牌排名涵盖中国、日本、韩国、欧美等世界多个地区品牌。" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="author" content="design by www.21-sun.com" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<link href="../style/style.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="/scripts/jquery-1.7.min.js"></script>
<script type="text/javascript" src="/scripts/scripts.js"></script>
</head>
<body>
<!--top-->
<jsp:include page="/include/top.jsp" flush="true"></jsp:include>
<!--面包屑-->
<div class="contain980 mb10">
  <h3 class="breadCrumbs"><a href="/">铁臂商城</a> &gt;&gt; <a href="/top_list/">排行榜</a> &gt;&gt; <%=catalogName %>品牌排名</h3>
</div>
<!--面包屑结束--> 
<!--main-->
<div class="contain980 mb10">
<%
  if(null!=brandList && brandList.size()>0){
	  int i = Integer.parseInt(offset)+1 ;
	  for(Map brandMap:brandList){
		  String id = CommonString.getFormatPara(brandMap.get("factoryid"));
		  String sumCount = CommonString.getFormatPara(brandMap.get("sumCount"));
		  if(id!=null && !id.equals("")){
			  Map m = dbHelper.getMap("select logo,full_name,usern,introduce,view_count from pro_agent_factory where id="+id);
		  %>
<div class="<%=(i<=3&&("".equals(offset)||"0".equals(offset)))?"rl top3":"rl" %>"> <em><%=i %></em>
  <div class="img jlb"><a href="/brand/<%=CommonString.getFormatPara(m.get("usern")) %>/" target="_blank" title="<%=CommonString.getFormatPara(m.get("full_name")) %>"><img src="/uploadfiles/<%=CommonString.getFormatPara(m.get("logo")) %>" width="131" height="84" alt="<%=CommonString.getFormatPara(m.get("full_name")) %>" title="<%=CommonString.getFormatPara(m.get("full_name")) %>" onerror="showImgDelay(this,'/uploadfiles/no_small.gif',2);" /></a></div>
  <div class="rlRight">
    <div class="rlt">
      <h2><a href="/brand/<%=CommonString.getFormatPara(m.get("usern")) %>/" target="_blank" title="<%=CommonString.getFormatPara(m.get("full_name")) %>"><%=CommonString.getFormatPara(m.get("full_name")) %></a></h2>
      <span>专注指数：<%=sumCount %></span> </div>
    <div class="rli"><%=CommonString.substringByte(CommonHtml.filterHTML(CommonString.getFormatPara(m.get("introduce"))),225)+"..." %><a href="/brand/<%=CommonString.getFormatPara(m.get("usern")) %>/" target="_blank"><strong><font color="red">详细信息</font></strong></a></div>
  </div>
</div>
<%		}
		  i++ ;
	  }
  }
%>

<!--翻页-->
<div class="wfull l">
  <div id="pagination" class="page">
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
<%
 if(referer.indexOf("brand.jsp")!=-1){
	 %>
	    //jQuery('html, body').animate({scrollTop: 215}, 0);
	 <%
 }
%>
</script>
</body>
</cache:cache>
</html>