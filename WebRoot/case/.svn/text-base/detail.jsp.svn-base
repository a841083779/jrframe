<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %><%@page import="com.jerehnet.util.common.CommonString"%><%@page import="java.util.Map"%><%@page import="com.jerehnet.util.dbutil.DBHelper"%><%@page import="com.jerehnet.util.common.CommonDate"%><%@page import="com.jerehnet.util.common.Common"%><%@page import="java.util.List"%><%@page import="javax.sql.CommonDataSource"%>
<%@page import="com.jerehnet.util.common.CommonHtml"%><%@ taglib uri="/WEB-INF/classes/oscache.tld" prefix="cache"%><%
	String id = CommonString.getFormatPara(request.getParameter("id")) ;  // 案例的id
	String sel_sql = " select title,pub_date,content,reply_count from pro_case_news where id=?" ;
	DBHelper dbHelper = DBHelper.getInstance() ;
	Map case_info = null ;
	if(!"".equals(id)){
		case_info = dbHelper.getMap(sel_sql,new Object[]{id}) ;
	}
	if(null==case_info || case_info.size()<=0){
		response.sendRedirect("/case") ;
	}
%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title><%=CommonString.getFormatPara(case_info.get("title")) %>__案例故事 - 铁臂商城</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="keywords" content="工程机械产品案例,工程机械产品订单案例" />
<meta name="description" content="<%=CommonHtml.filterHTML(CommonString.getFormatPara(case_info.get("content"))).length()>50?CommonHtml.filterHTML(CommonString.getFormatPara(case_info.get("content"))).substring(0,50):CommonHtml.filterHTML(CommonString.getFormatPara(case_info.get("content"))) %>" />
<meta name="author" content="design by www.21-sun.com" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<link href="/style/style.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="/scripts/jquery-1.7.min.js"></script>
<script type="text/javascript" src="/scripts/scripts.js"></script>
<!--[if (IE 6)]>
<link href="/style/pngfix.css" media="screen" rel="stylesheet" type="text/css" />
<![endif]-->
</head>
<body style="background-color:#ffd124;">
<!--top-->
<jsp:include page="/include/case/topcase.jsp" flush="true"></jsp:include>
<div class="caseBanner">
  <div class="contain980"><img src="/images/case_banner.jpg" width="980" height="320" /></div>
