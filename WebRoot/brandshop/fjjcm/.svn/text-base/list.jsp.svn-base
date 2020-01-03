<%@ page language="java" import="com.jerehnet.util.dbutil.PageBean,com.jerehnet.util.common.CommonString,com.jerehnet.util.dbutil.DBHelper,java.util.*" pageEncoding="UTF-8"%>
<%
	DBHelper dbHelper = DBHelper.getInstance() ;
	List<Map> recommondProductsList = new ArrayList() ;
	String rec_sql = "select top 2 id,name,file_name,img2,catalogname_spe,catalognum_spe,zoomlion_hot_pic ,catalogname,factoryid from pro_products where factoryid=152 and is_show=1 and zoomlion_hot=11 and catalognum_spe='102' " ; 
	recommondProductsList = dbHelper.getMapList(rec_sql+"order by view_count desc") ;
	
    List<Map> ProductsList = new ArrayList() ;
	String sql = "select  id,name,file_name,img2,catalogname_spe,catalognum_spe,zoomlion_hot_pic ,catalogname,factoryid from pro_products where factoryid=152 and is_show=1  and catalognum_spe='102' " ; 
    ProductsList = dbHelper.getMapList(sql+"order by view_count desc") ;
  	Map oneMap = null ;
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="author" content="design by www.21-sun.com" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<title>山重建机_山重建机品牌专区 - 中国工程机械商贸网</title>
<meta name="keywords" content="山重建机,山重建机产品报价,山重建机产品,山重建机产品图片,山重建机产品介绍,山重建机介绍" />
<meta name="description" content="中国工程机械商贸网为您提供山重建机介绍,山重建机产品介绍,山重建机产品报价,山重建机产品图片,山重建机产品展示等山重建机产品信息，帮助您全面了解山重建机。" />
<link href="/style/style.css" rel="stylesheet" type="text/css" />
<link href="style/style.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="/scripts/jquery-1.7.min.js"></script>
<script type="text/javascript" src="/scripts/jBox-v2.3/jquery.jBox-2.3.min.js"></script>
<script type="text/javascript" src="/scripts/jBox-v2.3/i18n/jquery.jBox-zh-CN.js"></script>
<script type="text/javascript" src="/scripts/scripts.js"></script>
<script type="text/javascript" src="/scripts/sort.js"></script>
<link type="text/css" rel="stylesheet"	href="/scripts/jBox-v2.3/Skins2/Blue/jbox.css" />
<link href="http://product.21-sun.com/style/brandshop_top.css" rel="stylesheet" type="text/css" />
<!--[if (IE 6)]>
<script src="scripts/iepng.js" type="text/javascript"></script>
<script type="text/javascript">
   EvPNG.fix('.ee'); 
</script>
<![endif]-->
</head>
<body class="flag_shop">
<jsp:include page="/brandshop/include/top.jsp" flush="true"></jsp:include>

	<div class="gnav">
    <div class="wrap">
    	<ul>
        	<li><a href="/brandshop/fjjcm/">首页</a></li>
            <li><a href="/brandshop/fjjcm/list.jsp">产品</a></li>
            <li><a href="/brandshop/fjjcm/#intro">公司介绍</a></li>
            <li><a href="/brandshop/fjjcm/#contact">联系方式</a></li>
        </ul>
        </div>
    </div>
    <div class="gbanner"></div>
<div class="wrap clearfix">


    
  <div class="con2" id="pro">
    	<a href="/brandshop/fjjcm/list.jsp"><h3></h3></a>
        <ul class="picList">
        	
	     <%
			if(null!=ProductsList && ProductsList.size()>0){
				for(int i=0;i<=ProductsList.size()-1;i++){
					oneMap = (HashMap)ProductsList.get(i);
		%>
			<li><a target="_blank"  href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")) %>" title="山重建机<%=CommonString.getFormatPara(oneMap.get("name")) %><%=CommonString.getFormatPara(oneMap.get("catalogname")) %>"><img alt="山重建机<%=CommonString.getFormatPara(oneMap.get("name")) %><%=CommonString.getFormatPara(oneMap.get("catalogname")) %>" src='http://product.21-sun.com/uploadfiles/<%=CommonString.getFormatPara(oneMap.get("img2")) %>' width="277" height="194" onerror="showImgDelay(this,'/uploadfiles/no_small.gif',2);"/></a>
            <p>山重建机<%=CommonString.getFormatPara(oneMap.get("name")) %><%=CommonString.getFormatPara(oneMap.get("catalogname")) %></p>
            <a href="javascript:;" onclick="showinquery('<%=CommonString.getFormatPara(oneMap.get("id")) %>','152');" class="btn"></a>
            </li>
	    <%}}%>	
			
			

        </ul>
        <div class="bot"></div>
    </div>


</div>
<div class="bottombg">
<jsp:include page="/include/foot.jsp" flush="true"></jsp:include>
</div>
</body>
</html>