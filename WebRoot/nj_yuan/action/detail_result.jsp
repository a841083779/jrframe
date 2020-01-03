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
<%@page import="com.jerehnet.util.common.CommonDate"%>
<%@page import="com.jerehnet.util.common.Common"%>
<%
	String productid = CommonString.getFormatPara(request.getParameter("productid")) ;
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
	String buy_type = CommonString.getFormatPara(request.getParameter("buy_type"));
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
	String buy_factoryid="";
	if(null == oneproduct || oneproduct.size()==0){return ;}
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

	if(null == otherProducts){
		otherProducts = new ArrayList() ;
	}
	int otherProductsSize = otherProducts.size() ;
	List<Map> tempotherProducts = null ;
	if(!"".equals(tonandmeter) && otherProductsSize<4){//list长度小于两个推荐产品，吨位不为空，查询左右浮动5吨的产品（较精确）
		tempotherProducts = new ArrayList() ;
		String temptj = otherchosetj + "and pro1.tonandmeter between "+Float.parseFloat(tonandmeter) +" and "+(Float.parseFloat(tonandmeter)+5.0) ;
		tempotherProducts = dbHelper.getMapList("select top "+(4-otherProductsSize)+"pro1.catalogname,pro1.id productid,pro2.factoryid,pro2.factoryname,pro2.catalognum,pro2.name,pro2.file_name,pro2.img2 from pro_products pro1 left join pro_products pro2 on pro1.id=pro2.id "+temptj+productControl+" order by newid()") ;
		otherProducts.addAll(tempotherProducts) ; // 联合两个 list 
	}
	otherProductsSize = otherProducts.size() ;
	if(null == otherProducts||otherProductsSize<4){//代理商管理中未开通产品推荐合同&&list长度小于两个推荐产品，查询不同品牌、同类别产品
		tempotherProducts = dbHelper.getMapList("select top "+(4-otherProductsSize)+" pro1.catalogname,pro1.id productid,pro2.factoryid,pro2.factoryname,pro2.catalognum,pro2.name,pro2.file_name,pro2.img2 from pro_products pro1 left join pro_products pro2 on pro1.id=pro2.id "+otherchosetj+" order by newid()") ;
		otherProducts.addAll(tempotherProducts) ; // 联合两个 list 
	}
	otherProductsSize = otherProducts.size() ;  // 重新算出 list 长度
	if(null == otherProducts||otherProductsSize<4){//代理商管理中未开通产品推荐合同&&list长度小于两个推荐产品，查询同品牌随机产品
		tempotherProducts = dbHelper.getMapList(" select top "+(4-otherProductsSize)+" pro1.catalogname,pro1.id productid,pro2.factoryid,pro2.factoryname,pro2.catalognum,pro2.name,pro2.file_name,pro2.img2 from pro_products pro1 left join pro_products pro2 on pro1.id=pro2.id  where 1=1 and pro1.factoryname='"+brandname+"' order by newid()") ;
		otherProducts.addAll(tempotherProducts) ; // 联合两个 list 
	}
	if(null != otherProducts && otherProducts.size()==4){//代理商管理中未开通产品推荐合同&&list长度小于两个推荐产品
							
													Map recomMap = null ;
								Map recomMap1 = null ;
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
								
								//除了询价柳工的机器，当询价其他小挖时推荐卡特合作的四款机器
							    if(!CommonString.getFormatPara(oneproduct.get("factoryid")).equals("136")&&CommonString.getFormatPara(oneproduct.get("catalognum")).indexOf("101001")!=-1&&CommonString.getFormatInt(oneproduct.get("tonandmeter"))>=1&&CommonString.getFormatInt(oneproduct.get("tonandmeter"))<=13){ 
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
								
								}
								Map imgs = null ;
			                    int i=0;
								String model_name="";String factory_ids="";String catalog_nums="";String catalog_names="";
								for(Map tempproduct:otherProducts){
								catalog_names="";
								String today = CommonDate.getToday("yyyy-MM-dd HH:mm:ss") ;
								model_name=CommonString.getFormatPara(tempproduct.get("name"));
								catalog_nums=CommonString.getFormatPara(tempproduct.get("catalognum"));
								factory_ids=CommonString.getFormatPara(tempproduct.get("factoryid"));
								catalog_names=CommonString.getFormatPara(tempproduct.get("catalogname"));
								String ip="";
								String insertsql = " insert into pro_product_form(add_user,add_date,add_ip,catanum,factoryid,factoryname,cataname,name,contact_address,mobile_phone,product_id,uuid,product_name,message,province,city,buy_time,ifgroup,company,buy_type) values('front_right','"+today+"','"+ip+"','"+Common.securityFilter(CommonString.getFormatPara(tempproduct.get("catalognum")))+"','"+Common.securityFilter(CommonString.getFormatPara(tempproduct.get("factoryid")))+"','"+Common.securityFilter(CommonString.getFormatPara(tempproduct.get("factoryname")))+"','"+(CommonString.getFormatPara(tempproduct.get("catalogname")))+"','"+username+"','"+contact_address+"','"+telephone+"','"+Common.securityFilter(CommonString.getFormatPara(tempproduct.get("productid")))+"','"+CommonString.getUUID()+"','"+Common.securityFilter(CommonString.getFormatPara(tempproduct.get("name")))+"','','"+province+"','"+city+"','"+buy_time+"','个人','','"+buy_type+"') " ;
                                dbHelper.executeUpdate(insertsql);
								i++;}
	 %>



