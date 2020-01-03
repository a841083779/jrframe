<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.jerehnet.util.dbutil.DBHelper"%>
<%@page import="com.jerehnet.util.common.CommonString"%>
<%@page import="com.jerehnet.util.common.CommonDate"%>
<%@page import="com.jerehnet.mobile.sync.PushSyncActon"%>
<%@page import="org.codehaus.xfire.client.Client,com.jerehnet.util.common.Env,java.net.URL"%>
<script type="text/javascript" src="/scripts/jquery-1.7.min.js"></script>
<%
	request.setCharacterEncoding("utf-8");
	DBHelper dbHelper = DBHelper.getInstance();
	
		String url="http://59.110.91.92/MDBWebRegWebSrv.asmx?wsdl";
		String token="cb9df9a21299438bb885528b98edec9b";
		
		StringBuffer xmlStr = new StringBuffer();
		xmlStr.append("<Cat>");
		xmlStr.append("<UserInfo>");
		
		xmlStr.append("<UserID>10031</UserID>");
		xmlStr.append("<Name>test</Name>");
		xmlStr.append("<Gender>男</Gender>");
		xmlStr.append("<Mobile>18615008719</Mobile>");
		xmlStr.append("<Telephone>6657338</Telephone>");
		xmlStr.append("<Company>jerei</Company>");
		xmlStr.append("<Position>经理</Position>");
		xmlStr.append("<Province>山东</Province>");
		xmlStr.append("<City>烟台</City>");
		xmlStr.append("<Birthday>1980-01</Birthday>");
		xmlStr.append("<PurchasePeriod>30</PurchasePeriod>");
		xmlStr.append("<ExcavatorSize>99</ExcavatorSize>");
		xmlStr.append("<ExcavatorModel>320</ExcavatorModel>");
		xmlStr.append("<AgreeContact>Y</AgreeContact>");
		xmlStr.append("<OrderMessage>我想购买卡特挖掘机</OrderMessage>");
		xmlStr.append("<RegDate>2017-03-06</RegDate>");
		xmlStr.append("<RegisterType>询价</RegisterType>");
		xmlStr.append("<MediaSource>21sun</MediaSource>");
		xmlStr.append("<DataSource>360-ADVANTAGE-FUEL-GUARANTEE-21SUN</DataSource>");
		xmlStr.append("<DataSourceCode>CG0102</DataSourceCode>");
		xmlStr.append("</UserInfo>");
		xmlStr.append("</Cat>");
		
			Client client = new Client(new URL(url));
			Object [] s =  client.invoke("UserinfoDataReceive", new Object[]{xmlStr,1,"cb9df9a21299438bb885528b98edec9b"});
			String upSql = "";
			if(s != null && s.length > 0){
				out.println("s========"+s[0].toString());
			} 
			 	
	
	

%>
