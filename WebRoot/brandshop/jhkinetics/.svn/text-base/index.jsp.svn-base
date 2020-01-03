<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.jerehnet.util.dbutil.DBHelper"%>
<%@page import="com.jerehnet.util.common.CommonString"%>
<%
	DBHelper dbHelper = DBHelper.getInstance() ;
	String sel_sql = "  select top 4 * from pro_products where factoryid=1220 and catalognum_spe=? and is_show=1 " ;
	List<Map> productsList = null ;
	
	List<Map> recommondProductsList = new ArrayList() ;
	String rec_sql = " select top 6 * from pro_products where factoryid=1220 and zoomlion_hot=11 and is_show=1 order by order_no desc " ; // 是否热卖推荐
	recommondProductsList = dbHelper.getMapList(rec_sql) ;
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="author" content="design by www.21-sun.com" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<title>江苏华通官方旗舰店_中国工程机械商贸网</title>
<meta name="keywords" content="江苏华通,江苏华通产品报价,江苏华通产品,江苏华通产品图片,江苏华通产品介绍,江苏华通介绍" />
<meta name="description" content="中国工程机械商贸网为您提供江苏华通介绍,江苏华通产品介绍,江苏华通产品报价,江苏华通产品图片,江苏华通产品展示等江苏华通产品信息，帮助您全面了解江苏华通。" />
<link href="/style/style.css" rel="stylesheet" type="text/css" />
<link href="style/flag_shop02.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="/scripts/jquery-1.7.min.js"></script>
<script type="text/javascript" src="/scripts/scripts.js"></script>
<script type="text/javascript" src="/scripts/jBox-v2.3/jquery.jBox-2.3.min.js"></script>
<script type="text/javascript" src="/scripts/jBox-v2.3/i18n/jquery.jBox-zh-CN.js"></script>
<script type="text/javascript" src="/scripts/sort.js"></script>
<link type="text/css" rel="stylesheet"	href="/scripts/jBox-v2.3/Skins2/Blue/jbox.css" />
<!--[if (IE 6)]>
<link href="/style/pngfix.css" media="screen" rel="stylesheet" type="text/css" />
<![endif]-->
</head>
<body class="flag_shop">
<!--top-->
<jsp:include page="/brandshop/include/top.jsp" flush="true"></jsp:include>
<jsp:include page="top.jsp" flush="true"></jsp:include>
<!--main-->
<div class="new_rec" style="background:#ffb806 url(/images/new_bigbanner1.jpg) center top no-repeat;"> <a href="/proDetail/EPC125B-18.shtm" target="_blank" title="EPC125B全液压多功能摊铺机"></a> </div>
<div class="shopPart01">
  <div class="contain980 pt20 pb20">
    <div class="coupon_top"> <span class="tip">售前咨询<br />
      <em>09:00-17:00</em></span>
      <ul class="qq">
        <li style="width:100px;">  <a target="_blank" href="http://wpa.qq.com/msgrd?v=3&uin=673965016&site=qq&menu=yes"><img src="http://wpa.qq.com/pa?p=2:673965016:45" alt="点击这里给我发消息" border="0" align="absmiddle" title="点击这里给我发消息">  673965016</a> </li>
      </ul>
      <div class="icon"><img src="/images/ico.gif" alt="旗舰店放心购" width="80" height="17" /></div>
	  <div class="hotLine">江苏华通动力客服热线：400-660-2278　　销售热线：0511-84423116　84420569</div>
    </div>
	<div class="i_banner_big"><a href="http://product.21-sun.com/proDetail/HTH3400B-11.shtm" target="_blank"><img src="/images/new_bigbanner2.jpg" width="978" height="345" border="0"  alt="HTH3400B滑模式水泥摊铺机" /></a>
        <a href="javascript:;" onclick="showinquery('15773','')" class="showinquery" ></a>
	</div>
    <div class="clear"></div>
  </div>
