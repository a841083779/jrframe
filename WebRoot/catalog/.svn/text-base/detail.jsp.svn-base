<%@ page language="java" import="org.json.*,java.net.*,java.sql.Connection,java.util.*,com.jerehnet.util.dbutil.*,com.jerehnet.util.common.*,com.jerehnet.webservice.*" pageEncoding="UTF-8"%><%
	String usernn = CommonString.getFormatPara(request.getParameter("usern"));
	String id = CommonString.getFormatPara(request.getParameter("id")) ;  // 新闻 id 
	String t_flag = CommonString.getFilterStr(request.getParameter("t_flag")) ;
	String tableName = "article" ;
	String whereStr = " where id="+id+" and is_pub=1" ;
	String sel_sql = " select * from "+tableName+whereStr ;
	if("service".equals(t_flag)){
		tableName = "article_other" ;
		sel_sql = " select * from "+tableName+whereStr ;
	}else if("product".equals(t_flag)){
		sel_sql = " select * from pro_agent_news where id = "+id;
	}else if("pro_case_news".equals(t_flag)){
		sel_sql = " select * from pro_case_news where id = "+id;
	}
	Map oneNews = null ;
	DBHelper dbHelper = DBHelper.getInstance() ;
	Connection conn_21sun = null;
	Connection connection = null;
	// 获得地区
	String ip  = Common.getIp(request);
	String jsonStr = Tools.getMyProvinceAndCity(ip);
	String city = "";
	String province = "";
	if(!CommonString.getFormatPara(jsonStr).equals("")){
		JSONObject obj = new JSONObject(jsonStr);
		if(null!=obj&&obj.length()>0){
			province = CommonString.getFormatPara(obj.getString("province"));
			city = CommonString.getFormatPara(obj.getString("city"));
		}
	}
	try{ 
	   	connection = dbHelper.getConnection();
		Map map = dbHelper.getMap(" select * from pro_products_second where english_name = ? ",new Object []{usernn},connection);
		if(map == null){
			Common.do302(response,"http://product.21-sun.com/");
			return;
	    }
	    String catalognum=CommonString.getFormatPara(map.get("catalognum"));
	    String catalogname=CommonString.getFormatPara(map.get("catalogname"));
        conn_21sun = dbHelper.getConnection();
		if(t_flag.equals("product")||t_flag.equals("pro_case_news")){
		oneNews = dbHelper.getMap(sel_sql);
		}else{
		oneNews = WEBDBHelper.getMap(sel_sql,"Web21sunDBHelper");
		}
		if(null==oneNews){
			response.sendRedirect("/news/") ;
		}
		Map productMap = null;
		String product_id = ""; // 新闻关联产品
		if("product".equals(t_flag)){
			String sql = " SELECT TOP 1 product_id FROM pro_agent_news_acl_products where agent_news_id = "+CommonString.getFormatPara(oneNews.get("id"));
			product_id = CommonString.getFormatPara(dbHelper.getOne(sql,conn_21sun));
		}else{
			product_id = CommonString.getFormatPara(oneNews.get("product_id")) ; // 新闻关联产品
			product_id=product_id.replace("null","");
		}
		productMap = dbHelper.getMap(" select * from pro_products where id = ? ",new Object [] {product_id},conn_21sun);
		String kwords = CommonString.getFormatPara(oneNews.get("keyword"));
		if(!"".equals(kwords)){
			String [] kArr = kwords.split("-");
			kwords = "";
			for(int i=0;i<kArr.length;i++){
				kwords+=kArr[i]+",";
			}
		}
		String content1 = CommonHtml.filterHTML(CommonString.getFormatPara(oneNews.get("content"))).length()>90?CommonHtml.filterHTML(CommonString.getFormatPara(oneNews.get("content"))).substring(0,90):CommonHtml.filterHTML(CommonString.getFormatPara(oneNews.get("content")));
		String title = CommonString.getFormatPara(oneNews.get("title"));
%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title><%=title%> - 铁臂<%=catalogname%>专区</title>
<meta name="keywords" content="<%=kwords %>" />
<meta name="description" content="<%=content1%>" />
<link href="/style/style.css" rel="stylesheet" type="text/css" />
<link href="/brandshow/style/brands.css" rel="stylesheet" type="text/css" />
<link href="/catalog/style/products.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="/plugin/dialog/jBox/Skins/Blue/jbox.css" type="text/css"></link>
<script type="text/javascript" src="/scripts/jquery-1.7.min.js"></script>
<script type="text/javascript" src="/scripts/scripts.js"></script>
<script type="text/javascript" src="/scripts/flash.js"></script>
<script type="text/javascript" src="/scripts/history/json.js"></script>
<script type="text/javascript" src="/scripts/jBox-v2.3/jquery.jBox-2.3.min.js"></script>
<script type="text/javascript" src="/scripts/jBox-v2.3/i18n/jquery.jBox-zh-CN.js"></script>
<script type="text/javascript" src="/plugin/jquery/jquery.cookies.2.2.0.min.js"></script>
<script type="text/javascript" src="/plugin/dialog/jBox/jquery.jBox-2.3.min.js"></script></head>
<body>
<!--top-->
  <jsp:include page="/include/top.jsp" flush="true"></jsp:include>
<div class="contain980 fix">
  <div class="nc_channT"><h1 style="font-size:24px;"><%=catalogname %></h1></div>
  <div class="s_mainSite"><a target="_blank" href="http://product.21-sun.com/">访问首页</a></div>
  <div class="s_tel">铁臂商城客服电话：<b>4006-521-526</b></div>
</div>
<div class="s_navBar">
  <div class="contain980">
    <ul class="fix">
      <li><a href="http://<%=usernn%>.21-sun.com/"><%=catalogname%>首页</a></li>
      <li   class="selected"><a href="http://<%=usernn%>.21-sun.com/news.htm"><%=catalogname%>动态</a></li>
      <li><a href="http://<%=usernn%>.21-sun.com/koubei.htm"><%=catalogname%>口碑</a></li>
      <li><a href="http://<%=usernn%>.21-sun.com/pic.htm"><%=catalogname%>图片</a></li>
      <li><a href="http://<%=usernn%>.21-sun.com/pro.htm"><%=catalogname%>品牌</a></li>
      <li><a href="http://product.21-sun.com/inquiry/0_0_0_<%=catalognum%>_0.shtm" target="_blank"><%=catalogname%>询价单</a></li>
    </ul>
  </div>
</div>
<div class="contain980 mb10 mt10">
  <div class="breadCrumbs"><a href="/">铁臂<%=catalogname %>专区</a> &gt;&gt; <a href="http://<%=usernn%>.21-sun.com/news.htm"><%=catalogname %>动态</a> &gt;&gt; <%=title %></div>
</div>
<!--main-->
<div class="contain980"> 
  <div class="newsListLeft">
    <div class="newsLeftpart mb10">
      <div class="newsDetail">
        <h2><%=CommonString.getFormatPara(oneNews.get("title")) %></h2>
        <div class="newsInfo blue"><%=CommonDate.getFormatDate("yyyy-MM-dd",oneNews.get("pub_date")) %>　来源：
        	<%
        		if("product".equals(t_flag)){
        			Map agentMap = dbHelper.getMap(" select is_qijiandian,full_name,usern,flag from pro_agent_factory where id = ? ",new Object [] {
        					oneNews.get("agent_id")
        			},conn_21sun);
					String url = "/agent/"+CommonString.getFormatPara(agentMap.get("usern"))+"/";
					if(CommonString.getFormatPara(agentMap.get("is_qijiandian")).equals("1") && CommonString.getFormatPara(agentMap.get("flag")).equals("2")){
						url = "/agentshop/"+CommonString.getFormatPara(agentMap.get("usern"))+"/";
					}else if(CommonString.getFormatPara(agentMap.get("is_qijiandian")).equals("0") && CommonString.getFormatPara(agentMap.get("flag")).equals("2")){
						url = "/agent/"+CommonString.getFormatPara(agentMap.get("usern"))+"/";
					}else if(CommonString.getFormatPara(agentMap.get("is_qijiandian")).equals("1") && CommonString.getFormatPara(agentMap.get("flag")).equals("1")){
						url = "/brandshop/"+CommonString.getFormatPara(agentMap.get("usern"))+"/";
					}else if(CommonString.getFormatPara(agentMap.get("is_qijiandian")).equals("0") && CommonString.getFormatPara(agentMap.get("flag")).equals("1")){
						url = "/brand/"+CommonString.getFormatPara(agentMap.get("usern"))+"/";
					}
        			%>
        			<a href="<%=url%>" target="_blank"><%=CommonString.getFormatPara(agentMap.get("full_name")) %></a>                    
        			<%
        		}else{
        			%>
        			<a href="http://product.21-sun.com/" target="_blank">工程机械铁臂商城</a>
        			<%
        		}
        	%>
        </div>
        <div class="ads" style="display: none;"><a href="#"><img src="../images/news_img14.jpg" width="630" height="60" /></a></div>
        <%
        	String content = CommonString.getFormatPara(oneNews.get("content"));
        	content = content.replaceAll("\\.\\./\\.\\./","/");
        	content = content.replaceAll("/UserFiles/Image/","http://news.21-sun.com/UserFiles/Image/");
        	content = content.replaceAll("/tech/uploadfiles/","http://www.21-sun.com/tech/uploadfiles/");
        %>
        <div class="detailTextarea">
         <%=content %>
         <div style="padding:0 15px 10px;border-top:1px dashed #CCCCCC;margin-top:20px;">本文链接地址：
         <%
         	String tUrl = "http://"+usernn+".21-sun.com/detail_"+CommonString.getFormatPara(oneNews.get("id"))+".htm";
	        if(!"".equals(t_flag)){
	        	tUrl += "&t_flag="+t_flag;	
	     	}
         %>
         <a style="color:#075aad;" title="<%=CommonString.getFormatPara(oneNews.get("title")) %>" target="_blank" href="<%=tUrl %>">
            <%=tUrl %>
            </a>
         </div>
        </div>
      </div>

      
 
    
    </div>

    

    
  </div>
  
    <div class="s_right">
	<!--热门产品-->
	<jsp:include page="/include/catalogshow/product_hot.jsp" flush="true">
      <jsp:param name="catalogname" value='<%=catalogname%>'></jsp:param>
      <jsp:param name="catalognum" value='<%=catalognum%>'></jsp:param>
    </jsp:include>
	<!--产品关注排行-->
	<jsp:include page="/include/catalogshow/product_rank.jsp" flush="true">
      <jsp:param name="catalogname" value='<%=catalogname%>'></jsp:param>
      <jsp:param name="catalognum" value='<%=catalognum%>'></jsp:param>
    </jsp:include>
    </div>
<div class="clear"></div>
</div>
<!--main end--> 
<!--foot-->
<jsp:include page="/include/foot.jsp" flush="true"></jsp:include> 

<script type="text/javascript" src="/scripts/sort.js"></script>
<!--end of foot--> 
</body>
</html>
<script type="text/javascript">
	<%
		if("product".equals(t_flag)){
			%>
			jQuery.post("/action/ajax.jsp",{
				flag : 'agent_news_view_count',
				id : '<%=id %>',
				agent_id : '<%=oneNews.get("agent_id") %>'
			});
			<%
		}
	%>
</script>	
</html>
<%
	}catch(Exception e){
		e.printStackTrace() ;
		response.setStatus(HttpServletResponse.SC_NOT_FOUND);
		request.getRequestDispatcher("/404.htm").forward(request,response);
	}finally{
		DBHelper.freeConnection(conn_21sun) ;
	}
%>
