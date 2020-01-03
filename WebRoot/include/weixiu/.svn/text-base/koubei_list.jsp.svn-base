<%@ page language="java" import="java.util.*,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*,java.sql.*" pageEncoding="GBK"%>
<%@page session="false" %>
<%@ taglib uri="/WEB-INF/classes/oscache.tld" prefix="cache"%>
<%
	String catalognum = CommonString.getFormatPara(request.getParameter("catalognum"));
	String factoryid = CommonString.getFormatPara(request.getParameter("factoryid"));
	Map catalogMap = (Map) application.getAttribute("catalogMap");
	Map brandMap = (Map) application.getAttribute("brandMap");
	String pro=(CommonString.getFormatPara(brandMap.get(factoryid))+CommonString.getFormatPara(catalogMap.get(catalognum)));
	String sql = " select top 8 id,img2,add_date,factoryname,catalogname,name,file_name from pro_products where 1=1  and img2 is not null and img2 != '' ";
	if(!factoryid.equals("")&&!factoryid.equals("0")){sql+=" and factoryid="+factoryid;}
	if(!catalognum.equals("")&&!catalognum.equals("0")){sql+=" and catalognum like '%"+catalognum+"%'";}
	sql+="order by view_count desc";  
	List <Map>list = (List <Map>)DBHelper.getInstance().getMapList(sql,new Object[]{});
%>
<cache:cache  cron="*/1 * * * *">
	<div class="rp clearfix mb10 cate Similar">
      <div class="title">
        <h3>    <%=("".equals(pro))?"最新产品":pro%>口碑</h3>
      </div>
      <div class="scontent">
        <ul class="slist">
     <%
			if(list != null && list.size() > 0){
				for(Map m : list){		
     %>

          <li><a target="_blank" title="<%=CommonString.getFormatPara(m.get("factoryname"))%><%=CommonString.getFormatPara(m.get("name"))%><%=CommonString.getFormatPara(m.get("catalogname"))%>口碑" href="http://product.21-sun.com/proDetail/<%=CommonString.getFormatPara(m.get("file_name")).replace(".shtm","")%>_message.shtm"><img src="/uploadfiles/<%=CommonString.getFormatPara(m.get("img2")) %>" alt="小松PC200-8履带式挖掘机口碑" onerror="showImgDelay(this,'/uploadfiles/no_small.gif',2);" width="80" height="70">
            <h4><%=CommonString.getFormatPara(m.get("factoryname"))%><%=CommonString.getFormatPara(m.get("name"))%><%=CommonString.getFormatPara(m.get("catalogname"))%>口碑</h4>
            </a></li>
	 

    
	<%}}%>
        </ul>
      </div>
    </div>  
</cache:cache>