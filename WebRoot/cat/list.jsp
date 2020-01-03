<%@ page language="java" import="com.jerehnet.util.common.*,com.jerehnet.util.dbutil.PageBean,com.jerehnet.util.dbutil.DBHelper,com.jerehnet.util.common.CommonString,java.util.*" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="tags"%>
<%
	DBHelper dbHelper = DBHelper.getInstance() ;
	PageBean pageBean = new PageBean() ; 
	String offset = CommonString.getFormatPara(request.getParameter("offset"));
	String flag = CommonString.getFormatPara(request.getParameter("flag"));
	String classString1="";
	String classString2="";
	String classString3="";
	if(flag.equals("grab_1_19")){flag="grab_1_13";classString1="class='cur'"; }
	if(flag.equals("grab_20_30")){flag="grab_14_29";classString2="class='cur'";}
	if(flag.equals("grab_30_1")){flag="grab_29_1";classString3="class='cur'";}
	pageBean.setTableName("pro_products") ;
	pageBean.setFields(" factoryname,name,catalogname,catalogname_spe,img2,id,factoryid_sub,file_name,introduce ");
	String whereStr = " and is_show=1 and factoryid=174 and catalognum like '%101001%' ";
	if (flag!=null && !"".equals(flag)) {
		String[] parttonandmeters = flag.split("_");
		String firsttonandmeter = parttonandmeters[1];
		String sectonandmeter = parttonandmeters[2];
		if ("0".equals(parttonandmeters[2])) {
			whereStr += " and tonandmeter < " + firsttonandmeter;
		} else if ("1".equals(parttonandmeters[2])) {
			whereStr += " and tonandmeter >" + firsttonandmeter;
		} else if ("01".equals(parttonandmeters[2])) {
			whereStr += " and tonandmeter =" + firsttonandmeter;
		} else {
			whereStr += " and tonandmeter between " + firsttonandmeter + " and " + parttonandmeters[2];
		}
	}
	pageBean.setCondition(whereStr);
	pageBean.setOrderBy(" order_no desc,id desc");
	pageBean.setPageSize(6);
	Integer nowPage = 1;
	if (!"".equals(offset) && !"0".equals(offset)) {
		nowPage = Integer.parseInt(offset) / pageBean.getPageSize() + 1;
	}; // 当前页
	pageBean.setNowPage(nowPage);
	pageBean.setIsShowSql(true);
	List<Map> productsList = pageBean.getDatas();
	
	//TDK
	String title="卡特挖掘机产品大全_卡特挖掘机型号 - 铁臂商城卡特彼勒(Cat)专区";
	String keywords="卡特挖掘机型号,卡特挖掘机产品";
	String description="卡特彼勒挖掘机产品大全，包括卡特彼勒挖掘机所有型号产品，帮助您全面了解卡特彼勒挖掘机。";
	if (flag!=null && !"".equals(flag)) {
	    //小挖
	    if(flag.equals("grab_1_19")){
	       title="卡特小挖_卡特小型挖掘机价格_卡特小型挖掘机 –铁臂商城卡特彼勒(Cat)专区";
	       keywords="卡特小挖,卡特小型挖掘机,卡特小型挖掘机价格";
	       description="铁臂商城卡特彼勒(Cat)专区提供所有卡特小型挖掘机型号、产品资料、报价，帮助您全面了解卡特小型挖掘机，卡特小挖。";
	    }
		//中挖
	   	if(flag.equals("grab_20_30")){
	       title="卡特中型挖掘机_卡特中型挖掘机价格–铁臂商城卡特彼勒(Cat)专区";
	       keywords="卡特中型挖掘机, 卡特中型挖掘机价格";
	       description="铁臂商城卡特彼勒(Cat)专区提供所有卡特小型挖掘机型号、产品资料、报价，帮助您全面了解卡特小型挖掘机。";
	    }
		//大挖
	    if(flag.equals("grab_30_1")){
	        title="卡特大型挖掘机_卡特大型挖掘机价格–铁臂商城卡特彼勒(Cat)专区";
	        keywords="卡特大型挖掘机, 卡特大型挖掘机价格";
	        description="铁臂商城卡特彼勒专区提供所有卡特大型挖掘机型号、产品资料、报价，帮助您全面了解卡特大型挖掘机。";
	    }
	}
