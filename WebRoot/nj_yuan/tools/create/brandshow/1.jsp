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
 	String innerMap="临工、柳工、龙工、洛阳路通、南方路机、日立、三一、厦工、山河智能、山推、山重建机、北车重工、常林股份、成工、德工、斗山、方圆集团、福田雷沃、抚挖、格瑞德、合力、恒特、恒天九五、鸿得利重工、加藤、江麓、杰西博、晋工、久保田、凯斯、雷萨、力士德、利勃海尔、山工、神钢、特雷克斯、同力重工、沃尔沃、现代、小松、新筑股份、徐工集团、宣工、玉柴、詹阳动力、杭叉、中联、住友";
	String innerList[]=innerMap.split("、");

    for(int i=0;i<innerList.length;i++){
	Map commentMap = dbHelper.getMap("select top 1 * from pro_agent_factory where name like '%"+innerList[i]+"%' or full_name like '%"+innerList[i]+"%'  ");

 
		usern = CommonString.getFormatPara(commentMap.get("usern"));
		root.put("usern",usern) ;
		freemarkerUtils.generate("brandshow/new_detail_right.htm",root,realPath+"/brandshow/"+usern+"/right.htm") ;  // 生成所有的品牌详显页右侧公共部分
		freemarkerUtils.generate("brandshow/new_detail.htm",root,realPath+"/brandshow/"+usern+"/index.htm") ;  // 生成所有的品牌详显页
		freemarkerUtils.generate("brandshow/new_intro.htm",root,realPath+"/brandshow/"+usern+"/intro.htm") ;  // 生成一个品牌介绍页
	 
	}	
 
	out.println("ok") ;
%>
