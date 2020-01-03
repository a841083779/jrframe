﻿<%@ page language="java" import="com.jerehnet.util.dbutil.PageBean,com.jerehnet.util.common.CommonString,com.jerehnet.util.dbutil.DBHelper,java.util.*" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="tags"%>
<%
  	DBHelper dbHelper = DBHelper.getInstance() ;
	String catalog=CommonString.getFormatPara(request.getParameter("catalog")); 
	//产品列表
	String pro_sql = "select  id,name,file_name,img2,catalogname_spe,catalognum_spe,zoomlion_hot_pic,catalogname,manual from pro_products where factoryid=138 and is_show=1 and catalognum like '"+catalog+"%'  order by id desc" ;
	List<Map> newProductsList = null ;
	newProductsList = dbHelper.getMapList(pro_sql) ;
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="author" content="design by www.21-sun.com" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<title>卡特彼勒（青州）有限公司官方旗舰店</title>
<meta name="keywords" content="山工装载机,山工推土机，山工平地机，山工压路机，山工压实机，山工产品报价,山工产品,山工产品图片,山工产品介绍" />
<meta name="description" content="铁臂商城为您提供卡特彼勒（青州）介绍,卡特彼勒（青州）产品介绍,卡特彼勒（青州）产品报价,卡特彼勒（青州）产品图片,卡特彼勒（青州）产品展示等卡特彼勒（青州）产品信息，帮助您全面了解卡特彼勒（青州）" />
<link href="style/style.css" rel="stylesheet" type="text/css" />
<link href="style/flag_shop02.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="scripts/jquery.min.js"></script>
<script type="text/javascript" src="/scripts/jBox-v2.3/jquery.jBox-2.3.min.js"></script>
<script type="text/javascript" src="/scripts/jBox-v2.3/i18n/jquery.jBox-zh-CN.js"></script>
<script type="text/javascript" src="/scripts/sort.js"></script>
<link type="text/css" rel="stylesheet"	href="/scripts/jBox-v2.3/Skins2/Blue/jbox.css" />
<!--[if (IE 6)]>
<script src="scripts/iepng.js" type="text/javascript"></script>
<script type="text/javascript">
   EvPNG.fix('.ee'); 
</script>
<![endif]-->
</head>
<body>
<div class="sg_nav clearfix">
    	<div class=" wrap">
    	<h1><img src='images/logo.jpg' width="147" height="45"/></h1>
        <ul>
		<li><a href="/brandshop/cql/" >首页</a></li>
        <li><a href="/brandshop/cql/list.jsp?catalog=101002" target="_blank">装载机</a></li>
        <li><a href="/brandshop/cql/list.jsp?catalog=101003" target="_blank">推土机</a></li>
        <li><a href="/brandshop/cql/list.jsp?catalog=101005" target="_blank">平地机</a></li>
        <li><a href="/brandshop/cql/list.jsp?catalog=106001" target="_blank">压路机</a></li>
        <li><a href="/brandshop/cql/list.jsp?catalog=106003" target="_blank">压实机</a></li>
        <li><a href="/brandshop/cql/about.jsp" target="_blank">关于我们</a></li>
        </ul>
        </div>
    </div>
<div class="sg_banner"></div>
<div class="wrap con clearfix">
    	<div class="con1 l">
        	<h3 class="sg_tit"
			<%if(catalog.equals("101002")){%> style="background: url(images/t02.jpg) no-repeat center;"<%}%>
		    <%if(catalog.equals("101003")){%> style="background: url(images/t03.jpg) no-repeat center;"<%}%>
			<%if(catalog.equals("101005")){%> style="background: url(images/t04.jpg) no-repeat center;"<%}%>
			<%if(catalog.equals("106001")){%> style="background: url(images/t05.jpg) no-repeat center;"<%}%>
			<%if(catalog.equals("106003")){%> style="background: url(images/t08.jpg) no-repeat center;"<%}%>
			></h3>
           <ul class="ulist">
           		
	   <%
			if(null!=newProductsList && newProductsList.size()>0){
				Map oneMap = null ;
				for(int i=0;i<newProductsList.size();i++){
					oneMap = (HashMap)newProductsList.get(i);
		%>
		
		

				<li>
			     
                	<a href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")) %>" target="_blank">
			
					<img width="305" height="193"  src='http://product.21-sun.com/uploadfiles/<%=CommonString.getFormatPara(oneMap.get("img2")) %>' onerror="showImgDelay(this,'/uploadfiles/no_big.gif',2);"/>
                    </a>                 
				 <div class="intro">
                    	<h4>山工<%=CommonString.getFormatPara(oneMap.get("name")) %><%=CommonString.getFormatPara(oneMap.get("catalogname")) %></h4>
						  <%if(!CommonString.getFormatPara(oneMap.get("manual")).equals("")){%>
                        <a onclick="javascript:down('/uploadfiles/<%=CommonString.getFormatPara(oneMap.get("manual")) %>','<%=CommonString.getFormatPara(oneMap.get("name")) %>')" class="list_a1"></a>
								<%}else{%>
					<a onclick="ts();" class="list_a1"></a>
					<%}%>
                          <a class="list_a2" href="javascript:;" onclick="showinquery('<%=CommonString.getFormatPara(oneMap.get("id")) %>','');"></a>
                    </div>
                </li>
          <%
				}
			}
		%>	 

			
           </ul>
      </div>
      
    </div>
    <div class="side"><img src='images/code.jpg'/></div>
	<jsp:include page="/brandshop/include/foot.jsp" flush="true"></jsp:include>

</body>
<script>
function ts(){
  alert("暂无下载资料!");
}
</script>
<script type="text/javascript">
function down(obj,obj1){
    window.open("/brandshop/cql/down.jsp?filename="+encodeURI(obj)+"&title="+encodeURI(obj1));
}
</script>
<div style="display:none"><script type="text/javascript">var cnzz_protocol = (("https:" == document.location.protocol) ? " https://" : " http://");document.write(unescape("%3Cspan id='cnzz_stat_icon_5865198'%3E%3C/span%3E%3Cscript src='" + cnzz_protocol + "s22.cnzz.com/stat.php%3Fid%3D5865198' type='text/javascript'%3E%3C/script%3E"));</script></div> 
</html>