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
		String whereStr="";
		if(!factoryid.equals("0")&&!factoryid.equals(""))
         {
			whereStr=(" and factoryid =" + factoryid + "");
	     }	
	    String sql = "select top 8 * from pro_mobile_koubei_list where  catalognum like '"+catalognum+"%' "+whereStr+"order by id desc";
		List<Map> koubeiList = dbHelper.getMapList(sql);
	    List<Map> brandList = dbHelper.getMapList("select top 15 id,name from pro_agent_factory where is_show=1 and flag=1 and id in (select distinct factoryid from pro_products where is_show=1 and catalognum like '"+catalognum+"%' ) order by view_count desc") ;
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%if(factoryid.equals("")||factoryid.equals("0")){%>
<title><%=catalogname %>口碑_<%=catalogname %>哪个品牌好 – 铁臂<%=catalogname %>专区</title>
<meta name="keywords" content="<%=catalogname %>口碑,<%=catalogname %>哪个品牌好" />
<meta name="description" content="铁臂<%=catalogname %>专区,为您提供大量来自真实用户的<%=catalogname %>口碑,帮助您全面了解<%=catalogname %>哪个品牌好,买<%=catalogname %>产品就上铁臂商城。" />
<%}else{%>
<title><%=CommonString.getFormatPara(brandMap.get(factoryid))%><%=catalogname %>口碑_<%=CommonString.getFormatPara(brandMap.get(factoryid))%><%=catalogname %>怎么样 – 铁臂<%=catalogname %>专区</title>
<meta name="keywords" content="<%=CommonString.getFormatPara(brandMap.get(factoryid))%><%=catalogname %>口碑,<%=CommonString.getFormatPara(brandMap.get(factoryid))%><%=catalogname %>怎么样" />
<meta name="description" content="铁臂<%=catalogname %>专区,为您提供大量来自真实用户的<%=CommonString.getFormatPara(brandMap.get(factoryid))%><%=catalogname %>口碑,帮助您全面了<%=CommonString.getFormatPara(brandMap.get(factoryid))%><%=catalogname %>怎么样,买<%=CommonString.getFormatPara(brandMap.get(factoryid))%><%=catalogname %>产品就上铁臂商城。" />
<%}%>
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
      <li><a href="http://<%=usernn%>.21-sun.com/"><%=catalogname%>首页</a></li>
      <li><a href="http://<%=usernn%>.21-sun.com/news.htm"><%=catalogname%>动态</a></li>
      <li  class="selected"><a href="http://<%=usernn%>.21-sun.com/koubei.htm"><%=catalogname%>口碑</a></li>
      <li><a href="http://<%=usernn%>.21-sun.com/pic.htm"><%=catalogname%>图片</a></li>
      <li><a href="http://<%=usernn%>.21-sun.com/pro.htm"><%=catalogname%>品牌</a></li>
      <li><a href="http://product.21-sun.com/inquiry/0_0_0_<%=catalognum%>_0.shtm" target="_blank"><%=catalogname%>询价单</a></li>
    </ul>
  </div>
