<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.jerehnet.util.common.Common"%>
<%@page import="com.jerehnet.util.freemarker.FreemarkerUtils"%>
<%@page import="com.jerehnet.util.dbutil.DBHelper"%>
<%@page import="com.jerehnet.util.common.CommonString"%>
<%
	Map catalogMap = (HashMap)application.getAttribute("catalogMap") ;
	// 生成所有产品详细页
	String realPath = Common.getAbsolutePath(request) ;
	FreemarkerUtils freemarkerUtils = new FreemarkerUtils(realPath+"template/") ;
	DBHelper dbHelper = DBHelper.getInstance() ;
	Map root = null;
	String factoryid="";
	String factoryname="";
	List<Map> list = dbHelper.getMapList("select id,name from pro_agent_factory where is_show=1 and  flag = 1 and usern<>'tdbenniu'  ") ;
		if(null != list && list.size()>0){
			for(Map model:list){
			    factoryid=CommonString.getFormatPara(model.get("id"));
				factoryname=CommonString.getFormatPara(model.get("name"));
				root = new HashMap();
				root.put("factoryid", factoryid);
				root.put("factoryname", factoryname);
				//freemarkerUtils.generate("news_21sun/hot_brand_pro.shtm",root,realPath+"/include/news_21sun/hot_brand_pro_for_"+factoryid+".htm") ;  
				//freemarkerUtils.generate("news_21sun/hot_brand_pic.shtm",root,realPath+"/include/news_21sun/hot_brand_pic_for_"+factoryid+".htm") ;  
			    //freemarkerUtils.generate("news_21sun/agent_list.shtm",root,realPath+"/include/news_21sun/agent_list_for_"+factoryid+".htm") ; 
			    freemarkerUtils.generate("news_21sun/brand_main_pro.shtm",root,realPath+"/include/news_21sun/brand_main_pro_for_"+factoryid+".htm") ;  				
			}
		}
		
	out.println("ok") ;
%>
