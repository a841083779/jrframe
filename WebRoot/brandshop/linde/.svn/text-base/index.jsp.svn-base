<%@ page language="java" import="com.jerehnet.util.dbutil.PageBean,com.jerehnet.util.common.CommonString,com.jerehnet.util.dbutil.DBHelper,java.util.*" pageEncoding="UTF-8"%>
<%
    Map oneMap = null ;
 	DBHelper dbHelper = DBHelper.getInstance() ;
	//内燃
	String nr_sql = "select top 4 id,name,file_name,img2,catalogname_spe,catalognum_spe,zoomlion_hot_pic ,catalogname from pro_products where factoryid=1742 and is_show=1 and catalognum like '107001%' and zoomlion_hot=11  order by id desc" ;
	List<Map> productsListNr = null ;
	productsListNr = dbHelper.getMapList(nr_sql) ;
	//电动
	String dd_sql = "select top 4 id,name,file_name,img2,catalogname_spe,catalognum_spe,zoomlion_hot_pic ,catalogname from pro_products where factoryid=1742 and is_show=1 and catalognum like '107003%' and zoomlion_hot=11 order by id desc" ;
	List<Map> productsListDd = null ;
	productsListDd = dbHelper.getMapList(dd_sql) ;
	//牵引
	String qy_sql = "select top 2 id,name,file_name,img2,catalogname_spe,catalognum_spe,zoomlion_hot_pic ,catalogname from pro_products where factoryid=1742 and is_show=1 and catalognum like '107005%' and zoomlion_hot=11 order by id desc" ;
	List<Map> productsListQy = null ;
	productsListQy = dbHelper.getMapList(qy_sql) ;
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="author" content="design by www.21-sun.com" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<title>林德(中国)叉车有限公司_中国工程机械商贸网</title>
<meta name="keywords" content="林德,林德叉车产品报价林德叉车产品林德叉车产品图片林德叉车产品介绍林德叉车介绍" />
<meta name="description" content="中国工程机械商贸网为您提供江苏华通介绍林德叉车产品介绍林德叉车产品报价林德叉车产品图片林德叉车产品展示等林德叉车产品信息，帮助您全面了解林德叉车。" />
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
  <div class="ban_c"><img src="images/banner01.jpg" width="1920" height="387" /></div>
  <div class="ban_c"><img src="images/banner02.jpg" width="1920" height="387" /></div>
</div>
<div class="shopWrap about_intro" id="about">
  <div class="box fix">
    <span class="l"><img src="images/loco01.png" width="328" height="146" /></span>
    <p class="text">
	<a href="about.jsp" style="color:#fff;">林德(中国)叉车有限公司,1993年成立于厦门，是林德物料搬运在亚洲的生产、销售、服务及技术支持基地，总投资17亿人民币，占地面积22万平方米，林德(中国)向市场提供全系列的平衡重及仓储等叉车，专业的全方位的服务，最优化的物料搬运综合解决方案及物流方案设计及咨询。林德(中国)现有2,500多名员工，销售网络覆盖全国96个城市，为全国的客户提供高效专业的服务。</a>
	</p>
  </div>
</div>
<div class="shopWrap pb10 recPro">
  <a href="/proDetail/EC16S.shtm" target="_blank" title="林德H35柴油，液化石油气叉车"><img src="images/h35.jpg" alt="林德H35柴油，液化石油气叉车" width="980" height="510" border="0" usemap="#Map" />
  <map name="Map" id="Map">
    <area shape="rect" coords="740,65,965,192" href="javascript:void(0);" onclick="showinquery('21127','1742')" />
  </map>
  </a>
  <a style="display:none" href="javascript:void(0);" onclick="showinquery('21111','1742')" class="xj_btn">立即询价</a>
