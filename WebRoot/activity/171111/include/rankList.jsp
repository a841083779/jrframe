<%@ page language="java" import="java.util.*,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*,java.sql.*" pageEncoding="UTF-8"%>
<%@page import="java.net.URL"%>
<%@page import="java.net.HttpURLConnection"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="java.util.Random"%>
<%	
    DBHelper dbHelper = DBHelper.getInstance() ;
	Connection connection = null;
    response.setContentType("text/html;charset=utf-8");
    request.setCharacterEncoding("utf-8");

	try{
		connection=dbHelper.getConnection();
		
			String html="";
			List<Map>  ranklist = dbHelper.getMapList(" select tel,gift  from  activity_17double_eleven_game_log where gift_id>0 order by id desc",connection);
			if(ranklist != null && ranklist.size() > 0){
			  for(Map news:ranklist){
				  String tel=CommonString.getFormatPara(news.get("tel"));
				  String gift=CommonString.getFormatPara(news.get("gift"));
				  html+="<li>手机号"+tel.substring(0,3)+"****"+tel.substring(tel.length()-4,tel.length())+"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 获得"+gift+"一个</li>";
			  }
			}else{
				html="暂无获奖名单！";
			}
			out.print(html);

	}catch(Exception e){
		e.printStackTrace();
	}finally{
		dbHelper.freeConnection(connection);
	}
	
	
%>
