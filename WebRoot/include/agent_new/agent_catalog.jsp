<%@ page language="java" import="java.sql.Connection,java.util.*,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*" pageEncoding="UTF-8"%><%@ taglib tagdir="/WEB-INF/tags" prefix="tags" %><%@ taglib uri="/WEB-INF/classes/oscache.tld" prefix="cache"%>
<cache:cache cron="* * */14 * *">
<%	
	DBHelper dbHelper = DBHelper.getInstance();
	Connection connection = null;
	try{
		connection = dbHelper.getConnection();
			String usern = CommonString.getFormatPara(request.getParameter("usern"));
			String agentid = CommonString.getFormatPara(request.getParameter("agentid"));
			//查出代理商
			Map agentMap = dbHelper.getMap(" select * from pro_agent_factory where id = ? ",new Object [] {agentid},connection);
			usern = CommonString.getFormatPara(agentMap.get("usern"));
			//如果代理商是办事处，则查询办事处上级
			if(!"".equals(CommonString.getFormatPara(agentMap.get("parent_id")))&&!"0".equals(CommonString.getFormatPara(agentMap.get("parent_id")))){
				agentMap = dbHelper.getMap(" select * from pro_agent_factory where id = ? ",new Object [] {CommonString.getFormatPara(agentMap.get("parent_id"))},connection);
				agentid = CommonString.getFormatPara(agentMap.get("id"));
			}
			String agent_fac = CommonString.getFormatPara(agentMap.get("agent_fac"));
			String[] agent_facs = null;
			if(!"".equals(agent_fac)){
				if(agent_fac.indexOf(",") > 0){
					agent_facs = agent_fac.split(",") ;
				}else{
					agent_facs = new String [] {agent_fac};
				}
			}
			//获得品牌信息
			Map map = null ;
			String sel_map = "select id,usern,name,logo from pro_agent_factory where id =?" ;
			List<Map> agentList = new ArrayList() ;
			if(null!=agent_facs && agent_facs.length>0){
				for(int i=0;i<agent_facs.length;i++){
					 if(agent_facs[i].trim()!=""){
						  map = dbHelper.getMap(sel_map,new Object[]{agent_facs[i]},connection);
					 }
					 if(map!=null){
					 agentList.add(map) ;
					 }
				}
			}
			String sql = " select catalognum,catalogname from pro_agent_product_vi where agentid = '"+agentid+"' and factoryid = '"+agent_fac+"'  group by catalognum,catalogname order by catalognum ";
			List<Map> list = new ArrayList();
			if(null!=agentList&&agentList.size()>0){
			for(Map oneMap : agentList){
			  String id = CommonString.getFormatPara(oneMap.get("id")) ; 
%>
            <li style="background:url();"><a href="/agent_products.jsp?usern=<%=usern%>&factory=<%=id%>" style="font-size:14px;" title="<%=CommonString.getFormatPara(oneMap.get("name"))%>"><strong>>><%=CommonString.getFormatPara(oneMap.get("name"))%></strong></a></li>
          <%
				  			String sql2 = " select catalognum,catalogname from pro_agent_product_vi where agentid = '"+agentid+"' and factoryid = '"+id+"'  group by catalognum,catalogname order by catalognum ";
				  			List<Map> list2 = null;
				  			list2 = dbHelper.getMapList(sql2) ;
				  			if(null!=list2 && list2.size()>0){
				  				for(Map towMap:list2){
		  %>
		              <li><a title="<%=CommonString.getFormatPara(oneMap.get("name"))%><%=CommonString.getFormatPara(towMap.get("catalogname"))%>" href="/agent_products.jsp?usern=<%=usern%>&factory=<%=id%>&catalognum=<%=CommonString.getFormatPara(towMap.get("catalognum"))%>"><%=CommonString.getFormatPara(towMap.get("catalogname"))%></a></li>

	
<%}}}}%>
<%
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		DBHelper.freeConnection(connection);
	}
%>
</cache:cache>