<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="com.jerehnet.util.common.CommonString"%>
<%@page import="com.jerehnet.util.dbutil.DBHelper"%>
<%@page import="com.jerehnet.util.common.*,com.jerehnet.webservice.*"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.jerehnet.util.dbutil.PageBean"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="tags" %>
<%@ taglib uri="/WEB-INF/classes/oscache.tld" prefix="cache"%>
<%
	DBHelper dbHelper = DBHelper.getInstance() ;
	String id = CommonString.getFormatPara(request.getParameter("id"));
	Map m = null;
	//相关人物
	List<Map> lr = null;
	PageBean pageBean = new PageBean();
	pageBean.setFields("*") ;
	pageBean.setPageSize(16);
	pageBean.setTableName("article");
	Integer nowPage = 1;
	String offset = CommonString.getFormatPara(request.getParameter("offset"));
	if("".equals(offset) || Integer.parseInt(offset)<=0){
		offset = "0" ;
	}
	if (!"".equals(offset) && !"0".equals(offset)) {
		nowPage = Integer.parseInt(offset) / pageBean.getPageSize() + 1;
	}
	String url = CommonString.getFormatPara(request.getQueryString());
	if (!"".equals(url)) {
		if (url.indexOf("offset") != -1 && url.indexOf("&") == -1) {
			url = "";
		} else if (url.indexOf("offset") != -1) {
			url = "&" + url.substring(url.indexOf("&") + 1);
		} else {
			url = "&" + url;
		}
	}
	String w = " and is_pub=1 and id!=138061   and (link_other='' or link_other is null )";
	//String w = " and title like '%人物%' ";

	if(!id.equals("")){
		m = dbHelper.getMap(" select * from pro_famous_person where id=?",new Object[]{id}) ;
		w += " and title like '%"+CommonString.getFormatPara(m.get("name"))+"%' ";
	}
	pageBean.setNowPage(nowPage);
	pageBean.setCondition(w);
	pageBean.setParams(url);
	pageBean.setOrderBy("id desc");
	lr = pageBean.getDatasByWebService("Web21sunDBHelper");
	
	List <Map>ls = dbHelper.getMapList(" select top 6 * from pro_famous_person order by id desc " );
	List<Map> ft = WEBDBHelper.getMapList(" select top 5 title,id,link_other,image,intro from people_lundao_detail order by id desc ","Web21sunDBHelper");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%if(id.equals("")){%>
<title>工程机械名人风采 - 铁臂名人堂</title>
<meta name="keywords" content="工程机械名人风采" />
<meta name="description" content="铁臂名人堂为您提供详细的工程机械名人风采和工程机械名人动态,找工程机械名人动态,就上铁臂名人堂！" />
<%}else if(!id.equals("")){%>
<title><%=CommonString.getFormatPara(m.get("name"))%>风采 – 铁臂名人堂</title>
<meta name="keywords" content="<%=CommonString.getFormatPara(m.get("name"))%>,<%=CommonString.getFormatPara(m.get("name"))%>风采" />
<meta name="description" content="铁臂名人堂为您提供详细的<%=CommonString.getFormatPara(m.get("name"))%>风采和<%=CommonString.getFormatPara(m.get("name"))%>动态等相关内容,找名字动态,就上铁臂名人堂！" />
<%}%>
<meta name="renderer" content="webkit">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="author" content="design by www.21-sun.com" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<link href="/style/style.css" rel="stylesheet" type="text/css" />
<link href="/style/new_style.css" rel="stylesheet" type="text/css" />
<link href="mingren.css" rel="stylesheet" type="text/css" />
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
<%if(id.equals("")){%>
<jsp:include page="/include/top_mingren.jsp" flush="true"/>
<%}else{%>
<jsp:include page="/include/top_mingren_detail.jsp" flush="true"/>
<%}%>
<!--top end--> 
<!--面包屑-->
<jsp:include page="/mingren/tongji.jsp"/>
<div class="contain980 mb10">
  <h3 class="breadCrumbs"> <a href="/">首页</a> &gt; <a href="/fclist/">名人风采</a><%if(!id.equals("")){%> &gt; <%=CommonString.getFormatPara(m.get("name"))%>风采<%}%></h3>
