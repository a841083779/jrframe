<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.jerehnet.util.common.CommonString"%>
<%@page import="com.jerehnet.util.dbutil.DBHelper"%>
<%
	String usern = CommonString.getFormatPara(request.getParameter("usern")) ; // 
	String sel_sql = " select * from pro_agent_factory where is_show=1 and usern=?" ;
	DBHelper dbHelper = DBHelper.getInstance() ;
	Map agentInfo = null ;
	 if(!"".equals(usern)){   
		 agentInfo = dbHelper.getMap(sel_sql,new Object[]{usern}) ;
	 }
	 agentInfo = (agentInfo==null?new HashMap():agentInfo) ;
	String agent_area = CommonString.getFormatPara(agentInfo.get("city")) ;  // 代理商代理地区
	String agent_factory = CommonString.getFormatPara(agentInfo.get("agent_fac")) ;  // 代理品牌
	String agentId = CommonString.getFormatPara(agentInfo.get("id")) ;  // 代理商id 
	String agentCatanum = "select catalognum from pro_agent_product_vi where agentid=? group by catalognum" ;
	List<Map> agentCatanumList = null ;
	String agentCatanumStr = "" ;
	agentCatanumList = dbHelper.getMapList(agentCatanum,new Object[]{agentId}) ;
	if(null!=agentCatanumList && agentCatanumList.size()>0){
		for(Map oneMap:agentCatanumList){
			if(!"".equals(oneMap.get("catalognum"))){
				agentCatanumStr += "'"+oneMap.get("catalognum")+"'," ;
			}
		}
	}
	if(agentCatanumStr.length()>0 && agentCatanumStr.indexOf(",")!=-1){
		agentCatanumStr = agentCatanumStr.substring(0,agentCatanumStr.length()-1) ;
	}
	String whereStr = " ";
	if(!"".equals(agentCatanumStr)){
		whereStr += " and catanum in("+ agentCatanumStr+") ";
	}
	String[] agent_factorys = null ;
	String agent_factory_str = "" ;
	 if(agent_factory.length()>0 && agent_factory.indexOf(",")>0){
		 agent_factorys = agent_factory.split(",") ;
	 }else{
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
	 if(agent_area.length()>0 && agent_area.indexOf(",")==-1){ 
		  whereStr+= " and province+city like'%"+agent_area+"%'" ;
	 }
	 String where = "" ;
	 if(agent_area.length()>0 && agent_area.indexOf(",")>0){  // 代理多个区域
		 String[] agent_areas = agent_area.split(",") ;
		 for(int i=0;i<agent_areas.length;i++){
			 where+=" or contact_address like '%"+agent_areas[i]+"%'" ;
		 }
	 }
	 if(where.length()>0 && where.indexOf("or")>0){
		 where = where.replaceFirst("or","") ;
	 }
	 if(where.length()>0){
		 whereStr+= " and ( "+where+" )" ;
	 }
	 
	 String orderByStr = " id desc ";
	 String tableName = "pro_product_form" ;
	 String fields = "add_date,factoryid,factoryname,agentid,agentname,catanum,cataname,product_id,product_name,contact_address,mobile_phone,province,city,buy_time,message,company,name" ;
	 List<Map> proList = null ; // convert(varchar,add_date,23)='2013-04-17'
	 String pro_sql = "select "+fields +" from "+tableName+" where 1=1  "+whereStr+" order by "+orderByStr ;
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
					agentId  ,
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
	out.println("ok") ;
	//  System.out.println(pro_sql) ;
%>
