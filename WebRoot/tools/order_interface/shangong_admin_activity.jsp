<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.jerehnet.util.dbutil.DBHelper"%>
<%@page import="com.jerehnet.util.common.CommonString"%>
<%@page import="com.jerehnet.util.common.CommonDate"%>
<%@page import="com.jerehnet.mobile.sync.PushSyncActon"%>
<%@page import="org.codehaus.xfire.client.Client,com.jerehnet.util.common.Env,java.net.URL"%>
<%


	request.setCharacterEncoding("utf-8");
	DBHelper dbHelper = DBHelper.getInstance();
	String rs="";
		String name = CommonString.getFormatPara(request.getParameter("name")); 
		String mobile_phone = CommonString.getFormatPara(request.getParameter("tel")); 
		String province = CommonString.getFormatPara(request.getParameter("province")); // ʡ��
		String city = CommonString.getFormatPara(request.getParameter("city")); 
		
		String sql = " insert into special_21sun_shangong_order_msg (name,tel,province,city,add_date) values (?,?,?,?,?) ";
		dbHelper.execute(sql,new Object[]{name,mobile_phone,province,city,CommonDate.getToday("yyyy-MM-dd HH:mm:ss")});

		String url="https://www.semsms.cn/WebBusOppRec/Webservice.asmx?wsdl";
		
		StringBuffer xmlStr = new StringBuffer();
		xmlStr.append("<SG>");
		xmlStr.append("<OrderInfo>");
		xmlStr.append("<Contact>"+name+"</Contact>");
		xmlStr.append("<Tel>"+mobile_phone+"</Tel>");
		xmlStr.append("<AreaProv>"+province+"</AreaProv>");
		xmlStr.append("<AreaCity>"+city+"</AreaCity>");
		xmlStr.append("<Buyer>-</Buyer>");
		xmlStr.append("<EstDate>-</EstDate>");
		xmlStr.append("<PayType>-</PayType>");
		xmlStr.append("<Product>SEM680D</Product>");
		xmlStr.append("<Model>SEM680D</Model>");	
		xmlStr.append("<Desc>SEM680D促销</Desc>");
		xmlStr.append("<SourceCode>21-SUN-680DSP</SourceCode>");
		xmlStr.append("</OrderInfo>");
		xmlStr.append("</SG>");


		System.out.println(xmlStr);
		    
			Client client = new Client(new URL(url));
			Object [] s =  client.invoke("OrderReceive", new Object[]{xmlStr,"BA53779E-8E88-41DA-BD4D-0F65E51BA9FD"});
			if(s != null && s.length > 0){
				System.out.println(s);
				if(s[0].toString().indexOf("Y") > 0){
					rs="ok";
				}else{
					rs="fail";
				}
			} 

			out.println(rs);

	 

	

%>
