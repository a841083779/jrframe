<%@ page language="java" import="java.sql.Connection,com.jerehnet.webservice.*,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.PageBean,com.jerehnet.util.dbutil.DBHelper,com.jerehnet.util.common.CommonString,java.util.*" pageEncoding="UTF-8"%>
<%
	DBHelper dbHelper = DBHelper.getInstance() ;
	String agentId = "174";//卡特

	//小挖
	List<Map>litleProList = dbHelper.getMapList(" select top 4 factoryname,name,catalogname_spe,img2,id,factoryid_sub,file_name,introduce from pro_products where is_show=1 and factoryid=? and catalognum like '%101001%' and tonandmeter <20 order by hot_num desc,id desc",new Object[]{agentId}) ;
	//中挖
	List<Map>middleProList = dbHelper.getMapList(" select top 4 factoryname,name,catalogname_spe,img2,id,factoryid_sub,file_name,introduce from pro_products where is_show=1 and factoryid=? and catalognum like '%101001%' and tonandmeter between 20 and 30 order by hot_num desc,id desc",new Object[]{agentId}) ;
	//大挖
	List<Map>largeProList = dbHelper.getMapList(" select top 4 factoryname,name,catalogname_spe,img2,id,factoryid_sub,file_name,introduce from pro_products where is_show=1 and factoryid=? and catalognum like '%101001%' and tonandmeter > 30 order by hot_num desc,id desc",new Object[]{agentId}) ;
	//hot
	List<Map>hotProList = dbHelper.getMapList(" select top 10 factoryname,name,catalogname_spe,img2,id,factoryid_sub,file_name,introduce from pro_products where is_show=1 and factoryid=? and catalognum like '%101001%' and zoomlion_hot=11 order by hot_num desc,id desc",new Object[]{agentId}) ;
	
	//rec
	List<Map>recProList = dbHelper.getMapList(" select top 6 factoryname,name,catalogname_spe,img2,id,factoryid_sub,file_name,introduce from pro_products where is_show=1 and factoryid=? and catalognum like '%101001%' and is_rec=1 order by hot_num desc,id desc",new Object[]{agentId}) ;
	
	List<Map> newsList =null;						
	newsList= WEBDBHelper.getMapList("select top 7 title,id from article where is_pub=1 and title like '%卡特%' order by id desc","Web21NewsDBHelper");

%>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="author" content="design by www.21-sun.com" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<title>卡特挖掘机_卡特挖掘机价格 - 铁臂商城卡特彼勒(Cat)专区</title>
<meta name="Keywords" content="卡特挖掘机,卡特挖掘机型号,卡特挖掘机价格,卡特挖掘机报价" />
<meta name="Description" content="铁臂商城卡特彼勒(Cat)专区是世界最大的挖掘机生产厂家之一卡特彼勒公司旗下的Cat电商平台,提供卡特挖掘机型号，卡特挖掘机价格方面内容，了解最新卡特挖机报价相关信息登录铁臂商城卡特彼勒专区。" />
<link href="style/style.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="scripts/jquery.min.js"></script>
<script type="text/javascript" src="scripts/jquery.SuperSlide.js"></script>
<script src="scripts/tabs.js" type="text/javascript"></script>
<script src="/scripts/scripts.js" type="text/javascript"></script>
<!--[if (IE 6)]>
<script src="scripts/iepng.js" type="text/javascript"></script>
<script type="text/javascript">
   EvPNG.fix('.png'); 
</script>
<![endif]-->
<style>
.con3 ul.list li .info{padding: 3px 0px;}
.con3 ul.list li .info h3{font-size:12px;}
</style>
</head>
<body>
<!--卡特曝光-->
<!--top--begin-->

<div class="top">
	
  <div class="top_up mb20">
  <!--
    <div class="wrap">
      <h3>卡特彼勒配件中国区唯一官方合作网络营销平台</h3>
      <div class="logIn">您好，欢迎进入卡特彼勒配件营销平台！<strong> 登陆 | 免费注册 |</strong> 在线收藏 | 安全保障 </div>
    </div>
     -->
  </div>
  <div class="wrap top_down clearfix">
    <div class="logo"><a href="http://product.21-sun.com/cat"><img style="float:left" src="images/logo.jpg" alt="卡特彼勒挖掘机电商平台"/>
	
	<div style="float:right;font-size: 18px;font-family: 'MicroSoft YaHei';float:right">电商平台</div><h1 style="font-size: 18px;font-family: 'MicroSoft YaHei';float:right">卡特彼勒挖掘机</h1>
	
	</a></div>
    <!-- 
    <div class="search">
      <div class="searchBox clearfix">
        <input type="text" class="searchTxt" />
        <input type="button" value="搜索" class="search_btn"/>
      </div>
      <div class="keywords"> <span>热搜：</span><a href="#" target="_blank">313D系列2</a><a href="#" target="_blank">306E</a><a href="#" target="_blank">307E</a><a href="#" target="_blank">320DGC</a> </div>
    </div>
    -->
  </div>
