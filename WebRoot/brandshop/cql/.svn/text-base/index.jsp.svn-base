<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" import="com.jerehnet.util.dbutil.PageBean,com.jerehnet.util.common.CommonString,com.jerehnet.util.dbutil.DBHelper,java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.jerehnet.util.common.CommonString"%>
<%@page import="com.jerehnet.util.common.CommonHtml"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="tags"%>
<%
	DBHelper dbHelper = DBHelper.getInstance() ;
   //公司信息
   String  company="select introduce from pro_agent_factory where id=138";
   List<Map> companyInfo = null ;
   companyInfo = dbHelper.getMapList(company) ;
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="author" content="design by www.21-sun.com" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<title>卡特彼勒（青州）有限公司官方旗舰店</title>
<meta name="keywords" content="山工装载机,山工推土机，山工平地机，山工压路机，山工压实机，山工产品报价,山工产品,山工产品图片,山工产品介绍" />
<meta name="description" content="铁臂商城为您提供卡特彼勒（青州）介绍,卡特彼勒（青州）产品介绍,卡特彼勒（青州）产品报价,卡特彼勒（青州）产品图片,卡特彼勒（青州）产品展示等卡特彼勒（青州）产品信息，帮助您全面了解卡特彼勒（青州）" />
<link href="style/style.css" rel="stylesheet" type="text/css" />
<link href="style/flag_shop02.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="scripts/jquery.min.js"></script>
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
<div class="sg_nav clearfix">
    	<div class=" wrap">
    	<h1><img src='images/logo.jpg' width="147" height="45"/></h1>
        <ul>
		<li><a href="/brandshop/cql/">首页</a></li>
        <li><a href="/brandshop/cql/list.jsp?catalog=101002" target="_blank">装载机</a></li>
        <li><a href="/brandshop/cql/list.jsp?catalog=101003" target="_blank">推土机</a></li>
        <li><a href="/brandshop/cql/list.jsp?catalog=101005" target="_blank">平地机</a></li>
        <li><a href="/brandshop/cql/list.jsp?catalog=106001" target="_blank">压路机</a></li>
        <li><a href="/brandshop/cql/list.jsp?catalog=106003" target="_blank">压实机</a></li>
        <li><a href="/brandshop/cql/about.jsp" target="_blank">关于我们</a></li>
        </ul>
        </div>
    </div>
