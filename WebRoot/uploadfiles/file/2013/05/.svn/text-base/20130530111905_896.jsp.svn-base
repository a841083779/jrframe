<%@ page language="java" import="java.text.NumberFormat,org.json.*,com.jerehnet.util.common.*,com.jerehnet.lucene.*,com.jerehnet.lucene.impl.*" pageEncoding="UTF-8"%><%
	String flag = CommonString.getFormatPara(request.getParameter("f"));
	JSONObject jsonObject = null;
	JSONArray arrays = null;
	ISearch iSearch = null;
	if("used".equals(flag)){
		iSearch = new Web21UsedSearchSellImpl();
	}else if("product".equals(flag)){
		iSearch = new Web21ProductSearchProductImpl();
	}else{
		iSearch = new MultipleSearchImpl();
	}
	String keywords = CommonString.getFormatPara(request.getParameter("q"));
	if("".equals(keywords)){
		keywords = "挖掘机";
	}
	String nowPageStr = CommonString.getFormatPara(request.getParameter("p"));
	Integer nowPage = 1;
	Integer pageSize  = 10;
	if(!"".equals(nowPageStr)){
		nowPage = CommonString.getFormatInt(nowPageStr);
	}
	String rs =  iSearch.doSearch(keywords,nowPage,pageSize);
	jsonObject = new JSONObject(rs);
	arrays = jsonObject.getJSONArray("list");
	//相关词
	RelatedUtils relatedUtils = new RelatedUtils();
	Integer all = CommonString.getFormatInt(jsonObject.get("all"));
	NumberFormat numberFormat = NumberFormat.getNumberInstance();
	String allStr = numberFormat.format(all);
	JSONArray xiang_guang_ci_arr = relatedUtils.getRelated(keywords);
%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta name="author" content="design by www.21-sun.com" />
	<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
	<title>21搜</title>
	<link href="/style/search.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="/plugin/jquery/jquery.min.js"></script>
</head>
<body>
<div class="search_topLinks">
  <div class="l pl20"><a href="http://www.21-sun.com/">21-sun首页</a></div>
  <div class="r pr20"><a href="javascript:void(0);">客服中心</a> <a href="http://aboutus.21-sun.com/map.htm">网站导航</a></div>
</div>
<div class="search_top">
  <h2><a href="http://www.21-sun.com/"><img src="/images/search_logo.gif" alt="中国工程机械商贸网" /></a></h2>
  <div class="search_contain">
    <ul class="category">
      <li><a href="javascript:void(0);" f="all" class="f_all">综合</a></li>
      <li><a href="javascript:void(0);" f="news" class="f_news">新闻</a></li>
      <li><a href="javascript:void(0);" f="market" class="f_market">供求</a></li>
      <li><a href="javascript:void(0);" f="product" class="f_product">产品</a></li>
      <li><a href="javascript:void(0);" f="parts" class="f_parts">配件</a></li>
      <li><a href="javascript:void(0);" f="used" class="f_used">二手</a></li>
    </ul>
    <script type="text/javascript">
    	var f = '<%=flag %>';
    	if(''!=f){
    		jQuery(".f_"+f).addClass("select");
    	}else{
    		jQuery(".f_all").addClass("select");
    	}
    </script>
    <div class="search_bar" style="position: relative;">
      <div class="search_input">
        <input name="q" type="text" id="keywords" value="<%=keywords %>" />
      </div>
      <div class="search_btn">
        <input type="button" name="button" id="button" value="&nbsp;" title="搜索" onclick="doSearch();" />
      </div>
      <div style="clear: both;"></div>
      <div class="search_related" id="search_related" style="display: none;"></div>
      <input type="hidden" name="f" id="f" value="<%=flag %>" />
    </div>
  </div>
  <div class="r pt20 pr20 rightLinks"><a href="javascript:void(0);">设为首页</a>|<a href="javascript:void(0);">加入收藏</a></div>
</div>
<div class="search_resultTop">
  <h3 class="name">搜索</h3> 
  <span class="total" style="margin-left: 27px;">找到约<%=allStr %>条结果（用时<%=jsonObject.get("time") %>秒）</span>
