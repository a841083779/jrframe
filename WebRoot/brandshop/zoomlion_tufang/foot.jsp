<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
     <div class="w960px centered pt15">
          <div class="l"><img src="/images/sp_img01.gif" width="138" height="104" /></div>
          <div class="shop_weibo">
            <strong class="name">中联重科</strong>
            <span class="links"><a href="http://e.weibo.com/zoomlionbranding" target="_blank">http://e.weibo.com/zoomlionbranding</a><br /><em>复制链接了解更多最新资讯</em></span>
          </div>
          <div class="l"><img src="/images/sp_img03.gif" width="185" height="104" alt="收藏我们" title="收藏我们" onclick="addShop();return false;" style="cursor:pointer;" /></div>
          <div class="l"><img src="/images/sp_img04.gif" width="168" height="104" /></div>
        <div class="clear"></div>  
        </div>