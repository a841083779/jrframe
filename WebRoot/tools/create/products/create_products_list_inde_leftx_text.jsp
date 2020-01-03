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
		List<String> letters = new ArrayList<String>(0);	

            	letters.add("A");letters.add("B");letters.add("C");letters.add("D");letters.add("E");letters.add("F");letters.add("G");letters.add("H");
				letters.add("I");letters.add("J");letters.add("K");letters.add("L");letters.add("M");letters.add("N");letters.add("O");letters.add("P");
				letters.add("Q");letters.add("R");letters.add("S");letters.add("T");letters.add("U");letters.add("V");letters.add("W");letters.add("X");
				letters.add("Y");letters.add("Z");
				
				String sql2 ="select paf.id,paf.upper_index,paf.name from pro_products pp ,pro_agent_factory paf where pp.factoryid = paf.id   and pp.is_show=1 and paf.is_show=1 and paf.is_inner=1 group by paf.upper_index,paf.name,paf.usern,paf.id order by paf.upper_index,paf.name";
				list2 = dbHelper.getMapList(sql2);
				for(int i=0;i<letters.size();i++){
						String pinyin=CommonString.getFormatPara(letters.get(i));
						for(int j=0;j<list2.size();j++){
								String id=CommonString.getFormatPara(list2.get(j).get("id"));
								String upper_index=CommonString.getFormatPara(list2.get(j).get("upper_index"));
								String name=CommonString.getFormatPara(list2.get(j).get("name"));
if(pinyin.equals(upper_index)){%><a href="/products/prolist.jsp?factory=<%=id%>" id="to_<%=upper_index%>"><%=name%></a>　<%}}%><br/><%}	
				
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		
	}
	
	%>