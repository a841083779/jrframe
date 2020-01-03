<%@page import="org.apache.solr.common.SolrDocumentList"%>
<%@page import="org.apache.solr.common.SolrDocument"%>
<%@page import="org.apache.solr.client.solrj.response.QueryResponse"%>
<%@page import="org.apache.solr.client.solrj.SolrQuery"%>
<%@page import="org.apache.solr.client.solrj.impl.HttpSolrServer"%>
<%@ page language="java" import="java.sql.Connection,java.util.*,com.jerehnet.util.common.*,com.jerehnet.webservice.*" pageEncoding="UTF-8"%><%@page import="com.jerehnet.util.dbutil.DBHelper"%><%@ taglib uri="/WEB-INF/classes/oscache.tld" prefix="cache"%><%
    String usernn = CommonString.getFormatPara(request.getParameter("usern"));
	String factoryid = CommonString.getFormatPara(request.getParameter("factoryid")) ;
	Map brandMap = (HashMap)application.getAttribute("brandMap") ;
	String cacheKey = "brand_agent_"+factoryid;
	DBHelper dbHelper = DBHelper.getInstance() ;
	Connection connection = null;
	try{
		connection = dbHelper.getConnection();
		Map map = dbHelper.getMap(" select * from pro_products_second where english_name = ? ",new Object []{usernn},connection);
		if(map == null){
			Common.do302(response,"http://product.21-sun.com/");
			return;
		}
		String catalognum=CommonString.getFormatPara(map.get("catalognum"));
		String catalogname=CommonString.getFormatPara(map.get("catalogname"));
	    String sql = "select top 2 id,name,full_name,agent_fac,agent_fac_name,telphone,fax,address,city,usern from pro_agent_factory where flag = 2 and is_show = 1  and id in ( select distinct agent_id from pro_agent_products where catalognum like '"+catalognum+"%') order by is_cooperate desc ,id desc";
	
%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><%=catalogname%>_<%=catalogname%>品牌排行榜_<%=catalogname%>价格表 – 铁臂<%=catalogname%>专区</title>
<meta name="keywords" content="<%=catalogname%>,<%=catalogname%>价格表,<%=catalogname%>品牌排行榜,<%=catalogname%>参数,<%=catalogname%>型号" />
<meta name="description" content="铁臂<%=catalogname%>专区,为您提供<%=catalogname%>型号,<%=catalogname%>价格,<%=catalogname%>品牌排行榜,<%=catalogname%>参数,<%=catalogname%>口碑,<%=catalogname%>图片等详细信息,让您更好的了解<%=catalogname%>,买<%=catalogname%>产品就上铁臂商城。" />
<link href="/style/style.css" rel="stylesheet" type="text/css" />
<link href="/brandshow/style/brands.css" rel="stylesheet" type="text/css" />
<link href="/catalog/style/products.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="/scripts/jquery.min.js"></script>
</head>
<body>
<!--top-->
<jsp:include page="/include/top.jsp" flush="true"/>
<!--top end-->
<div class="contain980 fix">
  <div class="nc_channT"><h1 style="font-size:24px;"><%=catalogname %></h1></div>
  <div class="s_mainSite"><a target="_blank" href="http://product.21-sun.com/">访问首页</a></div>
  <div class="s_tel">铁臂商城客服电话：<b>4006-521-526</b></div>
</div>
<div class="s_navBar">
  <div class="contain980">
    <ul class="fix">
      <li class="selected"><a href="http://<%=usernn%>.21-sun.com/"><%=catalogname%>首页</a></li>
      <li><a href="http://<%=usernn%>.21-sun.com/news.htm"><%=catalogname%>动态</a></li>
      <li><a href="http://<%=usernn%>.21-sun.com/koubei.htm"><%=catalogname%>口碑</a></li>
      <li><a href="http://<%=usernn%>.21-sun.com/pic.htm"><%=catalogname%>图片</a></li>
      <li><a href="http://<%=usernn%>.21-sun.com/pro.htm"><%=catalogname%>品牌</a></li>
      <li><a href="http://product.21-sun.com/inquiry/0_0_0_<%=catalognum%>_0.shtm" target="_blank"><%=catalogname%>询价单</a></li>
    </ul>
  </div>
</div>
<!--main-->
<div class="contain980 fix pt15 mb10">
    <!--顶部新闻-->
    <jsp:include page="/include/catalogshow/top_news.jsp" flush="true">
      <jsp:param name="catalogname" value='<%=catalogname%>'></jsp:param>
      <jsp:param name="catalognum" value='<%=catalognum%>'></jsp:param>
    </jsp:include>
	<!--品牌排行-->
	<jsp:include page="/include/catalogshow/brand_rank.jsp" flush="true">
      <jsp:param name="catalogname" value='<%=catalogname%>'></jsp:param>
      <jsp:param name="catalognum" value='<%=catalognum%>'></jsp:param>
    </jsp:include>
</div>
<div class="contain980 fix mb10">
    <!--推荐产品-->
	<jsp:include page="/include/catalogshow/product_rec.jsp" flush="true">
      <jsp:param name="catalogname" value='<%=catalogname%>'></jsp:param>
      <jsp:param name="catalognum" value='<%=catalognum%>'></jsp:param>
    </jsp:include>
    <!--产品评论-->
	<jsp:include page="/include/catalogshow/product_comment.jsp" flush="true">
      <jsp:param name="catalogname" value='<%=catalogname%>'></jsp:param>
      <jsp:param name="catalognum" value='<%=catalognum%>'></jsp:param>
    </jsp:include>
</div>
<div class="contain980 fix mb10">
  <div class="p_2_1">
    <div class="hd">
      <h3><%=catalogname%>代理商</h3>
      <span class="more"><a target="_blank" title="更多<%=catalogname%>代理商" href="http://dealer.21-sun.com/0_0_0_<%=catalognum%>_0.shtm">更多 &gt;&gt;</a></span>
    </div>
    <div class="bd fix s_company">
      <ul class="fix">
      <%
		List<Map> prosList = dbHelper.getMapList(sql);
		if(prosList!=null && prosList.size()>0){
			for(Map pro:prosList){
				String usern = CommonString.getFormatPara(pro.get("usern"));
				String full_name = CommonString.getFormatPara(pro.get("full_name"));
				String name = CommonString.getFormatPara(pro.get("name"));
				String agent_fac_name = CommonString.getFormatPara(pro.get("agent_fac_name"));
				String city = CommonString.getFormatPara(pro.get("city"));
				if(city.length()>20){city=city.substring(0,20)+"...";}
				String telphone = CommonString.getFormatPara(pro.get("telphone"));
				String fax = CommonString.getFormatPara(pro.get("fax"));
				String address = CommonString.getFormatPara(pro.get("address"));
	%>
        <li>
              <a class="n" href="http://dealer.21-sun.com/<%=usern %>/" title="<%=full_name %>" target="_blank"><%=full_name %></a>
              <span class="area"><%=city %></span>
              <div class="text">
                代理品牌：<%=agent_fac_name %><br />
                电话：<%=telphone %><br />
                传真：<%=fax %><br />
                地址：<%=address %>
              </div>
              <a href="http://dealer.21-sun.com/<%=usern %>/" target="_blank" class="btn">进入店铺</a>
            </li>
       <%}} %>
      </ul>
    </div>
  </div>
   <!--询价-->
	<jsp:include page="/include/catalogshow/product_inquiry.jsp" flush="true">
      <jsp:param name="catalogname" value='<%=catalogname%>'></jsp:param>
      <jsp:param name="catalognum" value='<%=catalognum%>'></jsp:param>
    </jsp:include>
</div>
<!--main end-->
<!--foot-->
<jsp:include page="/include/foot.jsp" flush="true"/>
<!--foot end-->
</body>
<script type="text/javascript" src="/scripts/scripts.js"></script>
<script type="text/javascript" src="scripts/superslide.js"></script>
<script type="text/javascript">
$(".p_slide").slide({ titCell:".hd ul", mainCell:".bd ul",effect:"fold",vis:1,scroll:1,autoPlay:true,autoPage:true,interTime:4000});
//$('.p_newsList li:eq(3)').css('margin-bottom',10);
</script>
</html>
<%
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		dbHelper.freeConnection(connection);
	}
%>