<%@page contentType="text/html;charset=utf-8" import="java.sql.*,java.util.*,jerehnet.jsp.database.*,java.text.SimpleDateFormat,com.jerehnet.util.dbutil.*,com.jerehnet.util.common.*,java.net.*"%>
<%
	PoolManager pool = new PoolManager();
	if (pool == null) {
		pool = new PoolManager();
	}
	Connection conn = null;
	List<Map> mtksy = null;//媒体视角
	List<Map> xwdt = null;//新闻动态
	List<Map> ztbd = null;//专题报道
	List<Map> videotype=null;//视频分类
	Map shipin=new HashMap();//视频中心
	String allnewsdates="";//所有新闻日期字符串
	try {
		conn = pool.getConnection();
		DBHelper dbHelper = DBHelper.getInstance();
		//查询所有新闻日期
		List<Map> newsdates = dbHelper.getMapList("select distinct start_date from jrcms_information where pub_state=1 and website_no='${channel.websiteNo}' and (channel_node='090611isam4pwfolgyem' or channel_node='090611phjbpznjk28sey' or channel_node='110120msazd58kczqitv') and start_date!='' order by start_date desc",conn);
		for(int i = 0;newsdates!=null && i<newsdates.size();i++){
			allnewsdates+=","+CommonDate.getFormatDate("yyyy-MM-dd",newsdates.get(i).get("start_date"));
		}
		//调取媒体视角
		mtksy = dbHelper.getMapList(" select id,title,start_date,link_other from jrcms_information where pub_state=1 and website_no='${channel.websiteNo}' and channel_node='09061137tpjqru4gmlbx' order by is_top desc,start_date desc,orderno,id desc limit 6",conn);
		//调取新闻动态
		xwdt = dbHelper.getMapList(" select id,title,start_date,link_other from jrcms_information where pub_state=1 and website_no='${channel.websiteNo}' and channel_node='090611isam4pwfolgyem' order by is_top desc,start_date desc,orderno,id desc limit 6",conn);
		//调取专题报道
		ztbd = dbHelper.getMapList("select no,id,title,pub_date,img2,link_other from jrcms_special where is_show=1 and flag=1 and website_no ='${channel.websiteNo}' order by pub_date desc,id desc limit 5",conn);
		videotype=dbHelper.getMapList("select name,keyv from jrcms_param where no='101004' and is_show=1 order by orderno,id limit 7",conn);
		List spTemp=null;
		for(int m=0;videotype!=null&&m<videotype.size();m++){
			spTemp=dbHelper.getMapList("select id,title,pub_date,img,content,resource from jrcms_video where is_show=1 and website_no='${channel.websiteNo}' and channel_node='131009mxjgn8ujbrb7oi' and type_flag like '%,"+CommonString.getFormatStr(videotype.get(m).get("keyv"))+",%' order by pub_date desc,id desc limit 4",conn);
			shipin.put(CommonString.getFormatStr(videotype.get(m).get("keyv")),spTemp);
			spTemp=null;
		}
	} catch (Exception e) {
		e.printStackTrace();
	} finally {
		pool.freeConnection(conn);
	}
%>
<#include "main.ftl">
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="author" content="design by www.21-sun.com" />
<@title otherTitle=""/>
<link href="/internet2013/style/style.css" rel="stylesheet" />
<script src="/internet2013/scripts/jq1.91.js" ></script>
<link rel="stylesheet" href="/internet2013/scripts/datepicker/jquery-ui.css"/>
<script src="/internet2013/scripts/datepicker/jquery-ui.js"></script>
<script src="/internet2013/scripts/main.js"></script>
<!--[if IE 6]>
<script src="/internet2013/scripts/iepng.js"></script>
<script>
   EvPNG.fix('s,i')
</script>
<![endif]-->
<!--[if IE 9]>
<style>
.ban_t,.i_foot_list p,.i_foot_list a:hover p{filter:none}
</style>
<![endif]-->
</head>
<body>
<@jspTop />
<div class="channelLine">
  <div class="wrap">
    <div class="posi"><@crumbs /></div>
  </div>
