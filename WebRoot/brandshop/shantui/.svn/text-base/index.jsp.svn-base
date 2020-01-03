<%@ page language="java" import="com.jerehnet.util.dbutil.PageBean,com.jerehnet.util.common.CommonString,com.jerehnet.util.dbutil.DBHelper,java.util.*" pageEncoding="UTF-8"%>
<%
    Map oneMap = null ;
   	DBHelper dbHelper = DBHelper.getInstance() ;
	//装载机
	String sql = "select  id,name,file_name,img2,catalogname_spe,catalognum_spe,zoomlion_hot_pic ,catalogname from pro_products where factoryid=144 and is_show=1 and catalognum like '101002%'  order by id desc" ;
	List<Map> productsList = null ;
	productsList = dbHelper.getMapList(sql) ;
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="author" content="design by www.21-sun.com" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<title>山推股份_中国工程机械商贸网</title>
<meta name="keywords" content="山推,山推装载机产品报价山推装载机产品山推装载机产品图片山推装载机产品介绍山推装载机介绍" />
<meta name="description" content="中国工程机械商贸网为您提供江苏华通介绍山推装载机产品介绍山推装载机产品报价山推装载机产品图片山推装载机产品展示等山推装载机产品信息，帮助您全面了解山推装载机。" />
<link href="/style/style.css" rel="stylesheet" type="text/css" />
<link href="style/flag_shop.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="/scripts/jquery-1.7.min.js"></script>
<script type="text/javascript" src="/scripts/scripts.js"></script>
<script type="text/javascript" src="/scripts/jBox-v2.3/jquery.jBox-2.3.min.js"></script>
<script type="text/javascript" src="/scripts/jBox-v2.3/i18n/jquery.jBox-zh-CN.js"></script>
<script type="text/javascript" src="/scripts/sort.js"></script>
<link type="text/css" rel="stylesheet"	href="/scripts/jBox-v2.3/Skins2/Blue/jbox.css" />
<!--[if IE 6]><script src="/scripts/pngfix.js">/* s,i,.pngfix,.pngimg img */</script><![endif]-->
</head>
<body class="flag_shop">
<!--top-->
<jsp:include page="/brandshop/include/top.jsp" flush="true"></jsp:include>
<jsp:include page="top.jsp" flush="true"></jsp:include>
<div class="slide shopBanner">
  <div class="ban_c" style="display:block;"><img src="images/banner01.jpg" width="1920" height="387" /></div>
</div>

<div class="contain980 mb15">
  <div class="scroll">
    <div class="bd">
      <ul>
	  	 <%
			if(null!=productsList && productsList.size()>0){
				for(int i=0;i<productsList.size();i++){
					oneMap = (HashMap)productsList.get(i);
      %>
        <li><a target="_blank" title="山推<%=CommonString.getFormatPara(oneMap.get("name")) %><%=CommonString.getFormatPara(oneMap.get("catalogname")) %>" href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")) %>">
		<img title="山推<%=CommonString.getFormatPara(oneMap.get("name")) %><%=CommonString.getFormatPara(oneMap.get("catalogname")) %>" alt="山推<%=CommonString.getFormatPara(oneMap.get("name")) %><%=CommonString.getFormatPara(oneMap.get("catalogname")) %>" src="http://product.21-sun.com/uploadfiles/<%=CommonString.getFormatPara(oneMap.get("zoomlion_hot_pic")) %>" width="145" height="130"  onerror="showImgDelay(this,'/uploadfiles/no_small.gif',2);" /><h3><%=CommonString.getFormatPara(oneMap.get("name")).replace("/","<br>") %></h3></a>
		</li>
	<% } } %>
      </ul>
    </div>
    <a href="javascript:void(0);" class="arr prev"></a>
    <a href="javascript:void(0);" class="arr next"></a>
  </div>
</div>

<div class="shopWrap pb10 recPro">
  <div class="hd fix">
    <h3>装载机系列</h3>
    <span class="more"><a href="http://product.21-sun.com/products/prolist.jsp?factory=144&catalog=101002" target="_blank">查看更多</a></span>
  </div>
  <div style="position:relative; clear:both;">
    <a href="http://product.21-sun.com/proDetail/SL50W-SL50W-2.shtm" target="_blank" title="SL50W，SL50W-2"><img src="images/rec_img01.jpg" alt="SL50W，SL50W-2" width="980" height="370" /></a>
    <a href="javascript:void(0);" onclick="showinquery('18905','144')" class="xj_btn">立即询价</a>
  </div>
  <div style="position:relative; clear:both;">
    <a href="http://product.21-sun.com/proDetail/SL30WN-58.shtm" target="_blank" title="SL30WN"><img src="images/rec_img02.jpg" alt="SL30WN" width="980" height="364" /></a>
    <a href="javascript:void(0);" onclick="showinquery('21915','144')" class="xj_btn" style="left:446px; top:280px;">立即询价</a>
  </div>
  <div class="proList">
    <ul class="fix">
	
	   <%   
	         int num=1;
			if(null!=productsList && productsList.size()>0){
				for(int i=0;i<productsList.size();i++){
					oneMap = (HashMap)productsList.get(i);
					if(num<=8&&!CommonString.getFormatPara(oneMap.get("id")).equals("18905")){
      %>
      <li>
        <div class="intro">
          <span class="cate">土方机械</span>
          <h3><a href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")) %>" title="山推<%=CommonString.getFormatPara(oneMap.get("name")) %><%=CommonString.getFormatPara(oneMap.get("catalogname")) %>" target="_blank"><b><%=CommonString.getFormatPara(oneMap.get("name")) %></b><%=CommonString.getFormatPara(oneMap.get("catalogname")) %></a></h3>
        </div>
        <div class="img"><a  target="_blank" href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")) %>" title="山推<%=CommonString.getFormatPara(oneMap.get("name")) %><%=CommonString.getFormatPara(oneMap.get("catalogname")) %>" target="_blank"><img src="http://product.21-sun.com/uploadfiles/<%=CommonString.getFormatPara(oneMap.get("img2")) %>" width="400" height="300" alt="山推<%=CommonString.getFormatPara(oneMap.get("name")) %><%=CommonString.getFormatPara(oneMap.get("catalogname")) %>" /></a></div>
        <span class="otLink"><a  target="_blank" href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")).replace(".shtm","")  %>_parameter.shtm">参数</a><em>|</em><a  target="_blank" href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")).replace(".shtm","") %>_message.shtm#myTab2">评论</a></span>
        <a class="btn" href="javascript:void(0);" onclick="showinquery('<%=CommonString.getFormatPara(oneMap.get("id")) %>','144')">立即询价</a>
      </li>
	  <% num++;}} } %>
	  
   
    </ul>
  </div>
