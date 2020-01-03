<%@ page language="java" import="java.sql.Connection,java.util.*,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*" pageEncoding="UTF-8"%><%@ taglib tagdir="/WEB-INF/tags" prefix="tags" %><%@ taglib uri="/WEB-INF/classes/oscache.tld" prefix="cache"%><%	
		String catalog = CommonString.getFormatPara(request.getParameter("catalog"));
		String factoryid = CommonString.getFormatPara(request.getParameter("factoryid"));
		String province = CommonString.getFormatPara(request.getParameter("province"));
		String city = CommonString.getFormatPara(request.getParameter("city"));
        Map catalogMap = (Map) application.getAttribute("catalogMap");
	    Map brandMap = (Map) application.getAttribute("brandMap");
		String catalogName=CommonString.getFormatPara(catalogMap.get(catalog));
		String factoryName=CommonString.getFormatPara(brandMap.get(factoryid));
		if(catalog.equals("")){catalog="0";} if(factoryid.equals("")){factoryid="0";}
%>
<cache:cache cron="* * */1 * *">
    <div class="rp clearfix mb10 area">
      <div class="title">
        <h3><%=factoryName%><%=catalogName%>热门区域维修网点</h3>
      </div>
      <div class="content rList01">
        <ul class="list">	
            <li><a title="北京<%=factoryName%><%=catalogName%>维修网点" href="/beijing-0-<%=factoryid%>-<%=catalog%>.htm">北京</a></li>
			<li><a title="上海<%=factoryName%><%=catalogName%>维修网点" href="/shanghai-0-<%=factoryid%>-<%=catalog%>.htm">上海</a></li>
			<li><a title="天津<%=factoryName%><%=catalogName%>维修网点" href="/tianjin-0-<%=factoryid%>-<%=catalog%>.htm">天津</a></li>
			<li><a title="重庆<%=factoryName%><%=catalogName%>维修网点" href="/chongqing-0-<%=factoryid%>-<%=catalog%>.htm">重庆</a></li>
			<li><a title="石家庄<%=factoryName%><%=catalogName%>维修网点" href="/hebei-shijiazhuang-<%=factoryid%>-<%=catalog%>.htm">石家庄</a></li>
			<li><a title="太原<%=factoryName%><%=catalogName%>维修网点" href="/shanxi-taiyuan-<%=factoryid%>-<%=catalog%>.htm">太原</a></li>	
			<li><a title="沈阳<%=factoryName%><%=catalogName%>维修网点" href="/liaoning-shenyang-<%=factoryid%>-<%=catalog%>.htm">沈阳</a></li>
			<li><a title="长春<%=factoryName%><%=catalogName%>维修网点" href="/jilin-changchun-<%=factoryid%>-<%=catalog%>.htm">长春</a></li>
			<li><a title="哈尔滨<%=factoryName%><%=catalogName%>维修网点" href="/heilongjiang-haerbin-<%=factoryid%>-<%=catalog%>.htm">哈尔滨</a></li>
			<li><a title="南京<%=factoryName%><%=catalogName%>维修网点" href="/jiangsu-nanjing-<%=factoryid%>-<%=catalog%>.htm">南京</a></li>
			<li><a title="杭州<%=factoryName%><%=catalogName%>维修网点" href="/zhejiang-hangzhou-<%=factoryid%>-<%=catalog%>.htm">杭州</a></li>
			<li><a title="合肥<%=factoryName%><%=catalogName%>维修网点" href="/anhui-hefei-<%=factoryid%>-<%=catalog%>.htm">合肥</a></li>
			<li><a title="福州<%=factoryName%><%=catalogName%>维修网点" href="/fujian-fuzhou-<%=factoryid%>-<%=catalog%>.htm">福州</a></li>
			<li><a title="南昌<%=factoryName%><%=catalogName%>维修网点" href="/jiangxi-nanchang-<%=factoryid%>-<%=catalog%>.htm">南昌</a></li>
			<li><a title="济南<%=factoryName%><%=catalogName%>维修网点" href="/shandong-jinan-<%=factoryid%>-<%=catalog%>.htm">济南</a></li>
			<li><a title="郑州<%=factoryName%><%=catalogName%>维修网点" href="/henan-zhengzhou-<%=factoryid%>-<%=catalog%>.htm">郑州</a></li>
			<li><a title="武汉<%=factoryName%><%=catalogName%>维修网点" href="/hubei-wuhan-<%=factoryid%>-<%=catalog%>.htm">武汉</a></li>
			<li><a title="长沙<%=factoryName%><%=catalogName%>维修网点" href="/hunan-changsha-<%=factoryid%>-<%=catalog%>.htm">长沙</a></li>
			<li><a title="广州<%=factoryName%><%=catalogName%>维修网点" href="/guangdong-guangzhou-<%=factoryid%>-<%=catalog%>.htm">广州</a></li>
			
			<li><a title="海口<%=factoryName%><%=catalogName%>维修网点" href="/hainan-haikou-<%=factoryid%>-<%=catalog%>.htm">海口</a></li>
			<li><a title="成都<%=factoryName%><%=catalogName%>维修网点" href="/sichuan-chengdu-<%=factoryid%>-<%=catalog%>.htm">成都</a></li>
			<li><a title="贵阳<%=factoryName%><%=catalogName%>维修网点" href="/guzhou-guiyang-<%=factoryid%>-<%=catalog%>.htm">贵阳</a></li>
			<li><a title="昆明<%=factoryName%><%=catalogName%>维修网点" href="/yunnan-kunming-<%=factoryid%>-<%=catalog%>.htm">昆明</a></li>
			

			
			<li><a title="西安<%=factoryName%><%=catalogName%>维修网点" href="/shanx-xian-<%=factoryid%>-<%=catalog%>.htm">西安</a></li>


        </ul>
      </div>
    </div>
</cache:cache>