%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="author" content="design by www.21-sun.com" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<title><%=title%></title>
<meta name="Keywords" content="<%=keywords%>" />
<meta name="Description" content="<%=description%>" />
<link href="style/style.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="scripts/jquery.min.js"></script>
<!-- jbox -->
<script type="text/javascript" src="/scripts/jBox-v2.3/jquery.jBox-2.3.min.js"></script>
<script type="text/javascript" src="/scripts/jBox-v2.3/i18n/jquery.jBox-zh-CN.js"></script>
<link type="text/css" rel="stylesheet" href="/scripts/jBox-v2.3/Skins2/Blue/jbox.css" />
<script type="text/javascript" src="/scripts/sort.js"></script> 
<!--[if (IE 6)]>
<script src="scripts/iepng.js" type="text/javascript"></script>
<script type="text/javascript">
   EvPNG.fix('.png'); 
</script>
<![endif]-->
</head>
<body>

<!--top--begin-->
<jsp:include page="include/top.jsp" flush="true"></jsp:include>
<jsp:include page="include/nav.jsp" flush="true"></jsp:include>
<!--top--end-->

<div class="wrap_list">
  <div class="list_banner" <%if(flag.equals("grab_1_13")){%>style="background: url(images/2018/301.5.jpg) no-repeat;"<%}else if(flag.equals("grab_14_29")){%>style="background: url(images/2018/330.jpg) no-repeat;"<%}else{%>style="background: url(images/2018/336.jpg) no-repeat;"<%}%>>
  <div class="word">
   	<h3><%if(flag.equals("grab_1_13")){%>新一代CAT®301.5挖掘机<%}else if(flag.equals("grab_14_29")){%>新一代CAT®330挖掘机<%}else{%>新一代CAT®336挖掘机<%}%></h3>
        <p>以更低的油耗实现更高的性能<br />
          易于使用的技术功能、新型舒适驾驶室<br />
          操作简单，安全性更好<br />
          通过驾驶室内的监视器跟踪挖掘机的滤清器使用寿命和维护间隔。