</div>
<div class="shopWrap fix proOrder">
  <div class="hd fix">
    <h3>产品订单</h3>
  </div>
  <div class="bd fix">
    <div class="w978 border03 l list08">
      <div class="order_title">
        <h3>山推装载机订单</h3>
        <span class="more"><a target="_blank" href="http://product.21-sun.com/inquiry/0_0_144_101002_0.shtm">更多&gt;&gt;</a></span>
      </div>
	  <%
       List<Map> orderList = null ;
       PageBean pageBean = new  PageBean() ;
       pageBean.setPageSize(10) ;
	   pageBean.setTableName("pro_product_form") ;
       pageBean.setFields("factoryid ,id, factoryname,product_name,contact_address,cataname,name,mobile_phone,province,city,add_date") ;
       pageBean.setCondition("and is_deleted=0 and catanum like '101002%' and factoryid=144 and factoryname <>'' and factoryname is not null and name is not null and name<>'' and product_name is not null and product_name<>''") ;
       pageBean.setNowPage(1) ;
       pageBean.setOrderBy(" add_date desc") ;
       pageBean.setParams("#to_order") ;
       orderList = pageBean.getDatas() ;
	  %>
      <div class="title08">
        <h3><b>询价总数：<%=pageBean.getTotal() %></b> - 采购询价</h3>
        <span>共有<font><%=pageBean.getTotal() %></font>个符合条件</span> </div>
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
    		showtel = "".equals(CommonString.getFormatPara(oneMap.get("mobile_phone")))?CommonString.getFormatPara(oneMap.get("contact_tel")):CommonString.getFormatPara(oneMap.get("mobile_phone")) ;
    		
    		if(showtel.length()>7&&showtel.length()<=20){
    			showtel = showtel.substring(0,2)+"***"+showtel.substring(showtel.length()-2) ;
    		}else if(showtel.length()>2){
    			showtel = showtel.substring(0,3)+"***" ;
    		}else
    		{
    			showtel = showtel+"***" ;
    		}
      %>
        <ul class="libg01">
          <li class="i1"><%=i+1 %></li>
          <li class="i2"><a target="_blank" href="/inquiry/detail_for_<%=CommonString.getFormatPara(oneMap.get("id")) %>.htm">山推<%=CommonString.getFormatPara(oneMap.get("product_name")) %><%=CommonString.getFormatPara(oneMap.get("cataname")) %></a></li>
          <li class="i3"><%=(CommonString.getFormatPara(oneMap.get("name")).length()>0)?CommonString.getFormatPara(oneMap.get("name")).substring(0,1)+"***":"张**" %></li>
          <li class="i4"><%=showtel %></li>
          <li class="i5"><a href="/inquiry/0_0_144_0_0.shtm" target="_blank">山推</a></li>
          <li class="i6"><%="".equals(CommonString.getFormatPara(oneMap.get("contact_address")))?"-":CommonString.getFormatPara(oneMap.get("contact_address"))  %></li>
          <li class="i7"><%=(CommonString.getFormatPara(oneMap.get("add_date")).length()>15)?CommonString.getFormatPara(oneMap.get("add_date")).substring(0,16):CommonString.getFormatPara(oneMap.get("add_date")) %></li>
        </ul>
     <%}}%> 
      </div>
    </div>
  </div>
</div>
<!--foot-->
<div class="bottombg">
<jsp:include page="/include/foot.jsp" flush="true"></jsp:include>
</div>
<!--end of foot--> 
<script type="text/javascript" src="scripts/slide.js"></script>
<script type="text/javascript" src="/scripts/jquery.SuperSlide.js"></script>
<script type="text/javascript">
$(document).ready(function() {
    $(".scroll").slide({ mainCell:".bd ul",effect:"leftLoop",vis:5,scroll:1,autoPlay:true,interTime:4000,prevCell:'.prev',nextCell:'.next'});
	$('.proList li').hover(function(){
		$(this).toggleClass('hover');
	});
});
</script>
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
  jQuery(".shopNav").scrollTo(700);
});
</script>
 
<script type="text/javascript">
function addShop(){　 // 收藏店铺
    try{
       window.external.addFavorite('product.21-sun.com/brandshop/shantui/', '山推旗舰店');
   }catch (e){
       try{
           window.sidebar.addPanel('山推旗舰店','product.21-sun.com/brandshop/shantui/',"");
       }catch (e){
           alert("加入收藏失败，请使用Ctrl+D进行添加");
       }
   }
}
</script> 
<script type="text/javascript" src="/scripts/scrolltopcontrol.js"></script> 
<div style="display:none"><script src="http://v1.cnzz.com/stat.php?id=5894569&web_id=5894569" language="JavaScript"></script></div>
</body>
</html>