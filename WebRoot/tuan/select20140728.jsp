<%@ page language="java" import="com.jerehnet.util.dbutil.PageBean,com.jerehnet.util.common.CommonString,com.jerehnet.util.dbutil.DBHelper,java.util.*" pageEncoding="UTF-8"%>
<% 
   	String catalog = CommonString.getFormatPara(request.getParameter("catalog"));
	String tonandmeter = CommonString.getFormatPara(request.getParameter("tonandmeter"));
	String factory = CommonString.getFormatPara(request.getParameter("factory"));

%>

<%if(catalog.equals("101001")){%>
        <div class="order">
        	<div class="l"><span style="width:60px">合作伙伴：</span>
            <div class="label">
                <a href="index.jsp?catalog=101001" <%if(factory.equals("")){%>class="cur"<%}%> >不限</a>
                <a href="index.jsp?factory=174&catalog=101001" <%if(factory.equals("174")){%>class="cur"<%}%> >卡特彼勒</a>
                <a href="index.jsp?factory=133&catalog=101001" <%if(factory.equals("133")){%>class="cur"<%}%> >三一</a>
                <a href="index.jsp?factory=182&catalog=101001" <%if(factory.equals("182")){%>class="cur"<%}%> >小松</a>
                <a href="index.jsp?factory=184&catalog=101001" <%if(factory.equals("184")){%>class="cur"<%}%> >日立</a>
                <a href="index.jsp?factory=192&catalog=101001" <%if(factory.equals("192")){%>class="cur"<%}%> >斗山</a>
                <a href="index.jsp?factory=183&catalog=101001" <%if(factory.equals("183")){%>class="cur"<%}%> >神钢</a>
                <a href="index.jsp?factory=136&catalog=101001" <%if(factory.equals("136")){%>class="cur"<%}%> >柳工</a>
                <a href="index.jsp?factory=152&catalog=101001" <%if(factory.equals("152")){%>class="cur"<%}%> >山重建机</a>
                <a href="index.jsp?factory=137&catalog=101001" <%if(factory.equals("137")){%>class="cur"<%}%> >临工</a>
            </div>
            </div>
            <div class="l"><span style="width:60px">按类型：</span>
             <div class="label">
            <a href="index.jsp?catalog=101001<%=factory.equals("")?"":"&factory="+factory%>" <%if(tonandmeter.equals("")){%>class="cur"<%}%>>不限</a>
            <a href="index.jsp?catalog=101001&ton=big<%=factory.equals("")?"":"&factory="+factory%>" <%if(tonandmeter.equals("big")){%>class="cur"<%}%>>大挖</a>
            <a href="index.jsp?catalog=101001&ton=mid<%=factory.equals("")?"":"&factory="+factory%>" <%if(tonandmeter.equals("mid")){%>class="cur"<%}%>>中挖</a>
            <a href="index.jsp?catalog=101001&ton=small<%=factory.equals("")?"":"&factory="+factory%>" <%if(tonandmeter.equals("small")){%>class="cur"<%}%>>小挖</a>
            </div>
            </div>
        </div>
<%}else if(catalog.equals("101002")){%>
        <div class="order">
        	<div class="l"><span style="width:60px">合作伙伴：</span>
            <div class="label">
            <a href="index.jsp?catalog=101002"  <%if(factory.equals("")){%>class="cur"<%}%>>不限</a>
                    <a href="index.jsp?factory=174&catalog=101002" <%if(factory.equals("174")){%>class="cur"<%}%> >卡特彼勒</a>
                    <a href="index.jsp?factory=137&catalog=101002" <%if(factory.equals("137")){%>class="cur"<%}%> >临工</a>
                    <a href="index.jsp?factory=138&catalog=101002" <%if(factory.equals("138")){%>class="cur"<%}%> >山工</a>
                    <a href="index.jsp?factory=144&catalog=101002" <%if(factory.equals("144")){%>class="cur"<%}%> >山推</a>
                    <a href="index.jsp?factory=172&catalog=101002" <%if(factory.equals("172")){%>class="cur"<%}%> >晋工</a>
                    <a href="index.jsp?factory=157&catalog=101002" <%if(factory.equals("157")){%>class="cur"<%}%> >力士德</a>
                    <a href="index.jsp?factory=141&catalog=101002" <%if(factory.equals("141")){%>class="cur"<%}%> >福田雷沃</a>
                    <a href="index.jsp?factory=209&catalog=101002" <%if(factory.equals("209")){%>class="cur"<%}%> >徐工</a>
                    <a href="index.jsp?factory=135&catalog=101002" <%if(factory.equals("135")){%>class="cur"<%}%> >龙工</a>
            </div>
            </div>
        </div>
	<%}else if(catalog.equals("106001")){%>
        <div class="order">
        	<div class="l"><span style="width:60px">合作伙伴：</span>
            <div class="label">
            <a href="#" <%if(factory.equals("")){%>class="cur"<%}%>>不限</a>
                    <a href="index.jsp?factory=209&catalog=106001" <%if(factory.equals("209")){%>class="cur"<%}%> >徐工</a>
                    <a href="index.jsp?factory=133&catalog=106001" <%if(factory.equals("133")){%>class="cur"<%}%> >三一</a>
                    <a href="index.jsp?factory=136&catalog=106001" <%if(factory.equals("136")){%>class="cur"<%}%> >柳工</a>
                    <a href="index.jsp?factory=134&catalog=106001" <%if(factory.equals("134")){%>class="cur"<%}%>>中联重科</a>
                    <a href="index.jsp?factory=174&catalog=106001" <%if(factory.equals("174")){%>class="cur"<%}%>>卡特彼勒</a>
                    <a href="index.jsp?factory=175&catalog=106001" <%if(factory.equals("175")){%>class="cur"<%}%>>沃尔沃</a>
                    <a href="index.jsp?factory=135&catalog=106001" <%if(factory.equals("135")){%>class="cur"<%}%>>龙工</a>
                    <a href="index.jsp?factory=139&catalog=106001" <%if(factory.equals("139")){%>class="cur"<%}%>>厦工</a>
                    <a href="index.jsp?factory=137&catalog=106001" <%if(factory.equals("137")){%>class="cur"<%}%>>临工</a>
            </div>
            </div>
        </div>	
		<%}else if(catalog.equals("103")){%>
        <div class="order">
        	<div class="l"><span style="width:60px">合作伙伴：</span>
            <div class="label">
                    <a href="#" <%if(factory.equals("")){%>class="cur"<%}%>>不限</a>
                    <a href="index.jsp?factory=209&catalog=103" <%if(factory.equals("209")){%>class="cur"<%}%>>徐工</a>
                    <a href="index.jsp?factory=133&catalog=103" <%if(factory.equals("133")){%>class="cur"<%}%>>三一</a>
                    <a href="index.jsp?factory=136&catalog=103" <%if(factory.equals("136")){%>class="cur"<%}%>>柳工</a>
                    <a href="index.jsp?factory=134&catalog=103" <%if(factory.equals("134")){%>class="cur"<%}%>>中联重科</a>
                    <a href="index.jsp?factory=139&catalog=103" <%if(factory.equals("139")){%>class="cur"<%}%>>厦工</a>
                    <a href="index.jsp?factory=144&catalog=103" <%if(factory.equals("144")){%>class="cur"<%}%>>山推</a>
                    <a href="index.jsp?factory=172&catalog=103" <%if(factory.equals("172")){%>class="cur"<%}%>>晋工</a>
                    <a href="index.jsp?factory=179&catalog=103" <%if(factory.equals("179")){%>class="cur"<%}%>>利勃海尔</a>
                    <a href="index.jsp?factory=148&catalog=103" <%if(factory.equals("148")){%>class="cur"<%}%>>常林股份</a>
            </div>
            </div>
        </div>
		<%}else if(catalog.equals("113001")){%>
        <div class="order">
        	<div class="l"><span style="width:60px">合作伙伴：</span>
            <div class="label">
            <a href="#" <%if(factory.equals("")){%>class="cur"<%}%>>不限</a>
                    <a href="index.jsp?factory=192&catalog=113001" <%if(factory.equals("192")){%>class="cur"<%}%> >斗山</a>
                    <a href="index.jsp?factory=776&catalog=113001" <%if(factory.equals("776")){%>class="cur"<%}%>>连云港工兵</a>
                    <a href="index.jsp?factory=679&catalog=113001" <%if(factory.equals("679")){%>class="cur"<%}%>>军恒</a>
					<a href="index.jsp?factory=402&catalog=113001" <%if(factory.equals("402")){%>class="cur"<%}%>>艾迪</a>
					<a href="index.jsp?factory=401&catalog=113001" <%if(factory.equals("401")){%>class="cur"<%}%>>惊天液压</a>
					<a href="index.jsp?factory=419&catalog=113001" <%if(factory.equals("419")){%>class="cur"<%}%>>水山</a>
            </div>
            </div>
        </div>
<%}else{%>

<%}%>		