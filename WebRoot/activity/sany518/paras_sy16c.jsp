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
		<title>三一SY16C微型液压挖掘机参数</title>
		<link rel="stylesheet" type="text/css" href="css/swiper.min.css"/>
		<link rel="stylesheet" type="text/css" href="css/style.css"/>
	</head>
	<body class="paras pr">
		
		<div class="header fix">
			<a href="javascript:void(0);" class="l"><img src="images/logo_01.jpg"/></a>
			<img src="images/line.jpg" class="l"/>
			<a href="javascript:void(0);" class="l"><img src="images/logo_03.jpg"/></a>
		</div>
		
		<div class="detail_show">
			<div class="ds_con">
				<div class="swiper-wrapper">
					<div class="swiper-slide"><img src="images/16show.jpg"/></div>
				</div>
			</div>
		</div>
		
		<div class="mac_name">三一SY16C微型液压挖掘机</div>
		
		<div class="paras_main pa">
			<div class="section">
				<div class="section_header">整机尺寸</div>
				<div class="section_body">
					<ul>
						<li class="fix">
							<p class="l">总长度</p>
							<p class="l">3575</p>
						</li>
						<li class="fix">
							<p class="l">总宽度</p>
							<p class="l">980/1350</p>
						</li>
						<li class="fix">
							<p class="l">总高度（至动臂顶部）</p>
							<p class="l">2420</p>
						</li>
						<li class="fix">
							<p class="l">最小离地间隙</p>
							<p class="l">180</p>
						</li>
						<li class="fix">
							<p class="l">尾部回转半径</p>
							<p class="l">920</p>
						</li>
						<li class="fix">
							<p class="l">履带长度</p>
							<p class="l">1585</p>
						</li>
						<li class="fix">
							<p class="l">履带接地长度</p>
							<p class="l">1225</p>
						</li>
						<li class="fix">
							<p class="l">履带宽度</p>
							<p class="l">230</p>
						</li>
					</ul>
				</div>
			</div>
			<div class="section">
				<div class="section_header">作业范围</div>
				<div class="section_body">
					<ul>
						<li class="fix">
							<p class="l">最大挖掘高度</p>
							<p class="l">3665</p>
						</li>
						<li class="fix">
							<p class="l">最大卸载高度</p>
							<p class="l">2635</p>
						</li>
						<li class="fix">
							<p class="l">最大挖掘深度</p>
							<p class="l">2360</p>
						</li>
						<li class="fix">
							<p class="l">最大垂直挖掘深度</p>
							<p class="l">2215</p>
						</li>
						<li class="fix">
							<p class="l">最小回转半径</p>
							<p class="l">1655</p>
						</li>
					</ul>
				</div>
			</div>
			<div class="section">
				<div class="section_header">主要性能</div>
				<div class="section_body">
					<ul>
						<li class="fix">
							<p class="l">工作重量</p>
							<p class="l">1850</p>
						</li>
						<li class="fix">
							<p class="l">标准铲斗容量</p>
							<p class="l">0.04</p>
						</li>
						<li class="fix">
							<p class="l">铲斗最大挖掘力</p>
							<p class="l">15.2</p>
						</li>
						<li class="fix">
							<p class="l">斗杆最大挖掘力</p>
							<p class="l">9.2</p>
						</li>
						<li class="fix">
							<p class="l">回转速度</p>
							<p class="l">10</p>
						</li>
						<li class="fix">
							<p class="l">爬坡能力</p>
							<p class="l">58%/30°</p>
						</li>
						<li class="fix">
							<p class="l">行走速度（高/中/低）</p>
							<p class="l">3.7/2.1</p>
						</li>
						<li class="fix">
							<p class="l">接地比压</p>
							<p class="l">29.1</p>
						</li>
					</ul>
				</div>
			</div>
			<div class="section">
				<div class="section_header">发动机</div>
				<div class="section_body">
					<ul>
						<li class="fix">
							<p class="l">额定功率</p>
							<p class="l">10.3</p>
						</li>
						<li class="fix">
							<p class="l">额定转速</p>
							<p class="l">2200</p>
						</li>
					</ul>
				</div>
			</div>
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
	<script src="js/module/swiper-4.2.2.min.js" type="text/javascript" charset="utf-8"></script>
	<script src="js/paras.js" type="text/javascript" charset="utf-8"></script>
</html>