</div>
<div class="search_content">
  <!--left-->
  <div class="search_left">
    <dl class="byCategory">
      <dd class="selected"><a href="javascript:void(0);">网页结果</a></dd>
      <dd><a href="javascript:void(0);">新闻</a></dd>
      <dd><a href="javascript:void(0);">供求</a></dd>
      <dd><a href="javascript:void(0);">产品</a></dd>
      <dd><a href="javascript:void(0);">配件</a></dd>
      <dd><a href="javascript:void(0);">二手</a></dd>
    </dl>
    <dl class="byTime" style="display: none;">
      <dt>全部时间</dt>
      <dd><a href="javascript:void(0);">一天内</a></dd>
      <dd><a href="javascript:void(0);">一周内</a></dd>
      <dd><a href="javascript:void(0);">一月内</a></dd>
      <dd><a href="javascript:void(0);">一年内</a></dd>
    </dl>
    <dl class="byOther" style="display: none;">
      <dt>大家还在搜</dt>
      <dd><a href="javascript:void(0);">感恩节</a></dd>
      <dd><a href="javascript:void(0);">复活节</a></dd>
      <dd><a href="javascript:void(0);">圣诞节</a></dd>
      <dd><a href="javascript:void(0);">万圣节服装</a></dd>
      <dd><a href="javascript:void(0);">万圣节是什么时候</a></dd>
    </dl>
    <dl class="byHistory" style="display: none;">
      <dt>搜索历史</dt>
      <dd><a href="javascript:void(0);">感恩节</a></dd>
      <dd><a href="javascript:void(0);">复活节</a></dd>
      <dd><a href="javascript:void(0);">圣诞节</a></dd>
      <dd><a href="javascript:void(0);">万圣节服装</a></dd>
      <dd><a href="javascript:void(0);">万圣节是什么时候</a></dd>
      <dd class="more"><a href="javascript:void(0);">更多<em>&gt;&gt;</em></a></dd>
    </dl>
    <dl class="byHistoryBtn" style="display: none;">
      <dd><a href="javascript:void(0);">清除</a> <a href="javascript:void(0);">关闭</a></dd>
    </dl>
  </div>
  <!--left end-->
  <!--right-->
  <div class="search_right">
    <div class="search_right_left">
      <!--推荐-->
      <ul class="searchList resultTop" style="display: none;">
        <li>
          <h3><a href="javascript:void(0);"><em>滑移</em> - 搜搜百科</a></h3>
          <span class="sc">
            <em>滑移</em>是指晶体相邻的两部分沿着某一晶面在某个晶向上彼此间作相对的平行...在原先抛光的表面上由于发生了相对滑移，出现了许多平行的条痕和高低不一的台阶，...
          </span>
          <div class="site">资讯中心 - baike.soso.com/v747047.htm - <span class="time">2011-03-25</span></div>
        </li>
      </ul>
      <!--推荐结束-->
      <!--搜索列表-->
      <ul class="searchList">
      <%
      	JSONObject obj = null;
      	for(int i=0;i<arrays.length();i++){
      		obj = arrays.getJSONObject(i);	
      		%>
        <li>
          <h3><a href="javascript:void(0);"><%=obj.getString("title") %> - 网站名称</a></h3>
          <span class="sc">
            <%=obj.getString("intro") %>
          </span>
          <div class="site">网站名称 - 网站地址 - <span class="time"><%=obj.getString("pub_date") %></span></div>
        </li>
      		<%
      	}
      %>
      </ul>
      <!--搜索列表结束-->
      <!--翻页-->
      <div class="paging">
      
      <%
      	String paramStr = "";
      	if(!"".equals(keywords)){
      		paramStr+="&q="+keywords;
      	}
      	if(!"".equals(flag)){
      		paramStr += "&f="+flag;
      	}
      	%><a target="_self" href="/?p=<%=(nowPage-1) %><%=paramStr %>" class="prev">上一页</a><%
      	Integer total = jsonObject.getInt("total");
      	Integer pageCount = ((Double)Math.ceil(1d*total/pageSize*1d)).intValue();
      	int left = 0;
    	int right = 0;
    	int middle = nowPage;
    	if (middle > 6) {
    		left = middle - 6;
    		if (middle >= (pageCount - 6)) {
    			right = pageCount;
    		} else {
    			right = middle + 5;
    		}
    	} else if (middle <= 6 && pageCount > 11) {
    		right = 11;
    	} else {
    		right = pageCount;
    	}
    	for(int i=left;i<right;i++){
      		if((i+1)==nowPage){
    			%><strong class="cur"><%=(i+1) %></strong><%
    		}else{
    			%><a target="_self" href="/?p=<%=(i+1) %><%=paramStr %>"><%=(i+1) %></a><%
    		}
      	}
      %>
      	 <a target="_self" href="/?p=<%=(nowPage+1) %><%=paramStr %>" class="next">下一页</a> <span class="total">共约<%=allStr %>条结果</span>
      </div>
      <!--翻页结束-->
    </div>
    <div class="search_right_right" style="display: none;">
      <strong class="recommend">推广链接</strong>
      <ul class="searchList">
        <li>
          <h3><a href="javascript:void(0);"><em>滑移</em>龙工(上海)路面机械有限公司</a></h3>
          <span class="sc">
            是专业滑移研发,制造,采用全球领先核心部件,销售热线:139 5902 2223,
          </span>
          <div class="site">www.lonking.cn</div>
        </li>
        <li>
          <h3><a href="javascript:void(0);"><em>滑移</em>龙工(上海)路面机械有限公司</a></h3>
          <span class="sc">
            是专业滑移研发,制造,采用全球领先核心部件,销售热线:139 5902 2223,
          </span>
          <div class="site">www.lonking.cn</div>
        </li>
      </ul>
      <div class="Pictures">
        <h3><a href="javascript:void(0);"><em>滑移</em>图片</a></h3>
        <div class="img"><a href="javascript:void(0);" title="滑移图片"><img src="/images/img01.jpg" alt="滑移图片" width="150" height="142" /></a></div>
      </div>
      <div class="adIntro">
        <h3>在此展示您的推广信息</h3>
        <span class="text">咨询热线：0535-6722555</span>
        <div class="site"><a href="http://www.21-sun.com/" target="_blank">www.21-sun.com</a></div>
      </div>
    </div>
    <%
    	if(null!=xiang_guang_ci_arr&&xiang_guang_ci_arr.length()>0){
    		%>
<!--相关搜索-->
    <div class="relatedSearch">
      <table cellpadding="0">
        <tr>
          <th class="tt" colspan="9">相关搜索：</th>
        </tr>
        <%
        	JSONObject xiang_guang_ci = null;
        	int xiang_guang_size = xiang_guang_ci_arr.length();
        	String word = "";
        	left = 0;
        	right = 0;
        	if(xiang_guang_size>5){
        		right = 5;
        	}else{
        		right = xiang_guang_size;
        	}
        	%><tr><%
        	for(int i=left;i<right;i++){
        		xiang_guang_ci = xiang_guang_ci_arr.getJSONObject(i);
        		word = CommonString.getFormatPara(xiang_guang_ci.getString("word"));
        		paramStr = "";
	        	if(!"".equals(paramStr)){
	        		paramStr = "/?p="+nowPage+"&q="+keywords;
	        	}else{
	        		paramStr ="/?q="+word;
	        	}
	        	if(!"".equals(flag)){
	        		paramStr += "&f="+flag;
	        	}
        		%>
        	<th><a target="_self" href="<%=paramStr %>"><%=word %></a></th>
            <td></td>
        		<%
        	}
        	%></tr><%
        	left = 5;
        	right = xiang_guang_size;
        	%><tr><%
        	for(int i=left;i<right;i++){
        		xiang_guang_ci = xiang_guang_ci_arr.getJSONObject(i);
        		word = CommonString.getFormatPara(xiang_guang_ci.getString("word"));
        		paramStr = "";
	        	if(!"".equals(paramStr)){
	        		paramStr = "/?p="+nowPage+"&q="+keywords;
	        	}else{
	        		paramStr ="/?q="+word;
	        	}
	        	if(!"".equals(flag)){
	        		paramStr += "&f="+flag;
	        	}
        		%>
        	<th><a target="_self" href="<%=paramStr %>"><%=word %></a></th>
            <td></td>
        		<%
        	}
        	%></tr><%
        %>
      </table>
    </div>
    <!--相关搜索结束-->
    		<%
    	}
    %>
    <div class="search_contain">
      <div class="search_bar">
        <form id="form1" name="form1" method="post" action="">
        <div class="search_input">
          <input name="k_temp" id="word_temp" type="text" value="<%=keywords %>" />
        </div>
        <div class="search_btn">
          <input type="button" name="button" id="button" value="&nbsp;" onclick="doBottomSearch();" title="搜索" />
        </div>
        </form>
      </div>
    </div>
  </div>
  <!--right end-->
<div class="clear"></div>
</div>
<!--foot-->
<div class="search_foot">
	中国工程机械商贸网　Copyright &copy; 2000-<%=CommonDate.getToday("yyyy") %>　[中华人民共和国增值电信业务经营许可证 鲁B2-20071026号]　[鲁ICP备09041295号]
</div>
</body>
</html>
<script type="text/javascript" src="/plugin/other/index.js"></script>