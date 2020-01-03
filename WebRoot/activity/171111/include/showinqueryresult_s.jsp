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
<%@page import="java.util.Random"%>

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
	for(int i=0;i<5;i++){
		uuids += CommonString.getUUID() +",";
	}
	
	//产品推荐品牌控制
	//轮式装载机系列品牌
	String zzj01="138,135,139,209,136,137,1777,145,144,141,172,145,148,143,192";
	String zzj02="174,182,175,14238";
	//履带式挖掘机系列品牌
	String wjj01="174,175,182,192,194,455,14238,184,183,133,189,185,16367,16373,179";
	String wjj02="209,139,136,135,137,152,141,146,142,134";
	//轮式挖掘机系列品牌
	String wjj03="192,194,184,174,175,455,16367";
	
	Map catalogMap = (HashMap)application.getAttribute("catalogMap") ;
	DBHelper dbHelper = DBHelper.getInstance() ;
	Map oneproduct  = null ;
	Map buyproduct  = null ;
	if(!"".equals(productid)){
	 	oneproduct = dbHelper.getMap(" select factoryid,factoryname,catalogname,name,file_name,tonandmeter,catalognum from pro_products where id='"+productid+"' ") ;
		buyproduct= dbHelper.getMap(" select top 1 buy_type,factoryid from pro_product_form where product_id='"+productid+"' order by add_date desc") ;
	}
	String buy_type = CommonString.getFormatPara(buyproduct.get("buy_type"));
	String buy_factoryid=CommonString.getFormatPara(buyproduct.get("factoryid"));

	if(null == oneproduct || oneproduct.size()==0){
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
	String productControl="";
	//轮式装载机条件
	if(CommonString.getFormatPara(oneproduct.get("catalognum")).equals("101002007")&&zzj01.indexOf(CommonString.getFormatPara(oneproduct.get("factoryid")))>=0){
		productControl=" and pro1.factoryid in("+zzj01+")";
	}else if(CommonString.getFormatPara(oneproduct.get("catalognum")).equals("101002007")&&zzj02.indexOf(CommonString.getFormatPara(oneproduct.get("factoryid")))>=0){
		productControl=" and pro1.factoryid in("+zzj02+")";
	}else if(CommonString.getFormatPara(oneproduct.get("catalognum")).equals("101002007")&&zzj01.indexOf(CommonString.getFormatPara(oneproduct.get("factoryid")))<0&&zzj02.indexOf(CommonString.getFormatPara(oneproduct.get("factoryid")))<0){
		productControl=" and pro1.factoryid not  in("+zzj01+","+zzj02+")";
	}
	//履带挖掘机条件
	if(CommonString.getFormatPara(oneproduct.get("catalognum")).equals("101001001")&&wjj01.indexOf(CommonString.getFormatPara(oneproduct.get("factoryid")))>=0){
		productControl=" and pro1.factoryid in("+wjj01+") and pro1.factoryid!=174";
	}else if(CommonString.getFormatPara(oneproduct.get("catalognum")).equals("101001001")&&wjj02.indexOf(CommonString.getFormatPara(oneproduct.get("factoryid")))>=0){
		productControl=" and pro1.factoryid in("+wjj02+")";
	}else if(CommonString.getFormatPara(oneproduct.get("catalognum")).equals("101001001")&&wjj01.indexOf(CommonString.getFormatPara(oneproduct.get("factoryid")))<0&&wjj02.indexOf(CommonString.getFormatPara(oneproduct.get("factoryid")))<0){
		productControl=" and pro1.factoryid not  in("+wjj01+","+wjj02+")";
	}
	//轮式挖掘机条件
	if(CommonString.getFormatPara(oneproduct.get("catalognum")).equals("101001004")&&wjj03.indexOf(CommonString.getFormatPara(oneproduct.get("factoryid")))>=0){
		productControl=" and pro1.factoryid in("+wjj03+")";
	}else if(CommonString.getFormatPara(oneproduct.get("catalognum")).equals("101001004")&&wjj03.indexOf(CommonString.getFormatPara(oneproduct.get("factoryid")))<0 ){
		productControl=" and pro1.factoryid not  in("+wjj03+")";
	}
	//压路机不出现骏马
	if(CommonString.getFormatPara(oneproduct.get("catalognum")).indexOf("106001")>=0){
        productControl=" and pro1.factoryid  != 816 ";   
	}
	factoryid=CommonString.getFormatPara(oneproduct.get("factoryid")) ;
	brandname = CommonString.getFormatPara(oneproduct.get("factoryname")) ;
	tonandmeter = CommonString.getFormatPara(oneproduct.get("tonandmeter")) ;
	otherchosetj += " and pro1.factoryname<>'"+brandname+"' and pro1.catalognum like '%"+CommonString.getFormatPara(oneproduct.get("catalognum"))+"%' ";
	// 根据开通订单推荐的代理商，优先推荐出产品，(条件:先根据区域选择)
	//otherProducts = OrderBusiness.getRecommendProducts(province,CommonString.getFormatPara(oneproduct.get("catalognum"))) ;//代理商管理中开通产品推荐合同，目前与营销宝冲突，该业务应该取消
	// 代理商营销宝中代理商推荐产品（高级版会员有此功能）
	if(!"".equals(tonandmeter) &&(null==otherProducts ||otherProducts.size()<3) && 1==2){
		String sql = "";
		sql += " SELECT TOP 4 a.factoryid,a.factoryname,a.catalognum,a.catalogname,a.name,a.file_name,";
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
		sql += " INNER JOIN pro_agent_factory paf ON paap.agent_id = paf.id AND paf.is_shop = 3 and paf.flag = 1 and paf.id!=173";
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
	if(!"".equals(tonandmeter) && otherProductsSize<4){//list长度小于两个推荐产品，吨位不为空，查询左右浮动5吨的产品（较精确）
		tempotherProducts = new ArrayList() ;
		String temptj = otherchosetj + "and pro1.tonandmeter between "+Float.parseFloat(tonandmeter) +" and "+(Float.parseFloat(tonandmeter)+5.0) ;
		tempotherProducts = dbHelper.getMapList("select top "+(4-otherProductsSize)+" pro1.id productid,pro2.factoryid,pro2.factoryname,pro2.catalognum,pro2.name,pro2.file_name,pro2.img2 from pro_products pro1 left join pro_products pro2 on pro1.id=pro2.id "+temptj+productControl+" order by newid()") ;
		otherProducts.addAll(tempotherProducts) ; // 联合两个 list 
		//System.out.println("=======================1");
	}
	otherProductsSize = otherProducts.size() ;
	if(null == otherProducts||otherProductsSize<4){//代理商管理中未开通产品推荐合同&&list长度小于两个推荐产品，查询不同品牌、同类别产品
		tempotherProducts = dbHelper.getMapList("select top "+(4-otherProductsSize)+" pro1.id productid,pro2.factoryid,pro2.factoryname,pro2.catalognum,pro2.name,pro2.file_name,pro2.img2 from pro_products pro1 left join pro_products pro2 on pro1.id=pro2.id "+otherchosetj+" order by newid()") ;
		otherProducts.addAll(tempotherProducts) ; // 联合两个 list 
		//System.out.println("=======================2");
	}
	otherProductsSize = otherProducts.size() ;  // 重新算出 list 长度
	if(null == otherProducts||otherProductsSize<4){//代理商管理中未开通产品推荐合同&&list长度小于两个推荐产品，查询同品牌随机产品
		tempotherProducts = dbHelper.getMapList(" select top "+(4-otherProductsSize)+" pro1.id productid,pro2.factoryid,pro2.factoryname,pro2.catalognum,pro2.name,pro2.file_name,pro2.img2 from pro_products pro1 left join pro_products pro2 on pro1.id=pro2.id  where 1=1 and pro1.factoryname='"+brandname+"' order by newid()") ;
		otherProducts.addAll(tempotherProducts) ; // 联合两个 list 
		//System.out.println("=======================3");
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>在线询价</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link href="/style/style.css" rel="stylesheet" type="text/css" />
<link href="/scripts/jBox-v2.3/Skins2/Blue/jbox.css" rel="stylesheet" type="text/css"/>
<style type="text/css">
body { padding: 5px 10px; font-family: 'Microsoft Yahei' }
.top_t { color: #4e5762; font-size: 18px; border-bottom: 1px solid #dfdfdf; padding-bottom: 7px; }
.top_t1 { font-size: 18px; height: 85px; line-height: 85px; font-weight: bold; border-bottom: 1px dashed #f1f1f2 }
.top_t1 .img { vertical-align: middle; margin-right: 10px; }
.list_t { font-size: 16px; font-weight: bold; margin-bottom: 10px; }
.list_t span { color: #fe6000 }
.tj li { float: left; width: 50%; margin-bottom: 1px; }
.tj li span { display: block; margin-bottom: 5px; }
.tj li span.n { color: #990000 }
.tj li input[type=checkbox] { vertical-align: middle; margin-right: 5px; }
.orderbg{ padding-bottom:5px; border-bottom:1px solid #dfdfdf; margin-bottom:5px;}
.orderbg .img { position: absolute; right: 20px; bottom: 50px; width: 210px; height: 45px; }
.xj_btn { width: 267px; height: 61px; background: url(images/xunjia.png) no-repeat; border: 0; cursor: pointer }
.STYLE1 { color: #FF0000 }
.jbox-close{ display:none !importent}
</style>
<script type="text/javascript" src="/scripts/jquery-1.7.min.js"></script>
<script type="text/javascript" src="/scripts/jquery.form.js"></script>
<script type="text/javascript" src="/scripts/jBox-v2.3/jquery.jBox-2.3.min.js"></script>
<script type="text/javascript" src="/scripts/citys.js"></script>
<script type="text/javascript" src="/scripts/scripts.js"></script>
<script type="text/javascript">
  function closeAll(){
   $(".chk_list").attr("checked",false);
   var count=4;
  for(var i=0;i<4;i++){
  count++;
   var x=document.getElementsByName("chk_list")[i].getAttribute('rel');
    var id=document.getElementsByName("chk_list")[i].id;
	var y1=x.split(":")[0];
	 var y2=x.split(":")[1];
	 //推荐
    if(x.indexOf("101001")!=-1&&y1=="174"){
	count--;
	 $("#"+id).attr("checked",true);
	 var value=$("#"+id).val();
	   $.post("/tools/kate_tuijian.jsp",{factory_num:y1,catalog_num:y2,pro_id:value},function(data){inquery("flag");} );
	     }
		}
		if(count==8){ parent.window.jBox.close();}
		
	}
  function closethiswindow(){
  window.close() ;
  }
  <%
  	String heshi = CommonString.getFormatPara(request.getParameter("heshi"));
  	if("1".equals(heshi)){
  		%> jQuery.getJSON("http://used.21-sun.com/tools/import/insertOneInquiry.jsp?id=<%=request.getParameter("keyId") %>&callback=?");<%
  	}
  %>
 
  function inquery(flag){
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
		 
  	 	 if(flag=='flag'){
		 parent.window.jBox.close();
		 }else{
		  parent.jQuery.jBox.tip("询价成功！") ;
		 setTimeout("parent.window.jBox.close()",1000) ;
		 }
   });
   }
   $(function(){$("body",parent.document).find('.jbox-close').hide()})

</script>
</head>
<body>
<h3 class="top_t">询价成功</h3>
<div class="top_t1"><img src="images/succ1.png" width="74" height="77" class="img">您在<span style="color:red"><a style="color:red" href="http://product.21-sun.com/" target="_blank">铁臂商城</a></span>的询价已提交，<span ><a style="color:red" href="http://product.21-sun.com/products/prolist.jsp?factory=<%=CommonString.getFormatPara(oneproduct.get("factoryid"))%>&catalog=<%=CommonString.getFormatPara(oneproduct.get("catalognum"))%>#main" target="_blank"><%=CommonString.getFormatPara(oneproduct.get("factoryname"))%></a></span>将及时联系您进行报价！</div>
<div class="orderbg fix"> <!--<img src="/images/xj_tel.png" alt="客服热线" class="img" />-->
  <p class="list_t">您可以对以下机型同时询价，获得更多的价格参考</p>
  <div class="l" style=" width:58%">
    <ul class="fix tj">
	
	                        <%
							if(null != otherProducts && otherProducts.size()==4){//代理商管理中未开通产品推荐合同&&list长度小于两个推荐产品
							
								// 订单推荐调整
								// 因目前和中联重科合作产品中心订单信息，现需要请您协助将挖掘机、
								//推土机询价后出现的推荐产品设定为推荐中联重科的
								//挖掘机(按吨位推荐)和推土机(随机出现)，谢谢
								//过滤掉安徽和河南的
								Map recomMap = null ;
								Map recomMap1 = null ;
								//20140830取消第二个卡特推荐，只保留后面的第一个位置推荐
								if(1==2&&CommonString.getFormatPara(oneproduct.get("catalognum")).indexOf("101001")!=-1 && !"".equals(oneproduct.get("tonandmeter"))&&!"安徽".equals(province)&&!"河南".equals(province)){ // 如果询价产品为挖掘机
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
									//String sel_sql = " select top 1 img2,factoryid,factoryname,catalogname,name,file_name,tonandmeter,catalognum,id as productid from pro_products where 1=1 " ;
									//String whereStr = " and factoryid=174 and catalognum like '"+CommonString.getFormatPara(oneproduct.get("catalognum"))+"%' " ;
									//String orderBy = " order by newid()" ;
									//recomMap = dbHelper.getMap(sel_sql+whereStr+orderBy) ;
									//if(null==recomMap){
										//recomMap = dbHelper.getMap(sel_sql+whereStr+orderBy) ;
									//}
									//if(null!=recomMap){
										 //otherProducts.remove(1) ; // 移除第二个推荐产品
										 //otherProducts.add(1,recomMap) ;	
									//}
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
								//推荐连云港工兵
								if(CommonString.getFormatPara(oneproduct.get("catalognum")).indexOf("113001")!=-1){
									String sel_sql = " select top 1 img2,factoryid,factoryname,catalogname,name,file_name,tonandmeter,catalognum,id as productid from pro_products where 1=1 " ;
									String whereStr = " and factoryid=1103 and catalognum like '113001%' " ;
									String whereStr1 = " and id='6346' " ;    //连云港工兵
									String orderBy = " order by newid()" ;
									recomMap = dbHelper.getMap(sel_sql+whereStr+orderBy) ;
									if(null==recomMap){
										recomMap = dbHelper.getMap(sel_sql+whereStr+orderBy) ;
									}
									if(null!=recomMap){
										 otherProducts.remove(0) ; // 移除第一个推荐产品,四川黑金刚
										 otherProducts.add(0,recomMap) ;	
									}
									
									recomMap1 = dbHelper.getMap(sel_sql+whereStr1+orderBy) ;
									if(null==recomMap1){
										recomMap1 = dbHelper.getMap(sel_sql+whereStr1+orderBy) ;
									}
									if(null!=recomMap1){
										 otherProducts.remove(1) ; // 移除第二个推荐产品,连云港工兵
										 otherProducts.add(1,recomMap1) ;	
									}
									
								}
    							// 产品中心装载机询价推荐常林、成工出现的频率太高了（貌似近80%都是他俩），
    							//这两个都和我们没有合作，可否换成推荐山工的，谢谢
    							// 备注：山工只有轮式装载机
								if(CommonString.getFormatPara(oneproduct.get("catalognum")).indexOf("101002")!=-1&&1==2){
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
										 otherProducts.remove(0) ; // 移除第一个推荐产品
										 otherProducts.add(0,recomMap) ;	
									}
								}
								
								//一直推荐一个卡特的
							    if(CommonString.getFormatPara(oneproduct.get("catalognum")).indexOf("101001")!=-1&&1==2){ 
									String sel_sql = " select top 1 img2,factoryid,factoryname,catalogname,name,file_name,tonandmeter,catalognum,id as productid from pro_products where 1=1 " ;
									String whereStr = " and (id=20164  or id=20163  or id=4561  or id=21514)" ;
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
								//询价微挖某款产品推荐吃传到
								 if(productid.equals("523")){ 
									String sel_sql = " select top 1 img2,factoryid,factoryname,catalogname,name,file_name,tonandmeter,catalognum,id as productid from pro_products where 1=1 " ;
									String whereStr = " and  id=15181 " ;
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
								//雷沃的概率提高一些
								if((CommonString.getFormatPara(oneproduct.get("catalognum")).indexOf("101001")!=-1||CommonString.getFormatPara(oneproduct.get("catalognum")).indexOf("101002")!=-1)&&(zzj01.indexOf(CommonString.getFormatPara(oneproduct.get("factoryid")))>=0||wjj02.indexOf(CommonString.getFormatPara(oneproduct.get("factoryid")))>=0)){
						            System.out.println("雷沃的有可能出现");
			                        Random random =new Random(); 
                                    int a=random.nextInt(100);
									if(a>80){
									String sel_sql = " select top 1 img2,factoryid,factoryname,catalogname,name,file_name,tonandmeter,catalognum,id as productid from pro_products where 1=1 " ;
									String whereStr = " and is_show=1 and factoryid=141 and catalognum like '"+CommonString.getFormatPara(oneproduct.get("catalognum"))+"%' " ;
									String orderBy = " order by newid()" ;
									recomMap = dbHelper.getMap(sel_sql+whereStr+orderBy) ;
									if(null==recomMap){
										recomMap = dbHelper.getMap(sel_sql+whereStr+orderBy) ;
									}
									if(null!=recomMap){
										 otherProducts.remove(3) ; // 移除第一个推荐产品
										 otherProducts.add(3,recomMap) ;	
									}
									}
								}
								//给山工四个类别推荐
								if((CommonString.getFormatPara(oneproduct.get("catalognum")).indexOf("101002007")!=-1||CommonString.getFormatPara(oneproduct.get("catalognum")).indexOf("106001")!=-1||CommonString.getFormatPara(oneproduct.get("catalognum")).indexOf("101003")!=-1||CommonString.getFormatPara(oneproduct.get("catalognum")).indexOf("101005")!=-1)&&!"138".equals(CommonString.getFormatPara(oneproduct.get("factoryid")))){
		
								
									String sel_sql = " select top 1 img2,factoryid,factoryname,catalogname,name,file_name,tonandmeter,catalognum,id as productid from pro_products where 1=1 " ;
									String whereStr = " and is_show=1 and factoryid=138 and catalognum like '"+CommonString.getFormatPara(oneproduct.get("catalognum"))+"%' " ;
									String orderBy = " order by newid()" ;
									recomMap = dbHelper.getMap(sel_sql+whereStr+orderBy) ;
									if(null==recomMap){
										recomMap = dbHelper.getMap(sel_sql+whereStr+orderBy) ;
									}
									if(null!=recomMap){
										 otherProducts.remove(1) ; // 移除第二个推荐产品
										 otherProducts.add(1,recomMap) ;	
									}
								
								}
								
								
								}
								Map imgs = null ;
			                    int i=0;
								String model_name="";String factory_ids="";String catalog_nums="";String catalog_names="";
								for(Map oneMap:otherProducts){
								model_name=CommonString.getFormatPara(oneMap.get("name"));
								catalog_nums=CommonString.getFormatPara(oneMap.get("catalognum"));
								factory_ids=CommonString.getFormatPara(oneMap.get("factoryid"));
								catalog_names=CommonString.getFormatPara(oneMap.get("catalog_name"));
								if(model_name.length()>8){model_name=model_name.substring(0,8)+"...";}
							%>
      <li><img src="/uploadfiles/<%=CommonString.getFormatPara(oneMap.get("img2"))%>"  onerror="showImgDelay(this,'/uploadfiles/no_small.gif',2);" width="103" height="84" class="l"><span id="brand_name">品牌：<%=CommonString.getFormatPara(oneMap.get("factoryname")) %></span>
	  <span>型号：<%=model_name %></span>
	  <span class="n"><input type="checkbox" name="chk_list" class="chk_list" id="input_<%=i%>" rel="<%=factory_ids%>:<%=catalog_nums%>" value="<%=CommonString.getFormatPara(oneMap.get("productid")) %>" <%if(  (buy_factoryid.equals("144")&&CommonString.getFormatPara(oneMap.get("catalognum")).indexOf("101002")!=-1)||"13570".equals(factory_ids)   ){%> <%}else{%>checked="true"<%}%>>
        请点击选择</span></li>
      <%i++;}%>
    </ul>
  </div>
  <div class="r" style="width:40%; border-left:1px solid #e6e6e6; text-align:center">
  <img src="images/erwei.png" width="96" height="96">  &nbsp; 
  <p style=" width:136px; margin:0 auto; text-align:center;line-height: 20px;">铁臂商城手机版<br>随时随地询价<br>QQ群:250469589</p>
  </div>
</div>
<div style="width:60%; text-align:center"><input class="xj_btn" name="Submit" type="button" value="" onClick="inquery();"/><a href="javascript:void(0)" onclick="closeAll()">【暂不询价】</a></div>
</div>
</body>
</html>

