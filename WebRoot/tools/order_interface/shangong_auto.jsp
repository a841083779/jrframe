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

	//凌晨一点自动发送前一天推送失败的订单数据
	request.setCharacterEncoding("utf-8");
	String thisTime = CommonDate.hourAdd("-1","yyyy-MM-dd HH:mm:ss");
	String yesTime = CommonDate.dateAdd("-1","yyyy-MM-dd HH:mm:ss");
	
	DBHelper dbHelper = DBHelper.getInstance();
	List list = dbHelper.getMapList("  select * from pro_product_form where 1=2 and factoryid = '138' and (is_success != 1 or is_success is null) and add_date > '"+yesTime+"' and add_date < '"+thisTime+"'   and  buy_time is  not  null  and  buy_time !=''  ");
	
	Map one_proform_pro = null;
	for(int i = 0; list != null && i < list.size(); i++){
		one_proform_pro = (Map)list.get(i);
		if(one_proform_pro != null && one_proform_pro.get("uuid") != null){
		
		
			String uuid =(String)(one_proform_pro.get("uuid"));
	Map one_proform = dbHelper.getMap("  select  * from pro_product_form where uuid='" + uuid + "' ");
	if(one_proform !=null && one_proform.get("id") != null){
		//String id = CommonString.getFormatPara(one_proform.get("id"));
		String name = CommonString.getFormatPara(one_proform.get("name"));                   //联系人 购买人
		String mobile_phone = CommonString.getFormatPara(one_proform.get("mobile_phone"));   //联系电话
		String message = CommonString.getFormatPara(one_proform.get("message"));           //询价内容
		String province = CommonString.getFormatPara(one_proform.get("province")).trim(); // 省份
		String city = CommonString.getFormatPara(one_proform.get("city"));              //城市
		String buy_time = CommonString.getFormatPara(one_proform.get("buy_time")); 
		if(!buy_time.equals("")){
		   if(buy_time.equals("102007")){buy_time="1个周内";}
		   else if(buy_time.equals("102001")){buy_time="1个月内";}
		   else if(buy_time.equals("102002")){buy_time="1—3个月";}
		   else if(buy_time.equals("102003")){buy_time="4—6个月";}
		   else if(buy_time.equals("102004")){buy_time="7—12个月";}
		   else if(buy_time.equals("102005")){buy_time="1年后";}
		   else if(buy_time.equals("102006")){buy_time="不确定";}
		   else{buy_time="不确定";}
		}
		String cataname = CommonString.getFormatPara(one_proform.get("cataname"));   //产品类型
		String product_name = CommonString.getFormatPara(one_proform.get("product_name")); // 产品名字 
		String add_date = CommonDate.getFormatDate("yyyy-MM-dd HH:mm:ss",one_proform.get("add_date")); 
		String catanum = CommonString.getFormatPara(one_proform.get("catanum"));
		
if(1==2){

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
formParams.add(new NameValuePair("BUYER", "个人")); 
formParams.add(new NameValuePair("PRODUCT", cataname)); 
formParams.add(new NameValuePair("MODEL", product_name)); 
formParams.add(new NameValuePair("DESC", message)); 
formParams.add(new NameValuePair("PAY_TYPE", "-")); 
formParams.add(new NameValuePair("EST_DATE", buy_time)); 
postMethod.addParameters(formParams.toArray(arr)); 
int statusCode = httpClient.executeMethod(postMethod); 
if(statusCode==200){
String upSql = " update pro_product_form set is_success = 1 where uuid = '"+uuid+"' ";
			dbHelper.execute(upSql);
}
	}	
	}

	
			
		}
		one_proform_pro = null;	
	}
%>