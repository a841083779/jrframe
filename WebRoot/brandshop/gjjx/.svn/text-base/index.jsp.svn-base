<%@ page language="java" import="com.jerehnet.util.dbutil.PageBean,com.jerehnet.util.common.CommonString,com.jerehnet.util.dbutil.DBHelper,java.util.*" pageEncoding="UTF-8"%>
<%
    Map oneMap = null ;
	DBHelper dbHelper = DBHelper.getInstance() ;
	//首页推荐
    String sql = "select top 3  id,name,file_name,img2,catalogname_spe,catalognum_spe,zoomlion_hot_pic ,catalogname,factoryname from pro_products where factoryid=133 and is_show=1 and catalognum like '101001%' and zoomlion_hot =11   order by view_count desc" ;
	List<Map> productList	= null ;
	productList = dbHelper.getMapList(sql) ;
	//大挖
    String dw = "select top 2  id,name,file_name,img2,catalogname_spe,catalognum_spe,zoomlion_hot_pic ,catalogname,factoryname from pro_products where factoryid=133 and is_show=1 and catalognum like '101001%'  and tonandmeter>=30   order by view_count desc" ;
	List<Map> productListdw	= null ;
	productListdw = dbHelper.getMapList(dw) ;
	//中挖
    String zw = "select top 2  id,name,file_name,img2,catalogname_spe,catalognum_spe,zoomlion_hot_pic ,catalogname,factoryname from pro_products where factoryid=133 and is_show=1 and catalognum like '101001%'  and (tonandmeter>13 and tonandmeter<30)  order by view_count desc" ;
	List<Map> productListzw	= null ;
	productListzw = dbHelper.getMapList(zw) ;
	//小挖
    String sw = "select top 2  id,name,file_name,img2,catalogname_spe,catalognum_spe,zoomlion_hot_pic ,catalogname,factoryname from pro_products where factoryid=133 and is_show=1 and catalognum like '101001%' and tonandmeter<=13   order by view_count desc" ;
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
<jsp:include page="top.jsp" flush="true"></jsp:include>
<div class="slide shopBanner">
  <div class="ban_c"><img src="images/banner01.jpg" width="1862" height="600" /></div>
  <div class="ban_c"><img src="images/banner01.jpg" width="1862" height="600" /></div>
</div>

