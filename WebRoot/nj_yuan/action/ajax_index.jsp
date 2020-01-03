<%@ page language="java" import="org.apache.commons.httpclient.params.*,org.apache.commons.httpclient.*,org.apache.commons.httpclient.methods.*,com.jerehnet.webservice.*,java.util.regex.*,org.json.*,java.util.*,com.jerehnet.util.common.*,java.sql.*,com.jerehnet.util.dbutil.*" pageEncoding="UTF-8"%>
<%@page import="com.jerehnet.alipay.util.*"%>
<%
	 String subtype = CommonString.getFormatPara(request.getParameter("subtype"));
	 
	 
	 String brand = CommonString.getFormatPara(request.getParameter("brand"));	//品牌
	 String catalognum = CommonString.getFormatPara(request.getParameter("catalognum"));  //分类
	 String model = CommonString.getFormatPara(request.getParameter("model"));	    //型号
	 	
	 
	 Connection connection = null;
     DBHelper dbHelper = DBHelper.getInstance();
	 String rs = "fail"; 	
	 try{
	    connection = dbHelper.getConnection();
	    List<Map> pictuelist = new ArrayList<Map>(); 
	    String proSql = "SELECT id,name from pro_products WHERE  id="+model;
	    List<Map> productsList = dbHelper.getMapList(proSql);	         
	    String modelname=CommonString.getFormatPara(productsList.get(0).get("name"));   
	    //查询品牌
	    String  hangye_sql = "select file_name from pro_products  where name='"+ modelname +"' and catalognum  like '"+ brand +"%' and factoryid ="+catalognum ;	          
	    pictuelist = dbHelper.getMapList(hangye_sql) ;
        String file_name="/proDetail/"+CommonString.getFormatPara(pictuelist.get(0).get("file_name"));
        //System.out.println("+++"+file_name);
        out.print(file_name.toString());
        

	 }catch(Exception e){
	 	e.printStackTrace();
	 }finally{
		DBHelper.freeConnection(connection);
	 }
	 //out.print(rs);
%>