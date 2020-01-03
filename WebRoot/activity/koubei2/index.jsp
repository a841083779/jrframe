<%@page import="java.sql.Connection"%>
<%@page import="com.jerehnet.util.common.Common"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.jerehnet.util.common.CommonString"%>
<%@page import="com.jerehnet.util.dbutil.DBHelper"%>
<%@page import="com.jerehnet.util.common.CommonDate"%>
<% 
	List<Map> catalogList = (List<Map>)application.getAttribute("catalogList") ;
	Map memberInfo = (Map)session.getAttribute("memberInfo");
	String username = ""; String password="";
	if(memberInfo != null){
		username = CommonString.getFormatPara(memberInfo.get("username"));
		password = CommonString.getFormatPara(memberInfo.get("password"));
	}
	

	DBHelper dbHelper = DBHelper.getInstance();
	Connection connection = null;
	List<Map> wajuejiList = null;
	List<Map> zhuangzaijiList = null;
	try{
		connection = dbHelper.getConnection();
		//wajueji
		String wajuejiSql = "select top 4 * from pro_products where catalognum like '101001%' order by view_count desc ,id desc ";
		wajuejiList = dbHelper.getMapList(wajuejiSql);
		//zhuangzaiji
		String zhuangzaijiSql = "select top 5 * from pro_products where is_show=1 and catalognum like '101002%' order by view_count desc ,id desc ";
		zhuangzaijiList = dbHelper.getMapList(zhuangzaijiSql);
		
	}catch(Exception e){
		connection.rollback();
		e.printStackTrace();
	}finally{
		dbHelper.freeConnection(connection);
	}
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>第二季铁臂口碑活动——分享真实用机感受 - 铁臂口碑</title>
<meta name="keywords" content="工程机械口碑" />
<meta name="description" content="铁臂口碑第二季活动——分享您的真实用机感受，就有机会获得大奖。买工程机械产品，就上铁臂商城。" />
<link href="/style/style.css" rel="stylesheet" type="text/css" />
<link href="style/style.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="/plugin/dialog/jBox/Skins/Blue/jbox.css" type="text/css"></link>
<link href="/plugin/validator/rjboy/validform.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="/scripts/jquery-1.7.min.js"></script>
<script type="text/javascript" src="/scripts/login.js"></script>
<script type="text/javascript" src="/scripts/jquery.raty.min.js"></script>
<script type="text/javascript" src="/scripts/jquery.form.js"></script>


