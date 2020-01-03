<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%><%@ page session="false"%><%@page import="com.jerehnet.util.common.CommonString"%><%@page import="com.jerehnet.util.dbutil.DBHelper"%>
<%@page import="com.jerehnet.util.common.Common"%><%@ taglib uri="/WEB-INF/classes/oscache.tld" prefix="cache"%><%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%><%
	String factoryid = CommonString.getFormatPara(request.getParameter("factoryid")) ; // 品牌id
	String catalog = CommonString.getFormatPara(request.getParameter("catalog")) ; // 品牌id
	Map pro_customer_brand_view_countMap = null ;
    if(!"".equals(factoryid)){
    	pro_customer_brand_view_countMap = new HashMap() ;
    	pro_customer_brand_view_countMap.put("flag","pro_customer_brand_view_countMap") ;
    	pro_customer_brand_view_countMap.put("factoryid",factoryid) ;
    	Common.doPostHttpAsync("http://product.21-sun.com/tools/ajax.jsp",pro_customer_brand_view_countMap) ;
    }
	DBHelper dbHelper = DBHelper.getInstance() ;
	String total = "0" ;
	String factoryname = "" ;
	List<Map> ordersList = null ;
	Map infoMap = null ;
	String whereStr = " " ;
	String cacheKey = "order_"+factoryid;
%>
<cache:cache cron="* */2 * * *">
<%
	if(!"".equals(factoryid)){
		whereStr = "where factoryid = "+factoryid+" and product_name is not null and product_name != ''" ;
		if("749".equals(factoryid)){ // 洛阳东方红 ，只取河南和甘肃的订单
			 // whereStr += "and (province like '河南' or province like '甘肃')" ;
		  //   whereStr += " or ( factoryid ='1187' and product_name is not null and product_name != '')" ;
		}
		if("1187".equals(factoryid)){ //如果是东方红则取 洛阳东方红和东方红的订单
		//	whereStr += " or ( factoryid ='749' and product_name is not null and product_name != '')" ;
		}
		if(catalog!=null && !catalog.equals("")){
			whereStr += " and catanum like '"+catalog+"%'";
		}
		ordersList = dbHelper.getMapList(" select top 20 id,factoryname,cataname,name,mobile_phone,contact_tel,contact_address,product_name,add_date from pro_product_form  "+whereStr+" order by id desc ") ;
		infoMap = dbHelper.getMap(" select count(*) total, max(factoryname) factoryname from pro_product_form "+whereStr) ;
		if(null != infoMap && infoMap.size()>0){
			total = CommonString.getFormatPara(infoMap.get("total")) ;
			factoryname = CommonString.getFormatPara(infoMap.get("factoryname")) ;
		}
	}
    Map brandMap = (Map) application.getAttribute("brandMap");
    factoryname= CommonString.getFormatPara(brandMap.get(factoryid));
	if("1187".equals(factoryid)){
		factoryname = "东方红" ;
	}
	if("749".equals(factoryid)){
		factoryname = "洛阳东方红" ;
	}
	
	
%>
  <div class="li">
    <%
        	if(null != ordersList && ordersList.size()>0){
        		int i=1 ;
        		String showtel = "" ;
        		for(Map oneMap:ordersList){
        			showtel = "".equals(CommonString.getFormatPara(oneMap.get("mobile_phone")))?CommonString.getFormatPara(oneMap.get("contact_tel")):CommonString.getFormatPara(oneMap.get("mobile_phone")) ;
            		if(showtel.length()>7&&showtel.length()<=20){
            			showtel = showtel.substring(0,3)+"***"+showtel.substring(showtel.length()-3) ;
            		}else if(showtel.length()>3){
            			showtel = showtel.substring(0,4)+"***" ;
            		}else
            		{
            			showtel = showtel+"***" ;
            		}
        			%>
    <ul <%=i%2==0?"class='libg02'":"class='libg01'" %>>
      <li class="i1"><%=i %></li>
      <li class="i2"><a href="/inquiry/detail_for_<%=CommonString.getFormatPara(oneMap.get("id")) %>.htm" target="_blank" title="<%=factoryname %><%=CommonString.getFormatPara(oneMap.get("product_name")) %><%=CommonString.getFormatPara(oneMap.get("cataname")) %>"><%=factoryname %><%=CommonString.getFormatPara(oneMap.get("product_name")) %><%=CommonString.getFormatPara(oneMap.get("cataname")) %></a></li>
      <li class="i3"><%=(CommonString.getFormatPara(oneMap.get("name")).length()>0)?CommonString.getFormatPara(oneMap.get("name")).substring(0,1)+"***":"张**" %></li>
      <li class="i4"><%=showtel %></li>
      <li class="i5"><%=factoryname %></li>
      <li class="i6"><%="".equals(CommonString.getFormatPara(oneMap.get("contact_address")))?"-":CommonString.getFormatPara(oneMap.get("contact_address"))  %></li>
      <li class="i7"><%=(CommonString.getFormatPara(oneMap.get("add_date")).length()>15)?CommonString.getFormatPara(oneMap.get("add_date")).substring(0,16):CommonString.getFormatPara(oneMap.get("add_date")) %></li>
    </ul>
    <%
        			i++ ;
        		}
        	}
        %>
  </div>
<!--询价列表结束--> 
</cache:cache>