<div class="sg_banner"></div>
<div class="wrap con clearfix" id="b00">
    	<div class="con1 l">
        	<h3 class="sg_tit"><a href="/brandshop/cql/about.jsp"></a></h3>
            <div class="info">
            	<img src='images/img1.jpg' width="408" height="248"/>
                <p>　			  <%
			  if(null!=companyInfo && companyInfo.size()>0){
				Map oneMap = null ;
				for(int i=0;i<companyInfo.size();i++){
					oneMap = (HashMap)companyInfo.get(i);
					String intro=CommonHtml.filterHTML(CommonString.getFormatPara(oneMap.get("introduce")));
					if(intro.length()>400){intro=intro.substring(0,400);}
		     %>
			    <%=intro%>...
				<%}}%><a target="_blank" href="/brandshop/cql/about.jsp"> [查看更多]</a></p>
            </div>
      </div>
	  <!--装载机-->
	  <div class="con2 l" id="b11">
      	<h3 class="sg_tit"><a href="/brandshop/cql/list.jsp?catalog=101002"></a></h3>
        <ul >
        	<li>
            	<div class="img">
            		<a href="http://product.21-sun.com/proDetail/SEM630B.shtm" target="_blank"><img src='images/img2.jpg' width="607" height="386"/></a>
            	</div>
           	  <div class="intro">
               	<h4>山工SEM630B装载机</h4>
                  <p>所属系列：30系列装载机<br />
                      所属工况：轻工况<br />
                      所属吨位：3吨<br />
                      牵引力:97kN<br />
                      掘起力 :1127kN<br />
                  卸载高度 :3101 mm</p>
                  <a class="a1" onclick="javascript:down('/uploadfiles/file/2014/04/SEM630B.pdf','SEM630B')"></a>
              	 <a class="a2" href="javascript:;" onClick="showinquery('5862','');"></a>
                </div>
            </li>
            <li>
            	<div class="img">
           		<a href="http://product.21-sun.com/proDetail/ZLF16F.shtm" target="_blank"> <img src='images/img3.jpg' width="607" height="386"/></a>
                 </div>
           	  <div class="intro">
               	<h4>山工SEM616B装载机</h4>
                  <p>所属系列：16系列装载机<br />
                    所属工况：轻工况<br />
                    所属吨位：1.6吨<br />
                    牵引力:49kN<br />
                    掘起力 :48kN<br />
                  卸载高度 :2409 mm</p>
                  <a class="a1"  onclick="javascript:down('/uploadfiles/file/2014/04/SEM616B.pdf','SEM616B')" ></a>
              	 <a class="a2"  href="javascript:;" onClick="showinquery('800','');"></a>
                </div>
            </li>
            <li>
            	<div class="img">
           		 <a href="http://product.21-sun.com/proDetail/ZL5-G-I.shtm" target="_blank"><img src='images/img4.jpg' width="607" height="386"/></a>
           		</div>
           	  <div class="intro">
               	<h4>山工ZL50F-II装载机</h4>
                  <p>所属系列：50系列装载机<br />
                    所属工况：重工况<br />
                    所属吨位：5吨<br />
                    牵引力:161kN<br />
                    掘起力 :177kN<br />
                  卸载高度 :3142 mm</p>
				    <a class="a1" onclick="javascript:down('/uploadfiles/file/2014/04/ZL50F.pdf','SEM630B')"></a>
              	 <a class="a2" href="javascript:;" onClick="showinquery('883','');"></a>
                </div>
            </li>
        </ul>
      </div>
	   <!--推土机-->
      <div class="con3 l mb20" id="b22">
    	<h3 class="sg_tit"><a href="/brandshop/cql/list.jsp?catalog=101003"></a></h3>
      	<a href="javascript:;" onClick="showinquery('15634','');"><img src='images/img5.jpg' width="980" height="388"/></a>
      </div>
	   <!--平地机-->
  <div class="con4 l mb20" id="b33">
     	<h3 class="sg_tit"><a href="/brandshop/cql/list.jsp?catalog=101005"></a></h3>
      	<a href="javascript:;" onClick="showinquery('10965','');"><img src='images/img6.jpg' width="980" height="388"/></a>
      </div>
	   <!--压路机-->
         <div class="con5 l mb20" id="b44">
      	<h3 class="sg_tit"><a href="/brandshop/cql/list.jsp?catalog=106001"></a></h3>
      	<a href="javascript:;" onClick="showinquery('7449','');"><img src='images/img7.jpg' width="980" height="388"/></a>
      </div>
	   
       <div class="con6 l mb20" id="b55">
      	<h3 class="sg_tit"><a href="/inquiry/0_0_138_0_0.shtm" target="_blank"></a></h3>
    	  <div class="contain980 shopPart08">
 			 <div class="content">
    <div class="w978 border03 l list08">
    	<div class="clearfix yhdedd">
        	<div class="l title_left">山工产品订单</div>
            <div class="r more_right"><a target="_blank" href="/inquiry/0_0_138_0_0.shtm">更多&gt;&gt;</a></div>
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
       pageBean.setCondition(" and factoryid=138 and factoryname <>'' and factoryname is not null and name is not null and name<>'' and product_name is not null and product_name<>''") ;
       pageBean.setNowPage(nowPage) ;
       pageBean.setOrderBy(" add_date desc") ;
       pageBean.setParams("#to_order") ;
       orderList = pageBean.getDatas() ;
    		%>
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
	  		Map oneMap = orderList.get(i) ;
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
    <div class="side"><img src='images/code.jpg' /></div>
	
	<jsp:include page="/brandshop/include/foot.jsp" flush="true"></jsp:include>
	
<script type="text/javascript">
function down(obj,obj1){
    window.open("/brandshop/cql/down.jsp?filename="+encodeURI(obj)+"&title="+encodeURI(obj1));
}
</script>
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
<div style="display:none"><script type="text/javascript">var cnzz_protocol = (("https:" == document.location.protocol) ? " https://" : " http://");document.write(unescape("%3Cspan id='cnzz_stat_icon_5865198'%3E%3C/span%3E%3Cscript src='" + cnzz_protocol + "s22.cnzz.com/stat.php%3Fid%3D5865198' type='text/javascript'%3E%3C/script%3E"));</script></div> 

</body>
</html>