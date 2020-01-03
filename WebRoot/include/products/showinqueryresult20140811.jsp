<%@page contentType="text/html;charset=utf-8"%>
<%@page import="java.util.Calendar"%>
<%@page import="com.jerehnet.util.common.CommonString"%>
<%@page import="com.jerehnet.util.dbutil.DBHelper"%>
<%@page import="java.util.Map"%>
<%@page import="org.apache.commons.codec.binary.StringUtils"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.List"%>
<%@page import="com.jerehnet.util.business.OrderBusiness"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.net.URLDecoder"%>
<%
	String productid = CommonString.getFormatPara(request.getParameter("productid")) ;
		String rand = CommonString.getFormatPara(request.getParameter("rand")) ;

	String username = CommonString.getFormatPara(request.getParameter("name")) ;
	String telephone = CommonString.getFormatPara(request.getParameter("telephone")) ;
	String contact_address = CommonString.getFormatPara(request.getParameter("zd_contact_address")) ;
	contact_address = URLDecoder.decode(contact_address,"utf-8");
	String province = CommonString.getFormatPara(request.getParameter("province")) ;  // 省份
	province = URLDecoder.decode(province,"utf-8");
	String city = CommonString.getFormatPara(request.getParameter("city")) ;
	city = URLDecoder.decode(city,"utf-8");
	String buy_time = CommonString.getFormatPara(request.getParameter("buy_time")) ;  // 预计购买时间
	String ifgroup = CommonString.getFormatPara(request.getParameter("ifgroup")) ; // 公司或个人
	String company = CommonString.getFormatPara(request.getParameter("company")) ; // 公司名字
	String source = CommonString.getFormatPara(request.getParameter("source"));
	String uuids = "" ;
	for(int i=0;i<3;i++){
		uuids += CommonString.getUUID() +",";
	}
	Map catalogMap = (HashMap)application.getAttribute("catalogMap") ;
	DBHelper dbHelper = DBHelper.getInstance() ;
	Map oneproduct  = null ;
	Map buyproduct  = null ;
	if(!"".equals(productid)){
	 	 oneproduct = dbHelper.getMap(" select factoryid,factoryname,catalogname,name,file_name,tonandmeter,catalognum from pro_products where id='"+productid+"' ") ;
		 buyproduct= dbHelper.getMap(" select top 1 buy_type from pro_product_form where product_id='"+productid+"' order by add_date desc") ;
	}
	String buy_type = CommonString.getFormatPara(buyproduct.get("buy_type"));
	
