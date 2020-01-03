<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.jerehnet.util.common.Common"%>
<%@page import="com.jerehnet.util.freemarker.FreemarkerUtils"%>
<%@page import="com.jerehnet.util.freemarker.FreemarkerWebserviceUtils"%>
<%@page import="com.jerehnet.util.dbutil.DBHelper"%>
<%@page import="com.jerehnet.util.common.CommonString"%>
<%
// 生成所有的品牌详显页
	String realPath = Common.getAbsolutePath(request) ;
	FreemarkerUtils freemarkerUtils = new FreemarkerUtils(realPath+"template/") ;
    FreemarkerWebserviceUtils freemarkerWebserviceUtils = new FreemarkerWebserviceUtils(realPath+"template/") ; 	
	String usern = "" ; // 品牌代号
	DBHelper dbHelper = DBHelper.getInstance() ;
	Map root = new HashMap() ;
	String[][] factory=new String[1][1]; 
	factory[0][0]="china-sg";  

	
      for(int i=0;i<factory.length;i++){	

	String flag = CommonString.getFormatPara(request.getParameter("flag"));
	String name = CommonString.getFormatPara(request.getParameter("name"));
	//name="dlheimao";
	//name=factory[i][0];
	if(name!=null && !name.equals("")){
		usern = name;
		root.put("usern",usern) ;
		freemarkerUtils.generate("brandshow/new_detail_right.htm",root,realPath+"/brandshow/"+usern+"/right.htm") ;  // 生成所有的品牌详显页右侧公共部分
		freemarkerUtils.generate("brandshow/new_detail.htm",root,realPath+"/brandshow/"+usern+"/index.htm") ;  // 生成所有的品牌详显页
		freemarkerUtils.generate("brandshow/new_intro.htm",root,realPath+"/brandshow/"+usern+"/intro.htm") ;  // 生成一个品牌介绍页

	}
	
	}
	//Common.doGet("/tools/create/news/create_news_index.jsp") ;
	out.println("ok") ;
%>
