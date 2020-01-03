<%@ page language="java" import="org.json.*,java.net.*,java.sql.Connection,java.util.*,com.jerehnet.util.dbutil.*,com.jerehnet.util.common.*,com.jerehnet.webservice.*" pageEncoding="UTF-8"%><%
	String id = CommonString.getFormatPara(request.getParameter("id")) ;  // 新闻 id 
	String t_flag = CommonString.getFormatPara(request.getParameter("t_flag")) ;
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
<title><%=title %>-工程机械维修 - 铁臂维修</title>
<meta name="keywords" content="<%=kwords %>企业动态,活动推荐,工程机械图片,工程机械产品动态,工程机械铁臂商城" />
<meta name="description" content="<%=content1 %>" />
<link href="/style/style.css" rel="stylesheet" type="text/css" />
<link href="/style/new_style.css" rel="stylesheet" type="text/css" />
<link href="/weixiu/style/style.css" rel="stylesheet" type="text/css" />
<link href="/weixiu/style/weixiu.css" rel="stylesheet" type="text/css" />
<link href="/style/friendly_link.css" rel="stylesheet" type="text/css" />

<link rel="stylesheet" href="/plugin/dialog/jBox/Skins/Blue/jbox.css" type="text/css"></link>
<script type="text/javascript" src="/scripts/jquery-1.7.min.js"></script>
<script type="text/javascript" src="/scripts/scripts.js"></script>
<script type="text/javascript" src="/scripts/flash.js"></script>

<script type="text/javascript" src="/scripts/jBox-v2.3/jquery.jBox-2.3.min.js"></script>
<script type="text/javascript" src="/scripts/jBox-v2.3/i18n/jquery.jBox-zh-CN.js"></script>
<script type="text/javascript" src="/plugin/jquery/jquery.cookies.2.2.0.min.js"></script>
<script type="text/javascript" src="/plugin/dialog/jBox/jquery.jBox-2.3.min.js"></script></head>
<body>
<!--top-->
<jsp:include page="/weixiu/top.jsp" flush="true" />
<!--面包屑-->
<div class="contain980 mb10">
  <h3 class="breadCrumbs"><a href="/">铁臂维修</a>&nbsp;&gt;&gt;&nbsp;<a href="/news/">维修动态</a> &gt;&gt; <%=CommonString.getFormatPara(oneNews.get("title")) %></h3>
</div>
<!--面包屑结束--> 

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
        			<a href="http://product.21-sun.com/" target="_blank">工程机械产品中心</a>
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
         	String tUrl = "http://weixiu.21-sun.com/news_"+CommonString.getFormatPara(oneNews.get("id"))+".htm";
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
      <div class="relateReader">
        <div class="title">
        	<%
        		String xiang_guan = CommonString.getFormatPara(oneNews.get("keyword"));
        		String [] xg_arr = null;
        		if(xiang_guan.indexOf("-")!=-1){
        			xg_arr = xiang_guan.split("-");
        		}
        	%>
          <h3>相关阅读：<%
          		if(null!=xg_arr){
          			out.print("<span>");
          			for(int i=0;i<xg_arr.length;i++){ 
          				%>
          				<a href="http://sowa.21-sun.com/?q=<%=URLEncoder.encode(xg_arr[i],"utf-8") %>&f=news" target="_blank"><%=xg_arr[i] %></a>
          				<%
          			}
          			out.print("</span>");
          		}
          	%></h3>
        </div>
        <%
        	List<Map> news = WEBDBHelper.getMapList(" select top 6 title,id,link_other from article order by newid() ","Web21sunDBHelper");
        	if(null!=news){
        		out.print("<ul class='rrlist'>");
        		for(Map m : news){
        			  if("".equals(CommonString.getFormatPara(m.get("link_other")))||"null".equals(CommonString.getFormatPara(m.get("link_other")))){
        			%><li>
        			<a href="/news_<%=CommonString.getFormatPara(m.get("id")) %>.htm" target="_blank"><%=CommonString.getFormatPara(m.get("title")) %></a>
        			</li><%
        		}else{
        			%>
        			<li>
        			<a href="<%=CommonString.getFormatPara(m.get("link_other")) %>" target="_blank"><%=CommonString.getFormatPara(m.get("title")) %></a>
        			</li>
        			<%
        		}
        		}
        		out.print("</ul>");
        	}
        %>
      </div>
      
      <div class="listBottom">
        <div class="bdshare">
          <!-- Baidu Button BEGIN -->
