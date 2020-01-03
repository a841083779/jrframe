<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.jerehnet.util.common.Common"%>
<%@page import="com.jerehnet.util.freemarker.FreemarkerUtils"%>
<%@page import="com.jerehnet.util.dbutil.DBHelper"%>
<%@page import="com.jerehnet.util.common.CommonString"%>
<%
	Map catalogMap = (HashMap)application.getAttribute("catalogMap") ;
	// 生成所有产品详细页
	String realPath = Common.getAbsolutePath(request) ;
	FreemarkerUtils freemarkerUtils = new FreemarkerUtils(realPath+"template/") ;
	DBHelper dbHelper = DBHelper.getInstance() ;
	Map root = null;
	String factoryid="";
	String factoryname="";
    
	List<Map> allbrandMap = dbHelper.getMapList("select  id from pro_agent_factory where  is_show=1 and ( flag!=1 or flag=2) order by id asc") ;
   	if(null != allbrandMap && allbrandMap.size()>0){
	root = new HashMap();
		for(Map oneMap:allbrandMap){
			factoryid = CommonString.getFormatPara(oneMap.get("id")) ;
			root.put("agent_id",factoryid) ;
			System.out.println();
          freemarkerUtils.generate("catalog_pro.htm",root,realPath+"/include/mobile/include_agent_"+factoryid+".htm") ;
		}
	}
	out.println("ok") ;
%>
