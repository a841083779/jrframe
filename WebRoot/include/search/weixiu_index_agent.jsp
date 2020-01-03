<%@ page language="java" import="java.util.*,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*,com.jerehnet.webservice.*,org.json.*" pageEncoding="UTF-8"%>
<%@page import="org.apache.solr.client.solrj.impl.HttpSolrServer"%>
<%@page import="com.jerehnet.util.common.CommonString"%>
<%@page import="org.apache.solr.common.SolrDocument"%>
<%@page import="org.apache.solr.common.SolrDocumentList"%>
<%@page import="org.apache.solr.client.solrj.response.QueryResponse"%>
<%@page import="org.apache.solr.client.solrj.SolrQuery"%>
<%@page import="java.net.URLEncoder,java.sql.Connection"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="tags"%>
<%  
    DBHelper dbHelper = DBHelper.getInstance() ;
	String weixiuType = CommonString.getFormatPara(request.getParameter("weixiuType")) ;
	String keywordCheck = CommonString.getFormatPara(request.getParameter("keyword")) ;
	String pageKeyword = CommonString.getFormatPara(request.getParameter("keyword")) ;
	String catalog = CommonString.getFormatPara(request.getParameter("catalog"));
	String factory = CommonString.getFormatPara(request.getParameter("factory"));
	List<Map> catalogList = (List<Map>)application.getAttribute("catalogList");
	int nowPage = CommonString.getFormatInt(request.getParameter("nowPage"));
	Map brandMap = (Map)application.getAttribute("brandMap") ;
	Map catalogMap = (Map)application.getAttribute("catalogMap") ;
    if(keywordCheck.equals("0")){keywordCheck="";}
	if(catalog.equals("")){catalog="0";}
	if(factory.equals("")){factory="0";}
	if(pageKeyword.equals("")){pageKeyword="0";}
	int totalParts = 0;
	String tempCatalog="";
	String tempFactory="";
	
	//搜索维修知识
	//搜索新	
	String httpUrl = "http://s.21-sun.com:7422/solr/sun21_product_agent";
	HttpSolrServer server = new HttpSolrServer(httpUrl);
	/*接收参数*/
	SolrQuery query = new SolrQuery();
	nowPage = nowPage <= 0 ? 1 : nowPage;
	List<String> whereList = new ArrayList<String>();
	if(!catalog.equals("0")&&!catalog.equals("")&&catalog.length()>3){
	   tempCatalog=(CommonString.getFormatPara(catalogMap.get(catalog)));
	}
	if(!factory.equals("0")&&!factory.equals("")){
	    tempFactory=(CommonString.getFormatPara(brandMap.get(factory)));
	}
	if((keywordCheck+tempFactory+tempCatalog).equals("")){
	   	query.setQuery("*:*");
	}else{
	    query.setQuery("full_name:" + keywordCheck+tempFactory+tempCatalog);
	}
    /*查询*/				
	int pageSize = 10;
	query.setRequestHandler("/jereh");
	query.setRows(pageSize);
	query.setStart((nowPage - 1) * pageSize);
	/* 高亮 */
	query.setHighlight(true);
	query.setHighlightSimplePre("<span style='color:red;'>");
	query.setHighlightSimplePost("</span>");
	query.setParam("hl.fl", "title");
	QueryResponse res = server.query(query);
	totalParts = (int)res.getResults().getNumFound();
	SolrDocumentList infoList = res.getResults();
%>
    <div class="rp clearfix mb10 nwx_zxlist repairList border0 mt10">
        <div class="title border04">
          <h3>维修网点</h3>
          <a style=" float:right; padding-right:25px;" target="_blank" href="/<%=keywordCheck%>_agent_0_0_0_0_0.htm">更多</a> </div>
          <div class="content r_add">
            <ul class="list blue">
		<%  
		String title_hl = "";
		for(SolrDocument m : infoList){	
			String id = CommonString.getFormatPara(m.getFieldValue("id"));
			String title = CommonString.getFormatPara(m.getFieldValue("full_name"));
            String agent_fac_name=CommonString.getFormatPara(m.getFieldValue("agent_fac_name"));
			String usern=CommonString.getFormatPara(m.getFieldValue("usern"));
			if(res.getHighlighting().get(id) != null){
				Map<String, List<String>> hl = res.getHighlighting().get(id);
				if(hl.get("title") != null){
					title_hl = hl.get("title").get(0);
				}
			}
			String titleAlt = title;
		 	if(title.length()>20){
		 		titleAlt=title;
		 		title=title.substring(0,20)+"...";
			}
		%>
		  
            <li>
              <h3 style="width:450px"> <span class="lb">
			  <a  target="_blank" href="http://weixiu.21-sun.com/network/" title="维修网点" style="color: #ff6600">[维修网点]</a> </span> 
			  <a target="_blank" href="http://dealer.21-sun.com/<%=usern%>" title="<%=title%>"><%=title%></a></h3>
              <span    class="time"><%=agent_fac_name%></span> </li>
           <%}%>
          </ul>
        </div>
      </div>