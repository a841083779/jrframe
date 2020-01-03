<%@ page language="java" import="org.json.*,java.util.*,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*,java.sql.*,com.jerehnet.webservice.*" pageEncoding="UTF-8"%><%@page import="com.jerehnet.util.dbutil.PageBean"%><%@page import="org.apache.solr.client.solrj.impl.HttpSolrServer"%><%@page import="com.jerehnet.util.common.CommonString,java.sql.Connection"%><%@page import="org.apache.solr.common.SolrDocument"%><%@page import="org.apache.solr.common.SolrDocumentList"%><%@page import="org.apache.solr.client.solrj.response.QueryResponse"%><%@page import="org.apache.solr.client.solrj.SolrQuery"%>
<%@page import="java.net.URL"%>
<%@page import="java.net.HttpURLConnection"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.io.InputStreamReader"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="tags" %><%@ taglib uri="/WEB-INF/classes/oscache.tld" prefix="cache" %><%
	DBHelper dbHelper = DBHelper.getInstance();
	Connection connection = null;
	String factoryId = CommonString.getFormatPara(request.getParameter("id"));
	
	String ipProvince="";
	String ipcity="";
	String IP=Common.getIp(request,1);
	IP="119.180.98.134";
	String[] areaArr = new String[10];
	String urlString = "http://int.dpool.sina.com.cn/iplookup/iplookup.php?ip="+ IP;
		try {
			URL url = new URL(urlString);
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			conn.connect();
			InputStream is = conn.getInputStream();
			BufferedReader br = new BufferedReader(new InputStreamReader(is,"gb2312"));
			
			String line = "";
			StringBuffer resultBuffer = new StringBuffer();
			while ((line = br.readLine()) != null) {
				resultBuffer.append(line);
			}
			br.close();
			is.close();
			conn.disconnect();
			areaArr = (resultBuffer.toString()).split("\\s+");
		    ipProvince=areaArr[4];
			ipcity=areaArr[5];
		} catch (Exception e) {

		}
		System.out.println("ipProvince="+ipProvince);
		System.out.println("ipcity="+ipcity);
	String search_province=ipProvince;
	String search_city=ipcity;
	
	Map brandMap = (Map) application.getAttribute("brandMap");
	String factoryName=CommonString.getFormatPara(brandMap.get(factoryId)).replace("卡特彼勒","卡特");
	
	try{	
	    int totalParts = 0;
		 Integer nowPage = 1 ;
	        int pageSize = 10;
	    //int nowPage = CommonString.getFormatInt(request.getParameter("nowPage"));	
	    //搜索新	
	    String httpUrl = "http://s.21-sun.com:7422/solr/sun21_product_agent";
	    HttpSolrServer server = new HttpSolrServer(httpUrl);
	    /*接收参数*/
	    SolrQuery query = new SolrQuery();
	    List<SolrQuery.SortClause> agentList = new ArrayList<SolrQuery.SortClause>();
	    //排序
	   
	        List<String> whereList = new ArrayList<String>();
		    query.setQuery("*:*");
		    //分页查询
		    List<String> filterQuery = new ArrayList<String>(0); 
			//如果有品牌，首先查询出该品牌的全部代理商
			if(!"".equals(factoryId)){   
	             filterQuery.add("agent_fac:("+ factoryId +", OR,"+ factoryId +" OR "+factoryId +")");   
	        }
	        //省份
	        if("".equals(search_province)){
	   	          query.setQuery("*:*");
	        }else{
	              filterQuery.add("address:"+ search_province +"  OR full_name:"+ search_province +"  OR city:"+ search_province +"");
	        }
	        //城市
	        if(!"".equals(search_city)){				
			      filterQuery.add("address:"+ search_city.replace("市","") +"  OR full_name:"+ search_city.replace("市","") +"  OR city:"+ search_city.replace("市","") +"");
			}
            /*查询*/				
	        String [] filterArr = new String [filterQuery.size()];
	        filterArr = filterQuery.toArray(filterArr);
	        query.addFilterQuery(filterArr);
	      
	        query.setRequestHandler("/jereh");
	        query.setSorts(agentList);
	        query.setRows(pageSize);
	        query.setStart((nowPage - 1) * pageSize);
	        query.setParam("hl.fl", "name");
	        QueryResponse res = server.query(query);
	        totalParts = (int)res.getResults().getNumFound();
	        int pageCount = totalParts / pageSize + (totalParts % pageSize > 0 ? 1 : 0);
	        SolrDocumentList agents = res.getResults();	   
            
					
%>
 <div class="tdlp_canshu fix">
 <%
 if(agents.size()>0){
 %>
          <div id="agent_list_length" class="the_agent">
            <ul class="agent_ti">
              <li class="g1">代理商</li>
              <li class="g2">代理区域</li>
              <li class="g3">主营品牌</li>
              <li class="g4">在线询价</li>
              <li class="g5">联系电话</li>
            </ul>
            <div class="agent_li" id="agent_li">
	<%
	
	   		int i=0;
		    for(SolrDocument m : agents){
				String id=CommonString.getFormatPara(m.getFieldValue("id"));
				String full_name = CommonString.getFormatPara(m.getFieldValue("full_name"));	
                String address = CommonString.getFormatPara(m.getFieldValue("address"));
				String usern = CommonString.getFormatPara(m.getFieldValue("usern"));
				String agent_city = CommonString.getFormatPara(m.getFieldValue("city"));    
				String agent_fac_name = CommonString.getFormatPara(m.getFieldValue("agent_fac_name"));		
	%>
	<ul class="libg01"><li class="g1"><a title="<%=full_name%>" href="http://product.21-sun.com/agent/<%=usern%>/" target="_blank"><%=full_name%></a></li><li class="g2"><span title="<%=agent_city%>"><%=agent_city%></span></li><li class="g3"><span title="<%=agent_fac_name%>"><%=agent_fac_name%></span></li><li class="g4"><a href="javascript:void(0);" onclick="zaiXianXunJia(<%=id%>);">在线询价</a></li><li class="g5" style="overflow:hidden;"><a id="seePhone_1000" href="javascript:void(0);" onclick="lianXiDianHua(<%=id%>);">点击查看联系电话</a></li></ul>
		<%}%>
 
  </div>
 </div>
<%}else{%>
<%=ipProvince%> <%=ipcity%> 地区暂无<%=factoryName%>代理商!
<%}%>
 </div>

<%
	
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		DBHelper.freeConnection(connection);
	}
%>
