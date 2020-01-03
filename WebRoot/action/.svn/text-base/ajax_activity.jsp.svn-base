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
	    
	    //行业图片
		if("107001".equals(sort_num)){
		      String html="<ul>";
              String  hangye_sql = "select top 3 id,title,add_user,image,vote_count,add_date,contents   from  pro_photo_group  where sort_num like '%107001%' and is_show=1 order by add_date desc" ;
	          
	          pictuelist = dbHelper.getMapList(hangye_sql) ;
	          String image="";
	          for(int i=0;i<pictuelist.size();i++){
	          if(CommonString.getFormatPara(pictuelist.get(i).get("image")).indexOf("resource.21-sun.com")>0){
	             image=CommonString.getFormatPara(pictuelist.get(i).get("image"));
	          }else{
	             image="http://product.21-sun.com/uploadfiles/"+CommonString.getFormatPara(pictuelist.get(i).get("image"));
	          }
	          
	          String id=CommonString.getFormatPara(pictuelist.get(i).get("id"));
	          String contents=CommonString.getFormatPara(pictuelist.get(i).get("contents"));
              String title=CommonString.getFormatPara(pictuelist.get(i).get("title"));
              if(contents.length()>14){contents=contents.substring(0,14)+"...";}
              if(contents.equals("")){contents="无";}
              
              
	             html+="<li><a href='http://photo.21-sun.com/ndetail_for_"+ id +".htm' class='img'><img src='"+ image +"'></a><div class='info'>" 
	             +"<a href='http://photo.21-sun.com/ndetail_for_"+ id +".htm'>"+ pictuelist.get(i).get("title") +"<br>拍摄者："+ pictuelist.get(i).get("add_user") +"<br>描述："+ contents +"</a></div></li>";
	          }         
              html+="<li class='last'><a href='/mobile/photo/index_list.jsp?catalog=107001' target='_blank' class='img'><img src='./web/img/more.png'></a></li></ul>";
			  out.print(html.toString());
		      
		//产品图片
		}else if("107002".equals(sort_num)){
              String html="<ul>";
	          String pro_sql = "select top 3 id,title,add_user,image,vote_count,add_date,contents   from  pro_photo_group  where sort_num like '%107002%' and is_show=1 order by  add_date desc" ;
	          pictuelist = dbHelper.getMapList(pro_sql) ;
	          String image="";
	          for(int i=0;i<pictuelist.size();i++){
	          if(CommonString.getFormatPara(pictuelist.get(i).get("image")).indexOf("resource.21-sun.com")>0){
	             image=CommonString.getFormatPara(pictuelist.get(i).get("image"));
	          }else{
	             image="http://product.21-sun.com/uploadfiles/"+CommonString.getFormatPara(pictuelist.get(i).get("image"));
	          }
	          String id=CommonString.getFormatPara(pictuelist.get(i).get("id"));
	          String contents=CommonString.getFormatPara(pictuelist.get(i).get("contents"));
              String title=CommonString.getFormatPara(pictuelist.get(i).get("title"));
              if(contents.length()>14){contents=contents.substring(0,14)+"...";}
              if(contents.equals("")){contents="无";}
              
              
	             html+="<li><a href='http://photo.21-sun.com/ndetail_for_"+ id +".htm' class='img'><img src='"+ image +"'></a><div class='info'>" 
	             +"<a href='http://photo.21-sun.com/ndetail_for_"+ id +".htm'>"+ pictuelist.get(i).get("title") +"<br>拍摄者："+ pictuelist.get(i).get("add_user") +"<br>描述："+ contents +"</a></div></li>";
	          }         
              html+="<li class='last'><a href='/mobile/photo/index_list.jsp?catalog=107002' target='_blank' class='img'><img src='./web/img/more.png'></a></li></ul>";
			  out.print(html.toString());
		//施工图片
		}else if("107003".equals(sort_num)){
	          String html="<ul>";
	          String shigong_sql = "select top 3 id,title,add_user,image,vote_count,add_date,contents  from  pro_photo_group  where sort_num like '%107003%' and is_show=1 order by  add_date desc" ;   
	          pictuelist = dbHelper.getMapList(shigong_sql) ;
	          String image="";
	          for(int i=0;i<pictuelist.size();i++){
	          if(CommonString.getFormatPara(pictuelist.get(i).get("image")).indexOf("resource.21-sun.com")>0){
	             image=CommonString.getFormatPara(pictuelist.get(i).get("image"));
	          }else{
	             image="http://product.21-sun.com/uploadfiles/"+CommonString.getFormatPara(pictuelist.get(i).get("image"));
	          }
	          
	          String id=CommonString.getFormatPara(pictuelist.get(i).get("id"));
	          String contents=CommonString.getFormatPara(pictuelist.get(i).get("contents"));
              String title=CommonString.getFormatPara(pictuelist.get(i).get("title"));
              if(contents.length()>14){contents=contents.substring(0,14)+"...";}
              if(contents.equals("")){contents="无";}
	             html+="<li><a href='http://photo.21-sun.com/ndetail_for_"+ id +".htm' class='img'><img src='"+ image +"'></a><div class='info'>" 
	             +"<a href='http://photo.21-sun.com/ndetail_for_"+ id +".htm'>"+ pictuelist.get(i).get("title") +"<br>拍摄者："+ pictuelist.get(i).get("add_user") +"<br>描述："+ contents +"</a></div></li>";
	          }         
              html+="<li class='last'><a href='/mobile/photo/index_list.jsp?catalog=107003' target='_blank' class='img'><img src='./web/img/more.png'></a></li></ul>";
			  out.print(html.toString());
		//维修图片
		}else if("107004".equals(sort_num)){
	          String html="<ul>";
	          String weixiu_sql = "select top 3 id,title,add_user,image,vote_count,add_date,contents  from  pro_photo_group  where sort_num like '%107004%' and is_show=1 order by  add_date desc" ;	          
	          pictuelist = dbHelper.getMapList(weixiu_sql) ;
	          String image="";
	          for(int i=0;i<pictuelist.size();i++){
	          if(CommonString.getFormatPara(pictuelist.get(i).get("image")).indexOf("resource.21-sun.com")>0){
	             image=CommonString.getFormatPara(pictuelist.get(i).get("image"));
	          }else{
	             image="http://product.21-sun.com/uploadfiles/"+CommonString.getFormatPara(pictuelist.get(i).get("image"));
	          }
	          
	          String id=CommonString.getFormatPara(pictuelist.get(i).get("id"));
	          String contents=CommonString.getFormatPara(pictuelist.get(i).get("contents"));
              String title=CommonString.getFormatPara(pictuelist.get(i).get("title"));
              if(contents.length()>14){contents=contents.substring(0,14)+"...";}
              if(contents.equals("")){contents="无";}
	             html+="<li><a href='http://photo.21-sun.com/ndetail_for_"+ id +".htm' class='img'><img src='"+ image +"'></a><div class='info'>" 
	             +"<a href='http://photo.21-sun.com/ndetail_for_"+ id +".htm'>"+ pictuelist.get(i).get("title") +"<br>拍摄者："+ pictuelist.get(i).get("add_user") +"<br>描述："+ contents +"</a></div></li>";
	          }         
              html+="<li class='last'><a href='/mobile/photo/index_list.jsp?catalog=107004' target='_blank' class='img'><img src='./web/img/more.png'></a></li></ul>";
			  out.print(html.toString());
		//展会图片
		}else if("107005".equals(sort_num)){
		
	          String html="<ul>";
	          String zhanhui_sql = "select top 3 id,title,add_user,image,vote_count,add_date,contents  from  pro_photo_group  where sort_num like '%107005%' and is_show=1 order by  add_date desc" ;	          
	          pictuelist = dbHelper.getMapList(zhanhui_sql) ;
	          String image="";
	          for(int i=0;i<pictuelist.size();i++){
	          if(CommonString.getFormatPara(pictuelist.get(i).get("image")).indexOf("resource.21-sun.com")>0){
	             image=CommonString.getFormatPara(pictuelist.get(i).get("image"));
	          }else{
	             image="http://product.21-sun.com/uploadfiles/"+CommonString.getFormatPara(pictuelist.get(i).get("image"));
	          }
	          
	          String id=CommonString.getFormatPara(pictuelist.get(i).get("id"));
	          String contents=CommonString.getFormatPara(pictuelist.get(i).get("contents"));
              String title=CommonString.getFormatPara(pictuelist.get(i).get("title"));
              if(contents.length()>14){contents=contents.substring(0,14)+"...";}
              if(contents.equals("")){contents="无";}
	             html+="<li><a href='http://photo.21-sun.com/ndetail_for_"+ id +".htm' class='img'><img src='"+ image +"'></a><div class='info'>" 
	             +"<a href='http://photo.21-sun.com/ndetail_for_"+ id +".htm'>"+ pictuelist.get(i).get("title") +"<br>拍摄者："+ pictuelist.get(i).get("add_user") +"<br>描述："+ contents +"</a></div></li>";
	          }         
              html+="<li class='last'><a href='/mobile/photo/index_list.jsp?catalog=107005' target='_blank' class='img'><img src='./web/img/more.png'></a></li></ul>";
			  out.print(html.toString());
		
		//趣味图片
		}else if("107006".equals(sort_num)){
		      String html="<ul>";
	          String quwei_sql = "select top 3 id,title,add_user,image,vote_count,add_date,contents   from  pro_photo_group  where sort_num like '%107006%' and is_show=1 order by  add_date desc" ;	          
	          pictuelist = dbHelper.getMapList(quwei_sql) ;
	          String image="";
	          for(int i=0;i<pictuelist.size();i++){
	          if(CommonString.getFormatPara(pictuelist.get(i).get("image")).indexOf("resource.21-sun.com")>0){
	             image=CommonString.getFormatPara(pictuelist.get(i).get("image"));
	          }else{
	             image="http://product.21-sun.com/uploadfiles/"+CommonString.getFormatPara(pictuelist.get(i).get("image"));
	          }
	          
	          String id=CommonString.getFormatPara(pictuelist.get(i).get("id"));
	          String contents=CommonString.getFormatPara(pictuelist.get(i).get("contents"));
              String title=CommonString.getFormatPara(pictuelist.get(i).get("title"));
              if(contents.length()>14){contents=contents.substring(0,14)+"...";}
              if(contents.equals("")){contents="无";}
	             html+="<li><a href='http://photo.21-sun.com/ndetail_for_"+ id +".htm' class='img'><img src='"+ image +"'></a><div class='info'>" 
	             +"<a href='http://photo.21-sun.com/ndetail_for_"+ id +".htm'>"+ pictuelist.get(i).get("title") +"<br>拍摄者："+ pictuelist.get(i).get("add_user") +"<br>描述："+ contents +"</a></div></li>";
	          }         
              html+="<li class='last'><a href='/mobile/photo/index_list.jsp?catalog=107006' target='_blank' class='img'><img src='./web/img/more.png'></a></li></ul>";
			  out.print(html.toString());
		}else{
		  //所有类别
	        
		
		}
	    
	    
	    
	    
	    
	    
	    
	 }catch(Exception e){
	 	e.printStackTrace();
	 }finally{
		DBHelper.freeConnection(connection);
	 }
	 //out.print(rs);
%>