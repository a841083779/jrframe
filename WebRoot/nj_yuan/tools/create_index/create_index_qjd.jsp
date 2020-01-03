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
	 if(cuuid.equals("0D3A1387-FE1D-4599-98F8-7D55E4E2A51E")){
			
			String sql = " select  title,url,img,order_no,pro_img from pro_index_data  where channel_uuid = '"+cuuid+"' and is_pub = 1  order by order_no asc ";
			list = dbHelper.getMapList(sql);
			if(list != null && list.size() > 0){//banner图 
				root.put("list",list);
				freemarkerUtils.generate("index_page/index_qjd.htm",root,realPath+"index_new/index_page/index_qjd.htm");
				resule="true";
			}	
	    }
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		
	}
	out.println(resule) ;	
	%>