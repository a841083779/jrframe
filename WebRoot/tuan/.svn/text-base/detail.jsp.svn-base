<%@ page language="java" import="java.sql.Connection,com.jerehnet.webservice.*,org.json.*,java.util.*,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="tags"%>
<%@ taglib uri="/WEB-INF/classes/oscache.tld" prefix="cache"%>
<%
    String id = CommonString.getFormatPara(request.getParameter("id")) ;
    String sel_sql = " select img2,flag,factoryid,pro_factoryid,description,factorylogo,factoryname,pro_name,pro_cataname,pro_id,pro_ids from  pro_ymt_activity where id="+id ;	
	DBHelper dbHelper = DBHelper.getInstance();
	Connection connection = null;
	Map one = null ;
   	// 获得地区
	String ip  = Common.getIp(request);
	String jsonStr = Tools.getMyProvinceAndCity(ip);
	String city = "";
	String province = "";
	if(!CommonString.getFormatPara(jsonStr).equals("")){
		JSONObject obj = new JSONObject(jsonStr);
		if(null!=obj&&obj.length()>0){
			province = CommonString.getFormatPara(obj.getString("province"));
			city = CommonString.getFormatPara(obj.getString("city"));
		}
	}
	one = dbHelper.getMap(sel_sql);
	//活动方信息
	String img=""; 	String img2=""; String flag="";  String agentid="";   String factoryid=""; String content=""; String logo="";String pro_type="";
	String factoryname="";  String pro_name="";  String pro_cataname=""; String pro_id="";  String pro_ids="";String page_hot_flag="";
	String whereStr="";
	if(one!=null)
	{
	    img2 = CommonString.getFormatPara(one.get("img2")) ; 
		
		flag = CommonString.getFormatPara(one.get("flag")) ; 
		agentid = CommonString.getFormatPara(one.get("factoryid")) ;
		factoryid = CommonString.getFormatPara(one.get("pro_factoryid")) ;
        content = CommonString.getFormatPara(one.get("description")) ;
		//if(content.length()>120){content=content.substring(0,120)+"...";}
	    logo=CommonString.getFormatPara(one.get("factorylogo")) ;
		if(logo.indexOf("uploadfiles")==-1&&!logo.equals("")){logo="/uploadfiles/"+logo;}
		factoryname=CommonString.getFormatPara(one.get("factoryname")) ;
		pro_name=CommonString.getFormatPara(one.get("pro_name")) ;
		pro_cataname=CommonString.getFormatPara(one.get("pro_cataname")) ;
		pro_id=CommonString.getFormatPara(one.get("pro_id")) ;
		pro_ids=CommonString.getFormatPara(one.get("pro_ids"));
		page_hot_flag=CommonString.getFormatPara(one.get("page_hot_flag"));
		//单产品，多产品标志位
		pro_type=CommonString.getFormatPara(one.get("pro_type"));
		
	}
	//产品
	String sql=""; 
	sql = "select  * from pro_ymt_products where  catalogid='"+id+"' order by order_no desc";
	Map products =  dbHelper.getMap(sql);
	String product_id="";String para="";String factoryids="";String catalognums="";String img3="";String introduce="";
	if(products!=null){
	product_id=CommonString.getFormatPara(products.get("id"));
	factoryids=CommonString.getFormatPara(products.get("factoryid"));
	catalognums=CommonString.getFormatPara(products.get("catalognum"));
	img3=CommonString.getFormatPara(products.get(img3));
	introduce=CommonString.getFormatPara(products.get("introduce"));
	introduce=introduce.replaceAll("<\\s*img\\s+([^>]*)\\s*>","");
		introduce = introduce.replaceAll("&nbsp;","");
		introduce = introduce.replaceAll("<[^<|^>]+>","");
	}
	List<Map> productsList = null ;
	productsList = dbHelper.getMapList(sql) ;
	
	//产品询价
	String sqls=""; 
	sqls = "select  * from pro_products where  name='"+pro_name+"' ";
	Map productsed =  dbHelper.getMap(sqls);
	String products_id=CommonString.getFormatPara(productsed.get("id"));
	
	Map catalogMap = (Map) application.getAttribute("catalogMap");
	Map brandMap = (HashMap) application.getAttribute("brandMap");

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="author" content="design by www.21-sun.com" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<title><%=CommonString.getFormatPara(brandMap.get(factoryids))%><%=CommonString.getFormatPara(catalogMap.get(catalognums))%>产品优惠, <%=CommonString.getFormatPara(brandMap.get(factoryids))%><%=CommonString.getFormatPara(catalogMap.get(catalognums))%>产品促销活动, <%=CommonString.getFormatPara(brandMap.get(factoryids))%><%=CommonString.getFormatPara(catalogMap.get(catalognums))%>产品团购 - 优买团</title>
<meta name="keywords" content="<%=CommonString.getFormatPara(brandMap.get(factoryids))%><%=CommonString.getFormatPara(catalogMap.get(catalognums))%>产品优惠, <%=CommonString.getFormatPara(brandMap.get(factoryids))%><%=CommonString.getFormatPara(catalogMap.get(catalognums))%>产品促销活动, <%=CommonString.getFormatPara(brandMap.get(factoryids))%><%=CommonString.getFormatPara(catalogMap.get(catalognums))%>产品团购" />
<meta name="description" content="铁臂商城旗下优买团为您提供<%=CommonString.getFormatPara(brandMap.get(factoryids))%><%=CommonString.getFormatPara(catalogMap.get(catalognums))%>产品优惠促销, <%=CommonString.getFormatPara(brandMap.get(factoryids))%><%=CommonString.getFormatPara(catalogMap.get(catalognums))%>产品团购活动, <%=CommonString.getFormatPara(brandMap.get(factoryids))%><%=CommonString.getFormatPara(catalogMap.get(catalognums))%>产品团购最低价.找<%=CommonString.getFormatPara(brandMap.get(factoryids))%><%=CommonString.getFormatPara(catalogMap.get(catalognums))%>产品优惠促销活动就上优买团!" />
<link href="style/style.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="scripts/jquery.min.js"></script>
<script type="text/javascript" src="/scripts/jBox-v2.3/jquery.jBox-2.3.min.js"></script>
<script type="text/javascript" src="/scripts/jBox-v2.3/i18n/jquery.jBox-zh-CN.js"></script>
<link type="text/css" rel="stylesheet" href="/scripts/jBox-v2.3/Skins2/Blue/jbox.css" />
<script type="text/javascript" src="/scripts/scripts.js"></script>
<script type="text/javascript" src="/scripts/sort.js"></script>