</p>
      </div>
  </div>
  <div class="list_con clearfix">
    <div class="list_left l">
      <ul class="up">
      	<% if(flag.equals("grab_1_19")){	%>
      		<li class="cur"><a href="?flag=grab_1_19"><div><div style="float:left">Cat<sup>&reg;</sup></div><h1 style="float:left">小型挖掘机</h1></div></a></li>
      	<%	}else{	%>
      		<li <%=classString1%>><a  href="?flag=grab_1_19">Cat<sup>&reg;</sup>小型挖掘机</a></li>
      	<%	} %>
      	<% if(flag.equals("grab_20_30")){	%>
		    <li class="cur"><a href="?flag=grab_20_30"><div><div style="float:left">Cat<sup>&reg;</sup></div><h1 style="float:left">中型挖掘机</h1></div></a></li>
      	<%	}else{	%>
      		<li <%=classString2%>><a   href="?flag=grab_20_30">Cat<sup>&reg;</sup>中型挖掘机</a></li>
      	<%	} %>
      	<% if(flag.equals("grab_30_1")){	%>
		    <li class="cur"><a href="?flag=grab_30_1"><div><div style="float:left">Cat<sup>&reg;</sup></div><h1 style="float:left">大型挖掘机</h1></div></a></li>
      	<%	}else{	%>
      		<li <%=classString3%>><a   href="?flag=grab_30_1">Cat<sup>&reg;</sup>大型挖掘机</a></li>
      	<%	} %>
      </ul>
      <!--  
      <div class="down"> <a href="#">我要购机</a> <a href="#">我要询价</a> <a href="#">下载产品手册</a> <strong>查找经销商</strong>
        <select name="select" id="select">
          <option>请选择</option>
        </select>
        <select name="select" id="select">
          <option>请选择</option>
        </select>
        <input type="button" />
      </div>
      -->
    </div>
    <div class="list_right r">
      <ul>
       <%
        	if(null!=productsList && productsList.size()>0){
        		for(Map oneMap:productsList){
        			String id = CommonString.getFormatPara(oneMap.get("id"));
        			String file_name = CommonString.getFormatPara(oneMap.get("file_name"));
        			String img2 = CommonString.getFormatPara(oneMap.get("img2"));
        			String factoryname = CommonString.getFormatPara(oneMap.get("factoryname"));
        			String name = CommonString.getFormatPara(oneMap.get("name")).replace("^r","®");
        			String catalogname = CommonString.getFormatPara(oneMap.get("catalogname"));
        			String factoryid_sub = CommonString.getFormatPara(oneMap.get("factoryid_sub"));
        			String introduce = CommonString.getFormatPara(oneMap.get("introduce")).replace("^r","®");
        			introduce = CommonHtml.filterHTML(introduce);
        			if(introduce.length()>150){
        				introduce = introduce.substring(0,150)+"...";
        			}
       %>
        <li>
          <div class="img"><a href="detail.jsp?id=<%=id %>" target="_blank" title="<%=factoryname %><%=name %><%=catalogname %>"><img src="http://product.21-sun.com/uploadfiles/<%=img2 %>" style="width:210px; height:178px;" onerror="showImgDelay(this,'/uploadfiles/no_big.gif',2);" alt="<%=factoryname %><%=name %><%=catalogname %>" /></a></div>
          <div class="info l">
            <h3><a href="detail.jsp?id=<%=id %>" target="_blank" title="<%=factoryname %><%=name %><%=catalogname %>"><strong><%=factoryname %><%=name %><%=catalogname %></strong></a></h3>
            <div class="celll">
            	<%=introduce %>
            <!-- 
              <table cellspacing="0" cellpadding="0" border="0" style="width:500px">
                <tbody>
                  <tr>
                    <td width="70" style="vertical-align:super;">发动机机型:</td>
                    <td style="vertical-align:super;">Cat<sup>&reg;</sup>3054C</td>
                    <td style="width:20px;">&nbsp;</td>
                    <td style="vertical-align:super;width:50%" rowspan="4">减油耗不减效益</td>
                  </tr>
                  <tr>
                    <td style="vertical-align:super;">净功率: </td>
                    <td style="vertical-align:super;">67kw</td>
                  </tr>
                  <tr>
                    <td style="vertical-align:super;">铲斗容量:</td>
                    <td style="vertical-align:super;">0.65m<sup>3</sup></td>
                  </tr>
                  <tr>
                    <td style="vertical-align:super;">工作重量:</td>
                    <td style="vertical-align:super;">13400kg</td>
                  </tr>
                </tbody>
              </table>
               -->
            </div>
            <div class="link">
            	<a class="a1" style="margin-right:30px;" href="order.jsp?id=<%=id %>" target="_blank">我要询价</a>
                <a class="a1" href="detail.jsp?id=<%=id %>" target="_blank" title="<%=factoryname %><%=name %><%=catalogname %>">查看详情</a>
            </div>
          </div>
        </li>
        <%}} %>
      </ul>
      	<% if(pageBean.getPageCount()>1){ %>
        <div id="pagination" class="paging">
      	<tags:cat_page pageBean="<%=pageBean%>" />
    	</div>
    	<%} %>
    </div>
  </div>
  
	<!--foot--begin-->
	<jsp:include page="include/foot.jsp" flush="true"></jsp:include>
	<!--foot--end-->
	
</div>
<script type="text/javascript" src="scripts/comm.js"></script> 
<script type="text/javascript">
function nTabs(thisObj, Num) {
	if (thisObj.className == "active") return;
	var tabObj = thisObj.parentNode.id;
	var tabList = document.getElementById(tabObj).getElementsByTagName("li");
	for (i = 0; i < tabList.length; i++) {
		if (i == Num) {
			thisObj.className = "active";
			document.getElementById(tabObj + "_Content" + i).style.display = "block";
		} else {
			tabList[i].className = "normal";
			document.getElementById(tabObj + "_Content" + i).style.display = "none";
		}
	}
}
$(document).ready(function(e) {
    $('.TabTitle li').click(function(){
		$('html,body').stop(1,0).animate({scrollTop:$('.TabTitle').offset().top},500);
	})
});
</script>
<script>
    var ref = ''; 
    if (document.referrer.length > 0) { 
        ref = document.referrer; 
    } 
    try { 
       if (ref.length == 0 && opener.location.href.length > 0) { 
       ref = opener.location.href; 
        } 
    }catch (e) {}
   	jQuery.ajax({
    	type:'post',
    	url:'ajax.jsp',
    	data:{flag:'visitHistory',ref:ref} ,
    	success:function(msg){
    	}
    });
</script>
</body>
</html>