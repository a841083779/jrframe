<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.jerehnet.util.dbutil.DBHelper"%>
<%@page import="com.jerehnet.util.common.CommonString"%>
<%@page import="com.jerehnet.util.common.CommonDate"%>
<%@page import="com.jerehnet.util.common.Common"%>
<%@page import="org.apache.commons.httpclient.HttpClient"%>
<%@page import="org.apache.commons.httpclient.Header"%>
<%@page import="org.apache.commons.httpclient.HttpStatus"%>
<%@page import="org.apache.commons.httpclient.NameValuePair"%>
<%@page import="org.apache.commons.httpclient.methods.PostMethod"%>
<%@page import="com.jerehnet.util.common.*"%>

<%@page import="org.codehaus.xfire.client.Client,com.jerehnet.util.common.Env,java.net.URL"%>
<%
	request.setCharacterEncoding("utf-8");
	DBHelper dbHelper = DBHelper.getInstance();
	String uuid = CommonString.getFormatPara(request.getParameter("uuid"));
	Map one_proform = dbHelper.getMap("  select  * from pro_product_form where uuid='" + uuid + "' ");
	if(one_proform !=null && one_proform.get("id") != null){
		//String id = CommonString.getFormatPara(one_proform.get("id"));
		String name = CommonString.getFormatPara(one_proform.get("name"));                   //联系人 购买人
		String mobile_phone = CommonString.getFormatPara(one_proform.get("mobile_phone"));   //联系电话
		String message = CommonString.getFormatPara(one_proform.get("message"));           //询价内容
		String province = CommonString.getFormatPara(one_proform.get("province")).trim(); // 省份
		String city = CommonString.getFormatPara(one_proform.get("city"));              //城市
		String buy_time = CommonString.getFormatPara(one_proform.get("buy_time")); 
		String cataname = CommonString.getFormatPara(one_proform.get("cataname"));   //产品类型
		String product_name = CommonString.getFormatPara(one_proform.get("product_name")); // 产品名字 
		String add_date = CommonDate.getFormatDate("yyyy-MM-dd HH:mm:ss",one_proform.get("add_date")); 
		String catanum = CommonString.getFormatPara(one_proform.get("catanum"));
		
		System.out.println("输出:"+name+"--"+mobile_phone+"--"+message+province+city+buy_time+cataname+product_name+add_date+catanum);
		HttpClient httpClient = new HttpClient(); 
        PostMethod postMethod = new UTF8PostMethod("http://222.132.48.38:90/orders/interfaces/order"); 
        postMethod.setRequestHeader(new Header("Order-Source-Code", "21-SUN")); 
        postMethod.setRequestHeader(new Header("Order-Source-Auth-Code", "A1BC06869ECE44C9859CAC2B46EE6FA6")); 
        postMethod.addParameter("CONTACT", name); 
        postMethod.addParameter("TEL", mobile_phone); 
        postMethod.addParameter("AREA_PROV", province); 
        postMethod.addParameter("AREA_CITY", city); 
        postMethod.addParameter("BUYER", name); 
		postMethod.addParameter("PRODUCT", cataname); 
		postMethod.addParameter("MODEL", product_name); 
		postMethod.addParameter("DESC ", message); 
		postMethod.addParameter("PAY_TYPE", "1"); 
		postMethod.addParameter("EST_DATE", "2014-01-01"); 
        int statusCode = httpClient.executeMethod(postMethod); 
		System.out.println("测试"+statusCode);

		
	


	}
	out.println("ok");
%>
