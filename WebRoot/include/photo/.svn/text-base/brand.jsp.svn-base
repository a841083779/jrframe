<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%><%@page import="com.jerehnet.util.common.CommonString"%><%@page import="com.jerehnet.util.dbutil.DBHelper"%><%@ taglib uri="/WEB-INF/classes/oscache.tld" prefix="cache"%><%
String factoryid = CommonString.getFormatPara(request.getParameter("factory_id")) ; // 品牌id 
String catalog = CommonString.getFormatPara(request.getParameter("catalog")) ; // 
String tonandmeter = CommonString.getFormatPara(request.getParameter("tonandmeter")) ;
String order = CommonString.getFormatPara(request.getParameter("order")) ;
String cachekey = factoryid+catalog+tonandmeter+order + "brandsss";
%><cache:cache cron="* * * */3 *" key="<%= cachekey%>"> <% 
    List finalBrands01 = new ArrayList() ; // A-G
	List finalBrands02 = new ArrayList() ; // H-N
	List finalBrands03 = new ArrayList() ; // O-T
	List finalBrands04 = new ArrayList() ; // U-Z
	List<Map> factorys = new ArrayList() ;
	String[] upperIndex02 = {"A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"} ;		
	List brandsList = null ;
	List oneFac = null ;		
	String facName="";
	String facId="" ;		
	Map brandsMap =  null ; // 以开头大写字母分类品牌
	DBHelper dbHelper = DBHelper.getInstance() ;
	String letter = "";
	for(int i=0;i<4;i++){
		brandsMap = new HashMap() ;
		brandsList = new ArrayList() ;
		// 每5个一组进行分组
			switch(i)
			{
			case 0:
				for(int j=0;j<7;j++)
				{
				 letter = CommonString.getFormatPara(upperIndex02[j]);
				 factorys = dbHelper.getMapList("  select facList.factoryid, facList.factoryname,facList.coun,allFac.upper_index from (SELECT factoryid, factoryname,count(factoryid) as coun  FROM pro_products  where catalognum like '%"+catalog+"%'  GROUP BY factoryid, factoryname) as facList,pro_agent_factory as allFac  where facList.factoryid=allFac.id and allFac.upper_index = '"+letter+"' ") ;
					 Iterator iter = factorys.iterator() ;
					 while(iter.hasNext())
					 {
						Map oneMap = (HashMap)iter.next() ;
						oneFac = new ArrayList() ;
						facName=CommonString.getFormatPara(oneMap.get("factoryname"));
						facId = CommonString.getFormatPara(oneMap.get("factoryid")) ;
						oneFac.add(facName);
						oneFac.add(facId) ;
						if(2==oneFac.size())  // 代理该品牌的数量不能为空
						{
						   brandsList.add(oneFac) ;
						}
					}			
					if(null!=brandsList && brandsList.size()>0)
					{
					  brandsMap.put("A-B-C-D-E-F-G", brandsList);
					}
			  }
				finalBrands01.add(brandsMap) ;	
				break;
			case 1:
				for(int j=0;j<7;j++)
				{
				 letter = CommonString.getFormatPara(upperIndex02[j+7]);
				 factorys = dbHelper.getMapList("  select facList.factoryid, facList.factoryname,facList.coun,allFac.upper_index from (SELECT factoryid, factoryname,count(factoryid) as coun  FROM pro_products  where catalognum like '%"+catalog+"%'  GROUP BY factoryid, factoryname) as facList,pro_agent_factory as allFac  where facList.factoryid=allFac.id and allFac.upper_index = '"+letter+"' ") ;
					 Iterator iter = factorys.iterator() ;
					 while(iter.hasNext())
					 {
						Map oneMap = (HashMap)iter.next() ;
						oneFac = new ArrayList() ;
						facName=CommonString.getFormatPara(oneMap.get("factoryname"));
						facId = CommonString.getFormatPara(oneMap.get("factoryid")) ;
						oneFac.add(facName);
						oneFac.add(facId) ;
						if(2==oneFac.size())  // 代理该品牌的数量不能为空
						{
						   brandsList.add(oneFac) ;
						}
					}			
					if(null!=brandsList && brandsList.size()>0)
					{
					  brandsMap.put("H-I-J-K-L-M-N", brandsList);
					}
			  }
				finalBrands02.add(brandsMap) ;
				break;
			case 2:
				for(int j=0;j<7;j++)
				{
				 letter = CommonString.getFormatPara(upperIndex02[j+14]);
				 factorys = dbHelper.getMapList("  select facList.factoryid, facList.factoryname,facList.coun,allFac.upper_index from (SELECT factoryid, factoryname,count(factoryid) as coun  FROM pro_products  where catalognum like '%"+catalog+"%'  GROUP BY factoryid, factoryname) as facList,pro_agent_factory as allFac  where facList.factoryid=allFac.id and allFac.upper_index = '"+letter+"' ") ;
					 Iterator iter = factorys.iterator() ;
					 while(iter.hasNext())
					 {
						Map oneMap = (HashMap)iter.next() ;
						oneFac = new ArrayList() ;
						facName=CommonString.getFormatPara(oneMap.get("factoryname"));
						facId = CommonString.getFormatPara(oneMap.get("factoryid")) ;
						oneFac.add(facName);
						oneFac.add(facId) ;
						if(2==oneFac.size())  // 代理该品牌的数量不能为空
						{
						   brandsList.add(oneFac) ;
						}
					}			
					if(null!=brandsList && brandsList.size()>0)
					{
					  brandsMap.put("O-P-Q-R-S-T", brandsList);
					}
			  }
				finalBrands03.add(brandsMap) ;
				break;
			case 3:
				for(int j=0;j<6;j++)
				{
				 letter = CommonString.getFormatPara(upperIndex02[j+20]);
				 factorys = dbHelper.getMapList("  select facList.factoryid, facList.factoryname,facList.coun,allFac.upper_index from (SELECT factoryid, factoryname,count(factoryid) as coun  FROM pro_products  where catalognum like '%"+catalog+"%'  GROUP BY factoryid, factoryname) as facList,pro_agent_factory as allFac  where facList.factoryid=allFac.id and allFac.upper_index = '"+letter+"' ") ;
					 Iterator iter = factorys.iterator() ;
					 while(iter.hasNext())
					 {
						Map oneMap = (HashMap)iter.next() ;
						oneFac = new ArrayList() ;
						facName=CommonString.getFormatPara(oneMap.get("factoryname"));
						facId = CommonString.getFormatPara(oneMap.get("factoryid")) ;
						oneFac.add(facName);
						oneFac.add(facId) ;
						if(2==oneFac.size())  // 代理该品牌的数量不能为空
						{
						   brandsList.add(oneFac) ;
						}
					}			
					if(null!=brandsList && brandsList.size()>0)
					{
					  brandsMap.put("U-V-W-X-Y-Z", brandsList);
					}
			  }
				finalBrands04.add(brandsMap) ;
				break;
    	}
	}
