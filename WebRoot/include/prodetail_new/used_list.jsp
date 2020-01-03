<%@ page language="java" import="java.util.*,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*,java.sql.*,com.jerehnet.util.freemarker.*,org.json.*" pageEncoding="UTF-8"%>
<%@page import="com.jerehnet.webservice.*"%>
<%@page import="com.jerehnet.webservice.WEBDBHelper"%>
<%@ taglib uri="/WEB-INF/classes/oscache.tld" prefix="cache"%>
<cache:cache cron="* * */1 * *">
<%  
    String factoryid = CommonString.getFormatPara(request.getParameter("factoryid"));
    List<Map> usedList  = WEBDBHelper.getMapList("select  top 4  used_area.area_name,used_equipment.import_brand,used_equipment.price,used_equipment.workingtime,used_equipment.img1_1,used_equipment.factorydate,used_equipment.model,used_equipment.id,used_catalog.name from used_equipment,used_catalog,used_area  where used_equipment.is_review=1 and used_equipment.brand_id="+factoryid+" and  used_equipment.is_pub=1 and  used_equipment.brand_id!='' and used_equipment.category_id=used_catalog.id and used_area.area_id=used_equipment.province_id and used_equipment.img1_1 like '%resource.21-sun%' order by  used_equipment.id desc","Web21usedDBHelper");
%>

        <div class="txd_plant fix">
          <div class="tpl_title">二手</div>
          <a href="http://used.21-sun.com/equipment/0-0-0-<%=factoryid%>-0-0-0-0.htm" class="tpl_more" target="_blank">查看更多</a> </div>
        <div class="prodt_used">
          <ul>
        <%
	        if(usedList!=null&&usedList.size()>0){
		    for(Map oneMap:usedList){
	    %>
            <li><a target="_blank" href="http://used.21-sun.com/equipment/equipmentdetail_for_<%=CommonString.getFormatPara(oneMap.get("id"))%>.htm" title="<%=CommonString.getFormatPara(oneMap.get("import_brand"))%><%=CommonString.getFormatPara(oneMap.get("model"))%><%=CommonString.getFormatPara(oneMap.get("name"))%>"><img src="<%=CommonString.getFormatPara(oneMap.get("img1_1"))%>" class="_img">
              <div class="_text"><%=CommonString.getFormatPara(oneMap.get("import_brand"))%><%=CommonString.getFormatPara(oneMap.get("model"))%><%=CommonString.getFormatPara(oneMap.get("name"))%><br>
                年限：<%=CommonString.getFormatPara(oneMap.get("factorydate"))%>年<br>
                地点：<%=CommonString.getFormatPara(oneMap.get("area_name"))%><br>
                <span>价格：面议</span></div>
              </a></li>
			<%}}%>
          </ul>
        </div>
		</script>
</cache:cache>