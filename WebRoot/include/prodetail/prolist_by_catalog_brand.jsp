<%@ page language="java" import="java.util.*,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*,java.sql.*" pageEncoding="GBK"%>
<%@page session="false" %>
<%@ taglib uri="/WEB-INF/classes/oscache.tld" prefix="cache"%>
<cache:cache  cron="* */7 * * *">
<%
	int catalog = CommonString.getFormatInt(request.getParameter("catalog")) ;   // ����
	int factoryid = CommonString.getFormatInt(request.getParameter("factoryid")) ; // Ʒ��	
	String url = CommonString.getFormatPara(request.getParameter("url"));
	String showType="";
	if(url.equals("pic")){ showType="ͼƬ";}
	if(url.equals("agent")){ showType="������";}
	if(url.equals("order")){ showType="�۸�";}
	if(url.equals("message")){ showType="�ڱ�";}
	
    if(url.equals("parameter")){ showType="����";}
    if(url.equals("intro")){ showType="����";}
	if(url.equals("video")){ showType="ʵ��";}
	if(url.equals("story")){ showType="��������";}
	if(url.equals("manual")){ showType="��Ʒ�ֲ�";}
	if(url.equals("weixiu")){ showType="ά��";}

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
		<a title='�鿴<%=CommonString.getFormatPara(m.get("factoryname"))+CommonString.getFormatPara(m.get("name"))+CommonString.getFormatPara(m.get("catalogname"))%><%=showType%>' target='_blank' href='/proDetail/<%=linkTo%>'>
		<%=CommonString.getFormatPara(m.get("factoryname"))+CommonString.getFormatPara(m.get("name"))+CommonString.getFormatPara(m.get("catalogname"))%><%=showType%>
        </a></h4></li>
			
			
       <%}}%>
  </cache:cache>