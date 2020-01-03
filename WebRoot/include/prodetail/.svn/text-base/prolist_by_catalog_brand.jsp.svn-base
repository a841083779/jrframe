<%@ page language="java" import="java.util.*,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*,java.sql.*" pageEncoding="GBK"%>
<%@page session="false" %>
<%@ taglib uri="/WEB-INF/classes/oscache.tld" prefix="cache"%>
<cache:cache  cron="* */7 * * *">
<%
	int catalog = CommonString.getFormatInt(request.getParameter("catalog")) ;   // 类型
	int factoryid = CommonString.getFormatInt(request.getParameter("factoryid")) ; // 品牌	
	String url = CommonString.getFormatPara(request.getParameter("url"));
	String showType="";
	if(url.equals("pic")){ showType="图片";}
	if(url.equals("agent")){ showType="代理商";}
	if(url.equals("order")){ showType="价格";}
	if(url.equals("message")){ showType="口碑";}
	
    if(url.equals("parameter")){ showType="参数";}
    if(url.equals("intro")){ showType="性能";}
	if(url.equals("video")){ showType="实拍";}
	if(url.equals("story")){ showType="创富故事";}
	if(url.equals("manual")){ showType="产品手册";}
	if(url.equals("weixiu")){ showType="维修";}

	List<Map> proList = null ;
	String do_sql ="select top 6 file_name,name,factoryname,catalogname from pro_products where is_show=1 and factoryid="+factoryid+" and catalognum ="+catalog;
	List <Map>list = (List <Map>)DBHelper.getInstance().getMapList(do_sql,new Object[]{});
%>

		<%
			String linkTo=""; 
			if(list != null && list.size() > 0){
				for(Map m : list){
				linkTo=CommonString.getFormatPara(m.get("file_name"));
				if(!url.equals("")){
				linkTo=linkTo.replace(".shtm","")+"_"+url+".shtm";
				}
		%>
		<li class='top3'><h4>
		<a title='查看<%=CommonString.getFormatPara(m.get("factoryname"))+CommonString.getFormatPara(m.get("name"))+CommonString.getFormatPara(m.get("catalogname"))%><%=showType%>' target='_blank' href='/proDetail/<%=linkTo%>'>
		<%=CommonString.getFormatPara(m.get("factoryname"))+CommonString.getFormatPara(m.get("name"))+CommonString.getFormatPara(m.get("catalogname"))%><%=showType%>
        </a></h4></li>
			
			
       <%}}%>
  </cache:cache>