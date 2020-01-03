<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="com.jerehnet.util.common.CommonString"%>  
<%
	String factoryid = CommonString.getFormatPara(request.getParameter("factoy_id")) ;
	String catalog = CommonString.getFormatPara(request.getParameter("catalog")) ;
	String tonandmeter = CommonString.getFormatPara(request.getParameter("tonandmeter")) ;
	String order = CommonString.getFormatPara(request.getParameter("order")) ;
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>无标题文档</title>  
   
 <style type="text/css">
a:link,a:visited { color:#666666;}
a:hover { color:#ff6600;}
.STYLE1 {color: #FFFFFF}
.pllist { width:90%;  min-height:50px; height:auto!important; height:50px; overflow:visible; position:relative; padding-top:23px; 

border-bottom:#ccc 1px dotted; margin-right:1%; padding-left:8px;}
.pllist a.plfl { position:absolute; left:8px; height:40px; top:0px; margin:5px; font-size:14px; font-family:Verdana; font-weight:bold; color:#3355AC; float:none; padding:0px; width:auto; text-decoration:none;}
.pllist a { display:inline-block; margin:0px 5px; font-size:12px; line-height:20px; height:20px; overflow:hidden; float:none; padding:0px; width:auto; text-decoration:none;}
</style>
</head>
<body style="background-color:transparent;">
<div class="plmore"  style="padding-left:0px; width:650px;">    

<#list allCatalogNames as brandInfo>  
   <#list   brandInfo?keys as mykey> 
     <#list mykey?keys as cataNums>
          <div class="pllist">
            <a href="/photo/list.jsp?factoryid=<%=factoryid %>&catalogid=${cataNums}&tonandmeter=<%=tonandmeter %>&order=<%=order %>" class="plfl" target="_top"> ${mykey[cataNums]} </a> <br/>                
          <#list catalogsMap02 as subCatalog>
          <#list subCatalog?keys as subkey>
          <#if subkey==mykey[cataNums]>
            <#assign sub = subCatalog[subkey]>
            <#list sub?keys as subsub>
             <a href="/photo/list.jsp?factoryid=<%=factoryid %>&catalogid=${subsub }<%="".equals(tonandmeter)?"":"&tonandmeter="+tonandmeter+""%><%="".equals(order)?"\"":"&order="+order+"\"" %> target="_top"> ${sub[subsub]} </a>
            </#list>
            </#if>  
          </#list>               
          </#list>         
       </#list>
      </div>       
  </#list>  
</#list>
</div>
</body>
</html>