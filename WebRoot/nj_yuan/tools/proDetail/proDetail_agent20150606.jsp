<%@ page language="java" import="org.json.*,java.util.*,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*,java.sql.*,com.jerehnet.webservice.*" pageEncoding="UTF-8"%><%@page import="com.jerehnet.util.dbutil.PageBean"%><%@page import="org.apache.solr.client.solrj.impl.HttpSolrServer"%><%@page import="com.jerehnet.util.common.CommonString,java.sql.Connection"%><%@page import="org.apache.solr.common.SolrDocument"%><%@page import="org.apache.solr.common.SolrDocumentList"%><%@page import="org.apache.solr.client.solrj.response.QueryResponse"%><%@page import="org.apache.solr.client.solrj.SolrQuery"%><%@ taglib tagdir="/WEB-INF/tags" prefix="tags" %><%@ taglib uri="/WEB-INF/classes/oscache.tld" prefix="cache" %><%
	DBHelper dbHelper = DBHelper.getInstance();
	Connection connection = null;
	String factoryId = CommonString.getFormatPara(request.getParameter("id"));
	
	String ipProvince="";
	String ipcity="";
	String IP=Common.getIp(request,1);
	//IP="119.254.64.4";
	Map mapip = new HashMap();
	String objStr = Common.doPost("http://service.21-sun.com/http/utils/ip.jsp?ip="+IP,mapip);
	JSONObject obj = new JSONObject(objStr);
	if(null!=obj&&obj.length()>0){
		ipProvince = CommonString.getFormatPara(obj.getString("province"));
		ipcity = CommonString.getFormatPara(obj.getString("city"));
    }
	String search_province=ipProvince;
	String search_city=ipcity;
	
	try{	
	    int totalParts = 0;
		 Integer nowPage = 1 ;
	        int pageSize = 2;
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

<div class="txd_dlp_dllist">
    <ul class="fix" >
	<%
	if(agents.size()>0){
	   		int i=0;
		    for(SolrDocument m : agents){
				String id=CommonString.getFormatPara(m.getFieldValue("id"));
				String full_name = CommonString.getFormatPara(m.getFieldValue("full_name"));	
                String address = CommonString.getFormatPara(m.getFieldValue("address"));
				String usern = CommonString.getFormatPara(m.getFieldValue("usern"));
				String agent_city = CommonString.getFormatPara(m.getFieldValue("city"));    
				String agent_fac_name = CommonString.getFormatPara(m.getFieldValue("agent_fac_name"));	
                String telphone = CommonString.getFormatPara(m.getFieldValue("telphone"));	
                String fax = CommonString.getFormatPara(m.getFieldValue("fax"));					
	%>
		<li>
			<div class="tdl_dltitle">
			 <a href="/agent/<%=usern%>/" target="_blank"><%=full_name%></a>
			 <span class="tdlt_qy"><%if(ipProvince.equals(ipcity)){%><%=ipProvince%><%}else{%><%=ipProvince%><%=ipcity%><%}%></span> 
			 <span class="tdlt_tag">荐</span>
			</div>
			<div class="tdl_dlsum">  代理区域：<%=ipProvince%><br> 
									 代理品牌：<%=agent_fac_name%><br> 
									 电话：<%=telphone%><br> 
									 传真：<%=fax%><br> 
									 地址：<%=address%>
			 </div>
		</li>
		<%}}%>
  </ul>
</div>

<%
	
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		DBHelper.freeConnection(connection);
	}
%>
