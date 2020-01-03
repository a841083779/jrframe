<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%><%@page import="com.jerehnet.util.common.Common"%><%@page import="com.jerehnet.util.common.CommonString"%><%@page import="com.jerehnet.util.dbutil.DBHelper"%><%@page import="com.jerehnet.util.dbutil.PageBean"%><%@page import="java.text.SimpleDateFormat"%><%@page import="com.jerehnet.util.common.CommonDate"%><%@page import="java.sql.Connection"%><%@page import="com.jerehnet.util.common.CommonApplication"%><%@ taglib tagdir="/WEB-INF/tags" prefix="tags" %><%@ taglib uri="/WEB-INF/classes/oscache.tld" prefix="cache"%><%
	Map memberInfo = (Map)session.getAttribute("memberInfo");
    if(memberInfo==null){
		    Common.do302(response,"http://koubei.21-sun.com/");
			return;
	}
	DBHelper dbHelper = DBHelper.getInstance();
	String uuid=CommonString.getFormatPara(memberInfo.get("uuid"));
	String sql = " select * from pro_member where uuid= '"+uuid+"'" ;		
	Map user_info = null ;
	if(!"".equals(uuid)){
		user_info = dbHelper.getMap(sql) ;
	}
	if(null==user_info){
			Common.do302(response,"http://koubei.21-sun.com/");
			return;
	}
	String usern= CommonString.getFormatPara(user_info.get("username"));
	String nickname= CommonString.getFormatPara(user_info.get("nickname"));
	if(nickname.equals("")){nickname=usern;}
	

	//String sql="select * from pro_comments where is_show =1 order by add_date desc";
	String url = CommonString.getFormatPara(request.getQueryString()) ;  // 调整url，做分页处理
	if(!"".equals(url)){
		if(url.indexOf("offset")!=-1 && url.indexOf("&")==-1){
			url="" ;
		}else if(url.indexOf("offset")!=-1 ){
			url = "&"+url.substring(url.indexOf("&")+1) ;
		}else{
			url = "&"+url ;
		}
	}
    String offset = CommonString.getFormatPara(request.getParameter("offset")) ;
    StringBuffer whereStr = new StringBuffer(" and add_user= '"+usern+"' ") ;
	//分页开始
	PageBean pageBean = new PageBean() ;
	pageBean.setPageSize(10) ;
	Integer nowPage = 1 ;
	if(!"".equals(offset) && !"0".equals(offset)){
	 	  nowPage = Integer.parseInt(offset)/pageBean.getPageSize()+1 ;
	}
	pageBean.setNowPage(nowPage) ;
	pageBean.setParams(url) ;
	pageBean.setCondition(whereStr.toString()) ;
	pageBean.setFields("add_date,title,id,image,vote_count") ;
	pageBean.setTableName("pro_photo_group") ;
    pageBean.setOrderBy("add_date desc") ;
	List<Map> koubeiList = pageBean.getDatas() ; 
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">	
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="renderer" content="webkit">
<meta name="author" content="design by www.21-sun.com">
<title>个人中心</title>
<link href="/style/style.css" rel="stylesheet" type="text/css" />
<link href="style/style.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="/scripts/jquery.min.js"></script>
<script type="text/javascript" src="/scripts/jquery.raty.min.js"></script>
<script type="text/javascript" src="/scripts/scripts.js"></script>
<script type="text/javascript" src="/scripts/jBox-v2.3/jquery.jBox-2.3.min.js"></script>
<script type="text/javascript" src="/scripts/jBox-v2.3/i18n/jquery.jBox-zh-CN.js"></script>
<link type="text/css" rel="stylesheet" href="/scripts/jBox-v2.3/Skins2/Blue/jbox.css" />
</head>
<body>
<!--top-->
<div class="m_newTop">
  <div class="wrapper">
    <h2 class="l"><a href="/member/index.jsp"><img width="219" height="40" src="images/mem_logo.png" alt="铁臂商城购物中心"></a></h2>
    <ul class="m_nav">
      <li><a href="#" class="n">网站<i></i></a>
        <div class="box">
          <a href="http://www.21-sun.com/" target="_blank">网站首页</a>
          <a href="http://product.21-sun.com/" target="_blank">铁臂商城</a>
          <a href="http://www.wajueji.com/" target="_blank">铁臂兄弟连</a>
          <a href="http://koubei.21-sun.com/" target="_blank">铁臂口碑</a>
          <a href="http://photo.21-sun.com/" target="_blank">铁臂图库</a>
          <a href="http://weixiu.21-sun.com/" target="_blank">铁臂维修</a>
          <a href="http://video.21-sun.com/" target="_blank">铁臂视频</a>
          <a href="http://news.21-sun.com/" target="_blank">铁臂资讯</a>
        </div>
      </li>
      <li><a href="#" class="n">应用<i></i></a>
        <div class="box">
          <a href="/member/koubei.jsp">我的口碑</a>
          <a href="#">我上传的图片</a>
          <a href="/member/weixiu.jsp">我的维修知识</a>
          <a href="#">我上传的视频</a>
        </div>
      </li>
    </ul>
    <div class="top_search" style="display:none">
      <input type="text" name="top_input" id="top_input" value="请输入搜索内容" onfocus="if(this.value == '请输入搜索内容'){this.value=''}" onblur="if(this.value == ''){this.value='请输入搜索内容'}" class="top_input">
      <li class="select_box"> <span>帖子</span>
        <ul style="display: none;" class="son_ul">
          <li value="0">帖子</li>
          <li value="1">用户</li>
        </ul>
      </li>
      <input type="hidden" id="top_select" value="0">
      <a class="top_btn" href="javascript:void(0);" onclick="goSearch()"></a> 
      <script type="text/javascript">
          $(document).ready(function(){
             $('.son_ul').hide(); //初始ul隐藏
             $('.select_box span').hover(function(){ //鼠标移动函数
                $(this).parent().find('ul.son_ul').slideDown(200);  //找到ul.son_ul显示
                $(this).parent().find('li').hover(function(){$(this).addClass('hover')},function(){$(this).removeClass('hover')}); //li的hover效果
                $(this).parent().hover(function(){},
                                       function(){
                                           $(this).parent().find("ul.son_ul").slideUp(200); 
                                           }
                                       );
                },function(){}
                );
            $('ul.son_ul li').click(function(){
              $("#top_select").val($(this).attr('value'));
              $(this).parents('li').find('span').html($(this).html());
              $(this).parents('li').find('ul').slideUp(200);
            });
          });
          function goSearch(){
              var tar = $("#top_select").val();
              var str = $("#top_input").val();
              if($.trim(str) == ''){
                  $.jBox.tip('请输入搜索内容');
              }
              if(tar == 0){
                   window.location.href='/service/searchList.jsp?keyWord='+str;
              }else{
                  window.location.href='/newMember.jsp?keyWord='+str;
              }
          }
      </script> 
    </div>
    <div class="mtl m_set"><a class="m_Ico" href="info_edit.jsp"><em></em></a></div>
    <div class="b_nav_member" style="background: none;width: auto;">
      <a href="/member/"><img width="30" height="30" src="<%= CommonString.getFormatPara(user_info.get("image"))%>" onerror="showImgDelay(this,'http://product.21-sun.com/uploadfiles/no_big.gif',2);" class="b_faceimg"/></a> 
      <span class="b_name" style="width: auto;">
        <a href="/member/" style="color: #FFF;"><%=nickname%></a>
        <a href="javascript:void(0)" onclick="loginOut();"  style="color:#fff;">[退出]</a>
      </span>
    </div>
  </div>
