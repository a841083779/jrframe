<%@ page language="java" import="java.sql.Connection,com.jerehnet.webservice.*,org.json.*,java.util.*,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*" pageEncoding="UTF-8"%>
<%@page import="org.apache.solr.client.solrj.impl.HttpSolrServer"%>
<%@page import="com.jerehnet.util.common.CommonString"%>
<%@page import="org.apache.solr.common.SolrDocument"%>
<%@page import="org.apache.solr.common.SolrDocumentList"%>
<%@page import="org.apache.solr.client.solrj.response.QueryResponse"%>
<%@page import="org.apache.solr.client.solrj.SolrQuery"%>
<%@page import="java.net.URLEncoder"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="tags"%>
<%@ taglib uri="/WEB-INF/classes/oscache.tld" prefix="cache"%>
<cache:cache cron="* * */1 * *">
<%  
    String factoryname = CommonString.getFormatPara(request.getParameter("factoryname"));	
	//搜索新	
	String httpUrl = "http://s.21-sun.com:7422/solr/sun21_news";
	HttpSolrServer server = new HttpSolrServer(httpUrl);
	/*接收参数*/
	List<SolrQuery.SortClause> orderList = new ArrayList<SolrQuery.SortClause>();
    orderList.add(SolrQuery.SortClause.desc("id"));
	/*查询*/	
	List<String> filterQuery = new ArrayList<String>(0);
	filterQuery.add("title:"+factoryname);
   	String [] filterArr = new String [filterQuery.size()];
	filterArr = filterQuery.toArray(filterArr);
	SolrQuery query = new SolrQuery();
	if(factoryname.equals("")){
    query.setQuery("*:*");	
	}else{
	query.setQuery("title:"+factoryname);	
	}
	query.addFilterQuery(filterArr);	
	query.setRequestHandler("/jereh");
	query.setSorts(orderList);
	query.setRows(5);
	query.setStart(0);
	query.setParam("hl.fl", "title");
	int totalParts = 0;	
	QueryResponse res = server.query(query);
	SolrDocumentList newsList = res.getResults();
	totalParts = (int)res.getResults().getNumFound();
%>

<div class="txd_plant fix">
  <div class="tpl_title">行业口碑</div>
  <a href="http://sowa.21-sun.com/?q=<%=factoryname%>&f=news" class="tpl_more" target="_blank">查看更多</a> </div>
<div class="hy_kb_list">
  <ul>
    <%
	        if(totalParts>0){
		    for(SolrDocument oneMap : newsList){
	%>
    <li><a target="_blank" href="http://news.21-sun.com/<%=CommonString.getFormatPara(oneMap.getFieldValue("url"))%>" title="<%=CommonString.getFormatPara(oneMap.getFieldValue("title"))%>"><%=CommonString.getFormatPara(oneMap.getFieldValue("title"))%></a></li>
    <%}}%>
  </ul>
</div>
</cache:cache>