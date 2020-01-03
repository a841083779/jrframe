<%@ page language="java" import="java.sql.Connection,com.jerehnet.webservice.*,org.json.*,java.util.*,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="tags"%>
<%@ taglib uri="/WEB-INF/classes/oscache.tld" prefix="cache"%>
<%%
    DBHelper dbHelper = DBHelper.getInstance();
	Connection connectioned = null;
	try{
		connectioned = dbHelper.getConnection();
	String factoryid = CommonString.getFormatPara(request.getParameter("factoy_id")) ;
	String catalog = CommonString.getFormatPara(request.getParameter("catalog")) ;
	String catalog_first = CommonString.getFormatPara(request.getParameter("catalog_first")) ;
	String catalog_detail = CommonString.getFormatPara(request.getParameter("catalog_detail")) ;
	String tonandmeter = CommonString.getFormatPara(request.getParameter("tonandmeter")) ;
	String order = CommonString.getFormatPara(request.getParameter("order")) ;
	String flag = CommonString.getFormatPara(request.getParameter("flag")) ;
	String url = "/products/prolist_text.jsp";
	if(flag.equals("photo")){
		url = "/list.jsp";
	}
	String where="select ";
	
	
	List<Map> list = dbHelper.getMapList("select name,id from pro_agent_factory id in(select distinct(pro_products.factoryid) from pro_products  where catalognum='"+catalog+"') and is_inner=1,connectioned) ;
	
	for(int i = 0;list != null && i < list.size();i++){
						Map m = list.get(i);
					    String factoryname=(String)CommonString.getFormatPara(m.get("name"));
						String id = CommonString.getFormatPara(m.get("id"));
%>
	                  <a href="<%url%>?factoryid=<%=id%><%=catalog.equals("")?"":"&catalog="+catalog%><%=tonandmeter.equals("")?"":"&tonandmeter="+tonandmeter%><%=order.equals("")?"":"&order="+order%>"><%=factoryname%></a>


 <%
	}}catch(Exception e){
		e.printStackTrace();
	}finally{
		DBHelper.freeConnection(connectioned);
	}
%>