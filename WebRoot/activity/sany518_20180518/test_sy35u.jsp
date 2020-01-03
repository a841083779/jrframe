<%@ page language="java" import="org.apache.commons.httpclient.params.*,org.apache.commons.httpclient.*,org.apache.commons.httpclient.methods.*,com.jerehnet.webservice.*,java.util.regex.*,org.json.*,java.util.*,com.jerehnet.util.common.*,java.sql.*,com.jerehnet.util.dbutil.*,java.net.URLEncoder" pageEncoding="UTF-8"%>
<%
Connection connection = null;
DBHelper dbHelper = DBHelper.getInstance();

String openId= CommonString.getFormatPara(request.getParameter("sqopenid"));
String headimgurl= CommonString.getFormatPara(request.getParameter("headimgurl"));
String nickname= CommonString.getFormatPara(request.getParameter("nickname"));

Map secPro=null;
String secState="0";
String nowDate = CommonDate.getToday("yyyy-MM-dd") ;
int month=0;int day=0;
month=Integer.parseInt(nowDate.substring(5,7));
day=Integer.parseInt(nowDate.substring(8,10));
System.out.println(nowDate.substring(0,4)+";"+nowDate.substring(5,7)+";"+nowDate.substring(8,10));
Calendar cal1 = new GregorianCalendar(2018, 5, 18);
Calendar cal2 = new GregorianCalendar(2018, month, day);
int i=cal1.compareTo(cal2);
System.out.println("日期比较："+i);
try{
	connection = dbHelper.getConnection(); 	
	secPro=dbHelper.getMap(" select top 1 order_state from activity_sany_pay where product_id=21005 and open_id='"+openId+"' ",connection);
	if(secPro!=null){
		secState=CommonString.getFormatPara(secPro.get("order_state"));
	}
}catch(Exception e){
	e.printStackTrace();
}finally{
	DBHelper.freeConnection(connection);
}
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
		<title>SY35U微型挖掘机测评</title>
		<link rel="stylesheet" type="text/css" href="css/style.css"/>
		<style type="text/css">
			img{margin-bottom: .5rem !important;}
			.text_main p{text-indent: 2em;}
			.test .to_pay{position: fixed;}
			.test .title{line-height: .6rem;padding: .3rem .25rem;}
		</style>
	</head>
	<body class="test">
		<p class="title">无尾灵活 一年省3000元油钱——SY35U微型挖掘机测评</p>
		<div class="text_main">
			<p>“壮汉十八名，不如三一微挖一台”，这不仅仅是噱头，更是实际验证。2017年，三一组织开展了一项比拼，十八名壮汉与一台三一微挖进行挖树坑对比，三一微挖无论效率还是质量实现了完胜。而其中的主角便是三一SY35U微型挖掘机，在行业内掀起了机器代人、解放劳动生产力的新一轮探讨。</p>
			<p>作为三一微挖系列中的效率王代表，三一SY35U微型挖掘机无疑成为瞩目的焦点，其不仅获得中国设计红星奖，更在城市建设、园林绿化、农田水利工程等小型土方工程中表现出色，在用户群、机友群中的口碑非常之高！</p>
			<p>备受世人关注的SY35U，不仅是基于三一挖机的“高贵的血统”，更是得益于卓越的产品性能，“无尾灵活”与“高效低耗”共同成就了这款设备王的传奇！</p>
			<img src="images/351.png" />
			<p style="font-weight: bold;">一流核心配置，挖掘力大于同吨位品牌</p>
			<p>SY35U采用一流核心配置，原装进口的洋马3TNV88发动机，三缸四冲程直喷发动机，功率20.4kW/2200rpm，洋马发动机已经成为国内高端小挖的标配，劲儿大，稳定性更是出色。</p>
			<img src="images/352.png" />
			<p>同时，SY35U采用进口整套欧洲知名公司的液压系统，确保机器在恶劣工况下工作的可靠性，挖掘力大于同吨位品牌！</p>
			<p style="font-weight: bold;">尾部零回转，灵活穿行狭窄巷道</p>
			<p>SY35U底盘总宽1720mm，回转半径860mm，上车回转时，尾部不会超出履带，适合在狭窄工况工作。同时无尾设计，更是实现灵活穿行。</p>
			<img src="images/353.png" />
			<p>同时，SY35U带有可偏转装置，可以在左右进行偏转，在狭窄环境就可以不必挪动实现现场作业，节省时间，提升了工作效率。</p>
			<img src="images/354.png" />
			<p style="font-weight: bold;">高效低耗更省油，一年节省3000元油钱</p>
			<p>SY35U采用负载敏感流量分配系统，能根据系统对流量的需要提供和分配流量，满足执行元件调速和复合动作要求。比竞争机型油耗低9.2%以上，效率高3.3%以上，一年轻轻松松节省近3000元油钱！</p>
			<img src="images/355.png"/>
			<p style="font-weight: bold;">结构件加强设计，皮实耐用故障少</p>
			<p>SY35U铲斗背面及侧面都设计有防磨板，增大了工作强度；斗杆内外部加强焊缝，从容面对极端工况，采用比竞争对手更大的截面形状，刚性更好，提高动臂抗变形能力。</p>
			<img src="images/356.png"/>
			<p>SY35U铲斗背面及侧面都设计有防磨板，增大了工作强度，也提升了铲斗使用寿命！</p>
			<img src="images/357.png"/>
			<p style="font-weight: bold;">加强型四轮一带，坚固可靠使用寿命长</p>
			<p>四轮一带方面，SY35U设计了四个支重轮和一个托链轮，用支重轮代替托链轮，采用双边安装方式，改善了受力条件，结构更结实。</p>
			<img src="images/358.png"/>
			<p style="font-weight: bold;">零部件触手可及，维修保养方便又快捷</p>
			<p>采用大面积覆盖件开启方式，打开后可站在地面进行日常维护和保养。空气滤清器、燃油滤、机油滤触手可及，保养十分方便。</p>
			<img src="images/359.png"/>
			<p style="font-weight: bold;">驾乘舒适，操作简便</p>
			<p>“麻雀虽小，五脏俱全”，SY35U微挖虽然小巧，但其驾驶室依旧有着许多人性化设计，以充分减少机手的驾驶疲劳，座椅可调，符合更多机手身形，在右手操控平台， 集中了启动开关、油门、雨刷控制、灯光控制、收音机、空调开关灯，高集成度，操作更便捷。</p>
			<img src="images/3510.png"/>
			<img src="images/3511.png"/>
			<p>随着城镇化的推进，作为微挖代表，SY35U如今已经成为很多用户创业的优先选择，价格适中，适用度高，使其已经成为微挖的无冕之王！2018年5月，三一与中国工程机械商贸网独家合作，正式开启了直销模式，限时秒杀，23.8万，更有多重好礼相送！</p>
			
			
			
			
			
			
		</div>
		
		<div class="to_pay">
				<% 
				if(secState.equals("0")){
				%>
				<a href="pay.jsp?productId=21005&productName=SY35U&productImg=http://product.21-sun.com/activity/sany518/images/machine2_07.jpg&headUrl=<%=headimgurl%>&nickName=<%=nickname%>&openId=<%=openId%>" >预售 ￥200 定金可退</a>
				<%}else if(secState.equals("1")&& i > 0 ){ %>
				<a style="background-color: #ddd;">定金 ￥1800 定金可退</a>
				<%}else if(secState.equals("2")&& i <= 0){ %>
				<a href="pay.html" >定金 ￥1800 定金可退</a>
				<%} %>
		</div>
		
	</body>
	<script src="js/module/jquery-1.10.2.min.js" type="text/javascript" charset="utf-8"></script>
	<script src="js/test.js" type="text/javascript" charset="utf-8"></script>
</html>