<div class="bdsharebuttonbox"><a href="#" class="bds_more" data-cmd="more"></a><a href="#" class="bds_qzone" data-cmd="qzone" title="分享到QQ空间"></a><a href="#" class="bds_tsina" data-cmd="tsina" title="分享到新浪微博"></a><a href="#" class="bds_tqq" data-cmd="tqq" title="分享到腾讯微博"></a><a href="#" class="bds_renren" data-cmd="renren" title="分享到人人网"></a><a href="#" class="bds_weixin" data-cmd="weixin" title="分享到微信"></a></div>

          <!-- Baidu Button END -->
        </div>
      </div>
    
    </div>
    <%
    	if(null!=productMap){
    		String name = CommonString.getFormatPara(productMap.get("factoryname"))+CommonString.getFormatPara(productMap.get("name"))+CommonString.getFormatPara(productMap.get("catalogname"));
    		String img = CommonString.getFormatPara(productMap.get("img2"));
    		String url = "http://product.21-sun.com/proDetail/"+CommonString.getFormatPara(productMap.get("file_name"));
    		String pid = CommonString.getFormatPara(productMap.get("id"));
    		Integer dealerCount = (Integer)dbHelper.getOne(" select count(*) from pro_agent_products where product_id = ? ",new Object [] {
    			pid
    		},conn_21sun);
    		Integer imgCount = (Integer)dbHelper.getOne(" select count(*) from pro_product_pic where product_id = ? ",new Object [] {
    			pid
    		},conn_21sun);
    		Integer commentCount = (Integer)dbHelper.getOne(" select count(*) from pro_comments where product_id = ? ",new Object [] {
    			pid
    		},conn_21sun);
    		Integer inquiryCount = (Integer)dbHelper.getOne(" select count(*) from pro_product_form where product_id = ? ",new Object [] {
    			pid
    		},conn_21sun);
    		String imgUrl = url.substring(0,url.lastIndexOf("."))+"_pic"+url.substring(url.lastIndexOf("."));
    		String commentUrl = url.substring(0,url.lastIndexOf("."))+"_message"+url.substring(url.lastIndexOf("."));
    		String orderUrl = url.substring(0,url.lastIndexOf("."))+"_order"+url.substring(url.lastIndexOf("."));
    		String introUrl = url.substring(0,url.lastIndexOf("."))+"_intro"+url.substring(url.lastIndexOf("."));
    	%>
	<div class="newsLeftpart nlp01 blue mb10">
      <div class="img">
      	<a href="<%=url %>" target="_blank"><img src="http://product.21-sun.com/uploadfiles/<%=img %>" width="147" height="103" /></a>
      </div>
      <div class="info">
        <h3><a href="<%=url %>" target="_blank"><%=name %></a></h3> 
        <ul style="width:176px;">   
          <li><a href="<%=url %>" target="_blank">参数配置</a></li>
          <li><a href="http://product.21-sun.com/agent/list.jsp?factoryid=<%=CommonString.getFormatPara(productMap.get("factoryid")) %>" target="_blank">代理商<span></span></a></li>
          <li><a href="<%=imgUrl %>" target="_blank">图片<span></span></a></li>
          <li><a href="<%=introUrl %>" target="_blank">产品介绍</a></li>
           <li><a href="<%=orderUrl %>" target="_blank">询价单<span></span></a></li>
          <li><a href="<%=commentUrl %>" target="_blank">评论<span></span></a></li>
          <li style="display: none;"><a href="#">看看<span>(6758)</span></a></li>
        </ul>   
      </div>     
      <div class="btn">本产品共有<strong><%=CommonString.getFormatPara(productMap.get("view_count")) %></strong>人关注&nbsp;<strong><a href='<%=orderUrl %>' target="_blank"><%=inquiryCount %></a></strong>&nbsp;份在线询价单<br />
      <a href="javascript:void(0);" onclick="showinquery('<%=CommonString.getFormatPara(productMap.get("id")) %>','');"><img src="../images/simg_btn01.gif" alt="免费询价" width="188" height="45" style="margin-top:15px;" /></a></div>
    </div>  
    	<%
    	}
    %>
    

    <div class="newsLeftpart nlp03" style="display: none;">
      <div class="newsLeftTabs">
        <ul>
          <li><a href="#" class="selected">热门车型</a></li>
          <li><a href="#">热门品牌</a></li>
          <li><a href="#">热点媒体</a></li>
          <li><a href="#">热点标签</a></li>
        </ul>
      </div>
      <div class="newsLeftTabsContent">
        <div class="nlt-con">
          <a href="#">阿斯顿·马丁</a><em>|</em><a href="#">本田</a><em>|</em><a href="#">比亚迪</a><em>|</em><a href="#">阿斯顿·马丁</a><em>|</em><a href="#">奥迪</a><em>|</em><a href="#">本田</a><em>|</em><a href="#">比亚迪</a><em>|</em><a href="#">阿斯顿·马丁</a><em>|</em><a href="#">奥迪</a><em>|</em><a href="#">本田</a><em>|</em><a href="#">比亚迪</a><em>|</em><a href="#">阿斯顿·马丁</a><em>|</em><a href="#">奥迪</a><em>|</em><a href="#">本田</a><em>|</em><a href="#">比亚迪</a><em>|</em><a href="#">阿斯顿·马丁</a><em>|</em><a href="#">奥迪</a><em>|</em><a href="#">本田</a><em>|</em><a href="#">比亚迪</a><a href="#">阿斯顿·马丁</a><em>|</em><a href="#">奥迪</a><em>|</em><a href="#">本田</a><em>|</em><a href="#">比亚迪</a><em>|</em><a href="#">阿斯顿·马丁</a><em>|</em><a href="#">奥迪</a><em>|</em><a href="#">本田</a><em>|</em><a href="#">比亚迪</a><em>|</em><a href="#">阿斯顿·马丁</a><em>|</em><a href="#">奥迪</a><em>|</em><a href="#">本田</a><em>|</em><a href="#">比亚迪</a><em>|</em><a href="#">阿斯顿·马丁</a><em>|</em><a href="#">奥迪</a><em>|</em><a href="#">本田</a><em>|</em><a href="#">比亚迪</a><em>|</em><a href="#">阿斯顿·马丁</a><em>|</em><a href="#">奥迪</a>
        </div>
      </div>
    </div>
    
  </div>
  
  
