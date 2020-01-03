<%@ page language="java" import="java.util.*,java.sql.*,com.jerehnet.util.file.HtmlParser,java.util.regex.*" pageEncoding="UTF-8"%>
<%@page import="com.jerehnet.util.common.Common"%>
<%@page import="com.jerehnet.util.freemarker.FreemarkerUtils"%>
<%@page import="com.jerehnet.util.dbutil.*"%>
<%@page import="com.jerehnet.util.file.FileUtils"%>
<%@page import="com.jerehnet.util.common.CommonString"%>
<%	
	DBHelper dbHelper = DBHelper.getInstance() ;
    Connection connection = null;
	try{
		connection = dbHelper.getConnection();
		connection.setAutoCommit(false);
		//把产品详细页面的图片下载下来
		List<Map> list = dbHelper.getMapList(" select img2 from pro_products where img2 is not null and img2 != '' ") ;

		for(int i = 0;list!=null && i<list.size();i++){
			try{
				FileUtils.downloadFromUrl("http://product.21-sun.com/uploadfiles/"+list.get(i).get("img2"),"E:/workspace/21sun_products_2012/zdownimg2/");
				Common.println(i+":"+"http://product.21-sun.com/uploadfiles/"+list.get(i).get("img2"));
			}catch(Exception ex){
				ex.printStackTrace();
				Common.println("http://product.21-sun.com/uploadfiles/"+list.get(i).get("img2")+"---未找到链接");
			}
		}
				
	}catch(Exception ex){
		ex.printStackTrace();
	}finally{
		dbHelper.freeConnection(connection);
	}
	out.println("ok") ;
%>