</div>
<div class="n_cont">
  <div class="wrap fix">
    <div class="Tit2 red plr25">${rootChannel.name}</div>
    <div class="newsLeft">
      <div class="Tit3 l">热点推荐</div>
      <a class="ico ico2_2" href="${websiteFolder.folderPath}/rss/" title="订阅"></a>
      <div class="hotRec" onselectstart="return false;">
	    <a id="newsTabLeft"></a>
		<a id="newsTabRight"></a>
        <div class="bd">
		  <#list relatedTop as info>
          <div id="myTab_Content${info_index}" class="video<#if info_index!=0> hide</#if>"><a href="<#if (info.moreUrl??&&info.moreUrl!=''&&info.moreUrl!='#')>${info.moreUrl}<#else>javascript:void(0)</#if>" title="${info.title}"><img src="${info.moreImg}" alt="${info.title}" width="578" height="325" /></a></div>
		  </#list>
        </div>
        <div class="hd">
          <ul id="myTab">
		  	<#list relatedTop as info>
            <li onclick="nTabs(this,${info_index});"<#if info_index==0> class="act"</#if>>
              <h2><a href="<#if (info.moreUrl??&&info.moreUrl!=''&&info.moreUrl!='#')>${info.moreUrl}<#else>javascript:void(0)</#if>" title="${info.title}">${info.title}</a></h2>
              <p><a href="<#if (info.moreUrl??&&info.moreUrl!=''&&info.moreUrl!='#')>${info.moreUrl}<#else>javascript:void(0)</#if>" title="${info.title}">${info.intro}</a></p>
            </li>
            </#list>
          </ul>
        </div>
      </div>
      <div class="impNews">
	    <#list relatedFoot as info>
        <div class="recNews"> <a href="<#if (info.moreUrl??&&info.moreUrl!=''&&info.moreUrl!='#')>${info.moreUrl}<#else>javascript:void(0)</#if>" title="${info.title}">
          <h2>${info.title}</h2>
          <p class="text">${info.intro}</p>
          </a> </div>
		  </#list>
      </div>
      <div class="newsList01">${channel.intro}</div>
    </div>
    <div class="newsRight">
      <div class="Tit3">新闻搜索</div>
      <form id="newssearchform" name="newssearchform" method="post" action="${websiteFolder.folderPath}/media/news.jsp">
      <div class="newsSearch">
        <div class="select">
          <select name="channelNo" id="channelNo">
            <option value="">所有新闻</option>
			<option value="090611isam4pwfolgyem">企业新闻</option>
			<option value="090611phjbpznjk28sey">产品新闻</option>
			<option value="110120msazd58kczqitv">服务新闻</option>
          </select>
        </div>
	   <div class="searchForm">
		  <input type="text" name="keywords" id="keywords" class="inp" />
		  <input type="submit" value=" " title="搜索" class="btn" />
	   </div>
       </div>
	   <input type="hidden" name="sdate" id="sdate"/>
	   <input type="hidden" name="edate" id="edate"/>
		</form>
      <div class="Calendar" id="datepicker"></div>