</div>
<!--面包屑结束--> 
<!--main-->
<div class="contain980 fm-wryh"> 
  <!--left-->
  <div class="contain980 fix">
    <div class="s_mleft"> 
      <!--新闻-->
      <div class="comBox">
        <div class="bd fix">
          <%for(int i = 0; lr != null && i<lr.size();i++){%>
          <div class="s_topNews new_news mt10"> <a target="_blank" href="http://news.21-sun.com/detail/<%=CommonString.getFormatPara(lr.get(i).get("html_filename")).substring(0,4)%>/<%=CommonString.getFormatPara(lr.get(i).get("html_filename")).substring(4,6)%>/<%=CommonString.getFormatPara(lr.get(i).get("html_filename"))%>" title="<%=CommonString.getFormatPara(lr.get(i).get("title"))%>">
            <%if(!CommonString.getFormatPara(lr.get(i).get("image")).equals("")&&!CommonString.getFormatPara(lr.get(i).get("image")).equals("null")){%>
            <img src="http://news.21-sun.com/UserFiles/Image/<%=CommonString.getFormatPara(lr.get(i).get("image"))%>" class="img" alt="<%=CommonString.getFormatPara(lr.get(i).get("title"))%>" />
            <%}%>
            </a>
            <div class="intro"> <a target="_blank" href="http://news.21-sun.com/detail/<%=CommonString.getFormatPara(lr.get(i).get("html_filename")).substring(0,4)%>/<%=CommonString.getFormatPara(lr.get(i).get("html_filename")).substring(4,6)%>/<%=CommonString.getFormatPara(lr.get(i).get("html_filename"))%>" title="<%=CommonString.getFormatPara(lr.get(i).get("title"))%>">
              <h3><%=CommonString.getFormatPara(lr.get(i).get("title"))%></h3>
              <div class="text"><%=CommonHtml.filterHTML(CommonString.getFormatPara(lr.get(i).get("content")),90)%>...</div>
              <div class="time pr"><%=CommonDate.getFormatDate("yyyy-MM-dd",CommonString.getFormatPara(lr.get(i).get("add_date")))%></div>
              <span class="btn">继续阅读</span></a> <!--<span class="tag">标签：<a href="#">三一</a></span>--> </div>
          </div>
          <%}%>
          <div class="pages">
            <form id="theform" name="theform" method="post" action="">
              <div id="pagination" class="paging  page" style="margin-right:3px;">
			    <%if(!id.equals("")){%>
                <tags:page_mrfc_detail pageBean="<%=pageBean%>" />
				<%}else if(id.equals("")){%>
				 <tags:page_mrfc_list pageBean="<%=pageBean%>" />
                <%}%>
              </div>
            </form>
          </div>
        </div>
      </div>
      <!--三一代理商--> 
      
    </div>
    <!-- left end--> 
    <!--right-->
    <div class="s_right">
      <div class="comBox01 mb10">
        <div class="hd fix">
          <h3><span class="more"><a href="/list/" target="_blank" title="更多名人展示">更多</a></span>名人展示</h3>
        </div>
        <div class="bd fix">
          <div class="s_info">
            <ul class="fix">
            <%for(int i = 0;ls != null && i<ls.size();i++ ){%>
              <li><a href="/mingren_detail_<%=CommonString.getFormatPara(ls.get(i).get("id"))%>.htm" title="<%=CommonString.getFormatPara(ls.get(i).get("name"))%>"><img src="/uploadfiles/<%=CommonString.getFormatPara(ls.get(i).get("img"))%>" width="84" height="85"  alt="<%=CommonString.getFormatPara(ls.get(i).get("name"))%>"/><span><%=CommonString.getFormatPara(ls.get(i).get("name"))%></span></a></li>
            <%}%>  
            </ul>
          </div>
        </div>
      </div>
      <div class="comBox01 mb10">
        <div class="hd fix">
          <h3  class="ot"><span class="more"><a href="/ftlist/" target="_blank" title="更多名人访谈">更多</a></span>名人访谈</h3>
        </div>
        <div class="bd fix">
          <ul class="mf fix">
          <%for(int i = 0; ft != null && i<ft.size();i++){%>
            <li <%if(i==0){%>class="hover"<%}%>><a target="_blank" href="<%=CommonString.getFormatPara(ft.get(i).get("link_other"))%>" title="<%=CommonString.getFormatPara(ft.get(i).get("title"))%>"><b <%if(i<=2){%>class="qs"<%}%>><%=i+1%></b><img src="<%=CommonString.getFormatPara(ft.get(i).get("image"))%>" width="61" height="65"  alt="<%=CommonString.getFormatPara(ft.get(i).get("title"))%>" class="xy" />
              <p><strong><%=CommonString.getFormatPara(ft.get(i).get("title"))%></strong><span class="xy"><%=CommonString.getFormatPara(ft.get(i).get("intro")).length()>9?CommonString.getFormatPara(ft.get(i).get("intro")).substring(0,18):CommonString.getFormatPara(ft.get(i).get("intro"))%>...</span></p>
              </a></li>
          <%}%> 
          </ul>
        </div>
      </div>
      <!--
      <div class="comBox01 mb10">
        <div class="hd fix">
          <h3  class="ot"><span class="more"><a href="#" target="_blank">更多</a></span>名人动态</h3>
        </div>
        <div class="bd fix">
          <ul class="fix s_pro_cates">
            <li><a href="#">三一名人风采</a></li>
            <li><a href="#">三一名人风采</a></li>
            <li><a href="#">三一名人风采</a></li>
          </ul>
        </div>
      </div>
      <div class="comBox01 mb10">
        <div class="hd fix">
          <h3 class="ot"><span class="more"><a href="#" target="_blank">更多</a></span>知名人物访谈</h3>
        </div>
        <div class="bd fix">
          <div class="s_info">
            <ul class="fix zmrw">
              <li><a href="#"><img src="images/temp/temp_1.jpg" width="84" height="85"  alt="向文波"/><span>向文波</span></a></li>
              <li><a href="#"><img src="images/temp/temp_1.jpg" width="84" height="85"  alt="向文波"/><span>向文波</span></a></li>
            </ul>
          </div>
        </div>
      </div>
      -->
    </div>
  </div>
</div>
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
    
          $('.mf li').hover(function(){
				$(this).addClass('hover').siblings().removeAttr('class') ;
			})
    
</script>
</body>
</html>