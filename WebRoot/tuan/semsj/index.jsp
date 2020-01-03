<%@page contentType="text/html;charset=utf-8" import="com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*,java.util.*" %>
<%
	// 预计购买时间
	LinkedHashMap buyTimeMap = (LinkedHashMap)CommonApplication.getEnumChildrenLink("102",application) ;
	String productid = "";
	String factoryid = "138" ;
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="author" content="design by www.21-sun.com" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<title>2周时间免费试用山工平地机 - 铁臂商城</title>
<meta name="keywords" content="山工平地机,山工产品介绍,山工产品价格,山工活动详情" />
<meta name="description" content="山工机械支持您对品质的苛刻，给您长达2周时间免费试用山工平地机，在试用后订购更可获得价值5000元的配件！试用机会全国仅限10名，2013年4月15日—5月15日报名参加，还能赢取精美平地机模型。现在就填写以下信息报名，将有专人与您取得联系。 " />
<link href="style/style.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="scripts/jquery.min.js"></script>
<script type="text/javascript" src="/scripts/jquery.form.js"></script>
<script type="text/javascript" src="/scripts/jBox-v2.3/jquery.jBox-2.3.min.js"></script>
<link href="/scripts/jBox-v2.3/Skins2/Blue/jbox.css" rel="stylesheet" type="text/css"></link>
<script type="text/javascript" src="/scripts/citys.js"></script> 
<script type="text/javascript" src="/scripts/pinyin.js"></script>
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
		5);
		return false ;
	}
	
	jQuery("#zd_contact_address").val(jQuery("#zd_province").val()+jQuery("#zd_city").val()) ;
	//为代理商分配订单
	jQuery.ajax({
		url : "/action/ajax.jsp",
		async : false ,
		type : 'post',
		cache : false,
		data : {
			flag : 'product_order_to_agent',
			productId : '<%=productid %>',
			factoryid : '<%=factoryid %>',
			factoryname : '山工',
			province : jQuery('#zd_province').val(),
			city : jQuery("#zd_city").val(),
			contact_tel : jQuery("#zd_mobile_phone").val(),
			ifgroup : jQuery("#zd_ifgroup").val(),
			buy_time : jQuery("#zd_buy_time").val(),
			message : jQuery("#zd_message").val(),
			user_name : jQuery("#zd_name").val(),
			company_name : jQuery("#zd_company").val()
		}
	});
	//插入原厂家表
	jQuery.ajax({
		url : "/tuan/semsj/ajax.jsp",
		async : false ,
		type : 'post',
		cache : false,
		data : {
			flag : 'order_save',
			productId : '<%=productid %>',
			factoryid : '<%=factoryid %>',
			factoryname : '山工',
			province : jQuery('#zd_province').val(),
			city : jQuery("#zd_city").val(),
			contact_tel : jQuery("#zd_mobile_phone").val(),
			ifgroup : jQuery("#zd_ifgroup").val(),
			buy_time : jQuery("#zd_buy_time").val(),
			message : jQuery("#zd_message").val(),
			name : jQuery("#zd_name").val(),
			company_name : jQuery("#zd_company").val()
		}
	});
   document.getElementById('success').style.display='block'
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
<body>
<h1 class="hide">2周时间免费试用山工平地机，订购减5000</h1>
<div class="wrapper top">
  <h2><img src="images/sem_logo.gif" alt="山工机械，开疆拓土，山工同路" width="186" height="80" /></h2>
