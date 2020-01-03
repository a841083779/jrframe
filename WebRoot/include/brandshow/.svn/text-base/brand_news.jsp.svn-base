<%@page import="org.apache.solr.common.SolrDocumentList"%>
<%@page import="org.apache.solr.common.SolrDocument"%>
<%@page import="org.apache.solr.client.solrj.response.QueryResponse"%>
<%@page import="org.apache.solr.client.solrj.SolrQuery"%>
<%@page import="org.apache.solr.client.solrj.impl.HttpSolrServer"%>
<%@ page language="java" import="java.util.*,com.jerehnet.util.common.*,com.jerehnet.webservice.*" pageEncoding="UTF-8"%><%@page import="com.jerehnet.util.dbutil.DBHelper"%><%@ page session="false" %><%@ taglib uri="/WEB-INF/classes/oscache.tld" prefix="cache"%><%
	String usern = CommonString.getFormatPara(request.getParameter("usern")) ;

if(1==1){
    /*查询*/
    String httpUrl = "http://s.21-sun.com:7422/solr/sun21_news";
	HttpSolrServer server = new HttpSolrServer(httpUrl);
	int nowPage = 1;
	int pageSize = 1;

    List<String> whereList2 = new ArrayList<String>();
    List<SolrQuery.SortClause> orderList2 = new ArrayList<SolrQuery.SortClause>();
    orderList2.add(SolrQuery.SortClause.desc("id"));
    SolrQuery query2 = new SolrQuery();
    query2.setRequestHandler("/jereh");
    whereList2.add("img:[* TO *]");
    whereList2.add("sort_num:(-874 -979)");
    whereList2.add("title:"+usern);
    query2.setQuery("*:*");
    String [] whereAry2 = new String [whereList2.size()];
    whereAry2 = whereList2.toArray(whereAry2);
    query2.addFilterQuery(whereAry2);
    query2.setSorts(orderList2);
    query2.setRows(pageSize);
    query2.setStart((nowPage - 1) * pageSize);
    QueryResponse res2 = server.query(query2);
    int totalParts2 = (int)res2.getResults().getNumFound();
    int pageCount2 = totalParts2 / pageSize + (totalParts2 % pageSize > 0 ? 1 : 0);
    SolrDocumentList news2 = res2.getResults();
	for(SolrDocument m : news2){
		String id = CommonString.getFormatPara(m.getFieldValue("id"));
		String title = CommonString.getFormatPara(m.getFieldValue("title"));
		String url = CommonString.getFormatPara(m.getFieldValue("url"));
		String img = CommonString.getFormatPara(m.getFieldValue("img"));
		String link_other = CommonString.getFormatPara(m.getFieldValue("link_other"));
		String intro = CommonString.getFormatPara(m.getFieldValue("intro"));
		String titleAlt = title;
	 	if(title.length()>20){
	 		titleAlt=title;
	 		title=title.substring(0,20)+"...";
		}
	 	if(link_other.length()>6){
	 		url=link_other;
	 	}
%>
	<div class="s_topNews">
            <a href="/news_detail_<%=id %>.htm" target="_blank" title="<%=titleAlt%>"><img src="<%=img%>" class="img" alt="<%=titleAlt%>" />
            <div class="intro">
              <h3><%=title%></h3>
              <div class="text"><%=intro %></div>
              <div class="time"><%=CommonDate.getFormatDate("yyyy-MM-dd", m.getFieldValue("pub_date"))%></div>
              <span class="btn">继续阅读</span>
            </div></a>
          </div>
<%}} %>
	<div class="s_news_list">
            <ul class="fix">
            <%
if(1==1){
    /*查询*/
    String httpUrl = "http://s.21-sun.com:7422/solr/sun21_news";
	HttpSolrServer server = new HttpSolrServer(httpUrl);
	int nowPage = 1;
	int pageSize = 12;

    List<String> whereList2 = new ArrayList<String>();
    List<SolrQuery.SortClause> orderList2 = new ArrayList<SolrQuery.SortClause>();
    orderList2.add(SolrQuery.SortClause.desc("id"));
    SolrQuery query2 = new SolrQuery();
    query2.setRequestHandler("/jereh");
    whereList2.add("sort_num:(-874 -979)");
    whereList2.add("title:"+usern);
    query2.setQuery("*:*");
    String [] whereAry2 = new String [whereList2.size()];
    whereAry2 = whereList2.toArray(whereAry2);
    query2.addFilterQuery(whereAry2);
    query2.setSorts(orderList2);
    query2.setRows(pageSize);
    query2.setStart((nowPage - 1) * pageSize);
    QueryResponse res2 = server.query(query2);
    int totalParts2 = (int)res2.getResults().getNumFound();
    int pageCount2 = totalParts2 / pageSize + (totalParts2 % pageSize > 0 ? 1 : 0);
    SolrDocumentList news2 = res2.getResults();
	for(SolrDocument m : news2){
		String id = CommonString.getFormatPara(m.getFieldValue("id"));
		String title = CommonString.getFormatPara(m.getFieldValue("title"));
		String url = CommonString.getFormatPara(m.getFieldValue("url"));
		String img = CommonString.getFormatPara(m.getFieldValue("img"));
		String link_other = CommonString.getFormatPara(m.getFieldValue("link_other"));
		String intro = CommonString.getFormatPara(m.getFieldValue("intro"));
		String titleAlt = title;
	 	if(title.length()>20){
	 		titleAlt=title;
	 		title=title.substring(0,20)+"...";
		}
	 	if(link_other.length()>6){
	 		url=link_other;
	 	}
%>
              <li><a href="/news_detail_<%=id %>.htm" target="_blank" title="<%=title %>"><%=title %></a><span class="time"><%=CommonDate.getFormatDate("MM-dd", m.getFieldValue("pub_date"))%></span></li>
              <%}} %>
            </ul>
          </div>