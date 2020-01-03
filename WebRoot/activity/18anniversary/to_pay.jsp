<%@ page language="java" import="org.apache.commons.httpclient.params.*,org.apache.commons.httpclient.*,org.apache.commons.httpclient.methods.*,com.jerehnet.webservice.*,java.util.regex.*,org.json.*,java.util.*,com.jerehnet.util.common.*,java.sql.*,com.jerehnet.util.dbutil.*,java.text.SimpleDateFormat,java.util.Date" pageEncoding="UTF-8"%>
<%@page import="com.jerehnet.alipay.util.*,com.jerehnet.wxpay.*"%>
<%@ page import="java.util.*,java.io.*,java.net.*"%>
<%@page import="com.jerehnet.wxpay.WXPayConstants.SignType" %>
<%@page import="com.jerehnet.alipay.util.*" %>
<%
	Connection connection = null;
	DBHelper dbHelper = DBHelper.getInstance();
	int id = CommonString.getFormatInt(CommonString.getFormatPara(request.getParameter("id")));
	double money = Double.parseDouble(CommonString.getFormatPara(request.getParameter("money")));
	
	String path= "http://" + request.getServerName()+":"+request.getServerPort()+ request.getContextPath() + request.getServletPath(); 
	System.out.println(path);
	String ua = ((HttpServletRequest) request).getHeader("user-agent").toLowerCase();
    if (ua.indexOf("micromessenger")==-1) {// 是微信浏览器
		response.sendRedirect("noweixin.jsp");
		return;
	}

     String openId= CommonString.getFormatPara(request.getParameter("sqopenid"));
	String headimgurl= CommonString.getFormatPara(request.getParameter("headimgurl"));
	String nickname= CommonString.getFormatPara(request.getParameter("nickname"));
    String  uid = CommonString.getFormatPara(session.getAttribute("wx_id"));
	
	if(uid==null||uid.equals("")){
		if(openId==null||openId.equals("")){
			String url=request.getScheme()+"://"+request.getHeader("host")+request.getRequestURI();  
			String paramsStr=request.getQueryString();
			if(paramsStr!=null&&!paramsStr.equals("")){
				url+="?"+request.getQueryString();
			}
			String enurl=URLEncoder.encode(url);
			response.sendRedirect("http://xxlfront.jerei.com/auth_head_tt.jsp?back="+enurl);//


			return;
		}else{
			session.setAttribute("wxImg", headimgurl); 
			session.setAttribute("wx_id", openId); 
			session.setAttribute("nickname", nickname); 
			response.sendRedirect(path);
		}
	}else{
		openId= CommonString.getFormatPara(session.getAttribute("wx_id"));
		headimgurl= CommonString.getFormatPara(session.getAttribute("wxImg"));
		nickname= CommonString.getFormatPara(session.getAttribute("nickname"));
	}
	
//String openId="oBp9ht3rNMXKkbz1c8tln69uxiqQ";	
//String headimgurl=	"http://thirdwx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTLJ55iasmMeibRRNT9RgVm0ZIzWrDXdho1QrsASlh1wNttOPW0ziarZibLvsjvcyicANSkq9K1JibvdMrgQ/132";
//String nickname="老衲";

Map model = null;
String title="",img="";
double price=0.00,nowPrice=0.00;
try{
	connection = dbHelper.getConnection();
	model = dbHelper.getMap(" select img,title,original_price,now_price from anniversary18_ad where id = ? ",new Object[]{id},connection);
	if(model!=null){
		title = CommonString.getFormatPara(model.get("title"));
		img =  CommonString.getFormatPara(model.get("img"));
		price = Double.parseDouble(CommonString.getFormatPara(model.get("original_price")));
		nowPrice = Double.parseDouble(CommonString.getFormatPara(model.get("now_price")));
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
		<title>支付页面</title>
		<link rel="stylesheet" type="text/css" href="css/style.css"/>
	</head>
	<body class="to_pay">
		
		<div class="line"></div>
		
		<div class="mes fix">
			<div class="item_img l">
				<img src="<%=img %>"/>
			</div>
			<div class="item_des l">
				<div class="item_name"><%=title%></div>
				<%
				if(id==19 || id==20){
				%>
				<div class="item_pro">原价：<%=price%>元/年</div>
				<div class="item_cost">现价：<span><%=nowPrice%></span><span>元/年</span></div>
				<%
				}
				%>
			</div>
		</div>
		
		<div class="price">
			<p class="price_title">应付金额</p>
			<p class="price_main"><span>￥</span><%=money %>元</p>
		</div>
		
		<div class="input_box">
			<p class="tip">请输入您的真实姓名和电话。</p>
			<div class="box fix">
				<p class="">姓名：</p>
				<input class="" type="text" name="name" id="name" />
			</div>
			<div class="box fix">
				<p class="">电话：</p>
				<input class="" type="text" name="tel" id="tel"/>
			</div>
		</div>
		<input id="adId" name="adId" type="hidden" value="<%=id%>"/>
		<input id="adTitle" name="adTitle" type="hidden" value="<%=title%>"/>
		<input id="money" name="money" type="hidden" value="<%=money%>"/>
		<input id="openId" name="openId" type="hidden" value="<%=openId%>"/>
		
		<a  class="pay_btn">去支付</a>
		
		<!--提示-->
		<div class="tip_mask hide">
			<div class="tip_all">
				<p class="el alert"></p>
				<a href="javascript:void(0);" class="close_it">
					<img src="images/close.png"/>
				</a>
			</div>
		</div>
	</body>
	<script src="js/module/jquery-1.10.2.min.js" type="text/javascript" charset="utf-8"></script>
	<script src="js/to_pay.js" type="text/javascript" charset="utf-8"></script>
</html>
