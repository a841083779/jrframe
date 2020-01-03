<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%><%@page import="com.jerehnet.util.common.CommonString"%><%@page import="com.jerehnet.util.dbutil.DBHelper"%><%@page import="com.jerehnet.util.common.*"%><%@page import="java.text.SimpleDateFormat"%><%@page import="com.jerehnet.util.dbutil.PageBean"%><%@ taglib tagdir="/WEB-INF/tags" prefix="tags" %><%@ taglib uri="/WEB-INF/classes/oscache.tld" prefix="cache"%><%
	String id = CommonString.getFormatPara(request.getParameter("id")) ; // 一条产品订单的id
	
	DBHelper dbHelper = DBHelper.getInstance() ;
	Map m = dbHelper.getMap(" select * from pro_famous_person where id=?",new Object[]{id}) ;
	if(m == null){
		response.setStatus(301);
		response.setHeader("Location", "/mingren/"); 
		return;	
	}
	List <Map>ls = dbHelper.getMapList(" select top 6 * from pro_famous_person where factoryid=? order by newId() ",new Object[]{CommonString.getFormatPara(m.get("factoryid"))});
	List <Map>l = dbHelper.getMapList(" select top 5 * from pro_famous_person  order by newId() ",new Object[]{});
	Map bm = dbHelper.getMap(" select usern,logo from pro_agent_factory where id=?",new Object[]{CommonString.getFormatPara(m.get("factoryid"))}) ;
	List <Map>lp = dbHelper.getMapList(" select top 6 * from pro_famous_person_pic where product_id = ?  ",new Object[]{id});
	
	
%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title><%=CommonString.getFormatPara(m.get("name"))%>_<%=CommonString.getFormatPara(m.get("name"))%>简介 – 铁臂名人堂</title>
<meta name="keywords" content="<%=CommonString.getFormatPara(m.get("name"))%>,<%=CommonString.getFormatPara(m.get("name"))%>简介" />
<meta name="description" content="铁臂名人堂为您提供详细的<%=CommonString.getFormatPara(m.get("name"))%>简介等相关内容,让您更好的了解<%=CommonString.getFormatPara(m.get("name"))%>。寻找<%=CommonString.getFormatPara(m.get("name"))%>简介,就上铁臂名人堂！" />
<meta name="renderer" content="webkit">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="author" content="design by www.21-sun.com" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<link href="/style/style.css" rel="stylesheet" type="text/css" />
<link href="/style/new_style.css" rel="stylesheet" type="text/css" />
<link type="text/css" rel="stylesheet" href="/scripts/jBox-v2.3/Skins2/Blue/jbox.css" />
<script type="text/javascript" src="/scripts/jquery-1.7.min.js"></script>
<script type="text/javascript" src="/scripts/scripts.js"></script>
<script type="text/javascript" src="/scripts/flash.js"></script>
<script type="text/javascript" src="/scripts/jBox-v2.3/jquery.jBox-2.3.min.js"></script>
<script type="text/javascript" src="/scripts/jBox-v2.3/i18n/jquery.jBox-zh-CN.js"></script>
<!--[if IE 6]><script src="/scripts/pngfix.js">/* s,i,.pngfix,.pngimg img */</script><![endif]-->
</head>
<body class="mingren_none">
<!--top--> 
<jsp:include page="/include/top_mingren_detail.jsp" flush="true">
<jsp:param name="id" value="<%=id%>"></jsp:param>
</jsp:include>
<jsp:include page="/mingren/tongji.jsp"/>
<!--top end-->
<!--面包屑-->
<div class="contain980 mb10">
  <h3 class="breadCrumbs"> <a href="/">首页</a> &gt; <a href="http://mingren.21-sun.com/list/">企业名人</a> &gt; <%=CommonString.getFormatPara(m.get("name"))%></h3>
