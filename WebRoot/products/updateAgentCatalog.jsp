<%@ page language="java" import="java.util.*,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*,java.sql.*" pageEncoding="UTF-8"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Calendar"%>
<%@ taglib uri="/WEB-INF/classes/oscache.tld" prefix="cache"%>
<%
String catIdStr="";String catNameStr="";
DBHelper dbHelper = DBHelper.getInstance() ;
List<Map> list=dbHelper.getMapList(" select  id from pro_agent_factory where is_show=1 and flag=2 and levelflag =0 ");//and id=226
for(Map m:list){
	String id=CommonString.getFormatPara(m.get("id"));
	List<Map> cataList=dbHelper.getMapList(" select catalognum from pro_agent_products where agent_id="+id+" and catalognum is not null and catalognum !=''  group by catalognum; ");
	catIdStr=",";catNameStr="";
	for(Map cata:cataList){
		String catalognum=CommonString.getFormatPara(cata.get("catalognum"));
		if(catalognum.indexOf("101001")>=0&&!catalognum.equals("101001098")&&!catalognum.equals("101001099")){//挖掘机
			if(catIdStr.indexOf(",1,")==-1){
				catIdStr+="1,";
				catNameStr+="挖掘机,";
			}
		}
		if(catalognum.indexOf("101002")>=0){//装载机
			if(catIdStr.indexOf(",2,")==-1){
				catIdStr+="2,";
				catNameStr+="装载机,";
			}
		}
		if(catalognum.indexOf("102")>=0){//起重机
			if(catIdStr.indexOf(",3,")==-1){
				catIdStr+="3,";
				catNameStr+="起重机,";
			}
		}
		if(catalognum.indexOf("105")>=0){//桩工机械
			if(catIdStr.indexOf(",4,")==-1){
				catIdStr+="4,";
				catNameStr+="桩工机械,";
			}
		}
		if(catalognum.indexOf("106001")>=0){//压路机
			if(catIdStr.indexOf(",5,")==-1){
				catIdStr+="5,";
				catNameStr+="压路机,";
			}
		}
		if(catalognum.indexOf("101003")>=0){//推土机
			if(catIdStr.indexOf(",6,")==-1){
				catIdStr+="6,";
				catNameStr+="推土机,";
			}
		}
		if(catalognum.indexOf("107")>=0){//叉车
			if(catIdStr.indexOf(",7,")==-1){
				catIdStr+="7,";
				catNameStr+="叉车,";
			}
		}
		if(catalognum.indexOf("103")>=0){//混凝土机械
			if(catIdStr.indexOf(",8,")==-1){
				catIdStr+="8,";
				catNameStr+="混凝土机械,";
			}
		}
		if(catalognum.indexOf("104")>=0){//路面机械
			if(catIdStr.indexOf(",9,")==-1){
				catIdStr+="9,";
				catNameStr+="路面机械,";
			}
		}
		if(catalognum.indexOf("101005")>=0){//平地机
			if(catIdStr.indexOf(",10,")==-1){
				catIdStr+="10,";
				catNameStr+="平地机,";
			}
		}
		if(catalognum.equals("101001098")||catalognum.equals("101001099")){//破碎锤/液压剪  
			if(catIdStr.indexOf(",11,")==-1){
				catIdStr+="11,";
				catNameStr+="破碎锤/液压剪,";
			}
		}

	}
	//catIdStr=catIdStr.substring(1,catIdStr.length()-1);
	//catNameStr=catNameStr.substring(0,catNameStr.length()-1);
	dbHelper.executeUpdate(" update pro_agent_factory set catalog_num ='"+catIdStr+"', catalog_name='"+catNameStr+"' where id="+id);
}
out.println("catIdStr:"+catIdStr+";catNameStr:"+catNameStr);
%>