;	if(null == oneproduct || oneproduct.size()==0){
		%>
<script type="text/javascript">
			    parent.window.jBox.close() ;
		</script>
<%
return ;
	}
	// 选出同类产品下的两个产品
	List<Map> otherProducts = null ;	
	String products_ids = "" ;
	String brandname = "" ;
	String tonandmeter = "" ;
	String factoryid="";
	String otherchosetj = " where pro1.is_show=1 " ;
	factoryid=CommonString.getFormatPara(oneproduct.get("factoryid")) ;
	brandname = CommonString.getFormatPara(oneproduct.get("factoryname")) ;
	tonandmeter = CommonString.getFormatPara(oneproduct.get("tonandmeter")) ;
	otherchosetj += " and pro1.factoryname<>'"+brandname+"' and pro1.catalognum like '%"+CommonString.getFormatPara(oneproduct.get("catalognum"))+"%' ";
	// 根据开通订单推荐的代理商，优先推荐出产品，(条件:先根据区域选择)
	otherProducts = OrderBusiness.getRecommendProducts(province,CommonString.getFormatPara(oneproduct.get("catalognum"))) ;//代理商管理中开通产品推荐合同，目前与营销宝冲突，该业务应该取消
	// 代理商营销宝中代理商推荐产品（高级版会员有此功能）
	if(!"".equals(tonandmeter) &&(null==otherProducts ||otherProducts.size()<3) && 1==2){
		String sql = "";
		sql += " SELECT TOP 3 a.factoryid,a.factoryname,a.catalognum,a.catalogname,a.name,a.file_name,";
		sql += " a.introduce,a.id productid,a.img2 ";
		sql += " FROM pro_products a ";
		sql += " WHERE id IN( ";
		sql += " SELECT pp.id ";
		sql += " FROM pro_agent_ad_position paap ";
		sql += " INNER JOIN pro_products pp ON pp.id = paap.product_id AND pp.catalognum LIKE '"+CommonString.getFormatPara(oneproduct.get("catalognum"))+"%' ";
		sql += " INNER JOIN pro_agent_factory paf ON paap.agent_id = paf.id AND paf.is_shop = 3 and paf.flag = 2 ";
		sql += " INNER JOIN pro_agent_factory_and_area pafaa ON pafaa.agent_id = paf.id ";
		sql += " INNER JOIN comm_area ca ON pafaa.area_id = ca.area_id AND ca.area_name LIKE '%"+city+"%' ";
		sql += " WHERE paap.position = 2 ";
		sql += " UNION ";
		sql += " SELECT pp.id ";
		sql += " FROM pro_agent_ad_position paap ";
		sql += " INNER JOIN pro_products pp ON pp.id = paap.product_id AND pp.catalognum LIKE '"+CommonString.getFormatPara(oneproduct.get("catalognum"))+"%' ";
		sql += " INNER JOIN pro_agent_factory paf ON paap.agent_id = paf.id AND paf.is_shop = 3 and paf.flag = 1 ";
		sql += " WHERE paap.position = 2 ";
		sql += " ) ";
		sql += " ORDER BY newid() ";
		otherProducts = dbHelper.getMapList(sql) ;
	}
	if(null == otherProducts){
		otherProducts = new ArrayList() ;
	}
	int otherProductsSize = otherProducts.size() ;
	List<Map> tempotherProducts = null ;
	if(!"".equals(tonandmeter) && otherProductsSize<3){//list长度小于两个推荐产品，吨位不为空，查询左右浮动5吨的产品（较精确）
		tempotherProducts = new ArrayList() ;
		String temptj = otherchosetj + "and pro1.tonandmeter between "+Float.parseFloat(tonandmeter) +" and "+(Float.parseFloat(tonandmeter)+5.0) ;
		tempotherProducts = dbHelper.getMapList("select top "+(3-otherProductsSize)+" pro1.id productid,pro2.factoryid,pro2.factoryname,pro2.catalognum,pro2.name,pro2.file_name,pro2.img2 from pro_products pro1 left join pro_products pro2 on pro1.id=pro2.id "+temptj+" order by newid()") ;
		otherProducts.addAll(tempotherProducts) ; // 联合两个 list 
	}
	otherProductsSize = otherProducts.size() ;
	if(null == otherProducts||otherProductsSize<3){//代理商管理中未开通产品推荐合同&&list长度小于两个推荐产品，查询不同品牌、同类别产品
		tempotherProducts = dbHelper.getMapList("select top "+(3-otherProductsSize)+" pro1.id productid,pro2.factoryid,pro2.factoryname,pro2.catalognum,pro2.name,pro2.file_name,pro2.img2 from pro_products pro1 left join pro_products pro2 on pro1.id=pro2.id "+otherchosetj+" order by newid()") ;
		otherProducts.addAll(tempotherProducts) ; // 联合两个 list 
	}
	otherProductsSize = otherProducts.size() ;  // 重新算出 list 长度
	if(null == otherProducts||otherProductsSize<3){//代理商管理中未开通产品推荐合同&&list长度小于两个推荐产品，查询同品牌随机产品
		tempotherProducts = dbHelper.getMapList(" select top "+(3-otherProductsSize)+" pro1.id productid,pro2.factoryid,pro2.factoryname,pro2.catalognum,pro2.name,pro2.file_name,pro2.img2 from pro_products pro1 left join pro_products pro2 on pro1.id=pro2.id  where 1=1 and pro1.factoryname='"+brandname+"' order by newid()") ;
		otherProducts.addAll(tempotherProducts) ; // 联合两个 list 
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>询价 - 工程机械产品大全 - 产品中心 - 中国工程机械商贸网</title>
<meta http-equiv="Content-Language" content="zh-cn"/>
<meta name="keywords" content="工程机械产品库,工程机械" />
<meta name="description" content="工程机械产品库，工程机械产品大全尽在中国工程机械商贸网产品中心" />
<link href="/style/style.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="/scripts/jquery-1.7.min.js"></script>
<script type="text/javascript" src="/scripts/jBox-v2.3/jquery.jBox-2.3.min.js"></script>
<link href="/scripts/jBox-v2.3/Skins2/Blue/jbox.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" src="/scripts/scripts.js"></script>
<%
	if(source!=null && !source.equals("")){
%>
<script type="text/javascript"> 
<!-- 
document.domain='21-sun.com'; 
--> 
</script>
<%}%>
<style type="text/css">
.xjList { width:280px; height:95px; float:left;}
.xjList .xjImg { width:140px; float:left;}
.xjList .xjInfo { width:140px; float:left; line-height:22px;}
</style>  
</head>
<body>
	    <%if(factoryid.equals("138")){%>
		  <div style="height:50px;"></div>
        <%}%> 
<table width="650" height="312" border="0" align="center" cellpadding="0" cellspacing="0" style="width:650px; margin:0px auto; clear:both;">
  <tr>
    <td valign="top"><div align="center">
        <table border="0" cellpadding="0" cellspacing="0" width="95%" style="margin-top:0px;">
          <tr>
            <td width="41"><img border="0" src="/images/success.gif"/></td>
            <td valign="top"><table border="0" cellpadding="0" cellspacing="0" width="100%" style="margin-top:20px;">
                <tr>
                  <td style="border-bottom: 1px solid #DEEEFE;font-size:22px; font-family:微软雅黑;font-weight:bold; line-height:30px; height:40px; text-align:left">您的询价信息已成功提交，我们将及时联系您进行报价！&nbsp;&nbsp;
				    <%if(factoryid.equals("138")){%>
				  <span><a style="border-bottom: 1px solid red;font-size:22px; font-family:微软雅黑;font-weight:bold; line-height:30px; height:40px;color:red " href="http://product.21-sun.com/brandshop/cql/" target="_blank">山工</a>会第一时间和您联系!</span></td>
                    <%}%> 
                </tr>
                <tr>
                  <td style="padding-top:10px; text-align:left">
				  <%if(!factoryid.equals("138")){%>
				  询问了<a href="/proDetail/<%=CommonString.getFormatPara(oneproduct.get("file_name")) %>" target="_blank"><font color="#FF0000"><strong><%=CommonString.getFormatPara(oneproduct.get("factoryname")) %><%=CommonString.getFormatPara(oneproduct.get("name")) %><%=CommonString.getFormatPara(oneproduct.get("catalogname")) %> </strong></font></a>的网友还询问了以下类似产品：
                    <%}%>                   
				   <table border="0" cellpadding="0" cellspacing="0" width="567" style="margin-top:10px;">
                      <tr> </tr>
                    </table>
                    <table width="567" border="0" cellspacing="0" cellpadding="0">
                      <tr>
                        <td>
                        <%
							if(null != otherProducts && otherProducts.size()==3){//代理商管理中未开通产品推荐合同&&list长度小于两个推荐产品
							
								// 订单推荐调整
								// 因目前和中联重科合作产品中心订单信息，现需要请您协助将挖掘机、
								//推土机询价后出现的推荐产品设定为推荐中联重科的
								//挖掘机(按吨位推荐)和推土机(随机出现)，谢谢
								//过滤掉安徽和河南的
								Map recomMap = null ;
								if(CommonString.getFormatPara(oneproduct.get("catalognum")).indexOf("101001")!=-1 && !"".equals(oneproduct.get("tonandmeter"))&&!"安徽".equals(province)&&!"河南".equals(province)){ // 如果询价产品为挖掘机
									String sel_sql = " select top 1 img2,factoryid,factoryname,catalogname,name,file_name,tonandmeter,catalognum,id as productid from pro_products where 1=1 " ;
									String whereStr = " and factoryid=174 and catalognum like '"+CommonString.getFormatPara(oneproduct.get("catalognum"))+"%' " ;
									String tonandmeterStr = " and tonandmeter between "+(Float.parseFloat(CommonString.getFormatPara(oneproduct.get("tonandmeter")))-10)+" and "+(Float.parseFloat(CommonString.getFormatPara(oneproduct.get("tonandmeter")))+10) ;
									String orderBy = " order by newid()" ;
									recomMap = dbHelper.getMap(sel_sql+whereStr+tonandmeterStr+orderBy) ;
									if(null==recomMap){
										recomMap = dbHelper.getMap(sel_sql+whereStr+orderBy) ;
									}
									if(null!=recomMap){
										 otherProducts.remove(1) ; // 移除第二个推荐产品
										 otherProducts.add(1,recomMap) ;	
									}
								}
								
								// 订单推荐调整
								//推土机询价后出现的推荐产品设定为推荐中联重科的
								//挖掘机(按吨位推荐)和推土机(随机出现)，谢谢
								//单独处理安徽和河南的挖机显示三一的
								if(CommonString.getFormatPara(oneproduct.get("catalognum")).indexOf("101001")!=-1 && !"".equals(oneproduct.get("tonandmeter"))&&("安徽".equals(province)||"河南".equals(province))){ // 如果询价产品为挖掘机
									String sel_sql = " select top 1 img2,factoryid,factoryname,catalogname,name,file_name,tonandmeter,catalognum,id as productid from pro_products where 1=1 " ;
									String whereStr = " and factoryid=133 and catalognum like '"+CommonString.getFormatPara(oneproduct.get("catalognum"))+"%' " ;
									String tonandmeterStr = " and tonandmeter between "+(Float.parseFloat(CommonString.getFormatPara(oneproduct.get("tonandmeter")))-10)+" and "+(Float.parseFloat(CommonString.getFormatPara(oneproduct.get("tonandmeter")))+10) ;
									String orderBy = " order by newid()" ;
									recomMap = dbHelper.getMap(sel_sql+whereStr+tonandmeterStr+orderBy) ;
									if(null==recomMap){
										recomMap = dbHelper.getMap(sel_sql+whereStr+orderBy) ;
									}
									if(null!=recomMap){
										 otherProducts.remove(1) ; // 移除第二个推荐产品
										 otherProducts.add(1,recomMap) ;	
									}
								}
								// 推土机推荐（随机）
								if(CommonString.getFormatPara(oneproduct.get("catalognum")).indexOf("101003")!=-1){
									//卡特
									String sel_sql = " select top 1 img2,factoryid,factoryname,catalogname,name,file_name,tonandmeter,catalognum,id as productid from pro_products where 1=1 " ;
									String whereStr = " and factoryid=174 and catalognum like '"+CommonString.getFormatPara(oneproduct.get("catalognum"))+"%' " ;
									String orderBy = " order by newid()" ;
									recomMap = dbHelper.getMap(sel_sql+whereStr+orderBy) ;
									if(null==recomMap){
										recomMap = dbHelper.getMap(sel_sql+whereStr+orderBy) ;
									}
									if(null!=recomMap){
										 otherProducts.remove(1) ; // 移除第二个推荐产品
										 otherProducts.add(1,recomMap) ;	
									}
									//宣工
									String sel_sql2 = " select top 1 img2,factoryid,factoryname,catalogname,name,file_name,tonandmeter,catalognum,id as productid from pro_products where 1=1 " ;
									String whereStr2 = " and factoryid=154 and catalognum like '"+CommonString.getFormatPara(oneproduct.get("catalognum"))+"%' " ;
									String orderBy2 = " order by newid()" ;
									recomMap = dbHelper.getMap(sel_sql2+whereStr2+orderBy2) ;
									if(null==recomMap){
										recomMap = dbHelper.getMap(sel_sql2+whereStr2+orderBy2) ;
									}
									if(null!=recomMap){
										 otherProducts.remove(2) ; // 移除第三个推荐产品
										 otherProducts.add(2,recomMap) ;	
									}
								}
								// 请协助产品中心破碎锤订单成功后产品推荐，全国范围，谢谢
								//四川黑金刚工程机械有限责任公司 
								if(CommonString.getFormatPara(oneproduct.get("catalognum")).indexOf("113001")!=-1){
									String sel_sql = " select top 1 img2,factoryid,factoryname,catalogname,name,file_name,tonandmeter,catalognum,id as productid from pro_products where 1=1 " ;
									String whereStr = " and factoryid=1103 and catalognum like '113001%' " ;
									String orderBy = " order by newid()" ;
									recomMap = dbHelper.getMap(sel_sql+whereStr+orderBy) ;
									if(null==recomMap){
										recomMap = dbHelper.getMap(sel_sql+whereStr+orderBy) ;
									}
									if(null!=recomMap){
										 otherProducts.remove(0) ; // 移除第二个推荐产品
										 otherProducts.add(0,recomMap) ;	
									}
								}
    							// 产品中心装载机询价推荐常林、成工出现的频率太高了（貌似近80%都是他俩），
    							//这两个都和我们没有合作，可否换成推荐山工的，谢谢
    							// 备注：山工只有轮式装载机
								if(CommonString.getFormatPara(oneproduct.get("catalognum")).indexOf("101002")!=-1){
									String sel_sql = " select top 1 img2,factoryid,factoryname,catalogname,name,file_name,tonandmeter,catalognum,id as productid from pro_products where 1=1 " ;
									String whereStr = " and factoryid=138 and catalognum like '"+CommonString.getFormatPara(oneproduct.get("catalognum"))+"%' " ;
									String orderBy = " order by newid()" ;
									recomMap = dbHelper.getMap(sel_sql+whereStr+orderBy) ;
									if(null==recomMap){
										recomMap = dbHelper.getMap(sel_sql+whereStr+orderBy) ;
									}
									if(null!=recomMap){
										 otherProducts.remove(0) ; // 移除第一个推荐产品
										 otherProducts.add(0,recomMap) ;	
									}
								
								}
								
								//订单推荐调整
								//叉车询价后会推荐一个林德的产品
								if(CommonString.getFormatPara(oneproduct.get("catalognum")).indexOf("107")!=-1||CommonString.getFormatPara(oneproduct.get("catalognum")).equals("118004")){ // 如果询价产品为叉车
									String sel_sql = " select top 1 img2,factoryid,factoryname,catalogname,name,file_name,tonandmeter,catalognum,id as productid from pro_products where 1=1 " ;
									String whereStr = " and factoryid=1742 and catalognum like '"+CommonString.getFormatPara(oneproduct.get("catalognum"))+"%' " ;
									String orderBy = " order by newid()" ;
									recomMap = dbHelper.getMap(sel_sql+whereStr+orderBy) ;
									if(null==recomMap){
										recomMap = dbHelper.getMap(sel_sql+whereStr+orderBy) ;
									}
									if(null!=recomMap){
										 otherProducts.remove(0) ; // 移除第二个推荐产品
										 otherProducts.add(0,recomMap) ;	
									}
								}
							
								Map imgs = null ;
								if(!factoryid.equals("138")){
								for(Map oneMap:otherProducts){
							%>
                         <div class="xjList">
                           <div class="xjImg">
                           <a href="http://product.21-sun.com/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")) %>" target="_blank"><img border="0" src="/uploadfiles/<%=CommonString.getFormatPara(oneMap.get("img2"))%>"  width="130px" height="90px" onerror="showImgDelay(this,'/uploadfiles/no_small.gif',2);"/></a>
                           </div>
                           <div class="xjInfo">
                              品牌：<%=CommonString.getFormatPara(oneMap.get("factoryname")) %><br />
                                型号：<a href="http://product.21-sun.com/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")) %>" target="_blank"><strong><%=CommonString.getFormatPara(oneMap.get("name")) %></strong><br />
                                </a> 类别：<%=CommonString.getFormatPara(catalogMap.get(CommonString.getFormatPara(oneMap.get("catalognum")))).equals("")?CommonString.getFormatPara(oneproduct.get("catalogname")):CommonString.getFormatPara(catalogMap.get(CommonString.getFormatPara(oneMap.get("catalognum"))))  %><br/>
                                <%if(CommonString.getFormatPara(oneMap.get("factoryid")).equals("138") ){%>
								<input type="checkbox" value="<%=CommonString.getFormatPara(oneMap.get("productid")) %>" id="<%=CommonString.getFormatPara(oneMap.get("productid")) %>" />
                                <%}else{%>
							     <input type="checkbox" value="<%=CommonString.getFormatPara(oneMap.get("productid")) %>" id="<%=CommonString.getFormatPara(oneMap.get("productid")) %>" />
								<%}%>
							   <label for="<%=CommonString.getFormatPara(oneMap.get("productid")) %>" style="color:#900">&nbsp;&nbsp;请点击选择</label>
                           </div>
                         </div>   
                        <%}
						}else{
						%>
						<div>
						<span style="color:black;font-size:25px;font-weight:bold;font-family:微软雅黑;">山工销售热线：</span>
						<span style="color:red;font-size:33px;font-weight:bold;font-family:微软雅黑;">400-890-5858</span><br><br>
						<span style="color:#3F3F3F;font-size:17px;font-weight:normal;font-family:微软雅黑;">为了获得更好的咨询，请说明是从中国工程机械商贸网上看到的</span><br><br>
						</div>
						<%
						}
						
						}%>
						<%	if(!factoryid.equals("138")){%>
                        <div class="xjList">
                          <div class="xjImg" style="width:105px"><img src="/images/erweima.jpg" width="100" height="95" /></div>
                          <div class="xjInfo" style="font-size:12px; line-height:20px; padding-top:5px;">
                           铁臂商城手机版，<br />随时随地询价，<br />QQ群：250469589
                          </div>
                        </div>
						<%}%>
                        </td>
                      </tr>
                    </table></td>
                </tr>
              </table></td>
          </tr>
        </table>
      </div>
	    <%if(!factoryid.equals("138")){%>
      <div align="center" style="margin-top:10px; border-top:#DEEEFE 1px solid; padding-top:10px;">
        <table border="0" cellpadding="0" cellspacing="0" width="95%">
          <tr>
            <td align="right"><a href="javascript:;" onClick="inquery();"><img border="0" src="/images/agent_btn01.gif" onClick=""></img></a></td>
          </tr>
        </table>
      </div>
	  <%}%>
      <!--
      <div style="text-align:center; padding-top:8px;">
        <a href="http://product.21-sun.com/tuan/" target="_blank"><img src="/images/ad_tuan.gif" width="654" height="82" /></a>
      </div>
      -->
    </td>
  </tr>
