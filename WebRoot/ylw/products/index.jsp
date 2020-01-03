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
	String sortNo=request.getParameter("sortNo"); 
	String sortName="";
	if(sortNo==null){
		sortNo="";
	}
	String ymname="../products/";
	try{

	String catalogName="",channelImg="",keywords="",description="",channelFlash="",title="";
	short channelFlag=1;
	sql="select catalog_name,channel_img,channel_flag,channel_flash,keywords,description,title from web_columns where web_no='"+web_no+"' and language_version='"+language_version+"' and catalog_no='products00'";
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
	if(sortNo==null||sortNo.equals("")){
		sql="select top 1 sort_no,sort_name from web_category where web_no='"+web_no+"' and language_version='"+language_version+"' and catalog_no='products01'   and is_show='1' order by sort_no";
		Map model = dbHelper.getMap(sql);
		if(model!=null){
			sortNo=CommonString.getFormatPara(model.get("sort_no"));
			sortName=CommonString.getFormatPara(model.get("sort_name"));
		}
	}else if(sortNo!=null){
		sql="select top 1 sort_name from web_category where web_no='"+web_no+"' and language_version='"+language_version+"' and catalog_no='products01' and  sort_no='"+sortNo+"'  and is_show='1' ";
		Map model = dbHelper.getMap(sql);
		if(model!=null){
			sortName=CommonString.getFormatPara(model.get("sort_name"));
		}
	}
	boolean Null_flag=false;
	int rs_count=0;
	int pagesize=12;
	int currentNum=0;
	int pagecount=0;
	int currentpage=1;
	String parampage=request.getParameter("parampage");
	if(parampage!=null)
	{	if(!parampage.equals("")&&Integer.parseInt(parampage)!=0)
			currentpage=Integer.parseInt(parampage);
	}
	String countSQL="";
	String strSQL="";
	countSQL = "select  count(id) from web_products  where  web_no="+web_no+" and catalog_no='products02'  and sort_no='"+sortNo+"' and is_show=1 and language_version="+language_version;
	strSQL = "select top "+pagesize+"  *  from web_products  where web_no="+web_no+" and catalog_no='products02'  and sort_no='"+sortNo+"' and is_show=1 and language_version="+language_version+"  and id  not in (select top "+((currentpage-1)*pagesize)+" id  from web_products  where web_no="+web_no+" and catalog_no='products02'  and sort_no='"+sortNo+"' and is_show=1 and language_version="+language_version+"  order by  order_no,is_new desc,add_date desc,id ) order by  order_no,is_new desc,add_date desc,id ";
	rs_count=(Integer)dbHelper.getOne(countSQL);

	List<Map> list2 = dbHelper.getMapList(strSQL);

	pagecount=(int)Math.ceil((float)rs_count/(float)pagesize);
	if((currentpage<=0)||(currentpage>pagecount))
		 {currentpage=1;}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><%if(title!=null&&!title.equals("")) {%><%=title%>_<%}%><%if(sortName!=null&&!sortName.equals("")){%><%=sortName%>_<%}%><%=catalogName%>_<%=web_name%></title>
<link href="../style/style.css" rel="stylesheet" type="text/css" />
<%if(keywords!=null&&!keywords.equals("")) {%><meta name="keywords" content="<%=keywords%>" />
<%}if(description!=null&&!description.equals("")){%><meta name="description" content="<%=description%>" /><%} %>
<script type="text/javascript" src="../scripts/highslide/highslide.js"></script>
<link rel="stylesheet" type="text/css" href="../scripts/highslide/highslide.css" />
<script type="text/javascript"> 
	hs.graphicsDir = '../scripts/highslide/graphics/';
	hs.align = 'center';
	hs.transitions = ['expand', 'crossfade'];
	hs.outlineType = 'rounded-white';
	hs.wrapperClassName = 'controls-in-heading';
	hs.fadeInOut = true;
	//hs.dimmingOpacity = 0.75;
	// Add the controlbar
	if (hs.addSlideshow) hs.addSlideshow({
		//slideshowGroup: 'group1',
		interval: 5000,
		repeat: false,
		useControls: true,
		fixedControls: false,
		overlayOptions: {
			opacity: 1,
			position: 'top right',
			hideOnMouseOut: false
		}
	});
	//=====page_updown=======
function page_updown(my_flag,url){
  var i=document.theform.parampage.selectedIndex;
  if(my_flag==0)
  {if(document.theform.parampage!=null)
  	document.theform.parampage.selectedIndex=i-1;
   document.theform.action=url;
   document.theform.method="post";
   document.theform.submit();
   }
  if(my_flag==1)
  {if(document.theform.parampage!=null)
  	document.theform.parampage.selectedIndex=i+1;
   document.theform.action=url;
   document.theform.method="post";
   document.theform.submit();
   }
 }
function do_tz(form){
	form.submit();
}
</script>
</head>
<body>
<jsp:include page="../include/top1.jsp" flush="true"/>
<table border="0" cellpadding="0" cellspacing="0" width="950" height="436" align="center" class="bodbox">
  <tr>
    <td width="251" valign="top" style=" padding:10px 0 0 10px;">
   	   <jsp:include page="../include/left1.jsp" flush="true">
			<jsp:param name="sortNo" value="<%=sortNo %>"/>
		</jsp:include>
      <jsp:include page="../include/lxwm1.jsp" flush="true"/>
    </td>
      <td width="697" valign="top">
      <table border="0" cellpadding="0" cellspacing="0" width="645">
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
              <td align="right" style=" border-bottom: 1px solid #ccc;padding-right:10px;" class="n5" > <a href="../">首页</a><span lang="en-us">&gt; </span><a class="n5" href="../products/"><%=catalogName%></a><%if(sortName!=null&&!sortName.equals("")){%><span lang="en-us">&gt; </span><%=sortName%><%}%></td>
            </tr>
          </table>
          <div class="cp01">
          <%int i = 1;
		  if(list2!=null&&list2.size()>0){
			  for(Map mm:list2){
			%>
          <div class="nycpsize">
            <div class="cptp">
              <div class="cptpsize">
              <a href="<%=CommonString.getFormatPara(mm.get("small_pic"))%>" class="highslide" onclick="return hs.expand(this)" title="<%=CommonString.getFormatPara(mm.get("name"))%>">
              <img border="0" src="<%=CommonString.getFormatPara(mm.get("small_pic"))%>" width="107" height="90" alt="<%=CommonString.getFormatPara(mm.get("name"))%>"/>
              </a>
			  <div class="highslide-heading"><%=CommonString.getFormatPara("name")%></div>
			  <div class="highslide-caption"><%if(CommonString.getFormatPara(mm.get("summary"))!=null){%><%=CommonString.getFormatPara(mm.get("summary")).replace("<p>","").replace("</p>","")%><%} %></div>
              </div>
            </div>
            <div class="cpname"> <%=CommonString.getFormatPara(mm.get("name"))%></div>
          </div>
          <% 
			currentNum=i;
			 ++i;
			}
			}
		  %>
		  </div>
		  <%if(pagecount>1){%>
                  <form name="theform" method="post">
                      <table width="86%" border="0" cellpadding="0" cellspacing="0" style="text-align: center;margin-left:29px;padding-top:10px;" align="left">
                        <tr>
                          <td width="100%" bgcolor="#E5E5E5" height="32">&nbsp;&nbsp;&nbsp; <font color="#333333">总共〖<%=rs_count%>〗&nbsp;&nbsp;〖<%=currentpage%>〗/〖<%=pagecount%>〗<font color="#FF9933">
                            <% if(currentpage>1){ %>
                            <a class="n5" href="javascript:page_updown(0,'<%=ymname%>');">上一页</a>
                            <%}%>
                            <%if(currentpage<pagecount){ %>
                            <a class="n5" href="javascript:page_updown(1,'<%=ymname%>');">下一页</a>
                            <%}%>
                            </font>&nbsp;&nbsp;
                            <select name="parampage" id="parampage" onChange="javascript:do_tz(theform);">
                              <%for(int p=1;p<=pagecount;p++){%>
                              <option value="<%=p%>"<%if(parampage!=null&&parampage.equals(new Integer(p).toString()))out.println("selected");%>><%=p%></option>
                              <%}%>
                            </select>
                            </font></td>
                        </tr>
                      </table>
                    <input type="hidden" name="sortNo" value="<%=sortNo%>"/>
                  </form>
                  <%}%>
    </td>
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