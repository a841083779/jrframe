<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.jerehnet.util.common.Common"%>
<%@page import="com.jerehnet.util.freemarker.FreemarkerUtils"%>
<%@page import="com.jerehnet.util.dbutil.DBHelper"%>
<%@page import="com.jerehnet.util.common.CommonString"%>
<%@page import="com.jerehnet.util.common.*"%>


<%
	Map catalogMap = (HashMap)application.getAttribute("catalogMap") ;
	// 生成有更新的产品引入页面
	String realPath = Common.getAbsolutePath(request) ;
	String absPath = Common.getAbsolutePath(request) ;
	FreemarkerUtils freemarkerUtils = new FreemarkerUtils(absPath+"template/") ; 
	String today=CommonDate.getToday("yyyy-MM-dd");
	DBHelper dbHelper = DBHelper.getInstance() ;
	Map root = null;
	List<Map> order_list = dbHelper.getMapList(" select * from pro_products  where   factoryid=138 ") ;


	    root = new HashMap();	
		for(Map proMap:order_list){

			if(null != proMap){
				root.put("pro_id",CommonString.getFormatPara(proMap.get("id"))) ;
			    root.put("factoryname",CommonString.getFormatPara(proMap.get("factoryname"))) ;
			    root.put("proname",CommonString.getFormatPara(proMap.get("name"))) ;
			    root.put("catalogname",CommonString.getFormatPara(proMap.get("catalogname"))) ;
			    freemarkerUtils.generate("proDetail/include_order_list.shtm",root,realPath+"/include/prodetail_order/order_list_"+CommonString.getFormatPara(proMap.get("id"))+".htm") ;
			}
		}
	

	out.println("ok") ;
%>
