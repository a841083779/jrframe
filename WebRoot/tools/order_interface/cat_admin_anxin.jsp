<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.jerehnet.util.dbutil.DBHelper"%>
<%@page import="com.jerehnet.util.common.CommonString"%>
<%@page import="com.jerehnet.util.common.CommonDate"%>
<%@page import="com.jerehnet.mobile.sync.PushSyncActon"%>
<%@page import="org.codehaus.xfire.client.Client,com.jerehnet.util.common.Env,java.net.URL"%>

<%@page import="com.dv.api.DvRequestEntity"%>
<%@page import="com.dv.api.DvHttpClient"%>
<%@page import="com.dv.api.DvConstants"%>
<script type="text/javascript" src="/scripts/jquery-1.7.min.js"></script>
<%
    String respon="";
	int way=0;
	int biaoshi=0;
	request.setCharacterEncoding("utf-8");
	DBHelper dbHelper = DBHelper.getInstance();
	String uuid = CommonString.getFormatPara(request.getParameter("uuid"));
	String flag = CommonString.getFormatPara(request.getParameter("flag"));
	//只是挖掘机走该接口
	Map one_proform = dbHelper.getMap("  select  * from pro_product_form where  uuid='" + uuid + "'");
	
	if(one_proform !=null && one_proform.get("id") != null){
	
	
	 if(CommonString.getFormatPara(one_proform.get("product_id")).equals("31913")||CommonString.getFormatPara(one_proform.get("product_id")).equals("31918")||CommonString.getFormatPara(one_proform.get("product_id")).equals("30219")||CommonString.getFormatPara(one_proform.get("product_id")).equals("30221")||CommonString.getFormatPara(one_proform.get("product_id")).equals("30220")||CommonString.getFormatPara(one_proform.get("product_id")).equals("31828")||CommonString.getFormatPara(one_proform.get("product_id")).equals("31829")  ){
  
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
		String add_date = CommonDate.getFormatDate("yyyy-MM-dd HH:mm:ss",one_proform.get("add_date")); 
		String url="Http://catmdb.ogilvy.com.cn/MDBWebRegWebSrv.asmx?wsdl";
		String token="cb9df9a21299438bb885528b98edec9b";
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
		 
		biaoshi=170;
		xmlStr.append("<DataSource>360-Campaign-2019</DataSource>");
		xmlStr.append("<DataSourceCode>CG0170</DataSourceCode>");
		xmlStr.append("<RegisterType>询价</RegisterType>");
		xmlStr.append("<MediaSource></MediaSource>");
		
		xmlStr.append("</UserInfo>");
		xmlStr.append("</Cat>");
	
	 
		   DvRequestEntity requestEntity = new DvRequestEntity(DvConstants.METHOD_CAT_GCI_USERINFO, DvConstants.FORMAT_XML,1,xmlStr.toString());
            respon = new DvHttpClient().execute(requestEntity);
			if(respon.indexOf("true")>=0){
				String upSqls = " update pro_product_form set is_success = 1,is_normal ="+biaoshi+" where uuid = '"+uuid+"' ";
				dbHelper.execute(upSqls);
			}
 
 
			
	out.println("ok"+"======"+respon);
	}else{
		
		out.println("fail"+"======"+respon);
	}
	 

	
	}
	

%>
