<%@ page language="java" import="org.apache.commons.httpclient.params.*,org.apache.commons.httpclient.*,org.apache.commons.httpclient.methods.*,com.jerehnet.webservice.*,java.util.regex.*,org.json.*,java.util.*,com.jerehnet.util.common.*,java.sql.*,com.jerehnet.util.dbutil.*" pageEncoding="UTF-8"%>
<%@page import="com.jerehnet.alipay.util.*"%>
<%
	 String sort_num = CommonString.getFormatPara(request.getParameter("sort_num"));	
	 Connection connection = null;
     DBHelper dbHelper = DBHelper.getInstance();
	 String rs = "fail"; 	
	 
	 try{
	    connection = dbHelper.getConnection();
	    List<Map> pictuelist = new ArrayList<Map>();
	    

		      String html="<ul>";
              String  people_sql = "select  m.nickname nickname,m.username username,l.jiangpin jiangpin from pro_member m,pro_web_lottery l where m.id=l.uid and (l.jiangpin is not null or l.jiangpin='') order by l.id desc " ;
	          
              List<Map> peopleList = null ;
              peopleList = dbHelper.getMapList(people_sql) ;
		      if(null!=peopleList && peopleList.size()>0){
		    	  Map oneMap = null ;
			      for(int i=0;i<peopleList.size();i++){
				  oneMap = (HashMap)peopleList.get(i);
				  
				  String username="";
				  if(CommonString.getFormatPara(oneMap.get("username")).length()>1){
					  username+=CommonString.getFormatPara(oneMap.get("username")).substring(0,1)+"***";
				  }else{
					  username+=CommonString.getFormatPara(oneMap.get("username"));
				  }
				  String jiangpin="";
				  if(CommonString.getFormatPara(oneMap.get("jiangpin")).length()>4){
					  jiangpin+=CommonString.getFormatPara(oneMap.get("jiangpin")).substring(0,4)+"***";
				  }else{
					  jiangpin+=CommonString.getFormatPara(oneMap.get("jiangpin"));
				  }
				  
	              html+="<li><span class='l'>"+username+"</span><span class='r'>"+jiangpin+"</span></li>"; 
	            }         
		      }    
		      html+="</ul>";
     out.print(html.toString());
	    
	 }catch(Exception e){
	 	e.printStackTrace();
	 }finally{
		DBHelper.freeConnection(connection);
	 }
	 //out.print(rs);
%>