</div>
<div class="wrapper banner"><img src="images/sem_banner.jpg" alt="2周免费用，订购减5000" width="1000" height="370" /></div>
<div class="wrapper mainbg01">
  <div class="contain"> 
    <!--intro-->
    <div class="intro">
      <p class="text">好机械用过才知道！山工机械支持您对品质的苛刻，给您长达<strong>2周时间免费试用</strong>山工平地机，<br />
        在试用后订购更可获得价值<strong>5000元的配件！</strong><br />
        <strong>试用机会全国仅限10名，</strong>2013年4月15日—5月15日报名参加，还能赢取精美平地机模型。<br />
        现在就填写以下信息报名，将有专人与您取得联系。 </p>
      <img src="images/model.png" width="259" height="202" class="model" /> </div>
    <!--form-->
    <form method="post" name="theform" id="theform">
      <div class="form" id="form">
        <h3>基本信息：</h3>
        <ul class="clearfix">
          <li> <strong class="ft"><font>*</font>您的姓名：</strong>
            <p class="fc">
              <input class="input" name="zd_name" type="text" id="zd_name" size="30" maxlength="20" />
            </p>
          </li>
          <li> <strong class="ft"><font>*</font>联系电话：</strong>
            <p class="fc">
              <input class="input" name="zd_mobile_phone" type="text" id="zd_mobile_phone" size="30" maxlength="15" />
            </p>
          </li>
          <li> <strong class="ft"><font>*</font>购买地区：</strong>
            <p class="fc">
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
              <select  name="zd_city" id="zd_city" class="select" style="width:90px;" dataType="Require"  msg="请选择城市">
                <option value="">选择城市</option>
              </select></p>
          </li>
          <li> <strong class="ft"><font>*</font>预计购买时间：</strong>
            <p class="fc">
              <select name="zd_buy_time" id="zd_buy_time" class="select" style="width:177px;">
				 <%= CommonForm.createSelect(buyTimeMap,"1个月内") %>
              </select>
            </p>
          </li>
        </ul>
        <div class="btn">
          <input type="button" name="Submit" id="button" value="提交" onclick="submitYN();" />
        </div>
      </div>
      <input name="tag" type="hidden" id="tag" value="3" />
      <input name="zd_agentid" type="hidden" id="zd_agentid" value="" />
      <input name="zd_factoryid" type="hidden" id="zd_factoryid" value="138" />
      <input name = "zd_product_id" type="hidden" id="zd_product_id" value=""/>
      <input name = "zd_factoryname" type="hidden" id="zd_factoryname" value="山工"/>
      <input name = "zd_product_name" type="hidden" id="zd_product_name" value=""/>
      <input type="hidden" name="zd_contact_address" id="zd_contact_address"/>
      <input type="hidden" name="zd_cataname" id="zd_cataname" value="" />
      <input type="hidden" name="zd_catanum" id="zd_catanum" value=""/>
      <input type="hidden" name="tableName" id="tableName" value="pro_product_form"/>
      <input type="hidden" name="zd_ifgroup" id="zd_ifgroup" value="个人"/>
      <input type="hidden" name="flag" id="flag" value="1"/>
    </form>
  </div>
