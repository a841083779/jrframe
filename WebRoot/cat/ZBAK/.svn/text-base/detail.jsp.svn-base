<%@ page language="java" import="com.jerehnet.util.common.*,com.jerehnet.util.dbutil.PageBean,com.jerehnet.util.dbutil.DBHelper,com.jerehnet.util.common.CommonString,java.util.*" pageEncoding="UTF-8"%>
<% 
	String proId = CommonString.getFormatPara(request.getParameter("id"));
	DBHelper dbHelper = DBHelper.getInstance() ;
	Map proMap = null;
	String id = "";
	String file_name = "";
	String img2 = "";
	String factoryname = "";
	String name = "";
	String catalogname = "";
	String factoryid_sub = "";
	String introduce = "";
	if(proId!=null && !proId.equals("")){
		proMap = dbHelper.getMap(" select factoryname,name,catalogname,img2,id,factoryid_sub,file_name,introduce from pro_products where is_show=1 and id=?",new Object[]{proId}) ;
		if(proMap == null){
			response.setStatus(301);
			response.setHeader("Location", "/cat/"); 
			return;	
		}else{
			id = CommonString.getFormatPara(proMap.get("id"));
			file_name = CommonString.getFormatPara(proMap.get("file_name"));
			img2 = CommonString.getFormatPara(proMap.get("img2"));
			factoryname = CommonString.getFormatPara(proMap.get("factoryname"));
			name = CommonString.getFormatPara(proMap.get("name"));
			catalogname = CommonString.getFormatPara(proMap.get("catalogname"));
			factoryid_sub = CommonString.getFormatPara(proMap.get("factoryid_sub"));
			introduce = CommonString.getFormatPara(proMap.get("introduce"));
			
		}
	}else{
		response.setStatus(HttpServletResponse.SC_NOT_FOUND);
		Common.doForward(request,response,"/404.htm");
	}
%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="author" content="design by www.21-sun.com" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<title>卡特彼勒挖掘机电商平台</title>
<link href="style/style.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="style/jquery.jqzoom.css" type="text/css">
<script type="text/javascript" src="scripts/jquery.min.js"></script>
<script type="text/javascript" src="scripts/jquery.SuperSlide.js"></script>
<script src="scripts/jquery.jqzoom-core.js" type="text/javascript"></script>

<!--[if (IE 6)]>
<script src="scripts/iepng.js" type="text/javascript"></script>
<script type="text/javascript">
   EvPNG.fix('.png'); 
</script>
<![endif]-->
</head>
<body>

<!--top--begin-->
<jsp:include page="include/top.jsp" flush="true"></jsp:include>
<jsp:include page="include/nav.jsp" flush="true"></jsp:include>
<!--top--end-->

<div class="wrap_list">
  <div class="list_banner">
    <div class="word">
      <h3>Cat®(卡特)小型挖掘主要亮点</h3>
      <p>卓越的性能，将生产效率最大化<br />
        先进的液压系统<br />
        安全舒适的驾驶室，长期操作也不易疲劳<br />
        液压系统可加装多种工装<br />
        强大的代理商网络提供世界级的售后服务和备件支持<br />
        Cat®(卡特) 车辆管理系统提供远程设备状况监控</p>
    </div>
  </div>
  <div class="list_con clearfix">
    <div class="list_left l">
      <ul class="up">
        <li class="cur">cat®小型挖掘机</li>
        <li>cat®中型挖掘机</li>
        <li>cat®大型挖掘机</li>
      </ul>
      <!--  
      <div class="down"> <a href="#">我要购机</a> <a href="#">我要询价</a> <a href="#">下载产品手册</a> <strong>查找经销商</strong>
        <select name="select" id="select">
          <option>请选择</option>
        </select>
        <select name="select" id="select">
          <option>请选择</option>
        </select>
        <input type="button" />
      </div>
      -->
    </div>
    <div class="pro_right">
      <div class="right_top clearfix">
      <div class=" share clearfix">
        <h2><%=factoryname %><%=name %><%=catalogname %></h2>
      <!-- JiaThis Button BEGIN -->
