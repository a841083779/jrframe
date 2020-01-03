<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.jerehnet.util.common.Common"%>
<%@page import="com.jerehnet.util.common.CommonString"%>
<%@page import="com.jerehnet.util.dbutil.DBHelper"%>
<%@page import="com.jerehnet.util.dbutil.PageBean"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.jerehnet.util.common.CommonDate"%>
<%@page import="java.sql.Connection"%>
<%@page import="com.jerehnet.util.common.CommonApplication"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="tags" %><%@ taglib uri="/WEB-INF/classes/oscache.tld" prefix="cache"%><%
	Map memberInfo = (Map)session.getAttribute("memberInfo");
	String usern="";
    if(memberInfo==null){
		    Common.do302(response,"http://product.21-sun.com/tuan/");
			return;
	}
	usern=CommonString.getFormatPara(memberInfo.get("username"));
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
	String order_state = CommonString.getFormatPara(request.getParameter("order_state")) ;
	
    StringBuffer whereStr = new StringBuffer(" and add_user= '"+usern+"' ") ;
	//分页开始
	if(!order_state.equals("")){
	   whereStr.append(" and order_state = "+order_state);
	}
	PageBean pageBean = new PageBean() ;
	pageBean.setPageSize(10) ;
	Integer nowPage = 1 ;
	if(!"".equals(offset) && !"0".equals(offset)){
	 	  nowPage = Integer.parseInt(offset)/pageBean.getPageSize()+1 ;
	}
	pageBean.setNowPage(nowPage) ;
	pageBean.setParams(url) ;
	pageBean.setCondition(whereStr.toString()) ;
	pageBean.setFields("add_user,realname,add_user_phone,price,order_state,product_factoryname,product_catalogname,product_name,product_img,order_no,file_name") ;
	pageBean.setTableName("pro_online_order") ;
    pageBean.setOrderBy("add_date desc") ;
	List<Map> orderList = pageBean.getDatas() ; 
	
	DBHelper dbHelper = DBHelper.getInstance() ;
	List<Map> proList = null ;
	proList = dbHelper.getMapList("select top 4 img2,file_name,factoryname,catalogname,name from pro_products where is_show=1 order by  view_count desc") ;
	
	int all=0;  int wait_pay=0;  int already_pay=0;
	all=(Integer)dbHelper.getOne("select count(id) as nums from pro_online_order where add_user='"+usern+"'") ;
	wait_pay=(Integer)dbHelper.getOne("select count(id) as nums from pro_online_order where order_state=0 and add_user='"+usern+"'") ;
	already_pay=(Integer)dbHelper.getOne("select count(id) as nums from pro_online_order where order_state=1 and add_user='"+usern+"'") ;
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
<script type="text/javascript" src="/scripts/idTabs.js"></script>
<script type="text/javascript" src="/scripts/jBox-v2.3/jquery.jBox-2.3.min.js"></script>
<script type="text/javascript" src="/scripts/jBox-v2.3/i18n/jquery.jBox-zh-CN.js"></script>
<link type="text/css" rel="stylesheet" href="/scripts/jBox-v2.3/Skins2/Blue/jbox.css" />
</head>
<body>
<script>
		function pay(a){
		    //alert(a);
			window.open("/tools/pay/alipayapi.jsp?order_num="+a+"&pay_mode=168002&pay_gateway_no=Alipay ");
		}
