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
		

           List<Map> list = dbHelper.getMapList(" select * from pro_products where  id=12813 and  file_name is not null order by id asc") ;			
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
				
				String pageFlag1 = "paras";	
				String fileName = CommonString.getFormatPara(model.get("file_name"));
				String  createName1 = absPath+"proDetail/"+fileName;
				root.put("cName1","/proDetail/"+fileName);
				
				
				String pageFlag11 = "shouhou";
				String fileName11 = fileName.substring(0,fileName.lastIndexOf(".shtm")>=0?fileName.lastIndexOf(".shtm"):fileName.length())+"_"+pageFlag11+".shtm";
				String createName11 = absPath+"proDetail/"+fileName11;			
				root.put("cName11","/proDetail/"+fileName11);	
				
				
				root.put("pageFlag",pageFlag11);
				freemarkerUtils.generate("/proDetail/detail_shouhou.shtm", root, createName11 ,request);
			}
		}
	out.println("ok") ;
%>
