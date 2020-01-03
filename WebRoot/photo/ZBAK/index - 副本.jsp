<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%><%@page import="com.jerehnet.util.dbutil.DBHelper"%><%@page import="com.jerehnet.util.common.CommonString"%><%@ taglib tagdir="/WEB-INF/tags" prefix="tags" %><%@ taglib uri="/WEB-INF/classes/oscache.tld" prefix="cache"%><%
	// 选出24张最新的图片。
	DBHelper dbHelper = DBHelper.getInstance() ;
%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>【工程机械图片大全|挖掘机图片|装载机图片】- 中国工程机械商贸网</title>
<meta name="keywords" content="工程机械图片,工程机械图库,工程机械图片大全" />
<meta name="description" content="挖掘机图片，装载机图片，国内工程机械图片量最丰富、图片清晰度最高的专业工程机械图片频道。" /> 
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="author" content="design by www.21-sun.com" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<link href="../style/style.css" rel="stylesheet" type="text/css" />
<link href="../style/friendly_link.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="/scripts/jquery-1.7.min.js"></script>
<script type="text/javascript" src="/scripts/scripts.js"></script>
<script type="text/javascript" src="/scripts/flash.js"></script>
</head>
<body>
<!--top-->
<jsp:include page="/include/top.jsp" flush="true"/>
<!--面包屑-->
<div class="contain980 mb10">
  <h3 class="breadCrumbs">您现在所在的位置：<a href="/">工程机械产品中心</a> &gt;&gt; 产品图库</h3>
