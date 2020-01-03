<%@ page language="java" import="java.util.*,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*,java.sql.*" pageEncoding="GBK"%>
<%@page session="false" %>
<%@ taglib uri="/WEB-INF/classes/oscache.tld" prefix="cache"%>
<cache:cache  cron="* */7 * * *">
<%
	String catalognum = CommonString.getFormatPara(request.getParameter("catalognum"));
	String catalog="";
	if(catalognum.equals("101001001")||catalognum.equals("101002003")||catalognum.equals("101003001"))
	{
	   catalog=catalognum.substring(0,6);
	}else{
	   catalog=catalognum;
	}
	String koubeiCata=catalognum.length()>6?catalognum.substring(0,6):catalognum;
	String id = CommonString.getFormatPara(request.getParameter("id"));
	String catalogname=CommonString.getFormatPara(request.getParameter("catalogname"));
	String url = CommonString.getFormatPara(request.getParameter("url"));
    String moreUrl="";
	String showType="";
	if(url.equals("pic")){ showType="图片";moreUrl="http://photo.21-sun.com/list.jsp?catalog="+catalognum;}
	else if(url.equals("agent")){ showType="代理商";moreUrl="http://product.21-sun.com/agent/0_0_0_"+catalognum+".shtm";}
	else if(url.equals("order")){ showType="价格";moreUrl="http://product.21-sun.com/inquiry/0_0_0_"+catalognum+"_0.shtm";}
	else if(url.equals("message")){ showType="口碑";moreUrl="http://koubei.21-sun.com/"+koubeiCata+"-0-0.htm";}
	else if(url.equals("parameter")){ showType="参数"; moreUrl="/products/prolist.jsp?catalog="+catalog;}
    else if(url.equals("intro")){ showType="性能"; moreUrl="/products/prolist.jsp?catalog="+catalog;}
	else if(url.equals("video")){ showType="实拍"; moreUrl="/products/prolist.jsp?catalog="+catalog;}
	else if(url.equals("story")){ showType="创富故事"; moreUrl="/products/prolist.jsp?catalog="+catalog;}
	else if(url.equals("manual")){ showType="产品手册"; moreUrl="/products/prolist.jsp?catalog="+catalog;}
	else if(url.equals("weixiu")){ showType="维修"; moreUrl="/products/prolist.jsp?catalog="+catalog;}

    else{moreUrl="/products/prolist.jsp?catalog="+catalog;}
	String sql = "";
	String proSql = ""; 
	Double dw ;
	if(catalognum.equals("101001")||catalognum.equals("101002")||catalognum.equals("102")||catalognum.equals("101001001")){
	    if(catalognum.equals("101001")||catalognum.equals("101001001")){
     	   proSql = " select  tonandmeter from pro_products where id="+id;
		   
		   dw = (Double)DBHelper.getInstance().getOne(proSql);
		   if(dw<=13){
		   catalogname=catalogname+"(小挖)";
		   sql = " select top 6 id,img2,add_date,factoryname,catalogname,name,file_name from pro_products where is_show=1 and  catalognum = '"+catalognum+"' and tonandmeter<=13 and img2 is not null and img2 != '' order by view_count desc";
		   }else if(dw<=30){
		   catalogname=catalogname+"(中挖)";
		   sql = " select top 6 id,img2,add_date,factoryname,catalogname,name,file_name from pro_products where is_show=1 and  catalognum = '"+catalognum+"' and tonandmeter>13  and tonandmeter<30 and img2 is not null and img2 != '' order by view_count desc";
		   }else{
		   catalogname=catalogname+"(大挖)";
		   sql = " select top 6 id,img2,add_date,factoryname,catalogname,name,file_name from pro_products where  is_show=1 and catalognum = '"+catalognum+"' and tonandmeter>30 and img2 is not null and img2 != '' order by view_count desc";
		   }
		}
	    if(catalognum.equals("101002")){
	       proSql = " select  tonandmeter from pro_products where id="+id;
		   dw = (Double)DBHelper.getInstance().getOne(proSql);
		   if(dw<3){
		   catalogname=catalogname+"(3T以下)";
		   sql = " select top 6 id,img2,add_date,factoryname,catalogname,name,file_name from pro_products where is_show=1 and  catalognum = '"+catalognum+"' and tonandmeter<3 and img2 is not null and img2 != '' order by view_count desc";
		   }else if(dw==3){
		   catalogname=catalogname+"(3T)";
		   sql = " select top 6 id,img2,add_date,factoryname,catalogname,name,file_name from pro_products where is_show=1 and  catalognum = '"+catalognum+"' and tonandmeter=3 and img2 is not null and img2 != '' order by view_count desc";
		   }else if(dw<=5){
		   catalogname=catalogname+"(3T~5T)";
		   sql = " select top 6 id,img2,add_date,factoryname,catalogname,name,file_name from pro_products where is_show=1 and  catalognum = '"+catalognum+"' and tonandmeter>3 and tonandmeter<=5 and img2 is not null and img2 != '' order by view_count desc";
		   }else{
		   catalogname=catalogname+"(5T以上)";
		   sql = " select top 6 id,img2,add_date,factoryname,catalogname,name,file_name from pro_products where is_show=1 and  catalognum = '"+catalognum+"' and tonandmeter>5 and img2 is not null and img2 != '' order by view_count desc";
		   }
		}
		if(catalognum.equals("102")){
	       proSql = " select  tonandmeter from pro_products where id="+id;
		   dw = (Double)DBHelper.getInstance().getOne(proSql);
		   if(dw<=16){
		   catalogname=catalogname+"(16T以下)";
		   sql = " select top 6 id,img2,add_date,factoryname,catalogname,name,file_name from pro_products where is_show=1 and  catalognum = '"+catalognum+"' and tonandmeter<=16 and img2 is not null and img2 != '' order by view_count desc";
		   }else if(dw<=70){
		   catalogname=catalogname+"(20T~70T)";
		   sql = " select top 6 id,img2,add_date,factoryname,catalogname,name,file_name from pro_products where is_show=1 and  catalognum = '"+catalognum+"' and tonandmeter>16 and tonandmeter<70 and img2 is not null and img2 != '' order by view_count desc";
		   }else{
		   catalogname=catalogname+"(70T以上)";
		   sql = " select top 6 id,img2,add_date,factoryname,catalogname,name,file_name from pro_products where is_show=1 and  catalognum = '"+catalognum+"' and tonandmeter>70 and img2 is not null and img2 != '' order by view_count desc";
		   }
	    }
	}else{
    sql = " select top 6 id,img2,add_date,factoryname,catalogname,name,file_name from pro_products where  catalognum = '"+catalognum+"' and img2 is not null and img2 != '' order by view_count desc";
	}
	List <Map>list = (List <Map>)DBHelper.getInstance().getMapList(sql,new Object[]{});