</div>
<div class="contain980 mb10 mt10">
<%if(factoryid.equals("")||factoryid.equals("0")){%>
  <div class="breadCrumbs"><a href="/">铁臂<%=catalogname%>专区</a> &gt;&gt; <%=catalogname%>口碑</div>
<%}else{%>
  <div class="breadCrumbs"><a href="/">铁臂<%=catalogname%>专区</a> &gt;&gt; <%=catalogname%>口碑 &gt;&gt; <%=CommonString.getFormatPara(brandMap.get(factoryid))%><%=catalogname %>口碑</div>
<%}%> 
</div>
<!--main-->
<div class="contain980 fix">
	<div class="s_mleft">
        <div class="comBox">
            <div class="cg mb10 cp_brandmore"> 
              <strong>品牌：</strong>
			  <%	  
				if (brandList != null && brandList.size() > 0) {
						for (Map oneMap : brandList) {
			  %>
			  <a href="/koubei_<%=CommonString.getFormatPara(oneMap.get("id"))%>.htm" title="<%=CommonString.getFormatPara(oneMap.get("name"))%>"><%=CommonString.getFormatPara(oneMap.get("name"))%></a><em>|</em>
              <%}}%>
              <a  href="javascript:void(0)"  class="cp_bmore">更多</a>
            </div>
         </div>
         <script type="text/javascript">
		 $('.cp_bmore').click(function(){
		 	if($(this).hasClass('act')){
				$(this).removeClass('act');
				$(this).parent('.cp_brandmore').removeAttr('style');
			}else{
				$(this).addClass('act');
				$(this).parent('.cp_brandmore').css('height','auto');
			}
		 })
		 </script>
        <div class="s_kb pc_koubeimt" style="margin-top:5px;">
            <div class="s_hd fix">
              <span class="more"><a href="http://koubei.21-sun.com/" target="_blank">发布口碑 &gt;&gt;</a></span>
            </div>
            <div class="s_bd fix">
              <div class="s_kb_list">
                <ul class="fix">
				
				<%
				   Map user=null; String touxiang="http://product.21-sun.com/catalog/images/s_face.png";
				   if(koubeiList!=null && koubeiList.size()>0){
				      String content="";
				      for(Map oneMap:koubeiList){
					   content=CommonString.getFormatPara(oneMap.get("content"));
					   if(content.length()>200){content=content.substring(0,200)+"...";}
					   if(!CommonString.getFormatPara(oneMap.get("username")).equals("")){
					      user=dbHelper.getMap("select image from pro_member where username='"+CommonString.getFormatPara(oneMap.get("username"))+"'");
					   }
					   if(user!=null){
					      if(!CommonString.getFormatPara(user.get("image")).equals("")){
					         touxiang=CommonString.getFormatPara(user.get("image"));
					      }else{
					         touxiang="http://product.21-sun.com/catalog/images/s_face.png";
					      }
					   }else{
	                     touxiang="http://product.21-sun.com/catalog/images/s_face.png";
					   }
				%>
                  <li>
                    <div class="user"><img  src="<%=touxiang%>"/><%=CommonString.getFormatPara(oneMap.get("username")).equals("")?"游客":CommonString.getFormatPara(oneMap.get("username"))%></div>
                    <div class="intro">
                      <a title="查看完整口碑" href="http://koubei.21-sun.com/detail/<%=CommonString.getFormatPara(oneMap.get("id"))%>.htm" target="_blank">
                      <strong class="n"><%=CommonString.getFormatPara(oneMap.get("factoryname"))%><%=CommonString.getFormatPara(oneMap.get("name1"))%><%=CommonString.getFormatPara(oneMap.get("catalogname"))%>使用感受</strong>
                      <span class="time"><%=CommonDate.getFormatDate("yyyy-MM-dd",CommonString.getFormatPara(oneMap.get("add_date")))%></span>
                      <div class="text"><%=content%></div>
                      <span class="more">查看完整口碑 &gt;&gt;</span>
                      </a>
                    </div>
                  </li>
                <%}}else{%>
				   <div align="center" style="font-size:16px;"><strong>暂无相关口碑，给您推荐其他<%=CommonString.getFormatPara(brandMap.get(factoryid))%>口碑!</strong></div>
				<%
				     koubeiList = dbHelper.getMapList("select top 8 * from pro_mobile_koubei_list  where 1=1  "+whereStr+"order by id desc");
					 if(koubeiList!=null && koubeiList.size()>0){
				      String content1="";
				      for(Map oneMap:koubeiList){
					   content1=CommonString.getFormatPara(oneMap.get("content"));
					   if(content1.length()>200){content1=content1.substring(0,200)+"...";}
					   if(!CommonString.getFormatPara(oneMap.get("username")).equals("")){
					      user=dbHelper.getMap("select image from pro_member where username='"+CommonString.getFormatPara(oneMap.get("username"))+"'");
					   }
					   if(user!=null){
					      if(!CommonString.getFormatPara(user.get("image")).equals("")){
					         touxiang=CommonString.getFormatPara(user.get("image"));
					      }else{
					         touxiang="http://product.21-sun.com/catalog/images/s_face.png";
					      }
					   }else{
	                     touxiang="http://product.21-sun.com/catalog/images/s_face.png";
					   }
				%>
				    <li>
                    <div class="user"><img  src="<%=touxiang%>"/><%=CommonString.getFormatPara(oneMap.get("username")).equals("")?"游客":CommonString.getFormatPara(oneMap.get("username"))%></div>
                    <div class="intro">
                      <a title="查看完整口碑" href="http://koubei.21-sun.com/detail/<%=CommonString.getFormatPara(oneMap.get("id"))%>.htm" target="_blank">
                      <strong class="n"><%=CommonString.getFormatPara(oneMap.get("factoryname"))%><%=CommonString.getFormatPara(oneMap.get("name1"))%><%=CommonString.getFormatPara(oneMap.get("catalogname"))%>使用感受</strong>
                      <span class="time"><%=CommonDate.getFormatDate("yyyy-MM-dd",CommonString.getFormatPara(oneMap.get("add_date")))%></span>
                      <div class="text"><%=content1%></div>
                      <span class="more">查看完整口碑 &gt;&gt;</span>
                      </a>
                    </div>
                  </li>
				<%}}}%>
                </ul>
                <div class="s_more"><a title="查看更多" target="_blank" href="http://koubei.21-sun.com/comment-<%=catalognum%>-<%=factoryid.equals("")?"0":factoryid%>-0-0-0.htm">查看更多口碑</a></div>
              </div>
            </div>
          </div>
    </div>
    <div class="s_right">
	<!--热门产品评论-->
	<jsp:include page="/include/catalogshow/hot_product_comment.jsp" flush="true">
      <jsp:param name="catalogname" value='<%=catalogname%>'></jsp:param>
      <jsp:param name="catalognum" value='<%=catalognum%>'></jsp:param>
    </jsp:include>
	<!--代理商-->
	<jsp:include page="/include/catalogshow/agent_list.jsp" flush="true">
      <jsp:param name="catalogname" value='<%=catalogname%>'></jsp:param>
      <jsp:param name="catalognum" value='<%=catalognum%>'></jsp:param>
    </jsp:include>	
	<!--热门产品图片-->
	<jsp:include page="/include/catalogshow/product_pic.jsp" flush="true">
      <jsp:param name="catalogname" value='<%=catalogname%>'></jsp:param>
      <jsp:param name="catalognum" value='<%=catalognum%>'></jsp:param>
    </jsp:include>		
    </div>
</div>
<!--main end-->
<!--foot-->
<jsp:include page="/include/foot.jsp" flush="true"/>
<!--foot end-->
</body>
<script type="text/javascript" src="/scripts/scripts.js"></script>
</html>
<%
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		dbHelper.freeConnection(connection);
	}
%>