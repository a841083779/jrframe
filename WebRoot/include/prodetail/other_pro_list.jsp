<%@ page language="java" import="java.util.*,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*,java.sql.*" pageEncoding="gbk"%>
<%@page session="false" %>
<%@ taglib uri="/WEB-INF/classes/oscache.tld" prefix="cache"%>
<cache:cache  cron="* */9 * * *">
<%
	String catalognum = CommonString.getFormatPara(request.getParameter("catalognum"));
	//������ھ���Ļ��Ƽ�һ�����ص��ھ��
	Map recomMap = null ;
	if(catalognum.indexOf("101001")!=-1){
	String sqlCat="select top 1 id,img2,add_date,factoryname,catalogname,name,file_name from pro_products where is_show=1  and factoryid=174 and catalognum like '101001%' order by view_count desc";
	recomMap =DBHelper.getInstance().getMap(sqlCat) ;
	}
	String sql = " select top 4 id,img2,add_date,factoryname,catalogname,name,file_name from pro_products where is_show=1 and catalognum = '"+catalognum+"' and img2 is not null and img2 != '' order by newid()  ";
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
	List <Map>list = (List <Map>)DBHelper.getInstance().getMapList(sql,new Object[]{});
	if(list != null && list.size() > 0&&recomMap!=null){
										 list.remove(0) ;
										 list.add(0,recomMap) ;
	}
%>
	  <div class="scontent">
        <ul class="slist">
		 <%
			String linkTo="";
			if(list != null && list.size() > 0){
				for(Map m : list){
				linkTo=CommonString.getFormatPara(m.get("file_name"));
				if(!url.equals("")){
				linkTo=linkTo.replace(".shtm","")+"_"+url+".shtm";
				}
		%>
          <li><a href="/proDetail/<%=linkTo%>" target="_blank" title="<%=CommonString.getFormatPara(m.get("factoryname")) %><%=CommonString.getFormatPara(m.get("name")) %><%=CommonString.getFormatPara(m.get("catalogname")) %><%=showType%>"><img src="http://product.21-sun.com/uploadfiles/<%=CommonString.getFormatPara(m.get("img2")) %>" alt="<%=CommonString.getFormatPara(m.get("factoryname")) %><%=CommonString.getFormatPara(m.get("name")) %><%=CommonString.getFormatPara(m.get("catalogname")) %><%=showType%>" onerror="showImgDelay(this,'/uploadfiles/no_small.gif',2);" width="80" height="70" />
            </a>
			<h4>
			<a href="/proDetail/<%=linkTo%>" target="_blank" title="<%=CommonString.getFormatPara(m.get("factoryname")) %><%=CommonString.getFormatPara(m.get("name")) %><%=CommonString.getFormatPara(m.get("catalogname")) %><%=showType%>">
			<%=CommonString.getFormatPara(m.get("factoryname")) %><%=CommonString.getFormatPara(m.get("name")) %><%=CommonString.getFormatPara(m.get("catalogname")) %><%=showType%></a></h4>
            </li>		
       <%}}%>
       </ul>
    </div>
	  </cache:cache>  
	  

 