<%@ page language="java" import="java.util.*,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*,java.sql.*" pageEncoding="GBK"%>
<%@page session="false" %>
<%@ taglib uri="/WEB-INF/classes/oscache.tld" prefix="cache"%>
<%
	String id = CommonString.getFormatPara(request.getParameter("id"));
	String proname = CommonString.getFormatPara(request.getParameter("proname"));
	
	String catalog = CommonString.getFormatPara(request.getParameter("catalog"));
	if(catalog.equals("")){catalog="0";}else {if(catalog.length()>=6){catalog=catalog.substring(0,6);}}
	String factoryid = CommonString.getFormatPara(request.getParameter("factoryid"));
	
	String sql = "SELECT * FROM ( SELECT pm.id,pm.score1,pm.score2,pm.score3,pm.score4,pm.content,pm.good,pm.bad,pm.name contact_address,pm.product_id,pp.factoryid,pp.factoryname,pp.catalognum,pp.catalogname,pp.name product_name,pp.img2,pp.file_name,pm.add_date,pp.view_count,pm.username FROM pro_comments pm left join pro_products pp on pm.product_id=pp.id  where pm.is_show=1) AS comments WHERE  comments.product_id="+id+" order by id desc";
	
%>
	<cache:cache  cron="*/1 * * * *">
   <div class="l np_fix" style=" width:100%;">
     <div class="np_pdproname l" style="width:auto;"><%=proname%>口碑</div>
     <div class="r"><a title="更多<%=proname%>口碑" target="_blank" href="http://koubei.21-sun.com/<%="".equals(catalog)?"0" :catalog%>-<%="".equals(factoryid)?"0" :factoryid%>-0.htm">更多&gt;&gt;</a></div>
   </div>
  <div class="plList">
    <ul> 
        <%
        List <Map>list = (List <Map>)DBHelper.getInstance().getMapList(sql,new Object[]{});
			if(list != null && list.size() > 0){
				for(Map m : list){
		%>
				   <li class="">
			        <div class="plimg"><a href="/proDetail/<%=CommonString.getFormatPara(m.get("file_name")) %>" target="_blank" title="<%=CommonString.getFormatPara(m.get("factoryname")) %><%=CommonString.getFormatPara(m.get("product_name")) %><%=CommonString.getFormatPara(m.get("catalogname")) %>"><img src="http://product.21-sun.com/uploadfiles/<%=CommonString.getFormatPara(m.get("img2")) %>" onerror="showImgDelay(this,'/uploadfiles/no_big.gif',2);" alt="<%=CommonString.getFormatPara(m.get("factoryname")) %><%=CommonString.getFormatPara(m.get("product_name")) %><%=CommonString.getFormatPara(m.get("catalogname")) %>"></a></div>
			        <div class="content">
			          <h3><a href="/proDetail/<%=CommonString.getFormatPara(m.get("file_name")) %>" target="_blank"><%=CommonString.getFormatPara(m.get("factoryname")) %><%=CommonString.getFormatPara(m.get("product_name")) %><%=CommonString.getFormatPara(m.get("catalogname")) %></a></h3> <span class="time"><%=CommonDate.getFormatDate("yyyy-MM-dd HH:mm", CommonString.getFormatPara(m.get("add_date"))) %></span>
			          <div class="plinfo01"><span class="plname"><%=CommonString.getFormatPara(m.get("username")).equals("")?CommonString.getFormatPara(m.get("contact_address")):CommonString.getFormatPara(m.get("username")) %>评论</span></div>
                      <div class="w100 l">
                        <p class="textContent">
						<%if(CommonString.getFormatPara(m.get("good"))!=null&&!CommonString.getFormatPara(m.get("good")).equals("")){%>
						优点: <%=CommonString.getFormatPara(m.get("good")) %></br>
						 <%}%>
						 <%if(CommonString.getFormatPara(m.get("bad"))!=null&&!CommonString.getFormatPara(m.get("bad")).equals("")){%>
						 缺点:<%=CommonString.getFormatPara(m.get("bad")) %></br>
					    <%}%>
                        <%=CommonString.getFormatPara(m.get("content")) %>
                        </p>
                        <div class="r plt">网友评分 <font><%=(Integer.parseInt(CommonString.getFormatPara(m.get("score1")))+Integer.parseInt(CommonString.getFormatPara(m.get("score2")))+Integer.parseInt(CommonString.getFormatPara(m.get("score3"))) +Integer.parseInt(CommonString.getFormatPara(m.get("score4"))))/4%></font> 分</div>
                      </div>
			          <div class="plinfo02">
			          	阅读 <%=CommonString.getFormatPara(m.get("view_count")) %>  | <a href="/products/prolist.jsp?catalog=<%=CommonString.getFormatPara(m.get("catalognum")) %>&factory=<%=CommonString.getFormatPara(m.get("factoryid")) %>" target="_blank"><%=CommonString.getFormatPara(m.get("factoryname")) %><%=CommonString.getFormatPara(m.get("catalogname")) %></a>  | <a target="_blank" href="http://koubei.21-sun.com/detail/<%=CommonString.getFormatPara(m.get("id")) %>.htm">详细</a>
			          </div> 
			          <div class="plinfo03" style="display:none">
			          	<a href=""><%=CommonString.getFormatPara(m.get("factoryname")) %><%=CommonString.getFormatPara(m.get("catalogname")) %></a>  | <a href="http://product.21-sun.com/proDetail/<%=CommonString.getFormatPara(m.get("file_name")).substring(0,CommonString.getFormatPara(m.get("file_name")).lastIndexOf(".")) %>_order.shtm#myTab2" target="_target">订单</a> | <a href="http://photo.21-sun.com/detail_for_<%=CommonString.getFormatPara(m.get("product_id")) %>.htm" target="_blank">图片</a> | <a href="http://product.21-sun.com/proDetail/<%=CommonString.getFormatPara(m.get("file_name")).substring(0,CommonString.getFormatPara(m.get("file_name")).lastIndexOf(".")) %>_order.shtm#prodetailOrder" target="_blank">询最低价</a>
			          </div> 
			        </div>
			      </li>	  
        <%}}else{%>
		<div align="center"><strong>暂无评论</strong></div>
		<%}%>
    </ul>
  </div>
  </cache:cache>