%> <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
  <html xmlns="http://www.w3.org/1999/xhtml">
  <head>
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
  <title>无标题文档</title>
  <style type="text/css">
a:link, a:visited {
	color:#666666;
}
a:hover {
	color:#ff6600;
}
.STYLE1 {
	color: #FFFFFF
}
.pllist {
	width:85%;
	float:left;
	min-height:50px;
	overflow:visible;
	position:relative;
	padding-top:23px;
	border-bottom:#ccc 1px dotted;
	margin-right:1%;
	padding-left:8px;
}
.pllist a.plfl {
	position:absolute;
	left:8px;
	top:0px;
	margin:5px;
	font-size:14px;
	font-family:Verdana;
	font-weight:bold;
	color:#3355AC;
	cursor:default;
	float:none;
	padding:0px;
	width:auto;
	text-decoration:none;
}
.pllist a {
	display:inline-block;
	margin:0px 5px;
	font-size:12px;
	line-height:20px;
	height:20px;
	overflow:hidden;
	float:none;
	padding:0px;
	width:auto;
	text-decoration:none;
}
</style>
  </head>
  <body style="background-color:transparent;">
  <div class="plmore"  style="padding-left:0px; width:650px;">
    <div class="pllist"> <a class="plfl"> A-B-C-D-E-F-G </a><br/>
      <%
           Iterator iter01 = finalBrands01.iterator() ;
       	while(iter01.hasNext())
       	{
       		Map oneMap = (HashMap)iter01.next() ;
       		List oneList = (null==(ArrayList)oneMap.get("A-B-C-D-E-F-G"))?new ArrayList():(ArrayList)oneMap.get("A-B-C-D-E-F-G") ;
                Iterator oneIter = oneList.iterator() ;
                while(null !=oneIter&&oneIter.hasNext())
                {
               	  List l = (ArrayList)oneIter.next() ;
               	  for(int k=0;k<l.size();k+=2)
               	  {
               		  %>
      <a href="/photo/list.jsp?factoryid=<%=l.get(k+1) %>&catalogid=<%=catalog %><%="".equals(tonandmeter)?"":"&tonandmeter="+tonandmeter+""%><%="".equals(order)?"\"":"&order="+order+"\"" %> target="_top"><%=l.get(k) %></a>
      <%
               		  }
                }
        	}
           %>
    </div>
    <div class="pllist"> <a class="plfl"> H-I-J-K-L-M-N </a> <br/>
      <%
            Iterator iter02 = finalBrands02.iterator() ;
       	while(iter02.hasNext())
       	{
       		Map oneMap = (HashMap)iter02.next() ;
       		List oneList = (null==(ArrayList)oneMap.get("H-I-J-K-L-M-N"))?new ArrayList():(ArrayList)oneMap.get("H-I-J-K-L-M-N") ;
                Iterator oneIter = oneList.iterator() ;
                while(null !=oneIter&&oneIter.hasNext())
                {
               	  List l = (ArrayList)oneIter.next() ;
               	  for(int k=0;k<l.size();k+=2)
               	  {
               		  %>
      <a href="/photo/list.jsp?factoryid=<%=l.get(k+1) %>&catalogid=<%=catalog %><%="".equals(tonandmeter)?"":"&tonandmeter="+tonandmeter+""%><%="".equals(order)?"\"":"&order="+order+"\"" %> target="_top"><%=l.get(k) %></a>
      <%
               		  }
                }
        	}
           %>
    </div>
    <div class="pllist"> <a class="plfl"> O-P-Q-R-S-T </a><br/>
      <%
            Iterator iter03 = finalBrands03.iterator() ;
       	while(iter03.hasNext())
       	{
       		Map oneMap = (HashMap)iter03.next() ;
       		List oneList = (null==(ArrayList)oneMap.get("O-P-Q-R-S-T"))?new ArrayList():(ArrayList)oneMap.get("O-P-Q-R-S-T") ;
                Iterator oneIter = oneList.iterator() ;
                while(null !=oneIter&&oneIter.hasNext())
                {
               	  List l = (ArrayList)oneIter.next() ;
               	  for(int k=0;k<l.size();k+=2)
               	  {
               		  %>
      <a href="/photo/list.jsp?factoryid=<%=l.get(k+1) %>&catalogid=<%=catalog %><%="".equals(tonandmeter)?"":"&tonandmeter="+tonandmeter+""%><%="".equals(order)?"\"":"&order="+order+"\"" %> target="_top"><%=l.get(k) %></a>
      <%
               		  }
                }
        	}
           %>
    </div>
    <div class="pllist"> <a class="plfl"> U-V-W-X-Y-Z </a> <br/>
      <%
            Iterator iter04 = finalBrands04.iterator() ;
       	while(iter04.hasNext())
       	{
       		Map oneMap = (HashMap)iter04.next() ;
       		List oneList = (null==(ArrayList)oneMap.get("U-V-W-X-Y-Z"))?new ArrayList():(ArrayList)oneMap.get("U-V-W-X-Y-Z") ;
            Iterator oneIter = oneList.iterator() ;
            while(null !=oneIter&&oneIter.hasNext())
            {
           	  List l = (ArrayList)oneIter.next() ;
           	  for(int k=0;k<l.size();k+=2)
           	  {
           		  %>
      <a href="/photo/list.jsp?factoryid=<%=l.get(k+1) %>&catalogid=<%=catalog %><%="".equals(tonandmeter)?"":"&tonandmeter="+tonandmeter+""%><%="".equals(order)?"\"":"&order="+order+"\"" %> target="_top"><%=l.get(k) %></a>
      <%
           		  }
            }
    	}
           %>
    </div>
  </div>
  </body>
  </html>
</cache:cache>
