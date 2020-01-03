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
	request.setCharacterEncoding("utf-8");
	DBHelper dbHelper = DBHelper.getInstance();
	String uuid = CommonString.getFormatPara(request.getParameter("uuid"));
	//只是挖掘机走该接口
	Map one_proform = dbHelper.getMap("  select  * from pro_product_form where  uuid='" + uuid + "'");
	
	if(one_proform !=null && one_proform.get("id") != null){
	
	
	 if(CommonString.getFormatPara(one_proform.get("product_id")).equals("31918")||CommonString.getFormatPara(one_proform.get("product_id")).equals("31913")||CommonString.getFormatPara(one_proform.get("product_id")).equals("31828")||CommonString.getFormatPara(one_proform.get("product_id")).equals("31829")||CommonString.getFormatPara(one_proform.get("product_id")).equals("31914")||CommonString.getFormatPara(one_proform.get("product_id")).equals("31921")||CommonString.getFormatPara(one_proform.get("product_id")).equals("31920")||CommonString.getFormatPara(one_proform.get("product_id")).equals("31919")||CommonString.getFormatPara(one_proform.get("product_id")).equals("31807")||CommonString.getFormatPara(one_proform.get("product_id")).equals("31806")||CommonString.getFormatPara(one_proform.get("product_id")).equals("31805")||CommonString.getFormatPara(one_proform.get("product_id")).equals("9554")||CommonString.getFormatPara(one_proform.get("product_id")).equals("25480")||CommonString.getFormatPara(one_proform.get("product_id")).equals("9553")||CommonString.getFormatPara(one_proform.get("product_id")).equals("9552")||CommonString.getFormatPara(one_proform.get("product_id")).equals("9551")||CommonString.getFormatPara(one_proform.get("product_id")).equals("9550")||CommonString.getFormatPara(one_proform.get("product_id")).equals("9548")||CommonString.getFormatPara(one_proform.get("product_id")).equals("9547")||CommonString.getFormatPara(one_proform.get("product_id")).equals("8351")||CommonString.getFormatPara(one_proform.get("product_id")).equals("8337")||CommonString.getFormatPara(one_proform.get("product_id")).equals("4615")||CommonString.getFormatPara(one_proform.get("product_id")).equals("378")||CommonString.getFormatPara(one_proform.get("product_id")).equals("390")||CommonString.getFormatPara(one_proform.get("product_id")).equals("400")||CommonString.getFormatPara(one_proform.get("product_id")).equals("403")||CommonString.getFormatPara(one_proform.get("product_id")).equals("407")||CommonString.getFormatPara(one_proform.get("product_id")).equals("445")||CommonString.getFormatPara(one_proform.get("product_id")).equals("522")||CommonString.getFormatPara(one_proform.get("product_id")).equals("3503")||CommonString.getFormatPara(one_proform.get("product_id")).equals("3525")||CommonString.getFormatPara(one_proform.get("product_id")).equals("4611")||CommonString.getFormatPara(one_proform.get("product_id")).equals("4613")||CommonString.getFormatPara(one_proform.get("product_id")).equals("4614")||CommonString.getFormatPara(one_proform.get("product_id")).equals("28481")||CommonString.getFormatPara(one_proform.get("product_id")).equals("9554")||CommonString.getFormatPara(one_proform.get("product_id")).equals("25480")||CommonString.getFormatPara(one_proform.get("product_id")).equals("9555")||CommonString.getFormatPara(one_proform.get("product_id")).equals("25477")||CommonString.getFormatPara(one_proform.get("product_id")).equals("25167")||CommonString.getFormatPara(one_proform.get("product_id")).equals("23911")||CommonString.getFormatPara(one_proform.get("product_id")).equals("23910")||CommonString.getFormatPara(one_proform.get("product_id")).equals("23909")||CommonString.getFormatPara(one_proform.get("product_id")).equals("23908")||CommonString.getFormatPara(one_proform.get("product_id")).equals("23364")||CommonString.getFormatPara(one_proform.get("product_id")).equals("23362")||CommonString.getFormatPara(one_proform.get("product_id")).equals("23228")||CommonString.getFormatPara(one_proform.get("product_id")).equals("21960")||CommonString.getFormatPara(one_proform.get("product_id")).equals("21958")||CommonString.getFormatPara(one_proform.get("product_id")).equals("20473")||CommonString.getFormatPara(one_proform.get("product_id")).equals("20472")||CommonString.getFormatPara(one_proform.get("product_id")).equals("20440")||CommonString.getFormatPara(one_proform.get("product_id")).equals("19947")||CommonString.getFormatPara(one_proform.get("product_id")).equals("19946")||CommonString.getFormatPara(one_proform.get("product_id")).equals("15159")||CommonString.getFormatPara(one_proform.get("product_id")).equals("11366")||CommonString.getFormatPara(one_proform.get("product_id")).equals("9585")||CommonString.getFormatPara(one_proform.get("product_id")).equals("9584")||CommonString.getFormatPara(one_proform.get("product_id")).equals("9555")||CommonString.getFormatPara(one_proform.get("product_id")).equals("25477")||CommonString.getFormatPara(one_proform.get("product_id")).equals("325")||CommonString.getFormatPara(one_proform.get("product_id")).equals("574")||CommonString.getFormatPara(one_proform.get("product_id")).equals("588")||CommonString.getFormatPara(one_proform.get("product_id")).equals("590")||CommonString.getFormatPara(one_proform.get("product_id")).equals("4561")||CommonString.getFormatPara(one_proform.get("product_id")).equals("9546")||CommonString.getFormatPara(one_proform.get("product_id")).equals("20164")||CommonString.getFormatPara(one_proform.get("product_id")).equals("20163")||CommonString.getFormatPara(one_proform.get("product_id")).equals("21514")||CommonString.getFormatPara(one_proform.get("product_id")).equals("23913")||CommonString.getFormatPara(one_proform.get("product_id")).equals("23914")||CommonString.getFormatPara(one_proform.get("product_id")).equals("23916")||CommonString.getFormatPara(one_proform.get("product_id")).equals("23917")||CommonString.getFormatPara(one_proform.get("product_id")).equals("23918")||CommonString.getFormatPara(one_proform.get("product_id")).equals("23919")||CommonString.getFormatPara(one_proform.get("product_id")).equals("23920")||CommonString.getFormatPara(one_proform.get("product_id")).equals("20423")||CommonString.getFormatPara(one_proform.get("product_id")).equals("20735")||CommonString.getFormatPara(one_proform.get("product_id")).equals("21524")||CommonString.getFormatPara(one_proform.get("product_id")).equals("21601")||CommonString.getFormatPara(one_proform.get("product_id")).equals("21607")||CommonString.getFormatPara(one_proform.get("product_id")).equals("21959")||CommonString.getFormatPara(one_proform.get("product_id")).equals("22613")||CommonString.getFormatPara(one_proform.get("product_id")).equals("23369")||CommonString.getFormatPara(one_proform.get("product_id")).equals("23371")||CommonString.getFormatPara(one_proform.get("product_id")).equals("23905")||CommonString.getFormatPara(one_proform.get("product_id")).equals("23906")||CommonString.getFormatPara(one_proform.get("product_id")).equals("23907")||CommonString.getFormatPara(one_proform.get("product_id")).equals("23921")||CommonString.getFormatPara(one_proform.get("product_id")).equals("23922")||CommonString.getFormatPara(one_proform.get("product_id")).equals("28480")||CommonString.getFormatPara(one_proform.get("product_id")).equals("29162")||CommonString.getFormatPara(one_proform.get("product_id")).equals("29171")||CommonString.getFormatPara(one_proform.get("product_id")).equals("29172")||CommonString.getFormatPara(one_proform.get("product_id")).equals("29173")||CommonString.getFormatPara(one_proform.get("product_id")).equals("29176")||CommonString.getFormatPara(one_proform.get("product_id")).equals("29178")||CommonString.getFormatPara(one_proform.get("product_id")).equals("29179")||CommonString.getFormatPara(one_proform.get("product_id")).equals("29444")||CommonString.getFormatPara(one_proform.get("product_id")).equals("30219")||CommonString.getFormatPara(one_proform.get("product_id")).equals("30220")||CommonString.getFormatPara(one_proform.get("product_id")).equals("30221")||CommonString.getFormatPara(one_proform.get("product_id")).equals("21525")||CommonString.getFormatPara(one_proform.get("product_id")).equals("23912")||CommonString.getFormatPara(one_proform.get("product_id")).equals("23915")||CommonString.getFormatPara(one_proform.get("product_id")).equals("29163")||CommonString.getFormatPara(one_proform.get("product_id")).equals("29164")||CommonString.getFormatPara(one_proform.get("product_id")).equals("29165")||CommonString.getFormatPara(one_proform.get("product_id")).equals("9546")||CommonString.getFormatPara(one_proform.get("product_id")).equals("38136")||CommonString.getFormatPara(one_proform.get("product_id")).equals("38139")||CommonString.getFormatPara(one_proform.get("product_id")).equals("38138")){
  
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
		//BCP
		if(CommonString.getFormatPara(one_proform.get("product_id")).equals("9546")||CommonString.getFormatPara(one_proform.get("product_id")).equals("38136")||CommonString.getFormatPara(one_proform.get("product_id")).equals("31921")||CommonString.getFormatPara(one_proform.get("product_id")).equals("31920")||CommonString.getFormatPara(one_proform.get("product_id")).equals("31919")||CommonString.getFormatPara(one_proform.get("product_id")).equals("31807")||CommonString.getFormatPara(one_proform.get("product_id")).equals("31806")||CommonString.getFormatPara(one_proform.get("product_id")).equals("31805")||CommonString.getFormatPara(one_proform.get("product_id")).equals("325")||CommonString.getFormatPara(one_proform.get("product_id")).equals("574")||CommonString.getFormatPara(one_proform.get("product_id")).equals("588")||CommonString.getFormatPara(one_proform.get("product_id")).equals("590")||CommonString.getFormatPara(one_proform.get("product_id")).equals("4561")||CommonString.getFormatPara(one_proform.get("product_id")).equals("9546")||CommonString.getFormatPara(one_proform.get("product_id")).equals("20164")||CommonString.getFormatPara(one_proform.get("product_id")).equals("20163")||CommonString.getFormatPara(one_proform.get("product_id")).equals("21514")||CommonString.getFormatPara(one_proform.get("product_id")).equals("23913")||CommonString.getFormatPara(one_proform.get("product_id")).equals("23914")||CommonString.getFormatPara(one_proform.get("product_id")).equals("23916")||CommonString.getFormatPara(one_proform.get("product_id")).equals("23917")||CommonString.getFormatPara(one_proform.get("product_id")).equals("23918")||CommonString.getFormatPara(one_proform.get("product_id")).equals("23919")||CommonString.getFormatPara(one_proform.get("product_id")).equals("23920")||CommonString.getFormatPara(one_proform.get("product_id")).equals("21525")||CommonString.getFormatPara(one_proform.get("product_id")).equals("23912")||CommonString.getFormatPara(one_proform.get("product_id")).equals("23915")||CommonString.getFormatPara(one_proform.get("product_id")).equals("29163")||CommonString.getFormatPara(one_proform.get("product_id")).equals("29164")||CommonString.getFormatPara(one_proform.get("product_id")).equals("29165")){
			way=3;
			xmlStr.append("<DataSource>21SUN-MINI</DataSource>");
			xmlStr.append("<DataSourceCode>CB0001</DataSourceCode>");
		}
		//GCI
        if(CommonString.getFormatPara(one_proform.get("product_id")).equals("31918")||CommonString.getFormatPara(one_proform.get("product_id")).equals("38139")||CommonString.getFormatPara(one_proform.get("product_id")).equals("38138")||CommonString.getFormatPara(one_proform.get("product_id")).equals("31913")||CommonString.getFormatPara(one_proform.get("product_id")).equals("31828")||CommonString.getFormatPara(one_proform.get("product_id")).equals("31829")||CommonString.getFormatPara(one_proform.get("product_id")).equals("31914")||CommonString.getFormatPara(one_proform.get("product_id")).equals("9554")||CommonString.getFormatPara(one_proform.get("product_id")).equals("25480")||CommonString.getFormatPara(one_proform.get("product_id")).equals("9553")||CommonString.getFormatPara(one_proform.get("product_id")).equals("9552")||CommonString.getFormatPara(one_proform.get("product_id")).equals("9551")||CommonString.getFormatPara(one_proform.get("product_id")).equals("9550")||CommonString.getFormatPara(one_proform.get("product_id")).equals("9548")||CommonString.getFormatPara(one_proform.get("product_id")).equals("9547")||CommonString.getFormatPara(one_proform.get("product_id")).equals("8351")||CommonString.getFormatPara(one_proform.get("product_id")).equals("8337")||CommonString.getFormatPara(one_proform.get("product_id")).equals("4615")||CommonString.getFormatPara(one_proform.get("product_id")).equals("378")||CommonString.getFormatPara(one_proform.get("product_id")).equals("390")||CommonString.getFormatPara(one_proform.get("product_id")).equals("400")||CommonString.getFormatPara(one_proform.get("product_id")).equals("403")||CommonString.getFormatPara(one_proform.get("product_id")).equals("407")||CommonString.getFormatPara(one_proform.get("product_id")).equals("445")||CommonString.getFormatPara(one_proform.get("product_id")).equals("522")||CommonString.getFormatPara(one_proform.get("product_id")).equals("3503")||CommonString.getFormatPara(one_proform.get("product_id")).equals("3525")||CommonString.getFormatPara(one_proform.get("product_id")).equals("4611")||CommonString.getFormatPara(one_proform.get("product_id")).equals("4613")||CommonString.getFormatPara(one_proform.get("product_id")).equals("4614")||CommonString.getFormatPara(one_proform.get("product_id")).equals("28481")||CommonString.getFormatPara(one_proform.get("product_id")).equals("9554")||CommonString.getFormatPara(one_proform.get("product_id")).equals("25480")||CommonString.getFormatPara(one_proform.get("product_id")).equals("9555")||CommonString.getFormatPara(one_proform.get("product_id")).equals("25477")||CommonString.getFormatPara(one_proform.get("product_id")).equals("25167")||CommonString.getFormatPara(one_proform.get("product_id")).equals("23911")||CommonString.getFormatPara(one_proform.get("product_id")).equals("23910")||CommonString.getFormatPara(one_proform.get("product_id")).equals("23909")||CommonString.getFormatPara(one_proform.get("product_id")).equals("23908")||CommonString.getFormatPara(one_proform.get("product_id")).equals("23364")||CommonString.getFormatPara(one_proform.get("product_id")).equals("23362")||CommonString.getFormatPara(one_proform.get("product_id")).equals("23228")||CommonString.getFormatPara(one_proform.get("product_id")).equals("21960")||CommonString.getFormatPara(one_proform.get("product_id")).equals("21958")||CommonString.getFormatPara(one_proform.get("product_id")).equals("20473")||CommonString.getFormatPara(one_proform.get("product_id")).equals("20472")||CommonString.getFormatPara(one_proform.get("product_id")).equals("20440")||CommonString.getFormatPara(one_proform.get("product_id")).equals("19947")||CommonString.getFormatPara(one_proform.get("product_id")).equals("19946")||CommonString.getFormatPara(one_proform.get("product_id")).equals("15159")||CommonString.getFormatPara(one_proform.get("product_id")).equals("11366")||CommonString.getFormatPara(one_proform.get("product_id")).equals("9585")||CommonString.getFormatPara(one_proform.get("product_id")).equals("9584")||CommonString.getFormatPara(one_proform.get("product_id")).equals("9555")||CommonString.getFormatPara(one_proform.get("product_id")).equals("25477")||CommonString.getFormatPara(one_proform.get("product_id")).equals("20423")||CommonString.getFormatPara(one_proform.get("product_id")).equals("20735")||CommonString.getFormatPara(one_proform.get("product_id")).equals("21524")||CommonString.getFormatPara(one_proform.get("product_id")).equals("21601")||CommonString.getFormatPara(one_proform.get("product_id")).equals("21607")||CommonString.getFormatPara(one_proform.get("product_id")).equals("21959")||CommonString.getFormatPara(one_proform.get("product_id")).equals("22613")||CommonString.getFormatPara(one_proform.get("product_id")).equals("23369")||CommonString.getFormatPara(one_proform.get("product_id")).equals("23371")||CommonString.getFormatPara(one_proform.get("product_id")).equals("23905")||CommonString.getFormatPara(one_proform.get("product_id")).equals("23906")||CommonString.getFormatPara(one_proform.get("product_id")).equals("23907")||CommonString.getFormatPara(one_proform.get("product_id")).equals("23921")||CommonString.getFormatPara(one_proform.get("product_id")).equals("23922")||CommonString.getFormatPara(one_proform.get("product_id")).equals("28480")||CommonString.getFormatPara(one_proform.get("product_id")).equals("29162")||CommonString.getFormatPara(one_proform.get("product_id")).equals("29171")||CommonString.getFormatPara(one_proform.get("product_id")).equals("29172")||CommonString.getFormatPara(one_proform.get("product_id")).equals("29173")||CommonString.getFormatPara(one_proform.get("product_id")).equals("29176")||CommonString.getFormatPara(one_proform.get("product_id")).equals("29178")||CommonString.getFormatPara(one_proform.get("product_id")).equals("29179")||CommonString.getFormatPara(one_proform.get("product_id")).equals("29444")||CommonString.getFormatPara(one_proform.get("product_id")).equals("30219")||CommonString.getFormatPara(one_proform.get("product_id")).equals("30220")||CommonString.getFormatPara(one_proform.get("product_id")).equals("30221")){
			way=2;
			xmlStr.append("<DataSource>21SUN</DataSource>");
            xmlStr.append("<DataSourceCode>CG0001</DataSourceCode>");		
		}
		xmlStr.append("<RegisterType>询价</RegisterType>");
		xmlStr.append("<MediaSource></MediaSource>");
		
		xmlStr.append("</UserInfo>");
		xmlStr.append("</Cat>");
	
	    //正常非加密
		if(way==1){

	    }
        //GCI加密
        if(way==2){	
		   DvRequestEntity requestEntity = new DvRequestEntity(DvConstants.METHOD_CAT_GCI_USERINFO, DvConstants.FORMAT_XML,1,xmlStr.toString());
            respon = new DvHttpClient().execute(requestEntity);
			if(respon.indexOf("true")>=0){
				String upSqls = " update pro_product_form set is_success = 1,is_normal =1 where uuid = '"+uuid+"' ";
				dbHelper.execute(upSqls);
			}
		}
		//BCP加密
        if(way==3){	
		   DvRequestEntity requestEntity = new DvRequestEntity(DvConstants.METHOD_CAT_BCP_USERINFO, DvConstants.FORMAT_XML,1,xmlStr.toString());
            respon = new DvHttpClient().execute(requestEntity);
			if(respon.indexOf("true")>=0){
				String upSqls = " update pro_product_form set is_success = 1,is_normal =1 where uuid = '"+uuid+"' ";
				dbHelper.execute(upSqls);
			}
		}
		
			
	out.println("ok"+"======"+respon);
	}else{
		
		out.println("fail"+"======"+respon);
	}
	 

	
	}
	

%>
