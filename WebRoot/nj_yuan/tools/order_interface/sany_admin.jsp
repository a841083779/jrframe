<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.jerehnet.util.dbutil.DBHelper"%>
<%@page import="com.jerehnet.util.common.CommonString"%>
<%@page import="com.jerehnet.util.common.CommonDate"%>
<%@page import="org.codehaus.xfire.client.Client,com.jerehnet.util.common.Env,java.net.URL"%>
<%
	request.setCharacterEncoding("utf-8");
	DBHelper dbHelper = DBHelper.getInstance();
	String uuid = CommonString.getFormatPara(request.getParameter("uuid"));
	Map one_proform = dbHelper.getMap("  select  * from pro_product_form where uuid='" + uuid + "' ");
	String result="fail";
	String catanum="";
	if(one_proform !=null && one_proform.get("id") != null){
		String id = CommonString.getFormatPara(one_proform.get("id"));
		String name = CommonString.getFormatPara(one_proform.get("name")); 
		String add_ip = CommonString.getFormatPara(one_proform.get("add_ip"));
		if(add_ip.equals("")){
			add_ip="119.180.98.134";
		}
		String mobile_phone = CommonString.getFormatPara(one_proform.get("mobile_phone")); 
		String company = CommonString.getFormatPara(one_proform.get("company")).equals("公司名字")?"":CommonString.getFormatPara(one_proform.get("company")); 
		String province = CommonString.getFormatPara(one_proform.get("province")).trim(); // 省份
		String city = CommonString.getFormatPara(one_proform.get("city")); 
		String buy_time = CommonString.getFormatPara(one_proform.get("buy_time")); 
		catanum = CommonString.getFormatPara(one_proform.get("catanum"));
		if(catanum.indexOf("103")>=0){catanum="103";}
		//if(catanum.equals("")){catanum="";}
		if(catanum.equals("120")){catanum="116002";}
		if(catanum.indexOf("107011")>=0){catanum="107";}
		if(catanum.indexOf("110019")>=0){catanum="107005";}

		String cataname = CommonString.getFormatPara(one_proform.get("cataname"));
		String product_name = CommonString.getFormatPara(one_proform.get("product_name")); // 产品名字 
		String message = CommonString.getFormatPara(one_proform.get("message")); 
		String add_date = CommonDate.getFormatDate("yyyy-MM-dd HH:mm",one_proform.get("add_date")); 
		String ifgroup = CommonString.getFormatPara(one_proform.get("ifgroup")); 
		if(ifgroup.equals("个人")){
			ifgroup = "1";	
		}else{
			ifgroup = "0";		
		}
		
		StringBuffer xmlStr = new StringBuffer();
		xmlStr.append("<NewDataSet>");
		xmlStr.append("<Request>");
		
		xmlStr.append("<comeflag>21sun</comeflag>");
		xmlStr.append("<order_date>"+add_date+"</order_date>");
		xmlStr.append("<add_ip>"+add_ip+"</add_ip>");
		xmlStr.append("<province_name>"+province+"</province_name>");
		xmlStr.append("<city_name>"+city+"</city_name>");
		xmlStr.append("<product_catalog_num>"+catanum+"</product_catalog_num>");
		xmlStr.append("<product_catalog_name>"+cataname+"</product_catalog_name>");
		xmlStr.append("<product_model>"+product_name+"</product_model>");
		xmlStr.append("<purchase_type>"+ifgroup+"</purchase_type>");
		xmlStr.append("<want_time>"+buy_time+"</want_time>");
		xmlStr.append("<buy_type>其他</buy_type>");
		xmlStr.append("<order_name>"+name+"</order_name>");
		xmlStr.append("<order_company>"+company+"</order_company>");
		xmlStr.append("<order_address></order_address>");
		xmlStr.append("<person_address></person_address>");
		xmlStr.append("<order_tel>"+mobile_phone+"</order_tel>");
		xmlStr.append("<line_call></line_call>");
		xmlStr.append("<order_email></order_email>");
		xmlStr.append("<order_word>"+message+"</order_word>");
		
		xmlStr.append("</Request>");
		xmlStr.append("</NewDataSet>");
		Client client = new Client(new URL("http://101.200.1.122:9807/sanyJob/services/IProductOrderService?wsdl"));
		Object [] s =  client.invoke("insertIntoData", new Object[]{xmlStr});
		String upSql = "";
		
		if(s != null && s.length > 0){
			result=(s[0].toString());
			if(s[0].toString().indexOf("success") >= 0||s[0].toString().indexOf("repeat") >= 0){
				upSql = " update pro_product_form set is_success = 1 where uuid = '"+uuid+"' ";
			}else{
				upSql = " update pro_product_form set is_success = 0 where uuid = '"+uuid+"' ";	

			}
			dbHelper.execute(upSql);
		}
		
	}
	if(result.equals("repeat")){result="该订单已经推送，推送状态已经修改";}
		out.println(result);
%>