<style type="text/css">
html { height: 100%; }
.xz_title { height: 40px!important; line-height:40px!important; }
.xzLayer .xz_title h3 { padding-left: 20px; }
li.name input, li.code input { width: 155px; height: 21px; line-height: 21px; padding: 8px 0px 8px 45px; font-size: 14px; font-family: 微软雅黑; color: #9c9c9c; background: url(images/new_login_inputbg.gif) no-repeat; border: none; }
li.code input { background-position: 0px -37px; }
</style>
<style>
.fixLayer { width:100px; height:300px;  position:fixed; right:10px; bottom:50px;}
</style>
</head>
<body>
<!--top-->
<jsp:include page="/include/top.jsp" flush="true"/>
<div class="kb_part kb_part01">
  <div class="wrap">
    <div class="nav_links">
      <a href="#guize" class="lk" title="活动规则">活动规则</a>
      <a href="#jiangpin" class="lk" title="活动奖品">活动奖品</a>
      <a href="#guize" class="lk" title="中奖规则" style="margin-right:20px;">中奖规则</a>
      <a href="#ganshou" class="lk" title="发表用机感受" style="margin-right:20px;">发表用机感受</a>
      <a href="http://product.21-sun.com/activity/shantui/" class="lk" title="山推专区" target="_blank">山推专区</a>
    </div>
  </div>
</div>
<div class="kb_part kb_part02" id="guize">
  <div class="wrap fix">
    <a href="http://product.21-sun.com/activity/koubei/images/gl.jpg" target="_blank" title="口碑评论标准" class="bz">口碑评论标准</a>
    <div class="loginForm">
      <div class="loginLayer">
  <div class="loginLayerLeft" <%if(!username.equals("")){%>style="display:none"<%}%>>
    <form action="/action/ajax.jsp" name="loginform" id="loginform" method="post">
      <ul class="b_whitebg">
        <li class="name">
          <input type="text" onfocus="clear1();" name="showLoginName_index" id="showLoginName_index" title="注册时的用户名"  onKeyDown="if(event.keyCode==13){doLoginIndex();}" datatype="Require" msg="请输入用户名！">
          <input style="display: none;" name="login_username_index" type="text" id="login_username_index" onBlur="onblurTochangeTxt(this,2)">
        </li>
        <li class="code">
          <input type="text" onfocus="clear2();"   class="b_wi02" name="showLoginPasswd_index" id="showLoginPasswd_index" value="" title="密码" onKeyDown="if(event.keyCode==13){doLoginIndex();}"  datatype="Require" msg="请输入密码！">
          <input style="display: none;" name="login_password_index" type="password_index" class="b_wi02" id="login_password" value="密码" onKeyDown="if(event.keyCode==13){doLogin();}" onBlur="onblurTochangeTxt(this,2)">
        </li>
        <li class="remeber">
          <input type="checkbox" name="rememberPass_index" id="rememberPass_index" value="0">
          <span style="cursor: pointer;" id="rem_pass_index">两周内自动登录</span> </li>
        <li class="b_loginWays" style="line-height: 40px;">
          <div class="b_btn">
            <input  type="button" name="button" id="button" onClick="doLoginIndex();" value="立即登录" class="b_lb1">
            <span>还没有账号？<br><a href="/activity/koubei/register.jsp">立即注册</a></span>
            &nbsp;&nbsp;&nbsp;<!-- <a href="javascript:void(0);" style="color:#ff8400; text-decoration:underline;">忘记密码？</a> -->
            <input type="hidden" name="flag" value="doLogin">
          </div>
        </li>
      </ul>
    </form>
  </div>
  <script>
$("#showLoginPasswd_index").focus(function(){ 
   document.getElementById("showLoginPasswd_index").type = "password"; 
});  
  </script>
    <div class="loginLayerLeft" <%if(username.equals("")){%>style="display:none"<%}%>>
	        <span style="font-size:16px; color:white"><%=username%>&nbsp;&nbsp;已登录<br><br><a style="color:white" href="javascript:void(0)" onClick="goToCenter();">查看已发布口碑</a></span>
    </div>
	
</div>
    </div>
  </div>
</div>
<div class="kb_part kb_part03" id="jiangpin">
<div class=" wrap fix">
<div class="l p3_2">
          <div class="listbody">
            <div class="listhead fix"><b>用户名</b><b>得分</b><b>名次</b><b>奖项</b></div>
            <ul>
              <li><strong>chenjindong</strong><span>297分</span><span>第一名</span><span>一等奖</span></li>
              <li><strong>liwei</strong><span>40分</span><span>第二名</span><span>二等奖</span></li>
              <li><strong>jiateng</strong><span>33分</span><span>第三名</span><span>二等奖</span></li>
              <li><strong>Dave</strong><span>20分 </span><span>第四名</span><span>二等奖</span></li>
              <li><strong >山推123</strong><span>10分</span><span>第五名</span><span>三等奖</span></li>
              <li><strong>ln001</strong><span>10分</span><span>第五名</span><span>三等奖</span></li>
              <li><strong>tbvisiter</strong><span>10分</span><span>第五名</span><span>三等奖</span></li>
              <li><strong>maeumi</strong><span>1分</span><span>第八名</span><span>三等奖</span></li>
              <li><strong>chkahei</strong><span>1分</span><span>第八名</span><span>三等奖</span></li>             
            </ul>          
          </div>          
        </div>
        <div class="r pre_r">        
            <div class="list_btm"> 了解更多获奖明细及活动公告请加 <b>产品咨询群： 250469589<br> 活动公告群： 215179483</b></div>
            <div class="jp"><img src="images/pre_03.jpg" width="152" height="286" alt="一等奖"><img src="images/pre_05.jpg" width="152" height="286" alt="二等奖"><img src="images/pre_07.jpg" width="152" height="286" alt="三等奖"><a href="http://product.21-sun.com/activity/shantui/" target="_blank"><img src="images/pre_09.jpg" width="152" height="286" alt="山推专区奖品"></a></div>
        </div>
</div>
</div>
<div class="kb_part kb_part04" id="ganshou">
<div class="wrap fix">
<form action="/action/crud.jsp" method="post" name="theform" id="theform">
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="19%" height="48" align="right" class="td_bot"><b>*</b>请选择机型：</td>
            <td width="81%" class="td_bot"><select name="catalog" id="catalog" onchange='<% if(username.equals("")){ %>login();<%}else{%>chooseBrand(this.value)<%}%>'>
                <option value="">请选择类型</option>
                <%
                for(Map m : catalogList){ 
                	String key = CommonString.getFormatPara(m.get("num"));
            		String value = CommonString.getFormatPara(m.get("name"));
            		if(key.length()==6){
                %>
                	<option value="<%=key %>"><%=value %></option>
                <%}} %>
              </select>
              <select name="brand" id="brand" onchange='<% if(username.equals("")){ %>login();<%}else{%>chooseBrand(this.value)<%}%>'>
                <option value="">请选择品牌</option>
				<option value="1185">A-阿尔多机械</option>
				<option value="180">A-阿特拉斯</option>
				<option value="482">A-阿特拉斯·科普柯</option>
				<option value="402">A-艾迪</option>
				<option value="772">A-艾思博</option>
				<option value="14236">A-安鼎重工</option>
				<option value="1710">A-安迈</option>
				<option value="1169">A-安丘通用</option>
				<option value="13271">A-奥津</option>
				<option value="1778">A-奥盛特重工</option>
				<option value="13272">A-奥泰</option>
				<option value="484">B-八达</option>
				<option value="791">B-八达重工</option>
				<option value="13557">B-巴里巴</option>
				<option value="1108">B-百财</option>
				<option value="13562">B-百巨建机</option>
				<option value="13560">B-百开</option>
				<option value="13565">B-百力克</option>
				<option value="13561">B-百灵</option>
				<option value="1168">B-百脉建机</option>
				<option value="478">B-邦立重机</option>
				<option value="13569">B-宝达</option>
				<option value="13570">B-宝鼎</option>
				<option value="1715">B-宝骊</option>
				<option value="13550">B-宝马格</option>
				<option value="13558">B-宝象</option>
				<option value="13567">B-暴风雪</option>
				<option value="1093">B-北车重工</option>
				<option value="14144">B-北方红阳</option>
				<option value="167">B-北方交通</option>
				<option value="13551">B-北京加隆</option>
				<option value="186">B-北起多田野</option>
				<option value="1714">B-北山机械</option>
				<option value="420">B-贝力特</option>
				<option value="13556">B-贝司特</option>
				<option value="13568">B-泵虎</option>
				<option value="13553">B-边宁荷夫</option>
				<option value="13566">B-滨州钻机</option>
				<option value="13552">B-波坦</option>
				<option value="13571">B-波特重工</option>
				<option value="13559">B-博德</option>
				<option value="1206">B-博汇机械</option>
				<option value="13555">B-博纳地</option>
				<option value="13093">B-博山</option>
				<option value="1234">B-博亚</option>
				<option value="13624">B-博洋</option>
				<option value="825">B-搏浪沙</option>
				<option value="13572">C-沧田重工</option>
				<option value="13575">C-昌世</option>
				<option value="13578">C-长春神骏</option>
				<option value="13142">C-长高一品</option>
				<option value="13094">C-长海科技</option>
				<option value="13174">C-长河</option>
				<option value="147">C-长江</option>
				<option value="13579">C-长盛机械</option>
				<option value="615">C-长阳机械</option>
				<option value="148">C-常林股份</option>
				<option value="485">C-朝工</option>
				<option value="13576">C-朝阳建工</option>
				<option value="13574">C-郴筑</option>
				<option value="145">C-成工</option>
				<option value="1591">C-楚工龙泰</option>
				<option value="13573">C-创一</option>
				<option value="1716">D-达刚</option>
				<option value="13587">D-达力</option>
				<option value="13580">D-达宇重工</option>
				<option value="162">D-大地</option>
				<option value="13584">D-大方</option>
				<option value="1122">D-大汉</option>
				<option value="13592">D-大宏立</option>
				<option value="1195">D-大江</option>
				<option value="13586">D-大连</option>
				<option value="13589">D-大山路桥</option>
				<option value="171">D-大信重工</option>
				<option value="212">D-戴纳派克</option>
				<option value="1243">D-道辰格</option>
				<option value="1218">D-道胜</option>
				<option value="13588">D-道维施</option>
				<option value="151">D-德工</option>
				<option value="683">D-德国宝峨</option>
				<option value="489">D-德基机械</option>
				<option value="13597">D-德科达</option>
				<option value="16351">D-德力重工</option>
				<option value="213">D-德玛格</option>
				<option value="13598">D-德通</option>
				<option value="1719">D-德威土行孙</option>
				<option value="13595">D-德亿重工</option>
				<option value="140">D-鼎盛重工</option>
				<option value="14222">D-东倡机械</option>
				<option value="1351">D-东达桩工</option>
				<option value="1763">D-东德重工</option>
				<option value="1187">D-东方红</option>
				<option value="13591">D-东方冶矿</option>
				<option value="616">D-东方之星</option>
				<option value="1755">D-东风</option>
				<option value="405">D-东空</option>
				<option value="14169">D-东立机械</option>
				<option value="13583">D-东泷</option>
				<option value="13590">D-东蒙机械</option>
				<option value="1717">D-东南机械</option>
				<option value="163">D-东岳重工</option>
				<option value="1098">D-斗昌</option>
				<option value="192">D-斗山</option>
				<option value="671">F-方圆集团</option>
				<option value="13630">F-飞涛机械</option>
				<option value="1120">F-丰汇技术</option>
				<option value="1729">F-丰田</option>
				<option value="1188">F-福大机械</option>
				<option value="215">F-福格勒</option>
				<option value="1183">F-福工</option>
				<option value="682">F-福临</option>
				<option value="141">F-福田雷沃</option>
				<option value="1208">F-福威重工</option>
				<option value="165">F-抚顺起重机</option>
				<option value="164">F-抚挖</option>
				<option value="1225">F-抚挖锦重</option>
				<option value="1721">F-富豪</option>
				<option value="1888">F-富亿机械</option>
				<option value="1124">F-富友正和</option>
				<option value="1703">G-甘肃宝龙</option>
				<option value="14252">G-冈研</option>
				<option value="13604">G-高达</option>
				<option value="492">G-高马科</option>
				<option value="534">G-高远路业</option>
				<option value="1754">G-高远圣工</option>
				<option value="13606">G-格鲁夫</option>
				<option value="477">G-格瑞德</option>
				<option value="13603">G-格瑞特</option>
				<option value="423">G-工兵</option>
				<option value="417">G-古河</option>
				<option value="13605">G-谷登机械</option>
				<option value="424">G-广林产机</option>
				<option value="1116">G-广西建机</option>
				<option value="13608">G-国发</option>
				<option value="1369">G-国机重工</option>
				<option value="893">H-海德</option>
				<option value="1109">H-海斗</option>
				<option value="13611">H-海华筑机</option>
				<option value="203">H-海诺</option>
				<option value="1091">H-海山</option>
				<option value="1733">H-海斯特</option>
				<option value="1176">H-海泰</option>
				<option value="1105">H-海特</option>
				<option value="13620">H-海天路矿</option>
				<option value="1128">H-海威斯帝尔</option>
				<option value="664">H-海州机械</option>
				<option value="415">H-韩川</option>
				<option value="1112">H-韩工</option>
				<option value="14253">H-韩农</option>
				<option value="845">H-韩锐</option>
				<option value="421">H-韩宇</option>
				<option value="216">H-悍马</option>
				<option value="426">H-悍狮</option>
				<option value="814">H-捍宇</option>
				<option value="1734">H-杭叉</option>
				<option value="13628">H-杭重威施诺</option>
				<option value="1732">H-杭州爱知</option>
				<option value="1724">H-杭州市政</option>
				<option value="1757">H-合肥中达</option>
				<option value="1525">H-合矿</option>
				<option value="158">H-合力</option>
				<option value="13632">H-和盛达</option>
				<option value="154">H-河北宣工</option>
				<option value="1103">H-黑金钢</option>
				<option value="13623">H-恒端机械</option>
				<option value="13641">H-恒康</option>
				<option value="1761">H-恒诺机械</option>
				<option value="1508">H-恒日重工</option>
				<option value="1735">H-恒润高科</option>
				<option value="13614">H-恒升</option>
				<option value="170">H-恒特</option>
				<option value="1147">H-恒天九五</option>
				<option value="13636">H-恒兴机械</option>
				<option value="13096">H-恒至凿岩</option>
				<option value="13613">H-红旗</option>
				<option value="13639">H-宏昌</option>
				<option value="13633">H-宏达</option>
				<option value="13609">H-宏大科技</option>
				<option value="13629">H-宏建机械</option>
				<option value="13618">H-宏力液压</option>
				<option value="217">H-鸿达</option>
				<option value="202">H-鸿得利重工</option>
				<option value="13626">H-鸿源车业</option>
				<option value="819">H-虎霸集团</option>
				<option value="13617">H-虎力</option>
				<option value="13577">H-华贝尔</option>
				<option value="13627">H-华丰桩工</option>
				<option value="13634">H-华光机械</option>
				<option value="206">H-华力重工</option>
				<option value="13640">H-华南重工</option>
				<option value="1725">H-华骐</option>
				<option value="1727">H-华强京工</option>
				<option value="1731">H-华山</option>
				<option value="1220">H-华通动力</option>
				<option value="1526">H-华伟重工</option>
				<option value="1512">H-华中建机</option>
				<option value="13625">H-华重</option>
				<option value="14111">H-环球</option>
				<option value="13621">浣-浣熊</option>
				<option value="13622">H-惠工机械</option>
				<option value="14283">H-惠龙机械</option>
				<option value="13616">H-惠山</option>
				<option value="554">J-吉公</option>
				<option value="1157">J-吉宏机械</option>
				<option value="1524">J-吉尼</option>
				<option value="1229">J-吉星</option>
				<option value="1179">J-济南建机</option>
				<option value="13655">J-冀中能源</option>
				<option value="189">J-加藤</option>
				<option value="13645">J-佳乐</option>
				<option value="13654">J-佳一</option>
				<option value="1145">J-佳弋建机</option>
				<option value="13656">J-嘉成</option>
				<option value="13176">J-嘉和重工</option>
				<option value="407">J-甲南</option>
				<option value="1352">J-建德机械</option>
				<option value="13659">J-建丰机械</option>
				<option value="1127">J-建神</option>
				<option value="1736">J-建研机械</option>
				<option value="1357">J-建友机械</option>
				<option value="479">J-江淮重工</option>
				<option value="13643">J-江加</option>
				<option value="487">J-江麓</option>
				<option value="13647">J-江苏路通</option>
				<option value="1643">J-江苏意玛</option>
				<option value="1136">J-江苏正兴</option>
				<option value="1355">J-矫马</option>
				<option value="1137">J-杰渝</option>
				<option value="13657">J-金城</option>
				<option value="1094">J-金菱机械</option>
				<option value="13651">J-金茂</option>
				<option value="1141">J-金桥塔机</option>
				<option value="1142">J-金塔</option>
				<option value="13653">J-金源</option>
				<option value="1737">J-金正神力</option>
				<option value="1132">J-锦城建机</option>
				<option value="1586">J-劲工</option>
				<option value="172">J-晋工</option>
				<option value="1759">J-京城长野</option>
				<option value="166">J-京城重工</option>
				<option value="1159">J-京龙</option>
				<option value="401">J-惊天液压</option>
				<option value="13649">J-精功</option>
				<option value="13650">J-靖江（JJCC）</option>
				<option value="187">J-久保田</option>
				<option value="1232">J-久工</option>
				<option value="13652">J-久润</option>
				<option value="197">J-酒井</option>
				<option value="1193">J-巨超重工</option>
				<option value="1130">J-巨神</option>
				<option value="13648">J-聚龙</option>
				<option value="679">J-军恒斯帕克</option>
				<option value="681">J-军联</option>
				<option value="816">J-骏马</option>
				<option value="13667">K-卡萨阁蓝地</option>
				<option value="174">K-卡特彼勒</option>
				<option value="178">K-卡特重工</option>
				<option value="14247">K-开普动力</option>
				<option value="160">K-开元智富</option>
				<option value="1135">K-凯捷</option>
				<option value="1322">K-凯雷</option>
				<option value="13661">K-凯联</option>
				<option value="480">K-凯莫尔</option>
				<option value="455">K-凯斯</option>
				<option value="1756">K-凯威</option>
				<option value="13682">K-凯兴</option>
				<option value="1210">K-康柏机械</option>
				<option value="1118">K-科曼萨杰牌</option>
				<option value="13705">K-科尼乐机械</option>
				<option value="13664">K-科尼乐重工</option>
				<option value="13663">K-科泰重工</option>
				<option value="14243">K-科友机械</option>
				<option value="13666">K-科筑机械</option>
				<option value="1779">K-克拉士</option>
				<option value="13665">K-克瑞</option>
				<option value="14265">K-孔山重工</option>
				<option value="1223">K-坤宇重工</option>
				<option value="13668">K-坤宇重装</option>
				<option value="1144">K-昆明力神</option>
				<option value="13097">L-莱工</option>
				<option value="1194">L-蓝翔重工</option>
				<option value="543">L-雷奥科技</option>
				<option value="1718">L-雷萨重机</option>
				<option value="13681">L-黎明</option>
				<option value="412">L-力博士</option>
				<option value="13678">L-力尔美</option>
				<option value="13683">L-力士</option>
				<option value="157">L-力士德</option>
				<option value="13687">L-立藤</option>
				<option value="13676">L-立新</option>
				<option value="179">L-利勃海尔</option>
				<option value="13677">L-利洲</option>
				<option value="776">L-连云港工兵GBPSC</option>
				<option value="13684">L-联丰机械</option>
				<option value="13686">L-辽原筑机</option>
				<option value="204">L-辽筑</option>
				<option value="1742">L-林德</option>
				<option value="13680">L-林泰阁</option>
				<option value="16359">L-临工重特</option>
				<option value="1509">L-灵升机械</option>
				<option value="1181">L-凌虹建机</option>
				<option value="767">L-凌宇汽车</option>
				<option value="1180">L-凌云建机</option>
				<option value="136">L-柳工</option>
				<option value="135">L-龙工</option>
				<option value="14233">L-龙兴机械</option>
				<option value="1739">L-鲁青</option>
				<option value="14257">L-鲁宇重工</option>
				<option value="688">L-鲁岳</option>
				<option value="207">L-陆德筑机</option>
				<option value="13688">L-路宝</option>
				<option value="13631">L-路畅养护</option>
				<option value="13679">L-路达</option>
				<option value="13669">L-路大</option>
				<option value="13673">L-路德克</option>
				<option value="13670">L-路虹</option>
				<option value="13675">L-路维</option>
				<option value="13674">L-路星</option>
				<option value="552">L-绿地</option>
				<option value="1709">L-滦州重工</option>
				<option value="1231">L-洛建</option>
				<option value="749">L-洛阳东方红</option>
				<option value="673">L-洛阳路通</option>
				<option value="13689">M-玛连尼</option>
				<option value="13208">M-麦恩</option>
				<option value="418">M-麦恩</option>
				<option value="13693">M-曼尼通</option>
				<option value="14262">M-曼托瓦尼</option>
				<option value="13692">M-梅狮</option>
				<option value="1743">M-美科斯</option>
				<option value="13095">M-美通筑机</option>
				<option value="13696">M-美卓</option>
				<option value="422">M-猛士</option>
				<option value="14278">M-蒙地机械</option>
				<option value="14300">M-民盛水山</option>
				<option value="13697">M-闽工</option>
				<option value="13691">M-闽科</option>
				<option value="13737">M-明山路桥</option>
				<option value="1125">M-明威塔机</option>
				<option value="13694">M-摩纳凯</option>
				<option value="1126">M-牡丹江</option>
				<option value="13695">M-牡丹江专用汽车</option>
				<option value="13700">N-纳科重工</option>
				<option value="1209">N-南车北京时代</option>
				<option value="200">N-南方路机</option>
				<option value="1134">N-南京绿野</option>
				<option value="13698">N-南侨</option>
				<option value="169">N-南特</option>
				<option value="14249">N-宁工重机</option>
				<option value="1748">N-农友</option>
				<option value="14186">N-诺尔</option>
				<option value="13699">N-诺力</option>
				<option value="1585">N-诺森机械</option>
				<option value="13702">O-欧霸重工</option>
				<option value="13701">O-欧亚机械</option>
				<option value="1588">P-平汉重工</option>
				<option value="199">P-普茨迈斯特</option>
				<option value="403">P-普堃韩泰克</option>
				<option value="486">P-普什重机</option>
				<option value="686">Q-七天阳</option>
				<option value="1184">Q-奇瑞迪凯重科</option>
				<option value="14232">Q-千里马</option>
				<option value="1139">Q-强力</option>
				<option value="582">Q-勤牛</option>
				<option value="14250">Q-青岛雅凯</option>
				<option value="13708">Q-青山</option>
				<option value="1750">Q-全工机械</option>
				<option value="198">Q-全进重工</option>
				<option value="13704">Q-泉成机械</option>
				<option value="13706">Q-泉工</option>
				<option value="13703">Q-泉筑</option>
				<option value="13707">Q-群峰智能</option>
				<option value="196">R-日工</option>
				<option value="184">R-日立</option>
				<option value="173">R-熔盛机械</option>
				<option value="409">R-锐马机械</option>
				<option value="805">R-锐泰</option>
				<option value="13709">R-瑞龙重工(欧盟技术)</option>
				<option value="1216">R-瑞诺</option>
				<option value="14211">R-润邦机械</option>
				<option value="810">R-润弘</option>
				<option value="14281">R-若鞍亿科技</option>
				<option value="13724">S-赛格玛</option>
				<option value="1762">S-赛力斯特</option>
				<option value="13717">S-赛奇</option>
				<option value="868">S-赛通重工</option>
				<option value="14248">S-赛宇重工</option>
				<option value="14187">S-三驾机械</option>
				<option value="13740">S-三力机械</option>
				<option value="13749">S-三笠</option>
				<option value="13732">S-三联机械</option>
				<option value="13721">S-三菱</option>
				<option value="13748">S-三隆重工</option>
				<option value="13725">S-三洋重工</option>
				<option value="133">S-三一</option>
				<option value="14217">S-三一帕尔菲格</option>
				<option value="1711">S-扫地王</option>
				<option value="626">S-森田重机</option>
				<option value="13730">S-森源</option>
				<option value="13713">S-森远</option>
				<option value="1221">S-山宝</option>
				<option value="153">S-山东常林</option>
				<option value="14280">S-山东海宏</option>
				<option value="1123">S-山东华夏</option>
				<option value="13744">S-山东汇强</option>
				<option value="137">S-山东临工</option>
				<option value="13118">S-山东鲁工</option>
				<option value="13747">S-山东明龙</option>
				<option value="13209">S-山东众和</option>
				<option value="138">S-山工</option>
				<option value="142">S-山河智能</option>
				<option value="454">S-山猫</option>
				<option value="13731">S-山美</option>
				<option value="1722">S-山猛机械</option>
				<option value="1304">S-山特维克</option>
				<option value="144">S-山推</option>
				<option value="13723">S-山推格林</option>
				<option value="1207">S-山挖重工</option>
				<option value="152">S-山重建机</option>
				<option value="668">S-陕建机械</option>
				<option value="1753">S-陕汽</option>
				<option value="13728">S-陕西科尼乐</option>
				<option value="691">S-上海华建</option>
				<option value="13735">S-上海建冶</option>
				<option value="201">S-上海金泰</option>
				<option value="156">S-上海彭浦</option>
				<option value="211">S-上海施维英</option>
				<option value="13733">S-上海威力特</option>
				<option value="13715">S-上海西芝</option>
				<option value="1095">S-上海振中</option>
				<option value="13718">S-上力重工</option>
				<option value="741">S-上騏</option>
				<option value="1113">S-神斧</option>
				<option value="183">S-神钢</option>
				<option value="1523">S-神马科技</option>
				<option value="14235">S-神娃机械</option>
				<option value="13746">S-沈阳广成</option>
				<option value="830">S-沈阳三洋</option>
				<option value="1720">S-沈阳山河</option>
				<option value="1138">S-升立建机</option>
				<option value="1090">S-盛利达</option>
				<option value="618">S-盛隆</option>
				<option value="190">S-石川岛</option>
				<option value="168">S-石煤</option>
				<option value="13727">S-世邦</option>
				<option value="14255">S-世工机械</option>
				<option value="13710">S-世联</option>
				<option value="14251">S-世鑫源机械</option>
				<option value="413">S-世运</option>
				<option value="13711">S-仕高玛</option>
				<option value="13714">S-首钢泰晟</option>
				<option value="13719">S-双力</option>
				<option value="13745">S-双牛</option>
				<option value="771">S-双友机械</option>
				<option value="419">S-水山</option>
				<option value="13729">S-思嘉特</option>
				<option value="13751">S-思拓瑞克</option>
				<option value="13722">S-斯贝柯</option>
				<option value="1102">S-斯达格思</option>
				<option value="14279">S-斯泰克</option>
				<option value="1117">S-四川建机</option>
				<option value="13742">S-四通重工</option>
				<option value="13739">嵩-嵩山重工</option>
				<option value="1730">T-台励福</option>
				<option value="538">T-太腾机械</option>
				<option value="1728">T-泰安鲁能</option>
				<option value="404">T-泰戈</option>
				<option value="406">T-泰科</option>
				<option value="14241">T-泰山力源</option>
				<option value="1353">T-泰石克</option>
				<option value="14261">T-泰信机械</option>
				<option value="176">T-特雷克斯</option>
				<option value="827">T-腾迈机械</option>
				<option value="13231">T-天地奔牛</option>
				<option value="476">T-天地重工</option>
				<option value="13754">T-天顺长城</option>
				<option value="774">T-天为</option>
				<option value="13755">T-天宇</option>
				<option value="13752">T-田中铁工</option>
				<option value="620">T-铁兵</option>
				<option value="1758">T-铁建重工</option>
				<option value="218">T-铁拓机械</option>
				<option value="1726">T-通亚汽车</option>
				<option value="1211">T-同力重工</option>
				<option value="13753">T-土力机械</option>
				<option value="210">T-拓能重机</option>
				<option value="614">W-万邦重科</option>
				<option value="1140">W-威海固恒</option>
				<option value="1189">W-威肯</option>
				<option value="491">W-威猛</option>
				<option value="1738">W-威盛</option>
				<option value="14256">W-威源机械</option>
				<option value="214">W-维特根</option>
				<option value="14263">W-潍柴特种车</option>
				<option value="149">W-沃得重工</option>
				<option value="662">W-沃尔华</option>
				<option value="175">W-沃尔沃</option>
				<option value="16352">W-沃特重工</option>
				<option value="1760">W-无锡泰特</option>
				<option value="1160">W-五羊建机</option>
				<option value="13778">X-西安路邦</option>
				<option value="1589">X-西贝</option>
				<option value="13777">X-西尔玛</option>
				<option value="13177">X-西林</option>
				<option value="1590">X-西子起重</option>
				<option value="623">X-犀牛重工</option>
				<option value="13786">X-夏洲重工</option>
				<option value="139">X-厦工</option>
				<option value="13175">X-厦金</option>
				<option value="13784">X-厦强</option>
				<option value="1744">X-厦盛</option>
				<option value="13783">X-厦装</option>
				<option value="410">X-先锋</option>
				<option value="194">X-现代</option>
				<option value="1359">X-现代（山东）</option>
				<option value="1227">X-现代建机</option>
				<option value="1741">X-小橋</option>
				<option value="182">X-小松</option>
				<option value="13787">X-协兴</option>
				<option value="13785">X-欣融</option>
				<option value="13814">X-新波臣</option>
				<option value="1708">X-新特重工</option>
				<option value="1236">X-新天和</option>
				<option value="13779">X-新型</option>
				<option value="13098">X-新宇机械</option>
				<option value="1683">X-新源机械</option>
				<option value="690">X-新筑股份</option>
				<option value="692">鑫-鑫国重机</option>
				<option value="1115">鑫-鑫天地</option>
				<option value="1235">X-信达机械</option>
				<option value="1097">X-星邦重工</option>
				<option value="205">X-星马汽车</option>
				<option value="13788">X-雄辉</option>
				<option value="1212">X-雄鹏机械</option>
				<option value="209">X-徐工</option>
				<option value="561">X-徐工汽车</option>
				<option value="1522">X-徐工特机</option>
				<option value="131">X-徐随</option>
				<option value="150">X-徐挖</option>
				<option value="544">X-徐威重科</option>
				<option value="128">X-徐重</option>
				<option value="1129">X-徐州建机</option>
				<option value="867">X-徐州凯尔</option>
				<option value="129">X-徐筑</option>
				<option value="13619">X-雪狼</option>
				<option value="687">X-雪桃</option>
				<option value="13805">Y-亚工</option>
				<option value="13798">Y-亚洁</option>
				<option value="1148">Y-亚特</option>
				<option value="155">Y-烟工</option>
				<option value="425">Y-烟台瑞工</option>
				<option value="14112">Y-烟台信人</option>
				<option value="191">Y-洋马</option>
				<option value="13795">Y-业豪</option>
				<option value="13738">Y-一鼎重工</option>
				<option value="13803">Y-一帆机械</option>
				<option value="663">Y-一工机械</option>
				<option value="159">Y-一拖</option>
				<option value="13800">Y-依格曼</option>
				<option value="770">Y-宜工</option>
				<option value="680">Y-宜兴巍宇</option>
				<option value="161">Y-移山</option>
				<option value="13791">Y-亿龙机械</option>
				<option value="13801">Y-亿通正龙</option>
				<option value="1749">Y-忆辉</option>
				<option value="13792">Y-易山重工</option>
				<option value="13808">Y-益鑫</option>
				<option value="1751">Y-银锚建机</option>
				<option value="13232">Y-银起</option>
				<option value="13793">Y-英达</option>
				<option value="1777">Y-英轩重工</option>
				<option value="1930">Y-永安机械</option>
				<option value="647">Y-永工</option>
				<option value="843">Y-永茂</option>
				<option value="13806">Y-尤尼克</option>
				<option value="408">Y-友一</option>
				<option value="16327">Y-友一机械</option>
				<option value="562">Y-愚公机械</option>
				<option value="13802">Y-宇泰</option>
				<option value="143">Y-宇通重工</option>
				<option value="146">Y-玉柴</option>
				<option value="13796">Y-豫弘重工</option>
				<option value="13794">Y-原进</option>
				<option value="1152">Y-圆鑫建机</option>
				<option value="1092">Y-圆友</option>
				<option value="13799">Y-远东</option>
				<option value="13736">Y-远华机械</option>
				<option value="14238">Y-约翰迪尔</option>
				<option value="13797">Y-岳首</option>
				<option value="13804">Y-粤工</option>
				<option value="13807">Y-运想重工</option>
				<option value="13821">Z-泽通</option>
				<option value="195">Z-詹阳动力</option>
				<option value="1149">Z-章丘机械</option>
				<option value="13811">Z-浙江赤道</option>
				<option value="1119">Z-浙江建机</option>
				<option value="14220">Z-浙江振中</option>
				<option value="13817">Z-正泰</option>
				<option value="13816">Z-郑州鼎盛</option>
				<option value="813">Z-郑州富岛（川岛）</option>
				<option value="13824">Z-中材建科</option>
				<option value="13810">Z-中方机械</option>
				<option value="1582">Z-中国虎工</option>
				<option value="1214">Z-中国重汽</option>
				<option value="13819">Z-中海恒通</option>
				<option value="1219">Z-中环动力</option>
				<option value="1106">Z-中集华骏</option>
				<option value="13813">Z-中际</option>
				<option value="1951">Z-中建机械</option>
				<option value="542">Z-中交西筑</option>
				<option value="1780">Z-中联土方</option>
				<option value="134">Z-中联重科</option>
				<option value="553">Z-中龙建机</option>
				<option value="13820">Z-中青林</option>
				<option value="13812">Z-中升</option>
				<option value="1131">Z-中昇建机</option>
				<option value="1682">Z-中铁二十局</option>
				<option value="1151">Z-中文实业</option>
				<option value="13823">Z-中意</option>
				<option value="13815">Z-中誉鼎力</option>
				<option value="1161">Z-重庆中建机械</option>
				<option value="188">Z-竹内</option>
				<option value="185">Z-住友</option>
				<option value="13809">Z-筑马</option>
				<option value="13818">Z-钻通</option>
                
              </select>
              <select name="zd_product_id" id="zd_product_id" >
                <option>请选择型号</option>
              </select></td>
          </tr>
          <tr>
            <td align="right"><b>*</b>价格：</td>
            <td valign="top"><div class="xing" id="price_1"> </div>
              <span class="xing_tip">点击星星为该机型价格打分</span></td>
          </tr>
          <tr>
            <td align="right"><b>*</b>质量：</td>
            <td><div class="xing" id="zhiliang_1"> </div>
              <span class="xing_tip">点击星星为该机型质量打分</span></td>
          </tr>
          <tr>
            <td align="right"><b>*</b>性能：</td>
            <td><div class="xing" id="xingneng_1"> </div>
              <span class="xing_tip">点击星星为该机型性能打分</span></td>
          </tr>
          <tr>
            <td align="right"><b>*</b>售后：</td>
            <td><div class="xing" id="shouhou_1"> </div>
              <span class="xing_tip">点击星星为该机型售后打分</span></td>
          </tr>
          <tr>
            <td align="right" valign="top"><b>*</b>评价：</td>
            <td><textarea onfocus="<%	if(username.equals("")){ %>login();<%}%>" id="zd_content" name="zd_content"></textarea></td>
          </tr>
          <tr>
            <td height="56">&nbsp;</td>
            <td><span class="tip">10~2000个字之间，请针对用机感受、使用情况等方面进行评论，评论的内容需对其他用户有参考价值，并且真实原创。</span></td>
          </tr>
          <tr>
            <td align="right">上传图片：</td>
            <td><%	if(username.equals("")){ %>
              <img src="images/1_22.jpg" onclick="login();" width="77" height="30" />
              <%}else{%>
              <span id="addImgs"></span>
              <%}%></td>
          </tr>
          <tr>
            <td colspan="2" style="padding-left:182px; padding-top:10px;"><ul class="showpic clearfix" id="addImgs_show">
              </ul></td>

          <tr> </tr>
          
            <td height="39" class="td_bot"></td>
            <td class="td_bot">单张图片不超过10MB，尺寸不小于300*300px,支持jpg、png和bmp。</td>
          </tr>
          <tr>
            <td bgcolor="#f8fcfb">&nbsp;</td>
            <td align="left" bgcolor="#f8fcfb"><div style="position:relative">
                <blockquote>
                  <p>
                    <%	if(username.equals("")){ %>
                    <a href="javascript:void(0);" onclick="login();" class="ti_btn">提交评论</a>
                    <%}else{%>
                    <input style="background: url(/activity/koubei/images/ti2_btn.png);width: 273px;height: 53px;font: 0px a;letter-spacing: -7px;margin-left: 180px;margin-top: 5px;margin-bottom: 12px;border: 0;" onclick="doComments();" type="button" name="button" id="button" value="提交评论" class="ti_btn" />
                    <%}%>
                  </p>
                </blockquote>              
              </div></td>
          </tr>
        </table>
        <input type="hidden" name="tableName" id="tableName" value="pro_comments"/>
        <input type="hidden" name="zd_username" id="zd_username" value="<%=username %>"/>
        <input type="hidden" name="zd_userid" id="zd_userid" value="1"/>
        <input type="hidden" name="eventAfter" value="insertImages"/>
        <input type="hidden" name="zd_score1" id="score1" />
        <input type="hidden" name="zd_score2" id="score2" />
        <input type="hidden" name="zd_score3" id="score3" />
        <input type="hidden" name="zd_score4" id="score4" />
        <input type="hidden" name="zd_is_show" value="1" />
      </form>
</div>
</div>
<div class="kb_part kb_part05">
<div class="wrap">
<ul class="fix">
        <%
    	if(wajuejiList!=null){
    		for(Map m:wajuejiList){
    			String id = CommonString.getFormatPara(m.get("id"));
    			String file_name = CommonString.getFormatPara(m.get("file_name"));
    			String img2 = CommonString.getFormatPara(m.get("img2"));
    			String name = CommonString.getFormatPara(m.get("name"));
    			String factoryname = CommonString.getFormatPara(m.get("factoryname"));
    			String catalogname = CommonString.getFormatPara(m.get("catalogname"));
    %>
        <li><a href="http://koubei.21-sun.com/list/<%=id %>.htm" target="_blank" title="<%=factoryname+name+catalogname %>"><img src="/uploadfiles/<%=img2 %>" onerror="this.src='/uploadfiles/no_big.gif'" width="164" height="116"  alt="<%=factoryname+name+catalogname %>"/><strong><%=factoryname+name+catalogname %></strong></a></li>
        <%			
    		}
    	}
    %>
    <li><a href="http://koubei.21-sun.com/list/10110.htm" target="_blank" title="福田雷沃FR60挖掘机"><img src="http://koubei.21-sun.com/uploadfiles/image/2014/01/20140126094347_830.jpg" onerror="this.src='/uploadfiles/no_big.gif'" width="164" height="116" alt="福田雷沃FR60挖掘机"><strong>福田雷沃FR60挖掘机</strong></a></li>
        <%
    	if(zhuangzaijiList!=null){
    		for(Map m:zhuangzaijiList){
    			String id = CommonString.getFormatPara(m.get("id"));
    			String file_name = CommonString.getFormatPara(m.get("file_name"));
    			String img2 = CommonString.getFormatPara(m.get("img2"));
    			String name = CommonString.getFormatPara(m.get("name"));
    			String factoryname = CommonString.getFormatPara(m.get("factoryname"));
    			String catalogname = CommonString.getFormatPara(m.get("catalogname"));
    %>
        <li><a href="http://koubei.21-sun.com/list/<%=id %>.htm" target="_blank" title="<%=factoryname+name+catalogname %>"><img src="/uploadfiles/<%=img2 %>" onerror="this.src='/uploadfiles/no_big.gif'" width="164" height="116"  alt="<%=factoryname+name+catalogname %>"/><strong><%=factoryname+name+catalogname %></strong></a></li>
        <%			
    		}
    	}
    %>
      </ul>
</div>
</div>
<div class="kb_part kb_part06">
<div class="wrap"><p style="line-height:40px;width:600px;">产品询价专线：4006-521-526  <span><a href="http://www.21-sun.com" target="_blank">中国工程机械商贸网</a>Copyright © 2000-2014</span> <br>铁臂口碑要求发布的评论确系本人原创，严禁剽窃、转投他人评论，若因此引起任何法律纠纷，与铁臂口碑无关。</p></div>
</div>
<script>
<%if(memberInfo!=null){%>
$.getJSON("http://koubei.21-sun.com/action/sso.jsp?key=<%=username%>--<%=password%>--<%=CommonDate.getToday("yyyy-MM-dd")%>");
<%}%>
</script>
</body>

<div class="fixLayer">
  <a href="javascript:void(0)" onclick="share();"><img src="r2.png"/></a>
  <br>
  <a href="javascript:void(0)" id="gotop"><img src="r3.png"/></a>
  <br>
  <a href="javascript:void(0)"><img src="ewm_21.gif"/></a>
</div>
<!-- JiaThis Button BEGIN -->

<!-- JiaThis Button END -->
</html>
<script>
$('#gotop').click(function(){$('html,body').stop().animate({scrollTop:'0'},300)});
</script>


<script type="text/javascript" src="scripts/scroll-row.js"></script> 
<script type="text/javascript" src="/plugin/validator/rjboy/Validform_v5.3.1.js"></script> 
<script type="text/javascript" src="/plugin/dialog/jBox/jquery.jBox-2.3.min.js"></script> 
<script type="text/javascript" src="http://resource.21-sun.com/plugin/upload/jr_upload.js"></script> 
<script>
$.fn.inputholder=function(){
var dval=$(this).val();
$(this).focus(function(){
	$(this).val('').addClass('focus');
	}).blur(function(){
	if($(this).val()==''){
		$(this).val(dval).removeClass('focus');
		}
	});
};
var inputholder=$('.inputholder');
if(inputholder.length){
	inputholder.each(function() {
	  $(this).inputholder()
   })
};
	
var backUrl = '';
jQuery(function(){
	jQuery("#showLoginPasswd").val("密码") ;
	jQuery("#showLoginName").val("用户名") ;
	
	jQuery("#rem_pass").click(function(){//记住密码事件
		var remPass = jQuery("#rememberPass");
		if(remPass.attr("checked")=="checked"){
			remPass.removeAttr("checked");
			remPass.val("0");
		}else{
			remPass.attr("checked","checked");
			remPass.val("1");
		}
	});
	jQuery("#rememberPass").click(function(){//记住密码事件
		var remPass = jQuery(this);
		if(jQuery(this).attr("checked")=="checked"){
			remPass.attr("value","1");
		}else{
			remPass.attr("value","0");
		}
	});
})


</script>
<script language="javascript" type="text/javascript">

jQuery(function(){
	jQuery("#addImgs").JrUpload({
		remotUrl : "http://resource.21-sun.com/upload.jsp",
		folder : "product/koubei" ,
		sizeLimit:10*1024*1024, //10M
		multi : true,
		beforeCallback : "beforeCallback",
		callback : "setImgs" ,
		style : "width:98px;height:30px;",
		buttonImg : "http://product.21-sun.com/activity/koubei/images/1_22.jpg" ,
		buttonImgWidth : 77 ,
		buttonImgHeight : 30
	});
});
function beforeCallback(){
	$.jBox.tip("图片上传中，请稍后。。。", "loading");
}
function setImgs(data){
	var imgs = data.split(",");
	var htm = '';
	var f = 'http://resource.21-sun.com';
	for(var i=0;i<imgs.length;i++){
		htm += '<li><img class="img" src="'+f+imgs[i]+'" width="90" height="60" /><input type="hidden" name="img" value="'+f+imgs[i]+'" /><a href="javascript:void(0);" onclick="removeThis(this);" attrId="0" class="img_delete" style="position:absolute;top:-7px;left:80px;"><img src="http://member.21-sun.com/home/used/images/delete.png" /></a></li>';
	}
	jQuery("#addImgs_show").append(htm);
	regEvent();
	$.jBox.closeTip();
}
function regEvent(){
	jQuery("#addImgs_show>li").mouseover(function(){
		jQuery(".img_delete").hide();
		jQuery(this).find(".img_delete").show();
	});
	jQuery("#addImgs_show>li").mouseout(function(){
		jQuery(".img_delete").hide();
	});
}
function removeThis(o){
	var attrId = jQuery(o).attr("attrId")+"";
	if(attrId=='0'){
		jQuery(o).parent().remove();
	}else{
		if(confirm("确定删除该张图片吗？")){
			jQuery(o).parent().remove();
		}
	}
}
function regForm(){
	$.extend($.Datatype,{
		"b3" : /^[-\+]?\d{1,3}(\.\d{0,2})?$/
	});
		
	jQuery("#theform").Validform({

	 	tiptype : 4,
	 	ajaxPost : true,
		beforeCheck : function(){
			var catalog = $("#catalog").val();
			var a = '';
			if(catalog==a){
				alert("请选择产品类型！");
				return false;
			}
			var brand = $("#brand").val();
			var b = '';
			if(brand==b){
				alert("请选择品牌！");
				return false;
			}
			var product = $("#zd_product_id").val();
			var p = '';
			if(product==p){
				alert("请选择产品！");
				return false;
			}
			var price = jQuery("#price_1").raty("score");
			var xingneng = jQuery("#xingneng_1").raty("score");
			var zhiliang = jQuery("#zhiliang_1").raty("score");
			var shouhou = jQuery("#shouhou_1").raty("score");
			if(typeof(price)=="undefined"){
				alert("请您点击星星为该机型价格打分！");
				return false;
			}
			if(typeof(zhiliang)=="undefined"){
				alert("请您点击星星为该机型质量打分！");
				return false;
			}
			if(typeof(xingneng)=="undefined"){
				alert("请您点击星星为该机型性能打分！");
				return false;
			}
			if(typeof(shouhou)=="undefined"){
				alert("请您点击星星为该机型售后打分！");
				return false;
			}
			var content = $.trim($("#zd_content").val());
			var c = '';
			if(content==c){
				alert("请填写您的评价！");
				return false;
			}else if(content.length<10||content.length>1999){
				alert("请按要求填写您的评价！");
				return false;
			}
			var imgLength = jQuery("input[name=img]").length;
			//if(imgLength<1){
			//	alert("上传图片数量不足，请上传至少1张图片！");
			//	return false;
			//}
			
			jQuery("#score1").val(parseFloat(jQuery("#price_1").raty("score"),10)*20);
			jQuery("#score2").val(parseFloat(jQuery("#xingneng_1").raty("score"),10)*20);
			jQuery("#score3").val(parseFloat(jQuery("#zhiliang_1").raty("score"),10)*20);
			jQuery("#score4").val(parseFloat(jQuery("#shouhou_1").raty("score"),10)*20);
			return true;
		},
		beforeSubmit : function(){
			parent.$.jBox.tip("评论分享中，请稍后。。。","loading");
		},
	 	callback : function(json){
	 	 	alert("评论分享成功！");
	 	 	var pid = $("#zd_product_id").val();
	 	 	window.location = "http://koubei.21-sun.com/list/"+pid+".htm";
			//window.location.reload();
	 	}
 	});
}

//评论提交	
jQuery("#price_1,#xingneng_1,#zhiliang_1,#shouhou_1").raty({
	path: "/koubei/img",
	half : true ,
	score : 0
});
function chooseCatalog(v){
	var rand = Math.random();
	jQuery.ajax({
			url:'include/brands.jsp?r='+rand+'&v='+encodeURI(v),
			async:false,
			cache:false,
			success:function(data){
				jQuery("#brand").empty("");
				jQuery("#brand").append(jQuery.trim(data));
			}
		});
}
function chooseBrand(v){
	var rand = Math.random();
	var c = $.trim(jQuery("#catalog").val());
	var v = $.trim(jQuery("#brand").val());
	if(c!=""&&v!=""){
		jQuery.ajax({
			url:'include/products.jsp?r='+rand+'&v='+encodeURI(v)+'&c='+encodeURI(c),
			async:false,
			cache:false,
			success:function(data){
				jQuery("#zd_product_id").empty("");
				jQuery("#zd_product_id").append(jQuery.trim(data));
			}
		});
	}
	
}
$(function(){
	$('.pr_img img').on({
		"mouseenter":function(){						
			$(this).parent().parent().css('position','relative').find('.big_img').show();			
		},
		"mouseleave":function(){
			$(this).parent().parent().css('position','static').find('.big_img').hide();			
		}})
		$('#weixin').hover(function(){
			$('#weixin_img').show();
			},function(){
				$('#weixin_img').hide();
				})
})

function login() {
	jQuery.jBox.setDefaults({
		defaults : {
			border : 5
		}
	}); // 只修改全局 border
	jQuery.jBox("iframe:/activity/koubei/login.jsp?back=" + encodeURIComponent(document.URL), {
		border:5,
		title : null,
		opacity : 0.3,
		width : 620,
		top : '30%',
		height : 280,
		showClose:false,
		showIcon : false,
		iframeScrolling : 'no',
		id:'loginFrame',
		buttons : {}
	});
}

function logout(){
	jQuery.ajax({
		url:'/action/ajax.jsp?flag=logout&r='+new Date(),
		async:false,
		cache:false,
		success:function(data){
			jQuery.jBox.tip("您已退出登录！");
			setTimeout("window.location.reload()",1000);
		}
	});
}
function LoginToRegister(){//注册成功会自动登录并返回注册前页面
	window.parent.location.href = 'register.jsp';
}
function toRegist_for_return(){	
	parent.LoginToRegister();
	parent.jQuery.jBox.close('loginFrame');
}

//登录弹出
function doLogin(){
	jQuery.ajax({
		url:'/action/ajax.jsp?flag=login&r='+new Date()+'&u='+encodeURI(jQuery("#login_username").val())+'&p='+encodeURI(jQuery("#login_password").val()),
		async:false,
		cache:false,
		success:function(data){
			if($.trim(data)=="ok"){
				jQuery.jBox.tip("您已经成功登录！");
				setTimeout("parent.window.location.reload()",1000);
			}else if($.trim(data)=="no"){
				jQuery.jBox.tip("用户名或密码错误！");
			}else if($.trim(data)=="state0"){
				jQuery.jBox.tip("该用户已被禁用，请联系铁臂商城管理员！");
			}
		}
	});
}

jQuery(function(){
	jQuery("#rem_pass").click(function(){//记住密码事件
		var remPass = jQuery("#rememberPass");
		if(remPass.attr("checked")=="checked"){
			remPass.removeAttr("checked");
			remPass.val("0");
		}else{
			remPass.attr("checked","checked");
			remPass.val("1");
		}
	});
	jQuery("#rememberPass").click(function(){//记住密码事件
		var remPass = jQuery(this);
		if(jQuery(this).attr("checked")=="checked"){
			remPass.attr("value","1");
		}else{
			remPass.attr("value","0");
		}
	});
})

//登录首页
function doLoginIndex(){
	jQuery.ajax({
		url:'/action/ajax.jsp?flag=login&r='+new Date()+'&u='+encodeURI(jQuery("#showLoginName_index").val())+'&p='+encodeURI(jQuery("#showLoginPasswd_index").val()),
		async:false,
		cache:false,
		success:function(data){
			if($.trim(data)=="ok"){
				jQuery.jBox.tip("您已经成功登录！");
				setTimeout("parent.window.location.reload()",1000);
			}else if($.trim(data)=="no"){
				jQuery.jBox.tip("用户名或密码错误！");
			}else if($.trim(data)=="state0"){
				jQuery.jBox.tip("该用户已被禁用，请联系铁臂商城管理员！");
			}
		}
	});
}

jQuery(function(){
	jQuery("#showLoginPasswd_index").val("密码") ;
	jQuery("#showLoginName_index").val("用户名") ;
	jQuery("#rem_pass_index").click(function(){//记住密码事件
		var remPass = jQuery("#rememberPass_index");
		if(remPass.attr("checked")=="checked"){
			remPass.removeAttr("checked");
			remPass.val("0");
		}else{
			remPass.attr("checked","checked");
			remPass.val("1");
		}
	});
	jQuery("#rememberPass_index").click(function(){//记住密码事件
		var remPass = jQuery(this);
		if(jQuery(this).attr("checked")=="checked"){
			remPass.attr("value","1");
		}else{
			remPass.attr("value","0");
		}
	});
})

//评论提交
function doComments(){
			var catalog = $("#catalog").val();
			var a = '';
			if(catalog==a){
				alert("请选择产品类型！");
				return false;
			}
			var brand = $("#brand").val();
			var b = '';
			if(brand==b){
				alert("请选择品牌！");
				return false;
			}
			var product = $("#zd_product_id").val();
			var p = '';
			if(product==p){
				alert("请选择产品！");
				return false;
			}
			var price = jQuery("#price_1").raty("score");
			var xingneng = jQuery("#xingneng_1").raty("score");
			var zhiliang = jQuery("#zhiliang_1").raty("score");
			var shouhou = jQuery("#shouhou_1").raty("score");
			if(typeof(price)=="undefined"){
				alert("请您点击星星为该机型价格打分！");
				return false;
			}
			if(typeof(zhiliang)=="undefined"){
				alert("请您点击星星为该机型质量打分！");
				return false;
			}
			if(typeof(xingneng)=="undefined"){
				alert("请您点击星星为该机型性能打分！");
				return false;
			}
			if(typeof(shouhou)=="undefined"){
				alert("请您点击星星为该机型售后打分！");
				return false;
			}
			var content = $.trim($("#zd_content").val());
			var c = '';
			if(content==c){
				alert("请填写您的评价！");
				return false;
			}else if(content.length<10||content.length>1999){
				alert("请按要求填写您的评价！");
				return false;
			}

			
			jQuery("#score1").val(parseFloat(jQuery("#price_1").raty("score"),10)*20);
			jQuery("#score2").val(parseFloat(jQuery("#xingneng_1").raty("score"),10)*20);
			jQuery("#score3").val(parseFloat(jQuery("#zhiliang_1").raty("score"),10)*20);
			jQuery("#score4").val(parseFloat(jQuery("#shouhou_1").raty("score"),10)*20);

			jQuery("#theform").ajaxSubmit({
				type : "POST",
				async : false ,
				success : function(data){
			     if(jQuery.trim(data)=='no'){
				   alert("您输入的评价中含有敏感词，请重新输入") ;
				    jQuery("#content").val("") ;
		            jQuery("#content").focus() ; 
				   return ;
				}
						if(jQuery.trim(data)=='0'){
				   alert("评论失败") ;
 
				   return ;
				}
					alert("评论提交成功！");
                    setTimeout("window.location.reload()",1000);
				}					  
			});
		}


function goToCenter(){
window.open("http://product.21-sun.com/member/koubei.jsp");
}

function clear1(){
	jQuery("#showLoginName_index").val("") ;
}
function clear2(){
	jQuery("#showLoginPasswd_index").val("") ;

}
//分享
function share() {
window.open("http://sns.qzone.qq.com/cgi-bin/qzshare/cgi_qzshare_onekey?url=http://product.21-sun.com/activity/koubei2/&title=铁臂口碑活动——分享真实用机感受 - 铁臂口碑");
}


</script>

  <div style="display:none"><script src="http://s95.cnzz.com/stat.php?id=1253076868&web_id=1253076868" language="JavaScript"></script></div>