</div>
<div class="wrapper mainbg02"> 
  <div class="contain">  
    <!--tab-->
    <div class="tabContain">
      <div class="tabTitle">
        <ul id="myTab">
          <li onmouseover="nTabs(this,0);" class="active">产品介绍</li>
          <li onmouseover="nTabs(this,1);">活动详情</li>
          <li onmouseover="nTabs(this,2);">试用名单</li>
        </ul>
      </div>
      <div class="tabContain">
        <div id="myTab_Content0" class="tabContent clearfix">
          <div class="ProIntro">
            <ul class="imgs">
              <li><img src="images/pro_img01.png" width="340" height="175" /><h3>SEM919</h3></li>
              <li><img src="images/pro_img02.png" width="340" height="175" /><h3>SEM921</h3></li>
            </ul>
            <div class="introText">
              <h3>产品特点:</h3>
              <ul>
                <li>国二排放配备增压中冷的发动机，扭矩储备大、动力强劲；</li>
                <li>全新冷却系统设计，满足零下40 °C ~零上50°C环境温度工作要求；</li>
                <li>国际先进技术变速箱，电液控制动力换档，前六后三档位；</li>
                <li>三段式驱动后桥，配备无滑转 (NO-SPIN) 差速器，可靠持久；</li>
                <li>宽大舒适的驾驶室位于前车架上，视野清晰，操控方便，并可选配防翻滚驾驶室 (ROPS)；</li>
                <li>标配进口力士乐变量柱塞泵，按需分配流量，节约能耗；</li>
                <li>卡特彼勒独有比例优先、压力补偿控制阀(PPPC)令机具操控更灵敏，提高机器整体性能和效率；</li>
                <li>电-液控制牵引架定位销和七孔连杆迅速获得最广泛的铲刀定位；</li>
                <li>世界级平地机的铲刀控制系统以及应用范围；</li>
                <li>优化的铲刀弧度以及大的喉部间隙使物料具有良好的通过性、流动性，提高生产效率；</li>
                <li>独特的前桥设计，行业领先的轮胎倾斜角度及转向角度，最大化机器的可操作性；</li>
                <li>多种工作机具选配，可以满足客户的不同工况需求。</li>
              </ul>
              <div class="detailBtn"><a href="http://product.21-sun.com/proDetail/SEM919.shtm" target="_blank">了解详情</a></div>
            </div>
          </div>
        </div>
        <div id="myTab_Content1" class="tabContent clearfix hide">
          <div class="activeDetail">
            <p class="text">
              山工机械邀您一同见证山工平地机的卓越品质！在全国范围内招募<strong>10位平地机试用者</strong>，将平地机开回您的施工现场，给您最长<strong>2周的免费</strong>试用时间。在试用结束后您要订购平地机，更能获得价值<strong>5000元</strong>的配件。只要您报名即有机会获得山工平地机精美模型。如果您符合以下条件，现在就立即报名吧！ </p>
            <div class="introText">
              <ul>
                <li>您可以是：平地机机手、机主、有采购意向的用户</li>
                <li>您要具备：<br />
                  1、需要使用平地机施工的工地<br />
                  2、本人或操作手从事工程机械行业2年以上的，试用过程中爱惜机器。
                </li>
                <li>活动时间：<br />
                  4月15日－5月15日 报名 、5月15日－5月20日 筛选、5月21日 确认所有试用者<br />
                  5月底（具体视当地经销商而定）交付机器，交付机器后培训1天、免费试用最长2周
                </li>
                <li>试用机型：SEM919 或SEM921（具体视当地经销商而定）</li>
                <li>试用范围：全国范围内，任何能够体现平地机作业优势的环境</li>
                <li>适合工况：道路建筑、道路维护、场地平整、边坡修筑、沟槽开挖、松土裂土等等</li>
                <li>卡特彼勒独有比例优先、压力补偿控制阀(PPPC)令机具操控更灵敏，提高机器整体性能和效率；</li>
                <li>电-液控制牵引架定位销和七孔连杆迅速获得最广泛的铲刀定位；</li>
                <li>世界级平地机的铲刀控制系统以及应用范围；</li>
                <li>优化的铲刀弧度以及大的喉部间隙使物料具有良好的通过性、流动性，提高生产效率；</li>
                <li>独特的前桥设计，行业领先的轮胎倾斜角度及转向角度，最大化机器的可操作性；</li>
                <li>多种工作机具选配，可以满足客户的不同工况需求。</li>
                <li class="about">
                  如何赢得试用机会？<br />
                  1   您的施工场地工况适合平地机作业。<br />
                  2   您已有开工的工程，或有即将开工项目。<br />
                  3   您拥有优秀的操作手<br />
                  4   能及时记录和分享平地机使用心得。
                </li>
              </ul>
              <p class="shuoming">
                全国范围仅限10个试用名额，符合以上条件者，按照报名时间先到先得。<br />
                每确定一位试用用户，名单将即时在此页面公布。
              </p>
            </div>  
          </div>
        </div>
        <div id="myTab_Content2" class="tabContent clearfix hide">
          <div class="nameList" style="height:auto;">
          <img src="images/qidai.png" width="630" height="215" />
            <!--
            <ul>
              <li>山西  张春生  138***57890</li>
              <li>山西  张春生  138***57890</li>
              <li>山西  张春生  138***57890</li>
              <li>山西  张春生  138***57890</li>
              <li>山西  张春生  138***57890</li>
              <li>山西  张春生  138***57890</li>
              <li>山西  张春生  138***57890</li>
              <li>山西  张春生  138***57890</li>
              <li>山西  张春生  138***57890</li>
              <li>山西  张春生  138***57890</li>
            </ul>-->
          </div>
        </div>
      </div>
    </div>
    
  <div class="clear"></div>  
  </div>
</div>

<div id="success">
  <div class="successCover">
    <!--[if (IE 6)]><iframe src="blank.htm" frameborder="0" scrolling="no" width="100%" height="100%" style="width:100%; height:100%; position:absolute; left:0px; top:0px; allowtransparency="true""></iframe><![endif]-->
  </div>
  <div class="successLayer">
    <img src="images/close.gif" class="closeBtn" onclick="document.getElementById('success').style.display='none'" />
    <p class="text">
      <strong>提交成功！</strong>
      <span>再次感谢您对山工机械的支持，3小时内将有专人与您电话联系。</span>
      <a href="javascript:void(0);" class="confirm" onclick="document.getElementById('success').style.display='none'">确定</a>
    </p>
  </div>
</div>
<div style="display:none"><script src="http://s20.cnzz.com/stat.php?id=5224062&web_id=5224062&show=pic" language="JavaScript"></script></div> 
</body>
</html>