</div>


<div class="nav_bg">
  <ul class="clearfix">
    <li class="category"> <span class="n">全部产品分类 <i></i></span>
      <div class="con1_left">
	  
	  
 <dl>
        <dt><a href="list.jsp?flag=grab_1_19" target="_blank">Cat<sup>&reg;</sup>小型挖掘机&gt;</a></dt>
        <dd class="menu"> <a href="detail.jsp?id=31806" target="_blank">新一代CAT®301.5挖掘机</a><br />
          <a href="detail.jsp?id=31919" target="_blank">新一代CAT®307.5挖掘机</a><br />
          <a href="detail.jsp?id=31920" target="_blank">新一代CAT®308.5挖掘机</a> </dd>
      </dl>
      <dl >
        <dt><a href="list.jsp?flag=grab_20_30" target="_blank">Cat<sup>&reg;</sup>中型挖掘机&gt;</a></dt>
        <dd class="menu"> <a href="detail.jsp?id=30220" target="_blank">新一代CAT®320挖掘机</a><br />
          <a href="detail.jsp?id=31913" target="_blank">新一代CAT®330挖掘机</a><br />
          <a href="detail.jsp?id=31918" target="_blank">新一代CAT®330 GC挖掘机 </a> </dd>
      </dl>
      <dl>
        <dt><a href="list.jsp?flag=grab_30_1" target="_blank">Cat<sup>&reg;</sup>大型挖掘机&gt;</a></dt>
        <dd class="menu"> <a href="detail.jsp?id=31828" target="_blank">新一代CAT®336挖掘机</a><br />
          <a href="detail.jsp?id=31829" target="_blank">新一代CAT®336 GC挖掘机</a><br />
            <a href="detail.jsp?id=31914" target="_blank">新一代CAT®345 GC挖掘机</a>
		  </dd>
      </dl>
      <a href="order.jsp" target="_blank" class="xunjia"></a>
    
	</div>
    </li>
    <li><a href="index.jsp">首　　页</a></li>
    <li><a href="list.jsp">产　　品</a> <i class="newIcon"></i></li>
    <li><a href="order.jsp" target="_blank">预约试机</a></li>
	<li><a href="http://zhuanti.21-sun.com/cat2019_1212/" target="_blank">配　　件</a></li>
		<li><a href="h5.htm" >互动专区</a></li>

	<!--
    <li><a href="active.jsp">活动专题</a></li>
	-->
  </ul>