</div>
<!--top end-->

<div class="wrapper m_contain mb20 fix">
  <!--left-->
  <div class="m_leftPart">
    <div class="mem-con">
      <div class="mem-face">
        <img width="175" height="175" src="<%= CommonString.getFormatPara(user_info.get("image"))%>" onerror="showImgDelay(this,'http://product.21-sun.com/uploadfiles/no_big.gif',2);" />
      </div>
      <ul style="display:none" class="mem-info">
        <li><strong>780</strong><br>
          粉丝</li>
        <li style="border:none;"><strong>895</strong><br>
          关注</li>
      </ul>
	  <ul align="center" class="mem-info">
	  <span ><%=nickname%></span>
      </ul>
    </div>
    
    <h3 class="mt">我发布的</h3>
    <ul class="m_leftMenu">
      <li><a  href="koubei.jsp"><span class="n"><img src="images/menu_ico01.png">我的口碑</span></a></li>
      <li><a class="selected"  href="#"><span class="n"><img src="images/menu_ico02.png">我上传的图片</span></a></li>
      <li><a href="/member/weixiu.jsp"><span class="n"><img src="images/menu_ico03.png">我的维修知识</span></a></li>
      <li><a href="#"><span class="n"><img src="images/menu_ico04.png">我的上传视频</span></a></li>
    </ul>
    <div class="m_line"></div>
    
  </div>
  <!--left end-->
  <!--right-->
  <div class="m_rightPart">
    <div class="mr_menu">
      <ul class="fix">
        <li><a href="#" class="selected"><span style="color:white">我的图片</span></a></li>
      </ul>
    </div>
    
    <div class="m_kbList">
      <ul class="fix">
	  
	  
	    <%  
		   String images="";
		   if(koubeiList !=null && koubeiList.size()>0){
			   for(Map oneMap:koubeiList){
			   images=CommonString.getFormatPara(oneMap.get("image"));
			   if(images.indexOf("resource.21-sun")<0){images="http://product.21-sun.com/uploadfiles/"+images;}
	   %>
           <li class="kbl" style="border-bottom:0px; width:440px;float:left">
          <div class="face" style="width:225px;height:160px;">
		  <img style="width:225px;height:160px;" src="<%=images%> " onerror="showImgDelay(this,'http://product.21-sun.com/uploadfiles/no_big.gif',2);" />
		  </div>
          <div class="intro" style="margin-left:260px">
            <strong class="name"><br><%=nickname%></strong>
            <div class="time"><br><br><%=CommonDate.getFormatDate("yyyy-MM-dd",CommonString.getFormatPara(oneMap.get("add_date")))%> </div>
            <div class="text">
			<br><%=CommonString.getFormatPara(oneMap.get("title"))%>  &nbsp;<a style="color:red" href="http://photo.21-sun.com/ndetail_for_<%= CommonString.getFormatPara(oneMap.get("id"))%>.htm" target="_blank">查看全文>></a>
            </div>    
          </div>
        </li>

        <%}}%>
      </ul>
    </div>
    
	   <div id="pagination" class="page">
          <tags:page pageBean="<%=pageBean%>" />
       </div>
	
  </div>
  <!--right end-->
</div>
<!--foot-->
<jsp:include page="/include/foot.jsp" flush="false"/>
<!--foot end-->
</body>
<script type="text/javascript" src="scripts/common.js"></script>
<script>
function loginOut(){
	jQuery.ajax({
		url:'/action/ajax.jsp?flag=logout',
		async:false,
		cache:false,
		success:function(data){
				jQuery.jBox.tip("退出成功！");
				setTimeout("window.location.reload()",1000);
		}
	});
}
</script>
</html>