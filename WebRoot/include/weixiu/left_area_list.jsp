<%@ page language="java" import="java.sql.Connection,java.util.*,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*" pageEncoding="UTF-8"%><%@ taglib tagdir="/WEB-INF/tags" prefix="tags" %><%@ taglib uri="/WEB-INF/classes/oscache.tld" prefix="cache"%><%	
		String catalog = CommonString.getFormatPara(request.getParameter("catalog"));
		String factoryid = CommonString.getFormatPara(request.getParameter("factoryid"));
        Map catalogMap = (Map) application.getAttribute("catalogMap");
	    Map brandMap = (Map) application.getAttribute("brandMap");
		String catalogName=CommonString.getFormatPara(catalogMap.get(catalog));
		String factoryName=CommonString.getFormatPara(brandMap.get(factoryid));
		if(catalog.equals("")){catalog="0";} if(factoryid.equals("")){factoryid="0";}
%>
<cache:cache cron="* * */1 * *">
    <div class="rp clearfix mb10 area">
      <div class="title">
        <h3><%=factoryName%><%=catalogName%>热门区域维修</h3>
      </div>
      <div class="content rList01">
        <ul class="list">	
            <li><a title="北京<%=factoryName%><%=catalogName%>维修" href="/<%=catalog%>-105500-<%=factoryid%>.htm">北京</a></li>
			<li><a title="上海<%=factoryName%><%=catalogName%>维修" href="/<%=catalog%>-105300-<%=factoryid%>.htm">上海</a></li>
			<li><a title="天津<%=factoryName%><%=catalogName%>维修" href="/<%=catalog%>-105690-<%=factoryid%>.htm">天津</a></li>
			<li><a title="重庆<%=factoryName%><%=catalogName%>维修" href="/<%=catalog%>-105880-<%=factoryid%>.htm">重庆</a></li>
			<li><a title="石家庄<%=factoryName%><%=catalogName%>维修" href="/<%=catalog%>-106410-<%=factoryid%>.htm">石家庄</a></li>
			<li><a title="太原<%=factoryName%><%=catalogName%>维修" href="/<%=catalog%>-108310-<%=factoryid%>.htm">太原</a></li>
			<li><a title="呼和浩特<%=factoryName%><%=catalogName%>维修" href="/<%=catalog%>-109710-<%=factoryid%>.htm">呼和浩特</a></li>
			<li><a title="沈阳<%=factoryName%><%=catalogName%>维修" href="/<%=catalog%>-120010-<%=factoryid%>.htm">沈阳</a></li>
			<li><a title="长春<%=factoryName%><%=catalogName%>维修" href="/<%=catalog%>-119010-<%=factoryid%>.htm">长春</a></li>
			<li><a title="哈尔滨<%=factoryName%><%=catalogName%>维修" href="/<%=catalog%>-122010-<%=factoryid%>.htm">哈尔滨</a></li>
			<li><a title="南京<%=factoryName%><%=catalogName%>维修" href="/<%=catalog%>-110910-<%=factoryid%>.htm">南京</a></li>
			<li><a title="杭州<%=factoryName%><%=catalogName%>维修" href="/<%=catalog%>-104210-<%=factoryid%>.htm">杭州</a></li>
			<li><a title="合肥<%=factoryName%><%=catalogName%>维修" href="/<%=catalog%>-102320-<%=factoryid%>.htm">合肥</a></li>
			<li><a title="福州<%=factoryName%><%=catalogName%>维修" href="/<%=catalog%>-142010-<%=factoryid%>.htm">福州</a></li>
			<li><a title="南昌<%=factoryName%><%=catalogName%>维修" href="/<%=catalog%>-103110-<%=factoryid%>.htm">南昌</a></li>
			<li><a title="济南<%=factoryName%><%=catalogName%>维修" href="/<%=catalog%>-101260-<%=factoryid%>.htm">济南</a></li>
			<li><a title="郑州<%=factoryName%><%=catalogName%>维修" href="/<%=catalog%>-130010-<%=factoryid%>.htm">郑州</a></li>
			<li><a title="武汉<%=factoryName%><%=catalogName%>维修" href="/<%=catalog%>-124010-<%=factoryid%>.htm">武汉</a></li>
			<li><a title="长沙<%=factoryName%><%=catalogName%>维修" href="/<%=catalog%>-126010-<%=factoryid%>.htm">长沙</a></li>
			<li><a title="广州<%=factoryName%><%=catalogName%>维修" href="/<%=catalog%>-128010-<%=factoryid%>.htm">广州</a></li>
			<li><a title="南宁<%=factoryName%><%=catalogName%>维修" href="/<%=catalog%>-113010-<%=factoryid%>.htm">南宁</a></li>
			<li><a title="海口<%=factoryName%><%=catalogName%>维修" href="/<%=catalog%>-141510-<%=factoryid%>.htm">海口</a></li>
			<li><a title="成都<%=factoryName%><%=catalogName%>维修" href="/<%=catalog%>-139010-<%=factoryid%>.htm">成都</a></li>
			<li><a title="贵阳<%=factoryName%><%=catalogName%>维修" href="/<%=catalog%>-132010-<%=factoryid%>.htm">贵阳</a></li>
			<li><a title="昆明<%=factoryName%><%=catalogName%>维修" href="/<%=catalog%>-137010-<%=factoryid%>.htm">昆明</a></li>
			<li><a title="拉萨<%=factoryName%><%=catalogName%>维修" href="/<%=catalog%>-115010-<%=factoryid%>.htm">拉萨</a></li>
			<li><a title="西安<%=factoryName%><%=catalogName%>维修" href="/<%=catalog%>-135510-<%=factoryid%>.htm">西安</a></li>
			<li><a title="兰州<%=factoryName%><%=catalogName%>维修" href="/<%=catalog%>-134010-<%=factoryid%>.htm">兰州</a></li>
			<li><a title="西宁<%=factoryName%><%=catalogName%>维修" href="/<%=catalog%>-133010-<%=factoryid%>.htm">西宁</a></li>
			<li><a title="银川<%=factoryName%><%=catalogName%>维修" href="/<%=catalog%>-116010-<%=factoryid%>.htm">银川</a></li>
			<li><a title="乌鲁木齐<%=factoryName%><%=catalogName%>维修" href="/<%=catalog%>-117010-<%=factoryid%>.htm">乌鲁木齐</a></li>
        </ul>
      </div>
    </div>
</cache:cache>
