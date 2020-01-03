<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.jerehnet.util.common.CommonString"%>
<%@page import="com.jerehnet.util.dbutil.DBHelper"%>
<%
	DBHelper dbHelper = DBHelper.getInstance() ;
	String total_sql = "select id,usern,city,agent_fac,catalognum from pro_agent_factory where (is_shop is null or is_shop=0) and flag=2 and parent_id=0 and usern is not null and usern<>''" ;
	String agentCatanum = "select catalognum from pro_agent_product_vi where agentid=? group by catalognum" ;
	List<Map> agentCatanumList = null ;
	List<Map> allList = dbHelper.getMapList(total_sql) ;
	String area_city = "" ; // 代理地区
	String agent_id = "" ;// 代理商id
	String whereStr = "" ;
    String where = "" ;
    String agentCatanumStr = "" ;  // 代理类别
    String agent_factory = "" ;
    String[] agent_factorys = null ; // 代理品牌
    String agent_factory_str = "" ;
    String usern = "" ;
	if(null!=allList && allList.size()>0){
		for(Map m:allList){
			whereStr = "" ;
			where = "" ;
			agent_factory_str = "" ;
			agentCatanumStr = "";
			agent_factorys = null ;
			usern = CommonString.getFormatPara(m.get("usern")) ;
			System.out.println(usern+"..") ;
			area_city = CommonString.getFormatPara(m.get("city")) ;
			agent_factory = CommonString.getFormatPara(m.get("agent_fac")) ;  // 代理品牌
			agent_id = CommonString.getFormatPara(m.get("id")) ;
			 if(area_city.length()>0 && area_city.indexOf(",")==-1){ // 代理一个地区 
				  whereStr+= " and contact_address like'%"+area_city+"%'" ;
			 }else if(area_city.length()>0 && area_city.indexOf(",")>0){  // 代理多个区域
				 String[] agent_areas = area_city.split(",") ;
				 for(int i=0;i<agent_areas.length;i++){
					 where+=" or contact_address like '%"+agent_areas[i]+"%'" ;
				 }
				 if(where.length()>0 && where.indexOf("or")>0){
					 where = where.replaceFirst("or","") ;
				 }
				 if(where.length()>0){
					 whereStr+= " and ( "+where+" )" ;
				 }
			 }
			agentCatanumList = dbHelper.getMapList(agentCatanum,new Object[]{agent_id}) ;
			if(null!=agentCatanumList && agentCatanumList.size()>0){
				for(Map twoMap:agentCatanumList){
					if(!"".equals(CommonString.getFormatPara(twoMap.get("catalognum")))){
						agentCatanumStr += "'"+CommonString.getFormatPara(twoMap.get("catalognum"))+"'," ; 
					}
				}
			}
			if(agentCatanumStr.length()>0 && agentCatanumStr.indexOf(",")!=-1){
				agentCatanumStr = agentCatanumStr.substring(0,agentCatanumStr.length()-1) ;
			}
			if(!"".equals(agentCatanumStr)){
				whereStr += " and catanum in("+ agentCatanumStr+") ";
			}
			// 代理品牌
			 if(agent_factory.length()>0 && agent_factory.indexOf(",")>0){
				 agent_factorys = agent_factory.split(",") ;
			 }else if(!"".equals(agent_factory)){
				 whereStr+=" and factoryid="+agent_factory ;
			 }
			 if(null!=agent_factorys){
				 for(int i=0;i<agent_factorys.length;i++){
					 if(agent_factorys[i].length()>0 && !",".equals(agent_factorys[i]) ){
						 agent_factory_str+=agent_factorys[i]+"," ;
					 }
				 }
			 }
			 if(agent_factory_str.length()>0 && agent_factory_str.lastIndexOf(",")!=0){
				 agent_factory_str = agent_factory_str.substring(0,agent_factory_str.length()-1) ;
			 }
			 if(agent_factory_str.length()>0){
				 whereStr += " and factoryid in("+agent_factory_str+")" ;
			 }
			 String orderByStr = " id desc ";
			 String tableName = "pro_product_form" ;
			 String fields = "add_date,factoryid,factoryname,agentid,agentname,catanum,cataname,product_id,product_name,contact_address,mobile_phone,province,city,buy_time,message,company,name" ;
			 List<Map> proList = null ; // 
			 String pro_sql = "select "+fields +" from "+tableName+" where 1=1  "+whereStr+" and convert(varchar,add_date,23)<='2013-03-18' order by "+orderByStr ;
			 proList = dbHelper.getMapList(pro_sql) ;
			 String ins_sql = " insert into pro_agent_products_form(add_date,factory_id,factory_name,agent_id,agent_name,cata_num,cata_name,product_id,product_name,contact_address,contact_tel,province,city,buy_time,message,company_name,user_name,state,ifgroup,is_import)" 
			      +"values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)" ;
			if(null!=proList && proList.size()>0){
				Object[] objs = null ;
				Map oneMap = null ;
				for(int i=0;i<proList.size();i++){
					oneMap = (HashMap)proList.get(i) ;
					objs = new Object[]{
							CommonString.getFormatPara(oneMap.get("add_date"))  ,
							CommonString.getFormatPara(oneMap.get("factoryid"))  ,
							CommonString.getFormatPara(oneMap.get("factoryname"))  ,
							agent_id  ,
							CommonString.getFormatPara(oneMap.get("agentname"))  ,
							CommonString.getFormatPara(oneMap.get("catanum"))  ,
							CommonString.getFormatPara(oneMap.get("cataname"))  ,
							CommonString.getFormatPara(oneMap.get("product_id"))  ,
							CommonString.getFormatPara(oneMap.get("product_name"))  ,
							CommonString.getFormatPara(oneMap.get("contact_address"))  ,
							CommonString.getFormatPara(oneMap.get("mobile_phone"))  ,
							CommonString.getFormatPara(oneMap.get("province"))  ,
							CommonString.getFormatPara(oneMap.get("city"))  , 
							CommonString.getFormatPara(oneMap.get("buy_time"))  ,
							CommonString.getFormatPara(oneMap.get("message"))  ,
							CommonString.getFormatPara(oneMap.get("company"))  ,
							CommonString.getFormatPara(oneMap.get("name"))  ,
							0, 
							CommonString.getFormatPara(oneMap.get("ifgroup"))  , 
							1
					} ;
					            dbHelper.execute(ins_sql,objs ) ;
				}
			}
			System.out.println(pro_sql) ;
		}
	}
%>
