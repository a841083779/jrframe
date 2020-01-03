<%@ page language="java" import="com.jerehnet.util.dbutil.PageBean,com.jerehnet.util.common.CommonString,com.jerehnet.util.dbutil.DBHelper,java.util.*" pageEncoding="UTF-8"%>
<%
    Map oneMap = null ;
	DBHelper dbHelper = DBHelper.getInstance() ;
	//首页推荐
    String sql = "select top 3  id,name,file_name,img2,catalogname_spe,catalognum_spe,zoomlion_hot_pic ,catalogname,factoryname from pro_products where factoryid=133 and is_show=1 and catalognum like '101001%'   order by view_count desc" ;
	List<Map> productList	= null ;
	productList = dbHelper.getMapList(sql) ;
	//大挖
    String dw = "select  id,name,file_name,img2,catalogname_spe,catalognum_spe,zoomlion_hot_pic ,catalogname,factoryname from pro_products where factoryid=133 and is_show=1 and catalognum like '101001%'  and tonandmeter>=30   order by view_count desc" ;
	List<Map> productListdw	= null ;
	productListdw = dbHelper.getMapList(dw) ;
	//中挖
    String zw = "select   id,name,file_name,img2,catalogname_spe,catalognum_spe,zoomlion_hot_pic ,catalogname,factoryname from pro_products where factoryid=133 and is_show=1 and catalognum like '101001%'  and (tonandmeter>13 and tonandmeter<30)  order by view_count desc" ;
	List<Map> productListzw	= null ;
	productListzw = dbHelper.getMapList(zw) ;
	//小挖
    String sw = "select   id,name,file_name,img2,catalogname_spe,catalognum_spe,zoomlion_hot_pic ,catalogname,factoryname from pro_products where factoryid=133 and is_show=1 and catalognum like '101001%' and tonandmeter<=13   order by view_count desc" ;
	List<Map> productListsw	= null ;
	productListsw = dbHelper.getMapList(sw) ;
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="author" content="design by www.21-sun.com" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<title>重庆国杰三一代理商旗舰店_中国工程机械商贸网</title>
<meta name="keywords" content="重庆国杰,重庆三一挖掘机产品报价,重庆三一挖掘机产品,重庆三一挖掘机产品图片,重庆三一挖掘机产品介绍,重庆国杰三一挖掘机介绍" />
<meta name="description" content="中国工程机械商贸网为您提供重庆国杰介绍，重庆三一挖掘机产品介绍，重庆三一挖掘机产品报价，重庆三一挖掘机产品图片，重庆三一挖掘机产品展示等重庆三一挖掘机产品信息，帮助您全面了解重庆三一挖掘机。" />
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
<div class="shop_topbg">
  <div class="contain980 fix" style="position:relative; z-index:5;">
    <h2><img src="images/logo.png" alt="重庆国杰三一代理商旗舰店" /></h2>
    <div class="shop_bm"><a href="#" onclick="addShop();return false;"><img src="images/bm.png" alt="收藏本店" /></a></div>
  </div>
  <div class="shopNav pngfix">
    <div class="contain980 fix">
      <ul>
        <li><a href="/brandshop/gjjx/" >首页</a></li>
        <li><a href="/brandshop/gjjx/#tuijian">推荐产品</a></li>
        <li><a href="/brandshop/gjjx/list.jsp" class="selected">三一挖掘机</a></li>
        <li><a href="/brandshop/gjjx/#introduce">公司介绍<i></i></a></li>
        <li><a href="/brandshop/gjjx/#contact">联系方式<i></i></a></li>
      </ul>
    </div>
  </div>
</div>
<script type="text/javascript">
jQuery("html, body").scrollTop(0).animate({scrollTop:jQuery(".shop_topbg").offset().top},1); 
</script>
<div class="slide shopBanner">
  <div class="ban_c"><img src="images/banner01.jpg" width="1862" height="600" /></div>
  <div class="ban_c"><img src="images/banner01.jpg" width="1862" height="600" /></div>
</div>



<div class="sp">
  <div class="shopWrap">
    <div class="hd">
      <h3><img src="images/t_02.png" alt="小挖" width="307" height="91" class="pngfix" /></h3>
      <!--<span class="more"><a href="#">查看更多&gt;&gt;</a></span>-->
    </div>
    <div class="bd">
      <div class="sb"><img src="images/ban_img02.jpg" width="950" height="270" /></div>
      <div class="plist02">
        <ul class="fix">
		<% 
			if(null!=productListsw && productListsw.size()>0){
				for(int i=0;i<productListsw.size();i++){
					oneMap = (HashMap)productListsw.get(i);

        %>
          <li><a title="<%=CommonString.getFormatPara(oneMap.get("factoryname"))%><%=CommonString.getFormatPara(oneMap.get("name"))+CommonString.getFormatPara(oneMap.get("catalogname"))%>" href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name"))%>" target="_blank"><img src="http://product.21-sun.com/uploadfiles/<%=CommonString.getFormatPara(oneMap.get("img2")) %>" width="310" height="215" />
            <h3><%=CommonString.getFormatPara(oneMap.get("factoryname"))%><br /><%=CommonString.getFormatPara(oneMap.get("name"))+CommonString.getFormatPara(oneMap.get("catalogname"))%></h3></a>
            <a href="javascript:void(0);" onclick="showinquery('<%=CommonString.getFormatPara(oneMap.get("id"))%>','133')" class="xj_btn">立即订购</a>
          </li>
		   	   <%}}%>

        </ul>
      </div>
    </div>
  </div>
