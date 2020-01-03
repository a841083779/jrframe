<%@ page language="java" import="java.util.*,java.sql.*,com.jerehnet.util.dbutil.*" pageEncoding="UTF-8"%>
<%@page import="com.jerehnet.util.freemarker.FreemarkerUtils"%>
<%@page import="com.jerehnet.util.common.Common"%>
<%@page import="com.jerehnet.webservice.*"%>
<%@page import="com.jerehnet.util.freemarker.FreemarkerWebserviceUtils"%>
<%@page import="com.jerehnet.util.common.CommonString"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
   
    DBHelper dbHelper = DBHelper.getInstance() ;
	String realPath = Common.getAbsolutePath(request) ;
	FreemarkerUtils freemarkerUtils = new FreemarkerUtils(realPath+"template/") ; 
	String resule="false";
	String sql="";
	String sql1="";
	try{
		List <Map>list = null;
		List <Map>list1 = null;
		List <Map>list2 = null;
		Map root = new HashMap();
		Map root1 = new HashMap();
			//根据大类调取二级类别
				sql = "select id from pro_catalog where parentid=0 and is_show=1  order by id asc";
			    list = dbHelper.getMapList(sql);
				if(list != null && list.size() > 0){
					root.put("list",list);
					freemarkerUtils.generate("products_page/products_list_second_catalog.htm",root,realPath+"include/products_page/products_list_second_catalog.jsp");
					resule="true";
				}
				sql = "select  id,name from pro_agent_factory where flag=1 and is_show=1 order by upper_index asc";
			    list = dbHelper.getMapList(sql);
				if(list != null && list.size() > 0){
					root.put("list",list);
					freemarkerUtils.generate("products_page/products_list_catalog.htm",root,realPath+"include/products_page/products_list_catalog.jsp");
					resule="true";
				}
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		
	}
	out.println(resule) ;	
	%>