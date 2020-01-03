<%@ page language="java" import="java.util.*,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*,java.sql.*" pageEncoding="GBK"%>
<%@page session="false" %>
<%@ taglib uri="/WEB-INF/classes/oscache.tld" prefix="cache"%>
<%
	String catalognum = CommonString.getFormatPara(request.getParameter("catalognum"));
	String factoryid = CommonString.getFormatPara(request.getParameter("factoryid"));
	Map catalogMap = (Map) application.getAttribute("catalogMap");
	Map brandMap = (Map) application.getAttribute("brandMap");
    String pro=(CommonString.getFormatPara(brandMap.get(factoryid))+CommonString.getFormatPara(catalogMap.get(catalognum)));
	String sql = " select top 4 image,link,title from product_video where 1=1  ";
	if(!catalognum.equals("")&&!catalognum.equals("0")){sql+=" and title like '%"+CommonString.getFormatPara(catalogMap.get(catalognum))+"%'";}
	if(!factoryid.equals("")&&!factoryid.equals("0")){sql+=" and title like '%"+CommonString.getFormatPara(brandMap.get(factoryid))+"%'";}
	sql+="order by id desc";  
	List <Map>list = (List <Map>)DBHelper.getInstance().getMapList(sql,new Object[]{});
%>
<cache:cache  cron="*/1 * * * *">
    <div class="rp clearfix mb10 nwx_video">
      <div class="title">
        <h3><%=pro%>维修实拍</h3>
      </div>
      <div class="nwx_vlist">
        <ul class="np_fix">
     <%
			if(list != null && list.size() > 0){
				for(Map m : list){		
     %>


	       
		   <li>
            <p class="nwx_vimg"><a title="<%=CommonString.getFormatPara(m.get("title"))%>" target="_blank" href="<%=CommonString.getFormatPara(m.get("link"))%>"><img  onerror="showImgDelay(this,'/uploadfiles/no_small.gif',2);"  src="http://news.21-sun.com/UserFiles/Image/<%=CommonString.getFormatPara(m.get("image"))%>" alt="<%=CommonString.getFormatPara(m.get("title"))%>"/><em class="nwx_vpico"></em></a></p>
            <p class="nwx_vname"><a title="<%=CommonString.getFormatPara(m.get("title"))%>" target="_blank"  href="<%=CommonString.getFormatPara(m.get("link"))%>"><%=CommonString.getFormatPara(m.get("title"))%></a></p>
          </li>

    
	<%}}else{%>
	  <div align="center">暂无相关实拍</div>
	<%}%>
        </ul>
      </div>
    </div>  
</cache:cache>