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
	
	
	 if(CommonString.getFormatPara(one_proform.get("catanum")).equals("101001001") ){
  
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
		xmlStr.append("<ExcavatorModel>-</ExcavatorModel>");
		xmlStr.append("<AgreeContact></AgreeContact>");
		xmlStr.append("<OrderMessage>-</OrderMessage>");
		xmlStr.append("<RegDate>"+add_date+"</RegDate>");
		if(CommonString.getFormatPara(one_proform.get("id")).equals("21525")||CommonString.getFormatPara(one_proform.get("id")).equals("21514")||CommonString.getFormatPara(one_proform.get("id")).equals("20163") || CommonString.getFormatPara(one_proform.get("id")).equals("20164") || CommonString.getFormatPara(one_proform.get("id")).equals("9546") || CommonString.getFormatPara(one_proform.get("id")).equals("325") || CommonString.getFormatPara(one_proform.get("id")).equals("574") || CommonString.getFormatPara(one_proform.get("id")).equals("588") || CommonString.getFormatPara(one_proform.get("id")).equals("4561") || CommonString.getFormatPara(one_proform.get("id")).equals("590")){

	
		}else{
			
		xmlStr.append("<DataSource>21SUN-LEGEND</DataSource>");
        xmlStr.append("<DataSourceCode>CB0036</DataSourceCode>");
		}		
		xmlStr.append("<RegisterType>询价</RegisterType>");
		xmlStr.append("<MediaSource></MediaSource>");
		xmlStr.append("</UserInfo>");
		xmlStr.append("</Cat>");
		

		    
			Client client = new Client(new URL("Http://catmdb.ogilvy.com.cn/MDBWebRegWebSrv.asmx?wsdl"));
			Object [] s =  client.invoke("UserinfoDataReceive", new Object[]{xmlStr,1,"cb9df9a21299438bb885528b98edec9b"});
			String upSql = "";
			if(s != null && s.length > 0){
				if(s[0].toString().indexOf("Y") > 0){
					upSql = " update pro_product_form set is_success = 1,is_special =1 where uuid = '"+uuid+"' ";
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
	}else{
		
		out.println("fail");
	}
	 

	
	}
	

%>
