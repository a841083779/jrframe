<%@page contentType="text/html;charset=utf-8" import="java.sql.*,java.util.*,jereh.system.*,java.text.*,jereh.database.*,jereh.user.*" errorPage=""%>
<%@ include file="sysconfig/config.jsp"%>
<%
ConnManager pool = (ConnManager)application.getAttribute("poolAPP");
	if(pool==null){
		pool = new ConnManager();
	}
	Connection conn = pool.getConnection();
	String sql="";
	ResultSet rs ; 
	try{
	String catalogName="",channelImg="",keywords="",description="",channelFlash="",title="";
	short channelFlag=1;
	sql="select catalog_name,channel_img,channel_flag,channel_flash,keywords,description,title from web_columns where web_no='"+web_no+"' and language_version='"+language_version+"' and catalog_no='index00'";
	rs=DataManager.executeQuery(conn,sql);
	if(rs!=null&&rs.next()){
		catalogName=rs.getString("catalog_name");
		channelImg=rs.getString("channel_img");
		keywords=rs.getString("keywords");
		description=rs.getString("description");
		title=rs.getString("title");
		channelFlag=rs.getShort("channel_flag");
		channelFlash=rs.getString("channel_flash");
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
</head>
<body>
<table border="0" cellpadding="0" cellspacing="0" width="950" height="470" align="center">
  <tr>
    <td valign="top"><jsp:include page="include/top1.jsp" flush="true"/>
      <table border="0" cellpadding="0" cellspacing="0" width="100%">
        <tr>
          <td>
          <%if(channelFlag==2){ %>
          <object classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=9,0,0,0" name="main" width="950" height="343" align="middle" id="main">
	<param name="allowScriptAccess" value="sameDomain" />
	<param name="allowFullScreen" value="false" />
	<param name="movie" value="<%=channelFlash%>" /><param name="quality" value="high" />
	<param name="wmode" value="transparent" /><param name="bgcolor" value="#ffffff" />	
	<embed src="<%=channelFlash%>" quality="high" wmode="transparent" bgcolor="#ffffff" width="950" height="343" name="main" align="middle" allowScriptAccess="sameDomain" allowFullScreen="false" type="application/x-shockwave-flash" pluginspage="http://www.macromedia.com/go/getflashplayer" />
	</object>
	<%}else{ %>
		<img border="0" src="<%=channelImg%>"/>
	<%} %>
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
	  	sql="select catalog_name,summary,image from web_infomation where web_no='"+web_no+"' and language_version='"+language_version+"' and catalog_no='aboutus00'";
		rs=DataManager.executeQuery(conn,sql);
		while(rs!=null&&rs.next()){
	  %>
      <table  border="0" cellpadding="0" cellspacing="0" style="border-left-width:1px; border-right-width:1px; border-top-width:1px; margin:10px 0 0 0;" height="35"  width="683">
        <tr width="6" height="30">
          <td style=" border-bottom: 1px solid #CCCCCC" width="11"><img border="0" src="images/top1.gif" width="11" height="30"/></td>
          <td class="ziti02" style=" border-bottom: 1px solid #CCCCCC" width="550"><div class="btzi"><a class="n3" href="about/"><%=rs.getString("catalog_name")%></a></div><div style="float:left; width:200px; font-weight:bold; font-size:12px; color:#004A9A">世界知名品牌机械零部件供应商</div></td>
          <td align="right" style=" border-bottom: 1px solid #CCCCCC;padding-right:10px;" class="more" ><a href="about/"> 更多</a></td>
        </tr>
      </table>
      <table border="0" cellpadding="0" cellspacing="0" width="640" style="margin-top:10px;margin-bottom:5px;margin-left:15px">
        <tr>
          <td style="margin-top:10px;margin-bottom:10px;" align="center"><img border="0" src="<%=rs.getString("image")%>" width="126" height="107"/></td>
          <td valign="top" width="485" style="padding-right:10px" ><a class="n5" href="about/"><%=rs.getString("summary")%></a></td>
        </tr>
      </table>
      <%}%>
      <table  border="0" cellpadding="0" cellspacing="0" style=" border-left-width:1px; border-right-width:1px; border-top-width:1px; margin:10px 0 0 0;" height="35"  width="683">
        <tr width="6" height="30">
          <td style=" border-bottom: 1px solid #CCCCCC" width="11"><img border="0" src="images/top1.gif" width="11" height="30"/></td>
          <td class="ziti02" style=" border-bottom: 1px solid #CCCCCC" width="550"><div class="btzi"><a class="n3" href="products/">产品展示</a></div></td>
		  <td align="right" style=" border-bottom: 1px solid #CCCCCC;padding-right:10px;" class="more"><a href="products/"> 更多</a></td>
        </tr>
      </table>
      
      <div id="tbmq">
  <table width="680" border="0" align="left" cellpadding="0" cellspacing="0" height="300">
    <tr> 
      <%
	  	sql="select top 15 name,small_pic,sort_no from web_products where web_no='"+web_no+"' and language_version='"+language_version+"' and catalog_no='products02' and is_show=1 order by is_permission desc,is_new desc,add_date desc,id";
		rs=DataManager.executeQuery(conn,sql);
		while(rs!=null&&rs.next()){
		%>
      <td>
      <div class="cpsize">
            <div class="cptp">
              <div class="cptpsize"><a href="products/?sortNo=<%=rs.getString("sort_no")%>" title="<%=rs.getString("name")%>"><img border="0" src="<%=rs.getString("small_pic")%>" width="107" height="90" alt="<%=rs.getString("name")%>"/></a></div>
            </div>
            <div class="cpname"> <a href="products/?sortNo=<%=rs.getString("sort_no")%>" class="n5" title="<%=rs.getString("name")%>"><%=rs.getString("name")%></a></div>
          </div></td>
     <%}%>      

    </tr>
    <tr>
       <%
	  	sql="select  name,small_pic,sort_no from web_products where web_no='"+web_no+"' and language_version='"+language_version+"' and catalog_no='products02' and is_show=1 and id not in(select top 15 id from web_products where web_no='"+web_no+"' and language_version='"+language_version+"' and catalog_no='products02' and is_show=1 order by is_permission desc,is_new desc,add_date desc,id) order by is_permission desc,is_new desc,add_date desc,id";
		rs=DataManager.executeQuery(conn,sql);
		while(rs!=null&&rs.next()){
		%> 
      <td><div class="cpsize">
            <div class="cptp">
              <div class="cptpsize"><a href="products/?sortNo=<%=rs.getString("sort_no")%>" title="<%=rs.getString("name")%>"><img border="0" src="<%=rs.getString("small_pic")%>" width="107" height="90" alt="<%=rs.getString("name")%>"/></a></div>
            </div>
            <div class="cpname"> <a href="products/?sortNo=<%=rs.getString("sort_no")%>" class="n5" title="<%=rs.getString("name")%>"><%=rs.getString("name")%></a></div>
          </div> </td>
       <%}%>      

    </tr>
  </table>
</div>
<script>
function MqObj(obj,width,height,speed,direct){
	obj.contWidth=obj.offsetWidth;// offsetWidth
	obj.stopscroll=false;
	obj.nowscroll=0;
	with(obj){
		scrollLeft=0;//
		innerHTML+=innerHTML;
		style.width=width;
		style.height=height;
		style.overflowX="hidden";//
		style.overflowY="visible";//
		noWrap=true;
		onmouseover=function(){stopscroll=true};
		onmouseout=function(){stopscroll=false};
	}
	eval("setInterval('doScroll("+obj.id+")',"+speed+")");
}
function doScroll(obj){
	if(obj.stopscroll==true) return;
	if(obj.nowscroll<obj.contWidth){ // 
	obj.scrollLeft=obj.nowscroll++;//scrollLeft
	}else{
	obj.scrollLeft=0;//scrollLeft
	obj.nowscroll=0;
	}
}
window.onload=function(){
	MqObj(tbmq,"680","300","10")
}
</script>

</div></td>
  </tr>
   <tr>
    <td width="256" valign="top" align="center">
    <select name="menu1" onChange="if(this.options[this.selectedIndex].value!=''){window.open(this.options[this.selectedIndex].value,'_blank');}" >
       <option value="" selected="selected">--友情链接--</option>
         <%
	    sql="select web_name,web_url from web_link where web_no='"+web_no+"' and language_version='"+language_version+"' and is_show='1' order by orderno";
		rs=DataManager.executeQuery(conn,sql);
		while(rs!=null&&rs.next()){
	    %>
	    <option value="<%=rs.getString("web_url") %>" ><%=rs.getString("web_name") %></option>
	    <%} %>
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
	finally{pool.freeConnection(conn);}	
%>