</div>
<!--面包屑结束--> 
<!--main-->
<div class="contain980 fix qymrdet fm-wryh">
	<div class="qymrdet_l">
    	<div class="qylbox qylbox-1">
        	<p class="qyxc-1"><a href="/mingren_tpdetail_<%=id%>.htm" title="<%=CommonString.getFormatPara(m.get("name"))%>"><img width="268" height="221" src="/uploadfiles/<%=CommonString.getFormatPara(m.get("img"))%>" alt="<%=CommonString.getFormatPara(m.get("name"))%>"/></a></p>
            <p class="qyxc-2"><a href="/mingren_tpdetail_<%=id%>.htm" title="<%=CommonString.getFormatPara(m.get("name"))%>"><%=CommonString.getFormatPara(m.get("name"))%>相册</a></p>
        </div>
        <div class="qylbox qylbox-2 fix">
        	<p class="qylogo"><a target="_blank" href="http://product.21-sun.com/brand/<%=CommonString.getFormatPara(bm.get("usern"))%>/"><img src="http://product.21-sun.com/uploadfiles/<%=CommonString.getFormatPara(bm.get("logo"))%>"/></a></p>
            <p class="qygoto"><a target="_blank" href="http://product.21-sun.com/brand/<%=CommonString.getFormatPara(bm.get("usern"))%>/">进入企业店铺 &gt;&gt;</a></p>
        </div>
        <div class="qylbox qylbox-3">
        	<div class="xgqy_t">相关企业家</div>
            <div class="xgqy_list">
            	<ul class="fix">
                <%for(int i = 0;ls != null && i<ls.size();i++){%>
                	<li>
                    	<a title="<%=CommonString.getFormatPara(ls.get(i).get("name"))%>" href="/mingren_detail_<%=CommonString.getFormatPara(ls.get(i).get("id"))%>.htm">
                        	<img src="/uploadfiles/<%=CommonString.getFormatPara(ls.get(i).get("img"))%>" alt="<%=CommonString.getFormatPara(ls.get(i).get("name"))%>"/>
                            <p class="qyj_name"><%=CommonString.getFormatPara(ls.get(i).get("name"))%></p>
                        </a>
                    </li>
                <%}%>    
                </ul>
            </div>
        </div>
        <div class="qylbox qylbox-4">
        	<div class="qyct_list">
                <p class="cit1">词条统计</p>
                <p class="cit2">浏览次数：<%=CommonString.getFormatPara(m.get("view_count"))%>次</p>
                <p class="cit4">最近更新：<%=CommonDate.getFormatDate("yyyy-MM-dd",m.get("last_modify_date"))%></p>
            </div>
        </div>
        <div class="qylbox qylbox-5">
        	<%=CommonString.getFormatPara(m.get("weibo"))%>
        </div>
    </div>
    <div class="qymrdet_r">
   	  <div class="qyrmr_name fix">
       	<h2 class="qyj_name"><span><%=CommonString.getFormatPara(m.get("name"))%></span> </h2>
        <div class="qyj_gn" style="width:193px">
       	  <div class="gnico gnico_1"><a href="javascript:addCookie();">收藏</a></div>
          <div class="gnico gnico_2"><a><%=CommonString.getFormatPara(m.get("view_count"))%></a></div>
          <div class="gnico gnico_3">
                	<div class="bdsharebuttonbox"><a href="#" class="bds_more" data-cmd="more">分享</a></div>
          </div>
        </div>
      </div>
      <div class="mrdet_text mrdet_text1"><%=CommonString.getFormatPara(m.get("intro"))%></div>
      <div class="mrdet_text mrdet_text2">
          <table cellpadding="0" cellspacing="0" border="0" width="100%" class="mrdet_cstab">
              <tr>
                  <th width="12%" align="left">中文名</th>
                  <td width="38%"><%=CommonString.getFormatPara(m.get("name"))%></td>
                  <th width="12%" align="left">出生日期</th>
                  <td width="38%"><%=(CommonString.getFormatPara(m.get("birthday")).equals("")||CommonString.getFormatPara(m.get("birthday")).indexOf("1900-01")!=-1)?"不详":CommonDate.getFormatDate("yyyy年MM月",m.get("birthday"))%></td>
              </tr>
              <tr>
                  <th align="left">外文名</th>
                  <td><%=CommonString.getFormatPara(m.get("name_en"))%></td>
                  <th align="left">职业</th>
                  <td><%=CommonString.getFormatPara(m.get("profession"))%></td>
              </tr>
              <tr>
                  <th align="left">国 籍</th>
                  <td><%=CommonString.getFormatPara(m.get("nationality"))%></td>
                  <th align="left">毕业院校</th>
                  <td><%=CommonString.getFormatPara(m.get("graduate"))%></td>
              </tr>
              <tr>
                  <th align="left">民 族</th>
                  <td><%=CommonString.getFormatPara(m.get("nation"))%></td>
                  <th align="left">主要成就</th>
                  <td><%=CommonString.getFormatPara(m.get("achieve"))%></td>
              </tr>
              <tr>
                  <th align="left">出生地</th>
                  <td><%=CommonString.getFormatPara(m.get("birthplace"))%></td>
                  <th align="left">&nbsp;</th>
                  <td>&nbsp;</td>
              </tr>
          </table>
      </div>
      <%=CommonString.getFormatPara(m.get("introduce"))%>
      <div class="mrdet_text mrdet_text4">
      	<div class="mrdet_xct">图册</div>
        <div class="mrdet_mrpic">
        	<ul class="fix">
            <%for(int i = 0; lp != null && i<lp.size();i++){%>
            	<li style="width:200px;margin-right:41px;background-image: url();"> 
                	<a target="_blank" href="/mingren_tpdetail_<%=id%>.htm">
                		<p><img style="width:200px" src="<%=CommonString.getFormatPara(lp.get(i).get("img_name"))%>" alt="<%=CommonString.getFormatPara(m.get("name"))%>"/></p>
                 	</a>
                </li>
             <%}%>   
            </ul>
        </div>
      </div>
      <div class="mrdet_text mrdet_text5">
      	<div class="mrdet_xct">行业名人</div>
        <div class="mrdet_hymrlist">
        	<ul class="fix">
            <%for(int i = 0; l != null && i<l.size();i++){%>
            	<li>
                	<a href="/mingren_detail_<%=CommonString.getFormatPara(l.get(i).get("id"))%>.htm" title="<%=CommonString.getFormatPara(l.get(i).get("name"))%>-<%=CommonString.getFormatPara(l.get(i).get("factoryname"))%><%=CommonString.getFormatPara(l.get(i).get("position"))%>">
                    	<img src="/uploadfiles/<%=CommonString.getFormatPara(l.get(i).get("img"))%>" alt="<%=CommonString.getFormatPara(l.get(i).get("name"))%>-<%=CommonString.getFormatPara(l.get(i).get("factoryname"))%><%=CommonString.getFormatPara(l.get(i).get("position"))%>"/>
                        <p class="hymr_name"><%=CommonString.getFormatPara(l.get(i).get("name"))%>-<%=CommonString.getFormatPara(l.get(i).get("factoryname"))%><%=CommonString.getFormatPara(l.get(i).get("position"))%></p>
                    </a>
                </li>
            <%}%>
            </ul>
        </div>
      </div>
      <!--
      <div class="ft_key fix mrdet_text7">
    	<div class="l ft_key_l">关键词：</div>
        <div class="r ft_key_r"><a href="#">中国人物</a><a href="#">企业家</a><a href="#">党员</a><a href="#">中国人物</a></div>-->
    </div>
  </div>
