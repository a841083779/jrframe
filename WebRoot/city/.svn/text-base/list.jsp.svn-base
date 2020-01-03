<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<%@ page import="org.apache.solr.common.SolrDocumentList"%>
<%@ page import="org.apache.solr.common.SolrDocument"%>
<%@ page import="org.apache.solr.client.solrj.response.QueryResponse"%>
<%@ page import="org.apache.solr.client.solrj.SolrQuery"%>
<%@ page import="org.apache.solr.client.solrj.impl.HttpSolrServer"%>
<%@ page language="java" import="java.sql.Connection,java.util.*,com.jerehnet.util.common.*,com.jerehnet.webservice.*" pageEncoding="UTF-8"%>
<%@ page import="com.jerehnet.util.dbutil.DBHelper"%>
<%@ taglib uri="/WEB-INF/classes/oscache.tld" prefix="cache"%>
<cache:cache cron="* * */4 * *">
<%
	DBHelper dbHelper = DBHelper.getInstance() ;
	//获取地区参数,用的是地区的拼音
	String parentNum=""; String childNum="";
	String areapy = CommonString.getFormatPara(request.getParameter("areapy"));
	Map area = (Map)dbHelper.getMap(" select name,num,parent_num,areapy from pro_agent_province_city where areapy = '"+ areapy +"'") ;
	String areaName = CommonString.getFormatPara(area.get("name"));
	String areaNum = CommonString.getFormatPara(area.get("num"));
	parentNum=areaNum;
	childNum="0";
	String areaparentNum = CommonString.getFormatPara(area.get("parent_num"));
	String areaIsParentpy = CommonString.getFormatPara(area.get("areapy"));
	Map mapParent = (Map)dbHelper.getMap(" select areapy,num from pro_agent_province_city where num = '"+ areaparentNum +"'") ;//查询上层拼音
	if(mapParent != null){
			areaIsParentpy = areapy;
			areapy = CommonString.getFormatPara(mapParent.get("areapy"));
			parentNum=CommonString.getFormatPara(mapParent.get("num"));
			childNum=areaNum;
	}else{
		areaIsParentpy = "0";
	}
	//询价单
	List<Map> product_form_list = dbHelper.getMapList("select top 6 id,province,city,name,add_date,factoryname,product_name,cataname as catalogname "
			+"from pro_product_form "
			+" where is_deleted = 0 and province = '" + areaName + "' order by id desc");	// and cataname = '挖掘机'
	//新闻
    List<Map> news_list=WEBDBHelper.getMapList("select top 21 id,title,pub_date,content,image from article where is_pub=1 and image is not null and title like '%"+areaName+"%' order by pub_date desc","Web21sunDBHelper") ;
	String case_news_title ="";	
	String case_news_id ="";
	//巡展图
    List<Map> news_pic_list=WEBDBHelper.getMapList("select top 3 id,title,pub_date,content,image from article where is_pub = 1 and len(image)<> 0 and image<> '' and title like '%"+areaName+"%' order by pub_date desc","Web21sunDBHelper") ;
	//地区商铺
	List<Map> agent_factory_list = dbHelper.getMapList("select top 3 * from pro_agent_factory where flag=2 and is_show=1 and city like '%" + areaName + "%' order by is_shop desc,flag ASC , name DESC , id DESC");	//and title like '%" + areaName + "%'
	//产品列表//catanum
	List<Map> wajue_product_list = dbHelper.getMapList("select top 4 * from pro_products where is_show = 1 and catalognum like '101001%' order by view_count desc");//挖掘机
	List<Map> zhuagnzai_product_list = dbHelper.getMapList("select top 4 * from pro_products where is_show = 1 and catalognum like '101002%' order by view_count desc");//装载机
	List<Map> qizhong_product_list = dbHelper.getMapList("select top 4 * from pro_products where is_show = 1 and catalognum like '102%' order by view_count desc");//起重机
	List<Map> yalu_product_list = dbHelper.getMapList("select top 4 * from pro_products where is_show = 1 and catalognum like '106001%' order by view_count desc");//压路机
	String citys = "'北京','上海','广州','天津','杭州','深圳','济南','南京','福州','青岛','苏州','东莞','太原','宁波','佛山','海口','合肥','南昌','长春','成都','郑州'";//,'呼和浩特'
	/*
	List<Map> hotcitypyList = (List<Map>)dbHelper.getMapList("SELECT a.name,CASE when b.areapy is null then a.areapy else b.areapy end parent_areapy from pro_agent_province_city a "+ 
			"LEFT JOIN pro_agent_province_city b  on a.parent_num=b.num "+
			"where a.name in ("+citys+")") ;
   */			
	List<Map> hotcitypyList = (List<Map>)dbHelper.getMapList("SELECT name,areapy  from pro_agent_province_city "+"where name in ("+citys+")") ;	
    //Map brandMap = (Map) application.getAttribute("brandMap");
	Map catalogMap = (Map) application.getAttribute("catalogMap");
	//String catalog = CommonString.getFormatInt(request.getParameter("catalog")).toString();