</div>
<!--top--end-->
<div class="wrap con">
  <div class="con1">
    <div class="con1_left">
      <dl>
        <dt><a href="list.jsp?flag=grab_1_19" target="_blank">Cat<sup>&reg;</sup>小型挖掘机&gt;</a></dt>
        <dd class="menu"> <a href="detail.jsp?id=31806" target="_blank">新一代CAT®301.5挖掘机</a><br />
          <a href="detail.jsp?id=31919" target="_blank">新一代CAT®307.5挖掘机</a><br />
          <a href="detail.jsp?id=31920" target="_blank">新一代CAT®308.5挖掘机</a> </dd>
      </dl>
      <dl >
        <dt><a href="list.jsp?flag=grab_20_30" target="_blank">Cat<sup>&reg;</sup>中型挖掘机&gt;</a></dt>
        <dd class="menu"> <a href="detail.jsp?id=30220" target="_blank">新一代CAT®320挖掘机</a><br />
          <a href="detail.jsp?id=31913" target="_blank">新一代CAT®330挖掘机</a><br />
          <a href="detail.jsp?id=31918" target="_blank">新一代CAT®330 GC挖掘机 </a> </dd>
      </dl>
      <dl>
        <dt><a href="list.jsp?flag=grab_30_1" target="_blank">Cat<sup>&reg;</sup>大型挖掘机&gt;</a></dt>
        <dd class="menu"> <a href="detail.jsp?id=31828" target="_blank">新一代CAT®336挖掘机</a><br />
          <a href="detail.jsp?id=31829" target="_blank">新一代CAT®336 GC挖掘机</a><br />
            <a href="detail.jsp?id=31914" target="_blank">新一代CAT®345 GC挖掘机</a>
		  </dd>
      </dl>
      <a href="order.jsp" target="_blank" class="xunjia"></a> </div>
    <div class="con1_mid">
      <div class="effect">
        <div id="slideBox2" class="slideBox2">
          <div class="hd">
            <ul>
              <li></li>

            </ul>
          </div>
          <div class="bd">
            <ul>
              <li><a href="http://product.21-sun.com/proDetail/320GC.shtm" target="_blank" title="卡特"><img src="images/bb.jpg" /></a></li>
            </ul>
          </div>
        </div>
        <script type="text/javascript">jQuery(".slideBox2").slide( { mainCell:".bd ul",autoPlay:true,delayTime:1000} );</script>
      </div>
    </div>
    <!-- <div class="option clearfix"> <span class="choose"><a href="#" target="_blank">新闻与活动</a></span> <span><a href="#" target="_blank">优惠政策</a></span> </div>-->
    <div class="con1_right">
      <div class="TabTitle clearfix">
        <ul id="myTab">
          <li class="active" onclick="nTabs(this,0);">新闻与活动</li>
          <li class="normal" onclick="nTabs(this,1);">优惠政策</li>
        </ul>
      </div>
      <div class="TabContent">
        <div id="myTab_Content0">
          <ul>
		    
		    <%
		        if(newsList != null && newsList.size()>0){
	  		        for(Map oneMap:newsList){
						String title=CommonString.getFormatPara(oneMap.get("title")).replace("^R","®").replace("^r","®");
						if(title.length()>=30){title=title.substring(0,30)+"...";}
			%>
		    <li style="margin-top:10px"><a href="news_detail.jsp?id=<%=CommonString.getFormatPara(oneMap.get("id"))%>" target="_blank"><%=title%></a></li>
			<%}}%>
			
          </ul>
        </div>
        <ul id="myTab_Content1" class="none">
          <li ><a href="news_detail_yh.jsp?id=338" target="_blank">专为挑战而生 卡特彼勒发布349D2 重型挖掘机</a></li>
          <li ><a href="news_detail_yh.jsp?id=307" target="_blank">终极对决，更胜一筹——卡特挖掘机油耗更低、效率更高</a></li>
          <li ><a href="news_detail_yh.jsp?id=280" target="_blank">发布梦想蓝图，赢Cat(卡特)海外工厂参观之旅！</a></li>
          <li ><a href="news_detail_yh.jsp?id=279" target="_blank">卡特用户试驾初体验： 卡特312D2 GC 低油耗、高效益</a></li>
          <li class="last"><a href="news_detail_yh.jsp?id=278" target="_blank">深度剖析卡特彼勒312D2 GC履带式挖掘机</a></li>
        </ul>
      </div>
    </div>
  </div>
  <div class="con2 mb15">
    <div class="con_title Yh18"> <span>New新品推荐</span>
      <!-- <a href="#" target="_blank">更多&gt;&gt;</a> -->
    </div>
    <ul class=" clearfix">
      <li><a href="detail.jsp?id=31806" target="_blank" title="CAT®301.5挖掘机"><img src="images/2018/1.png" alt="CAT®301.5挖掘机"/></a></li>
      <li><a href="detail.jsp?id=31919" target="_blank" title="CAT®307.5挖掘机"><img src="images/2018/2.png" alt="CAT®307.5挖掘机"/></a></li>
      <li><a href="detail.jsp?id=31913" target="_blank" title="CAT® 330挖掘机"><img src="images/2018/3.png" alt="CAT® 330挖掘机"/></a></li>
      <li><a href="detail.jsp?id=31828" target="_blank" title="CAT® 336挖掘机"><img src="images/2018/4.png" alt="CAT® 336挖掘机"/></a></li>
    </ul>
  </div>
  <div class="con3 mb15">
    <div class="con_title Yh18"> <span>Sales促销产品</span>
      <!--<a href="#" target="_blank">更多&gt;&gt;</a>-->
    </div>
    <div class="item clearfix">
      <div class="img">
        <!--  <a href="#" target="_blank"><img src="images/cat1_21.jpg" /></a>-->
        <div class="effect">
          <div id="slideBox3" class="slideBox3">
            <div class="hd">
              <ul>
                <li></li>
              </ul>
            </div>
            <div class="bd">
              <ul>
                <li><a href="detail.jsp?id=31913" target="_blank" title="CAT® 330挖掘机"><img src="images/2018/5.png" alt="CAT® 330挖掘机" /></a></li>
              </ul>
            </div>
          </div>
          <script type="text/javascript">jQuery(".slideBox3").slide( { mainCell:".bd ul",autoPlay:true,delayTime:1000} );</script>
        </div>
      </div>
      <ul class="list">
	    <%
		if(recProList != null && recProList.size()>0){
	  		for(Map oneMap:recProList){
	  			String id = CommonString.getFormatPara(oneMap.get("id"));
    			String file_name = CommonString.getFormatPara(oneMap.get("file_name"));
    			String img2 = CommonString.getFormatPara(oneMap.get("img2"));
    			String factoryname = CommonString.getFormatPara(oneMap.get("factoryname"));
    			String name = CommonString.getFormatPara(oneMap.get("name")).replace("^R","®").replace("^r","®");
    			String catalogname = CommonString.getFormatPara(oneMap.get("catalogname"));
    			String factoryid_sub = CommonString.getFormatPara(oneMap.get("factoryid_sub"));
      
      %>
        <li> <a href="detail.jsp?id=<%=id %>" target="_blank" title="<%=factoryname %><%=name %><%=catalogname %>"><img src="http://product.21-sun.com/uploadfiles/<%=img2 %>" alt="<%=factoryname %><%=name %><%=catalogname %>" style="width:210px;height:178px;"/></a>
          <div class="info clearfix">
            <h3><a class="recommend" href="detail.jsp?id=<%=id %>" target="_blank" title="<%=factoryname %><%=name %><%=catalogname %>"><%=name%></a></h3>
            <a href="order.jsp?id=<%=id %>" target="_blank" class="wyxj">我要询价</a> </div>
        </li>
      <%}} %>  
      </ul>
    </div>
  </div>
  <div class="con4 mb30">
    <div class="con_title Yh18 clearfix"> <span>Hot热卖产品</span> <a href="list.jsp" target="_blank">更多&gt;&gt;</a> </div>
    <div class="leftLoop mb20">
      <div class="bd">
        <ul class="picList">
          <%
		if(hotProList != null && hotProList.size()>0){
	  		for(Map oneMap:hotProList){
	  			String id = CommonString.getFormatPara(oneMap.get("id"));
    			String file_name = CommonString.getFormatPara(oneMap.get("file_name"));
    			String img2 = CommonString.getFormatPara(oneMap.get("img2"));
    			String factoryname = CommonString.getFormatPara(oneMap.get("factoryname"));
    			String name = CommonString.getFormatPara(oneMap.get("name")).replace("^R","®").replace("^r","®");
    			String catalogname = CommonString.getFormatPara(oneMap.get("catalogname"));
    			String factoryid_sub = CommonString.getFormatPara(oneMap.get("factoryid_sub"));
      
      %>
          <li>
            <div class="pic"> <a href="detail.jsp?id=<%=id %>" target="_blank" title="<%=factoryname %><%=name %><%=catalogname %>"><img src="http://product.21-sun.com/uploadfiles/<%=img2 %>" width="181" height="156" alt="<%=factoryname %><%=name %><%=catalogname %>"/></a>
              <div class="hot-icon"><img src="images/hot.gif" width="46" height="45"/></div>
            </div>
            <div class="info">
              <h3><a class="recommend" href="detail.jsp?id=<%=id %>" target="_blank" title="<%=factoryname %><%=name %><%=catalogname %>"><%=name %></a></h3>
              <a href="order.jsp?id=<%=id %>" target="_blank" class="wyxj">我要询价</a> </div>
          </li>
          <%}} %>   
        </ul>
      </div>
      <div class="hd"> <a class="next"></a>
        <ul>
        </ul>
        <a class="prev"></a> </div>
    </div>
    <div><a href="detail.jsp?id=31828" target="_blank"><img src="images/2018/6.jpg" /></a></div>
  </div>
  <div class="con5 mb15">
    <div class="con_title Yh18 clearfix"> <span>Cat<sup>&reg;</sup>小型挖掘机</span> <a href="list.jsp?flag=grab_1_19" target="_blank">更多&gt;&gt;</a> </div>
    <ul class=" clearfix">
      
      <%
		if(litleProList != null && litleProList.size()>0){
	  		for(Map oneMap:litleProList){
	  			String id = CommonString.getFormatPara(oneMap.get("id"));
    			String file_name = CommonString.getFormatPara(oneMap.get("file_name"));
    			String img2 = CommonString.getFormatPara(oneMap.get("img2"));
    			String factoryname = CommonString.getFormatPara(oneMap.get("factoryname"));
    			String name = CommonString.getFormatPara(oneMap.get("name")).replace("^R","®").replace("^r","®");
    			String catalogname = CommonString.getFormatPara(oneMap.get("catalogname"));
    			String factoryid_sub = CommonString.getFormatPara(oneMap.get("factoryid_sub"));
    			String introduce = CommonString.getFormatPara(oneMap.get("introduce"));
      
      %>
      <li>
        <div class="img"><a href="detail.jsp?id=<%=id %>" target="_blank" title="<%=factoryname %><%=name %><%=catalogname %>"><img  onerror="showImgDelay(this,'/cat/images/zwtp.jpg',2);"  src="http://product.21-sun.com/uploadfiles/<%=img2 %>" style="width:235px;height:178px;" alt="<%=factoryname %><%=name %><%=catalogname %>" /></a></div>
        <a href="detail.jsp?id=<%=id %>#param" target="_blank" class="a1 aa">参数</a> <a href="detail.jsp?id=<%=id %>#intro" target="_blank" class="a2 aa">介绍</a> <a href="detail.jsp?id=<%=id %>#inquirys" target="_blank" class="a3 aa">询价单</a>
        <div class="price"> <a href="detail.jsp?id=<%=id %>" target="_blank" title="<%=factoryname %><%=name %><%=catalogname %>">
          <h3><%=name %><%=catalogname %></h3>
          </a> </div>
        <a href="order.jsp?id=<%=id %>" target="_blank" class="aaa wyxj">我要询价</a> </li>
      <%}} %>
      
    </ul>
  </div>
  <div class="con5 mb15">
    <div class="con_title Yh18 clearfix"> <span>Cat<sup>&reg;</sup>中型挖掘机</span> <a href="list.jsp?flag=grab_20_30" target="_blank">更多&gt;&gt;</a> </div>
    <ul class=" clearfix">
      <%
		if(middleProList != null && middleProList.size()>0){
	  		for(Map oneMap:middleProList){
	  			String id = CommonString.getFormatPara(oneMap.get("id"));
    			String file_name = CommonString.getFormatPara(oneMap.get("file_name"));
    			String img2 = CommonString.getFormatPara(oneMap.get("img2"));
    			String factoryname = CommonString.getFormatPara(oneMap.get("factoryname"));
    			String name = CommonString.getFormatPara(oneMap.get("name")).replace("^R","®").replace("^r","®");
    			String catalogname = CommonString.getFormatPara(oneMap.get("catalogname"));
    			String factoryid_sub = CommonString.getFormatPara(oneMap.get("factoryid_sub"));
    			String introduce = CommonString.getFormatPara(oneMap.get("introduce"));
      
      %>
      <li>
        <div class="img"><a href="detail.jsp?id=<%=id %>" target="_blank" title="<%=factoryname %><%=name %><%=catalogname %>"><img onerror="showImgDelay(this,'/cat/images/zwtp.jpg',2);"  src="http://product.21-sun.com/uploadfiles/<%=img2 %>" style="width:235px;height:178px;" alt="<%=factoryname %><%=name %><%=catalogname %>" /></a></div>
        <a href="detail.jsp?id=<%=id %>#param" target="_blank" class="a1 aa">参数</a> <a href="detail.jsp?id=<%=id %>#intro" target="_blank" class="a2 aa">介绍</a> <a href="detail.jsp?id=<%=id %>#inquirys" target="_blank" class="a3 aa">询价单</a>
        <div class="price"> <a href="detail.jsp?id=<%=id %>" target="_blank" title="<%=factoryname %><%=name %><%=catalogname %>">
          <h3><%=name %><%=catalogname %></h3>
          </a> </div>
        <a href="order.jsp?id=<%=id %>" target="_blank" class="aaa wyxj">我要询价</a> </li>
      <%}} %>
      
    </ul>
  </div>
  <div class="con5 mb15">
    <div class="con_title Yh18 clearfix"> <span>Cat<sup>&reg;</sup>大型挖掘机</span> <a href="list.jsp?flag=grab_30_1" target="_blank">更多&gt;&gt;</a> </div>
    <ul class=" clearfix">
      
      <%
		if(largeProList != null && largeProList.size()>0){
	  		for(Map oneMap:largeProList){
	  			String id = CommonString.getFormatPara(oneMap.get("id"));
    			String file_name = CommonString.getFormatPara(oneMap.get("file_name"));
    			String img2 = CommonString.getFormatPara(oneMap.get("img2"));
    			String factoryname = CommonString.getFormatPara(oneMap.get("factoryname"));
    			String name = CommonString.getFormatPara(oneMap.get("name")).replace("^R","®").replace("^r","®");
    			String catalogname = CommonString.getFormatPara(oneMap.get("catalogname"));
    			String factoryid_sub = CommonString.getFormatPara(oneMap.get("factoryid_sub"));
    			String introduce = CommonString.getFormatPara(oneMap.get("introduce"));
      
      %>
      <li>
        <div class="img"><a href="detail.jsp?id=<%=id %>" target="_blank" title="<%=factoryname %><%=name %><%=catalogname %>"><img onerror="showImgDelay(this,'/cat/images/zwtp.jpg',2);"  src="http://product.21-sun.com/uploadfiles/<%=img2 %>" style="width:235px;height:178px;" alt="<%=factoryname %><%=name %><%=catalogname %>" /></a></div>
        <a href="detail.jsp?id=<%=id %>#param" target="_blank" class="a1 aa">参数</a> <a href="detail.jsp?id=<%=id %>#intro" target="_blank" class="a2 aa">介绍</a> <a href="detail.jsp?id=<%=id %>#inquirys" target="_blank" class="a3 aa">询价单</a>
        <div class="price"> <a href="detail.jsp?id=<%=id %>" target="_blank" title="<%=factoryname %><%=name %><%=catalogname %>">
          <h3><%=name %><%=catalogname %></h3>
          </a> </div>
        <a href="order.jsp?id=<%=id %>" target="_blank" class="aaa wyxj">我要询价</a> </li>
      <%}} %>
      
    </ul>
  </div>
  <!--
  <div class="activity mb15">
    <div class="con_title Yh18 clearfix"> <span>Activity活动专题</span> <a href="active.jsp" target="_blank">更多&gt;&gt;</a> </div>
    <ul class="clearfix">
      <li><a rel="nofollow" href="http://www.catwaji.com/plan/?utm_source=catwaji_p&utm_medium=owned&utm_content=150211008&utm_campaign=1503_BCPPLAN " target="_blank" title="创富"><img src="images/activity01.gif" alt="创富"/></a></li>
      <li><a rel="nofollow" href="http://www.catwaji.com/2015_repurchase_caring/index.html?utm_source=catwaji&utm_medium=owned&utm_content=kv&utm_campaign=catclub_2014 " target="_blank" title="大黄靴回家"><img src="images/activity02.gif" /></a></li>
      <li><a href="list.jsp?flag=grab_1_19" target="_blank" title="卡特“创富中国梦”大赛，赢取卡特E系列小挖6个月免费使用权"><img src="images/kal2.jpg" alt="卡特“创富中国梦”大赛，赢取卡特E系列小挖6个月免费使用权"/></a></li>
      <li><a rel="nofollow" href="http://www.wajueji.com/service/detail_for_48764.htm" target="_blank" title="卡特专家走进你身边，大家一起来寻“宝”"><img src="images/3331.jpg" alt="卡特专家走进你身边，大家一起来寻“宝”"/></a></li>
    </ul>
  </div>
  -->
  <!--foot--begin-->
  
