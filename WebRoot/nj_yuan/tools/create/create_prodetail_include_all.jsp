<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.jerehnet.util.common.Common"%>
<%@page import="com.jerehnet.util.freemarker.FreemarkerUtils"%>
<%@page import="com.jerehnet.util.dbutil.DBHelper"%>
<%@page import="com.jerehnet.util.common.CommonString"%>
<%
	Map catalogMap = (HashMap)application.getAttribute("catalogMap") ;
	String realPath = Common.getAbsolutePath(request) ;
	String absPath = Common.getAbsolutePath(request) ;
	FreemarkerUtils freemarkerUtils = new FreemarkerUtils(absPath+"template/") ; 
	DBHelper dbHelper = DBHelper.getInstance() ;
	Map root = null;
	List<Map> pro_list = dbHelper.getMapList("select  *  from pro_products order by view_count desc") ;
	if(null != pro_list && pro_list.size()>0){
	    root = new HashMap();
		for(Map oneMap:pro_list){
			root.put("pro_id",CommonString.getFormatPara(oneMap.get("id"))) ;
			root.put("factoryname",CommonString.getFormatPara(oneMap.get("factoryname"))) ;
			root.put("proname",CommonString.getFormatPara(oneMap.get("name"))) ;
			root.put("catalogname",CommonString.getFormatPara(oneMap.get("catalogname"))) ;
            freemarkerUtils.generate("proDetail/include_comment_list.shtm",root,realPath+"/include/prodetail_comment/comment_list_"+CommonString.getFormatPara(oneMap.get("id"))+".htm") ;
			freemarkerUtils.generate("proDetail/include_order_list.shtm",root,realPath+"/include/prodetail_order/order_list_"+CommonString.getFormatPara(oneMap.get("id"))+".htm") ;
		}
	}
	out.println("ok") ;
%>
