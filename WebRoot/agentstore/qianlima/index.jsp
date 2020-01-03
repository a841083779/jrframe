<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.jerehnet.util.dbutil.DBHelper"%>
<%@page import="com.jerehnet.util.common.CommonString"%>
<%@page import="com.jerehnet.util.dbutil.PageBean"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="tags"%>
<%
	List<Map> hotList = null ;
	List<Map> proList = null ;
try{
	DBHelper dbHelper = DBHelper.getInstance() ;
	String sel_sql = "select top 2 * from pro_products " ;  // 选出两个产品
	String whereStr = "" ;
	String hot_sql = "select top 4 pro.* from pro_agent_products agent left join pro_products pro on agent.product_id=pro.id where agent_id=1661 and pro.zoomlion_hot=11" ;
	hotList = dbHelper.getMapList(hot_sql) ;
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />  
<meta name="author" content="design by www.21-sun.com" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />  
<title>千里马官方旗舰店_中国工程机械商贸网</title>
<meta name="keywords" content="千里马,千里马产品报价,千里马产品,千里马产品图片,千里马介绍,千里马代理商" />
<meta name="description" content="中国工程机械商贸网为您提供千里马介绍,千里马产品介绍,千里马产品报价,千里马产品图片,千里马产品展示等千里马产品信息，帮助您全面了解千里马相关的斗山产品、临工产品、山猫滑移产品、千里马产品。" />
<link href="/style/style.css" rel="stylesheet" type="text/css" />
<link href="style/flag_shop02.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="/scripts/jquery-1.7.min.js"></script>
<script type="text/javascript" src="/scripts/scripts.js"></script>
<script type="text/javascript" src="/scripts/jBox-v2.3/jquery.jBox-2.3.min.js"></script>
<script type="text/javascript" src="/scripts/jBox-v2.3/i18n/jquery.jBox-zh-CN.js"></script>
<script type="text/javascript" src="/scripts/sort.js"></script>
<link type="text/css" rel="stylesheet"	href="/scripts/jBox-v2.3/Skins2/Blue/jbox.css" />
<!--[if (IE 6)]>
<link href="/style/pngfix.css" media="screen" rel="stylesheet" type="text/css" />
<![endif]-->
<script type="text/javascript" src="/scripts/jquery.SuperSlide.js"></script>
</head>
<body class="flag_shop">
<!--top-->
<jsp:include page="/brandshop/include/top.jsp" flush="true"></jsp:include>
<jsp:include page="top.jsp" flush="true"></jsp:include>
<!--main-->
<div id="slider" class="new_rec">
  <div class="hd">
    <a class="newsImgprev"></a>
    <ul class="points">
    </ul>
    <a class="newsImgnext"></a>
  </div>
  <div class="bd"> 
    <ul class="bgs">
      <li><a href="javascript:;"><img src="images/new_bigbanner1.jpg" width="977" height="490" /></a></li>
      <li><a href="javascript:;"><img src="images/new_bigbanner2.jpg" width="977" height="490" /></a></li>
      <li><a href="javascript:;"><img src="images/new_bigbanner3.jpg" width="977" height="490" /></a></li>
    </ul>
  </div>
</div>
<script type="text/javascript">
jQuery("#slider").slide({ titCell:".hd ul", mainCell:".bd ul",effect:"leftLoop",vis:1,scroll:1,autoPlay:true,autoPage:true});
</script> 
<div class="pageTotal">
  <div class="brands">
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td><a href="#bs01"><img src="images/big_brand01.png" width="225" height="170" /></a></td>
        <td><a href="#bs02"><img src="images/big_brand02.png" width="225" height="170" /></a></td>
        <td><a href="#bs03"><img src="images/big_brand03.png" width="225" height="170" /></a></td>
        <td><img src="images/erweima.png" width="171" height="170" style="padding:0px 27px;" /></td>
      </tr>
    </table> 
  </div>
  <div class="brandsShop">  
    <ul>
      <li>
        <dt><img src="images/brand_img01.gif" width="162" height="47" /></dt>
        <dd><a href="list.jsp?factoryid=192&catanum=101001" target="_blank">挖掘机</a></dd>
        <dd><a href="list.jsp?factoryid=192&catanum=101002" target="_blank">装载机</a></dd> 
        <dd><a href="list.jsp?factoryid=192&catanum=101008" target="_blank">铰接式自卸卡车</a></dd>
        <dd><a href="list.jsp?factoryid=192&catanum=113001" target="_blank">破碎锤</a></dd>
      </li>
      <li>
        <dt><img src="images/brand_img02.gif" width="162" height="47" /></dt>
        <dd><a href="list.jsp?factoryid=137&catanum=101001" target="_blank">液压挖掘机</a></dd>
        <dd><a href="list.jsp?factoryid=137&catanum=101002" target="_blank">装载机</a></dd>
        <dd><a href="list.jsp?factoryid=137&catanum=106001" target="_blank">压路机</a></dd>
      </li>
      <li>
        <dt><img src="images/brand_img03.gif" width="162" height="47" /></dt>
        <dd><a href="list.jsp?factoryid=454&catanum=101002" target="_blank">装载机</a></dd> 
        <dd><a href="list.jsp?factoryid=454&catanum=101001" target="_blank">挖掘机</a></dd>
      </li>
      <li class="last">
        <dt><img src="images/brand_img04.gif" width="224" height="47" /></dt>
        <dd><a href="list.jsp?factoryid=1661&catanum=33333" target="_blank">再制造产品</a></dd>
        <dd><a href="list.jsp?factoryid=1661&catanum=113001" target="_blank">破碎锤</a></dd>
      </li>
    </ul>
  </div>
<div class="clear"></div>  
</div>

<div class="proRec clearfix">
  <div class="bigTitle01">
    <h2>产品推荐\RECOMMENDED PRODUCTS</h2>
    <span class="ico"></span>
  </div>
  
  <div class="recBigimg">
    <ul>
      <li><img src="images/im-01.jpg" width="950" height="300" /></li>
    </ul>
  </div>
  
  <div class="recList">
    <ul>
    <%
    	if(null!=hotList && hotList.size()>0){
    		for(Map oneMap:hotList){
    			%>
      <li>
        <div class="img"><a href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")) %>" target="_blank"><img onerror='this.src="/images/nopic.gif"' src="/uploadfiles/<%=CommonString.getFormatPara(oneMap.get("img2")) %>" width="215" height="170" /></a></div>
        <div class="info">
          <div class="intro">产品：<%=CommonString.getFormatPara(oneMap.get("factoryname"))+CommonString.getFormatPara(oneMap.get("catalogname")) %><br />型号：<%=CommonString.getFormatPara(oneMap.get("name"))%></div>
          <a href="javascript:;" onclick="showinquery('<%=CommonString.getFormatPara(oneMap.get("id"))%>','')" class="xjbtn" title="立即询价">立即询价</a>
        </div> 
      </li>
    			<%
    		}
    	}
    %>
    </ul>
  </div>
</div>

<div class="proBrandShow clearfix">
<a class="pp" id="bs01"></a>
<div class="clear"></div>
  <div class="bigTitle01">
    <h2><img src="images/title_brand01.gif" width="133" height="72" />斗山产品</h2>
    <span class="links"><a href="list.jsp?factoryid=192&catanum=101001" target="_blank">挖掘机</a><em>|</em><a href="list.jsp?factoryid=192&catanum=101002" target="_blank">装载机</a><em>|</em><a href="list.jsp?factoryid=192&catanum=101008" target="_blank">铰接式自卸卡车</a><em>|</em><a href="list.jsp?factoryid=192&catanum=113001" target="_blank">破碎锤</a></span>
    <span class="ico"></span>
  </div>
  <div class="proBrandList">
    <ul class="pbl-con">
      <li class="pbl">
        <div class="cate">
          <div class="img"><a href="list.jsp?factoryid=192&catanum=101001" target="_blank"><img src="images/doosan2_07.jpg" alt="斗山挖掘机系列" width="395" height="210" /></a></div>
          <div class="title">
            <h3><a href="list.jsp?factoryid=192&catanum=101001" target="_blank">斗山挖掘机系列</a></h3>
            <span class="more"><a href="list.jsp?factoryid=192&catanum=101001" target="_blank">查看更多&gt;&gt;</a></span>
          </div>
        </div>
        <ul>
        <%
        whereStr += "where 1=1 and  factoryid=192 and catalognum like'101001%'" ;
        proList = (ArrayList)dbHelper.getMapList(sel_sql+whereStr) ;
        if(null!=proList && proList.size()>0){
        	for(Map oneMap:proList){
        		%>
                <li>
                <a href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")) %>" target="_blank" class="img" title="<%= CommonString.getFormatPara(oneMap.get("name"))+CommonString.getFormatPara(oneMap.get("catalogname"))%>"><img src="/uploadfiles/<%=CommonString.getFormatPara(oneMap.get("img2"))%>" onerror='this.src="/images/nopic.gif"' width="235" height="225" /></a>
                <h4><a href='/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")) %>' target="_blank" title="<%= CommonString.getFormatPara(oneMap.get("name"))+CommonString.getFormatPara(oneMap.get("catalogname"))%>"><%=CommonString.getFormatPara(oneMap.get("name"))+CommonString.getFormatPara(oneMap.get("catalogname"))%></a></h4>
                <a href="javascript:;" onclick="showinquery('<%=CommonString.getFormatPara(oneMap.get("id"))%>','')" class="xjbtn">立即询价</a>
              </li>       		
              <%
        	}
        }
        proList = null ;
        %>
        </ul>
      </li>
      <li class="pbl">
        <div class="cate">
          <div class="img"><a href="list.jsp?factoryid=192&catanum=101002" target="_blank"><img src="images/doosan2_07-10.jpg" alt="斗山装载机系列" width="395" height="210" /></a></div>
          <div class="title">
            <h3><a href="list.jsp?factoryid=192&catanum=101002" target="_blank">斗山装载机系列</a></h3>
            <span class="more"><a href="list.jsp?factoryid=192&catanum=101002" target="_blank">查看更多&gt;&gt;</a></span>
          </div>
        </div>
        <ul>
              <%
        whereStr = "where factoryid=192 and catalognum like'101002%' and len(name)>5" ;
        proList = (ArrayList)dbHelper.getMapList(sel_sql+whereStr) ;
        if(null!=proList && proList.size()>0){
        	for(Map oneMap:proList){
        		%>
                <li>
                <a href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")) %>" target="_blank" class="img" title="<%= CommonString.getFormatPara(oneMap.get("name"))+CommonString.getFormatPara(oneMap.get("catalogname"))%>"><img src="/uploadfiles/<%=CommonString.getFormatPara(oneMap.get("img2"))%>" onerror='this.src="/images/nopic.gif"' width="235" height="225" /></a>
                <h4><a href='/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")) %>' target="_blank" title="<%= CommonString.getFormatPara(oneMap.get("name"))+CommonString.getFormatPara(oneMap.get("catalogname"))%>"><%=CommonString.getFormatPara(oneMap.get("name"))+CommonString.getFormatPara(oneMap.get("catalogname"))%></a></h4>
                <a href="javascript:;" onclick="showinquery('<%=CommonString.getFormatPara(oneMap.get("id"))%>','')" class="xjbtn">立即询价</a>
              </li>       		
              <%
        	}
        }
        proList = null ;
        %>
        </ul>
      </li>
      <li class="pbl">
        <div class="cate">
          <div class="img"><a href="list.jsp?factoryid=192&catanum=101008" target="_blank"><img src="images/doosan2_07-12.jpg" alt="斗山铰接式自卸卡车系列" width="395" height="210" /></a></div>
          <div class="title">
            <h3><a href="list.jsp?factoryid=192&catanum=101008" target="_blank">斗山铰接式自卸卡车系列</a></h3>
            <span class="more"><a href="list.jsp?factoryid=192&catanum=101008" target="_blank">查看更多&gt;&gt;</a></span>
          </div>
        </div>
        <ul>
              <%
        whereStr = "where factoryid=192 and catalognum like'101008%'" ;
        proList = (ArrayList)dbHelper.getMapList(sel_sql+whereStr) ;
        if(null!=proList && proList.size()>0){
        	for(Map oneMap:proList){
        		%>
                <li>
                <a href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")) %>" target="_blank" class="img" title="<%= CommonString.getFormatPara(oneMap.get("name"))+CommonString.getFormatPara(oneMap.get("catalogname"))%>"><img src="/uploadfiles/<%=CommonString.getFormatPara(oneMap.get("img2"))%>" onerror='this.src="/images/nopic.gif"' width="235" height="225" /></a>
                <h4><a href='/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")) %>' target="_blank" title="<%= CommonString.getFormatPara(oneMap.get("name"))+CommonString.getFormatPara(oneMap.get("catalogname"))%>"><%=CommonString.getFormatPara(oneMap.get("name"))+CommonString.getFormatPara(oneMap.get("catalogname"))%></a></h4>
                <a href="javascript:;" onclick="showinquery('<%=CommonString.getFormatPara(oneMap.get("id"))%>','')" class="xjbtn">立即询价</a>
              </li>       		
              <%
        	}
        }
        proList = null ;
        %>
        </ul>
      </li>
      <li class="pbl">
        <div class="cate">
          <div class="img"><a href="list.jsp?factoryid=192&catanum=113001" target="_blank"><img src="images/pblimg04.jpg" alt="斗山破碎锤系列" width="395" height="210" /></a></div>
          <div class="title">
            <h3><a href="list.jsp?factoryid=192&catanum=113001" target="_blank">斗山破碎锤系列</a></h3>
            <span class="more"><a href="list.jsp?factoryid=192&catanum=113001" target="_blank">查看更多&gt;&gt;</a></span>
          </div>
        </div>
        <ul>
             <%
        whereStr = "where factoryid=192 and catalognum like'113001%'" ;
        proList = (ArrayList)dbHelper.getMapList(sel_sql+whereStr) ;
        if(null!=proList && proList.size()>0){
        	for(Map oneMap:proList){
        		%>
                <li>
                <a href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")) %>" target="_blank" class="img" title="<%= CommonString.getFormatPara(oneMap.get("name"))+CommonString.getFormatPara(oneMap.get("catalogname"))%>"><img src="/uploadfiles/<%=CommonString.getFormatPara(oneMap.get("img2"))%>" onerror='this.src="/images/nopic.gif"' width="235" height="225" /></a>
                <h4><a href='/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")) %>' target="_blank" title="<%= CommonString.getFormatPara(oneMap.get("name"))+CommonString.getFormatPara(oneMap.get("catalogname"))%>"><%=CommonString.getFormatPara(oneMap.get("name"))+CommonString.getFormatPara(oneMap.get("catalogname"))%></a></h4>
                <a href="javascript:;" onclick="showinquery('<%=CommonString.getFormatPara(oneMap.get("id"))%>','')" class="xjbtn">立即询价</a>
              </li>       		
              <%
        	}
        }
        proList = null ;
        %>
        </ul>
      </li>
    </ul>
  </div>
</div>
<div class="proBrandShow clearfix">
<a class="pp" id="bs02"></a>
<div class="clear"></div>
  <div class="bigTitle01">
    <h2><img src="images/title_brand02.gif" width="78" height="72" />临工产品</h2>
    <span class="links"><a href="list.jsp?factoryid=137&catanum=101002" target="_blank">装载机</a><em>|</em><a href="list.jsp?factoryid=137&catanum=101001" target="_blank">液压挖掘机</a><em>|</em><a href="list.jsp?factoryid=137&catanum=106001" target="_blank">压路机</a></span>
    <span class="ico"></span>
  </div>
  <div class="proBrandList">
    <ul class="pbl-con">
      <li class="pbl">
        <div class="cate">
          <div class="img"><a href="list.jsp?factoryid=137&catanum=101002" target="_blank"><img src="images/lingong2_07-14.jpg" alt="临工装载机系列" width="395" height="210" /></a></div>
          <div class="title">
            <h3><a href="list.jsp?factoryid=137&catanum=101002" target="_blank">临工装载机系列</a></h3>
            <span class="more"><a href="list.jsp?factoryid=137&catanum=101002" target="_blank">查看更多&gt;&gt;</a></span>
          </div>
        </div>
        <ul>
             <%
        whereStr = "where factoryid=137 and catalognum like'101002%'" ;
        proList = (ArrayList)dbHelper.getMapList(sel_sql+whereStr) ;
        if(null!=proList && proList.size()>0){
        	for(Map oneMap:proList){
        		%>
                <li>
                <a href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")) %>" target="_blank" class="img" title="<%= CommonString.getFormatPara(oneMap.get("name"))+CommonString.getFormatPara(oneMap.get("catalogname"))%>"><img src="/uploadfiles/<%=CommonString.getFormatPara(oneMap.get("img2"))%>" onerror='this.src="/images/nopic.gif"' width="235" height="225" /></a>
                <h4><a href='/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")) %>' target="_blank" title="<%= CommonString.getFormatPara(oneMap.get("name"))+CommonString.getFormatPara(oneMap.get("catalogname"))%>"><%=CommonString.getFormatPara(oneMap.get("name"))+CommonString.getFormatPara(oneMap.get("catalogname"))%></a></h4>
                <a href="javascript:;" onclick="showinquery('<%=CommonString.getFormatPara(oneMap.get("id"))%>','')" class="xjbtn">立即询价</a>
              </li>       		
              <%
        	}
        }
        proList = null ;
        %>
        </ul>
      </li>
      <li class="pbl">
        <div class="cate">
          <div class="img"><a href="list.jsp?factoryid=137&catanum=101001" target="_blank"><img src="images/lingong2_07-16.jpg" alt="临工液压挖掘机系列" width="395" height="210" /></a></div>
          <div class="title">
            <h3><a href="list.jsp?factoryid=137&catanum=101001" target="_blank">临工液压挖掘机系列</a></h3>
            <span class="more"><a href="list.jsp?factoryid=137&catanum=101001" target="_blank">查看更多&gt;&gt;</a></span>
          </div>
        </div>
        <ul>
            <%
        whereStr = "where factoryid=137 and catalognum like'101001%'" ;
        proList = (ArrayList)dbHelper.getMapList(sel_sql+whereStr) ;
        if(null!=proList && proList.size()>0){
        	for(Map oneMap:proList){
        		%>
                <li>
                <a href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")) %>" target="_blank" class="img" title="<%= CommonString.getFormatPara(oneMap.get("name"))+CommonString.getFormatPara(oneMap.get("catalogname"))%>"><img src="/uploadfiles/<%=CommonString.getFormatPara(oneMap.get("img2"))%>" onerror='this.src="/images/nopic.gif"' width="235" height="225" /></a>
                <h4><a href='/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")) %>' target="_blank" title="<%= CommonString.getFormatPara(oneMap.get("name"))+CommonString.getFormatPara(oneMap.get("catalogname"))%>"><%=CommonString.getFormatPara(oneMap.get("name"))+CommonString.getFormatPara(oneMap.get("catalogname"))%></a></h4>
                <a href="javascript:;" onclick="showinquery('<%=CommonString.getFormatPara(oneMap.get("id"))%>','')" class="xjbtn">立即询价</a>
              </li>       		
              <%
        	}
        }
        proList = null ;
        %>
        </ul>
      </li>
      <li class="pbl">
        <div class="cate">
          <div class="img"><a href="list.jsp?factoryid=137&catanum=106001" target="_blank"><img src="images/lingong2_07-19.jpg" alt="临工压路机系列" width="395" height="210" /></a></div>
          <div class="title">
            <h3><a href="list.jsp?factoryid=137&catanum=106001" target="_blank">临工压路机系列</a></h3>
            <span class="more"><a href="list.jsp?factoryid=137&catanum=106001" target="_blank">查看更多&gt;&gt;</a></span>
          </div>
        </div>
        <ul>
            <%
        whereStr = "where factoryid=137 and catalognum like'106001%'" ;
        proList = (ArrayList)dbHelper.getMapList(sel_sql+whereStr) ;
        if(null!=proList && proList.size()>0){
        	for(Map oneMap:proList){
        		%>
                <li>
                <a href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")) %>" target="_blank" class="img" title="<%= CommonString.getFormatPara(oneMap.get("name"))+CommonString.getFormatPara(oneMap.get("catalogname"))%>"><img src="/uploadfiles/<%=CommonString.getFormatPara(oneMap.get("img2"))%>" onerror='this.src="/images/nopic.gif"' width="235" height="225" /></a>
                <h4><a href='/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")) %>' target="_blank" title="<%= CommonString.getFormatPara(oneMap.get("name"))+CommonString.getFormatPara(oneMap.get("catalogname"))%>"><%=CommonString.getFormatPara(oneMap.get("name"))+CommonString.getFormatPara(oneMap.get("catalogname"))%></a></h4>
                <a href="javascript:;" onclick="showinquery('<%=CommonString.getFormatPara(oneMap.get("id"))%>','')" class="xjbtn">立即询价</a>
              </li>       		
              <%
        	}
        }
        proList = null ;
        %>
        </ul>
      </li>
    </ul>
  </div> 
</div>
<div class="proBrandShow clearfix">
<a class="pp" id="bs03"></a>
<div class="clear"></div>
  <div class="bigTitle01">
    <h2><img src="images/title_brand03.gif" width="199" height="72" />山猫产品</h2> 
    <span class="links"><a href="list.jsp?factoryid=454&catanum=101001" target="_blank">挖掘机</a><em>|</em><a href="list.jsp?factoryid=454&catanum=101002" target="_blank">装载机</a></span>
    <span class="ico"></span>
  </div>
  <div class="proBrandList">
    <ul class="pbl-con">
      <li class="pbl" style="display:none;">
        <div class="cate" >
          <div class="img"><a href="list.jsp?factoryid=454&catanum=101001" target="_blank"><img src="images/shanmao2_07-23.jpg" alt="山猫滑移挖掘机系列" width="395" height="210" /></a></div>
          <div class="title">
            <h3><a href="list.jsp?factoryid=454&catanum=101001" target="_blank">山猫滑移挖掘机系列</a></h3>
            <span class="more"><a href="list.jsp?factoryid=454&catanum=101001" target="_blank">查看更多&gt;&gt;</a></span>
          </div>
        </div>
        <ul>
            <%
        whereStr = "where factoryid=454 and catalognum like'101001%'" ;
        proList = (ArrayList)dbHelper.getMapList(sel_sql+whereStr) ;
        if(null!=proList && proList.size()>0){
        	for(Map oneMap:proList){
        		%>
                <li>
                <a href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")) %>" target="_blank" class="img" title="<%= CommonString.getFormatPara(oneMap.get("name"))+CommonString.getFormatPara(oneMap.get("catalogname"))%>"><img src="/uploadfiles/<%=CommonString.getFormatPara(oneMap.get("img2"))%>" onerror='this.src="/images/nopic.gif"' width="235" height="225" /></a>
                <h4><a href='/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")) %>' target="_blank" title="<%= CommonString.getFormatPara(oneMap.get("name"))+CommonString.getFormatPara(oneMap.get("catalogname"))%>"><%=CommonString.getFormatPara(oneMap.get("name"))+CommonString.getFormatPara(oneMap.get("catalogname"))%></a></h4>
                <a href="javascript:;" onclick="showinquery('<%=CommonString.getFormatPara(oneMap.get("id"))%>','')" class="xjbtn">立即询价</a>
              </li>       		
              <%
        	}
        }
        proList = null ;
        %>
        </ul>
      </li>
      <li class="pbl">
        <div class="cate">
          <div class="img"><a href="list.jsp?factoryid=454&catanum=101002" target="_blank"><img src="images/shanmao2_07-26.jpg" alt="山猫滑移装载机系列" width="395" height="210" /></a></div>
          <div class="title">
            <h3><a href="list.jsp?factoryid=454&catanum=101002" target="_blank">山猫滑移装载机系列</a></h3>
            <span class="more"><a href="list.jsp?factoryid=454&catanum=101002" target="_blank">查看更多&gt;&gt;</a></span>
          </div>
        </div>
        <ul>
            <%
        whereStr = "where factoryid=454 and catalognum like'101002%'" ;
        proList = (ArrayList)dbHelper.getMapList(sel_sql+whereStr) ;
        if(null!=proList && proList.size()>0){
        	for(Map oneMap:proList){
        		%>
                <li>
                <a href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")) %>" target="_blank" class="img" title="<%= CommonString.getFormatPara(oneMap.get("name"))+CommonString.getFormatPara(oneMap.get("catalogname"))%>"><img src="/uploadfiles/<%=CommonString.getFormatPara(oneMap.get("img2"))%>" onerror='this.src="/images/nopic.gif"' width="235" height="225" /></a>
                <h4><a href='/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")) %>' target="_blank" title="<%= CommonString.getFormatPara(oneMap.get("name"))+CommonString.getFormatPara(oneMap.get("catalogname"))%>"><%=CommonString.getFormatPara(oneMap.get("name"))+CommonString.getFormatPara(oneMap.get("catalogname"))%></a></h4>
                <a href="javascript:;" onclick="showinquery('<%=CommonString.getFormatPara(oneMap.get("id"))%>','')" class="xjbtn">立即询价</a>
              </li>       		
              <%
        	}
        }
        proList = null ;
        %>
    </ul>
      </li>
    </ul>  	
  </div>
</div>
<div class="proBrandShow clearfix last">
<a class="pp" id="bs04"></a>
<div class="clear"></div>  
  <div class="bigTitle01">
    <h2><img src="images/title_brand04.gif" width="199" height="72" />千里马产品</h2>
    <span class="links"><a href="list.jsp?factoryid=1661&catanum=113001" target="_blank">破碎锤</a><em>|</em><a href="list.jsp?factoryid=1661&catanum=33333" target="_blank">再制造产品</a></span>
    <span class="ico"></span>
  </div>
  <div class="proBrandList">
    <ul class="pbl-con">
      <li class="pbl">
        <div class="cate">
          <div class="img"><a href="list.jsp?factoryid=1661&catanum=113001" target="_blank"><img src="images/sevalo2_07.jpg" alt="千里马破碎锤系列" width="395" height="210" /></a></div>
          <div class="title">
            <h3><a href="list.jsp?factoryid=1661&catanum=113001" target="_blank">千里马破碎锤系列</a></h3>
            <span class="more"><a href="list.jsp?factoryid=1661&catanum=113001" target="_blank">查看更多&gt;&gt;</a></span>
          </div>
        </div>
        <div class="cate">
          <div class="img"><a href="list.jsp?factoryid=1661&catanum=33333"><img src="images/sevalo2_08.jpg" alt="千里马再制造产品系列" width="395" height="210" /></a></div>
          <div class="title">
            <h3><a href="list.jsp?factoryid=1661&catanum=33333" target="_blank">千里马再制造产品系列</a></h3>
            <span class="more"><a href="list.jsp?factoryid=1661&catanum=33333" target="_blank">查看更多&gt;&gt;</a></span>
          </div>
        </div>
      </li>
    </ul>
  </div>
</div>
<div class="proBrandShow clearfix">
  <div class="bigTitle01">
    <h2>千里马产品订单</h2>
    <a name="to_order" href="#">&nbsp;</a>
    <span class="more"><a href="/inquiry/" target="_blank">&nbsp;</a></span>
  </div>
  <div class="content">
    <div class="w978 border03 l list08">
      <div class="title08">
       <%
   	    String offset = CommonString.getFormatPara(request.getParameter("offset"));
       List<Map> orderList = null ;
       PageBean pageBean = new  PageBean() ;
		Integer nowPage = 1;
		if("".equals(offset) || Integer.parseInt(offset)<=0){
			offset = "0" ;
		}
		if (!"".equals(offset) && !"0".equals(offset)) {
			nowPage = Integer.parseInt(offset) / pageBean.getPageSize() + 1;
		}
       pageBean.setTableName("pro_agent_products_form") ;
       pageBean.setFields("factory_id factoryid ,id,factory_name factoryname,product_name,contact_address,cata_name cataname,user_name name,contact_tel mobile_phone,province,city,add_date") ;
       pageBean.setPageSize(10) ;
       pageBean.setCondition(" and agent_id=1661 and factory_name <>'' and factory_name is not null and user_name is not null and user_name<>'' and product_name is not null and product_name<>''") ;
       pageBean.setNowPage(nowPage) ;
       pageBean.setOrderBy(" add_date desc") ;
       pageBean.setParams("#to_order") ;
       orderList = pageBean.getDatas() ;
       %>
        <h3><b>询价总数：<%=pageBean.getTotal() %></b> - 采购询价</h3>
        <span>共有<font><%=pageBean.getTotal()  %></font>个符合条件</span> </div>
      <ul class="ti">
        <li class="i1">编号</li>
        <li class="i2">询价产品</li>
        <li class="i3">联系人</li>
        <li class="i4">电话</li>
        <li class="i5">询价品牌</li>
        <li class="i6">询价区域</li>
        <li class="i7">询价时间</li>
      </ul>
      <div class="li">
	  <%
	  if(null!=orderList && orderList.size()>0){
		  int k = orderList.size()>10?10:orderList.size() ;
      	 String showtel = "" ; 
      	 Map oneMap = null ;
	  	 for(int i=0;i<k;i++){
	  		oneMap = orderList.get(i) ;
    		showtel = "".equals(CommonString.getFormatPara(oneMap.get("mobile_phone")))?CommonString.getFormatPara(oneMap.get("contact_tel")):CommonString.getFormatPara(oneMap.get("mobile_phone")) ;
    		
    		if(showtel.length()>7&&showtel.length()<=20){
    			showtel = showtel.substring(0,3)+"***"+showtel.substring(showtel.length()-3) ;
    		}else if(showtel.length()>3){
    			showtel = showtel.substring(0,4)+"***" ;
    		}else
    		{
    			showtel = showtel+"***" ;
    		}
    		%>  
    		 <ul class="libg01">
            <li class="i1"><%=i+1 %></li>
            <li class="i2"><a href="/inquiry/details_for_<%=CommonString.getFormatPara(oneMap.get("id")) %>.htm" target="_blank"><%=CommonString.getFormatPara(oneMap.get("factoryname")) %><%=CommonString.getFormatPara(oneMap.get("product_name")) %><%=CommonString.getFormatPara(oneMap.get("cataname")) %></a></li>
            <li class="i3"><%=(CommonString.getFormatPara(oneMap.get("name")).length()>0)?CommonString.getFormatPara(oneMap.get("name")).substring(0,1)+"***":"张**" %></li>
            <li class="i4"><%=showtel %></li>
            <li class="i5"><a target="_blank" href="/inquiry/?factory=<%=CommonString.getFormatPara(oneMap.get("factoryid")) %>"><%=CommonString.getFormatPara(oneMap.get("factoryname")) %></a></li>
            <li class="i6"><%="".equals(CommonString.getFormatPara(oneMap.get("contact_address")))?"-":CommonString.getFormatPara(oneMap.get("contact_address"))  %></li>
            <li class="i7"><%=(CommonString.getFormatPara(oneMap.get("add_date")).length()>15)?CommonString.getFormatPara(oneMap.get("add_date")).substring(0,16):CommonString.getFormatPara(oneMap.get("add_date")) %></li>
          </ul>
    		<%
	  	 }
	  }
	  %>
      </div>
    </div>
      <div class="page" style="margin-left:467px;width:500px;clear:both;float:left;"><tags:page pageBean="<%=pageBean%>" /></div></div>
  </div>
</div>
<!--main end--> 
<!--foot-->
<div class="flagshopbg">
<jsp:include page="/include/foot.jsp" flush="true"></jsp:include>
</div>
<!--end of foot--> 
<script type="text/javascript">
(function(jQuery){
 jQuery.extend(jQuery.fn,{
 scrollTo:function(time,to){
 time=time||800;
 to=to||1;
            jQuery('a[href*=#]', this).click(function(){
                if (location.pathname.replace(/^\//, '') == this.pathname.replace(/^\//, '') && 
location.hostname == this.hostname) {
      var jQuerytarget = jQuery(this.hash);
     jQuerytarget = jQuerytarget.length && jQuerytarget || jQuery('[name=' + this.hash.slice(1) + ']');
                    if (jQuerytarget.length) {
                        if (to == 1) {
                            jQuery('html,body').animate({
                                scrollTop: jQuerytarget.offset().top
                            }, time);
                        }
                        else if(to==2){
                            jQuery('html,body').animate({
                                scrollLeft: jQuerytarget.offset().left
                            }, time);
                        }else{
alert('argument error');
  }
                        return false;
                    }
                }
            });
  }
 });
})(jQuery);
</script> 
<script type="text/javascript" language="javascript">
jQuery(function(){
  jQuery(".brands").scrollTo(700)
  jQuery(".brands a").click(function(){
		jQuery(".brands a").removeClass("selected");
		jQuery(this).addClass("selected");
	});
});
</script> 
<script type="text/javascript">
function addShop(){　 // 收藏我们
    try{
       window.external.addFavorite('http://product.21-sun.com/brandshop/sevalo/', '千里马官方旗舰店');
   }catch (e){
       try{
           window.sidebar.addPanel('千里马官方旗舰店','http://product.21-sun.com/brandshop/hengzhi/',"");
       }catch (e){
           alert("加入收藏失败，请使用Ctrl+D进行添加");
       }
   }
}
jQuery("body").bind("contextmenu", function() {
  return false;
});
</script> 
<script type="text/javascript" src="/scripts/scrolltopcontrol.js"></script> 
<script type="text/javascript" src="/scripts/sort.js"></script>
<div class="erweima"><img src="images/erweima.png" width="170" height="170" /></div>
</body>
</html>
<%
}catch(Exception e){
	e.printStackTrace() ;
}finally{
	hotList = null ;
	proList = null ;
}
%>