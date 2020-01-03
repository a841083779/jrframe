<%@ page language="java" import="org.json.*,java.net.*,java.sql.Connection,java.util.*,com.jerehnet.util.dbutil.*,com.jerehnet.util.common.*,com.jerehnet.webservice.*" pageEncoding="UTF-8"%><%
	String id = CommonString.getFormatPara(request.getParameter("id")) ;  // 新闻 id 
	String t_flag = CommonString.getFormatPara(request.getParameter("t_flag")) ;
	Map brandMap = (HashMap)application.getAttribute("brandMap") ;
	Map brandMap2 = (HashMap)application.getAttribute("brandMap2") ;
	String whereStr = " where id="+id+" and is_pub=1" ;
	String sel_sql = " select * from article "+whereStr ;
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
		String product_brand = CommonString.getFormatPara(oneNews.get("product_brand"));
		String factoryId = CommonString.getFormatPara(brandMap2.get(oneNews.get("product_brand")));
		Map factoryMap = null; 
		List<Map> articleList = null ;
		String factoryName = "";
		String factorycatalogName = "";
		String factorypro_brand_title = "";
		String factorylogo = "";
		String factoryurl = "";
		String factorytelphone="";
		String usern="";
		if(factoryId!=null && !factoryId.equals("")){
			String factory_sql = "select is_made,pro_brand_title, is_qijiandian,usern,is_shop,id,name,is_shop,logo,full_name,introduce,mobile,url,img1,telphone,banner,create_date,master,weibo,email from pro_agent_factory where id = '"+factoryId+"' and is_show=1 and flag=1" ;
			factoryMap = dbHelper.getMap(factory_sql);
			usern = CommonString.getFormatPara(factoryMap.get("usern"));
			factoryName = CommonString.getFormatPara(factoryMap.get("name"));
			factorypro_brand_title = CommonString.getFormatPara(factoryMap.get("pro_brand_title"));
			factorylogo = CommonString.getFormatPara(factoryMap.get("logo"));
			factoryurl = CommonString.getFormatPara(factoryMap.get("url")); 
			factorytelphone = CommonString.getFormatPara(factoryMap.get("telphone")); 
		}else{
			response.setStatus(HttpServletResponse.SC_NOT_FOUND);
			Common.doForward(request,response,"/404.htm");
		}
		
		String newContent = CommonString.getFormatPara(CommonHtml.filterHTML(oneNews.get("content").toString()));
		if(newContent.length()>80){newContent=newContent.substring(0,80)+"...";}
%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<html xmlns:wb="http://open.weibo.com/wb">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><%=CommonString.getFormatPara(oneNews.get("title")) %> - 铁臂<%=factoryName %>专区</title>
<meta name="keywords" content="<%=CommonString.getFormatPara(oneNews.get("keyword")).replace("-", ",") %>" />
<meta name="description" content="<%=newContent %>" />
<link href="/style/style.css" rel="stylesheet" type="text/css" />
<link href="/brandshow/style/brands.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="/scripts/jquery.min.js"></script>
<script src="http://tjs.sjs.sinajs.cn/open/api/js/wb.js" type="text/javascript" charset="utf-8"></script>
</head>
<body>
<!--top-->
<jsp:include page="/include/top.jsp" flush="true"/>
<!--top end-->
<div class="contain980 fix">
  <div class="s_brand_logo">
    <img src="http://product.21-sun.com/uploadfiles/<%=factorylogo %>" alt="<%=factoryName %>" width="120" height="50" class="s_img" /><strong class="s_n"><h1><%=factoryName %></h1></strong>
  </div>
  <div class="s_mainSite"><a href="<%=factoryurl %>" target="_blank">访问官网</a></div>
  <div class="s_tel"><%=factoryName %>品牌客服电话：<b><%=factorytelphone %></b></div>
</div>
<div class="s_navBar">
  <div class="contain980">
    <ul class="fix">
      <li><a href="/"><%=factoryName %>首页</a></li>
      <li><a href="/intro.htm"><%=factoryName %>简介</a></li>
      <li class="selected"><a href="/news.htm"><%=factoryName %>动态</a></li>
      <li><a href="#"><%=factoryName %>人物</a></li>
      <li><a href="/product_list.htm"><%=factoryName %>产品</a></li>
      <li><a href="/comment_list.htm"><%=factoryName %>口碑</a></li>
      <li><a href="/agent_list.htm"><%=factoryName %>代理商</a></li>
    </ul>
  </div>
</div>
<div class="contain980 mb10 mt10">
  <div class="breadCrumbs"><a href="/">铁臂<%=factoryName %>专区</a> &gt;&gt; <a href="/news.htm"><%=factoryName %>动态</a> &gt;&gt; <%=CommonString.getFormatPara(oneNews.get("title")) %></div>
