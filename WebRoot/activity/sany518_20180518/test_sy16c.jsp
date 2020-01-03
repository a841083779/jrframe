<%@ page language="java" import="org.apache.commons.httpclient.params.*,org.apache.commons.httpclient.*,org.apache.commons.httpclient.methods.*,com.jerehnet.webservice.*,java.util.regex.*,org.json.*,java.util.*,com.jerehnet.util.common.*,java.sql.*,com.jerehnet.util.dbutil.*,java.net.URLEncoder" pageEncoding="UTF-8"%>
<%
Connection connection = null;
DBHelper dbHelper = DBHelper.getInstance();

String openId= CommonString.getFormatPara(request.getParameter("sqopenid"));
String headimgurl= CommonString.getFormatPara(request.getParameter("headimgurl"));
String nickname= CommonString.getFormatPara(request.getParameter("nickname"));

Map firstPro=null;
String firstState="0";
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
	firstPro=dbHelper.getMap(" select top 1 order_state from activity_sany_pay where product_id=21004 and open_id='"+openId+"' ",connection);
	if(firstPro!=null){
		firstState=CommonString.getFormatPara(firstPro.get("order_state"));
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
		<title>SY16C迷你挖掘机测评</title>
		<link rel="stylesheet" type="text/css" href="css/style.css"/>
		<style type="text/css">
			img{margin-bottom: .5rem !important;}
			.text_main p{text-indent: 2em;}
			.test .to_pay{position: fixed;}
			.test .title{line-height: .6rem;padding: .3rem .25rem;}
		</style>
	</head>
	<body class="test">
		<p class="title">园林绿化专用 行动灵活更皮实——SY16C迷你挖掘机测评</p>
		<div class="text_main">
			<p>近年来，小型挖掘机，尤其是迷你挖掘机在市政工程、农田水利等施工中发挥了越来越显著的优势，为节省人力、物力做出了较大贡献，在狭窄的工作空间内能够最大限度发挥其生产能力。</p>
			<p>对于中国工程机械行业而言，三一小型挖掘机已经成为了畅销的明星产品，其中推出的全新园林绿化专用挖掘机——SY16C行动灵活，皮实耐用，最重要的是能省油的好机器，诠释了最小微型挖掘机性能特点——挖掘工作稳定可靠、配置高，性能优越，油耗低，外观漂亮，用途广。</p>
			<img src="images/161.png" />
			<p style="font-weight: bold;">适合范围</p>
			<p>蔬菜大棚的土地疏松，市政部门的园林绿化、果园苗圃栽树挖坑，混凝土路面破碎，砂石料搅拌，狭小空间的施工作业，使用快速更换接头，降低维护和作业成本，提高机械化程度，投资小，回报高。如今，此款产品三一与中国工程机械商贸网合作，采用网络直销模式，售价仅15.8万，更有多重好礼相送。</p>
			<img src="images/162.png"/>
			<p style="font-weight: bold;">专供动力 高效节能</p>
			<p>在动力系统方面，三一挖掘机采用三一专用洋马EPA INT环保发动机、CASAPPA主泵、Walvoil主阀、NACHI回转、NACHI行走，配置均为同级别中的佼佼者。原装进口发动机匹配负载敏感液压系统，结合自主研发的功率匹配调试技术，SY16C将迷你挖掘机高效节能发挥到了极致。</p>
			<img src="images/163.png"/>
			<p>同时，SY16C采用独创的SLSS液压系统，实现了发动机与主泵的完美匹配，能最大程度的利用发动机的输出功率，油耗更低，提升作业效率。</p>
			<p style="font-weight: bold;">加强型设计 性能更稳定</p>
			<p>作为迷你挖掘机代表，SY16C却再各部件进行了加强设计，加强型工作装置及高强度回转平台，整机性能更稳定；加强型工作装置和车架，基于ANSYS平台，优化结构，减少应力集中，平均寿命延长30%。</p>
			<p>SY16C挖掘机的铲斗底部设计有漏水孔，斗齿设计了三个，用料是非常充足的。</p>
			<img src="images/164.png"/>
			<img src="images/165.png"/>
			<p>同时，SY16C挖掘机大小臂，可以看到在大小臂连接处做了加强的设计，而耐磨铲斗也增强了设备的作业效率与使用寿命。</p>
			<p style="font-weight: bold;">出色工作效率 卓越性价比</p>
			<p>SY16C采用人体工程学原理设计，致使每个操纵按钮都在驾驶员伸手可及的范围之内；可实现钢履带和橡胶履带的互换，可直接在公路上行走，满足各种工况需求。</p>
			<img src="images/166.png"/>
			<p>SY16C可偏转动臂，可偏转工作装置范围为：左偏595mm，右转350mm，两边都能轻松挖到履带外边缘，可在墙边墙角等空间限制位置作业。</p>
			<img src="images/167.png"/>
			<p style="font-weight: bold;">保养便捷 驾驶室多选更舒适</p>
			<p>SY16C维护保养便捷 所有的电器元件均采取集中布置设计，而且重要部件非常容易靠近作业；日常保养位置集中在机器后部，打开后机罩即可接触到空滤、燃油滤等，保养维护方便。</p>
			<img src="images/168.png"/>
			<img src="images/169.png"/>
			<p>SY16C由于驾驶室内部按人体工程学原理设计，致使每个操纵按钮都在驾驶员伸手可及的范围之内，驾驶室底部采用先进的硅油橡胶安装座，防振效果更佳;座椅可全方位调整，操纵箱可以在二级轨道上移动到最理想的位置。</p>
			<p>同时，驾驶室内设有大功率冷暖空调，冬暖夏凉，舒适宜人。整机视野开阔，驾驶室的天窗还可以打开，前窗可以向上翻至顶部,后窗可提供后方和两侧良好的视野。而为了避免显示屏反光对可视性的影响，控制面板还可以向内侧倾斜移动。</p>
			<p>SY16C作为三一迷你挖掘机代表，其品质、性能已经得到了充分验证，是一款针对园林绿化、农田水利等小型工程的专用机械，在城镇化日益推进的现在，相信会得到更多的青睐。</p>
		</div>
		
		<div class="to_pay">
				<% 
				if(firstState.equals("0")){
				%>
				<a href="pay.jsp?productId=21004&productName=SY16C&productImg=http://product.21-sun.com/activity/sany518/images/machine1_03.jpg&headUrl=<%=headimgurl%>&nickName=<%=nickname%>&openId=<%=openId%>" >预售 ￥200 定金可退</a>
				<%}else if(firstState.equals("1")&& i > 0 ){ %>
				<a style="background-color: #ddd;">定金 ￥1800 定金可退</a>
				<%}else if(firstState.equals("2")&& i <= 0){ %>
				<a href="pay.html" >定金 ￥1800 定金可退</a>
				<%} %>
		</div>
		
	</body>
	<script src="js/module/jquery-1.10.2.min.js" type="text/javascript" charset="utf-8"></script>
	<script src="js/test.js" type="text/javascript" charset="utf-8"></script>
</html>
