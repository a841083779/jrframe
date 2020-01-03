<%@ page language="java" import="java.sql.Connection,java.util.*,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*" pageEncoding="UTF-8"%><%
	DBHelper dbHelper = DBHelper.getInstance();
	Connection connection = null;
	try{
		connection = dbHelper.getConnection();
		String sql = " select b.name,a.phone from ";
		sql += " activities_record a , activities_reg b ";
		sql += " where a.phone = b.phone and a.rs = 1 and a.items = 'other2' ";
		List<Map> list = dbHelper.getMapList(sql,connection);
%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="author" content="design by www.21-sun.com" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<title>斗山挖掘机-3.15斗山挖掘机抢购活动，疯抢史上最低折扣 - 铁臂商城</title>
<meta name="keywords" content="斗山挖掘机,3.15抢购活动,挖掘机限时抢购,挖掘机优惠" />
<meta name="description" content="中国工程机械商贸网与山东永弘联合发起315斗山挖掘机优惠促销活动，保底赠送2000小时挖掘机保养及5000元优惠券，更有85折大奖等你拿，抢购热线：4006-521-526" />
<link href="style/style.css" rel="stylesheet" type="text/css" />
<link href="/plugin/dialog/jBox/Skins/Blue/jbox.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="/plugin/jquery/jquery.min.js"></script>
<script type="text/javascript" src="/plugin/jquery/jquery.cookies.2.2.0.min.js"></script>
</head>
<body>
<h1 class="hide">斗山挖掘机-疯抢史上最低折扣</h1>
<!--top-->
<div class="top01">
  <div class="wrapper">
    <h2><a href="http://www.21-sun.com/" target="_blank" title="中国工程机械商贸网"><img src="images/21sun_logo.gif" alt="中国工程机械商贸网" width="130" height="86" /></a><a href="http://product.21-sun.com/" target="_blank" title="产品中心-中国工程机械商贸网"><img src="images/21sun_product.gif" alt="产品中心-中国工程机械商贸网" width="72" height="86" /></a></h2>
    <span class="r" id="login_reg" style="display: none;"><a href="javascript:void(0);" onclick="doLogin();">登录</a><em>|</em><a href="javascript:void(0);" onclick="doReg();">注册</a></span>
  </div>
</div>
<div class="nav">
  <div class="wrapper">
    <ul>
      <li><a href="/activity/yhqg/">3.15大放价</a></li>
       <li><a href="/activity/yhqg/process.jsp">活动规则</a></li>
       <li><a href="/brand/doosan/" target="_blank">斗山产品旗舰店</a></li>
       <li><a href="/activity/yhqg/name_list.jsp" class="selected">获奖名单</a></li>
    </ul>
  </div>
</div>
<!--top end-->
<div class="wrapper mainContain pageDetail" style="*padding-bottom:20px; _padding-bottom:0px;">
  <div class="mainLeft">
    <div class="shopPart">
    <script src="MSClass.js" type="text/javascript"></script>
      <div class="content" style="border:none; background:url(images/namelistbg.jpg) 15px 15px no-repeat; height:346px; padding-top:80px;">
        <div class="namelist" id="namelist"  style="height:252px; margin-bottom:0px; ">
          <ul>
            <li>
              <span class="n">田**</span>
              <span class="t">138******29</span>
              <span class="g">DX345LC挖掘机一等奖</span>
            </li>
            <li>
              <span class="n">张*</span>
              <span class="t">132******22</span>
              <span class="g">DX380LC挖掘机一等奖</span>
            </li>
            <li>
              <span class="n">王*</span>
              <span class="t">137******80</span>
              <span class="g"> 保养及优惠券限时抢购一等奖</span>
            </li>
            <li>
              <span class="n">田**</span>
              <span class="t">186******17</span>
              <span class="g">DX345LC挖掘机二等奖</span>
            </li> 
            <li>
              <span class="n">贾**</span>
              <span class="t">139******33</span>
              <span class="g">保养及优惠券限时抢购二等奖</span>
            </li>
            <li>
              <span class="n">于**</span>
              <span class="t">186******89</span>
              <span class="g">DX345LC挖掘机三等奖</span>
            </li>
            
            <%
          	if(null!=list&&list.size()>0){
          		String name = "";
          		String phone = "";
          		for(Map m : list){
          			name = CommonString.getFormatPara(m.get("name"));
          			name = name.substring(0,1)+"**";
          			phone = CommonString.getFormatPara(m.get("phone"));
          			phone = phone.substring(0,3)+"******"+phone.substring(phone.length()-2);
          			%>
			<li>
              <span class="n"><%=name %></span>
              <span class="t"><%=phone %></span>
              <span class="g">获得5000元优惠券</span>
            </li>
          			<%
          		}
          	}
          %>
          </ul>
        </div>
       
        <script type="text/javascript">
		new Marquee("namelist",0,1,580,285,30,0,0)//向上连续滚动及鼠标拖动实例实例
		</script>
      </div>
    </div>
  </div>
  <div class="mainRight">
  
    <div class="rightPart">
      <div class="title t01">
        <h2>挖机抢购公告</h2>
      </div>
      <div class="content">
        <p class="text">用户在3.15当天约定时间(10:00开始)<br />参与抢购活动</p>
      </div>
    </div>
    
    
    <div class="rightPart">
      <div class="title t02">
        <h2>联系客服</h2>
      </div>
      <div class="content">
        <table width="218" border="0" cellspacing="0" cellpadding="0" class="mb5">
          <tr>
            <td width="37">电话：</td>
            <td width="181">0535-6792733　0535-6792830<br />
            0535-6921286　0535-6727793</td>
          </tr>
        </table>
        <table width="218" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="37">ＱＱ：</td>
            <td width="181">
             <a target="_blank" href="http://wpa.qq.com/msgrd?v=3&uin=1637601151&site=qq&menu=yes"><img border="0" src="http://wpa.qq.com/pa?p=2:1637601151:41" alt="点击这里给我发消息" title="点击这里给我发消息"></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a target="_blank" href="http://wpa.qq.com/msgrd?v=3&uin=527071217&site=qq&menu=yes"><img border="0" src="http://wpa.qq.com/pa?p=2:527071217:41" alt="点击这里给我发消息" title="点击这里给我发消息"></a><br />
            <a target="_blank" href="http://wpa.qq.com/msgrd?v=3&uin=1623270792&site=qq&menu=yes"><img border="0" src="http://wpa.qq.com/pa?p=2:1623270792:41" alt="点击这里给我发消息" title="点击这里给我发消息"></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a target="_blank" href="http://wpa.qq.com/msgrd?v=3&uin=544685334&site=qq&menu=yes"><img border="0" src="http://wpa.qq.com/pa?p=2:544685334:41" alt="点击这里给我发消息" title="点击这里给我发消息"></a>
            </td>
          </tr>
        </table>
      </div>
     
    </div>
    
  </div>
<div class="clear"></div>
</div>
<!--foot-->
<div class="foot">
  <jsp:include page="/include/foot.jsp" flush="true"/>
</div>
<!--foot end-->
</body>
</html>
<script type="text/javascript" id="bdshare_js" data="type=tools&amp;uid=537258" ></script>
<script type="text/javascript" id="bdshell_js"></script>
<script type="text/javascript" src="/plugin/dialog/jBox/jquery.jBox-2.3.min.js"></script>
<script type="text/javascript" src="/plugin/jquery/jquery.form.js"></script>
<script type="text/javascript" src="index.js"></script>
<%
	}catch(Exception e){
		
	}finally{
		DBHelper.freeConnection(connection);
	}
%>