</div>
<div class="shopPart02">
  <div class="contain980">
    <ul class="shopPros style01">
		<%
			if(null!=recommondProductsList && recommondProductsList.size()>0){
				Map oneMap = null ;
				for(int i=0;i<=1;i++){
					oneMap = (HashMap)recommondProductsList.get(i);
					%>
				<li> <a href="<%="/proDetail/"+CommonString.getFormatPara(oneMap.get("file_name")) %>" target="_blank"><img src="<%="/uploadfiles/"+CommonString.getFormatPara(oneMap.get("zoomlion_hot_pic")) %>" width="465" height="365" /></a><span class="price">热销机型</span>
		        <div class="title"> <a href="<%="/proDetail/"+CommonString.getFormatPara(oneMap.get("file_name")) %>" target="_blank">
		          <h3><%=CommonString.getFormatPara(oneMap.get("factoryname"))+CommonString.getFormatPara(oneMap.get("name")) +CommonString.getFormatPara(oneMap.get("catalogname"))%></h3>
		          </a> <a href="javascript:;" onclick="showinquery('<%=CommonString.getFormatPara(oneMap.get("id")) %>','')" class="buyBtn">立即预定</a> </div>
		      </li>
					<%
				}
			}
		%>
    </ul>
    <div class="shadow01"></div>
    <ul class="shopPros style02">
     		<%
			if(null!=recommondProductsList && recommondProductsList.size()>0){
				Map oneMap = null ;
				for(int i=2;i<=3;i++){
					oneMap = (HashMap)recommondProductsList.get(i);
					%>
				<li> <a href="<%="/proDetail/"+CommonString.getFormatPara(oneMap.get("file_name")) %>" target="_blank"><img src="<%="/uploadfiles/"+CommonString.getFormatPara(oneMap.get("zoomlion_hot_pic")) %>" width="465" height="365" /></a><span class="price">热销机型</span>
		        <div class="title"> <a href="<%="/proDetail/"+CommonString.getFormatPara(oneMap.get("file_name")) %>" target="_blank">
		          <h3><%=CommonString.getFormatPara(oneMap.get("factoryname"))+CommonString.getFormatPara(oneMap.get("name")) +CommonString.getFormatPara(oneMap.get("catalogname"))%></h3>
		          </a> <a href="javascript:;" onclick="showinquery('<%=CommonString.getFormatPara(oneMap.get("id")) %>','')" class="buyBtn">立即预定</a> </div>
		      </li>
					<%
				}
			}
		%>
    </ul>
    <div class="shadow02"></div>
    <ul class="shopPros style03">
     		<%
		if(null!=recommondProductsList && recommondProductsList.size()>0){
			Map oneMap = null ;
			for(int i=4;i<=5;i++){
				oneMap = (HashMap)recommondProductsList.get(i);
				%>
			<li> <a href="<%="/proDetail/"+CommonString.getFormatPara(oneMap.get("file_name")) %>" target="_blank"><img src="<%="/uploadfiles/"+CommonString.getFormatPara(oneMap.get("zoomlion_hot_pic")) %>" width="465" height="365" /></a><span class="price">热销机型</span>
	        <div class="title"> <a href="<%="/proDetail/"+CommonString.getFormatPara(oneMap.get("file_name")) %>" target="_blank">
	          <h3><%=CommonString.getFormatPara(oneMap.get("factoryname"))+CommonString.getFormatPara(oneMap.get("name")) +CommonString.getFormatPara(oneMap.get("catalogname"))%></h3>
	          </a> <a href="javascript:;" onclick="showinquery('<%=CommonString.getFormatPara(oneMap.get("id")) %>','')" class="buyBtn">立即预定</a> </div>
	      </li>
				<%
			}
		}
	%>
    </ul>
    <div class="shadow01"></div>
  </div>
