<%@ page language="java" import="java.sql.Connection,java.util.*,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*" pageEncoding="UTF-8"%><%@ taglib tagdir="/WEB-INF/tags" prefix="tags" %><%@ taglib uri="/WEB-INF/classes/oscache.tld" prefix="cache"%><%	
	DBHelper dbHelper = DBHelper.getInstance();
	Connection connection = null;
	try{
		connection = dbHelper.getConnection();
		String sql = " select top 5 id,img2,add_date,factoryname,catalogname,name,file_name,price_start,price_end from pro_products where is_show=1  and img2 is not null and img2 != '' order by view_count desc ";
%>
<cache:cache cron="* * */1 * *">
    <div class="rp clearfix mb10 nwx_zxlist repairList border05  mt10">
    <div class="title" style="border-right:1px solid #ccc;border-bottom:1px solid #ccc;">
    <h3 style="color:#000;">热门维修产品推荐</h3>
    </div>
    <div class="content r_add">
      <div class="n_sepro_list">
          <ul class="tabList01 np_fix">
<%
       List<Map> list = dbHelper.getMapList(sql);
	  	if(list != null && list.size() > 0){
	         for(Map m : list){	
			 String  tcity=CommonString.getFormatPara(m.get("city")) ;
			 if(tcity.length()>20){tcity=tcity.substring(0,20)+"...";}
			 String  address=CommonString.getFormatPara(m.get("address")) ;
			 if(address.length()>20){address=address.substring(0,20)+"...";}

	  %>
	          <li style="height:125px;"> 
			  <a href="http://product.21-sun.com/proDetail/<%=CommonString.getFormatPara(m.get("file_name")) %>" title="<%=CommonString.getFormatPara(m.get("factoryname")) %><%=CommonString.getFormatPara(m.get("name")) %><%=CommonString.getFormatPara(m.get("catalogname")) %>" target="_blank">
			  <img src="http://product.21-sun.com/uploadfiles/<%=CommonString.getFormatPara(m.get("img2")) %>" width="130" height="90" alt="<%=CommonString.getFormatPara(m.get("factoryname")) %><%=CommonString.getFormatPara(m.get("name")) %><%=CommonString.getFormatPara(m.get("catalogname")) %>" title="<%=CommonString.getFormatPara(m.get("factoryname")) %><%=CommonString.getFormatPara(m.get("name")) %><%=CommonString.getFormatPara(m.get("catalogname")) %>"></a>
              <div class="tlt">
              <p class="sn_pname"><a title="<%=CommonString.getFormatPara(m.get("factoryname")) %><%=CommonString.getFormatPara(m.get("name")) %><%=CommonString.getFormatPara(m.get("catalogname")) %>" href="http://product.21-sun.com/proDetail/<%=CommonString.getFormatPara(m.get("file_name")) %>" target="_blank"><%=CommonString.getFormatPara(m.get("factoryname")) %><%=CommonString.getFormatPara(m.get("name")) %><%=CommonString.getFormatPara(m.get("catalogname")) %></a></p>
              </div>
              </li>
	<%}}%> 
</cache:cache>
<%
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		DBHelper.freeConnection(connection);
	}
%>
       </ul>    
    </div>
  </div>
</div>



