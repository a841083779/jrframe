<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%><%@page import="com.jerehnet.util.common.CommonString"%><%@page import="com.jerehnet.util.dbutil.DBHelper"%><%@ page session="false" %><%@ taglib uri="/WEB-INF/classes/oscache.tld" prefix="cache"%><%
	String factoryid = CommonString.getFormatPara(request.getParameter("factoryid")) ;
	String catalog = CommonString.getFormatPara(request.getParameter("catalog")) ;
	Map brandMap = (HashMap)application.getAttribute("brandMap") ;
	Map catalogMap = (Map)application.getAttribute("catalogMap") ;
	String catalogName="";
	if(catalog!=null && !catalog.equals("")){
	if(catalog.length()>6){catalog=catalog.substring(0,6);}
	catalogName=CommonString.getFormatPara(catalogMap.get(catalog));
	}
	String cacheKey = "koubei_brand_"+catalog;
	DBHelper dbHelper = DBHelper.getInstance() ;
	String whereStr = "";
	if(catalog!=null && !catalog.equals("")){
		whereStr = " and catalognum  like '"+catalog+"%'";
	}
	String brandSql = "select top 15  factoryid,sum(view_count) as sumCount from pro_products where 1=1 "+whereStr+"   group by factoryid  order by sum(view_count) desc";
	
%>
<cache:cache cron="* * */1 * *" key="<%=cacheKey%>">
<%
	List<Map> brandList = dbHelper.getMapList(brandSql);
  if(null!=brandList && brandList.size()>0){
	  int i = 1 ;
	  Map m=null;
	  for(Map bMap:brandList){
		  String id = CommonString.getFormatPara(bMap.get("factoryid"));
		  String sumCount = CommonString.getFormatPara(bMap.get("sumCount"));
		  if(id!=null && !id.equals("")){
			   m = dbHelper.getMap("select name from pro_agent_factory where id="+id);
		  }
		  if(m!=null){
%>
	<li <% if(i<=3){ %>class="top3"<%} %><% if(i==15){ %>style="border-bottom:none;"<%} %>> <em><%=i %></em>
          <h4><a target="_blank" href="/<%=catalog %>-<%=id %>-0.htm" title="<%=CommonString.getFormatPara(m.get("name")).replace("卡特彼勒","卡特")%><%=catalogName %>口碑"><%=CommonString.getFormatPara(m.get("name")).replace("卡特彼勒","卡特")%><%=catalogName %>口碑</a></h4>
        </li>
<%		}
		  i++ ;
	  }
  }
%>
</cache:cache>