</div>
<div class="shopPart03">
  <div class="contain980">
    <div class="shopContain" id="101">
      <div class="title">
        <h3><strong>华通动力摊铺机械</strong><span class="en"><em>HUATONG  Products list</em><br />
          Paver Series</span></h3>
        <span class="more"><a href="list.jsp?num=101" target="_blank">更多&gt;</a></span> </div> 
      <div class="bigRec">
      <div class="i_banner">
      <a href="/proDetail/SPS90.shtm" target="_blank"><img src="/images/new_shop_huatong01.jpg" width="940" height="380" border="0"  alt="SPS90全液压多功能摊铺机"/></a>
      <a href="javascript:;" onclick="showinquery('10841','')" class="showinquery" style="left:450px; top:70px;"></a>
      </div>    
      <span class="price">热销机型</span></div>
      <ul class="shopPros01">  
     <%
    	 productsList = dbHelper.getMapList(sel_sql,new Object[]{"101"}) ;
     	 if(null!=productsList && productsList.size()>0){
     		 for(Map oneMap:productsList){
     			 %>
     	 <li>
          <div class="img"><a href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")) %>" target="_blank"><img src="/uploadfiles/<%=CommonString.getFormatPara(oneMap.get("img2")) %>" onerror="showImgDelay(this,'/uploadfiles/no_small.gif',2);" width="225" height="212" /></a></div>
          <h3><a href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")) %>" target="_blank"><%=CommonString.getFormatPara(oneMap.get("factoryname"))+CommonString.getFormatPara(oneMap.get("name"))+CommonString.getFormatPara(oneMap.get("catalogname")) %></a></h3>
          <span class="links"><a href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")) %>" target="_blank">参数</a> | <a href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")).replace(".shtm","_message.shtm") %>" target="_blank">评论</a></span>
          <a href="javascript:;" onclick='showinquery(<%=CommonString.getFormatPara(oneMap.get("id")) %>,1220)' class="priceBtn">立即询价</a>
         </li>
     			 <%
     		 }
     	 }
     %>  
      </ul>
    </div>
    <div class="shopContain" id="102">
      <div class="title">
        <h3><strong>华通动力养护机械</strong><span class="en"><em>HUATONG  Products list</em><br />
          Maintaining Project Series</span></h3>
        <span class="more"><a href="list.jsp?num=102" target="_blank">更多&gt;</a></span> </div>
      <div class="bigRec">
        <div class="i_banner">
        <a href="http://product.21-sun.com/proDetail/HM2100A.shtm" target="_blank"><img src="/images/new_shop_huatong02.jpg" width="940" height="380" border="0"  alt="HM2100A铣刨机" /></a>
        <a href="javascript:;" onclick="showinquery('10970','')" class="showinquery" style="left:395px; top:196px; width:100px; height:100px;"></a>
        </div>
      <span class="price">热销机型</span></div>
      <ul class="shopPros01">     
     <%
    	 productsList = dbHelper.getMapList(sel_sql,new Object[]{"102"}) ;
     	 if(null!=productsList && productsList.size()>0){
     		 for(Map oneMap:productsList){
     			 %>
     	 <li>
          <div class="img"><a href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")) %>" target="_blank"><img src="/uploadfiles/<%=CommonString.getFormatPara(oneMap.get("img2")) %>" onerror="showImgDelay(this,'/uploadfiles/no_small.gif',2);" width="225" height="212" /></a></div>
          <h3><a href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")) %>" target="_blank"><%=CommonString.getFormatPara(oneMap.get("factoryname"))+CommonString.getFormatPara(oneMap.get("name"))+CommonString.getFormatPara(oneMap.get("catalogname")) %></a></h3>
          <span class="links"><a href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")) %>" target="_blank">参数</a> | <a href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")).replace(".shtm","_message.shtm") %>" target="_blank">评论</a></span>
          <a href="javascript:;" onclick='showinquery(<%=CommonString.getFormatPara(oneMap.get("id")) %>,1220)' class="priceBtn">立即询价</a>
         </li>
     			 <%
     		 }
     	 }
     %>
      </ul>
    </div>
    <div class="shopContain" id="103">
      <div class="title">
        <h3><strong>华通动力沥青搅拌设备</strong><span class="en"><em>HUATONG  Products list</em><br />
          Asphalt Mixing Series</span></h3>
        <span class="more"><a href="list.jsp?num=103" target="_blank">更多&gt;</a></span> </div>
      <div class="bigRec">
        <div class="i_banner">
          <a href="/proDetail/ABH5000.shtm" target="_blank"><img src="/images/new_shop_huatong03.jpg" width="940" height="380" border="0" alt="ABH5000沥青搅拌站" /></a>
          <a href="javascript:;" onclick="showinquery('10917','')" class="showinquery"></a>
        </div>
      <span class="price">热销机型</span></div>
      <ul class="shopPros01">
    <%
    	 productsList = dbHelper.getMapList(sel_sql+" order by order_no_all desc ",new Object[]{"103"}) ;
     	 if(null!=productsList && productsList.size()>0){
     		 for(Map oneMap:productsList){
     		%>
     	 <li>
          <div class="img"><a href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")) %>" target="_blank"><img src="/uploadfiles/<%=CommonString.getFormatPara(oneMap.get("img2")) %>" onerror="showImgDelay(this,'/uploadfiles/no_small.gif',2);" width="225" height="212" /></a></div>
          <h3><a href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")) %>" target="_blank"><%=CommonString.getFormatPara(oneMap.get("factoryname"))+CommonString.getFormatPara(oneMap.get("name"))+CommonString.getFormatPara(oneMap.get("catalogname")) %></a></h3>
          <span class="links"><a href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")) %>" target="_blank">参数</a> | <a href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")).replace(".shtm","_message.shtm") %>" target="_blank">评论</a></span>
          <a href="javascript:;" onclick='showinquery(<%=CommonString.getFormatPara(oneMap.get("id")) %>,1220)' class="priceBtn">立即询价</a>
         </li>
     			 <%
     		 }
     	 }
     %>   
      </ul>
    </div>
    <div class="shopContain" id="104">
      <div class="title">
        <h3><strong>华通动力铲运机械</strong><span class="en"><em>HUATONG  Products list</em><br />
          Scrapers Mechanical</span></h3>
        <span class="more"><a href="list.jsp?num=104" target="_blank">更多&gt;</a></span> </div>
      <div class="bigRec">
      <div class="i_banner">
      <a href="/proDetail/PY185-72.shtm" target="_blank"><img src="/images/new_shop_huatong04.jpg" width="940" height="380" border="0" usemap="#Map5" alt="PY185平地机" /></a>
      <a href="javascript:;" onclick="showinquery('15780','')" class="showinquery" style="left:399px; top:82px; width:118px; height:118px;"></a>
      </div>
      <span class="price">热销机型</span></div>
      <ul class="shopPros01">
    <%
    	 productsList = dbHelper.getMapList(sel_sql,new Object[]{"104"}) ;
     	 if(null!=productsList && productsList.size()>0){
     		 for(Map oneMap:productsList){
     			 %>
     	 <li>
          <div class="img"><a href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")) %>" target="_blank"><img src="/uploadfiles/<%=CommonString.getFormatPara(oneMap.get("img2")) %>" onerror="showImgDelay(this,'/uploadfiles/no_small.gif',2);" width="225" height="212" /></a></div>
          <h3><a href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")) %>" target="_blank"><%=CommonString.getFormatPara(oneMap.get("factoryname"))+CommonString.getFormatPara(oneMap.get("name"))+CommonString.getFormatPara(oneMap.get("catalogname")) %></a></h3>
          <span class="links"><a href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")) %>" target="_blank">参数</a> | <a href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")).replace(".shtm","_message.shtm") %>" target="_blank">评论</a></span>
          <a href="javascript:;" onclick='showinquery(<%=CommonString.getFormatPara(oneMap.get("id")) %>,1220)' class="priceBtn">立即询价</a>
         </li>
     			 <%
     		 }
     	 }
     %>        
      </ul>
    </div>
    <div class="shopContain" id="105"> <a name='105'></a>
      <div class="title">
        <h3><strong>华通动力稳定土厂拌设备</strong><span class="en"><em>HUATONG  Products list</em><br />
          Stablized Soil Mixing Series</span></h3>
        <span class="more"><a href="list.jsp?num=105" target="_blank">更多&gt;</a></span> </div>
      <div class="clear"></div>  
      <div class="bigRec">
        <div class="i_banner"><a href="/proDetail/WBS700E.shtm" target="_blank"><img src="/images/new_shop_huatong05.jpg" width="940" height="380" border="0" usemap="#Map7"   alt="WBS700E稳定土厂拌设备"/></a>
        <a href="javascript:;" onclick="showinquery('15777','')" class="showinquery" style="left:216px; top:78px;"></a>
        </div>
      <span class="price">热销机型</span></div>
      <ul class="shopPros01">
    <%
    	 productsList = dbHelper.getMapList(sel_sql+" order by order_no_all desc ",new Object[]{"105"}) ;
     	 if(null!=productsList && productsList.size()>0){
     		 for(Map oneMap:productsList){
     			 %>
     	 <li>
          <div class="img"><a href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")) %>" target="_blank"><img src="/uploadfiles/<%=CommonString.getFormatPara(oneMap.get("img2")) %>" onerror="showImgDelay(this,'/uploadfiles/no_small.gif',2);" width="225" height="212" /></a></div>
          <h3><a href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")) %>" target="_blank"><%=CommonString.getFormatPara(oneMap.get("factoryname"))+CommonString.getFormatPara(oneMap.get("name"))+CommonString.getFormatPara(oneMap.get("catalogname")) %></a></h3>
          <span class="links"><a href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")) %>" target="_blank">参数</a> | <a href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")).replace(".shtm","_message.shtm") %>" target="_blank">评论</a></span>
          <a href="javascript:;" onclick='showinquery(<%=CommonString.getFormatPara(oneMap.get("id")) %>,1220)' class="priceBtn">立即询价</a>
         </li>
     			 <%
     		 }
     	 }
     %>    
      </ul>
    </div>
    
       <div class="shopContain" id="106"> <a name='106'></a>
      <div class="title">
        <h3><strong>华通动力再生设备</strong><span class="en"><em>HUATONG  Products list</em><br />
          Reproducing Equipment</span></h3>
        <span class="more"><a href="list.jsp?num=106" target="_blank">更多&gt;</a></span> </div>
      <div class="bigRec">
        <div class="i_banner">
        <a href="/proDetail/ARC300E.shtm" target="_blank"><img src="/images/new_shop_huatong06.jpg" width="940" height="380" border="0" usemap="#Map6"   alt="ARC300E冷再生设备"/></a>
        <a href="javascript:;" onclick="showinquery('10995','')" class="showinquery" style="left:380px; top:51px;"></a>
        </div>
      <span class="price">热销机型</span></div>
      <ul class="shopPros01">
   <%
    	 productsList = dbHelper.getMapList(sel_sql,new Object[]{"106"}) ;
     	 if(null!=productsList && productsList.size()>0){ 
     		 for(Map oneMap:productsList){ 
     			 %>
     	 <li>
          <div class="img"><a href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")) %>" target="_blank"><img src="/uploadfiles/<%=CommonString.getFormatPara(oneMap.get("img2")) %>" onerror="showImgDelay(this,'/uploadfiles/no_small.gif',2);" width="225" height="212" /></a></div>
          <h3><a href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")) %>" target="_blank"><%=CommonString.getFormatPara(oneMap.get("factoryname"))+ CommonString.getFormatPara(oneMap.get("name"))+CommonString.getFormatPara(oneMap.get("catalogname")) %></a></h3>
          <span class="links"><a href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")) %>" target="_blank">参数</a> | <a href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")).replace(".shtm","_message.shtm") %>" target="_blank">评论</a></span>
          <a href="javascript:;" onclick='showinquery(<%=CommonString.getFormatPara(oneMap.get("id")) %>,1220)' class="priceBtn">立即询价</a>
         </li>
     			 <%
     		 }
     	 }
     %>    
      </ul>
    </div>
    <div class="clear"></div>
  </div>
