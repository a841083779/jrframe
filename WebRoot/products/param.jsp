<%@page language="java" import="java.sql.Connection,com.jerehnet.webservice.*,org.json.*,java.util.*,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*" pageEncoding="UTF-8"%>
<%@page import="org.apache.solr.client.solrj.impl.HttpSolrServer"%>
<%@page import="com.jerehnet.util.common.CommonString"%>
<%@page import="org.apache.solr.common.SolrDocument"%>
<%@page import="org.apache.solr.common.SolrDocumentList"%>
<%@page import="org.apache.solr.client.solrj.response.QueryResponse"%>
<%@page import="org.apache.solr.client.solrj.SolrQuery"%>
<%@page import="java.net.URLEncoder"%>
<%@taglib tagdir="/WEB-INF/tags" prefix="tags"%>
<%@taglib uri="/WEB-INF/oscache.tld" prefix="cache"%>

<%
		DBHelper dbHelper = DBHelper.getInstance();
		List proList = null;
		//String sqlCatalog = "select id,pro_id,param_id,param_value,param_name  from pro_main_param ";
		String sql="select id from  pro_products where  factoryid=18936  ";
		Connection conn = null;
		HashMap<String, List<Map>> proParamMap = null;

			proList = dbHelper.getMapList(sql);
			Map info = null;
			proParamMap = new HashMap<String, List<Map>>();
			for (int i = 0; i < proList.size(); i++) {
				info = (Map) proList.get(i);
				List <Map>   paramList = dbHelper.getMapList("select id,pro_id,param_id,param_value,param_name  from pro_main_param   where pro_id="+info.get("id").toString());
                if(paramList==null){
                	paramList=new ArrayList<Map>();
                }else{
					System.out.println("123");
				}
				proParamMap.put(info.get("id").toString(), paramList);
			}
	
		application.setAttribute("proParamMap", proParamMap);


%>

