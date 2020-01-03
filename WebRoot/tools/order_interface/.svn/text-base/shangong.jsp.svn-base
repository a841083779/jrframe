<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.jerehnet.util.dbutil.DBHelper"%>
<%@page import="com.jerehnet.util.common.CommonString"%>
<%@page import="com.jerehnet.util.common.CommonDate"%>
<%@page import="org.codehaus.xfire.client.Client,com.jerehnet.util.common.Env,java.net.URL"%>
<%
	request.setCharacterEncoding("utf-8");
	DBHelper dbHelper = DBHelper.getInstance();
	String uuid = CommonString.getFormatPara(request.getParameter("uuid"));
	Map one_proform = dbHelper.getMap("  select  * from pro_product_form where uuid='" + uuid + "' and  buy_time is  not  null  and  buy_time !=''  ");
	
	if(one_proform !=null && one_proform.get("id") != null){
		String id = CommonString.getFormatPara(one_proform.get("id"));
		String name = CommonString.getFormatPara(one_proform.get("name")); 
		
		String mobile_phone = CommonString.getFormatPara(one_proform.get("mobile_phone")); 
		String company = CommonString.getFormatPara(one_proform.get("company")).equals("公司名字")?"个人":CommonString.getFormatPara(one_proform.get("company")); 
		String province = CommonString.getFormatPara(one_proform.get("province")).trim(); // 省份
		String city = CommonString.getFormatPara(one_proform.get("city")); 
		
		if(province.equals("香港") || province.equals("澳门") || province.equals("台湾")){
			province = "66";	
			city = "6601";
		}else if(province.equals("海外")){
			province = "67";	
			city = "6701";	
		}else{
			Map p = dbHelper.getMap(" select province_no from common_province where province = '"+province+"' ");
			if(p != null && p.get("province_no") != null){
				province = CommonString.getFormatPara(p.get("province_no"));
			}else{
				province = "37";	
			}
			if(province.equals("")){
				province = "37";
			}
			
			Map c = dbHelper.getMap(" select city_no from common_province where city = '"+city+"' ");
			if(c != null && c.get("city_no") != null){
				city = CommonString.getFormatPara(c.get("city_no"));
			}else if(province.equals("11")){
				city = "1101";	
			}else if(province.equals("12")){
				city = "1201";	
			}else if(province.equals("31")){
				city = "3101";	
			}else if(province.equals("50")){
				city = "5001";	
			}else{
				province = "37";
				city = "3706";	
			}
			if(city.equals("")){
				province = "37";
				city = "3706";
			}
		}
		
		String buy_time = CommonString.getFormatPara(one_proform.get("buy_time")); 
		if(buy_time.equals("102001")){
			buy_time = "1";	
		}else if(buy_time.equals("102002")){
			buy_time = "1";	
		}else if(buy_time.equals("102003")){
			buy_time = "2";	
		}else if(buy_time.equals("102004")){
			buy_time = "3";	
		}else if(buy_time.equals("102005")){
			buy_time = "4";	
		}else if(buy_time.equals("102006")){
			buy_time = "99";	
		}
		String cataname = CommonString.getFormatPara(one_proform.get("cataname"));
		String product_name = CommonString.getFormatPara(one_proform.get("product_name")); // 产品名字 
		String message = CommonString.getFormatPara(one_proform.get("message")); 
		String add_date = CommonDate.getFormatDate("yyyy-MM-dd HH:mm:ss",one_proform.get("add_date")); 
		String catanum = CommonString.getFormatPara(one_proform.get("catanum"));
		if(catanum.indexOf("101002") >= 0){
			catanum = "100";
		}else if(catanum.indexOf("101005") >= 0){
			catanum = "101";
		}else if(catanum.indexOf("106003") >= 0){
			catanum = "102";
		}else if(catanum.indexOf("106001") >= 0){
			catanum = "103";
		}else if(catanum.indexOf("101003") >= 0){
			catanum = "104";
		}else{
			catanum = "105";	
		}
		
		StringBuffer xmlStr = new StringBuffer();
		xmlStr.append("<Cat>");
		xmlStr.append("<OBInfo>");
		
		xmlStr.append("<LeadID>"+id+"</LeadID>");
		xmlStr.append("<Name>"+name+"</Name>");
		xmlStr.append("<Mobile>"+mobile_phone+"</Mobile>");
		xmlStr.append("<Email></Email>");
		xmlStr.append("<Gender></Gender>");
		xmlStr.append("<Province>"+province+"</Province>");
		xmlStr.append("<City>"+city+"</City>");
		xmlStr.append("<Unit>"+company+"</Unit>");
		xmlStr.append("<PurchasePeriod>"+buy_time+"</PurchasePeriod>");		
		xmlStr.append("<MachineCategory>"+catanum+"</MachineCategory>");
		xmlStr.append("<MachineModel>"+product_name+"</MachineModel>");
		xmlStr.append("<OrderMessage>"+message+"</OrderMessage>");
		xmlStr.append("<DataSource>4</DataSource>");		
		xmlStr.append("<Sourcelabel>1</Sourcelabel>");
		xmlStr.append("<utmsource></utmsource>");
		xmlStr.append("<utmmedium></utmmedium>");
		xmlStr.append("<utmcontent></utmcontent>");
		xmlStr.append("<utmcampaign></utmcampaign>");		
		xmlStr.append("<DataRegDate>"+add_date+"</DataRegDate>");
		xmlStr.append("<Remark></Remark>");	
			
		xmlStr.append("</OBInfo>");
		xmlStr.append("</Cat>");

	if(1==0){//前台都不自动推送
		Client client = new Client(new URL("http://121.58.159.11:8096/SmartCRM/services/UserinfoDataTransmission?wsdl"));
		Object [] s =  client.invoke("UserinfoDataTransmission", new Object[]{xmlStr,1});
		String upSql = "";
		if(s != null && s.length > 0){
			if(s[0].toString().indexOf("Y") > 0){
				upSql = " update pro_product_form set is_success = 1 where uuid = '"+uuid+"' ";
			}else{
				upSql = " update pro_product_form set is_success = 0 where uuid = '"+uuid+"' ";	
			}
			dbHelper.execute(upSql);
		}
	}	
		

	}
	out.println("ok");
%>