</div>
<!--main end--> 
<!--foot-->
<div class="flagshopbg">
<jsp:include page="/include/foot.jsp" flush="true"></jsp:include>
</div>
<!--end of foot--> 
<script type="text/javascript">
jQuery(function(){
	jQuery(".shopPros01 li").hover(function(){
		jQuery(this).toggleClass("hover");
	},function(){
		jQuery(this).removeClass("hover");
	});
})
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
<script type="text/javascript" language="javascript">
//营销宝统计
jQuery(function(){
  jQuery.ajax({
    	type:'post',
    	url:'/action/ajax.jsp',
    	data:{flag:'getAgentViewCount',agentId:'1220'} ,
    	success:function(msg){
    	}
    }) ;
});
</script> 
<script type="text/javascript">
function addShop(){　 // 收藏我们
    try{
       window.external.addFavorite('http://product.21-sun.com', '江苏华通动力重工官方旗舰店');
   }catch (e){
       try{
           window.sidebar.addPanel('江苏华通动力重工官方旗舰店','http://product.21-sun.com',"");
       }catch (e){
           alert("加入收藏失败，请使用Ctrl+D进行添加");
       }
   }
}
jQuery("body").bind("contextmenu", function() {
  return false;
});
</script> 
<script type="text/javascript" src="/scripts/scrolltopcontrol.js"></script> 
<script type="text/javascript" src="/scripts/sort.js"></script>
</body>
</html>