<script type="text/javascript">
function check(date){
	ok = $.datepicker.formatDate('yy-mm-dd', new Date(date));
	if('<%=allnewsdates%>'.indexOf(ok)!=-1){
		return [true, ''];  
	}else{
		return [false, '']; 
	}
}
$(function() {
	$( "#datepicker" ).datepicker({
		closeText: '关闭',
		prevText: '<上月',
		nextText: '下月>',
		currentText: '今天',
		monthNames: ['一月','二月','三月','四月','五月','六月',
		'七月','八月','九月','十月','十一月','十二月'],
		monthNamesShort: ['一','二','三','四','五','六',
		'七','八','九','十','十一','十二'],
		dayNames: ['星期日','星期一','星期二','星期三','星期四','星期五','星期六'],
		dayNamesShort: ['周日','周一','周二','周三','周四','周五','周六'],
		dayNamesMin: ['日','一','二','三','四','五','六'],
		weekHeader: '周',
		yearSuffix: '年',
		dateFormat:"yy-mm-dd",
		firstDay:1,
		beforeShowDay: check, 
		maxDate: new Date(),
		onSelect:function(dateText, ui){
			$("#sdate").val(dateText);$("#edate").val(dateText);
			$("#newssearchform").submit();
		}
	});
});
</script>
	  <div class="sub_block sub_rss">
               <div class="mt10 sub_order">
                     <div class="dib t2">新闻订阅</div>
                     <div class="dib actgrey"><a href="${websiteFolder.folderPath}/rss/" title="订阅">订阅</a></div>
                     <p class="p">通过三一新闻订阅，快速便捷地获取有关三一的最新消息。<img src="/internet2013/images/rsstip.gif" /></p>
                  </div>
                  <div class="mt10 sub_order">
                     <div class="dib t2">新闻线索征集</div>
                     <div class="dib actgrey"><a href="${websiteFolder.folderPath}/service/zaixiantougao.jsp">投稿</a></div>
                     <p class="p">我们关注行业最新产品下线、最新技术应用...</p>
                  </div>
      </div>
			   
		
      <div class="weibo">
        <div class="Tit3"><a href="http://weibo.com/sanygroup" target="_blank" title="官方微博">官方微博</a></div>
        <div class="c"><iframe class="share_self" src="http://widget.weibo.com/weiboshow/index.php?language=&amp;width=278&amp;height=320&amp;fansRow=2&amp;ptype=1&amp;speed=0&amp;skin=1&amp;isTitle=0&amp;noborder=0&amp;isWeibo=1&amp;isFans=0&amp;uid=2230416520&amp;verifier=b3a5339e&amp;dpc=1" frameborder="0" width="278" scrolling="no" height="320"></iframe></div>
      </div>
    </div>
    <div class="comWhitePart fix plr25 mb20">
      <h3 class="Tit3 l"><a href="${websiteFolder.folderPath}/media/special_list.jsp" title="专题报道">专题报道</a></h3>
	  <a href="${websiteFolder.folderPath}/rss/" title="订阅" class="l ico ico2_2" style="margin-top:16px; margin-left:10px;"></a>
      <a class="ico ico2_4" href="${websiteFolder.folderPath}/media/special_list.jsp" title="更多"></a>
      <div class="pic_list">
        <ul class="fix">
		  <%for(int i = 0;ztbd!=null && i<ztbd.size();i++){
		 	String infolink="";
			if(!(CommonString.getFormatStr(ztbd.get(i).get("link_other"))).equals("")){
				infolink = CommonString.getFormatStr(ztbd.get(i).get("link_other"));
			}else{
				infolink =CommonString.getFormatStr(ztbd.get(i).get("id"))+"_for_special_list_text.htm";
			}
		 %>
          <li class="imghover"><a href="<%=infolink%>" title="<%=CommonString.getFormatStr(ztbd.get(i).get("title"))%>"><img src="<%=CommonString.getFormatStr(ztbd.get(i).get("img2"))%>" alt="<%=CommonString.getFormatStr(ztbd.get(i).get("title"))%>" width="184" height="132" />
            <h3><%=CommonString.getFormatStr(ztbd.get(i).get("title"))%></h3>
            </a></li>
          <%}%>
        </ul>
      </div>
    </div>
    <div class="comWhitePart fix plr25 mb20">
      <div class="otherList l">
        <h3 class="Tit3 l"><a href="${websiteFolder.folderPath}/media/news.jsp" title="新闻动态">新闻动态</a></h3>
		<a class="l ico ico2_2" href="${websiteFolder.folderPath}/rss/" title="订阅"></a> <a class="ico ico2_4" href="${websiteFolder.folderPath}/media/news.jsp" title="更多"></a>
        <ul class="otherList_list">
		<%for(int i = 0;xwdt!=null && i<xwdt.size();i++){
		 	String infolink="";
			if(!(CommonString.getFormatStr(xwdt.get(i).get("link_other"))).equals("")){
				infolink = CommonString.getFormatStr(xwdt.get(i).get("link_other"));
			}else{
				infolink =CommonString.getFormatStr(xwdt.get(i).get("id"))+"_for_news_text.htm";
			}
		 %>
          <li><span class="time"><%=CommonDate.getFormatDate("yyyy-MM-dd",xwdt.get(i).get("start_date"))%></span>
            <h3><a href="<%=infolink%>" title="<%=CommonString.getFormatStr(xwdt.get(i).get("title"))%>"><%=CommonString.getFormatStr(xwdt.get(i).get("title"))%></a> </h3>
             </li>
         <%}%>
        </ul>
      </div>
      <div class="otherList r">
        <h3 class="Tit3 l"><a href="${websiteFolder.folderPath}/media/media.jsp" title="媒体视角">媒体视角</a></h3>
        <a href="${websiteFolder.folderPath}/rss/" title="订阅" class="l ico ico2_2"></a> <a class="ico ico2_4" href="${websiteFolder.folderPath}/media/media.jsp" title="更多"></a>
        <ul class="otherList_list">
		<%for(int i = 0;mtksy!=null && i<mtksy.size();i++){
		 	String infolink="";
			if(!(CommonString.getFormatStr(mtksy.get(i).get("link_other"))).equals("")){
				infolink = CommonString.getFormatStr(mtksy.get(i).get("link_other"));
			}else{
				infolink =CommonString.getFormatStr(mtksy.get(i).get("id"))+"_for_media_text.htm";
			}
		 %>
		 <li><span class="time"><%=CommonDate.getFormatDate("yyyy-MM-dd",mtksy.get(i).get("start_date"))%></span>
            <h3><a href="<%=infolink%>" title="<%=CommonString.getFormatStr(mtksy.get(i).get("title"))%>"><%=CommonString.getFormatStr(mtksy.get(i).get("title"))%></a> </h3>
             </li>
		<%}%>
        </ul>
      </div>
    </div>
    <div class="comWhitePart fix plr25 serviceVideo">
     <h3 class="Tit3 l"><a href="${websiteFolder.folderPath}/media/video.jsp" title="视频中心"><em class="ico ico6_3"></em>视频中心</a></h3>
      <a class="ico ico2_4" href="${websiteFolder.folderPath}/media/video.jsp" title="更多"></a>
	  <div class="fix">
			<ul class="l n_v_item">
			<%for(int m=0;videotype!=null&&m<videotype.size();m++){%>
			<li<%if(m==0){%> class="cur"<%}%>><%=CommonString.getFormatStr(videotype.get(m).get("name"))%><i class="cir"></i></li>
			<%}%>
            </ul>
			<%for(int m=0;videotype!=null&&m<videotype.size();m++){%>
            <ul class="l n_v_list">
			 <% List<Map> tempsp=(List<Map>)shipin.get(CommonString.getFormatStr(videotype.get(m).get("keyv")));
			  for(int i = 0;tempsp!=null && i<tempsp.size();i++){
				String infolink=CommonString.getFormatStr(tempsp.get(i).get("id"))+"_for_video_text.htm";
				if(i==0){
			 %>
              <li class="first"><a href="<%=infolink%>" title="<%=CommonString.getFormatStr(tempsp.get(i).get("title"))%>"><i class="playico"></i><img src="<%=CommonString.getFormatStr(tempsp.get(i).get("img"))%>" alt="<%=CommonString.getFormatStr(tempsp.get(i).get("title"))%>" width="400" height="300" /><div class="mask"><h4 class="t"><%=CommonString.getFormatStr(tempsp.get(i).get("title"))%></h4><p class="p"><%=CommonString.substringByte(CommonString.getFormatStr(tempsp.get(i).get("content")).replaceAll("<[^<|^>]+>",""),100,true)%>...</p></div></a></li>
			  <%}else{%>
			  <li>
               	<div class="pic">
                  	<a href="<%=infolink%>" title="<%=CommonString.getFormatStr(tempsp.get(i).get("title"))%>"><img src="<%=CommonString.getFormatStr(tempsp.get(i).get("img"))%>" alt="<%=CommonString.getFormatStr(tempsp.get(i).get("title"))%>" width="400" height="300" /><s></s></a>
                  </div>
                  <div class="detail">
                  	<h4 class="t"><b class="ico ico1_5"></b><%=CommonString.getFormatStr(tempsp.get(i).get("title"))%></h4>
                     <p class="p"><%=CommonString.substringByte(CommonString.getFormatStr(tempsp.get(i).get("content")).replaceAll("<[^<|^>]+>",""),100,true)%>...</p>
                     <div class="art_info mt10 fs mybdshare artbdshare">
            		  <div id="bdshare" class="bdshare_t bds_tools get-codes-bdshare"><span class="bds_more">分享</span></div>
                        <a href="javascript:favorite()" class="fav">加入收藏</a>
                        <a href="javascript:void(0)" onclick="downPdf(<%=CommonString.getFormatStr(tempsp.get(i).get("id"))%>,'jrcms_video',<%=CommonString.getFormatStr(tempsp.get(i).get("resource")).equals("")?false:true%>,'http://resource.sanygroup.com/down.jsp?filename=<%=CommonString.getFormatStr(tempsp.get(i).get("resource")).equals("")?"":CommonString.getFormatStr(tempsp.get(i).get("resource")).replace("http://resource.sanygroup.com","http://down.sanygroup.com")%>&amp;title=<%=URLEncoder.encode(CommonString.getFormatStr(tempsp.get(i).get("title")),"utf-8")%>')" class="downv">下载</a>
					 </div>
                  </div>
               </li>
			   <% }
			  }
			  %>
            </ul>
			<%}%>
         </div>
    </div>
  </div>