%>
<!doctype html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><%=areaName%>挖掘机_<%=areaName%>装载机_<%=areaName%>工程机械报价 – 铁臂城市</title>
<meta name="keywords" content="<%=areaName%>挖掘机,<%=areaName%>装载机,<%=areaName%>工程机械报价" />
<meta name="description" content="铁臂城市，为您提供全面的<%=areaName%>工程机械信息，包括<%=areaName%>挖掘机信息，<%=areaName%>载机信息，<%=areaName%>热销工程机械产品报价，方便您在<%=areaName%>找到心仪的产品，买工程机械产品就上铁臂商城。" />
<meta name="renderer" content="webkit">
<meta name="author" content="design by www.21-sun.com">
<link href="http://product.21-sun.com/style/style.css" rel="stylesheet" />
<link href="http://product.21-sun.com/style/city.css" rel="stylesheet" />
<link href="http://product.21-sun.com/agent_new/style/style.css" rel="stylesheet" />

<script type="text/javascript" src="/scripts/jquery.min.js"></script>
<script type="text/javascript" src="/scripts/common.js"></script>
<script type="text/javascript" src="/scripts/scripts.js"></script>
<script type="text/javascript" src="/scripts/jBox-v2.3/jquery.jBox-2.3.min.js"></script>
<script type="text/javascript" src="/scripts/jBox-v2.3/i18n/jquery.jBox-zh-CN.js"></script>
<link type="text/css" rel="stylesheet" href="/scripts/jBox-v2.3/Skins2/Blue/jbox.css" />

<script type="text/javascript">
//导航选中状态
var jrChannel='3#0'
</script>
</head>
<body>
<!--top-->
<jsp:include page="/include/top.jsp" flush="true" />
<!--top end-->
<div class="contain980 mb10">
  <h3 class="breadCrumbs"><a href="/">铁臂城市 </a> &gt;&gt; <a href="http://city.21-sun.com/<%=areapy%>/"><%=areaName%></a></h3>
</div>
<div class="contain980 fix">
  <div class="city_all fix">
    <p class="ct1">全国分站</p>
    <ul class="ctlist">
	<%
		if (null != hotcitypyList && hotcitypyList.size() > 0) {
			for (Map m:hotcitypyList) {
				String hotcityname = CommonString.getFormatPara(m.get("name"));
				String hotcitypy = CommonString.getFormatPara(m.get("areapy"));
	%>
    	<li><a target="_blank" href="http://city.21-sun.com/<%=hotcitypy%>/"><%=hotcityname %></a></li>
    <%}}%>    
      <li style="background:none;"><a href="http://city.21-sun.com/">345个城市</a></li>
    </ul>
  </div>
  <div class="agent_area fix mt10 citybrand_list">
    <!-- ====================================================== -->