<div class="foot clearfix mb15">
    <dl>
      <dt>产品系列</dt>
      <dd><a href="list.jsp?tonandmeter=grab_1_19" target="_blank">小型挖掘机</a></dd>
      <dd><a href="list.jsp?tonandmeter=grab_20_30" target="_blank">中型挖掘机</a></dd>
      <dd><a href="list.jsp?tonandmeter=grab_30_1" target="_blank">大型挖掘机</a></dd>
    </dl>
    <dl>
      <dt>服务与体验</dt>
      <dd><a href="http://catparts.com.cn/" target="_blank" rel="nofollow">零件与服务</a></dd>
    </dl>
    <dl>
      <dt>新闻与活动</dt>
      <dd><a href="news.jsp?flag=news" target="_blank">行业资讯</a></dd>
      <dd><a href="news.jsp?flag=pre" target="_blank">卡特新闻与活动</a></dd>
    </dl>
    <dl>
      <dt>热销型号</dt>
      <dd><a href="detail.jsp?id=23912" target="_blank">卡特彼勒306E2小型挖掘机</a></dd>
      <dd><a href="detail.jsp?id=29164" target="_blank">卡特彼勒307E2小型挖掘机</a></dd>
      <dd><a href="detail.jsp?id=30221" target="_blank">卡特彼勒Cat®320GC挖掘机</a></dd>
      <dd><a href="detail.jsp?id=30220" target="_blank">卡特彼勒Cat®320挖掘机</a></dd>
      <dd> <a href="detail.jsp?id=30219" target="_blank">卡特彼勒Cat®323挖掘机 </a></dd>
    </dl>
  </div>
  <div class="New_foot">
  Copyright &copy; 2000-<script type="text/javascript">document.write((new Date()).getFullYear());</script>
	<span class="New_links" onclick="window.open('http://www.21-sun.com');">中国工程机械商贸网</span> | 制作维护
  </div>
  <div style="display:none;">
  <script src="http://s13.cnzz.com/stat.php?id=5786967&web_id=5786967" language="JavaScript"></script>
  <script src="http://s85.cnzz.com/stat.php?id=5100957&web_id=5100957" language="JavaScript"></script>
  
  
  
  <script type="text/javascript">