%>
      <div class="stitle">
        <h3><%=catalogname%></h3>
        <span class="more"><a title="更多<%=catalogname%><%=showType%>" href="<%=moreUrl%>" target="_blank">更多&gt;&gt;</a></span></div>
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
          <li><a href="/proDetail/<%=linkTo%>" target="_blank" title="<%=CommonString.getFormatPara(m.get("factoryname")) %><%=CommonString.getFormatPara(m.get("name")) %><%=CommonString.getFormatPara(m.get("catalogname")) %><%=showType%>"><img src="http://product.21-sun.com/uploadfiles/<%=CommonString.getFormatPara(m.get("img2")) %>" alt="<%=CommonString.getFormatPara(m.get("factoryname")) %><%=CommonString.getFormatPara(m.get("name")) %><%=CommonString.getFormatPara(m.get("catalogname")) %><%=showType%>" onerror="showImgDelay(this,'/uploadfiles/no_small.gif',2);" width="80" height="70"></a>
           <a href="/proDetail/<%=linkTo%>" target="_blank" title="<%=CommonString.getFormatPara(m.get("factoryname")) %><%=CommonString.getFormatPara(m.get("name")) %><%=CommonString.getFormatPara(m.get("catalogname")) %><%=showType%>">           
		  <h4><%=CommonString.getFormatPara(m.get("factoryname")) %><%=CommonString.getFormatPara(m.get("name")) %><%=CommonString.getFormatPara(m.get("catalogname")) %><%=showType%></h4>
            </a></li>
       <%}}%>
        </ul>
      </div>
	    </cache:cache>