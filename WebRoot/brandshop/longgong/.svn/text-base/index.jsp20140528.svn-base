<%@ page language="java" import="com.jerehnet.util.dbutil.PageBean,com.jerehnet.util.common.CommonString,com.jerehnet.util.dbutil.DBHelper,java.util.*" pageEncoding="UTF-8"%>
<%
    Map oneMap = null ;
	DBHelper dbHelper = DBHelper.getInstance() ;
	//挖掘机 
	//and zoomlion_hot=11
	String sql_wj = "select top 4 id,name,file_name,img2,catalogname_spe,catalognum_spe,zoomlion_hot_pic ,catalogname from pro_products where factoryid=135 and is_show=1 and catalognum_spe ='102' order by view_count desc" ;
	List<Map> productsListWj = null ;
	productsListWj = dbHelper.getMapList(sql_wj) ;
	//装载机
	String sql_zz = "select top 4 id,name,file_name,img2,catalogname_spe,catalognum_spe,zoomlion_hot_pic ,catalogname from pro_products where factoryid=135 and is_show=1 and catalognum_spe ='101' order by view_count desc" ;
	List<Map> productsListZz = null ;
	productsListZz = dbHelper.getMapList(sql_zz) ;
	//路面机械
	String sql_lm = "select top 4 id,name,file_name,img2,catalogname_spe,catalognum_spe,zoomlion_hot_pic ,catalogname from pro_products where factoryid=135 and is_show=1 and catalognum_spe = '103' order by view_count desc" ;
	List<Map> productsListLm = null ;
	productsListLm = dbHelper.getMapList(sql_lm) ;
	//叉车
    String sql_cc = "select  id,name,file_name,img2,catalogname_spe,catalognum_spe,zoomlion_hot_pic ,catalogname from pro_products where (id=15916 or id=15905 or id=21450 or id=15927) order by view_count desc" ;
	List<Map> productsListCc = null ;
	productsListCc = dbHelper.getMapList(sql_cc) ;
	//首页推荐
    String sql = "select top 10  id,name,file_name,img2,catalogname_spe,catalognum_spe,zoomlion_hot_pic ,catalogname from pro_products where factoryid=135 and is_show=1 and zoomlion_hot=11   order by view_count desc" ;
	List<Map> productList	= null ;
	productList = dbHelper.getMapList(sql) ;
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="author" content="design by www.21-sun.com" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<title>龙工旗舰店-中国工程机械商贸网</title>
<meta name="keywords" content="" />
<meta name="description" content="" />
<link href="/style/style.css" rel="stylesheet" type="text/css" />
<link href="style/longgong.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="/scripts/jquery-1.7.min.js"></script>
<script type="text/javascript" src="/scripts/scripts.js"></script>
<script type="text/javascript" src="/scripts/jBox-v2.3/jquery.jBox-2.3.min.js"></script>
<script type="text/javascript" src="/scripts/jBox-v2.3/i18n/jquery.jBox-zh-CN.js"></script>
<script type="text/javascript" src="/scripts/sort.js"></script>
<script type="text/javascript" src="/scripts/jquery.SuperSlide.js"></script>
<link type="text/css" rel="stylesheet"	href="/scripts/jBox-v2.3/Skins2/Blue/jbox.css" />
<!--[if IE 6]>
<script src="/scripts/iepng.js"></script>
<script>
   EvPNG.fix('.png')
</script>
<![endif]-->
</head>
<body class="longgong_body">
<!--top-->
<jsp:include page="/brandshop/include/top.jsp" flush="true"></jsp:include>
<!--top end-->
<div class="lg_logo">
  <div class="contain980"><a href="/brandshop/longgong/"><img src="images/logo.gif"  alt="龙工旗舰店"/></a></div>
