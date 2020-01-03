<%@page import="org.apache.solr.common.SolrDocumentList"%>
<%@page import="org.apache.solr.common.SolrDocument"%>
<%@page import="org.apache.solr.client.solrj.response.QueryResponse"%>
<%@page import="org.apache.solr.client.solrj.SolrQuery"%>
<%@page import="org.apache.solr.client.solrj.impl.HttpSolrServer"%>
<%@ page language="java" import="java.util.*,com.jerehnet.util.common.*,com.jerehnet.webservice.*" pageEncoding="UTF-8"%><%@page import="com.jerehnet.util.dbutil.DBHelper"%><%@ page session="false" %><%@ taglib uri="/WEB-INF/classes/oscache.tld" prefix="cache"%><%
	String factoryid = CommonString.getFormatPara(request.getParameter("factoryid")) ;
	Map brandMap = (HashMap)application.getAttribute("brandMap") ;
	String cacheKey = "brand_agent_"+factoryid;
	DBHelper dbHelper = DBHelper.getInstance() ;
	String sql = "select top 4 id,name,full_name,agent_fac,agent_fac_name,telphone,fax,address,city,usern from pro_agent_factory where flag = 2 and is_show = 1 and  agent_fac like '%"+factoryid+"%' order by is_cooperate desc ,id desc";
	
%>
<cache:cache cron="*/1 * * * *" key="<%=cacheKey%>">
<ul class="fix">
<%
	List<Map> prosList = dbHelper.getMapList(sql);
	if(prosList!=null && prosList.size()>0){
		for(Map pro:prosList){
			String usern = CommonString.getFormatPara(pro.get("usern"));
			String full_name = CommonString.getFormatPara(pro.get("full_name"));
			String name = CommonString.getFormatPara(pro.get("name"));
			String agent_fac_name = CommonString.getFormatPara(pro.get("agent_fac_name"));
			String city = CommonString.getFormatPara(pro.get("city"));
			String telphone = CommonString.getFormatPara(pro.get("telphone"));
			String fax = CommonString.getFormatPara(pro.get("fax"));
			String address = CommonString.getFormatPara(pro.get("address"));
%>
            <li>
              <a class="n" href="http://dealer.21-sun.com/<%=usern %>/" title="<%=full_name %>" target="_blank"><%=full_name %></a>
              <span class="area"><%=city %></span>
              <div class="text">
                代理品牌：<%=agent_fac_name %><br />
                电话：<%=telphone %><br />
                传真：<%=fax %><br />
                地址：<%=address %>
              </div>
              <a href="http://dealer.21-sun.com/<%=usern %>/" target="_blank" class="btn">进入店铺</a>
            </li>
<%}} %>
          </ul>
</cache:cache>