</div>
<div class="s_main fix pt15">
  <!--left-->
  <div class="contain980 fix">
    <div class="s_mleft">
      <div class="listleft02_1">
        <div class="listtitle01_1">
          <h1><%=CommonString.getFormatPara(oneNews.get("title")) %></h1>
        </div>
        <div class="listtitle03_2">
        <%
        String pub_date = CommonString.getFormatPara(oneNews.get("pub_date"));
        %>
          <font class="font08">发布时间:<%=pub_date.length()>10?pub_date.substring(0,10):pub_date %>  &nbsp;&nbsp;&nbsp;&nbsp;来源:
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
        			<a href="http://product.21-sun.com/" target="_blank">铁臂商城</a>
        			<%
        		}
        	%>
		</font>
        </div>
        <%
        	String content = CommonString.getFormatPara(oneNews.get("content"));
        	content = content.replaceAll("\\.\\./\\.\\./","/");
        	content = content.replaceAll("/UserFiles/Image/","http://news.21-sun.com/UserFiles/Image/");
        	content = content.replaceAll("/tech/uploadfiles/","http://www.21-sun.com/tech/uploadfiles/");
        %>
        <div class="detail" id="mainDetail">
         　　<%=content %> <br>
          <div class="listfoot01"> <a href="http://<%=usern %>.brand.21-sun.com/">返回首页</a></div>
          <!-- JiaThis Button BEGIN -->
          <div style="width:240px;height:30px;padding:15px 0 5px 0px; float:left;">
            <div id="ckepop"><span class="jiathis_txt">分享到：</span> <a class="jiathis_button_tsina"></a> <a class="jiathis_button_tqq"></a> <a class="jiathis_button_weixin"></a> <a class="jiathis_button_qzone"></a> <a class="jiathis_button_xiaoyou"></a> <a class="jiathis_button_t163"></a> <a class="jiathis_button_baidu"></a> <a href="http://www.jiathis.com/share?uid=1554525" class="jiathis jiathis_txt jiathis_separator jtico jtico_jiathis" target="_blank"></a> 
              <!--<a class="jiathis_counter_style"></a>--> 
            </div>
          </div>
          <script type="text/javascript" >
          var jiathis_config={
				data_track_clickback:true,
	          summary:" ",
	          ralateuid:{
	          "tsina":"1904756027"
	          },
	          appkey:{
	          "tsina":"709719509"
	          },
	          hideMore:false
          }
          </script> 
          <script type="text/javascript" src="http://v2.jiathis.com/code/jia.js?uid=1554525" charset="utf-8"></script> 
          <!-- JiaThis Button END -->
          
          <div class="detail_news_keywords">
            <div id="mark_old">
            关键词：<a href="/" class="link06"><%=factoryName %></a>
            </div>
          </div>
        </div>
        <div class="listfoot02">
          <div style="float:right;width:55%;height:29px;line-height:29px">【<img src="http://product.21-sun.com/brandshow/images/tb01.gif" width="18" height="11" /><a href="javascript:storePage();" class="pl">收藏此页</a>】【<img src="http://product.21-sun.com/brandshow/images/tb03.gif" width="16" height="12" /><a href="Javascript:window.print();" >打印</a>】【<img src="http://product.21-sun.com/brandshow/images/tb04.gif" width="12" height="9" /><a href="javascript:window.close()">关闭</a>】 </div>
        </div>
        
        <div>
          <div class="redian-title00">
            <div class="title3">相关动态</div>
          </div>
          <div class="listnews001">
            <ul class="qushitext">
            <%
        	List<Map> news = WEBDBHelper.getMapList(" select top 16 title,id,link_other from article where product_brand ='"+product_brand+"'  order by pub_date desc ","Web21sunDBHelper");
        	if(null!=news){
        		for(Map m : news){
        			if("".equals(CommonString.getFormatPara(m.get("link_other")))||"null".equals(CommonString.getFormatPara(m.get("link_other")))){
        	%>
        		<li class="listnews006_ads">·<a target="_blank" title="<%=CommonString.getFormatPara(m.get("title")) %>" href="news_detail_<%=CommonString.getFormatPara(m.get("id")) %>.htm"><%=CommonString.getFormatPara(m.get("title")) %></a></li>
        		<%
        		}else{
        		%>
        		 <li class="listnews006_ads">·<a href="<%=CommonString.getFormatPara(m.get("link_other")) %>" target="_blank"><%=CommonString.getFormatPara(m.get("title")) %></a></li>
        	
        	<%	
        		}}}
        	%>
             
            </ul>
          </div>
        </div>
        
      </div>
    </div>
    <!--right-->
    <div class="s_right">
    	<!--agent-->
    		<%String add = "/brandshow/"+usern+"/right.htm"; %>  
        	<jsp:include page="<%=add %>" />
		<!--agent end-->
    </div>
  </div>
</div>
<!--top-->
<jsp:include page="/include/foot.jsp" flush="true"/>
<!--top end-->
</body>
<script type="text/javascript" src="/scripts/scripts.js"></script>
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