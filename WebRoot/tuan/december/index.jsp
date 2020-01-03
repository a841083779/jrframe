<%@page contentType="text/html;charset=utf-8" import="com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*,java.util.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="author" content="design by www.21-sun.com" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<title>优买团品牌汇聚，2013年终惠_21-sun优买团</title>
<meta name="keywords" content="21-sun优买团,卡特迷你挖掘机,山工装载机,三一挖掘机,卡特挖机,山推专场,配件,破碎锤" />
<meta name="description" content="21-sun优买团，这里让你购机更轻松，这里是众多终端用户上网购机的首选平台，每天有上万的终端用户汇集在这里选机比价" />
<link href="style/style.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="/scripts/jquery.min.js"></script>
<script type="text/javascript" src="scripts/common.js"></script>
<script type="text/javascript" src="scripts/jquery.SuperSlide.js"></script>

<script type="text/javascript" src="/scripts/jquery.form.js"></script>
<script type="text/javascript" src="/scripts/citys.js"></script> 
<script type="text/javascript" src="/scripts/pinyin.js"></script>
<script type="text/javascript" src="/plugin/validator/rjboy/Validform_v5.3.1.js"></script>
<script type="text/javascript" src="/scripts/jquery.cookies.2.2.0.min.js"></script>
<script>
	function nTabs(thisObj,Num){
	if(thisObj.className == "active")return;
	  var tabObj = thisObj.parentNode.id;
	  var tabList = document.getElementById(tabObj).getElementsByTagName("li");
	  for(i=0; i <tabList.length; i++)
	{
	if (i == Num){
      thisObj.className = "active"; 
      document.getElementById(tabObj+"_Content"+i).style.display = "block";
	  }else{
      tabList[i].className = "normal"; 
   	  document.getElementById(tabObj+"_Content"+i).style.display = "none";
	 }
}}

function setUpdated(){
	var tuan = jQuery.cookies.get("tuan_toupiao");
	var shouji = jQuery("#zd_mobile_phone").val();
	if(tuan==null || tuan == "" || shouji!=tuan){  
		expireDate = new Date();
		expireDate.setTime( expireDate.getTime() + ( 60 * 100000 ) );
		jQuery.cookies.set("tuan_toupiao",shouji,{expiresAt:expireDate});
		return true;
	}else if(shouji==tuan){
		alert("同一手机只能投票一次，请勿重复提交！");
		return false;	
	}else{
		return true;
	}
}