</div>
<div class="shopWrap fix pb10">
  <div class="hd fix">
    <h3>林德内燃叉车</h3>
    <span class="more"><a href="/brandshop/linde/list.jsp?catalog=107001">查看更多</a></span>
  </div>
  <div class="proList">
    <ul class="fix">
	 <%
			if(null!=productsListNr && productsListNr.size()>0){
				for(int i=0;i<productsListNr.size();i++){
					oneMap = (HashMap)productsListNr.get(i);
    %>
      <li><a href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")) %>" title="林德<%=CommonString.getFormatPara(oneMap.get("name")) %><%=CommonString.getFormatPara(oneMap.get("catalogname")) %>" target="_blank"><i class="ico"></i><img src="http://product.21-sun.com/uploadfiles/<%=CommonString.getFormatPara(oneMap.get("zoomlion_hot_pic")) %>" width="400" height="300" alt="林德<%=CommonString.getFormatPara(oneMap.get("name")) %><%=CommonString.getFormatPara(oneMap.get("catalogname")) %>" /></a>
        <div class="intro">
          <h3><a href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")) %>" title="林德<%=CommonString.getFormatPara(oneMap.get("name")) %><%=CommonString.getFormatPara(oneMap.get("catalogname")) %>" target="_blank">林德<%=CommonString.getFormatPara(oneMap.get("name")) %><%=CommonString.getFormatPara(oneMap.get("catalogname")) %></a></h3>
          <span class="otLink"><a href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")).replace(".shtm","")  %>_parameter.shtm">参数</a><em>|</em><a href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")).replace(".shtm","") %>_message.shtm#myTab2">评论</a></span>
          <a class="btn" href="javascript:void(0);" onclick="showinquery('<%=CommonString.getFormatPara(oneMap.get("id")) %>','1742')">立即询价</a>
        </div>
      </li>
	<% } } %>
    </ul>
  </div>
</div>
<div class="shopWrap fix pb10">
  <div class="hd fix">
    <h3>林德电动叉车</h3>
    <span class="more"><a href="/brandshop/linde/list.jsp?catalog=107003">查看更多</a></span>
  </div>
  <div class="proList">
    <ul class="fix">
	  <%
			if(null!=productsListDd && productsListDd.size()>0){
				for(int i=0;i<productsListDd.size();i++){
					oneMap = (HashMap)productsListDd.get(i);
      %>
      <li><a href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")) %>" title="林德<%=CommonString.getFormatPara(oneMap.get("name")) %><%=CommonString.getFormatPara(oneMap.get("catalogname")) %>" target="_blank"><i class="ico"></i><img src="http://product.21-sun.com/uploadfiles/<%=CommonString.getFormatPara(oneMap.get("zoomlion_hot_pic")) %>" width="400" height="300" alt="林德<%=CommonString.getFormatPara(oneMap.get("name")) %><%=CommonString.getFormatPara(oneMap.get("catalogname")) %>" /></a>
        <div class="intro">
          <h3><a href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")) %>" title="林德<%=CommonString.getFormatPara(oneMap.get("name")) %><%=CommonString.getFormatPara(oneMap.get("catalogname")) %>" target="_blank">林德<%=CommonString.getFormatPara(oneMap.get("name")) %><%=CommonString.getFormatPara(oneMap.get("catalogname")) %></a></h3>
          <span class="otLink"><a href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")).replace(".shtm","")  %>_parameter.shtm">参数</a><em>|</em><a href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")).replace(".shtm","") %>_message.shtm#myTab2">评论</a></span>
          <a class="btn" href="javascript:void(0);" onclick="showinquery('<%=CommonString.getFormatPara(oneMap.get("id")) %>','1742')">立即询价</a>
        </div>
      </li>
 	 <% } } %>
    </ul>
  </div>
