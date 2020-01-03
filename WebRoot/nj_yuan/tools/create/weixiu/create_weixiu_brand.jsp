<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.jerehnet.util.common.Common"%>
<%@page import="com.jerehnet.util.freemarker.FreemarkerUtils"%>
<%@page import="com.jerehnet.util.freemarker.FreemarkerWebserviceUtils"%>
<%@page import="com.jerehnet.util.dbutil.DBHelper"%>
<%@page import="com.jerehnet.util.common.CommonString"%>
<%
// 生成所有的品牌详显页
	String realPath = Common.getAbsolutePath(request) ;
	FreemarkerUtils freemarkerUtils = new FreemarkerUtils(realPath+"template/") ;
    FreemarkerWebserviceUtils freemarkerWebserviceUtils = new FreemarkerWebserviceUtils(realPath+"template/") ;
	DBHelper dbHelper = DBHelper.getInstance() ;
	Map root = new HashMap() ;
	List<Map> cataloglist = dbHelper.getMapList("select  num from pro_catalog") ;	
	if(null != cataloglist && cataloglist.size()>0){
	for(Map catalogs:cataloglist){
	String catalog=CommonString.getFormatPara(catalogs.get("num")) ;	
	List<Map> allbrandMap = dbHelper.getMapList("select top 10 factoryid,factoryname from pro_catalog_factory where catalognum ='" + catalog+ "' order by order_no desc") ;
	
			if(null != allbrandMap && allbrandMap.size()>0){
					root.put("list",allbrandMap) ;
					freemarkerUtils.generate("weixiu/weixiu_brand.shtm",root,realPath+"/include/weixiu/weixiu_brand/brand_"+catalog+".jsp") ;  // 生成所有的品牌详显页
			}
	
		}
     }
	
	out.println("ok") ;
%>
