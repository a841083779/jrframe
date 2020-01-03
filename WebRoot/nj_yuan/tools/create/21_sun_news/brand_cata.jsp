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
	String factoryid="";
	String factoryname="";
	List<Map> list = dbHelper.getMapList("select num,name from pro_catalog where is_show=1  and LEN(num)<=6 ") ;
		if(null != list && list.size()>0){
			for(Map model:list){
			    catalognum=CommonString.getFormatPara(model.get("num"));
				catalogname=CommonString.getFormatPara(model.get("name"));
				root = new HashMap();
				root.put("catalognum", catalognum);
				root.put("catalogname", catalogname);
				List<Map> listF = dbHelper.getMapList("select factoryid,factoryname from pro_products where is_show=1 and  catalognum like '"+catalognum+"%' and factoryid!='' and factoryid is not null   group by factoryid,factoryname ") ;
				if(null != listF && listF.size()>0){
				        for(Map modelF:listF){
						   factoryid=CommonString.getFormatPara(modelF.get("factoryid"));
						   factoryname=CommonString.getFormatPara(modelF.get("factoryname"));
						   root.put("factoryid", factoryid);
						    root.put("factoryname", factoryname);
						   freemarkerUtils.generate("news_21sun/hot_cata_brand_pic.shtm",root,realPath+"/include/news_21sun/hot_cata_brand_pic_for_"+factoryid+"_"+catalognum+".htm") ;   
				           freemarkerUtils.generate("news_21sun/hot_cata_brand_pro.shtm",root,realPath+"/include/news_21sun/hot_cata_brand_pro_for_"+factoryid+"_"+catalognum+".htm") ; 
				        }
				}
  

			}
		}
		
	out.println("ok") ;
%>
