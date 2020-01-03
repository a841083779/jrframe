<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%><%@page import="com.jerehnet.util.common.CommonString"%><%@page import="com.jerehnet.util.dbutil.DBHelper"%><%@ page session="false" %><%@ taglib uri="/WEB-INF/classes/oscache.tld" prefix="cache"%><%
	String v = CommonString.getFormatPara(request.getParameter("v")) ;

	LinkedHashMap<String,String> wajuejiMap = new LinkedHashMap() ;
	wajuejiMap.put("182", "小松");
	wajuejiMap.put("184", "日立");
	wajuejiMap.put("183", "神钢");
	wajuejiMap.put("175", "沃尔沃");
	wajuejiMap.put("133", "三一");
	wajuejiMap.put("141", "福田雷沃");
	wajuejiMap.put("174", "卡特");
	wajuejiMap.put("192", "斗山");
	wajuejiMap.put("137", "山东临工");
	wajuejiMap.put("209", "徐工");
	
	LinkedHashMap<String,String> zhuangzaijiMap = new LinkedHashMap() ;
	zhuangzaijiMap.put("135", "龙工");
	zhuangzaijiMap.put("139", "厦工");
	zhuangzaijiMap.put("136", "柳工");
	zhuangzaijiMap.put("137", "山东临工");
	zhuangzaijiMap.put("138", "山工");
	
/* 	if(v.equals("101001")){
		brandMap = wajuejiMap;
	}else if(v.equals("101002")){
		brandMap = zhuangzaijiMap;
	} */
	//Map brandMap = (HashMap)application.getAttribute("brandMap") ;
	List<Map> brandList = (List<Map>)application.getAttribute("brandList") ;
	
	String brandfirst = "<option value=''>请选择品牌</option>";
   	for(Map m : brandList){ 
		String key = CommonString.getFormatPara(m.get("id"));
		String value = CommonString.getFormatPara(m.get("name"));
		brandfirst += "<option value='"+key+"'>"+value+"</option>";
	}
   	
	out.println(brandfirst);	
%>