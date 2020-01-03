<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%><%@page import="com.jerehnet.util.common.CommonString"%><%@page import="com.jerehnet.util.dbutil.DBHelper"%><%@ page session="false" %><%@ taglib uri="/WEB-INF/classes/oscache.tld" prefix="cache"%>
<cache:cache cron="*/1 * * * *">
<%
	String catalog = CommonString.getFormatPara(request.getParameter("catalog"));
	String factory =  CommonString.getFormatPara(request.getParameter("factory"));
	Map catalogMap = (Map) application.getAttribute("catalogMap");
	Map brandMap = (Map) application.getAttribute("brandMap");
	String name="工程机械";
	if(!catalog.equals("0")||!factory.equals("0"))
	{
	   name=CommonString.getFormatPara(brandMap.get(factory))+CommonString.getFormatPara(catalogMap.get(catalog));
	}
%>
    <%if(catalog.equals("0")&&factory.equals("0")){%>
          <li class="top3"> <em>1</em>
            <h4><a title="<%=name%>型号大全" href="http://product.21-sun.com/products/prolist.jsp" target="_blank"><%=name%>型号大全</a></h4>
          </li>
          <li class="top3"> <em>2</em>
            <h4><a title="<%=name%>图片" href="http://photo.21-sun.com/" target="_blank"><%=name%>图片</a></h4>
          </li>
          <li class="top3"> <em>3</em>
            <h4><a title="<%=name%>口碑" href="http://koubei.21-sun.com/" target="_blank"><%=name%>口碑</a></h4>
          </li>
          <li> <em>4</em>
            <h4><a title="<%=name%>维修知识" href="http://weixiu.21-sun.com/" target="_blank"><%=name%>维修知识</a></h4>
          </li>
          <li> <em>5</em>
            <h4><a title="<%=name%>实拍大全" href="http://video.21-sun.com/" target="_blank"><%=name%>实拍大全</a></h4>
          </li>
          <li> <em>6</em>
            <h4><a title="<%=name%>专栏" href="http://spec.21-sun.com/" target="_blank"><%=name%>专栏</a></h4>
          </li>
          <li> <em>7</em>
            <h4><a title="<%=name%>动态" href="http://news.21-sun.com/" target="_blank"><%=name%>动态</a></h4>
          </li>
          <li> <em>8</em>
            <h4><a title="<%=name%>排行榜" href="http://top.21-sun.com/" target="_blank"><%=name%>排行榜</a></h4>
          </li>
    <%}if(!catalog.equals("0")&&factory.equals("0")){%>
	      <li class="top3"> <em>1</em>
            <h4><a title="<%=name%>型号大全" href="http://product.21-sun.com/products/prolist.jsp?catalog=<%=catalog%>" target="_blank"><%=name%>型号大全</a></h4>
          </li>
          <li class="top3"> <em>2</em>
            <h4><a title="<%=name%>图片" href="http://photo.21-sun.com/list.jsp?catalog=<%=catalog%>" target="_blank"><%=name%>图片</a></h4>
          </li>
          <li class="top3"> <em>3</em>
            <h4><a title="<%=name%>口碑" href="http://koubei.21-sun.com/<%=catalog%>-0-0-0-0.htm" target="_blank"><%=name%>口碑</a></h4>
          </li>
          <li> <em>4</em>
            <h4><a title="<%=name%>维修知识" href="http://weixiu.21-sun.com/<%=catalog%>-0-0.htm" target="_blank"><%=name%>维修知识</a></h4>
          </li>
          <li> <em>5</em>
            <h4><a title="<%=name%>实拍大全" href="http://video.21-sun.com/video_873_0_<%=catalog%>_1.htm" target="_blank"><%=name%>实拍大全</a></h4>
          </li>
          <li> <em>6</em>
            <h4><a title="<%=name%>专栏" href="http://spec.21-sun.com/list-<%=catalog.substring(0,3)%>-<%=catalog.length()>=6?catalog.substring(0,6):"0"%>-<%=catalog.length()>6?catalog:"0"%>-0-0-0.htm" target="_blank"><%=name%>专栏</a></h4>
          </li>
          <li> <em>7</em>
            <h4><a title="<%=name%>动态" href="http://news.21-sun.com/list/spec_0-<%=catalog%>-1.htm" target="_blank"><%=name%>动态</a></h4>
          </li>
          <li> <em>8</em>
            <h4><a title="<%=name%>排行榜" href="http://top.21-sun.com/brand_0_0_0_<%=catalog%>_0.htm" target="_blank"><%=name%>排行榜</a></h4>
          </li>
    <%} if(!factory.equals("0")&&catalog.equals("0")){%>
		      <li class="top3"> <em>1</em>
            <h4><a title="<%=name%>型号大全" href="http://product.21-sun.com/products/prolist.jsp?factory=<%=factory%>" target="_blank"><%=name%>型号大全</a></h4>
          </li>
          <li class="top3"> <em>2</em>
            <h4><a title="<%=name%>图片" href="http://photo.21-sun.com/list.jsp?factory=<%=factory%>" target="_blank"><%=name%>图片</a></h4>
          </li>
          <li class="top3"> <em>3</em>
            <h4><a title="<%=name%>口碑" href="http://koubei.21-sun.com/0-<%=factory%>-0-0-0.htm" target="_blank"><%=name%>口碑</a></h4>
          </li>
          <li> <em>4</em>
            <h4><a title="<%=name%>维修知识" href="http://weixiu.21-sun.com/0-0-<%=factory%>.htm" target="_blank"><%=name%>维修知识</a></h4>
          </li>
          <li> <em>5</em>
            <h4><a title="<%=name%>实拍大全" href="http://video.21-sun.com/video_873_<%=factory%>_0_1.htm" target="_blank"><%=name%>实拍大全</a></h4>
          </li>
          <li> <em>6</em>
		  
            <h4><a title="<%=name%>专栏" href="http://spec.21-sun.com/list-0-0-0-0-<%=factory%>-0.htm" target="_blank"><%=name%>专栏</a></h4>
			
          </li>
          <li> <em>7</em>
            <h4><a title="<%=name%>动态" href="http://news.21-sun.com/list/spec_<%=factory%>-0-1.htm" target="_blank"><%=name%>动态</a></h4>
          </li>
          <li> <em>8</em>
            <h4><a title="<%=name%>排行榜" href="http://top.21-sun.com/pro_0_0_0_<%=factory%>_0_0.htm" target="_blank"><%=name%>排行榜</a></h4>
          </li>
	<%} if(!catalog.equals("0")&&!factory.equals("0")){%>
	      <li class="top3"> <em>1</em>
            <h4><a title="<%=name%>型号大全" href="http://product.21-sun.com/products/prolist.jsp?factory=<%=factory%>&catalog=<%=catalog%>" target="_blank"><%=name%>型号大全</a></h4>
          </li>
          <li class="top3"> <em>2</em>
            <h4><a title="<%=name%>图片" href="http://photo.21-sun.com/list.jsp?factory=<%=factory%>&catalog=<%=catalog%>" target="_blank"><%=name%>图片</a></h4>
          </li>
          <li class="top3"> <em>3</em>
            <h4><a title="<%=name%>口碑" href="http://koubei.21-sun.com/<%=catalog%>-<%=factory%>-0-0-0.htm" target="_blank"><%=name%>口碑</a></h4>
          </li>
          <li> <em>4</em>
            <h4><a title="<%=name%>维修知识" href="http://weixiu.21-sun.com/<%=catalog%>-0-<%=factory%>.htm" target="_blank"><%=name%>维修知识</a></h4>
          </li>
          <li> <em>5</em>
            <h4><a title="<%=name%>实拍大全" href="http://video.21-sun.com/video_873_<%=factory%>_<%=catalog%>_1.htm" target="_blank"><%=name%>实拍大全</a></h4>
          </li>
          <li> <em>6</em>
		  
            <h4><a title="<%=name%>专栏" href="http://spec.21-sun.com/list-<%=catalog.substring(0,3)%>-<%=catalog.length()>=6?catalog.substring(0,6):"0"%>-<%=catalog.length()>6?catalog:"0"%>-0-<%=factory%>-0.htm" target="_blank"><%=name%>专栏</a></h4>
			
          </li>
          <li> <em>7</em>
            <h4><a title="<%=name%>动态" href="http://news.21-sun.com/list/spec_<%=factory%>-<%=catalog%>-1.htm" target="_blank"><%=name%>动态</a></h4>
          </li>
          <li> <em>8</em>
            <h4><a title="<%=name%>排行榜" href="http://top.21-sun.com/pro_0_0_0_<%=factory%>_<%=catalog%>_0.htm" target="_blank"><%=name%>排行榜</a></h4>
          </li>
	<%}%>
</cache:cache>