var _smq = _smq || [];
_smq.push(['_setAccount', '58af85d', new Date()]);
_smq.push(['_setHeatmapEnabled', 'no']);
_smq.push(['_setUrlParam', 'smt_e', '_e360_uid', '_e360_campaignid', '_e360_groupid', '_e360_creativeid', '_e360_keywordid']);
_smq.push(['pageview']);
 
(function() {
var so = document.createElement('script'); so.type = 'text/javascript'; so.async = true;
so.src = 'http://stat.e.tf.360.cn/search/c.js?u=968805521,968805521';
var e = document.getElementsByTagName('script')[0]; e.parentNode.insertBefore(so, e);
})();
 
(function() {
var sm = document.createElement('script'); sm.type = 'text/javascript'; sm.async = true;
sm.src = ('https:' == document.location.protocol ? 'https://' : 'http://') + 'cdnmaster.com/sitemaster/sm360.js';
var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(sm, s);
})();


</script>
<script type="text/javascript">
var _bdhmProtocol = (("https:" == document.location.protocol) ? " https://" : " http://");
document.write(unescape("%3Cscript src='" + _bdhmProtocol + "hm.baidu.com/h.js%3Fbbb14afeeac6a868b9709cf8e0c171be' type='text/javascript'%3E%3C/script%3E"));
</script>
<script src='http://stat.e.tf.360.cn/search/c.js?u=968805521' language='JavaScript' ></script><script src='http://pw.cnzz.com/tongji_360.php?id=1201858776&pid=e360&l=2' language='JavaScript' charset='gb2312'></script> 
  </div>
  <script>
