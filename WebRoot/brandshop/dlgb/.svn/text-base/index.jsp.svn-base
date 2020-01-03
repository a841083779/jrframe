<%@ page language="java" import="com.jerehnet.util.dbutil.PageBean,com.jerehnet.util.common.CommonString,com.jerehnet.util.dbutil.DBHelper,java.util.*" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="tags"%>
<%
	DBHelper dbHelper = DBHelper.getInstance() ;
	String rec_sql="";
	//工兵
	List<Map> gb_hot = new ArrayList() ;
	rec_sql = "select top 3 * from pro_products where factoryid=776 and is_show=1  and zoomlion_hot =11" ; 
	gb_hot = dbHelper.getMapList(rec_sql+"order by id desc") ;
	
	List<Map> gb_list = new ArrayList() ;
	rec_sql = "select top 4 * from pro_products where factoryid=776 and is_show=1 and zoomlion_hot!=11" ; 
	gb_list = dbHelper.getMapList(rec_sql+"order by id desc") ;
	//水山
	List<Map> ss_hot = new ArrayList() ;
	rec_sql = "select top 3 * from pro_products where factoryid=14300 and is_show=1 and zoomlion_hot =11" ; 
	ss_hot = dbHelper.getMapList(rec_sql+"order by id desc") ;
	
	List<Map> ss_list = new ArrayList() ;
	rec_sql = "select top 4 * from pro_products where factoryid=14300 and is_show=1 and zoomlion_hot!=11 " ; 
	ss_list = dbHelper.getMapList(rec_sql+"order by id desc") ;
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="author" content="design by www.21-sun.com" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<title>连云港工兵旗舰店</title>
<meta name="keywords" content="连云港工兵,连云港工兵产品报价,连云港工兵产品,连云港工兵产品图片,连云港工兵产品介绍,连云港工兵介绍" />
<meta name="description" content="铁臂商城为您提供连云港工兵介绍,连云港工兵产品介绍,连云港工兵产品报价,连云港工兵产品图片,连云港工兵产品展示等连云港工兵产品信息，帮助您全面了解连云港工兵" />
<link href="/style/style.css" rel="stylesheet" type="text/css" />
<link href="style/style.css" rel="stylesheet" type="text/css" />
<link href="style/flag_shop02.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="scripts/jquery.min.js"></script>
<script type="text/javascript" src="/scripts/scripts.js"></script>
<script type="text/javascript" src="/scripts/jBox-v2.3/jquery.jBox-2.3.min.js"></script>
<script type="text/javascript" src="/scripts/jBox-v2.3/i18n/jquery.jBox-zh-CN.js"></script>
<script type="text/javascript" src="/scripts/sort.js"></script>
<link type="text/css" rel="stylesheet"	href="/scripts/jBox-v2.3/Skins2/Blue/jbox.css" />
<!--[if (IE 6)]>
<script src="scripts/iepng.js" type="text/javascript"></script>
<script type="text/javascript">
   EvPNG.fix('.ee'); 
</script>
<![endif]-->
</head>
<body>
<!--<jsp:include page="/brandshop/include/top.jsp" flush="true"></jsp:include>-->
<div class="top">
  <div class="wrap">
    <div class="logo"><img src='images/logo.jpg' width="438" height="78" alt="3月优买团连云港工兵"/></div>
  </div>
</div>
<div class="banner">
  <div class="wrap bb">
    <p class="btxt">连云港工兵GBPSC商标由工兵机械（韩国）有限公司持有。由连云港工兵国际贸易有限公司运营，产品以卓越的品质和完善的售后服务在业内行成了良好的口碑，成为国内外众多知名厂家的首选品牌。液压机械以最尖端的工程技术为基础满足不断发展的用户需求，公司以“保持国内领先地位”为目标，始终坚持“跟踪先进、引进消化、纵向延伸、横向扩展”的产品销售战略。</p>
  </div>
</div>
<div class="nav">
  <ul class="wrap clearfix">
    <li><a href="#">首页</a></li>
    <li><a href="#b33">公司介绍</a></li>
    <li><a href="#b11">工兵破碎锤</a></li>
    <li><a href="#b22">水山破碎锤</a></li>
    <li><a href="#b44">产品订单</a></li>
  </ul>
