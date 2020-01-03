<%@ page language="java" import="java.sql.Connection,java.util.*,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*" pageEncoding="UTF-8"%><%@ taglib tagdir="/WEB-INF/tags" prefix="tags" %><%@ taglib uri="/WEB-INF/classes/oscache.tld" prefix="cache"%><%	
	DBHelper dbHelper = DBHelper.getInstance();
	Connection connection = null;
	try{
		connection = dbHelper.getConnection();
%>
<cache:cache cron="* * */1 * *">
  <div class="rp clearfix mb10 nwx_zxlist repairList border05  mt10">
    <div class="title" style="border-right:1px solid #ccc;border-bottom:1px solid #ccc;">
      <h3 style="color:#000;">热门维修网点推荐</h3>
    </div>
    <div class="content r_add">
      <div class="agent_list border0">
        <ul class="fix">
<%
       List<Map> list = dbHelper.getMapList("select top 2 id,logo,name,usern,full_name,address,city,agent_fac_name,agent_fac,telphone from pro_agent_factory where logo<>'' and is_show=1 and flag=2 order by is_shop desc,flag ASC , name DESC , id DESC");
	  	if(list != null && list.size() > 0){
	         for(Map m : list){	
			 String  tcity=CommonString.getFormatPara(m.get("city")) ;
			 if(tcity.length()>20){tcity=tcity.substring(0,20)+"...";}
			 String  address=CommonString.getFormatPara(m.get("address")) ;
			 if(address.length()>20){address=address.substring(0,20)+"...";}

	  %>
          <li class="l"  style="width:50%"><a href="/<%=CommonString.getFormatPara(m.get("usern")) %>/" target="blank" title="<%=CommonString.getFormatPara(m.get("full_name")) %>">
		  <img onerror="showImgDelay(this,'/uploadfiles/no_big.gif',2);" src="http://product.21-sun.com/uploadfiles/<%=CommonString.getFormatPara(m.get("logo")) %>" class="agimg" style="width:140px; height:auto"></a>
            <div class="intro" style="width:320px;">
              <h2><a target="_blank" href="/<%=CommonString.getFormatPara(m.get("usern")) %>/" title="<%=CommonString.getFormatPara(m.get("full_name")) %>"><%=CommonString.getFormatPara(m.get("full_name")) %></a></h2>
              <div class="text">
                <dl>
                  <strong>主营品牌：</strong> [<%=CommonString.getFormatPara(m.get("agent_fac_name")) %>]
                </dl>
                <dl>
                  <strong>代理区域：</strong> <%=tcity%>
                </dl>
                <dl>
                  <strong>详细地址：</strong> <%=address %>
                </dl>
                <dl>
                  <strong>公司网址：</strong> <a target="_blank" href="http://dealer.21-sun.com/<%=CommonString.getFormatPara(m.get("usern")) %>/" title="http://dealer.21-sun.com/<%=CommonString.getFormatPara(m.get("usern")) %>/">http://dealer.21-sun.com/<%=CommonString.getFormatPara(m.get("usern")) %>/</a>
                </dl>
              </div>
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




