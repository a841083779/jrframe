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
	String[][] factory=new String[2][2]; 
	factory[0][0]="137";   factory[0][1]="sdlg"; 
    factory[1][0]="135";   factory[1][1]="chinalonggong"; 
      for(int i=0;i<factory.length;i++){	
	List<Map> allbrandMap = dbHelper.getMapList("select usern from pro_agent_factory where id="+factory[i][0]+" and   is_show=1 and  flag = 1 and usern<>'tdbenniu'  ") ;
	
	String flag = CommonString.getFormatPara(request.getParameter("flag"));
	String name = CommonString.getFormatPara(request.getParameter("name"));
	//name="dlheimao";
	name=factory[i][1];
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
