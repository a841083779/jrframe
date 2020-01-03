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
	List<Map> list = dbHelper.getMapList(" select * from pro_products where is_show = 1 and file_name is not null  ") ;
		
		if(null != list && list.size()>0){
			for(Map model:list){
				 String catalognum = (String)model.get("catalognum") ;
				 String precatalogname = CommonString.getFormatPara(catalognum).length()>6?CommonString.getFormatPara(catalogMap.get(catalognum.substring(0,6))):CommonString.getFormatPara(catalogMap.get(catalognum)) ;
				root = new HashMap();
				root.put("model", model);
				root.put("precatalogname",precatalogname) ;
				String pageFlag1 = "paras";	
				String fileName = CommonString.getFormatPara(model.get("file_name"));
				String  createName1 = absPath+"proDetail/"+fileName;
				root.put("cName1","/proDetail/"+fileName);
				
				String pageFlag2 = "intro";
				String fileName2 = fileName.substring(0,fileName.lastIndexOf(".shtm")>=0?fileName.lastIndexOf(".shtm"):fileName.length())+"_"+pageFlag2+".shtm";
				String createName2 = absPath+"proDetail/"+fileName2;			
				root.put("cName2","/proDetail/"+fileName2);
				
				String pageFlag3 = "pic";
				String fileName3 = fileName.substring(0,fileName.lastIndexOf(".shtm")>=0?fileName.lastIndexOf(".shtm"):fileName.length())+"_"+pageFlag3+".shtm";
				String createName3 = absPath+"proDetail/"+fileName3;			
				root.put("cName3","/proDetail/"+fileName3);
				
				String pageFlag4 = "agent";
				String fileName4 = fileName.substring(0,fileName.lastIndexOf(".shtm")>=0?fileName.lastIndexOf(".shtm"):fileName.length())+"_"+pageFlag4+".shtm";
				String createName4 = absPath+"proDetail/"+fileName4;			
				root.put("cName4","/proDetail/"+fileName4);
				
				String pageFlag5 = "message";
				String fileName5 = fileName.substring(0,fileName.lastIndexOf(".shtm")>=0?fileName.lastIndexOf(".shtm"):fileName.length())+"_"+pageFlag5+".shtm";
				String createName5 = absPath+"proDetail/"+fileName5;			
				root.put("cName5","/proDetail/"+fileName5);
				
				String pageFlag6 = "order";
				String fileName6 = fileName.substring(0,fileName.lastIndexOf(".shtm")>=0?fileName.lastIndexOf(".shtm"):fileName.length())+"_"+pageFlag6+".shtm";
				String createName6 = absPath+"proDetail/"+fileName6;			
				root.put("cName6","/proDetail/"+fileName6);
							
				root.put("pageFlag",pageFlag1);
				freemarkerUtils.generate("/proDetail/detail.shtm", root, createName1 ,request);
							
				root.put("pageFlag",pageFlag2);
				freemarkerUtils.generate("/proDetail/detail.shtm", root, createName2 ,request);
				
				root.put("pageFlag",pageFlag3);
				freemarkerUtils.generate("/proDetail/detail.shtm", root, createName3 ,request);
				
				root.put("pageFlag",pageFlag4);
				freemarkerUtils.generate("/proDetail/detail.shtm", root, createName4 ,request);
				
				root.put("pageFlag",pageFlag5);
				freemarkerUtils.generate("/proDetail/detail.shtm", root, createName5 ,request);
				
				root.put("pageFlag",pageFlag6);
				freemarkerUtils.generate("/proDetail/detail.shtm", root, createName6 ,request);
			}
		}
	out.println("ok") ;
%>