</div>
<div class="lg_nav">
  <ul class="fix contain980">
    <li class="first_home"><a href="/brandshop/longgong/">首页</a></li>
    <li><a href="/brandshop/longgong/pro_list.jsp?catalog=101">装载机</a></li>
    <li><a href="/brandshop/longgong/pro_list.jsp?catalog=102">挖掘机</a></li>
    <li><a href="/brandshop/longgong/pro_list.jsp?catalog=103">路面机械</a></li>
    <li><a href="/brandshop/longgong/pro_list.jsp?catalog=104">叉车</a></li>
    <li><a href="/brandshop/longgong/pro_list.jsp?catalog=105">推土机</a></li>
    <li><a href="/brandshop/longgong/pro_list.jsp?catalog=106">旋挖钻</a></li>
    <li  style="background:none;"><a href="/brandshop/longgong/about.jsp">公司简介</a></li>
    <li class="last"><a href="javascript:void(0);" onclick="addShop();return false;"></a></li>
  </ul>
</div>
<!--banner-->
<div class="slide lg_banner">
  <div class="ban_c"><a  href="javascript:void(0);"><img src="images/lg_banner.jpg"/></a></div>
  <div class="ban_c"><a  href="javascript:void(0);"><img src="images/lg_banner_01.jpg"/></a></div>
