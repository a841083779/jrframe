<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.jerehnet.util.common.Common"%>
<%@page import="com.jerehnet.util.freemarker.FreemarkerUtils"%>
<%@page import="com.jerehnet.util.dbutil.DBHelper"%>
<%@page import="com.jerehnet.util.common.CommonString"%>
<%
	Map catalogMap = (HashMap)application.getAttribute("catalogMap") ;
	// 生成所有产品详细页
	String absPath = Common.getAbsolutePath(request) ;
	FreemarkerUtils freemarkerUtils = new FreemarkerUtils(absPath+"template/") ; 
	DBHelper dbHelper = DBHelper.getInstance() ;
	Map root = null;
	String realPath = Common.getAbsolutePath(request) ;



        List<Map> list = dbHelper.getMapList(" select * from pro_products where id=18533 and  is_show=1 and  file_name is not null ") ;			
		if(null != list && list.size()>0){
			for(Map model:list){
				root = new HashMap();
				//产品的品牌信息
				String sql=" select full_name,logo from pro_agent_factory where id="+model.get("factoryid");
				List<Map> brandInfo = dbHelper.getMapList(sql) ;
				if(null != brandInfo && brandInfo.size()>0){
					for(Map brandMode:brandInfo){
						root.put("brandMode", brandMode);
					}
				}
				//产品品牌信息结束
				String catalognum = (String)model.get("catalognum") ;
				String precatalogname = CommonString.getFormatPara(catalognum).length()>6?CommonString.getFormatPara(catalogMap.get(catalognum.substring(0,6))):CommonString.getFormatPara(catalogMap.get(catalognum)) ;
				root.put("model", model);
				root.put("precatalogname",precatalogname) ;
				String fileName = CommonString.getFormatPara(model.get("file_name"));	
				freemarkerUtils.generate("/mobile/proDetail.htm",root,realPath+"/mobile/proDetail/"+fileName) ;  				

			}
		}
	out.println("ok") ;
%>
