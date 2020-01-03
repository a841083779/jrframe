<%@page import="java.sql.Connection"%>
<%@page import="com.jerehnet.util.common.Common"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.jerehnet.util.common.CommonString"%>
<%@page import="com.jerehnet.util.dbutil.DBHelper"%>
<% 
	Map memberInfo = (Map)session.getAttribute("memberInfo");
	String username = "";
	if(memberInfo != null){
		username = CommonString.getFormatPara(memberInfo.get("username"));
	}
	
	DBHelper dbHelper = DBHelper.getInstance();
	Connection connection = null;
	List<Map> proLists = null;
	List<Map> faLists = null;
	List<Map> hotLists = null;
	List<Map> hot_pro= null;

	try{
		connection = dbHelper.getConnection();
            //类别
	       String sql="select  catalognum,catalogname from pro_catalog_factory where factoryid=136";
			proLists = dbHelper.getMapList(sql);
			
			 //品牌
	       String fa_sql="select  id,name from pro_agent_factory where flag=1 and is_show=1";
			faLists = dbHelper.getMapList(fa_sql);

		//热门产品
		String query="select  top 4 id,count(id) as countd from pro_products where  img2!='' and is_show=1 group by id  order by countd desc";
		hotLists = dbHelper.getMapList(query);

%>
     <div class="_option hide"> 
     	 <div class="kba_words">
          	<a href="#">A</a><a href="#">B</a><a href="#">C</a><a href="#">D</a><a href="#">E</a><a href="#">F</a><a href="#">G</a><a href="#">H</a><a href="#">I</a><a href="#">J</a><a href="#">K</a><a href="#">L</a><a href="#">M</a><a href="#">N</a><a href="#">O</a><a href="#">P</a><a href="#">Q</a><a href="#">R</a><a href="#">S</a><a href="#">T</a><a href="#">U</a><a href="#">V</a><a href="#">W</a><a href="#">X</a><a href="#">Y</a><a href="#">Z</a>
          </div>
          <!--A-->
		  <%
		  String sql2 = "select paf.upper_index from pro_products pp ,pro_agent_factory paf where pp.factoryid = paf.id ";
		
        sql2 += " group by paf.upper_index ";	
		List <Map>list7 = dbHelper.getMapList(sql2,connection);	
		
		String upLetter = "";
		String letter = "";
		List<Map>list_sub =null;
		int n = 0;
		
		 
		 for(int k = 0; list7 != null && k < list7.size();k++){
			String lettered = list7.get(k).get("upper_index").toString().toUpperCase();
		%><div class="fix akb_brand_list">
              <div class="kba_key"><%=lettered%></div>
              <%
                 String sql5 = "select paf.id,paf.upper_index,paf.name,paf.usern from pro_products pp ,pro_agent_factory paf where pp.factoryid = paf.id and paf.upper_index like '%"+lettered+"%'";
		
        sql5 += " group by paf.upper_index,paf.name,paf.usern,paf.id order by paf.upper_index,paf.name ";	
		List <Map>list2 = dbHelper.getMapList(sql5,connection);	
		  for(int i = 0; list2 != null && i < list2.size();i++){
			letter = list2.get(i).get("upper_index").toString().toUpperCase();
	if(!letter.equals(upLetter)){
			n++;
		  
                if(letter.equals(lettered)){
                %>
              
              <a href="<%=list2.get(i).get("id").toString()%>" data-val="<%=list2.get(i).get("id").toString()%>" ><%=list2.get(i).get("name").toString()%></a>
              <%}}}%>
          </div>
		  </div>
		  <%}%>
          <!--A end-->
       
	<%
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		dbHelper.freeConnection(connection);
	}
%>		   
			   
			   
			   
			   
			   
			   
			   
			   
			   
			   
			   
			   
			   
			   
			   