</div>
<!--banner end--> 
<!--main-->
<div class="lg_mainbg">
  <div class="contain980 pt15">
    <div class="jg_tjT">
      <div class="lg_title">产品推荐</div>
    </div>
    <div class="lg_tuijian">
      <div class="bd">
        <ul class="fix">

		 <% 
		    String fullName="";
			if(null!=productList && productList.size()>0){
				for(int i=0;i<productList.size();i++){
					oneMap = (HashMap)productList.get(i);
					fullName=CommonString.getFormatPara(oneMap.get("catalogname"))+" "+CommonString.getFormatPara(oneMap.get("name"));
					if(fullName.length()>15){fullName=fullName.substring(0,15)+"...";}
         %>
          <li> <a title="<%=CommonString.getFormatPara(oneMap.get("catalogname"))+CommonString.getFormatPara(oneMap.get("name"))%>" href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")) %>" title="" target="_blank">
            <div class="tuijian_img"><img title="<%=CommonString.getFormatPara(oneMap.get("catalogname"))+CommonString.getFormatPara(oneMap.get("name"))%>" src="http://product.21-sun.com/uploadfiles/<%=CommonString.getFormatPara(oneMap.get("img2")) %>" alt="<%=CommonString.getFormatPara(oneMap.get("catalogname"))+CommonString.getFormatPara(oneMap.get("name"))%>"/></div>
            <div class="tuijian_nr">
              <p class="tjn_title" style="font-size:14px;padding-right:0px"><%=fullName %></p>
              <p class="tjn_more">查看详情&gt;&gt;</p>
            </div>
            </a> </li>
			<%}}%>

        </ul>
      </div>
      <div class="hd"><a class="newsImgprev"></a><a class="newsImgnext"></a></div>
    </div>
    <div class="lg_lan_yy"></div>
  </div>
  <div class="contain980">
    <div class="lg_lan_bg fix">
      <div class="l lan_left"><span>装载机  /</span> <span class="lg_img"><img src="images/lan_logo.gif"/></span></div>
      <div class="r lan_right"><a href="/brandshop/longgong/pro_list.jsp?catalog=101">点击查看更多</a></div>
    </div>
    <div class="lg_pro_img"><a href="http://product.21-sun.com/proDetail/LG853DH.shtm" title="" target="_blank"><img src="images/pro1.jpg" alt="" width="980" height="345"/></a></div>
    <div class="lg_pro_list">
      <ul class="fix">
	  	 <%
			if(null!=productsListZz && productsListZz.size()>0){
				for(int i=0;i<productsListZz.size();i++){
					oneMap = (HashMap)productsListZz.get(i);
				    fullName=CommonString.getFormatPara(oneMap.get("catalogname"))+" "+CommonString.getFormatPara(oneMap.get("name"));
					if(fullName.length()>7){fullName=fullName.substring(0,7)+"...";}
         %>
        <li>
          <div class="lg_pimg"><a href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")) %>" title="<%=CommonString.getFormatPara(oneMap.get("catalogname"))+CommonString.getFormatPara(oneMap.get("name"))%>" target="_blank"><img width="224" height="224" src="http://product.21-sun.com/uploadfiles/<%=CommonString.getFormatPara(oneMap.get("img2")) %>" alt="<%=CommonString.getFormatPara(oneMap.get("catalogname"))+CommonString.getFormatPara(oneMap.get("name"))%>"/></a></div>
          <div class="lg_pname"><a href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")) %>" title="<%=CommonString.getFormatPara(oneMap.get("catalogname"))+CommonString.getFormatPara(oneMap.get("name"))%>" target="_blank"><%=CommonString.getFormatPara(oneMap.get("catalogname")) %> <%=CommonString.getFormatPara(oneMap.get("name")) %></a></div>
          <div class="lg_xunjia fix">
            <div class="l lg_pcanshu"><a href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")) %>">详细</a> | <a href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")).replace(".shtm","") %>_parameter.shtm">参数</a></div>
            <div class="r lg_pbrn"><a href="javascript:void(0);" onclick="showinquery('<%=CommonString.getFormatPara(oneMap.get("id")) %>','135')">点击询价</a></div>
          </div>
        </li>
			<%}}%>
      </ul>
    </div>
    <div class="lg_lan_yy"></div>
  </div>
  <div class="contain980">
    <div class="lg_lan_bg fix">
      <div class="l lan_left"><span>挖掘机  /</span> <span class="lg_img"><img src="images/lan_logo.gif"/></span></div>
      <div class="r lan_right"><a href="/brandshop/longgong/pro_list.jsp?catalog=102">点击查看更多</a></div>
    </div>
    <div class="lg_pro_img"><a href="http://product.21-sun.com/proDetail/LG6365H.shtm"  target="_blank"><img src="images/pro2.jpg" alt="" width="980" height="345"/></a></div>
    <div class="lg_pro_list">
      <ul class="fix">
	  
	  	<%
			if(null!=productsListWj && productsListWj.size()>0){
				for(int i=0;i<productsListWj.size();i++){
					oneMap = (HashMap)productsListWj.get(i);
        %>
        <li>
          <div class="lg_pimg"><a title="<%=CommonString.getFormatPara(oneMap.get("catalogname"))+CommonString.getFormatPara(oneMap.get("name"))%>" href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")) %>"  target="_blank"><img width="224" height="224" src="http://product.21-sun.com/uploadfiles/<%=CommonString.getFormatPara(oneMap.get("img2")) %>" alt=""/></a></div>
          <div class="lg_pname"><a title="<%=CommonString.getFormatPara(oneMap.get("catalogname"))+CommonString.getFormatPara(oneMap.get("name"))%>" href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")) %>"   target="_blank"><%=CommonString.getFormatPara(oneMap.get("catalogname")) %> <%=CommonString.getFormatPara(oneMap.get("name")) %></a></div>
          <div class="lg_xunjia fix">
            <div class="l lg_pcanshu"><a href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")) %>">详细</a> | <a href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")).replace(".shtm","") %>_parameter.shtm">参数</a></div>
            <div class="r lg_pbrn"><a href="javascript:void(0);" onclick="showinquery('<%=CommonString.getFormatPara(oneMap.get("id")) %>','135')">点击询价</a></div>
          </div>
        </li>
		<%}}%>
	
      </ul>
    </div>
    <div class="lg_lan_yy"></div>
  </div>
  <div class="contain980">
    <div class="lg_lan_bg fix">
      <div class="l lan_left"><span>路面机械  /</span> <span class="lg_img"><img src="images/lan_logo.gif"/></span></div>
      <div class="r lan_right"><a href="/brandshop/longgong/pro_list.jsp?catalog=103">点击查看更多</a></div>
    </div>
    <div class="lg_pro_img"><a href="http://product.21-sun.com/proDetail/LG526A6.shtm" title="" target="_blank"><img src="images/pro3.jpg" alt="" width="980" height="345"/></a></div>
    <div class="lg_pro_list">
      <ul class="fix">
        
		
	  
	  	<%
			if(null!=productsListLm && productsListLm.size()>0){
				for(int i=0;i<productsListLm.size();i++){
					oneMap = (HashMap)productsListLm.get(i);
        %>
        <li>
          <div class="lg_pimg"><a title="<%=CommonString.getFormatPara(oneMap.get("catalogname"))+CommonString.getFormatPara(oneMap.get("name"))%>" href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")) %>"  target="_blank"><img width="224" height="224" src="http://product.21-sun.com/uploadfiles/<%=CommonString.getFormatPara(oneMap.get("img2")) %>" alt=""/></a></div>
          <div class="lg_pname"><a title="<%=CommonString.getFormatPara(oneMap.get("catalogname"))+CommonString.getFormatPara(oneMap.get("name"))%>" href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")) %>"   target="_blank"><%=CommonString.getFormatPara(oneMap.get("catalogname")) %> <%=CommonString.getFormatPara(oneMap.get("name")) %></a></div>
          <div class="lg_xunjia fix">
            <div class="l lg_pcanshu"><a href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")) %>">详细</a> | <a href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")).replace(".shtm","") %>_parameter.shtm">参数</a></div>
            <div class="r lg_pbrn"><a href="javascript:void(0);" onclick="showinquery('<%=CommonString.getFormatPara(oneMap.get("id")) %>','135')">点击询价</a></div>
          </div>
        </li>
		<%}}%>
   
      </ul>
    </div>
    <div class="lg_lan_yy"></div>
  </div>
    <div class="contain980">
    <div class="lg_lan_bg fix">
      <div class="l lan_left"><span>叉车  /</span> <span class="lg_img"><img src="images/lan_logo.gif"/></span></div>
      <div class="r lan_right"><a href="/brandshop/longgong/pro_list.jsp?catalog=104">点击查看更多</a></div>
    </div>
    <div class="lg_pro_img"><a href="http://product.21-sun.com/proDetail/LG30D(T)III.shtm"  target="_blank"><img src="images/pro4.jpg" alt="" width="980" height="345"/></a></div>
    <div class="lg_pro_list">
      <ul class="fix">
	  
	  	<%
			if(null!=productsListCc && productsListCc.size()>0){
				for(int i=0;i<productsListCc.size();i++){
					oneMap = (HashMap)productsListCc.get(i);
        %>
        <li>
          <div class="lg_pimg"><a title="<%=CommonString.getFormatPara(oneMap.get("catalogname"))+CommonString.getFormatPara(oneMap.get("name"))%>" href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")) %>"  target="_blank"><img width="224" height="224" src="http://product.21-sun.com/uploadfiles/<%=CommonString.getFormatPara(oneMap.get("img2")) %>" alt=""/></a></div>
          <div class="lg_pname"><a title="<%=CommonString.getFormatPara(oneMap.get("catalogname"))+CommonString.getFormatPara(oneMap.get("name"))%>" href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")) %>"   target="_blank"><%=CommonString.getFormatPara(oneMap.get("catalogname")) %> <%=CommonString.getFormatPara(oneMap.get("name")) %></a></div>
          <div class="lg_xunjia fix">
            <div class="l lg_pcanshu"><a href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")) %>">详细</a> | <a href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")).replace(".shtm","") %>_parameter.shtm">参数</a></div>
            <div class="r lg_pbrn"><a href="javascript:void(0);" onclick="showinquery('<%=CommonString.getFormatPara(oneMap.get("id")) %>','135')">点击询价</a></div>
          </div>
        </li>
		<%}}%>
	
      </ul>
    </div>
    <div class="lg_lan_yy"></div>
  </div>
  <div class="contain980">
    <div class="lg_lan_bg fix">
      <div class="l lan_left"><span>产品订单  /</span> <span class="lg_img"><img src="images/lan_logo.gif"/></span></div>
      <div class="r lan_right"><a href="/inquiry/0_0_135_0_0.shtm">点击查看更多</a></div>
    </div>
    <div class="lg_order_nr fix">
      <div class="wfull " id="myTab2_ContentA5">
        <div class="w960 border03  mb10 list08 fix">
        	<div class="fix lg_more_order">
        	<div class="l lgmo_title">龙工产品订单</div>
            <div class="r lgmo_more"><a href="/inquiry/0_0_135_0_0.shtm">更多&gt;&gt;</a></div>
        </div>
	    <%
       List<Map> orderList = null ;
       PageBean pageBean = new  PageBean() ;
       pageBean.setPageSize(10) ;
	   pageBean.setTableName("pro_product_form") ;
       pageBean.setFields("factoryid ,id, factoryname,product_name,contact_address,cataname,name,mobile_phone,province,city,add_date") ;
       pageBean.setCondition("and factoryid=135 and factoryname <>'' and factoryname is not null and name is not null and name<>'' and product_name is not null and product_name<>''") ;
       pageBean.setNowPage(1) ;
       pageBean.setOrderBy(" add_date desc") ;
       pageBean.setParams("#to_order") ;
       orderList = pageBean.getDatas() ;
	  %>
        	<div class="title08">
              <h3><b>询价总数：<%=pageBean.getTotal() %></b> - 采购询价</h3>
              <span>共有<font><%=pageBean.getTotal() %></font>个符合条件</span> 
           </div>
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
	  	 for(int i=0;i<k;i++){
	  		oneMap = orderList.get(i) ;
    		showtel = "".equals(CommonString.getFormatPara(oneMap.get("mobile_phone")))?CommonString.getFormatPara(oneMap.get("mobile_phone")):CommonString.getFormatPara(oneMap.get("mobile_phone")) ;
    		
    		if(showtel.length()>7&&showtel.length()<=20){
    			showtel = showtel.substring(0,2)+"***"+showtel.substring(showtel.length()-2) ;
    		}else if(showtel.length()>3){
    			showtel = showtel.substring(0,4)+"***" ;
    		}else
    		{
    			showtel = showtel+"***" ;
    		}
     %>
        <ul class="libg01">
          <li class="i1"><%=i+1 %></li>
          <li class="i2"><a title="<%=CommonString.getFormatPara(oneMap.get("product_name")) %><%=CommonString.getFormatPara(oneMap.get("cataname")) %>" target="_blank" href="/inquiry/detail_for_<%=CommonString.getFormatPara(oneMap.get("id")) %>.htm"><%=CommonString.getFormatPara(oneMap.get("product_name")) %><%=CommonString.getFormatPara(oneMap.get("cataname")) %></a></li>
          <li class="i3"><%=(CommonString.getFormatPara(oneMap.get("name")).length()>0)?CommonString.getFormatPara(oneMap.get("name")).substring(0,1)+"***":"张**" %></li>
          <li class="i4"><%=showtel %></li>
          <li class="i5"><a href="/inquiry/0_0_1742_0_0.shtm" target="_blank"><%=CommonString.getFormatPara(oneMap.get("factoryname")) %></a></li>
          <li class="i6"><%="".equals(CommonString.getFormatPara(oneMap.get("contact_address")))?"-":CommonString.getFormatPara(oneMap.get("contact_address"))  %></li>
          <li class="i7"><%=(CommonString.getFormatPara(oneMap.get("add_date")).length()>15)?CommonString.getFormatPara(oneMap.get("add_date")).substring(0,16):CommonString.getFormatPara(oneMap.get("add_date")) %></li>
        </ul>

         <%}}%> 
          </div>
          <!--翻页--> 
          <!-- 
  <div class="w755 l">
    <div id="pagination" class="page"> <span> <a onclick="goToTop();" href="#" target="_self" class="goTop">返回顶部</a> </span> </div>
  </div>
   --> 
          <!--翻页--> 
        
        </div>
      </div>
    </div>
    <div class="lg_lan_yy"></div>
  </div>
</div>
<!--main end--> 
<!--foot-->
<div class="john_foot">
  <jsp:include page="/include/foot.jsp"/>
</div>
<!--foot end--> 
<script type="text/javascript" src="scripts/comm.js"></script> 
<script type="text/javascript">
$(".lg_tuijian").slide({ titCell:".hd ul", mainCell:".bd ul",effect:"leftLoop",vis:5,scroll:1,autoPlay:true,autoPage:true,interTime:4000});
</script>
<script type="text/javascript">
function addShop(){　 // 收藏店铺
    try{
       window.external.addFavorite('http://product.21-sun.com/brandshop/longgong/', '中国龙工控股有限公司');
   }catch (e){
       try{
           window.sidebar.addPanel('中国龙工控股有限公司','http://product.21-sun.com/brandshop/longgong/',"");
       }catch (e){
           alert("加入收藏失败，请使用Ctrl+D进行添加");
       }
   }
}
</script> 
</body>
</html>