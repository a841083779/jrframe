<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.jerehnet.util.common.Common"%>
<%@page import="com.jerehnet.util.freemarker.FreemarkerUtils"%>
<%@page import="com.jerehnet.util.dbutil.DBHelper"%>
<%@page import="com.jerehnet.util.common.CommonString"%>
<%
	// 生成所有产品详细页
	String realPath = Common.getAbsolutePath(request) ;
	String catalog="";
	String nowPage="";
	FreemarkerUtils freemarkerUtils = new FreemarkerUtils(realPath+"template/") ;
	DBHelper dbHelper = DBHelper.getInstance() ;
	Map root = new HashMap() ;
	String factoryid="";
	String factory="";
	String factoryname="";
	List<Map> list = dbHelper.getMapList("select name,id from pro_agent_factory where   is_inner=1 and is_show=1 and flag=1 order by view_count desc ") ;
	        System.out.println("list="+list);
				
					root.put("list",list);
					freemarkerUtils.generate("inner_outer.shtm",root,realPath+"/include/inner_outer.htm");  // 生成所有的品牌详显页
		
						
		
		
		
	
%>
