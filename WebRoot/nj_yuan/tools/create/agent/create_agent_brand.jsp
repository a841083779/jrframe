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
	List<Map> allbrandMap = dbHelper.getMapList("SELECT top 10 id,name,factoryid FROM (select id,name from pro_agent_factory where pro_agent_factory.flag=1  )AS b INNER  JOIN  (SELECT factoryid FROM pro_products WHERE catalognum  like '%"+catalog+"%' AND factoryid!=0 GROUP BY factoryid) AS p  ON b.id =p.factoryid  order by id asc") ;
	
			if(null != allbrandMap && allbrandMap.size()>0){
					root.put("list",allbrandMap) ;
					freemarkerUtils.generate("agent/agent_brand.shtm",root,realPath+"/include/agent/agent_brand/brand_"+catalog+".jsp") ;  // 生成所有的品牌详显页
			}
	
		}
     }
	
	out.println("ok") ;
%>
