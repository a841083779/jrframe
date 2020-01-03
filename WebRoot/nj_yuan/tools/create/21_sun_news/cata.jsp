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
	String catalognum="";
	String catalogname="";
	List<Map> list = dbHelper.getMapList("select num,name from pro_catalog where is_show=1  and LEN(num)<=6 ") ;
		if(null != list && list.size()>0){
			for(Map model:list){
			    catalognum=CommonString.getFormatPara(model.get("num"));
				catalogname=CommonString.getFormatPara(model.get("name"));
				root = new HashMap();
				root.put("catalognum", catalognum);
				root.put("catalogname", catalogname);
				freemarkerUtils.generate("news_21sun/hot_cata_pro.shtm",root,realPath+"/include/news_21sun/hot_cata_pro_for_"+catalognum+".htm") ;   
				freemarkerUtils.generate("news_21sun/hot_cata_pic.shtm",root,realPath+"/include/news_21sun/hot_cata_pic_for_"+catalognum+".htm") ;   
				freemarkerUtils.generate("news_21sun/related_brand.shtm",root,realPath+"/include/news_21sun/related_brand_for_"+catalognum+".htm") ;   
			}
		}
		
	out.println("ok") ;
%>