</div>
<div class="wrap">
  <div class="con  clearfix" id="b11">
    <h3 class="tit"><a target="_blank" class="more" href="/products/prolist.jsp?factory=776"></a></h3>
    <ul class="imgList">
	
	<%
	        Map oneMap = null ;
			if(null!=gb_hot && gb_hot.size()>0){
			//zoomlion_hot_pic		
				for(int i=0;i<=gb_hot.size()-1;i++){
					oneMap = (HashMap)gb_hot.get(i);
					String name=CommonString.getFormatPara(oneMap.get("factoryname"))+CommonString.getFormatPara(oneMap.get("name")) +CommonString.getFormatPara(oneMap.get("catalogname"));
					if(name.length()>10)
					{
					   name=name.substring(0,10)+"...";
					}
	%>
      <li title="<%=CommonString.getFormatPara(oneMap.get("factoryname"))+CommonString.getFormatPara(oneMap.get("name")) +CommonString.getFormatPara(oneMap.get("catalogname"))%>"  <%if(i==0){%>class="first"<%}else{%>class="sec"<%}%>><a href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")) %>" target="_blank"><img <%if(i==0){%>width="433" height="243"<%}%> src='<%="/uploadfiles/"+CommonString.getFormatPara(oneMap.get("zoomlion_hot_pic")) %>' onerror="showImgDelay(this,'/uploadfiles/no_small.gif',2);"/></a>
        <p><span><%=name%><br />
          <em>价格：<%=CommonString.getFormatPara(oneMap.get("price_start")) %>万</em></span> <a title="<%=CommonString.getFormatPara(oneMap.get("factoryname"))+CommonString.getFormatPara(oneMap.get("name")) +CommonString.getFormatPara(oneMap.get("catalogname"))%>" href="javascript:;" onclick="showinquery('<%=CommonString.getFormatPara(oneMap.get("id")) %>','');" class="order"></a> </p>
      </li>	  
     <%}}%> 
	  
	  
  	<%
			if(null!=gb_list && gb_list.size()>0){
			//zoomlion_hot_pic		
				for(int i=0;i<=gb_list.size()-1;i++){
					oneMap = (HashMap)gb_list.get(i);
					String name=CommonString.getFormatPara(oneMap.get("factoryname"))+CommonString.getFormatPara(oneMap.get("name")) +CommonString.getFormatPara(oneMap.get("catalogname"));
					if(name.length()>10)
					{
					   name=name.substring(0,10)+"...";
					}
	%>
      <li title="<%=CommonString.getFormatPara(oneMap.get("factoryname"))+CommonString.getFormatPara(oneMap.get("name")) +CommonString.getFormatPara(oneMap.get("catalogname"))%>"><a href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")) %>" target="_blank"><img width="228"  height="230" src='<%="/uploadfiles/"+CommonString.getFormatPara(oneMap.get("zoomlion_hot_pic")) %>' onerror="showImgDelay(this,'/uploadfiles/no_small.gif',2);"/></a>
        <p><span><%=name%><br />
          <em>价格：<%=CommonString.getFormatPara(oneMap.get("price_start")) %>万</em></span> <a title="<%=CommonString.getFormatPara(oneMap.get("factoryname"))+CommonString.getFormatPara(oneMap.get("name")) +CommonString.getFormatPara(oneMap.get("catalogname"))%>" href="javascript:;" onclick="showinquery('<%=CommonString.getFormatPara(oneMap.get("id")) %>','');" class="order"></a> </p>
      </li>	  
     <%}}%> 

    </ul>
  </div>
  <div class="con clearfix"  id="b22">
    <h3 class="tit t2"><a class="more" href="/products/prolist.jsp?factory=14300" target="_blank"></a></h3>
    <ul class="imgList">
	
	<%
			if(null!=ss_hot && ss_hot.size()>0){
			//zoomlion_hot_pic		
				for(int i=0;i<=ss_hot.size()-1;i++){
					oneMap = (HashMap)ss_hot.get(i);
										String name=CommonString.getFormatPara(oneMap.get("factoryname"))+CommonString.getFormatPara(oneMap.get("name")) +CommonString.getFormatPara(oneMap.get("catalogname"));
					if(name.length()>10)
					{
					   name=name.substring(0,10)+"...";
					}
	%>
      <li title="<%=CommonString.getFormatPara(oneMap.get("factoryname"))+CommonString.getFormatPara(oneMap.get("name")) +CommonString.getFormatPara(oneMap.get("catalogname"))%>"  <%if(i==0){%>class="first"<%}else{%>class="sec"<%}%>><a href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")) %>" target="_blank"><img <%if(i==0){%>width="433" height="243"<%}%> src='<%="/uploadfiles/"+CommonString.getFormatPara(oneMap.get("zoomlion_hot_pic")) %>' onerror="showImgDelay(this,'/uploadfiles/no_small.gif',2);"/></a>
        <p><span><%=name%><br />
          <em>价格： <%=CommonString.getFormatPara(oneMap.get("price_start")) %>万</em></span> <a title="<%=CommonString.getFormatPara(oneMap.get("factoryname"))+CommonString.getFormatPara(oneMap.get("name")) +CommonString.getFormatPara(oneMap.get("catalogname"))%>" href="javascript:;" onclick="showinquery('<%=CommonString.getFormatPara(oneMap.get("id")) %>','');" class="order"></a> </p>
      </li>	  
     <%}}%> 

     <%
			if(null!=ss_list && ss_list.size()>0){
			//zoomlion_hot_pic		
				for(int i=0;i<=ss_list.size()-1;i++){
					oneMap = (HashMap)ss_list.get(i);
										String name=CommonString.getFormatPara(oneMap.get("factoryname"))+CommonString.getFormatPara(oneMap.get("name")) +CommonString.getFormatPara(oneMap.get("catalogname"));
					if(name.length()>10)
					{
					   name=name.substring(0,10)+"...";
					}
	%>
      <li title="<%=CommonString.getFormatPara(oneMap.get("factoryname"))+CommonString.getFormatPara(oneMap.get("name")) +CommonString.getFormatPara(oneMap.get("catalogname"))%>"><a href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")) %>" target="_blank"><img width="228"  height="230" src='<%="/uploadfiles/"+CommonString.getFormatPara(oneMap.get("zoomlion_hot_pic")) %>' onerror="showImgDelay(this,'/uploadfiles/no_small.gif',2);"/></a>
        <p><span><%=name%><br />
          <em>价格：<%=CommonString.getFormatPara(oneMap.get("price_start")) %>万</em></span> <a title="<%=CommonString.getFormatPara(oneMap.get("factoryname"))+CommonString.getFormatPara(oneMap.get("name")) +CommonString.getFormatPara(oneMap.get("catalogname"))%>" href="javascript:;" onclick="showinquery('<%=CommonString.getFormatPara(oneMap.get("id")) %>','');" class="order"></a> </p>
      </li>	  
     <%}}%> 
	 
	 
    </ul>
  </div>
  <div class="con clearfix"  id="b33">
    <h3 class="tit t3"></h3>
    <div class="txt"> 　　工兵国际贸易有限公司所销售的GBPSC系列液压破碎锤机芯全部源自韩国，以卓越的品质和完善的售后服务在业内行成了良好的口碑,成为国内外众多知名厂家的首选品牌。液压机械以最尖端的工程技术为基础满足不断发展的用户需求,公司以“保持国内领先地位”为目标，始终坚持“跟踪先进、引进消化、纵向延伸、横向扩展”的产品销售战略。引进韩国先进液压生产技术，逐步形成了自己的企业技术标准，打造具有国际竞争力的工程机械制造基地，成为国际化的工程机械制造商。
      Engineering Machinery (Korea) Limited which bases on the super quality and impeccable after-sale service has won a good reputation from the customers, and has been the first choice brand for the customers. The movements of GBPSC hydraulic breaker hammers are all South Korea original product. Hydraulic machinery                              
      bases on the top engineering technology in order to meet the customers’ requirements.
      We take “keep on the leading position in domestic market” as our developing goal, and we insist “following technology, bringing in new skills, vertical and horizontal extension” as our product sales strategy. We bring in the advanced hydraulic producing technology from South Korea and has formed our own technology standard. Now we have built an international competitive engineering machinery manufacturing factory and have becoming an international engineering machinery manufacturer. <br />
      <br />
      　　连云港工兵破碎锤销售有限公司引进国际先进的技术和科学的经营管理理念，为客户提供高品质，低价位的产品，提高产品竞争力，为客户降低成本，提供优质服务和创造最佳经济效益。我们的产品畅销全国。质量可靠、价格公道、信誉度高、售后服务好，是广大人企业的首选产品。连云港民盛破碎锤销售有限公司信奉“经商先做人”的为商之道，有着较强的技术与管理力量。真诚欢迎国内外客商前来洽谈、订购。<br />
      Lianyungang gongbing hydraulic breaker hammers Sale Company bring in the international advanced technology and scientific management. We supply the high-quality and low price product，enhance the competitiveness of the product, reduce the cost for customers. We provide the high-quality after-sale service and create the best economic benefit so our products are sold well all over the country.Reliable quality, reasonable price, high reputation, good after-sale service have made our products be the first choice for the customers. We believe that “to do business, conduct ourselves first” and we have rich technology and management power. We sincerely welcome domestic and foreign customers to come to negotiate and place orders!<br />
      <br />
      　　水山机械（连云港）有限公司坐落于美丽的山海城市连云港，是一家集整机销售、服务维修、配件制造为一体的大型专业化液压破碎器经营企业。公司下辖销售中心、维修中心、配件中心、物流中心等完善配套机构。水山机械以其专业的技术经验，全力为客户打造快速反应的系统方案及优良的售后服务。公司历练多年，依靠稳健扎实的市场推广和游刃有余的环节协作，形成了完整的破碎工程专业化体系和强劲的市场竞争实力。 <br />
      Shuishan Machinery (Lianyungang) CO., LTD. is located in the beautiful mountain<br />
      coastal city Lianyungang. We are a big professional manufacture of hydraulic breaker hammers which includes whole machine sale, after-sale service, making its accessories. The company was made up by sale center, repair center, making accessories, logistics center and etc. With the professional technology experience, we make every effort to supply a rapid and perfect after-sale service. Our company has been making great efforts to develop for many years. And we base on the stable marketing and flexible <br />
      cooperation. Now we have formed a professional breaker engineering system and competitive market. <br />
    </div>
  </div>
  <div class="con clearfix" id="b44">
    <h3 class="tit t4"><a class="more" href="/inquiry/0_0_776_0_0.shtm" target="_blank"></a></h3>
    <div class="contain980 shopPart08">
      <div class="content">
        <div class="w978 border03 l list08">
          <div class="clearfix yhdedd">
            <div class="l title_left">连云港工兵产品订单</div>
            <div class="r more_right"><a target="_blank" href="/inquiry/0_0_776_0_0.shtm">更多&gt;&gt;</a></div>
          </div>
          <div class="title08">
            <%
   	    String offset = CommonString.getFormatPara(request.getParameter("offset"));
       List<Map> orderList = null ;
       PageBean pageBean = new  PageBean() ;
       pageBean.setPageSize(10) ;
		Integer nowPage = 1;
		if("".equals(offset) || Integer.parseInt(offset)<=0){
			offset = "0" ;
		}
		if (!"".equals(offset) && !"0".equals(offset)) {
			nowPage = Integer.parseInt(offset) / pageBean.getPageSize() + 1;
		}
       pageBean.setTableName("pro_product_form") ;
       pageBean.setFields("factoryid ,id, factoryname,product_name,contact_address,cataname,name,mobile_phone,province,city,add_date") ;
       pageBean.setCondition(" and factoryid=776 and factoryname <>'' and factoryname is not null and name is not null and name<>'' and product_name is not null and product_name<>''") ;
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
            <ul class="libg0<%=((i%2)+1)%>">
              <li class="i1"><%=i+1 %></li>
              <li class="i2"><a target="_blank" href="/inquiry/detail_for_<%=CommonString.getFormatPara(oneMap.get("id")) %>.htm"><%=CommonString.getFormatPara(oneMap.get("factoryname")) %><%=CommonString.getFormatPara(oneMap.get("product_name")) %><%=CommonString.getFormatPara(oneMap.get("cataname")) %></a></li>
              <li class="i3"><%=(CommonString.getFormatPara(oneMap.get("name")).length()>0)?CommonString.getFormatPara(oneMap.get("name")).substring(0,1)+"***":"张**" %></li>
              <li class="i4"><%=showtel %></li>
              <li class="i5"><a href="http://product.21-sun.com/inquiry/0_0_<%=CommonString.getFormatPara(oneMap.get("factoryid")) %>_0_0.shtm" target="_blank"><%=CommonString.getFormatPara(oneMap.get("factoryname")) %></a></li>
              <li class="i6"><%="".equals(CommonString.getFormatPara(oneMap.get("contact_address")))?"-":CommonString.getFormatPara(oneMap.get("contact_address"))  %></li>
              <li class="i7"><%=(CommonString.getFormatPara(oneMap.get("add_date")).length()>15)?CommonString.getFormatPara(oneMap.get("add_date")).substring(0,16):CommonString.getFormatPara(oneMap.get("add_date")) %></li>
            </ul>
            <%
	  	 }
	  }
	  %>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>
<!--<jsp:include page="/include/foot.jsp" flush="true"></jsp:include>-->
<script type="text/javascript">
(function($){
 $.extend($.fn,{
 scrollTo:function(time,to){
 time=time||800;
 to=to||1;
            $('a[href*=#]', this).click(function(){
                if (location.pathname.replace(/^\//, '') == this.pathname.replace(/^\//, '') && 
location.hostname == this.hostname) {
      var $target = $(this.hash);
     $target = $target.length && $target || $('[name=' + this.hash.slice(1) + ']');
                    if ($target.length) {
                        if (to == 1) {
                            $('html,body').animate({
                                scrollTop: $target.offset().top
                            }, time);
                        }
                        else if(to==2){
                            $('html,body').animate({
                                scrollLeft: $target.offset().left
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
})($);
$(function(){
  $("body").scrollTo(700)
})
</script>
</body>
</html>