</script>
<!--top-->
<div class="m_newTop">
  <div class="wrapper">
    <h2 class="l"><a href="/member/index.jsp"><img width="219" height="40" src="images/mem_logo.png" alt="铁臂商城购物中心"></a></h2>
    <ul class="m_nav">
      <li><a href="#" class="n">网站<i></i></a>
        <div class="box"> <a href="http://www.21-sun.com/" target="_blank">网站首页</a> <a href="http://product.21-sun.com/" target="_blank">铁臂商城</a> <a href="http://www.wajueji.com/" target="_blank">铁臂兄弟连</a> <a href="http://koubei.21-sun.com/" target="_blank">铁臂口碑</a> <a href="http://photo.21-sun.com/" target="_blank">铁臂图库</a> <a href="http://weixiu.21-sun.com/" target="_blank">铁臂维修</a> <a href="http://video.21-sun.com/" target="_blank">铁臂视频</a> <a href="http://news.21-sun.com/" target="_blank">铁臂资讯</a> </div>
      </li>
      <li><a href="#" class="n">应用<i></i></a>
        <div class="box"> <a href="/member/koubei.jsp">我的口碑</a> <a href="#">我上传的图片</a> <a href="/member/weixiu.jsp">我的维修知识</a> <a href="#">我上传的视频</a> </div>
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
    <div class="b_nav_member" style="background: none;width: auto;"> <a href="/member/"><img width="30" height="30" src="<%=CommonString.getFormatPara(memberInfo.get("image"))%>" onerror="showImgDelay(this,'http://product.21-sun.com/uploadfiles/no_big.gif',2);" class="b_faceimg"/></a> <span class="b_name" style="width: auto;"> <a href="/member/" style="color: #FFF;"><%=CommonString.getFormatPara(memberInfo.get("username"))%></a> <a href="javascript:void(0)" onclick="loginOut();"  style="color:#fff;">[退出]</a> </span> </div>
  </div>
</div>
<!--top end-->

