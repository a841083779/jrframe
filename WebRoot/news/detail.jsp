<%@ page language="java" import="org.json.*,java.net.*,java.sql.Connection,java.util.*,com.jerehnet.util.dbutil.*,com.jerehnet.util.common.*,com.jerehnet.webservice.*" pageEncoding="UTF-8"%><%
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
<title><%=title %>-工程机械行业 - 铁臂商城</title>
<meta name="keywords" content="<%=kwords %>企业动态,活动推荐,工程机械图片,工程机械产品动态,工程机械铁臂商城" />
<meta name="description" content="<%=content1 %>" />
<link href="/style/style.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="/plugin/dialog/jBox/Skins/Blue/jbox.css" type="text/css"></link>
<script type="text/javascript" src="/scripts/jquery-1.7.min.js"></script>
<script type="text/javascript" src="/scripts/scripts.js"></script>
<script type="text/javascript" src="/scripts/flash.js"></script>
<script type="text/javascript" src="/scripts/history/json.js"></script>
<script type="text/javascript" src="/scripts/history/history.js"></script>
<script type="text/javascript" src="/scripts/jBox-v2.3/jquery.jBox-2.3.min.js"></script>
<script type="text/javascript" src="/scripts/jBox-v2.3/i18n/jquery.jBox-zh-CN.js"></script>
<script type="text/javascript" src="/plugin/jquery/jquery.cookies.2.2.0.min.js"></script>
<script type="text/javascript" src="/plugin/dialog/jBox/jquery.jBox-2.3.min.js"></script></head>
<body>
<!--top-->
  <jsp:include page="/include/top.jsp" flush="true"></jsp:include>