<div class="jiathis_style">
	<a class="jiathis_button_renren"></a>
	<a class="jiathis_button_tsina"></a>
	<a class="jiathis_button_douban"></a>
	<a class="jiathis_button_tqq"></a>
	<a class="jiathis_button_kaixin001"></a>

</div>
<script type="text/javascript" src="http://v3.jiathis.com/code/jia.js?uid=undefined" charset="utf-8"></script>
<!-- JiaThis Button END -->
        </div>
        <div class="picBtnLeft l">
        <a href="images/triumph_big1.jpg" class="jqzoom" rel='gal1'  title="triumph" >
<img src="images/triumph_big1.jpg" width="365" height="246"  style="border: 1px solid #dfdfdf;" title="triumph"></a>

<br>

<div class="clearfix" style="clear:both;">
	<ul id="thumblist" class="clearfix" >
		<li><a class="zoomThumbActive" href='javascript:void(0);' rel="{gallery: 'gal1', smallimage: 'images/triumph_big1.jpg',largeimage: 'images/triumph_big1.jpg'}"><img src='images/triumph_big1.jpg' width="59" height="59"></a></li>
		<li><a href='javascript:void(0);' rel="{gallery: 'gal1', smallimage: 'images/triumph_big2.jpg',largeimage: 'images/triumph_big2.jpg'}"><img src='images/triumph_big2.jpg' width="59" height="59"></a></li>
		<li><a  href='javascript:void(0);' rel="{gallery: 'gal1', smallimage: 'images/triumph_big3.jpg',largeimage: 'images/triumph_big3.jpg'}"><img src='images/triumph_big3.jpg' width="59" height="59"></a></li>
        <li><a  href='javascript:void(0);' rel="{gallery: 'gal1', smallimage: 'images/triumph_big3.jpg',largeimage: 'images/triumph_big3.jpg'}"><img src='images/triumph_big3.jpg' width="59" height="59"></a></li>
        <li><a  href='javascript:void(0);' rel="{gallery: 'gal1', smallimage: 'images/triumph_big3.jpg',largeimage: 'images/triumph_big3.jpg'}"><img src='images/triumph_big3.jpg' width="59" height="59"></a></li>
	</ul>
	</div>
       
        </div>
        <div class="info">
          <p>挖机型号: 313D2<br />
            铲斗容量: 0.65m3<br />
            净功率: 67kw<br />
            工作重量: 13400kg<br />
            所属类别: 小型挖掘机<br />
            机器好处: <br />
            宽敞驾驶室，高效工作不疲倦<br />
            最优性能发动机，省心更省油<br />
            操作省力和控制精确的液压系统<br />
            全新结构设计，打造非凡的卓绝品质<br />
            维护更便捷，工作更加事半功倍</p>
          <div class="link"> <a class="a1" href="#" target="_blank">下载产品手册</a> <a class="a2" href="#" target="_blank">查找代理商</a> <a class="a3" href="#" target="_blank">我要询价</a> </div>
        </div>
      </div>
      
      <div class="right_mid">
      	<h3 class="tit">参数配置</h3>
        <ul class="clearfix">
        	<li>
            <a href="#">
            	<div class="img"><img src="images/pro_img1.jpg"/></div>
                <div class="info">
                	<h3>宽城驾驶室，高效工作不疲惫</h3>
                    <p>更快更强的液压系统提供业界最佳的生产效率全寿命成本低，实现产品的最优化更强的结构带来更加卓越的功能性、稳定性和耐久性</p>
                </div></a>
            </li>
            <li>
            <a href="#">
            	<div class="img"><img src="images/pro_img1.jpg"/></div>
                <div class="info">
                	<h3>宽城驾驶室，高效工作不疲惫</h3>
                    <p>更快更强的液压系统提供业界最佳的生产效率全寿命成本低，实现产品的最优化更强的结构带来更加卓越的功能性、稳定性和耐久性</p>
                </div></a>
            </li>
            <li>
            <a href="#">
            	<div class="img"><img src="images/pro_img1.jpg"/></div>
                <div class="info">
                	<h3>宽城驾驶室，高效工作不疲惫</h3>
                    <p>更快更强的液压系统提供业界最佳的生产效率全寿命成本低，实现产品的最优化更强的结构带来更加卓越的功能性、稳定性和耐久性</p>
                </div></a>
            </li>
            <li>
            <a href="#">
            	<div class="img"><img src="images/pro_img1.jpg"/></div>
                <div class="info">
                	<h3>宽城驾驶室，高效工作不疲惫</h3>
                    <p>更快更强的液压系统提供业界最佳的生产效率全寿命成本低，实现产品的最优化更强的结构带来更加卓越的功能性、稳定性和耐久性</p>
                </div></a>
            </li>
             <li>
            <a href="#">
            	<div class="img"><img src="images/pro_img1.jpg"/></div>
                <div class="info">
                	<h3>宽城驾驶室，高效工作不疲惫</h3>
                    <p>更快更强的液压系统提供业界最佳的生产效率全寿命成本低，实现产品的最优化更强的结构带来更加卓越的功能性、稳定性和耐久性</p>
                </div></a>
            </li>
             <li>
            <a href="#">
            	<div class="img"><img src="images/pro_img1.jpg"/></div>
                <div class="info">
                	<h3>宽城驾驶室，高效工作不疲惫</h3>
                    <p>更快更强的液压系统提供业界最佳的生产效率全寿命成本低，实现产品的最优化更强的结构带来更加卓越的功能性、稳定性和耐久性</p>
                </div></a>
            </li>

        </ul>
      </div>
      <div class="right_down clearfix">
      	<h3 class="tit">相关工装机具</h3>
        <ul class="list">
        	<li class="ll">
            <a href="#">
            	<img src="images/pro_img2.jpg"/>
                <h3>挖斗</h3>
                <ul class="txt">
                	<li>高能量输入输出比带来更大打击力，放空打功能及静音设计</li>
                    <li>高能量输入输出比带来更大打击力，放空打功能及静音设计</li>
                    <li>高能量输入输出比带来更大打击力，放空打功能及静音设计</li>
                </ul></a>
            </li>
           <li class="ll">
            <a href="#">
            	<img src="images/pro_img3.jpg"/>
                <h3>挖斗</h3>
                <ul class="txt">
                	<li>高能量输入输出比带来更大打击力，放空打功能及静音设计</li>
                    <li>高能量输入输出比带来更大打击力，放空打功能及静音设计</li>
                    <li>高能量输入输出比带来更大打击力，放空打功能及静音设计</li>
                </ul></a>
            </li>
            <li class="ll last">
            <a href="#">
            	<img src="images/pro_img4.jpg"/>
                <h3>挖斗</h3>
                <ul class="txt">
                	<li>高能量输入输出比带来更大打击力，放空打功能及静音设计</li>
                    <li>高能量输入输出比带来更大打击力，放空打功能及静音设计</li>
                    <li>高能量输入输出比带来更大打击力，放空打功能及静音设计</li>
                </ul></a>
            </li>
        </ul>
      </div>
    </div>
  </div>
  
  <!--foot--begin-->
  <jsp:include page="include/foot.jsp" flush="true"></jsp:include>
  <!--foot--end--> 
  
</div>
<script type="text/javascript" src="scripts/comm.js"></script> 
<script type="text/javascript">
function nTabs(thisObj, Num) {
	if (thisObj.className == "active") return;
	var tabObj = thisObj.parentNode.id;
	var tabList = document.getElementById(tabObj).getElementsByTagName("li");
	for (i = 0; i < tabList.length; i++) {
		if (i == Num) {
			thisObj.className = "active";
			document.getElementById(tabObj + "_Content" + i).style.display = "block";
		} else {
			tabList[i].className = "normal";
			document.getElementById(tabObj + "_Content" + i).style.display = "none";
		}
	}
}
$(document).ready(function(e) {
    $('.TabTitle li').click(function(){
		$('html,body').stop(1,0).animate({scrollTop:$('.TabTitle').offset().top},500);
	})
});
</script>
<script type="text/javascript">
$(document).ready(function() {
	$('.jqzoom').jqzoom({
            zoomType: 'reverse',
            lens:true,
            preloadImages: false,
            alwaysOn:false
        });
	//$('.jqzoom').jqzoom();
});
</script>
</body>
</html>