</div>
<style>

</style>
<!--main end-->
<div class="contain980 nomess_tel">如果没有找到您的信息，请直接致电：4006-521-526</div>
<!--foot-->
<jsp:include page="../include/foot_photo.jsp"/>
<!--foot end-->
<script type="text/javascript">
	$('.mrfc_list li:lt(3) .mr_num').addClass('red_num')
	$('.mrfc_list li').hover(function(){
		$(this).addClass('mrfc_open').siblings().removeClass('mrfc_open');
	});
	
	$('.mrb_srmore a').click(function(){
		var na = $('.mrb_srlist'); 
		na.toggleClass('mrb_srlist_auto'); 
		if( na.hasClass('mrb_srlist_auto') ){ 
			$(this).addClass('add_sqbtn');
		}else{ 
			$(this).removeClass('add_sqbtn');
		} 
	});
	jQuery.ajax({
		url:"/action/ajax.jsp",
		data:{flag:"viewCount",tableName:"pro_famous_person",id:"<%=id%>"} ,
		success:function(msg){
		}
	}) ;
</script>
<script>
window._bd_share_config={"common":{"bdSnsKey":{},"bdText":"","bdMini":"2","bdPic":"","bdStyle":"0","bdSize":"16"},"share":{}};with(document)0[(getElementsByTagName('head')[0]||body).appendChild(createElement('script')).src='http://bdimg.share.baidu.com/static/api/js/share.js?v=89860593.js?cdnversion='+~(-new Date()/36e5)];
</script>
</body>
</html>