<div class="sp" id="tuijian">
  <div class="shopWrap">
    <div class="hd">
      <h3><img src="images/t_01.png" alt="热销产品" width="307" height="91" class="pngfix" /></h3>
    </div>
    <div class="bd">
      <div class="sb"><a href="/proDetail/SY75C-9(2013K).shtm" target="_blank"><img src="images/ban_img01.jpg" width="950" height="304" /></a></div>
      <div class="plist01">
        <ul class="fix">
		
	    <% 
			if(null!=productList && productList.size()>0){
				for(int i=0;i<productList.size();i++){
					oneMap = (HashMap)productList.get(i);

        %>
          <li><a title="<%=CommonString.getFormatPara(oneMap.get("factoryname"))%><%=CommonString.getFormatPara(oneMap.get("name"))+CommonString.getFormatPara(oneMap.get("catalogname"))%>" href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name"))%>" target="_blank"><img src="http://product.21-sun.com/uploadfiles/<%=CommonString.getFormatPara(oneMap.get("zoomlion_hot_pic")) %>" width="310" height="250" />
            <h3><%=CommonString.getFormatPara(oneMap.get("factoryname"))%><br /><%=CommonString.getFormatPara(oneMap.get("name"))+CommonString.getFormatPara(oneMap.get("catalogname"))%></h3></a>
            <a href="javascript:void(0);" onclick="showinquery('<%=CommonString.getFormatPara(oneMap.get("id"))%>','133')" class="xj_btn">立即抢购</a>
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

<div class="sp" id="introduce">
  <div class="shopWrap">
    <div class="hd">
      <h3><img src="images/t_05.png" alt="公司介绍" width="307" height="91" class="pngfix" /></h3>
    </div>
    <div class="bd about">
      <div class="fix">
        <img src="images/ban_img05.jpg" width="275" height="161" class="l" />
        <p>重庆国杰工程机械有限公司成立于2007年12月，前身为三一集团下属公司三一重机有限公司驻重庆分公司。公司集三一挖掘机整机销售、配件销售、售后维修服务、技术咨询服务于一体。公司总部位于重庆市大渡口区建桥工业园C区华福路中段1号三一重工，下属9个分公司：重庆主城、永川、黔江、万州、涪陵、乐眉、资阳、宜宾、泸州。 </p><br />
        <p>目前公司员工人数380多名，拥有60多名在本行业从业3年以上的优秀工作人员，形成了功能齐全的售前、售中、售后为一体的专业化服务队伍。公司成立之初对人才培养尤为重视，公司秉承“创建一流企业，造就一流人才，做出一流贡献”的公司宗旨 。倡导“先做人，后做事”、“品质改变世界”的核心价值观和“疾慢如仇”的工作作风”。为客户提供最完善、最专业、最便捷的服务。</p>
      </div>
    </div>
  </div>
</div>

<div class="sp" id="contact">
  <div class="shopWrap">
    <div class="hd">
      <h3><img src="images/t_06.png" alt="联系方式" width="307" height="91" class="pngfix" /></h3>
    </div>
    <div class="bd contact">
      <p><strong>重庆国杰工程机械有限公司</strong><br />
      重庆市大渡口区建桥工业园C区华福路中段1号三一重工<br />
      邮编：400800 <br />
      电话：023-88103565 <br />
      传真：023-88103565 <br />
      邮箱：ganluo522@126.com <br />
      网址：http://www.cqguojie.com</p> 
    </div>
  </div>
</div>


<div class="sp" id="introduce">
  <div class="shopWrap">
    <div class="hd">
      <h3><img src="images/t_011.png" alt="产品订单" width="307" height="91" class="pngfix" /></h3>
    </div>
    <div class="bd about">

	    <div class="bgmain">
	
      <div class="contain980 shopPart08" style="width:950px">
        <div class="content">
          <div class="w978 border03 l list08" style="width:950px">

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
       pageBean.setCondition("and is_deleted=0	   and factoryid=133 and province like '%重庆%' and factoryname <>'' and factoryname is not null and name is not null and name<>'' and product_name is not null and product_name<>''") ;
       pageBean.setNowPage(nowPage) ;
       pageBean.setOrderBy(" add_date desc") ;
       pageBean.setParams("#to_order") ;
       orderList = pageBean.getDatas() ;
       %>
              <h3><b>询价总数：<%=pageBean.getTotal() %></b> - 采购询价</h3>
			  <div class="r more_right"><a href="http://product.21-sun.com/inquiry/chongqing_0_133_0_0.shtm" target="_blank">更多订单&gt;&gt;</a></div>
              <span style="display:none">共有<font><%=pageBean.getTotal()  %></font>个符合条件</span> </div>
            <ul class="ti">
              <li class="i1">编号</li>
              <li class="i2" style="width: 288px">询价产品</li>
              <li class="i3" style="width: 129px">联系人</li>
              <li class="i4">电话</li>
              <li class="i5">询价品牌</li>
              <li class="i6" style="width: 134px;">询价区域</li>
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
    		}else if(showtel.length()>3){
    			showtel = showtel.substring(0,4)+"***" ;
    		}else
    		{
    			showtel = showtel+"***" ;
    		}
    		%>
              <ul class="libg01">
                <li class="i1"><%=i+1 %></li>
                <li class="i2" style="width: 283px"><a href="/inquiry/detail_for_<%=CommonString.getFormatPara(oneMap.get("id")) %>.htm" target="_blank"><%=CommonString.getFormatPara(oneMap.get("factoryname")) %><%=CommonString.getFormatPara(oneMap.get("product_name")) %><%=CommonString.getFormatPara(oneMap.get("cataname")) %></a></li>
                <li class="i3" style="width: 129px"><%=(CommonString.getFormatPara(oneMap.get("name")).length()>0)?CommonString.getFormatPara(oneMap.get("name")).substring(0,1)+"***":"张**" %></li>
                <li class="i4"><%=showtel %></li>
                <li class="i5"><a target="_blank" href="http://product.21-sun.com/inquiry/0_0_<%=CommonString.getFormatPara(oneMap.get("factoryid")) %>_0_0.shtm"><%=CommonString.getFormatPara(oneMap.get("factoryname")) %></a></li>
                <li class="i6" style="width: 134px;"><%="".equals(CommonString.getFormatPara(oneMap.get("contact_address")))?"-":CommonString.getFormatPara(oneMap.get("contact_address"))  %></li>
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
<script>window._bd_share_config={"common":{"bdSnsKey":{},"bdText":"","bdMini":"2","bdMiniList":false,"bdPic":"","bdStyle":"0","bdSize":"16"},"slide":{"type":"slide","bdImg":"0","bdPos":"right","bdTop":"100"}};with(document)0[(getElementsByTagName('head')[0]||body).appendChild(createElement('script')).src='http://bdimg.share.baidu.com/static/api/js/share.js?v=89860593.js?cdnversion='+~(-new Date()/36e5)];</script>

<script type="text/javascript" src="/scripts/scrolltopcontrol.js"></script> 
</body>
</html>