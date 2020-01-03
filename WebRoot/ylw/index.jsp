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
 	try{
	String catalogName="",channelImg="",keywords="",description="",channelFlash="",title="";
	String channelFlag="1";
	sql="select catalog_name,channel_img,channel_flag,channel_flash,keywords,description,title from web_columns where web_no='"+web_no+"' and language_version='"+language_version+"' and catalog_no='index00'";
	Map isB = dbHelper.getMap(sql);
	if(isB!=null){
		catalogName=CommonString.getFormatPara(isB.get("catalog_name"));
		channelImg=CommonString.getFormatPara(isB.get("channel_img"));
		keywords=CommonString.getFormatPara(isB.get("keywords"));
		description=CommonString.getFormatPara(isB.get("description"));
		title=CommonString.getFormatPara(isB.get("title"));
		channelFlag=CommonString.getFormatPara(isB.get("channel_flag"));
		channelFlash=CommonString.getFormatPara(isB.get("channel_flash"));
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><%if(title!=null&&!title.equals("")){%><%=title%><%}else{%><%=web_name%><%} %></title>
<link href="style/style.css" rel="stylesheet" type="text/css" />
<%if(keywords!=null&&!keywords.equals("")) {%><meta name="keywords" content="<%=keywords%>" />
<%}if(description!=null&&!description.equals("")){%><meta name="description" content="<%=description%>" /><%} %>
<script src="http://lib.sinaapp.com/js/jquery/1.9.0/jquery.min.js" type="text/javascript"></script>
</head>
<body>
<table border="0" cellpadding="0" cellspacing="0" width="950" height="470" align="center">
  <tr>
    <td valign="top"><jsp:include page="include/top1.jsp" flush="true"/>
      <table border="0" cellpadding="0" cellspacing="0" width="100%">
        <tr>
          <td>
		<img border="0" src="<%=channelImg%>"/>

          </td>
        </tr>
      </table>
	 </td>
  </tr>
</table>
<table border="0" cellpadding="0" cellspacing="0" width="950" align="center" class="bodbox">
  <tr>
    <td width="245" align="left" valign="top" style="padding:10px 0 0 10px;">
     <jsp:include page="include/left1.jsp" flush="true"/>
      <jsp:include page="include/lxwm1.jsp" flush="true"/>
    </td>
    <td width="693" valign="top">
      <%
	  
	   	List<Map> list1 = dbHelper.getMapList("select catalog_name,summary,image from web_infomation where web_no='"+web_no+"' and language_version='"+language_version+"' and catalog_no='aboutus00'") ;
 	       if(null !=list1 && list1.size()>0){
				for(Map oneMap:list1){
	  %>
      <table  border="0" cellpadding="0" cellspacing="0" style="border-left-width:1px; border-right-width:1px; border-top-width:1px; margin:10px 0 0 0;" height="35"  width="683">
        <tr width="6" height="30">
          <td style=" border-bottom: 1px solid #CCCCCC" width="11"><img border="0" src="images/top1.gif" width="11" height="30"/></td>
          <td class="ziti02" style=" border-bottom: 1px solid #CCCCCC" width="550"><div class="btzi"><a class="n3" href="about/"><%=CommonString.getFormatPara(oneMap.get("pic_small_link"))%></a></div><div style="float:left; width:200px; font-weight:bold; font-size:12px; color:#004A9A">世界知名品牌机械零部件供应商</div></td>
          <td align="right" style=" border-bottom: 1px solid #CCCCCC;padding-right:10px;" class="more" ><a href="about/"> 更多</a></td>
        </tr>
      </table>
      <table border="0" cellpadding="0" cellspacing="0" width="640" style="margin-top:10px;margin-bottom:5px;margin-left:15px">
        <tr>
          <td style="margin-top:10px;margin-bottom:10px;" align="center"><img border="0" src="<%=CommonString.getFormatPara(oneMap.get("image"))%>" width="126" height="107"/></td>
          <td valign="top" width="485" style="padding-right:10px"  class="n5"><a href="about/"><%=CommonString.getFormatPara(oneMap.get("summary"))%></a></td>
        </tr>
      </table>
	<%}}%>
      <table  border="0" cellpadding="0" cellspacing="0" style=" border-left-width:1px; border-right-width:1px; border-top-width:1px; margin:10px 0 0 0;" height="35"  width="683">
        <tr width="6" height="30">
          <td style=" border-bottom: 1px solid #CCCCCC" width="11"><img border="0" src="images/top1.gif" width="11" height="30"/></td>
          <td class="ziti02" style=" border-bottom: 1px solid #CCCCCC" width="550"><div class="btzi"><a class="n3" href="products/">产品展示</a></div></td>
		  <td align="right" style=" border-bottom: 1px solid #CCCCCC;padding-right:10px;" class="more"><a href="products/"> 更多</a></td>
        </tr>
      </table>
<div class="wrapper">
	<div id="con">
		<div class="roll">
			<ul>
 

      <%
	  
	   	List<Map> list2 = dbHelper.getMapList("select top 15 name,small_pic,sort_no from web_products where web_no='"+web_no+"' and language_version='"+language_version+"' and catalog_no='products02' and is_show=1 order by is_permission desc,is_new desc,add_date desc,id") ;
 	       if(null !=list2 && list2.size()>0){
				for(Map oneMap:list2){
	  %>		
				<li>
              <div class="cpsize">
            <div class="cptp">
              <div class="cptpsize"><a href="products/?sortNo=123" title="<%=CommonString.getFormatPara(oneMap.get("name"))%>"><img border="0" src="<%=CommonString.getFormatPara(oneMap.get("small_pic"))%>" width="107" height="90" alt=""/></a></div>
            </div>
            <div class="cpname">  <a href="products/?sortNo=123" class="n5" title="<%=CommonString.getFormatPara(oneMap.get("name"))%>"><%=CommonString.getFormatPara(oneMap.get("name"))%></a></div>
          </div>           
              </li>
	<%}}%>         
			</ul>
		</div>
	</div>
</div>
<div class="wrapper">
	<div id="con2">
		<div class="roll">
			<ul>
        <%
 
			
				   	List<Map> list3 = dbHelper.getMapList("select  name,small_pic,sort_no from web_products where web_no='"+web_no+"' and language_version='"+language_version+"' and catalog_no='products02' and is_show=1 and id not in(select top 15 id from web_products where web_no='"+web_no+"' and language_version='"+language_version+"' and catalog_no='products02' and is_show=1 order by is_permission desc,is_new desc,add_date desc,id) order by is_permission desc,is_new desc,add_date desc,id") ;
 	       if(null !=list3 && list3.size()>0){
				for(Map oneMap:list3){
			
		%> 
				<li> <div class="cpsize">
            <div class="cptp">
              <div class="cptpsize"><a href="products/?sortNo=123" title="123"><img border="0" src="<%=CommonString.getFormatPara(oneMap.get("small_pic"))%>" width="107" height="90" alt=""/></a></div>
            </div>
            <div class="cpname"> <a href="products/?sortNo=123" class="n5" title=""><%=CommonString.getFormatPara(oneMap.get("name"))%></a></div>
          </div></li>
		   <%}}%> 
			</ul>
		</div>
	</div>
</div> 
 
<script>
//连续滚动
$.fn.ConScroll=function(){
	var Con=$(this);
	var Ul=Con.find('ul');
	var Li=Ul.find('li');
	var BtnL=Con.find('.BtnL');
	var BtnR=Con.find('.BtnR');
	var Speed=3;
	var T;
	Ul.append(Ul.html());
	Ul.width(Li.length*2*(Li.width()));
	function goRoll(){
		T=setInterval(function(){
			Ul.css('left',parseInt(Ul.css('left'))-Speed+'px');
			if(parseInt(Ul.css('left'))<-parseInt(Ul.width())/2){
				Ul.css('left','0')
				}else if(parseInt(Ul.css('left'))>=0){
					Ul.css('left',-parseInt(Ul.width())/2)
					}
			},30);
		}
	Ul.mouseover(function() {clearInterval(T)});
	Ul.mouseout(function() {goRoll()});
	BtnL.mouseover(function() {Speed = -3});
	BtnR.mouseover(function() {Speed = 3});
	goRoll();
	}
</script>
<script>
$(function(){
	$('#con').ConScroll();
	$('#con2').ConScroll();
	})
</script> 
 
</div></td>
  </tr>
   <tr>
    <td width="256" valign="top" align="center">
    <select name="menu1" onChange="if(this.options[this.selectedIndex].value!=''){window.open(this.options[this.selectedIndex].value,'_blank');}" >
       <option value="" selected="selected">--友情链接--</option>
 
      </select>
    </td>
    <td width="693" valign="top">&nbsp;</td>
  </tr>
</table>
<jsp:include page="include/foot1.jsp" flush="true"/>
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