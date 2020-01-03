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
	String uuid = CommonString.getFormatPara(request.getParameter("uuid"));
	//只是挖掘机走该接口
	Map one_proform = dbHelper.getMap("  select  * from pro_product_form where  uuid='" + uuid + "'");
	
	if(one_proform !=null && one_proform.get("id") != null){
	
	
   
		String id = CommonString.getFormatPara(one_proform.get("id"));
		String name = CommonString.getFormatPara(one_proform.get("name")); 
		
		String mobile_phone = CommonString.getFormatPara(one_proform.get("mobile_phone")); 
		String company = CommonString.getFormatPara(one_proform.get("company")).equals("公司名字")?"":CommonString.getFormatPara(one_proform.get("company")); 
		String province = CommonString.getFormatPara(one_proform.get("province")).trim(); // 省份
		String city = CommonString.getFormatPara(one_proform.get("city")); 
		String buy_time = CommonString.getFormatPara(one_proform.get("buy_time")); 
		if(buy_time.equals("102001")){
			buy_time = "10";	
		}else if(buy_time.equals("102002")){
			buy_time = "20";	
		}else if(buy_time.equals("102003")){
			buy_time = "30";	
		}else if(buy_time.equals("102004")){
			buy_time = "40";	
		}else if(buy_time.equals("102005")){
			buy_time = "50";	
		}else if(buy_time.equals("102006")){
			buy_time = "99";	
		}else{
			    buy_time = "99";	
			}
		String cataname = CommonString.getFormatPara(one_proform.get("cataname"));
		String product_name = CommonString.getFormatPara(one_proform.get("product_name")); // 产品名字 
		String message = CommonString.getFormatPara(one_proform.get("message")); 
		String add_date = CommonDate.getFormatDate("yyyy-MM-dd HH:mm",one_proform.get("add_date")); 
		
		StringBuffer xmlStr = new StringBuffer();
		xmlStr.append("<Cat>");
		xmlStr.append("<UserInfo>");
		xmlStr.append("<UserID>"+id+"</UserID>");
		xmlStr.append("<Name>"+name+"</Name>");
		xmlStr.append("<Gender></Gender>");
		xmlStr.append("<Mobile>"+mobile_phone+"</Mobile>");
		xmlStr.append("<Telephone></Telephone>");
		xmlStr.append("<Company>"+company+"</Company>");
		xmlStr.append("<Position></Position>");
		xmlStr.append("<Province>"+province+"</Province>");
		xmlStr.append("<City>"+city+"</City>");
		xmlStr.append("<Birthday></Birthday>");
		xmlStr.append("<PurchasePeriod>"+buy_time+"</PurchasePeriod>");
		xmlStr.append("<ExcavatorSize>99</ExcavatorSize>");
		xmlStr.append("<ExcavatorModel>"+product_name+"</ExcavatorModel>");
		xmlStr.append("<AgreeContact></AgreeContact>");
		xmlStr.append("<OrderMessage>"+message+"</OrderMessage>");
		xmlStr.append("<RegDate>"+add_date+"</RegDate>");
		if(CommonString.getFormatPara(one_proform.get("product_id")).equals("29179")||CommonString.getFormatPara(one_proform.get("product_id")).equals("29162")|| CommonString.getFormatPara(one_proform.get("product_id")).equals("23369")|| CommonString.getFormatPara(one_proform.get("product_id")).equals("23364")|| CommonString.getFormatPara(one_proform.get("product_id")).equals("20440")|| CommonString.getFormatPara(one_proform.get("product_id")).equals("21958")|| CommonString.getFormatPara(one_proform.get("product_id")).equals("28481")|| CommonString.getFormatPara(one_proform.get("product_id")).equals("28480")|| CommonString.getFormatPara(one_proform.get("product_id")).equals("23921")|| CommonString.getFormatPara(one_proform.get("product_id")).equals("23905")|| CommonString.getFormatPara(one_proform.get("product_id")).equals("20735")|| CommonString.getFormatPara(one_proform.get("product_id")).equals("23371")|| CommonString.getFormatPara(one_proform.get("product_id")).equals("21524")|| CommonString.getFormatPara(one_proform.get("product_id")).equals("23907")|| CommonString.getFormatPara(one_proform.get("product_id")).equals("23906")|| CommonString.getFormatPara(one_proform.get("product_id")).equals("21601")|| CommonString.getFormatPara(one_proform.get("product_id")).equals("20423")|| CommonString.getFormatPara(one_proform.get("product_id")).equals("29171")|| CommonString.getFormatPara(one_proform.get("product_id")).equals("29172")|| CommonString.getFormatPara(one_proform.get("product_id")).equals("29178")|| CommonString.getFormatPara(one_proform.get("product_id")).equals("29176")|| CommonString.getFormatPara(one_proform.get("product_id")).equals("29173")|| CommonString.getFormatPara(one_proform.get("product_id")).equals("21607")|| CommonString.getFormatPara(one_proform.get("product_id")).equals("22613")|| CommonString.getFormatPara(one_proform.get("product_id")).equals("23922")  ){
			xmlStr.append("<DataSource>360-ADVANTAGE-FUEL-GUARANTEE-21SUN</DataSource>");
		    xmlStr.append("<DataSourceCode>CG0102</DataSourceCode>");
		}else{	

		}		
		xmlStr.append("<RegisterType>询价</RegisterType>");
		xmlStr.append("<MediaSource></MediaSource>");
		xmlStr.append("</UserInfo>");
		xmlStr.append("</Cat>");
		

		    
			Client client = new Client(new URL("http://59.110.91.92/MDBWebRegWebSrv.asmx?wsdl"));
			Object [] s =  client.invoke("UserinfoDataReceive", new Object[]{xmlStr,1,"cb9df9a21299438bb885528b98edec9b"});
			String upSql = "";
			if(s != null && s.length > 0){
				if(s[0].toString().indexOf("Y") > 0){
					upSql = " update pro_product_form set is_success = 1,is_special = 2,is_360=1  where uuid = '"+uuid+"' ";
				}else{
					upSql = " update pro_product_form set is_success = 0 where uuid = '"+uuid+"' ";	
					%>
					<script>
					jQuery.post("/tools/email/cat_push_email.jsp",{uuids:"<%=uuid%>"}) ;
					</script>
				<%
				}
				dbHelper.execute(upSql);
			} 
			 	out.println("ok");
 

	
	}
	

%>
