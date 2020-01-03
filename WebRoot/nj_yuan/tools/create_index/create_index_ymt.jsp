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
	String cuuid = CommonString.getFormatPara(request.getParameter("cuuid"));
	String resule="false";
	try{
		List <Map>list = null;
		Map root = new HashMap();
	 if(cuuid.equals("BCB346C4-62CE-4AB5-AC03-95575229F516")){
			
			String sql = " select top 4  title,url,sub_title,img,order_no,area,area_name,end_time,sort_flag from pro_index_data  where channel_uuid = '"+cuuid+"' and is_pub = 1  order by order_no asc ";
			list = dbHelper.getMapList(sql);
			if(list != null && list.size() > 0){
				root.put("list",list);
				freemarkerUtils.generate("index_page/index_ymt.htm",root,realPath+"index_new/index_page/index_ymt.htm");
				resule="true";
			}	
	    }
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		
	}
	out.println(resule) ;	
	%>