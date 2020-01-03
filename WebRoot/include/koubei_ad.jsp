<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*,org.apache.commons.httpclient.*,org.apache.commons.httpclient.methods.*" errorPage="" %>
<%@ page session="false" %>
<%@page import="com.jerehnet.util.common.CommonString"%>
<style>
/*左侧*/
#ads02 { position:fixed; left:0px; top:310px; z-index:99999; width:42px; height:350px;}
* html #ads02 {position:absolute; left:expression(eval(document.documentElement.scrollLeft+document.documentElement.clientWidth-this.offsetWidth)-(parseInt(this.currentStyle.marginLeft,0)||0)-(parseInt(this.currentStyle.marginRight,0)||0)); top:expression(eval(document.documentElement.scrollTop)+100);}
#ads02.ads_hover { width:95px!important;}
/*对联广告结束*/
</style>
<!--对联广告-->
<div id="ads02" class="ads_hover">
<a href="http://product.21-sun.com/activity/tuku/" target="blank" style="display:block;"><img src="http://product.21-sun.com/images/tuku_activity.jpg" width="95" height="330" class="ads_big" /></a>
<img src="http://news.21-sun.com/images/close_x.gif" width="39" height="13" alt="关闭" title="关闭" onclick="document.getElementById('ads02').className='hide';" style="cursor:pointer; margin-top:1px; float:right;" />
</div>