</div>
<div class="shopWrap fix pb10">
  <div class="hd fix">
    <h3>林德仓储叉车</h3>
    <span class="more"><a href="/brandshop/linde/list.jsp?catalog=107005">查看更多</a></span>
  </div>
  <div class="proList">
    <ul class="fix">
	  <%
			if(null!=productsListQy && productsListQy.size()>0){
				for(int i=0;i<productsListQy.size();i++){
					oneMap = (HashMap)productsListQy.get(i);
      %>
      <li><a href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")) %>" title="林德<%=CommonString.getFormatPara(oneMap.get("name")) %><%=CommonString.getFormatPara(oneMap.get("catalogname")) %>" target="_blank"><i class="ico"></i><img src="http://product.21-sun.com/uploadfiles/<%=CommonString.getFormatPara(oneMap.get("zoomlion_hot_pic")) %>" width="400" height="300" alt="林德<%=CommonString.getFormatPara(oneMap.get("name")) %><%=CommonString.getFormatPara(oneMap.get("catalogname")) %>" /></a>
        <div class="intro">
          <h3><a href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")) %>" title="林德<%=CommonString.getFormatPara(oneMap.get("name")) %><%=CommonString.getFormatPara(oneMap.get("catalogname")) %>" target="_blank">林德<%=CommonString.getFormatPara(oneMap.get("name")) %><%=CommonString.getFormatPara(oneMap.get("catalogname")) %></a></h3>
          <span class="otLink"><a href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")).replace(".shtm","")  %>_parameter.shtm">参数</a><em>|</em><a href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")).replace(".shtm","") %>_message.shtm#myTab2">评论</a></span>
          <a class="btn" href="javascript:void(0);" onclick="showinquery('<%=CommonString.getFormatPara(oneMap.get("id")) %>','1742')">立即询价</a>
        </div>
      </li>
    <% } } %>
    </ul>
  </div>
</div>
<div class="shopWrap fix pb10 proOrder">
  <div class="hd fix">
    <h3>林德产品订单</h3>
  </div>
  <div class="bd fix">
    <div class="w978 border03 l list08">
      <div class="order_title">
        <h3>林德产品订单</h3>
        <span class="more"><a target="_blank" href="/inquiry/0_0_1742_0_0.shtm">更多&gt;&gt;</a></span>
      </div>
	  <%
       List<Map> orderList = null ;
       PageBean pageBean = new  PageBean() ;
       pageBean.setPageSize(10) ;
	   pageBean.setTableName("pro_product_form") ;
       pageBean.setFields("factoryid ,id, factoryname,product_name,contact_address,cataname,name,mobile_phone,province,city,add_date") ;
       pageBean.setCondition(" and factoryid=1742 and factoryname <>'' and factoryname is not null and name is not null and name<>'' and product_name is not null and product_name<>''") ;
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
          <li class="i2"><a title="<%=CommonString.getFormatPara(oneMap.get("product_name")) %><%=CommonString.getFormatPara(oneMap.get("cataname")) %>" target="_blank" href="/inquiry/detail_for_<%=CommonString.getFormatPara(oneMap.get("id")) %>.htm"><%=CommonString.getFormatPara(oneMap.get("product_name")) %><%=CommonString.getFormatPara(oneMap.get("cataname")) %></a></li>
          <li class="i3"><%=(CommonString.getFormatPara(oneMap.get("name")).length()>0)?CommonString.getFormatPara(oneMap.get("name")).substring(0,1)+"***":"张**" %></li>
          <li class="i4"><%=showtel %></li>
          <li class="i5"><a href="/inquiry/0_0_1742_0_0.shtm" target="_blank"><%=CommonString.getFormatPara(oneMap.get("factoryname")) %></a></li>
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

</script> 
<script type="text/javascript">
function addShop(){　 // 收藏店铺
    try{
       window.external.addFavorite('http://product.21-sun.com/brandshop/linde/', '林德(中国)叉车有限公司');
   }catch (e){
       try{
           window.sidebar.addPanel('林德(中国)叉车有限公司','http://product.21-sun.com/brandshop/linde/',"");
       }catch (e){
           alert("加入收藏失败，请使用Ctrl+D进行添加");
       }
   }
}
</script> 
<script type="text/javascript" src="/scripts/scrolltopcontrol.js"></script> 
</body>
</html>