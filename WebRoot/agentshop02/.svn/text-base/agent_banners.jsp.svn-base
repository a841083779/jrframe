<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.jerehnet.util.common.CommonString"%>
<%
	String agentbanner = CommonString.getFormatPara(request.getParameter("agentbanner")) ;
	String agentbanner2 = CommonString.getFormatPara(request.getParameter("agentbanner2")) ;
	String agentbanner3 = CommonString.getFormatPara(request.getParameter("agentbanner3")) ;
	List<String> bannerList = new ArrayList() ;
	if(!"".equals(agentbanner)){
		bannerList.add("http://product.21-sun.com/uploadfiles/"+agentbanner) ;
	}
	if(!"".equals(agentbanner2)){
		bannerList.add("http://product.21-sun.com/uploadfiles/"+agentbanner2) ;
	}
	if(!"".equals(agentbanner3)){
		bannerList.add("http://product.21-sun.com/uploadfiles/"+agentbanner3) ;
	}
	if(bannerList.size()==0){ // 如果没有录入banner图则默认显示
		bannerList.add("http://product.21-sun.com/images/shop02/agentshop_banner.jpg") ;
	}
%>
      <div class="bannerShow">
        <ul class="imgs">
        <%
        	if(null!=bannerList && bannerList.size()>0){
        		for(String str:bannerList){
        			%>
        			<li><img src="<%=str %>" width="746" height="240" /></li>
        			<%
        		}
        	}
        %>
        </ul>
        <ul class="nums">
        <%
        	if(null!=bannerList && bannerList.size()>1){
        		for(int i=1;i<bannerList.size()+1;i++){
        			%>
        			<li value="<%=i %>" <%if(i==1){out.print("class='cur'");} %>></li>
        			<%
        		}
        	}
        %>
        </ul>
      </div>