(function(){
    var bp = document.createElement('script');
    bp.src = '//push.zhanzhang.baidu.com/push.js';
    var s = document.getElementsByTagName("script")[0];
    s.parentNode.insertBefore(bp, s);
})();
</script>
  
  
  

  <!--foot--end-->
</div>
<script type="text/javascript" src="scripts/comm.js"></script>
<script type="text/javascript">
jQuery(".leftLoop").slide({ titCell:".hd ul",mainCell:".bd ul",effect:"leftLoop",vis:5,scroll:1,autoPage:false,autoPlay:true,delayTime:1000});
</script>
<div style="display:none"><img src="http://g.cn.miaozhen.com/x/k=2004866&p=6sjZZ&dx=0&rt=2&ns=__IP__&ni=__IESID__&v=__LOC__&o=" width="1" height="1" border="0"></div>
<script>
    var ref = ''; 
    if (document.referrer.length > 0) { 
        ref = document.referrer; 
    } 
    try { 
       if (ref.length == 0 && opener.location.href.length > 0) { 
       ref = opener.location.href; 
        } 
    }catch (e) {}
   	jQuery.ajax({
    	type:'post',
    	url:'ajax.jsp',
    	data:{flag:'visitHistory',ref:ref} ,
    	success:function(msg){
    	}
    });
</script>
</body>
</html>