</table>
<script type="text/javascript">
  function closethiswindow(){
  window.close() ;
  }
  <%
  	String heshi = CommonString.getFormatPara(request.getParameter("heshi"));
  	if("1".equals(heshi)){
  		%> jQuery.getJSON("http://used.21-sun.com/tools/import/insertOneInquiry.jsp?id=<%=request.getParameter("keyId") %>&callback=?");<%
  	}
  %>
 
  function inquery(){
   var products_ids ="";
   jQuery("input:checkbox:checked").each(function(){
    products_ids += jQuery(this).val() +","; 
   }) ;
   if(products_ids.length>0){
     products_ids = products_ids.substring(0,products_ids.length-1) ;
   }
   jQuery.post("/action/order_save.jsp",{
  	 	if_tag:"fourorders",
  	 	username:"<%=username%>",
  	 	telephone:"<%=telephone%>",
  	 	contact_address:"<%=contact_address%>",
  	 	pro_ids:products_ids,
  	 	contact_addr:"<%=contact_address%>",
  	 	uuids:"<%=uuids%>",
  	 	province:"<%=province%>",
  	 	city:"<%=city%>",
  	 	buy_time:"<%=buy_time%>",
  	 	ifgroup:"<%=ifgroup%>",
		buy_type:"<%=buy_type%>" ,
  	 	company:"<%=company%>" ,
		rand:"<%=rand%>"
  	 },function(msg){
  	 	 jQuery.post("/tools/email/order_email.jsp",{productids:"<%=products_ids%>",uuids:"<%=uuids%>"}) ; // 请求发送邮件页
  	 	 <%
  	 	 	if("1".equals(heshi)){
  	 	 		%>
  	 	 		var ids = jQuery.trim(msg);
  	 	var idArr = ids.split(",");
    	for(var i=0;i<idArr.length;i++){
    		jQuery.getJSON("http://used.21-sun.com/tools/import/insertOneInquiry.jsp?id="+idArr[i]+"&callback=?");
    	}<%
  	 	 	}
  	 	 %>
		 
  	 	parent.jQuery.jBox.tip("询价成功！") ;
		setTimeout("parent.window.jBox.close()",1000) ;
   });
   }
</script>
<div style="display:none">
<script type="text/javascript"> 
var cnzz_protocol = (("https:" == document.location.protocol) ? " https://" : " http://");document.write(unescape("%3Cspan id='cnzz_stat_icon_2697829'%3E%3C/span%3E%3Cscript src='" + cnzz_protocol + "s17.cnzz.com/stat.php%3Fid%3D2697829%26show%3Dpic' type='text/javascript'%3E%3C/script%3E"));
</script>
<script type="text/javascript">
var _bdhmProtocol = (("https:" == document.location.protocol) ? " https://" : " http://");
document.write(unescape("%3Cscript src='" + _bdhmProtocol + "hm.baidu.com/h.js%3F2bbdb11527d93b69fad8795fbc9167ef' type='text/javascript'%3E%3C/script%3E"));
</script> 
</div>
</body>
</html>