</div>
<@jspFoot />
<script src="/internet2013/scripts/comm.js"></script>
<#if (channel.num??&&channel.num?length>2)>
<script type="text/javascript">
setTopSelect(${channel.num[0..2]});
</script>
</#if>
<script type="text/javascript">
$(".searchBtn b,.searchBtn i").click(function(){
	$(".searchBtn .searchForm").show(200);
	$(".searchForm .inp").focus();
})
$(".searchForm .inp").blur(function(){
	$(".searchBtn .searchForm").hide(500);
});
/*tab*/
function nTabs(thisObj, Num) {
	if (thisObj.className == "act") return;
	var tabObj = thisObj.parentNode.id;
	var tabList = document.getElementById(tabObj).getElementsByTagName("li");
	for (i = 0; i < tabList.length; i++) {
		if (i == Num) {
			thisObj.className = "act";
			document.getElementById(tabObj + "_Content" + i).style.display = "block";
		} else {
			tabList[i].className = "";
			document.getElementById(tabObj + "_Content" + i).style.display = "none";
		}
	}
};
function nTabsA(thisObj, Num) {
	if (thisObj.className == "act") return;
	var tabObj = thisObj.parentNode.id;
	var tabList = document.getElementById(tabObj).getElementsByTagName("li");
	for (i = 0; i < tabList.length; i++) {
		if (i == Num) {
			thisObj.className = "act";
			document.getElementById(tabObj + "_ContentA" + i).style.display = "block";
		} else {
			tabList[i].className = "";
			document.getElementById(tabObj + "_ContentA" + i).style.display = "none";
		}
	}
}
$(".specialList li a").append("<em class='dot'></em>");
$(".otherList_list li.vd a").append("<em class='ico ico3_4'></em>");
</script>
<@rightfloat />
<@visiteCount />
</body>
</html>