<!--面包屑-->
<div class="contain980 mb10">
  <h3 class="breadCrumbs">您现在所在的位置：<a href="/">工程机械产品中心</a> &gt;&gt; <a href="/news/">行情.导购</a> &gt;&gt; <%=CommonString.getFormatPara(oneNews.get("title")) %></h3>
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
         	String tUrl = "http://product.21-sun.com/news/detail.jsp?id="+CommonString.getFormatPara(oneNews.get("id"));
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
        			<a href="detail.jsp?id=<%=CommonString.getFormatPara(m.get("id")) %>" target="_blank"><%=CommonString.getFormatPara(m.get("title")) %></a>
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
          <div id="bdshare" class="bdshare_t bds_tools get-codes-bdshare">
          <span class="bds_more">分享到：</span>
          <a class="bds_tsina"></a>
          <a class="bds_qzone"></a>
          <a class="bds_tqq"></a>
          <a class="bds_renren"></a>
          <a class="bds_t163"></a>
          <a class="bds_kaixin001"></a>
          <a class="bds_tsohu"></a>
          </div>
          <script type="text/javascript" id="bdshare_js" data="type=tools&amp;uid=537258" ></script>
          <script type="text/javascript" id="bdshell_js"></script>
          <script type="text/javascript">
          document.getElementById("bdshell_js").src = "http://bdimg.share.baidu.com/static/js/shell_v2.js?cdnversion=" + Math.ceil(new Date()/3600000)
          </script>
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
    
    <div class="newsLeftpart nlp02 mb10">
      <div class="title">
        <h3>经销商推荐</h3>
        <span class="more"><a href="http://product.21-sun.com/agent/" target="_blank">更多&gt;&gt;</a></span>
      </div>
      
      <div class="agent_li">
        <div class="agent_li" id="agent_info"> 
          <!-- 代理商信息 --> 
        </div>
        <div class="paging page" id="agent_page" style="float: right;margin-right:5px;"> 
          <!-- ajax分页 --> 
        </div>
      </div>
    </div>
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
  <div class="newsListRight">
    <div class="w100 l mb10" style="display: none;"><a href="#"><img src="../images/news_img08.jpg" width="240" height="80" /></a></div>
    <div class="w100 l mb10" style="display: none;"><a href="#"><img src="../images/news_img09.jpg" width="240" height="80" /></a></div>
    <div class="newsRightpart nrp01 mb10">
      <div class="title">
        <h3><%=product_id.equals("")?"最新产品图片":"关联产品图片" %></h3>
        <span class="more"><a href="/photo/list.jsp" target="_blank">更多&gt;&gt;</a></span>
      </div>
      <div class="content">
        <ul class="list">
    <%
		 String sel_pic_sql = "select top 8 id,img2,add_date,factoryname,catalogname,name from pro_products where img2 is not null and img2 != '' order by newid()";
		 List<Map> newPics = null ;
		 if(!"".equals(product_id) && null!=productMap){
			sel_pic_sql = "select id,img2,add_date,factoryname,catalogname,name from pro_products where id=?  union all select top 5 id,img2,add_date,factoryname,catalogname,name from pro_products where factoryid=? and catalognum=?" ;
			 newPics = dbHelper.getMapList(sel_pic_sql,new Object[]{product_id,CommonString.getFormatPara(productMap.get("factoryid")),CommonString.getFormatPara(productMap.get("catalognum"))}, conn_21sun);
		}else{
			 newPics = dbHelper.getMapList(sel_pic_sql,conn_21sun);
		}
		if (null != newPics && newPics.size() > 0) {
		for (Map oneMap : newPics) {
		%>
          <li> <a	href="/photo/detail_for_<%=CommonString.getFormatPara(oneMap.get("id"))%>.htm" target="_blank" title="<%=CommonString.getFormatPara(oneMap.get("factoryname")) + CommonString.getFormatPara(oneMap.get("catalogname"))
								+ CommonString.getFormatPara(oneMap.get("name"))%>">
          <img 	alt=" <%=CommonString.getFormatPara(oneMap.get("factoryname")) + CommonString.getFormatPara(oneMap.get("catalogname"))
								+ CommonString.getFormatPara(oneMap.get("name"))%>" src="/uploadfiles/<%=CommonString.getFormatPara(oneMap.get("img2"))%>" onerror="this.src='/images/nopic.gif'" width="90" height="60" />
            <h3>
            <%= CommonString.getFormatPara(oneMap.get("name"))+CommonString.getFormatPara(oneMap.get("catalogname"))
								%>
								</h3>
            </a> </li>
          <%
				}
				}
			%>
        </ul>
      </div>
    </div>
    <div class="newsRightpart nrp02 mb10">
      <div class="title">
        <h3>最新看看</h3>
        <span class="more"><a href="http://video.21-sun.com/" target="_blank">更多&gt;&gt;</a></span>
      </div>
      <div class="content">
        <ul class="list">
           <%
				String sel_video_sql = "select top 3 * from article where sort_num like '%,869,%' and  is_pub=1 and is_del=0 and flag=3 and area_flag<>4 order by newid() ";
				List<Map> videoList = WEBDBHelper.getMapList(sel_video_sql, "Web21sunDBHelper");
				if (null != videoList && videoList.size() > 0) {
				for (Map oneMap : videoList) {
				%>
			    <li> <a href="<%=CommonString.getFormatPara(oneMap.get("link_other")) %>" target="_blank">
			    <img src="http://news.21-sun.com/UserFiles/Image/<%=CommonString.getFormatPara(oneMap.get("image")) %>" onerror="this.src='/images/nopic.gif'" width="90" height="50" />
			   <h3 style="height:48px;"><%=CommonString.getFormatPara(oneMap.get("title")) %></h3>
			   </a> </li>
          <%
			}
				}
			%>
        </ul>
      </div>
    </div>
    <div class="w100 l mb10" style="display: none;"><a href="#"><img src="../images/news_img10.jpg" width="240" height="200" /></a></div>
    <div class="w100 l mb10" style="display: none;"><a href="#"><img src="../images/news_img11.jpg" width="240" height="200" /></a></div>
    <div class="w100 l mb10" style="display: none;"><a href="#"><img src="../images/news_img12.jpg" width="240" height="200" /></a></div>
    <div class="clear"></div>
    <div class="newsRightpart nrp03 mb10" id="tophistory">
      <div class="title">
        <h3>最近浏览过的产品 <a href="javascript:;" onclick="clearHistory();"><font color='red'>清空</font></a></h3>
      </div>
      <div class="content">
        <ul class="list" id="history">
        </ul>
      </div>
    </div>
    <%
    	 if(!"".equals(product_id)){
    		 String sel_other_sql = " select top 6 pro.price_end,id,img2,add_date,factoryname,catalogname,name,file_name from pro_products_view_relation rela left join pro_products pro on rela.other_product_id = pro.id where rela.product_id=? order by newid()" ;
    		List<Map> otherList = dbHelper.getMapList(sel_other_sql,new Object[]{product_id},conn_21sun) ;
    	 	if(null!=otherList && otherList.size()>0){
    	 		%>
    <div class="clear"></div>  
    <div class="newsRightpart nrp03 mb10">
      <div class="title">
        <h3>看过该产品的还看过</h3>
      </div>
      <div class="content">
        <ul class="list">
         <%
         	for(Map oneMap:otherList){
         		%>
         <li><a href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")) %>" target="_blank">
        <img width="90" height="50" onerror="this.src='/images/nopic.gif'" src="<%="/uploadfiles/"+CommonString.getFormatPara(oneMap.get("img2")) %>" />
        <h3> <%=CommonString.getFormatPara(oneMap.get("factoryname"))+CommonString.getFormatPara(oneMap.get("name"))+CommonString.getFormatPara(oneMap.get("catalogname")) %></h3>
        <span class="price">参考价:<%=(CommonString.getFormatPara(oneMap.get("price_end")).equals("")||CommonString.getFormatPara(oneMap.get("price_end")).equals("0"))?"面议":(CommonString.getFormatPara(oneMap.get("price_end"))+"万") %></span>
        </a></li>
         <%
         	}
         %>
        </ul>
      </div>
    </div>
    	 		<%
    	 	}
    	 }
    %>
    <div class="clear"></div>  
    <div class="newsRightpart nrp04 mb10">
      <div class="title">
        <h3>相关二手机</h3>
       <span class="more">
        <a href="http://www.21-used.com/equipment/" target="_blank">更多>></a>
        </span>
      </div>
      <div class="content">
        <ul class="list">
          <%
		String sel_sql_used = "select top 5 eq.id,eq.province,eq.model,brand.brand_name,eq.price from dbo.used_equipment eq  left join used_brand brand on eq.brand_id=brand.id where eq.category_id=1 and eq.is_pub=1 order by eq.id desc";
		List<Map> usedVehicle = WEBDBHelper.getMapList(sel_sql_used,"Web21usedDBHelper") ;
		if (null != usedVehicle && usedVehicle.size() > 0) {
			for (Map oneMap : usedVehicle) {   
							%>
          <li class="t-d">
            <h3 class="n01"> <a href="http://www.21-used.com/equipment/equipmentdetail_for_<%=CommonString.getFormatPara(oneMap.get("id"))%>.htm" target="_blank"><%=CommonString.getFormatPara(oneMap.get("brand_name")) + CommonString.getFormatPara(oneMap.get("model")) + "挖掘机"%></a> </h3>
           <span class="n02"><%=CommonString.getFormatPara(oneMap.get("province"))%></span> <span class="n03"><%=((CommonString.getFormatPara(oneMap.get("price")).equals("0.00")||CommonString.getFormatPara(oneMap.get("price")).equals("0")) ? "面议" :( "￥"+CommonString.getFormatPara(oneMap.get("price")))+"万")%></span><div class="clear"></div></li>
          <%
								}
									}
							%>
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