</div>
<!--面包屑结束--> 
<!--广告-->
<div class="contain980 mb10"><script language="javascript" type="text/javascript">
writeflashhtml("_swf=/images/hy.swf", "_width=980", "_height=60" ,"_wmode=opaque");
</script></div>
<!--广告结束--> 
<!--main-->
<div class="contain980 mb10"> 
  <!--left-->
  <div class="w210 l"> 
    <!--热门品牌-->
    <div id="leftId"> </div>
    <!--热门品牌结束--> 
  </div>
  <!--left end--> 
  <%--<cache:cache cron="* */6 * * *">--%>
  <%
  	List<Map> products_pic = dbHelper.getMapList(" select top 24 id,img2,add_date,factoryname,catalogname,name from pro_products where img2 is not null and img2 != '' order by id desc ") ;
  %>
  <!--right-->
  <div class="w757 r">
    <div class="wfull l photoTop">
      <h3>产品图片</h3>
      <div class="photoSelect">
        <form name="theform" id="theform">
          <div class="selectContain" align="right">
            <select id="factoryid" name="factoryid" style="width:120px">
              <option selected="selected" value=""> 选择品牌 </option>
            </select>
            <select  id="catalogid" name="catalogid" disabled="disabled" style="width:160px">
              <option selected="selected" value=""> 选择机型　　 </option>
            </select>
            <!--<select style="position: absolute; left: -2000px;"  id="level_3" 	name="level_3" disabled="disabled">
                    <option selected="selected" value=""> 请选择机型 </option>
                  </select>-->
          </div>
        </form>
        <a href="javascript:void(0)" class="photbtn" onclick="submitYN();">查看图片</a> </div>
    </div>
    <script type="text/javascript">
		function submitYN(){
		  if(""==jQuery.trim(jQuery("#factory").val())){
		  	jQuery("#factory").removeAttr("name") ;
		  }
		 jQuery("#theform").attr("action","list.jsp") ;
        jQuery("#theform").submit() ;
		}
	</script> 
    <!--最新推荐-->
    <div class="modIndexFoc r mb10">
      <div class="FocTh"> <span class="mark">最新推荐</span>
        <div class="navi"></div>
      </div>
      <div class="demowrap">
        <div class="browsebg lBbrowsebg"></div>
        <a class="prev browse left"></a>
        <div class="scrollable" id="chained">
          <div class="items">
            <%
             if(null != products_pic && products_pic.size()>0){
            	 for(int i=0;i<7;i++){
            		 Map oneMap = (HashMap)products_pic.get(i) ;
            		 %>
            <div> <a href="detail_for_<%=CommonString.getFormatPara(oneMap.get("id")) %>.htm" target="_blank" title="<%=CommonString.getFormatPara(oneMap.get("factoryname")) %><%=CommonString.getFormatPara(oneMap.get("name")) %><%=CommonString.getFormatPara(oneMap.get("catalogname")) %>"> <img src="/uploadfiles/<%=CommonString.getFormatPara(oneMap.get("img2")) %>" width="480" height="360" alt="<%=CommonString.getFormatPara(oneMap.get("factoryname")) %><%=CommonString.getFormatPara(oneMap.get("name")) %><%=CommonString.getFormatPara(oneMap.get("catalogname")) %>"  onerror="showImgDelay(this,'/uploadfiles/no_big.gif',2);" /> </a>
              <p><a href="detail_for_<%=CommonString.getFormatPara(oneMap.get("id")) %>.htm" target="_blank" title="2012<%=CommonString.getFormatPara(oneMap.get("factoryname")) %><%=CommonString.getFormatPara(oneMap.get("name")) %><%=CommonString.getFormatPara(oneMap.get("catalogname")) %>高清实拍图赏">2012<%=CommonString.getFormatPara(oneMap.get("factoryname")) %><%=CommonString.getFormatPara(oneMap.get("name")) %><%=CommonString.getFormatPara(oneMap.get("catalogname")) %>高清实拍图赏</a></p>
            </div>
            <%
            	 }
             }
            %>
          </div>
        </div>
        <a class="next browse right"></a>
        <div class="browsebg rBbrowsebg"></div>
      </div>
    </div>
    <!--最新推荐结束-->
    <div class="w748 r border03">
      <div class="title12">
        <h3>最新更新图片</h3>
      </div>
      <ul class="list12">
        <%
       if(null != products_pic && products_pic.size()>0){
    	   for(Map oneMap:products_pic){
    		   %>
        <li>
          <div class="photo"><a href="detail_for_<%=CommonString.getFormatPara(oneMap.get("id")) %>.htm" target="_blank"><img src="/uploadfiles/<%=CommonString.getFormatPara(oneMap.get("img2")) %>" alt="<%=CommonString.getFormatPara(oneMap.get("factoryname")) %><%=CommonString.getFormatPara(oneMap.get("name")) %><%=CommonString.getFormatPara(oneMap.get("catalogname")) %>" title="<%=CommonString.getFormatPara(oneMap.get("factoryname")) %><%=CommonString.getFormatPara(oneMap.get("name")) %><%=CommonString.getFormatPara(oneMap.get("catalogname")) %>" width="135" height="100"  onerror="showImgDelay(this,'/uploadfiles/no_big.gif',2);" /></a></div>
          <h3><a href="detail_for_<%=CommonString.getFormatPara(oneMap.get("id")) %>.htm" target="_blank"><%=CommonString.getFormatPara(oneMap.get("factoryname")) %><%=CommonString.getFormatPara(oneMap.get("name")) %><%=CommonString.getFormatPara(oneMap.get("catalogname")) %></a></h3>
        </li>
        <%
    		   }
       }
      %>
      </ul>
    </div>
  </div>
  <!--right end-->
  <%--</cache:cache>--%>
  <div class="clear"></div>
</div>
<!--main end--> 
<!--foot-->
<jsp:include page="/include/index/friendlink.htm" flush="false"/>
<jsp:include page="/include/foot.jsp" flush="false"/>
<!--end of foot-->
<!--图片轮换-->
<script src="/scripts/jquery.tools.min.js" type="text/javascript"></script>
<script>
	//左侧
	jQuery.ajax({
		url:"/include/left.jsp",
		type:"post",
		data:{"flag":"product","factoryid":"","catalog":"","url":"/photo/list.jsp"},
		success:function(data){
			jQuery("#leftId").html(jQuery.trim(data));	
		}
	})

	jQuery(document).ready(function() {
		jQuery("#chained").scrollable({circular: true, mousewheel: false}).navigator().autoscroll({
		interval: 8000
		});
	});
</script>
<!--图片轮换-->
<script type="text/javascript" src="/scripts/choose_cascade_date.js"></script>
<script type="text/javascript" src="/scripts/sort.js"></script>
</body>
</html>