</div>
<div class="caseMain">
  <div class="contain980"><img src="/images/casebanner_shadow.gif" width="980" height="18" /></div>
  <!--面包屑-->
  <div class="contain980">
    <h3 class="breadCrumbs"><a href="/">铁臂商城</a> &gt;&gt; <a href="/case/">产品案例</a></h3>
  </div>
  <!--面包屑结束--> 
  <cache:cache cron="*/1 * * * * ?">
  <div class="contain980 content">
    <!--left-->
   <jsp:include page="/include/case/left.jsp" flush="true"></jsp:include>
    <!--right-->
    <div class="caseRight caseDetail">
      <a href="/case/" title="返回列表" class="backlist">&nbsp;</a>
      <h2 class="ntitle"><%=case_info.get("title") %></h2>
      <div class="info blue"><%=CommonDate.getFormatDate("yyyy年MM月dd日",case_info.get("pub_date")) %>　<a href="javascript:;" onclick="javascript:comments() ;">我要评论(<font id="commentscount"><%=CommonString.getFormatPara(case_info.get("reply_count")) %></font>)</a></div>
      <div class="textContent">
      	<%=CommonString.getFormatPara(case_info.get("content")) %>
      </div>
     </cache:cache>
      
      <div class="share">
      <!-- Baidu Button BEGIN -->
      <div id="bdshare" class="bdshare_t bds_tools get-codes-bdshare">
      <span class="bds_more">分享到：</span>
      <a class="bds_qzone"></a>
      <a class="bds_tsina"></a>
      <a class="bds_tqq"></a>
      <a class="bds_renren"></a>
      <a class="shareCount"></a>
      </div>
      <script type="text/javascript" id="bdshare_js" data="type=tools&amp;uid=537258" ></script>
      <script type="text/javascript" id="bdshell_js"></script>
      <script type="text/javascript">
       document.getElementById("bdshell_js").src = "http://bdimg.share.baidu.com/static/js/shell_v2.js?cdnversion=" + Math.ceil(new Date()/3600000)
      </script>
      <!-- Baidu Button END -->
      </div>
      
      <div class="comment">
        <h3>最新评论</h3>
        <ul id="commentListId" class="commentList">
        <!-- 取出一条记录的评论 -->
        <%
        	String comments_sql = " select pub_date,name,pub_date,comment_content from pro_case_news_reply where case_news_id=? " ;
        	List<Map> commentsList = null ;
        	if(!"".equals(id)){
        		commentsList = dbHelper.getMapList(comments_sql,new Object[]{id}) ;
        	}
        	if(commentsList!=null && commentsList.size()>0){
        		for(Map oneMap:commentsList){
        			%>
        			 <li> <strong class="l"><%=CommonString.getFormatPara(oneMap.get("name")) %>：</strong> <span class="r"><%=CommonDate.getFormatDate("yyyy-MM-dd HH:mm",oneMap.get("pub_date")) %></span>
			            <div class="clc"> <%=CommonString.getFormatPara(oneMap.get("comment_content")) %> </div>
			         </li>
        			<%
        		}
        	}
        %>
        </ul>
      </div>

      <div class="l plTitle"><strong>我来说两句</strong>  (<font id="commentscount2"><%=CommonString.getFormatPara(case_info.get("reply_count")) %></font> 人参与)</div>
     <div class="plForm">
        <form id="comment_form" name="comment_form" method="post" action="">
          <input type="hidden" value="38" id="group_id" name="group_id">
          <div class="input">
            <textarea rows="5" cols="45" id="zd_comment_content" name="zd_comment_content"></textarea>
          </div>
          <div style="height:29px;" class="c tright pt10 pb10"> <span class="l"><b>您的称呼：</b>
            <input type="text" style="width:120px; height:18px; line-height:18px; border:#ccc 1px solid;" id="zd_name" name="zd_name">
            <input type="checkbox" onclick="javascript:test2();" checked="checked" id="namecheckbox" name="namecheckbox">
            匿名评价 </span> <span class="r">
            <input type="button" onclick="doComments();" class="plBtn" value="&nbsp;" id="button" name="button">
            </span> 
            <input type="hidden" name="tableName" id="tableName" value="pro_case_news_reply"/>
           <input type="hidden" name="zd_pub_date" id="zd_pub_date" value="<%=CommonDate.getToday("yyyy-MM-dd HH:mm:ss") %>"/>
           <input type="hidden" name="zd_case_news_id" id="zd_case_news_id" value="<%=id %>"/>
           <input type="hidden" name="flag_ip" id="flag_ip" value="yes"/>
           <input type="hidden" name=""/>
            </div>
        </form>
      </div>
    </div>
    
  <div class="clear"></div>  
  </div>
  <div class="contain980"><img src="/images/zhengwen.gif" width="980" height="145" border="0" usemap="#Map" />
    <map name="Map" id="Map">
      <area shape="rect" coords="642,43,837,103" href="http://news.21-sun.com/online.htm "  target="_blank" title="我要参与" />
    </map>
  </div>
<!--foot--> 
<div align="center">
  <table cellspacing="0" cellpadding="0" border="0" width="950" style="margin-top:7px">
    <tbody>
      <tr>
        <td class="td04"><p align="center"><span onclick="window.open('http://www.21-sun.com/service/guanggao/index.htm');" style="cursor: pointer;">广告服务</span> | <span onclick="window.open('http://aboutus.21-sun.net/contact/');" style="cursor: pointer;"> 联系方式</span> | <span onclick="window.open('http://aboutus.21-sun.net/');" style="cursor: pointer;"> 关于我们</span> | <span onclick="window.open('http://aboutus.21-sun.net/news/');" style="cursor: pointer;"> 本网动态</span> | <span onclick="window.open('http://aboutus.21-sun.net/contact/legal.jsp');" style="cursor: pointer;">法律声明</span> | <span onclick="window.open('http://aboutus.21-sun.net/map.htm');" style="cursor: pointer;">网站导航</span> | <span onclick="window.open('http://www.21-sun.com/guestbook/index.jsp');" style="cursor: pointer;"> 访问留言</span> <br/>
            主编:<a href="mailto:webmaster@21-sun.com" class="link09" rel="nofollow">webmaster@21-sun.com</a> 市场部:<a href="mailto:market@21-sun.com" class="link09" rel="nofollow">market@21-sun.com</a> 技术部:<a href="mailto:tech@21-sun.com" class="link09" rel="nofollow">tech@21-sun.com</a> 广告部:<a href="mailto:ads@21-sun.com" class="link09" rel="nofollow">ads@21-sun.com</a><br/>
            产品询价专线:0535-6792733 业务联系:(总机)0535-6722555 传真:0535-6723239<br/>
            <span onclick="window.open('http://www.21-sun.com');" style="cursor: pointer;">中国工程机械商贸网</span> Copyright &copy; 2000-<script type="text/javascript">document.write((new Date()).getFullYear());</script></p></td>
      </tr>
    </tbody>
  </table>