</div>

<div class="sp">
  <div class="shopWrap">
    <div class="hd">
      <h3><img src="images/t_03.png" alt="中挖" width="307" height="91" class="pngfix" /></h3>
      <!--<span class="more"><a href="#">查看更多&gt;&gt;</a></span>-->
    </div>
    <div class="bd">
      <div class="sb"><img src="images/ban_img03.jpg" width="950" height="273" /></div>
      <div class="plist02">
        <ul class="fix">
		
		<% 
			if(null!=productListzw && productListzw.size()>0){
				for(int i=0;i<productListzw.size();i++){
					oneMap = (HashMap)productListzw.get(i);

        %>
          <li><a  title="<%=CommonString.getFormatPara(oneMap.get("factoryname"))%><%=CommonString.getFormatPara(oneMap.get("name"))+CommonString.getFormatPara(oneMap.get("catalogname"))%>" href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name"))%>" target="_blank"><img src="http://product.21-sun.com/uploadfiles/<%=CommonString.getFormatPara(oneMap.get("img2")) %>" width="310" height="215" />
            <h3><%=CommonString.getFormatPara(oneMap.get("factoryname"))%><br /><%=CommonString.getFormatPara(oneMap.get("name"))+CommonString.getFormatPara(oneMap.get("catalogname"))%></h3></a>
            <a href="javascript:void(0);" onclick="showinquery('<%=CommonString.getFormatPara(oneMap.get("id"))%>','133')" class="xj_btn">立即订购</a>
          </li>
		   	   <%}}%>
		  

        </ul>
      </div>
    </div>
  </div>
</div>

<div class="sp">
  <div class="shopWrap">
    <div class="hd">
      <h3><img src="images/t_04.png" alt="大挖" width="307" height="91" class="pngfix" /></h3>
      <!--<span class="more"><a href="#">查看更多&gt;&gt;</a></span>-->
    </div>
    <div class="bd">
      <div class="sb"><img src="images/ban_img04.jpg" width="950" height="273" /></div>
      <div class="plist02">
        <ul class="fix">
		<% 
			if(null!=productListdw && productListdw.size()>0){
				for(int i=0;i<productListdw.size();i++){
					oneMap = (HashMap)productListdw.get(i);

        %>
          <li><a title="<%=CommonString.getFormatPara(oneMap.get("factoryname"))%><%=CommonString.getFormatPara(oneMap.get("name"))+CommonString.getFormatPara(oneMap.get("catalogname"))%>" href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name"))%>" target="_blank"><img src="http://product.21-sun.com/uploadfiles/<%=CommonString.getFormatPara(oneMap.get("img2")) %>" width="310" height="215" />
            <h3><%=CommonString.getFormatPara(oneMap.get("factoryname"))%><br /><%=CommonString.getFormatPara(oneMap.get("name"))+CommonString.getFormatPara(oneMap.get("catalogname"))%></h3></a>
            <a href="javascript:void(0);" onclick="showinquery('<%=CommonString.getFormatPara(oneMap.get("id"))%>','133')" class="xj_btn">立即订购</a>
          </li>
		   	   <%}}%>

        </ul>
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
<script type="text/javascript" language="javascript">
//营销宝统计
jQuery(function(){
  jQuery.ajax({
    	type:'post',
    	url:'/action/ajax.jsp',
    	data:{flag:'getAgentViewCount',agentId:'514'} ,
    	success:function(msg){
    	}
    }) ;
});
</script> 
<script type="text/javascript">
function addShop(){　 // 收藏店铺
    try{
       window.external.addFavorite('http://product.21-sun.com/brandshop/gjjx/', '重庆国杰三一代理商旗舰店');
   }catch (e){
       try{
           window.sidebar.addPanel('重庆国杰三一代理商旗舰店','http://product.21-sun.com/brandshop/gjjx/',"");
       }catch (e){
           alert("加入收藏失败，请使用Ctrl+D进行添加");
       }
   }
}
</script> 
<script type="text/javascript" src="/scripts/scrolltopcontrol.js"></script> 

<script>window._bd_share_config={"common":{"bdSnsKey":{},"bdText":"","bdMini":"2","bdMiniList":false,"bdPic":"","bdStyle":"0","bdSize":"16"},"slide":{"type":"slide","bdImg":"0","bdPos":"right","bdTop":"100"}};with(document)0[(getElementsByTagName('head')[0]||body).appendChild(createElement('script')).src='http://bdimg.share.baidu.com/static/api/js/share.js?v=89860593.js?cdnversion='+~(-new Date()/36e5)];</script>
</body>
</html>