<div class="nre_left" style="float:right;width:230px;">
      <div class="rp clearfix mb10 area">
      <div class="title">
        <h3>热门区域维修</h3>
      </div>
      <div class="content rList01">
        <ul class="list">	
            <li><a title="北京维修" href="/0-105500-0.htm">北京</a></li>
			<li><a title="上海维修" href="/0-105300-0.htm">上海</a></li>
			<li><a title="天津维修" href="/0-105690-0.htm">天津</a></li>
			<li><a title="重庆维修" href="/0-105880-0.htm">重庆</a></li>
			<li><a title="石家庄维修" href="/0-106410-0.htm">石家庄</a></li>
			<li><a title="太原维修" href="/0-108310-0.htm">太原</a></li>
			<li><a title="呼和浩特维修" href="/0-109710-0.htm">呼和浩特</a></li>
			<li><a title="沈阳维修" href="/0-120010-0.htm">沈阳</a></li>
			<li><a title="长春维修" href="/0-119010-0.htm">长春</a></li>
			<li><a title="哈尔滨维修" href="/0-122010-0.htm">哈尔滨</a></li>
			<li><a title="南京维修" href="/0-110910-0.htm">南京</a></li>
			<li><a title="杭州维修" href="/0-104210-0.htm">杭州</a></li>
			<li><a title="合肥维修" href="/0-102320-0.htm">合肥</a></li>
			<li><a title="福州维修" href="/0-142010-0.htm">福州</a></li>
			<li><a title="南昌维修" href="/0-103110-0.htm">南昌</a></li>
			<li><a title="济南维修" href="/0-101260-0.htm">济南</a></li>
			<li><a title="郑州维修" href="/0-130010-0.htm">郑州</a></li>
			<li><a title="武汉维修" href="/0-124010-0.htm">武汉</a></li>
			<li><a title="长沙维修" href="/0-126010-0.htm">长沙</a></li>
			<li><a title="广州维修" href="/0-128010-0.htm">广州</a></li>
			<li><a title="南宁维修" href="/0-113010-0.htm">南宁</a></li>
			<li><a title="海口维修" href="/0-141510-0.htm">海口</a></li>
			<li><a title="成都维修" href="/0-139010-0.htm">成都</a></li>
			<li><a title="贵阳维修" href="/0-132010-0.htm">贵阳</a></li>
			<li><a title="昆明维修" href="/0-137010-0.htm">昆明</a></li>
			<li><a title="拉萨维修" href="/0-115010-0.htm">拉萨</a></li>
			<li><a title="西安维修" href="/0-135510-0.htm">西安</a></li>
			<li><a title="兰州维修" href="/0-134010-0.htm">兰州</a></li>
			<li><a title="西宁维修" href="/0-133010-0.htm">西宁</a></li>
			<li><a title="银川维修" href="/0-116010-0.htm">银川</a></li>
			<li><a title="乌鲁木齐维修" href="/0-117010-0.htm">乌鲁木齐</a></li>
        </ul>
      </div>
    </div>

    <div class="rp clearfix mb10 cate">
      <div class="title">
        <h3>热门产品维修</h3>
      </div>
      <div class="content rList01">
        <ul class="list">
            <li><a target="_blank" title="挖掘机维修" href="/101001-0-0.htm">挖掘机维修</a></li>
			<li><a target="_blank" title="摊铺机维修" href="/104001-0-0.htm">摊铺机维修</a></li>
			<li><a target="_blank" title="沥青搅拌站维修" href="/104009-0-0.htm">沥青搅拌站维修</a></li>
			<li><a target="_blank" title="铣刨机维修" href="/104005-0-0.htm">铣刨机维修</a></li>
			<li><a target="_blank" title="平地机维修" href="/101005-0-0.htm">平地机维修</a></li>
			<li><a target="_blank" title="压路机维修" href="/106001-0-0.htm">压路机维修</a></li>
			<li><a target="_blank" title="混凝土泵车维修" href="/103001-0-0.htm">混凝土泵车维修</a></li>
			<li><a target="_blank" title="截桩机/破桩机维修" href="/105028-0-0.htm">截桩机/破桩机维修</a></li>
			<li><a target="_blank" title="推土机维修" href="/101003-0-0.htm">推土机维修</a></li>
			<li><a target="_blank" title="装载机维修" href="/101002-0-0.htm">装载机维修</a></li>
			<li><a target="_blank" title="铲运机维修" href="/101004-0-0.htm">铲运机维修</a></li>
			<li><a target="_blank" title="自卸卡车维修" href="/101008-0-0.htm">自卸卡车维修</a></li>
			<li><a target="_blank" title="牵引车维修" href="/118004-0-0.htm">牵引车维修</a></li>
			<li><a target="_blank" title="正面吊维修" href="/111001-0-0.htm">正面吊维修</a></li>
			<li><a target="_blank" title="塔式起重机维修" href="/102002-0-0.htm">塔式起重机维修</a></li>
			<li><a target="_blank" title="高空作业车维修" href="/102010-0-0.htm">高空作业车维修</a></li>
			<li><a target="_blank" title="施工升降机维修" href="/102011-0-0.htm">施工升降机维修</a></li>
			<li><a target="_blank" title="专用叉车维修" href="/107010-0-0.htm">专用叉车维修</a></li>
			<li><a target="_blank" title="强夯机维修" href="/105017-0-0.htm">强夯机维修</a></li>
			<li><a target="_blank" title="场桥维修" href="/111006-0-0.htm">场桥维修</a></li>
			<li><a target="_blank" title="消防车维修" href="/118003-0-0.htm">消防车维修</a></li>
			<li><a target="_blank" title="液压剪维修" href="/113002-0-0.htm">液压剪维修</a></li>
        </ul>
      </div>
    </div>

    <div class="rp clearfix mb10 area">
      <div class="title">
        <h3>热门品牌维修</h3>
      </div>
      <div class="content rList01">
        <ul class="list">
            <li><a target="_blank" title="徐工维修" href="/0-0-209.htm">徐工</a></li>
            <li><a target="_blank" title="三一维修" href="/0-0-133.htm">三一</a></li>
            <li><a target="_blank" title="小松维修" href="/0-0-182.htm">小松</a></li>
            <li><a target="_blank" title="柳工维修" href="/0-0-136.htm">柳工</a></li>
            <li><a target="_blank" title="中联重科维修" href="/0-0-134.htm">中联重科</a></li>
            <li><a target="_blank" title="斗山维修" href="/0-0-192.htm">斗山</a></li>
            <li><a target="_blank" title="卡特彼勒维修" href="/0-0-174.htm">卡特彼勒</a></li>
            <li><a target="_blank" title="沃尔沃维修" href="/0-0-175.htm">沃尔沃</a></li>
            <li><a target="_blank" title="福田雷沃维修" href="/0-0-141.htm">福田雷沃</a></li>
            <li><a target="_blank" title="日立维修" href="/0-0-184.htm">日立</a></li>
            <li><a target="_blank" title="龙工维修" href="/0-0-135.htm">龙工</a></li>
            <li><a target="_blank" title="厦工维修" href="/0-0-139.htm">厦工</a></li>
            <li><a target="_blank" title="神钢维修" href="/0-0-183.htm">神钢</a></li>
            <li><a target="_blank" title="利勃海尔维修" href="/0-0-179.htm">利勃海尔</a></li>
            <li><a target="_blank" title="山河智能维修" href="/0-0-142.htm">山河智能</a></li>
            <li><a target="_blank" title="山东临工维修" href="/0-0-137.htm">山东临工</a></li>
            <li><a target="_blank" title="山推维修" href="/0-0-144.htm">山推</a></li>
            <li><a target="_blank" title="加藤维修" href="/0-0-189.htm">加藤</a></li>
            <li><a target="_blank" title="山重建机维修" href="/0-0-152.htm">山重建机</a></li>
            <li><a target="_blank" title="凯斯维修" href="/0-0-455.htm">凯斯</a></li>
            <li><a target="_blank" title="玉柴维修" href="/0-0-146.htm">玉柴</a></li>
            <li><a target="_blank" title="特雷克斯维修" href="/0-0-176.htm">特雷克斯</a></li>
            <li><a target="_blank" title="卡特重工维修" href="/0-0-178.htm">卡特重工</a></li>
            <li><a target="_blank" title="现代维修" href="/0-0-194.htm">现代</a></li>
            <li><a target="_blank" title="住友维修" href="/0-0-185.htm">住友</a></li>
            <li><a target="_blank" title="一拖维修" href="/0-0-159.htm">一拖</a></li>
            <li><a target="_blank" title="JCB维修" href="/0-0-177.htm">JCB</a></li>
            <li><a target="_blank" title="久保田维修" href="/0-0-187.htm">久保田</a></li>
            <li><a target="_blank" title="徐挖维修" href="/0-0-150.htm">徐挖</a></li>
            <li><a target="_blank" title="沃得重工维修" href="/0-0-149.htm">沃得重工</a></li>
        </ul>
      </div>
    </div>
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
	var nowBrand = '';
    var nowBrandName = '';
	var nowCatalog = '';
	var nowCatalogName = '';
	var nowProvince = '<%=province%>';
	var nowCity = '<%=city%>';
    function doAgentSearch(){
    	if(jQuery("#province").val()==''&&jQuery("#city").val()==''&&jQuery("#brand").val()==''&&jQuery("#model").val()==''&&jQuery("#agent_q").val()==''){
    		alert("请选择搜索条件！");
    		return;
    	}
    	if(jQuery("#agent_q").val()!=''){
    		var provinceHTML ='';
    		if(document.getElementById("province").value!=''){
    			provinceHTML=document.getElementById("province").options[document.getElementById("province").selectedIndex].innerHTML;
    			provinceHTML = provinceHTML.split(" ")[1];
    		}
    		var cityHTML ='';
    		if(document.getElementById("city").value!=''){
    			cityHTML=document.getElementById("city").options[document.getElementById("city").selectedIndex].innerHTML;
    			cityHTML = cityHTML.split(" ")[1];
    		}
    		var brandHTML ='';
    		if(document.getElementById("brand").value!=''){
    			brandHTML=document.getElementById("brand").options[document.getElementById("brand").selectedIndex].innerHTML;
    			brandHTML = brandHTML.split(" ")[1];
    			brandHTML = brandHTML.replace("&nbsp;","");
    			brandHTML = brandHTML.replace("&nbsp;","");
    			brandHTML = brandHTML.replace("&nbsp;","");
    			brandHTML = brandHTML.replace("&nbsp;","");
    		}
    		var modelHTML ='';
    		if(document.getElementById("model").value!=''){
    			modelHTML=document.getElementById("model").options[document.getElementById("model").selectedIndex].innerHTML;
    			modelHTML = modelHTML.replace("&nbsp;","");
    			modelHTML = modelHTML.replace("&nbsp;","");
    			modelHTML = modelHTML.replace("&nbsp;","");
    			modelHTML = modelHTML.replace("&nbsp;","");
    		}
    		var goHtm = provinceHTML+cityHTML+brandHTML+modelHTML+jQuery("#agent_q").val();
    		goHtm = jQuery("#agent_q").val();
    		window.open("http://sowa.21-sun.com/?q="+encodeURIComponent(goHtm)+"&f=supply");
    	}else{
    		var url = "";
	    	if(jQuery("#brand").val()!=''){
	    		url += "&factoryid="+jQuery("#brand").val();
	    	}
	    	if(jQuery("#city").val()!=''){
	    		var city = jQuery("#city").val();
	    		city = city.split(" ")[1];
	    		url += "&city="+city;
	    	}
	    	if(jQuery("#province").val()!=''){
	    		var province = jQuery("#province").val();
	    		province = province.split(" ")[1];
	    		url += "&province="+province;
	    	}
	    	if(jQuery("#model").val()!=''){
	    		url += "&catalogid="+jQuery("#model").val();
	    	}
	    	if(""!=url){
	    		url = url.substring(1);
	    		url = "/agent/list.jsp?"+url;
	    	}else{
	    		url = "/agent/list.jsp";
	    	}
	    	window.location.href = url;
    	}
    }
  	getAgentList(0,'search');
  	function setHover(){
  		 jQuery("#agent_info ul").hover(function(){
			jQuery(this).toggleClass("a_hover");
		},function(){
			jQuery(this).removeClass("a_hover");
		});
  	}
  	function getAgentList(nowPage,isAuto){
  		if(nowBrand!=null||nowBrand!=''){
  			jQuery("#brand").val(nowBrand);
  		}
  		jQuery("#agent_info").html("<img src='/images/loading.gif' style='margin:130px 0 0 350px;' />");
		var agentObj;
		jQuery.ajax({
			url : "/tools/ajax.jsp",
			data : {
				flag : "agentList",
				nowPage : nowPage ,
				province : nowProvince ,
				orderProvince : nowProvince ,
				orderCity : nowCity ,
				city : nowCity ,
				brand : nowBrand ,
				model : nowCatalog ,
				isAuto : isAuto				
			},
			type : "post",
			success : function(data){
				agentObj = eval("["+data+"]")[0];
				var agentList = agentObj.list;
				var agLi = jQuery("#agent_info");
				agLi.html("");
				var htm = '';
				var i_f = 1;
				for(var i=0;i<agentList.length;i++){
					if((i%2)==0){
						i_f = 2;
					}else{
						i_f = 1;
					}
					htm += '<ul class="libg0'+i_f+'">';
					if(agentList[i].is_qijiandian==1){
					htm += '<li class="g1"><a title="'+agentList[i].full_name+'" href="/agentshop/'+agentList[i].usern+'/" target="_blank">'+agentList[i].full_name+'</a></li>';
					}else{
					htm += '<li class="g1"><a title="'+agentList[i].full_name+'" href="/agent/'+agentList[i].usern+'/" target="_blank">'+agentList[i].full_name+'</a></li>';
					}
					htm += '<li class="g4"><a href="javascript:void(0);" onclick="zaiXianXunJia(\''+agentList[i].id+'\');">在线询价</a></li>';
					if(null!=agentList[i].telphone&&agentList[i].telphone!=''){
						htm += '<li class="g5" style="width:130px;overflow:hidden;"><a id="seePhone_'+agentList[i].id+'" href="javascript:void(0);" onclick="lianXiDianHua(\''+agentList[i].id+'\');">点击查看联系电话</a></li>';
					}else{
						htm += '<li class="g5" style="width:130px;overflow:hidden;"><a class="gcur" href="javascript:void(0);">暂无联系方式</a></li>';
					}
					htm += '</ul>';
				}
				agLi.html(htm);
				jQuery("#agent_page").html("");
				if(jQuery.trim(htm)!=''){
					createPage(agentObj);
				}else{
					jQuery("#agent_info").html("<div style='text-align:center;margin:10px auto;'>暂无代理商信息！</div>");
				}
				setHover();
			}
		});
	}
	function zaiXianXunJia(id){
		var url = '/include/agent/enquiry.jsp?id='+id;
		if(nowBrand!=''){
			url += "&nowBrand="+nowBrand;
		}
		if(nowBrandName!=''){
			url += "&nowBrandName="+nowBrandName;
		}
		if(nowCatalog!=''){
			url += "&nowCatalog="+nowCatalog;
		}
		if(nowCatalogName!=''){
			url += "&nowCatalogName="+nowCatalogName;
		}
		jQuery.jBox("iframe:"+url,{
			title : "在线询价",
			width : 550,
			height : 380,
			iframeScrolling:'no' ,
			top: '25%',
			buttons : {"确定":true,"关闭":false},
			submit : function(v,h,f){
				if(v){
					var ifrm = jQuery.jBox.getIframe();
					var subSr = ifrm.contentWindow.doSub();
					return false;
				}
				return true;
			}
		});
	}
	function seePhone(id){
		jQuery.post("/tools/ajax.jsp",{flag:'viewPhoneClickCount',id:id});
		var xunjia_user = jQuery.cookies.get("xunjia_user");
		var xunjia_phone = jQuery.cookies.get("xunjia_phone");
		var xunjia_catalog = jQuery.cookies.get("xunjia_catalog");
		var xunjia_catalog_name = jQuery.cookies.get("xunjia_catalog_name");
		var xunjia_brand = jQuery.cookies.get("xunjia_brand");
		var xunjia_brand_name = jQuery.cookies.get("xunjia_brand_name");
		jQuery.post("/tools/ajax.jsp",{
			flag : 'seePhone',
			name : xunjia_user,
			mobile_phone : xunjia_phone,
			province : '<%=province%>',
			city : '<%=city%>',
			catalog : xunjia_catalog,
			catalogName : xunjia_catalog_name,
			brand : xunjia_brand ,
			brandName : xunjia_brand_name ,
			id : id
		},function(data){
			jQuery("#seePhone_"+id).addClass("gcur");
			jQuery("#seePhone_"+id).html(data);
			jQuery("#seePhone_"+id).attr("tip_title",data);
			jQuery("#seePhone_"+id).removeAttr("onclick");
			jQuery("#seePhone_"+id).yitip();
			var singleTitleTip = jQuery("#seePhone_"+id).yitip("api");
			singleTitleTip.setPosition("rightMiddle");
		});
	}
	function lianXiDianHua(id){
		var xunjia_user = jQuery.cookies.get("xunjia_user");
		if(null!=xunjia_user){
			seePhone(id);
			return;
		}
		jQuery.jBox("iframe:/include/agent/show_phone.jsp?id="+id,{
			title : "查看联系电话",
			width : 400,
			height : 290,
			top: '35%',
			iframeScrolling:'no' ,
			buttons : {"确定":true,"关闭":false},
			submit : function(v,h,f){
				if(v){
					var ifrm = jQuery.jBox.getIframe();
					var subSr = ifrm.contentWindow.doSub();
					return false;
				}
				return true;
			}
		});
	}
	function createPage(obj){
		var htm = '';
		if(obj.nowPage>1){
			htm += '<a class="pre" href="javascript:void(0);" onclick="getAgentList('+(obj.nowPage-1)+',\'search\');">&nbsp;</a>';
		}else{
			htm += '<a class="pre" style="cursor: default;">&nbsp;</a>';
		}
		var left = 0;
		var right = 0;
		var middle = obj.nowPage;
		var rightCount = 0; 
		if(obj.pageCount>10){
			rightCount = obj.pageCount - 5;
			if (middle <= 5 && middle < rightCount) {
				for(var i=0;i<5;i++){
					if((i+1)==obj.nowPage){
						htm += '<span class="current"><b>&nbsp;'+(i+1)+'&nbsp;</b></span>';
					}else{
						htm += '<a class="num" href="javascript:void(0);" onclick="getAgentList('+(i+1)+',\'search\');">&nbsp;'+(i+1)+'&nbsp;</a>';
					}
				}
				if(middle==5){
					htm += '<a class="num" href="javascript:void(0);" onclick="getAgentList('+6+',\'search\');">&nbsp;'+6+'&nbsp;</a>';
					htm += '<a class="num" href="javascript:void(0);" onclick="getAgentList('+7+',\'search\');">&nbsp;'+7+'&nbsp;</a>';
				}
				htm += '<a class="num" href="javascript:void(0);">...</a>';
				htm += '<a class="num" href="javascript:void(0);" onclick="getAgentList('+(obj.pageCount-2)+',\'search\');">&nbsp;'+(obj.pageCount-2)+'&nbsp;</a>';
				htm += '<a class="num" href="javascript:void(0);" onclick="getAgentList('+(obj.pageCount-1)+',\'search\');">&nbsp;'+(obj.pageCount-1)+'&nbsp;</a>';
			}else if( middle > 5 && middle > rightCount){
				htm += '<a class="num" href="javascript:void(0);" onclick="getAgentList('+1+',\'search\');">&nbsp;'+1+'&nbsp;</a>';
				htm += '<a class="num" href="javascript:void(0);" onclick="getAgentList('+2+',\'search\');">&nbsp;'+2+'&nbsp;</a>';
				htm += '<a class="num" href="javascript:void(0);">...</a>';
				if(middle==(rightCount+1)){
					htm += '<a class="num" href="javascript:void(0);" onclick="getAgentList('+(middle-2)+',\'search\');">&nbsp;'+(middle-2)+'&nbsp;</a>';
					htm += '<a class="num" href="javascript:void(0);" onclick="getAgentList('+(middle-1)+',\'search\');">&nbsp;'+(middle-1)+'&nbsp;</a>';
				}
				for(var i = rightCount;i<obj.pageCount;i++){
						if((i+1)==obj.nowPage){
							htm += '<span class="current"><b>&nbsp;'+(i+1)+'&nbsp;</b></span>';
						}else{
							htm += '<a class="num" href="javascript:void(0);" onclick="getAgentList('+(i+1)+',\'search\');">&nbsp;'+(i+1)+'&nbsp;</a>';
						}
					}
				} else {
					htm += '<a class="num" href="javascript:void(0);" onclick="getAgentList('+1+',\'search\');">&nbsp;'+1+'&nbsp;</a>';
					htm += '<a class="num" href="javascript:void(0);" onclick="getAgentList('+2+',\'search\');">&nbsp;'+2+'&nbsp;</a>';
					htm += '<a class="num" href="javascript:void(0);">...</a>';
					htm += '<a class="num" href="javascript:void(0);" onclick="getAgentList('+(middle-2)+',\'search\');">&nbsp;'+(middle-2)+'&nbsp;</a>';
					htm += '<a class="num" href="javascript:void(0);" onclick="getAgentList('+(middle-1)+',\'search\');">&nbsp;'+(middle-1)+'&nbsp;</a>';
					htm += '<span class="current"><b>&nbsp;'+middle+'&nbsp;</b></span>';
					htm += '<a class="num" href="javascript:void(0);" onclick="getAgentList('+(middle+1)+',\'search\');">&nbsp;'+(middle+1)+'&nbsp;</a>';
					htm += '<a class="num" href="javascript:void(0);" onclick="getAgentList('+(middle+2)+',\'search\');">&nbsp;'+(middle+2)+'&nbsp;</a>';
					htm += '<a class="num" href="javascript:void(0);">...</a>';
					htm += '<a class="num" href="javascript:void(0);" onclick="getAgentList('+(obj.pageCount-1)+',\'search\');">&nbsp;'+(obj.pageCount-1)+'&nbsp;</a>';
					htm += '<a class="num" href="javascript:void(0);" onclick="getAgentList('+(obj.pageCount-0)+',\'search\');">&nbsp;'+(obj.pageCount-0)+'&nbsp;</a>';
			}
		}else{
			left = 0;
			right = obj.pageCount;
			for(var i=left;i<right;i++){
				if((i+1)==obj.nowPage){
					htm += '<span class="current" style="cursor: default;"><b>&nbsp;'+(i+1)+'&nbsp;</b></span>';
				}else{
					htm += '<a class="num" href="javascript:void(0);" onclick="getAgentList('+(i+1)+',\'search\');">&nbsp;'+(i+1)+'&nbsp;</a>';
				}
			}
		}
		if(obj.nowPage>=obj.pageCount){
			htm += '<a class="next" style="cursor: default;">&nbsp;</a>';
		}else{ 
			htm += '<a class="next" href="javascript:void(0);" onclick="getAgentList('+(obj.nowPage+1)+',\'search\');">&nbsp;</a>';
		}
	// 	htm += '<a href="/agent/list.jsp">更多>></a>';
		jQuery("#agent_page").html(htm);
	}
		// 显示浏览记录 
		setTimeout(function(){ 
		 	   if(jQuery.trim(jQuery("#history").html())==''){
		 	   jQuery("#tophistory").hide() ;   
		 	   }
		 },10) ;
	jQuery(function(){                                          
		 	 DisplayHistory() ;
	}) ;
	function clearHistory(){
		jQuery("#tophistory").fadeOut("slow") ;
    	DeleteCookie("history") ;
	}
jQuery(function(){
	jQuery.ajax({
		url:'/action/ajax.jsp',
		type:'post',
		async:true,
		data:{flag:'agentNewsCount',id:'<%=id%>'},
		success:function(msg){} 
	}) ; 
}) ;
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