<!--[if (IE 6)]>
<script src="scripts/iepng.js" type="text/javascript"></script>
<script type="text/javascript">
   EvPNG.fix('.ee'); 
</script>
<![endif]-->
</head>
<body style="background-color:#ededed;">
<jsp:include page="/tuan/top.jsp" flush="true"/>

<div class="content wrap mt20">

		<div class="innerbanner" style="background-color:#fff;">
    	<div class="img"><img src='http://product.21-sun.com/uploadfiles/<%=img2%>' width="500"  height="286" onerror="showImgDelay(this,'/uploadfiles/no_small.gif',2);"/></div>
    	<div class="intro">
        	<div class="logo">
			<%if(!logo.equals("")){%>
			<img src='http://product.21-sun.com/<%=logo%>' width="80"  height="30"  onerror="showImgDelay(this,'/uploadfiles/no_small.gif',2);"/>
			<%}%>
			</div>
            <h3><%=factoryname%><%=pro_name%><%=pro_cataname%></h3>
            <p><%=content%></p>
			<div class="order_tel">
            	<div class="l"><i></i><em>|</em>4006-521-526</div>
                <div class="r" onclick="showinquery('<%=products_id %>','')"></div>
            </div>
        </div>
    </div>
	
  <ul class="homelist" style="margin-top:5px;">
  
  	  	<%  
		    Map oneMap = null ;
			String imgSrc="";
			if(null!=productsList && productsList.size()>0){
				for(int i=0;i<productsList.size();i++){
					oneMap = (HashMap)productsList.get(i);
				    imgSrc=CommonString.getFormatPara(oneMap.get("zoomlion_hot_pic"));
					if(imgSrc.equals("")){imgSrc=CommonString.getFormatPara(oneMap.get("img2"));}
        %>
  
    	<li><a target="_blank" href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")) %>"><img src='http://product.21-sun.com/uploadfiles/<%=imgSrc %>' onerror="showImgDelay(this,'/uploadfiles/no_small.gif',2);"  width="314" height="210"/></a>
        	<div class="info">
            <h3><%=CommonString.getFormatPara(oneMap.get("factoryname")) %><%=CommonString.getFormatPara(oneMap.get("name")) %><%=CommonString.getFormatPara(oneMap.get("catalogname")) %></h3>
            <p>参考价格：
			<em>
			<%if(!CommonString.getFormatPara(oneMap.get("price_start")).equals("0")&&!CommonString.getFormatPara(oneMap.get("price_end")).equals("0")&&!CommonString.getFormatPara(oneMap.get("price_start")).equals("")&&!CommonString.getFormatPara(oneMap.get("price_end")).equals("")){%>
            <%=CommonString.getFormatPara(oneMap.get("price_start"))%>万<!--<%=CommonString.getFormatPara(oneMap.get("price_end"))%>万-->
			<%}else{%>
			面议
			<%}%>
			</em></p>
            <a class="order_btn" onclick="showinquery('<%=CommonString.getFormatPara(oneMap.get("page_hot_flag")) %>','')"></a>
          </div>
        </li>
		<%}}%>
    </ul>
    <div class="check">
    	<a href="/tuan/" class="checkmore"></a>
    </div>
</div>
<div class="bottom">
	<div class="wrap">
	<span class="l">中国工程机械商贸网 Copyright © 2000-2014 </span>	
    <div class="r">客服：9:00-21:00<em>|</em>4006-521-526</div>
    </div>
 </div>
  <script type="text/javascript" src="scripts/comm.js"></script> 
</body>
</html>
