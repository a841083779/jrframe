<%@ page language="java" import="java.sql.Connection,java.util.*,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*" pageEncoding="UTF-8"%><%@ taglib tagdir="/WEB-INF/tags" prefix="tags" %><%@ taglib uri="/WEB-INF/classes/oscache.tld" prefix="cache"%><%	
	DBHelper dbHelper = DBHelper.getInstance();
	Connection connection = null;
	try{
		connection = dbHelper.getConnection();
		Map brandMap = (Map) application.getAttribute("brandMap");
		String factoryid = CommonString.getFormatPara(request.getParameter("factoryid"));
		String area = CommonString.getFormatPara(request.getParameter("area"));
	    String areaName = CommonString.getFormatPara(request.getParameter("areaName"));
		String factoryName=CommonString.getFormatPara(brandMap.get(factoryid));
		String whereStr="";
		String sql = " select substring(catalognum,1,6) as catalognum from pro_products where factoryid = '"+factoryid+"' and catalognum is not null and catalognum !='' group by substring(catalognum,1,6) order by catalognum asc ";
        Map catalogMap = (Map) application.getAttribute("catalogMap");
%>
<cache:cache cron="* * */1 * *">
    <div class="rp clearfix mb10 cate">
      <div class="title">
        <h3><%=areaName+factoryName%>热门产品维修</h3>
      </div>
      <div class="content rList01">
        <ul class="list">
		<%if(factoryid.equals("")){%>
            <li><a target="_blank" title="挖掘机维修" href="/101001-0-0.htm">挖掘机维修</a></li>
			<li><a target="_blank" title="摊铺机维修" href="/104001-0-0.htm">摊铺机维修</a></li>
			<li><a target="_blank" title="沥青搅拌站维修" href="/104009-0-0.htm">沥青搅拌站维修</a></li>
			<li><a target="_blank" title="铣刨机维修" href="/104005-0-0.htm">铣刨机维修</a></li>
			<li><a target="_blank" title="平地机维修" href="/101005-0-0.htm">平地机维修</a></li>
			<li><a target="_blank" title="压路机维修" href="/106001-0-0.htm">压路机维修</a></li>
			<li><a target="_blank" title="混凝土泵车维修" href="/103001-0-0.htm">混凝土泵车维修</a></li>
			<li><a target="_blank" title="截桩机/破桩机维修" href="/105028-0-0.htm">截桩机/破桩机维修</a></li>
			<li><a target="_blank" title="推土机维修" href="/101003-0-0.htm">推土机维修</a></li>
			<li><a target="_blank" title="装载机维修" href="/101002-0-0.htm">装载机维修</a></li>
			<li><a target="_blank" title="铲运机维修" href="/101004-0-0.htm">铲运机维修</a></li>
			<li><a target="_blank" title="自卸卡车维修" href="/101008-0-0.htm">自卸卡车维修</a></li>
			<li><a target="_blank" title="牵引车维修" href="/118004-0-0.htm">牵引车维修</a></li>
			<li><a target="_blank" title="正面吊维修" href="/111001-0-0.htm">正面吊维修</a></li>
			<li><a target="_blank" title="塔式起重机维修" href="/102002-0-0.htm">塔式起重机维修</a></li>
			<li><a target="_blank" title="高空作业车维修" href="/102010-0-0.htm">高空作业车维修</a></li>
			<li><a target="_blank" title="施工升降机维修" href="/102011-0-0.htm">施工升降机维修</a></li>
			<li><a target="_blank" title="专用叉车维修" href="/107010-0-0.htm">专用叉车维修</a></li>
			<li><a target="_blank" title="强夯机维修" href="/105017-0-0.htm">强夯机维修</a></li>
			<li><a target="_blank" title="场桥维修" href="/111006-0-0.htm">场桥维修</a></li>
			<li><a target="_blank" title="消防车维修" href="/118003-0-0.htm">消防车维修</a></li>
			<li><a target="_blank" title="液压剪维修" href="/113002-0-0.htm">液压剪维修</a></li>
		<%}else{
		    List<Map> list = dbHelper.getMapList(sql,connection);
	       	if(list != null && list.size() > 0){
	  		for(int i = 0;list != null && i < list.size();i++){
	  			String catalognum =CommonString.getFormatPara(list.get(i).get("catalognum"));
				String catalogName=CommonString.getFormatPara(catalogMap.get(catalognum));
		%>
				<li><a target="_blank" title="<%=catalogName%>维修" href="/<%=catalognum%>-0-0.htm"><%=catalogName%></a></li>
		<%}}}%>
        </ul>
      </div>
    </div>
</cache:cache>
<%
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		dbHelper.freeConnection(connection);
	}
%>