<jsp:include page="brand_factory.jsp" flush="true" />
    <!-- ====================================================== -->
  </div>
  <div class="fix city_news mt10">
  	<div class="cy_left fix">
    	<div class="clhd fix">
        	<h3><%=areaName%> 今日热门</h3>
            <span class="more"><a href="http://news.21-sun.com/" title="更多<%=areaName%>今日热门信息">更多 &gt;&gt;</a></span>
        </div>
        <div class="clbd fix">
          <div class="cl_slide">
          	<div class="bd">
            	<ul>
									
				<%if(news_pic_list != null && news_pic_list.size()>0){
					for(Map m: news_pic_list){
							String pic_id = CommonString.getFormatPara(m.get("id"));
							String pic_image = CommonString.getFormatPara(m.get("image"));
							String title= CommonString.getFormatPara(m.get("title"));
							if(title.length() > 30){title=title.substring(0,30)+"**";}
				%>
                	<li>
                    	<a href="http://product.21-sun.com/news/detail.jsp?id=<%=pic_id%>" title="<%=title%>" target="_blank">
                    		<p class="cl_img"><img src="http://news.21-sun.com/UserFiles/Image/<%=pic_image%>" alt="<%=title%>"/></p>
                        	<p class="cl_name"><%=title%></p>
                        </a>
                    </li>
				<%}}%>				
					
                </ul>
            </div>
            <div class="hd">
            	<ul></ul>
            </div>
          </div>
          <div class="cl_newslist">
	<%
	if(news_list!=null&&news_list.size()>0){
	%>	  
    <div class="clnews_val">
    <%	
        for(int i=0;i<= news_list.size()-1; i++){
		case_news_title = CommonString.getFormatPara(news_list.get(i).get("title"));
		case_news_id = CommonString.getFormatPara(news_list.get(i).get("id"));
		if(i==0){
	%>
<div class="cltopnew"><a href="http://product.21-sun.com/news/detail.jsp?id=<%=case_news_id%>" title="<%=case_news_title%>"><%=case_news_title%></a></div>
   <%}}%> 
<ul class="fix clnews_vlist">
    <%	
        for(int i=0;i<= news_list.size()-1; i++){
		case_news_title = CommonString.getFormatPara(news_list.get(i).get("title"));
		case_news_id = CommonString.getFormatPara(news_list.get(i).get("id"));
		if(i>=1&&i<=6){
	%>
				<li><a href="http://product.21-sun.com/news/detail.jsp?id=<%=case_news_id%>" title="<%=case_news_title%>"><%=case_news_title%></a></li>
   <%}}%>
  </ul>
</div>
<%}%>	  


	<%
	if(news_list!=null&&news_list.size()>7){
	%>	  
    <div class="clnews_val">
    <%	
        for(int i=7;i<= news_list.size()-1; i++){
		case_news_title = CommonString.getFormatPara(news_list.get(i).get("title"));
		case_news_id = CommonString.getFormatPara(news_list.get(i).get("id"));
		if(i==7){
	%>
<div class="cltopnew"><a href="http://product.21-sun.com/news/detail.jsp?id=<%=case_news_id%>" title="<%=case_news_title%>"><%=case_news_title%></a></div>
   <%}}%> 
<ul class="fix clnews_vlist">
    <%	
        for(int i=7;i<= news_list.size()-1; i++){
		case_news_title = CommonString.getFormatPara(news_list.get(i).get("title"));
		case_news_id = CommonString.getFormatPara(news_list.get(i).get("id"));
		if(i>=8&&i<=13){
	%>
				<li><a href="http://product.21-sun.com/news/detail.jsp?id=<%=case_news_id%>" title="<%=case_news_title%>"><%=case_news_title%></a></li>
   <%}}%>
  </ul>
</div>
<%}%>	




	<%
	if(news_list!=null&&news_list.size()>14){
	%>	  
    <div class="clnews_val">
    <%	
        for(int i=14;i<= news_list.size()-1; i++){
		case_news_title = CommonString.getFormatPara(news_list.get(i).get("title"));
		case_news_id = CommonString.getFormatPara(news_list.get(i).get("id"));
		if(i==14){
	%>
<div class="cltopnew"><a href="http://product.21-sun.com/news/detail.jsp?id=<%=case_news_id%>" title="<%=case_news_title%>"><%=case_news_title%></a></div>
   <%}}%> 
<ul class="fix clnews_vlist">
    <%	
        for(int i=14;i<= news_list.size()-1; i++){
		case_news_title = CommonString.getFormatPara(news_list.get(i).get("title"));
		case_news_id = CommonString.getFormatPara(news_list.get(i).get("id"));
		if(i>=15&&i<=21){
	%>
				<li><a href="http://product.21-sun.com/news/detail.jsp?id=<%=case_news_id%>" title="<%=case_news_title%>"><%=case_news_title%></a></li>
   <%}}%>
  </ul>
</div>
<%}%>	
         </div>
        </div>
    </div>
    <div class="cy_right">
    	<div class="hd fix">
          <h3><%=areaName%>最新询价单</h3>
          <span class="more"><a href="http://product.21-sun.com/inquiry/<%=areapy%>_0_0_0_0.shtm" title="更多<%=areaName%>最新询价单">更多</a></span>
        </div>
        <div class="bd fix">
            <ul>
			<%
				if (null != product_form_list && product_form_list.size() > 0) {
						for (Map m:product_form_list) {
							String subscribe_province = CommonString.getFormatPara(m.get("province"));
							String subscribe_city = CommonString.getFormatPara(m.get("city"));
							String subscriber_name = CommonString.getFormatPara(m.get("name"));
							if(subscriber_name.length()>1){subscriber_name=subscriber_name.substring(0,1)+"**";}
							String subscribe_id = CommonString.getFormatPara(m.get("id"));
							String add_date = CommonDate.getFormatDate("MM-dd", m.get("add_date"));
							String subscribe_factoryname = CommonString.getFormatPara(m.get("factoryname"));						
							String subscribe_product_name = CommonString.getFormatPara(m.get("product_name"));						
							String subscribe_catalogname = CommonString.getFormatPara(m.get("catalogname"));						
			%>
				<li style="width:195px;"> 
				<span class="ltitle"><%=subscribe_province%><%=subscribe_city%><%if (subscribe_city != null){%>"市<%}%>的<%=subscriber_name%>** 询：</span> 
				<span class="r" style="white-space:nowrap"><%=add_date%></span> <span class="linfo"> <a href="/inquiry/detail_for_<%=subscribe_id%>.htm" target="_blank">
				<font title="<%=subscribe_factoryname + subscribe_product_name + subscribe_catalogname %>"><%=subscribe_factoryname + subscribe_product_name + subscribe_catalogname %></font>的价格</a></span> 
				</li>
            <%}} %>
            </ul>
          </div>
    </div>
  </div>
  <div class="city_pro fix">
  
  
  
  
  
	<%if(wajue_product_list != null && wajue_product_list.size()>0){%>
  	<div class="city_pro_val">
        <div class="hd fix">
            <h3 class="cpro_t"><%=areaName%>挖掘机推荐</h3>
            <span class="more"><a href="http://product.21-sun.com/products/prolist.jsp?catalog=101001" title="更多<%=areaName%>挖掘机推荐">更多 &gt;&gt;</a></span>
        </div>
        <div class="bd">
        	<ul class="city_prolist fix">
			<%
						for (Map m:wajue_product_list) {
							String pro_factoryname = CommonString.getFormatPara(m.get("factoryname"));
							String pro_name = CommonString.getFormatPara(m.get("name"));
							String pro_catalogname = CommonString.getFormatPara(m.get("catalogname"));
							if(pro_name.length()>18){pro_name=pro_name.substring(0,18)+"**";}
							String pro_file_name = CommonString.getFormatPara(m.get("file_name"));
							String pro_file_name_replace = pro_file_name.replace(".shtm","");
							String pro_img2 = CommonString.getFormatPara(m.get("img2"));			
							String pro_price_start = CommonString.getFormatPara(m.get("price_start"));			
							String pro_price_end = CommonString.getFormatPara(m.get("price_end"));			
			%>
            	<li>
                	<div class="cp_img"><a href="http://product.21-sun.com/proDetail/<%=pro_file_name%>" title="<%=pro_factoryname+pro_name+pro_catalogname%>" target="_blank">
                	<img src="http://product.21-sun.com/uploadfiles/<%=pro_img2%>" alt="<%=pro_name%>"/></a></div>
                    <div class="cp_name"><a href="http://product.21-sun.com/proDetail/<%=pro_file_name%>" title="<%=pro_factoryname+pro_name+pro_catalogname%>" target="_blank">
                    <%=pro_factoryname+pro_name+pro_catalogname%></a></div>
                    <div class="cp_price">参考价：
                    <span>
                    <%if(pro_price_start != null && pro_price_end != null && !pro_price_start.equals("0") && !pro_price_end.equals("0") ){%>
                    	<%=pro_price_start%>~<%=pro_price_end%>万
                    <%}else{ %>
                    	暂无
                    <%}%>
                    </span>
                    </div>
                    <div class="cp_gn"><span>【<a href="http://product.21-sun.com/proDetail/<%=pro_file_name%>">参数</a>】</span><span>【<a href="http://product.21-sun.com/proDetail/<%=pro_file_name%>#sentComment">评论</a>】</span><span class="prgp">【<a href="http://product.21-sun.com/inquiry/detail_for_<%=pro_file_name_replace%>.htm" >询价</a>】</span></div>
                </li>
             <%}%>   
            </ul>
        </div>
    </div>
	<%}%>
	
	
	
	
	<%if(zhuagnzai_product_list != null && zhuagnzai_product_list.size()>0){%>
  	<div class="city_pro_val">
        <div class="hd fix">
            <h3 class="cpro_t"><%=areaName%>装载机推荐</h3>
            <span class="more"><a href="http://product.21-sun.com/products/prolist.jsp?catalog=101002" title="更多<%=areaName%>装载机推荐">更多 &gt;&gt;</a></span>
        </div>
        <div class="bd">
        	<ul class="city_prolist fix">
			<%
						for (Map m:zhuagnzai_product_list) {
							String pro_factoryname = CommonString.getFormatPara(m.get("factoryname"));
							String pro_name = CommonString.getFormatPara(m.get("name"));
							String pro_catalogname = CommonString.getFormatPara(m.get("catalogname"));
							if(pro_name.length()>18){pro_name=pro_name.substring(0,18)+"**";}
							String pro_file_name = CommonString.getFormatPara(m.get("file_name"));
							String pro_file_name_replace = pro_file_name.replace(".shtm","");
							String pro_img2 = CommonString.getFormatPara(m.get("img2"));			
							String pro_price_start = CommonString.getFormatPara(m.get("price_start"));			
							String pro_price_end = CommonString.getFormatPara(m.get("price_end"));			
			%>
            	<li>
                	<div class="cp_img"><a href="http://product.21-sun.com/proDetail/<%=pro_file_name%>" title="<%=pro_factoryname+pro_name+pro_catalogname%>" target="_blank">
                	<img src="http://product.21-sun.com/uploadfiles/<%=pro_img2%>" alt="<%=pro_factoryname+pro_name+pro_catalogname%>"/></a></div>
                    <div class="cp_name"><a href="http://product.21-sun.com/proDetail/<%=pro_file_name%>" title="<%=pro_factoryname+pro_name+pro_catalogname%>" target="_blank"><%=pro_factoryname+pro_name+pro_catalogname%></a></div>
                    <div class="cp_price">参考价：<span>
                    <%if(pro_price_start != null && pro_price_end != null && !pro_price_start.equals("0") && !pro_price_end.equals("0") ){%>
                    	<%=pro_price_start%>~<%=pro_price_end%>万
                    <%}else{ %>
                    	暂无
                    <%}%>
					</span></div>
                    <div class="cp_gn"><span>【<a href="http://product.21-sun.com/proDetail/<%=pro_file_name%>">参数</a>】</span><span>【<a href="http://product.21-sun.com/proDetail/<%=pro_file_name%>#sentComment">评论</a>】</span><span class="prgp">【<a href="http://product.21-sun.com/proDetail/<%=pro_file_name_replace%>_order.shtm" >询价</a>】</span></div>
                </li>
             <%}%>   
            </ul>
        </div>
    </div>
	<%}%>
	
	
	
	
	
	
	<%if(qizhong_product_list != null && qizhong_product_list.size()>0){%>
  	<div class="city_pro_val">
        <div class="hd fix">
            <h3 class="cpro_t"><%=areaName%>起重机推荐</h3>
            <span class="more"><a href="http://product.21-sun.com/products/prolist.jsp?catalog=102" title="更多<%=areaName%>起重机推荐">更多 &gt;&gt;</a></span>
        </div>
        <div class="bd">
        	<ul class="city_prolist fix">
			<%
						for (Map m:qizhong_product_list) {
							String pro_factoryname = CommonString.getFormatPara(m.get("factoryname"));
							String pro_name = CommonString.getFormatPara(m.get("name"));
							String pro_catalogname = CommonString.getFormatPara(m.get("catalogname"));
							if(pro_name.length()>18){pro_name=pro_name.substring(0,18)+"**";}
							String pro_file_name = CommonString.getFormatPara(m.get("file_name"));
							String pro_file_name_replace = pro_file_name.replace(".shtm","");
							String pro_img2 = CommonString.getFormatPara(m.get("img2"));			
							String pro_price_start = CommonString.getFormatPara(m.get("price_start"));			
							String pro_price_end = CommonString.getFormatPara(m.get("price_end"));			
			%>
            	<li>
                	<div class="cp_img"><a href="http://product.21-sun.com/proDetail/<%=pro_file_name%>" title="<%=pro_factoryname+pro_name+pro_catalogname%>" target="_blank"><img src="http://product.21-sun.com/uploadfiles/<%=pro_img2%>" alt="<%=pro_factoryname+pro_name+pro_catalogname%>"/></a></div>
                    <div class="cp_name"><a href="http://product.21-sun.com/proDetail/<%=pro_file_name%>" title="<%=pro_factoryname+pro_name+pro_catalogname%>" target="_blank"><%=pro_factoryname+pro_name+pro_catalogname%></a></div>
                    <div class="cp_price">参考价：<span>
					<%if(pro_price_start != null && pro_price_end != null && !pro_price_start.equals("0") && !pro_price_end.equals("0") ){%>
                    	<%=pro_price_start%>~<%=pro_price_end%>万
                    <%}else{ %>
                    	暂无
                    <%}%>
					</span></div>
                    <div class="cp_gn">
                    <span>【<a href="http://product.21-sun.com/proDetail/<%=pro_file_name%>">参数</a>】</span>
                    <span>【<a href="http://product.21-sun.com/proDetail/<%=pro_file_name%>#sentComment">评论</a>】</span>
                    <span class="prgp">【<a href="http://product.21-sun.com/proDetail/<%=pro_file_name_replace%>_order.shtm" >询价</a>】</span></div>
                </li>
             <%}%>   
            </ul>
        </div>
    </div>
	<%}%>
	
	
	
	
	
	
	
	
	
	

	<%if(yalu_product_list != null && yalu_product_list.size()>0){%>
  	<div class="city_pro_val">
        <div class="hd fix">
            <h3 class="cpro_t"><%=areaName%>压路机推荐</h3>
            <span class="more"><a href="http://product.21-sun.com/products/prolist.jsp?catalog=106001" title="更多<%=areaName%>压路机推荐">更多 &gt;&gt;</a></span>
        </div>
        <div class="bd">
        	<ul class="city_prolist fix">
			<%
						for (Map m:yalu_product_list) {
							String pro_factoryname = CommonString.getFormatPara(m.get("factoryname"));
							String pro_name = CommonString.getFormatPara(m.get("name"));
							String pro_catalogname = CommonString.getFormatPara(m.get("catalogname"));
							if(pro_name.length()>18){pro_name=pro_name.substring(0,18)+"**";}
							String pro_file_name = CommonString.getFormatPara(m.get("file_name"));
							String pro_file_name_replace = pro_file_name.replace(".shtm","");
							String pro_img2 = CommonString.getFormatPara(m.get("img2"));			
							String pro_price_start = CommonString.getFormatPara(m.get("price_start"));			
							String pro_price_end = CommonString.getFormatPara(m.get("price_end"));			
			%>
            	<li>
                	<div class="cp_img"><a href="http://product.21-sun.com/proDetail/<%=pro_file_name%>" title="<%=pro_factoryname+pro_name+pro_catalogname%>" target="_blank"><img src="http://product.21-sun.com/uploadfiles/<%=pro_img2%>" alt="<%=pro_name%>"/></a></div>
                    <div class="cp_name"><a href="http://product.21-sun.com/proDetail/<%=pro_file_name%>" title="<%=pro_factoryname+pro_name+pro_catalogname%>" target="_blank"><%=pro_factoryname+pro_name+pro_catalogname%></a></div>
                    <div class="cp_price">参考价：<span>
					<%if(pro_price_start != null && pro_price_end != null && !pro_price_start.equals("0") && !pro_price_end.equals("0") ){%>
                    	<%=pro_price_start%>~<%=pro_price_end%>万
                    <%}else{ %>
                    	暂无
                    <%}%>
					</span></div>
                    <div class="cp_gn"><span>【<a href="http://product.21-sun.com/proDetail/<%=pro_file_name%>">参数</a>】</span><span>【<a href="http://product.21-sun.com/proDetail/<%=pro_file_name%>#sentComment">评论</a>】</span><span class="prgp">【<a href="http://product.21-sun.com/proDetail/<%=pro_file_name_replace%>_order.shtm" >询价</a>】</span></div>
                </li>
             <%}%>   
            </ul>
        </div>
    </div>
	<%}%>
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
  <%if(agent_factory_list != null && agent_factory_list.size()>0){%>
    <div class="city_pro_val city_dls">
        <div class="hd fix">
            <h3 class="cpro_t"><%=areaName%>代理商</h3>
            <span class="more"><a href="http://dealer.21-sun.com/<%=parentNum%>_<%=childNum%>_0_0_0.shtm" target="_blank" title="更多<%=areaName%>代理商">更多<%=areaName%>代理商 &gt;&gt;</a></span>
        </div>
		<div class="bd fix s_company">
		<ul class="fix">  
		
			<%
			for(Map m : agent_factory_list){ 
				String agent_factory_full_name = CommonString.getFormatPara(m.get("full_name"));	
				String agent_factory_address = CommonString.getFormatPara(m.get("address"));	
				String agent_factory_telephone = CommonString.getFormatPara(m.get("telephone"));//city_tel	
				String agent_factory_fax = CommonString.getFormatPara(m.get("fax"));
				String agent_factory_agent_fac_name = CommonString.getFormatPara(m.get("agent_fac_name"));
				String agent_factory_agent_usern = CommonString.getFormatPara(m.get("usern"));
				String agent_factory_agent_city = CommonString.getFormatPara(m.get("city"));
				String agent_factory_agent_city_all = CommonString.getFormatPara(m.get("city"));
				if(agent_factory_agent_city.length() > 22){agent_factory_agent_city=agent_factory_agent_city.substring(0,22)+"...";}
				if(agent_factory_full_name.length() > 22){agent_factory_full_name=agent_factory_full_name.substring(0,22)+"...";}
				if(agent_factory_address.length() > 20){agent_factory_address=agent_factory_address.substring(0,20)+"...";}
			
			%>
        <li>
          <a href="http://dealer.21-sun.com/<%=agent_factory_agent_usern %>/" target="_blank" class="n" title="<%=agent_factory_full_name%>"><%=agent_factory_full_name%></a>
          <span class="area" title="<%=agent_factory_agent_city_all%>"><%= (agent_factory_agent_city == null || agent_factory_agent_city.length() <= 0) ? areaName : agent_factory_agent_city%> </span>
          <div class="text">
            代理品牌：<%=agent_factory_agent_fac_name%><br>
            电话：<%=agent_factory_telephone%><br>
            传真：<%=agent_factory_fax%><br>
            地址：<%=agent_factory_address%>
          </div>
          <a class="btn" href="http://dealer.21-sun.com/<%=agent_factory_agent_usern %>/" target="_blank">进入店铺</a>
        </li>
        <%}%>
      </ul>
		</div>
    </div>
  <%}%>
	
	
	
	
	
	
  </div>
</div>
<!--foot-->
<div class="foot_box">
  <jsp:include page="/include/foot.jsp" flush="true" />
</div>
<!--foot end-->
</body>
<script type="text/javascript" src="/scripts/idTabs.js"></script>
<script type="text/javascript" src="/scripts/jquery.SuperSlide.js"></script>
<script type="text/javascript">
$(".cl_slide").slide({ titCell:".hd ul", mainCell:".bd ul",effect:"leftLoop",vis:1,scroll:1,autoPlay:true,autoPage:true,interTime:4000});
</script>
<script type="text/javascript">
$(".idTabs").idTabs("!mouseover");
</script>
<script type="text/javascript">
$('.clnews_vlist li:odd').css('border','none');
</script>
</html>
</cache:cache>