<div class="wrapper m_contain mb20 fix"> 
  <!--left-->
  <div class="m_leftPart">
    <div class="mem-con">
      <div class="mem-face"> <img width="175" height="175" src="<%=CommonString.getFormatPara(memberInfo.get("image"))%>" onerror="showImgDelay(this,'http://product.21-sun.com/uploadfiles/no_big.gif',2);" /> </div>
      <ul style="display:none" class="mem-info">
        <li><strong>780</strong><br>
          粉丝</li>
        <li style="border:none;"><strong>895</strong><br>
          关注</li>
      </ul>
      <ul align="center" class="mem-info">
        <span ><%=CommonString.getFormatPara(memberInfo.get("username"))%></span>
      </ul>
    </div>
    <h3 class="mt">我发布的</h3>
    <ul class="m_leftMenu">
      <li><a class="selected" href="koubei.jsp"><span class="n"><img src="images/menu_ico01.png">我的口碑</span></a></li>
      <li><a href="#"><span class="n"><img src="images/menu_ico02.png">我上传的图片</span></a></li>
      <li><a href="/member/weixiu.jsp"><span class="n"><img src="images/menu_ico03.png">我的维修知识</span></a></li>
      <li><a href="#"><span class="n"><img src="images/menu_ico04.png">我的上传视频</span></a></li>
    </ul>
    <div class="m_line"></div>
  </div>
  <!--left end--> 
  <!--right-->
  <div class="m_rightPart">
    <div class="mem_top01 clearfix"> <span class="l"> <strong class="name">我的订单</strong>
	<a style="margin-right:10px;" href="/member/order_list.jsp" class="selected">全部订单(<%=all%>)</a>
	<a style="margin-right:10px;" href="/member/order_list.jsp?order_state=0">等待付款(<%=wait_pay%>)</a> 
      <!--<a style="margin-right:10px;" href="/member/order/index.jsp?s=4">待收货(0)</a>--> 
      <a style="margin-right:10px;" href="/member/order_list.jsp?order_state=1">已付款(<%=already_pay%>)</a> </span> <span class="r" style="font-family:微软雅黑"> 
	  <a href="/member/">首页</a> &gt;&gt; 我的订单 </span> </div>
    <div class="filter_main">
      <ul class="filter">
        <li> <a href="javascript://void(0);" style="text-decoration: none; cursor: default;" class="selected">全部订单</a> </li>
      </ul>
    </div>
    <div class="orderList">
      <table width="100%" cellspacing="0" cellpadding="0" border="0">
        <tbody>
          <tr>
            <th width="157"> 订单产品 </th>
            <th width="93"> 联系人 </th>
            <th width="93"> 电话 </th>
            <th width="87"> 定金 </th>
            <th width="50" style="display:none"> 评价 </th>
            <th width="85"> 支付定金 </th>
            <th width="63"> 订单状态 </th>
            <th> 操作 </th>
          </tr>
		  <%	  
							if (orderList != null && orderList.size() > 0) {
										for (Map oneMap : orderList) {
		  %> 
		  
          <tr>
            <td><a href="http://product.21-sun.com/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name"))%>" target="_blank" class="n1">
			<div style="text-align:left; width:157px; margin:0 auto;">
			<img onerror="showImgDelay(this,'/uploadfiles/no_big.gif',2);" src="http://product.21-sun.com/uploadfiles/<%=CommonString.getFormatPara(oneMap.get("product_img"))%>" class="img"><span class="ftx-03">
			<%=CommonString.getFormatPara(oneMap.get("product_factoryname"))%><%=CommonString.getFormatPara(oneMap.get("product_name"))%><%=CommonString.getFormatPara(oneMap.get("product_catalogname"))%></span> </div></a></td>
            <td style="padding:0;"><span class="ftx-03"><%=CommonString.getFormatPara(oneMap.get("add_user"))%></span></td>
            <td><span class="ftx-03"><%=CommonString.getFormatPara(oneMap.get("add_user_phone"))%></span></td>
            <td><s>￥2000.0</s><span class="ftx-03" style="color:red">￥2000.0</span></td>
            <td style="display:none"><span class="ftx-03">已评价</span></td>
            <td><span class="ftx-03">￥2000.0</span></td>
            <td><span class="ftx-03"><%=CommonString.getFormatPara(oneMap.get("order_state")).equals("1")?"已完成":"待付款"%></span></td>
            <td width="100" class="order-doi"><input type="hidden" value="0">
			 <%if(CommonString.getFormatPara(oneMap.get("order_state")).equals("1")){%>
			 <a href="http://product.21-sun.com/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name"))%>" class="btn-img btn-buyagain" target="_blank"> </a> 
			 <a href="/member/order_detail.jsp?order_num=<%=CommonString.getFormatPara(oneMap.get("order_no"))%>" target="_blank" style="display:block;">查看详情</a>
             <%}else{%>
			 <a href="javascript:void(0)" class="btn-img btn-payfor" onclick="pay('<%=CommonString.getFormatPara(oneMap.get("order_no"))%>');">立即支付</a> 
			 <%}%>
			  </td>
          </tr>
		  <%
								}
									} else {
		  %>
		  <tr><td colspan= "8">暂无订单！</td></tr>
		  <%}%>

        </tbody>
      </table>
	  <!--分页-->
      <div class="pt10 mb10 clearfix" style="display:none">
        <div class="pagin r"> <span class="prev-disabled">上一页<b></b></span> <a class="current">1</a> <span class="next-disabled">下一页<b></b></span> </div>
      </div>
      <div id="order03" style="margin-top:10px;">
        <div class="mt">
          <ul class="tabs">
            <li> <a href="#order1" class="selected">猜你喜欢</a> </li>
          </ul>
        </div>
        <div class="mc clearfix">
          <ul class="list" id="order1">
		    <%
			  if(proList != null && proList.size() > 0){
				  for(Map m : proList){
		    %>
            <li> <a href="http://product.21-sun.com/proDetail/<%=CommonString.getFormatPara(m.get("file_name"))%>" title="<%=CommonString.getFormatPara(m.get("factoryname"))%><%=CommonString.getFormatPara(m.get("name"))%><%=CommonString.getFormatPara(m.get("catalogname"))%>" target="_blank">
			<img  onerror="showImgDelay(this,'/uploadfiles/no_big.gif',2);" src="http://product.21-sun.com/uploadfiles/<%=CommonString.getFormatPara(m.get("img2"))%>"  width="160" height="140" class="img" alt="<%=CommonString.getFormatPara(m.get("factoryname"))%><%=CommonString.getFormatPara(m.get("name"))%><%=CommonString.getFormatPara(m.get("catalogname"))%>">
              <h3><%=CommonString.getFormatPara(m.get("factoryname"))%><%=CommonString.getFormatPara(m.get("name"))%><%=CommonString.getFormatPara(m.get("catalogname"))%></h3>
              <span class="price" style="display:none">¥ <strong>198.0</strong></span> 
              <!-- <span class="num">月销售 <strong>5816</strong> 件</span> --> 
              </a> </li>
            <%}}%>
          </ul>
        </div>
      </div>
    </div>
  </div>
  <!--right end--> 
</div>
<!--foot-->
<jsp:include page="/include/foot.jsp" flush="false"/>
<!--foot end-->
</body>
<script type="text/javascript" src="scripts/common.js"></script>

</html>
