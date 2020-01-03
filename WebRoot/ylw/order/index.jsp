<%@ page language="java" import="java.util.*,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*,java.sql.*" pageEncoding="UTF-8"%>
<%@page import="java.net.URL"%>
<%@page import="java.net.HttpURLConnection"%>
<%@page import="java.net.URLEncoder"%>
<%
String web_no ="20056"; 
String web_name ="优立维国际机械有限公司";
 String web_name2 ="Copyright Uniwell International Machinery Co.,Limited. All Rights Reserved.";
 String web_count ="http://www.21-sun.com/count/counter.asp?uid=youliwei&amp;style=7";
 String web_site ="http://www.uniwellmachine.com";
 String language_version ="1";
%>
<%
Connection connection = null;
   	DBHelper dbHelper = DBHelper.getInstance();
	String sql="";
	ResultSet rs ; 
	try{
	String catalogName="",channelImg="",keywords="",description="",channelFlash="",title="";
	short channelFlag=1;
	sql="select catalog_name,channel_img,channel_flag,channel_flash,keywords,description,title from web_columns where web_no='"+web_no+"' and language_version='"+language_version+"' and catalog_no='products03'";
	List<Map> list = dbHelper.getMapList(sql);
	for(Map m:list){
		catalogName=CommonString.getFormatPara(m.get("catalog_name"));
		channelImg=CommonString.getFormatPara(m.get("channel_img"));
		title=CommonString.getFormatPara(m.get("title"));
		keywords=CommonString.getFormatPara(m.get("keywords"));
		description=CommonString.getFormatPara(m.get("description"));
		channelFlag=Short.parseShort(CommonString.getFormatPara(m.get("channel_flag")));
		channelFlash=CommonString.getFormatPara(m.get("channel_flash"));
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><%if(title!=null&&!title.equals("")) {%><%=title%>_<%}%><%=catalogName%>_<%=web_name%></title>
<link href="../style/style.css" rel="stylesheet" type="text/css" />
<%if(keywords!=null&&!keywords.equals("")) {%><meta name="keywords" content="<%=keywords%>" />
<%}if(description!=null&&!description.equals("")){%><meta name="description" content="<%=description%>" /><%} %>
</head>
<body>
<jsp:include page="../include/top1.jsp" flush="true"/>
<table border="0" cellpadding="0" cellspacing="0" width="950" height="436" align="center" class="bodbox">
  <tr>
    <td width="251" valign="top" style="padding:10px 0 0 10px;">
        <jsp:include page="../include/left1.jsp" flush="true"/>
       <jsp:include page="../include/lxwm1.jsp" flush="true"/>
      </td>
      
      <td width="697" valign="top" style="padding:10px 0 0 0;"><table border="0" cellpadding="0" cellspacing="0" width="645">
            <tr>
              <td>
				<%if(channelFlag==2){ %>
				          <object classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=9,0,0,0" name="main" width="690" height="200" align="middle" id="main">
					<param name="allowScriptAccess" value="sameDomain" />
					<param name="allowFullScreen" value="false" />
					<param name="movie" value="<%=channelFlash%>" /><param name="quality" value="high" />
					<param name="wmode" value="transparent" /><param name="bgcolor" value="#ffffff" />	
					<embed src="<%=channelFlash%>" quality="high" wmode="transparent" bgcolor="#ffffff" width="690" height="200" name="main" align="middle" allowScriptAccess="sameDomain" allowFullScreen="false" type="application/x-shockwave-flash" pluginspage="http://www.macromedia.com/go/getflashplayer" />
					</object>
<%}else{ %>
						 <img border="0" src="<%=channelImg %>" width="690" height="200"/>
					<%} %>
				</td>
            </tr>
          </table>
          <table border="0" cellpadding="0" cellspacing="0" width="690"  style="margin-top:10px;">
            <tr width="6" height="30">
              <td style=" border-bottom: 1px solid #ccc" width="11"><img border="0" src="../images/top1.gif" width="11" height="30"/></td>
              <td class="ziti02" style=" border-bottom: 1px solid #ccc" > <%=catalogName%></td>
              <td align="right" style=" border-bottom: 1px solid #ccc;padding-right:10px;" class="n5" > <a href="../">首页</a>&gt;<%=catalogName%></td>
            </tr>
          </table>
          <table border="0" cellpadding="0" cellspacing="0" width="630"  style="margin-top:10px; margin-left:25px">
            <tr>
              <td><table width="100%" height="43" border="0" cellpadding="0" cellspacing="0" class="p92" id="table1">
                <tr>
                  <td width="99%" height="10" align="left" valign="middle" style="color: #333333; font-family: Verdana, Arial, 宋体; font-size: 9pt; line-height: 150%"><font color="#4d4d4d"> 　　如果您想购买我们的产品或有任何疑问，请您详细填写以下联系方式，我们会尽快与您联系。</font></td>
                </tr>
              </table>
                <iframe src="fed.jsp"  width="100%"  height="370"  frameborder=No border=0 marginwidth=0 marginheight=0 scrolling=No align="center"></iframe></td>
            </tr>
          </table></td>
      </tr>
    </table>
<jsp:include page="../include/foot1.jsp" flush="true"/>
</body>
</html>
<%
	}catch(Exception e){
		e.printStackTrace();
	}
	finally{
		DBHelper.freeConnection(connection);
	}	
%>