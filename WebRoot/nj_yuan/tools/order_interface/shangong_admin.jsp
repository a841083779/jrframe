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
<%@page import="com.jerehnet.webservice.WEBEmail"%>
<%@page import="com.jerehnet.mobile.sync.PushSyncActon"%>
<%@page import="com.jerehnet.util.common.*"%>

<%@page import="org.codehaus.xfire.client.Client,com.jerehnet.util.common.Env,java.net.URL"%>
<% 
    int statusCode=0;
	request.setCharacterEncoding("utf-8");
	DBHelper dbHelper = DBHelper.getInstance();
	System.out.println("����");
	String uuid = CommonString.getFormatPara(request.getParameter("uuid"));
	Map one_proform = dbHelper.getMap("  select  * from pro_product_form where uuid='" + uuid + "' ");
	if(one_proform !=null && one_proform.get("id") != null){
		String id = CommonString.getFormatPara(one_proform.get("id"));
		String name = CommonString.getFormatPara(one_proform.get("name"));                   //��ϵ�� ������
		String mobile_phone = CommonString.getFormatPara(one_proform.get("mobile_phone"));   //��ϵ�绰
		String message = CommonString.getFormatPara(one_proform.get("message"));           //ѯ������
		String province = CommonString.getFormatPara(one_proform.get("province")).trim(); // ʡ��
		String city = CommonString.getFormatPara(one_proform.get("city"));              //����
		String buy_time = CommonString.getFormatPara(one_proform.get("buy_time")).trim(); 
		if(!buy_time.equals("")){
		   if(buy_time.equals("102007")){buy_time="1������";}
		   else if(buy_time.equals("102001")){buy_time="1������";}
		   else if(buy_time.equals("102002")){buy_time="1��3����";}
		   else if(buy_time.equals("102003")){buy_time="4��6����";}
		   else if(buy_time.equals("102004")){buy_time="7��12����";}
		   else if(buy_time.equals("102005")){buy_time="1���";}
		   else if(buy_time.equals("102006")){buy_time="��ȷ��";}
		   else{buy_time="��ȷ��";}
		}else{
			buy_time="��ȷ��";
		}
	
		String cataname = CommonString.getFormatPara(one_proform.get("cataname"));   //��Ʒ����
		String product_name = CommonString.getFormatPara(one_proform.get("product_name")); // ��Ʒ���� 
		String add_date = CommonDate.getFormatDate("yyyy-MM-dd HH:mm:ss",one_proform.get("add_date")); 
		String catanum = CommonString.getFormatPara(one_proform.get("catanum"));
		String buy_type = CommonString.getFormatPara(one_proform.get("buy_type"));
		if(buy_type.equals("")){buy_type="-";}


		HttpClient httpClient = new HttpClient(); 
		PostMethod postMethod = new UTF8PostMethod("http://222.132.48.38:90/orders/interfaces/order"); 
		postMethod.setRequestHeader(new Header("Order-Source-Code", "21-SUN")); 
		postMethod.setRequestHeader(new Header("Order-Source-Auth-Code", "A1BC06869ECE44C9859CAC2B46EE6FA6")); 
		NameValuePair[] arr = new NameValuePair[10]; 
		List<NameValuePair> formParams = new ArrayList<NameValuePair>(); 
		formParams.add(new NameValuePair("CONTACT", name)); 
		formParams.add(new NameValuePair("TEL", mobile_phone)); 
		formParams.add(new NameValuePair("AREA_PROV", province)); 
		formParams.add(new NameValuePair("AREA_CITY", city)); 
		formParams.add(new NameValuePair("BUYER", "-")); 
		formParams.add(new NameValuePair("PRODUCT", cataname)); 
		formParams.add(new NameValuePair("MODEL", product_name)); 
		formParams.add(new NameValuePair("DESC", message)); 
		formParams.add(new NameValuePair("PAY_TYPE", buy_type)); 
		formParams.add(new NameValuePair("EST_DATE", "-")); 
		postMethod.addParameters(formParams.toArray(arr)); 
		statusCode = httpClient.executeMethod(postMethod); 
	
								
		if(statusCode==200){
		String upSql = " update pro_product_form set is_success = 1 where uuid = '"+uuid+"' ";
		dbHelper.execute(upSql);	
		}else{		
		}
		


	}
	out.println(statusCode);
%>