function submitYN() {
	var mobile_phone_reg = /^1([\d]{10})$/;
	var connect_reg=/^((0\d{2,3})-)(\d{7,8})(-(\d{3,}))?$/;
	var emailreg = /^([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+@([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+\.[a-zA-Z]{2,3}$/;
	if (null == jQuery("#zd_name").val() || jQuery("#zd_name").val().length == 0) {
		jQuery.jBox.tip("请输入您的姓名!");
		setTimeout(function() {
			jQuery("#zd_name").focus();
		},
		0);
		return false;
	}
	if ((null == jQuery("#zd_mobile_phone").val() || jQuery("#zd_mobile_phone").val().length == 0)) {
		jQuery.jBox.tip("请输入您的联系电话！");
		setTimeout(function() {
		 	jQuery("#zd_mobile_phone").focus();
		},
		10);
		return false;
	}
	
	if ((null == jQuery("#zd_pinpai").val() || jQuery("#zd_pinpai").val().length == 0)) {
		jQuery.jBox.tip("请选择您最喜欢的品牌！");
		setTimeout(function() {
		 	jQuery("#zd_pinpai").focus();
		},
		10);
		return false;
	}
	
	
	if (jQuery("#zd_mobile_phone").val().length != 0 && (!mobile_phone_reg.test(jQuery('#zd_mobile_phone').attr("value"))&&!connect_reg.test(jQuery('#zd_mobile_phone').attr("value")))) {
		jQuery.jBox.tip("请输入正确的电话号码，如座机格式：0535-6928888<br/>手机格式18605358888!");
		setTimeout(function() {
			jQuery("#zd_mobile_phone").focus();
			jQuery("#zd_mobile_phone").select(); 
		},
		15);
		return false;
	}
	if(jQuery("#zd_city").val()==''){
		jQuery.jBox.tip("请选择城市") ;
		setTimeout(function() {
		 	jQuery("#zd_city").focus();
		},
		20);
		return false ;
	}
	

	jQuery("#zd_contact_address").val(jQuery("#zd_province").val()+jQuery("#zd_city").val()) ;

	if(setUpdated()){
	alert("投票成功，感谢您的参与！");
	
	
	jQuery.ajax({
		url : "/tuan/december/ajax.jsp",
		async : false ,
		type : 'post',
		cache : false,
		data : {
			flag : 'toupiao',
			province : jQuery('#zd_province').val(),
			city : jQuery("#zd_city").val(),
			user_name : jQuery("#zd_name").val(),
			contact_tel : jQuery("#zd_mobile_phone").val(),
			pinpai : jQuery("#zd_pinpai").val()
			
		}
	});

	}else{
	
	//alert("每人可投一票，请勿重复提交！");
	}


}

jQuery.getScript("http://int.dpool.sina.com.cn/iplookup/iplookup.php?format=js",function(){
	var province = remote_ip_info["province"];
	var city = remote_ip_info["city"];
	jQuery("#zd_province option:contains("+province+")").attr("selected",true);
	set_city(document.getElementById("zd_province"),document.getElementById("zd_province").value,document.theform.zd_city,'');
	document.getElementById("zd_city").value = city;  
}) ;
</script>
<!--[if (IE 6)]>
<link href="style/pngfix.css" media="screen" rel="stylesheet" type="text/css" />
<![endif]-->
</head>

<body class="tuan">

<form method="post" name="theform" id="theform">
<div>
  <jsp:include page="include/top.jsp" flush="true"></jsp:include>
  <div class="con clearfix">
    <div class="home_left mb30">
      <div id="slideBox" class="slideBox">
        <div class="hd">
          <ul>
            <li></li>
            <li></li>
            <li></li>
            <li></li>
          </ul>
        </div>
        <div class="bd">
          <ul>
            <li><a href="http://product.21-sun.com/tuan/november/" target="_blank" ><img src="images/home_img1.jpg" />
              <h2>十一月优买团——我们的故事</h2>
              <p>每天有上万的终端用户汇集在这里选机比价，最终这里汇集了他们和我们的故事</p>
              <b>查看更多&gt;&gt;</b></a> 
            </li>
            <li><a href="http://product.21-sun.com/tuan/october/" target="_blank" ><img src="images/home_img2.jpg" />
              <h2>十月优买团，待我长发及腰，拖我回家可好</h2>
              <p>我在这里优惠，我在这里等你，心已动，请你在挖机还未远走前，到达这里，我们一起畅游北京展，品牌云集，总有你那款</p>
              <b>查看更多&gt;&gt;</b></a> 
            </li>
            <li><a href="http://product.21-sun.com/tuan/september/" target="_blank" ><img src="images/home_img3.jpg" />
              <h2>九月品牌英雄汇全民盛宴</h2>
              <p>六雄争霸，英雄汇集，全民盛宴，钜惠金秋，让您热爱着我的热爱</p>
              <b>查看更多&gt;&gt;</b></a> 
            </li>
              <li><a href="http://product.21-sun.com/tuan/august/index.htm" target="_blank" ><img src="images/home_img4.jpg" />
              <h2>八月优买团，梦想新航线，未来合伙人</h2>
              <p>有梦就要去追，敢想就要敢干，“梦想新航线，未来合伙人”，邀您“入伙”让您的工程机械梦想在阳光下恣意绽放</p>
              <b>查看更多&gt;&gt;</b></a> 
            </li>
          </ul>
        </div>
      </div>
    </div>
	
	 
    <div class="home_right mb30"> <img src="images/home_gift.jpg" />
      <div class="con">
        <div class="text_input"><b>姓　名 ： </b>
          <input class="input" name="zd_name" type="text" id="zd_name" size="30" maxlength="20" />
        </div>
        <div class="selectBox"><b>省　份 ： </b>
          <select name="zd_province" id="zd_province" onChange="set_city(this,this.value,theform.zd_city,'');" class="select" style="width:90px;"  dataType="Require"  msg="请选择省份">
                  <option value="安徽">安徽</option>
                  <option value="北京">北京</option>
                  <option value="重庆">重庆</option>
                  <option value="福建">福建</option>
                  <option value="甘肃">甘肃</option>
                  <option value="广东">广东</option>
                  <option value="广西">广西</option>
                  <option value="贵州">贵州</option>
                  <option value="海南">海南</option>
                  <option value="河北">河北</option>
                  <option value="黑龙江">黑龙江</option>
                  <option value="河南">河南</option>
                  <option value="湖北">湖北</option>
                  <option value="湖南">湖南</option>
                  <option value="内蒙古">内蒙古</option>
                  <option value="江苏">江苏</option>
                  <option value="江西">江西</option>
                  <option value="吉林">吉林</option>
                  <option value="辽宁">辽宁</option>
                  <option value="宁夏">宁夏</option>
                  <option value="青海">青海</option>
                  <option value="山西">山西</option>
                  <option value="山东">山东</option>
                  <option value="上海">上海</option>
                  <option value="四川">四川</option>
                  <option value="天津">天津</option>
                  <option value="西藏">西藏</option>
                  <option value="新疆">新疆</option>
                  <option value="云南">云南</option>
                  <option value="浙江">浙江</option>
                  <option value="陕西">陕西</option>
                  <option value="台湾">台湾</option>
                  <option value="香港">香港</option>
                  <option value="澳门">澳门</option>
                  <option value="海外">海外</option>
              </select>
			  <input type="hidden" name="zd_contact_address" id="zd_contact_address"/>
        </div>
        <div class="selectBox"><b>品　牌 ： </b>
          <select name="zd_pinpai" id="zd_pinpai" >
            <option selected="selected" value="">请选择</option>
            <option value="斗山">斗山</option>
            <option value="三一">三一</option>
            <option value="卡特">卡特</option>
            <option value="山推">山推</option>
            <option value="山工">山工</option>
            <option value="福田">福田</option>
            <option value="徐工">徐工</option>
            <option value="龙工">龙工</option>
            <option value="江麓">江麓</option>
            <option value="现代">现代</option>
            <option value="小松">小松</option>
            <option value="宝鼎">宝鼎</option>
            <option value="烟台军恒">烟台军恒</option>
            <option value="日立">日立</option>
            <option value="泰盛">泰盛</option>
            <option value="第一油压">第一油压</option>
            <option value="康明斯">康明斯</option>
            <option value="洋马">洋马</option>
          </select >
        </div>
      </div>
      <div class="con">
        <div class="text_input"><b>手　机 ： </b>
          <input class="input" name="zd_mobile_phone" type="text" id="zd_mobile_phone" size="30" maxlength="15" />
        </div>
        <div class="selectBox"><b>城　市 ： </b>
         <select  name="zd_city" id="zd_city" class="select" style="width:90px;" dataType="Require"  msg="请选择城市">
                <option value="">选择城市</option>
              </select>
        </div>
      </div>
	  <input type="button" name="Submit" id="button" value="&nbsp;" onclick="alert('本活动已经结束，感谢您的参与！')"  class="sumitBtn" />
    </div>
	

  </div>
</div>
	</form>

<div class="foot">
<jsp:include page="/include/foot.jsp" flush="true"></jsp:include>
</div>
</body>
<!-- jbox -->
<link type="text/css" rel="stylesheet" href="/scripts/jBox-v2.3/Skins2/Blue/jbox.css" />
<script type="text/javascript" src="/scripts/jBox-v2.3/jquery.jBox-2.3.min.js"></script>
<script type="text/javascript" src="/scripts/jBox-v2.3/i18n/jquery.jBox-zh-CN.js"></script>
<script type="text/javascript">


jQuery(".slideBox").slide( { mainCell:".bd ul",effect:'leftLoop',autoPlay:true,interTime:4000} );
function showinquery(pid,factoryid){
	jQuery.jBox("iframe:/include/products/product_order.jsp?productid="+pid+"&factoryid="+factoryid, {
	title: "在线询价",
	width: 720,
	height: 435,
	top: '20%',
	iframeScrolling : 'no',
	buttons: { '关闭': false }
	});
	jQuery(".jbox-button-panel").attr("style","display:none;") ;
}
</script>
</html>