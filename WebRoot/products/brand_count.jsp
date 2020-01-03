<%@ page language="java" import="java.util.*,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*,java.sql.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/oscache.tld" prefix="cache"%>

<%
	DBHelper dbHelper = DBHelper.getInstance() ;
	String sql = " select id from  pro_agent_factory where is_show=1 and flag=1  ";
	List <Map>list = (List <Map>)DBHelper.getInstance().getMapList(sql);
	String  cataSql=" select id,name,num from pro_catalog where is_show=1 ";
	List <Map> catalist = (List <Map>)DBHelper.getInstance().getMapList(cataSql);
	
	String  cataTopSql=" select num,name from pro_catalog where is_show=1 and  parentid=0  order by order_no asc ";
	List <Map> cataToplist = (List <Map>)DBHelper.getInstance().getMapList(cataTopSql);
	
	
	HashMap<String, String> brandProMap = null;
    if(list != null && list.size() > 0){
		brandProMap = new HashMap<String, String>();
		for(int i = 0;i < list.size(); i++){
		    List<Map> catalogList = (List <Map>)DBHelper.getInstance().getMapList(" select catalognum as num from pro_products where is_show=1  and  factoryid="+CommonString.getFormatPara(list.get(i).get("id"))+ " group by  catalognum");
			if(catalogList != null && catalogList.size() > 0){
			    for(int ii = 0;ii < catalogList.size(); ii++){
					
					    if(catalist != null && catalist.size() > 0){
			                for(int j = 0;j < catalist.size(); j++){
								 if(CommonString.getFormatPara(catalogList.get(ii).get("num")).indexOf(CommonString.getFormatPara(catalist.get(j).get("num")))>=0){
									 	Map catalogOneMap = dbHelper.getMap("select count(id) as allCount from pro_products  where is_show=1 and  factoryid="+CommonString.getFormatPara(list.get(i).get("id"))+" and catalognum like '"+CommonString.getFormatPara(catalist.get(j).get("num"))+"%' " ) ;
			                            brandProMap.put(CommonString.getFormatPara(list.get(i).get("id"))+"_"+CommonString.getFormatPara(catalist.get(j).get("num")), CommonString.getFormatInt(catalogOneMap.get("allCount")).toString() );
								 }
					        }
					    }
			    }     
	        }
		    //默认所有产品数
		    Map theMap = dbHelper.getMap("select count(id) as allCount from pro_products  where is_show=1 and factoryid="+CommonString.getFormatPara(list.get(i).get("id"))) ;
		    brandProMap.put(CommonString.getFormatPara(list.get(i).get("id"))+"_0", CommonString.getFormatInt(theMap.get("allCount")).toString() );
        } 
	}
	

	HashMap<String, String> cataTopProMap = null;
	if(cataToplist != null && cataToplist.size() > 0){
		cataTopProMap = new HashMap<String, String>();
		for(int jj = 0;jj < cataToplist.size(); jj++){
			Map catalogOneMap = dbHelper.getMap("select count(id) as allCount from pro_products  where is_show=1 and   catalognum like '"+CommonString.getFormatPara(cataToplist.get(jj).get("num"))+"%' " ) ;
			cataTopProMap.put( CommonString.getFormatPara(cataToplist.get(jj).get("num")), CommonString.getFormatInt(catalogOneMap.get("allCount")).toString() );
		}
	}
	
	
	HashMap<String, String> cataProMap = null;
	if(catalist != null && catalist.size() > 0){
		cataProMap = new HashMap<String, String>();
		for(int jj = 0;jj < catalist.size(); jj++){
			Map catalogOneMap = dbHelper.getMap("select count(id) as allCount from pro_products  where is_show=1 and   catalognum like '"+CommonString.getFormatPara(catalist.get(jj).get("num"))+"%' " ) ;
			cataProMap.put( CommonString.getFormatPara(catalist.get(jj).get("num")), CommonString.getFormatInt(catalogOneMap.get("allCount")).toString() );
		}
	}
	
	
	
	application.setAttribute("brandProMap", brandProMap);
	application.setAttribute("cataProMap", cataProMap);
	application.setAttribute("cataTopProMap", cataTopProMap);


%>

