<%@ page language="java" import="java.util.*,com.jerehnet.util.dbutil.*,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*" pageEncoding="UTF-8"%><%@ taglib tagdir="/WEB-INF/tags" prefix="tags"%><%
	DBHelper dbHelper = DBHelper.getInstance() ;	
	List<Map> recommondProductsList = new ArrayList() ;
	String rec_sql = "select top 6 * from pro_agent_product_vi where agentid=15864 and factoryid=139 and id<>'20365' and is_show=1" ; 
	recommondProductsList = dbHelper.getMapList(rec_sql+"order by order_no") ;
%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="author" content="design by www.21-sun.com" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<title>厦门市尧鼎机械有限公司_中国工程机械商贸网</title>
<meta name="keywords" content="厦门尧鼎,厦工挖掘机产品报价厦工挖掘机产品厦工挖掘机产品图片厦工挖掘机产品介绍厦工挖掘机介绍" />
<meta name="description" content="中国工程机械商贸网为您提供厦门市尧鼎机械有限公司介绍厦工挖掘机产品介绍厦工挖掘机产品报价厦工挖掘机产品图片厦工挖掘机产品展示等厦工挖掘机产品信息，帮助您全面了解厦工挖掘机。" />
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
<div class="shopBanner">
 
  <div class="ban_c"><img src="images/banner_02.jpg" width="1862" height="590" /></div>
</div>
<div class="top_title mt35">
  <h2>厦工挖掘机</h2>
  <span><a href="list.jsp">更多>></a></span></div>
<div class="shopWrap pb10 recPro fix">
  <div class="l p1"><a href="/proDetail/XG825EL.shtm" title="厦工XG825EL挖掘机" target="_blank"><img src="images/5_03.jpg" width="254" height="500" /></a></div>
  <div class="r p2">
    <ul>
    <%
    if(recommondProductsList!=null && recommondProductsList.size()>0){
    	for(Map m:recommondProductsList){
    		String id = CommonString.getFormatPara(m.get("id"));
    		String file_name = CommonString.getFormatPara(m.get("file_name"));
    		String name = CommonString.getFormatPara(m.get("name"));
    		String catalogname = CommonString.getFormatPara(m.get("catalogname"));
    		String factoryname = CommonString.getFormatPara(m.get("factoryname"));
    		String img2 = CommonString.getFormatPara(m.get("img2"));
    		String factoryid = CommonString.getFormatPara(m.get("factoryid"));
    %>
      <li><a href="/proDetail/<%=file_name %>" title="<%=factoryname+name+catalogname %>" target="_blank"><img src="/uploadfiles<%=img2 %>" width="222" height="157" onerror="showImgDelay(this,'/uploadfiles/no_small.gif',2);" alt="<%=factoryname+name+catalogname %>"><strong><%=factoryname+name+catalogname %></strong></a><a href="javascript:void(0);" onclick="showinquery('<%=id %>','')"><img src="images/1_10.png" /></a></li>
    <%}} %>
    </ul>
  </div>
</div>
<div class="top_title">
  <h2>公司介绍</h2>
</div>
<div class="shopWrap about_intro" id="about">
  <div class="fix"> <span class="l"><img src="images/1_14.jpg"  width="194" height="197"/></span>
    <p class="text">&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;厦门市尧鼎工程机械有限公司成立于2010年4月，专业代理厦工品牌工程机械产品，是厦门厦工机械股份有限公司挖掘机福建区域代理商。公司总部位于厦工股份有限公司的生产发源地——厦门市，设有综合管理部、市场企划部、财务部、债权管理部、整机销售部、售后服务部、配件部等部门，在部分代理区域内设有二级经销商，并且在漳州、泉州、三明、南平等区域设有办事处，自公司成立以来，以良好的企业形象及信誉赢得了广大用户的支持和信赖。<br>
      <br>
      &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;公司的前身致力于大型工程承包作业20余年，拥有四十余台厦工品牌的挖掘机及其它大型工程机械产品，公司以整机销售、配件供应、三包服务、市场信息为一体的销售模式，及时到位的为广大用户服务。公司注重于内部人员培训，树立公司价值观，逐步形成以销售、培训、售中及售后服务相互联动与公司发展和服务同步的企业经营方向。<br>
      <br>
      &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;随着福建地区公路建设、矿山开采、水利设施及城市基础建设的加强，工程机械的发展拥有更广阔的空间，通过业务人员的不懈努力与宣传，公司销售业绩也在不断的攀升。</p>
  </div>
</div>
<div class="top_title">
  <h2>联系方式</h2>
</div>
<div class="shopWrap contact" id="contact">
  <p> <b>厦门本部</b><br>
    <span>人事部：0592-5133355转803</span><span>销售部：0592-5133355转807</span><span>售后服务部：0592-6091133</span><br>
    <span>节假日联系方式：18750257621</span><br>
    <span>公司微博：<a href="http://weibo.com/yaodinggcjx" target="_blank">http://weibo.com/yaodinggcjx</a></span><br>
    <span>QQ: 2362572016</span><br>
    <b>厦门尧鼎工程机械有限公司竭诚为您服务，欢迎垂询！</b> </p>
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
    	data:{flag:'getAgentViewCount',agentId:'15864'} ,
    	success:function(msg){
    	}
    }) ;
});
</script> 
<script type="text/javascript">
function addShop(){ // 收藏店铺
    var url = window.location.href;
    try{
       window.external.addFavorite(url, '厦门市尧鼎机械有限公司');
   }catch (e){
       try{
           window.sidebar.addPanel('厦门市尧鼎机械有限公司',url,"");
       }catch (e){
           alert("加入收藏失败，请使用Ctrl+D进行添加");
       }
   }
}
</script> 
<script type="text/javascript" src="/scripts/scrolltopcontrol.js"></script>
</body>
</html>