</div>
<div style="display:none"> 
  <script src="http://s17.cnzz.com/stat.php?id=2697829&web_id=2697829" language="JavaScript"></script> 
  <script src='http://w.cnzz.com/c.php?id=30058227&l=3' language='JavaScript'></script> 
</div>
<script type="text/javascript" src="/scripts/scrolltopcontrol.js"></script> 
<script src="http://int.dpool.sina.com.cn/iplookup/iplookup.php?format=js" type="text/javascript"></script>
<script src="/scripts/jBox-v2.3/jquery.jBox-2.3.min.js" type="text/javascript"></script>
<script type="text/javascript" src="/scripts/jquery.form.js"></script>
<link type="text/css" rel="stylesheet" href="/scripts/jBox-v2.3/Skins2/Blue/jbox.css"></link>
<script type="text/javascript">
function addCookie(){　 // 加入收藏夹
    if (document.all){
        window.external.addFavorite('http://product.21-sun.com', '21-sun产品中心');
    }else if (window.sidebar){
        window.sidebar.addPanel('21-sun产品中心', 'http://www.product.21-sun.com', "");
    }
}
jQuery("body").bind("contextmenu", function() {
  return false;
});
function comments(){
 jQuery(".textContent").slideToggle("slow"); 
 setTimeout('jQuery("#zd_comment_content").focus()',300)  ; 
}
function test2(){
	if(jQuery("#namecheckbox").attr("checked")==true || jQuery("#namecheckbox").attr("checked")=="checked"){
	  jQuery('#zd_name').val(remote_ip_info['province']+remote_ip_info['city']+'的网友') ;
	}else{
		jQuery('#zd_name').val('');
	} ;
}
jQuery('#zd_name').val(remote_ip_info['province']+remote_ip_info['city']+'的网友') ;
function doComments(){	
	if(jQuery.trim(jQuery("#zd_comment_content").val())==""){
		jQuery.jBox.tip("请您输入评论内容") ;
		jQuery("#zd_comment_content").focus() ;
		return false ;
	}
	if(jQuery.trim(jQuery("#zd_name").val())==""){
		jQuery.jBox.tip("请您输入称呼") ;
		return false ;
	}
	 if(jQuery("#flag_ip").val()=="yes"){
	 	jQuery("#comment_form").ajaxSubmit({
		url:"/action/crud.jsp" ,
		type:"post" ,
		success:function(msg){
		if(jQuery.trim(msg)>0){  // 评论提交成功
			var htm=""  ;
			htm+='<li>' ;
			htm += '<strong class="l">'+jQuery("#zd_name").val()+'：</strong> ' ;
			htm += '<span class="r">'+jQuery("#zd_pub_date").val().substring(0,16)+'</span>' ;
			htm += '<div class="clc"> '+jQuery("#zd_comment_content").val()+' </div>' ;
			htm += '</li>' ;
			if(jQuery("#commentListId li:first").html()==null){
				jQuery("#commentListId").append(htm) ;
				jQuery("#zd_comment_content").val('') ;
			}else{
				jQuery("#commentListId li:first").before(htm) ;
				jQuery("#zd_comment_content").val('') ;
			}
			// 更改评论数
			jQuery.ajax({
			  url:"/action/ajax.jsp",
			  type:"post",
			  data:{flag:"changeonefield",field:"reply_count",id:"<%=id%>",tableName:"pro_case_news"} ,
			  success:function(msg){
			    jQuery("#commentscount").html(jQuery.trim(msg)) ; //  更新评论数
			    jQuery("#commentscount2").html(jQuery.trim(msg)) ;
			  }
			}) ;
			jQuery("#flag_ip").val("yes") ;
		}else{
		  jQuery.jBox.tip("服务器正忙，请您稍候再试....") ;
		}
		}
	  });
	 }else{
	  jQuery.jBox.tip("您已经评论过了。") ;
	 }
}
jQuery(function(){
	jQuery.ajax({
		url:"/action/ajax.jsp", 
		type:"post" ,
		data:{flag:"ifcancomments",myip:'<%=Common.getIp(request,1)%>',caseid:"<%=id%>"},
		success:function(msg){
			if(jQuery.trim(msg)>0){
				jQuery("#flag_ip").val("yes") ;  // 是否允许评论  yes 允许 no 不允许
			}else{
			  jQuery("#flag_ip").val("yes") ;
			}
		}
	}) ;
	jQuery.ajax({
	url:"/action/ajax.jsp",
	type:"post",
	data:{flag:"viewCount",id:'<%=id%>',tableName:"pro_case_news"},
	success:function(){}
	}) ;
}) ;
</script> 
<!--end of foot--> 
</body>
</html>