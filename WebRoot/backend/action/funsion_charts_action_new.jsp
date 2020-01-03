<%@ page language="java" import="java.net.URLDecoder,java.util.*,com.jerehnet.util.dbutil.*,java.sql.Connection,com.jerehnet.util.common.*,com.jerehnet.manage.*" pageEncoding="GBK"%><%
	String base_e = "0123456789ABCDEF" ;
	Random random = new Random() ;	
	response.setContentType("text/xml;");
	StringBuffer xml = new StringBuffer();
	xml.append("<?xml version='1.0' encoding='gbk'?>");
	DBHelper dbHelper = DBHelper.getInstance();
	Connection connection = null;
	String flag = CommonString.getFormatPara(request.getParameter("flag"));
	String enumNo = CommonString.getFormatPara(request.getParameter("enumNo"));
	String sql = "";
	List<String> provincesCategory = new ArrayList<String>();
	provincesCategory.add("安徽");
	provincesCategory.add("北京");
	provincesCategory.add("重庆");
	provincesCategory.add("福建");
	provincesCategory.add("甘肃");
	provincesCategory.add("广东");
	provincesCategory.add("广西");
	provincesCategory.add("贵州");
	provincesCategory.add("海南");
	provincesCategory.add("河北");
	provincesCategory.add("黑龙江");
	provincesCategory.add("河南");
	provincesCategory.add("湖北");
	provincesCategory.add("湖南");
	provincesCategory.add("内蒙古");
	provincesCategory.add("江苏");
	provincesCategory.add("江西");
	provincesCategory.add("吉林");
	provincesCategory.add("辽宁");
	provincesCategory.add("宁夏");
	provincesCategory.add("青海");
	provincesCategory.add("山西");
	provincesCategory.add("山东");
	provincesCategory.add("上海");
	provincesCategory.add("四川");
	provincesCategory.add("天津");
	provincesCategory.add("西藏");
	provincesCategory.add("新疆");
	provincesCategory.add("云南");
	provincesCategory.add("浙江");
	provincesCategory.add("陕西");
	provincesCategory.add("台湾");
	provincesCategory.add("香港");
	provincesCategory.add("澳门");
	try{
		connection = PoolManager.getConnection(DBType.getDBTypeByEnum(enumNo));
		if("agent_cai_gou_xing_zhi".equals(flag)){
			Integer ge_ren = (Integer)dbHelper.getOne(" SELECT COUNT(*) FROM pro_product_form WHERE ifgroup = '个人' ",connection);
			Integer gong_si = (Integer)dbHelper.getOne(" SELECT COUNT(*) FROM pro_product_form WHERE ifgroup = '公司' ",connection);
			//Integer qi_ta = (Integer)dbHelper.getOne(" SELECT COUNT(*) FROM pro_product_form WHERE ifgroup IS NULL ",connection);
			xml.append("<chart palette='4' caption='采购性质（来源于订单询价）' formatNumberScale='0' decimals='0' enableSmartLabels='1' enableRotation='0' bgColor='CCCCCC,FFFFFF' bgAlpha='40,100' bgRatio='0,100' bgAngle='360' showBorder='1' startingAngle='70' baseFont='微软雅黑' baseFontSize='16'>");
			xml.append("<set label='个人' value='"+ge_ren+"' />");
			xml.append("<set label='公司' value='"+gong_si+"' />");
			//xml.append("<set label='其它' value='"+qi_ta+"' />");
			xml.append("</chart>");
		}
		if("agent_yu_gou_shi_jian".equals(flag)){ 
			Integer buy_time_102001 = (Integer)dbHelper.getOne(" SELECT count(*) FROM pro_product_form WHERE buy_time = '102001' ",connection);
			Integer buy_time_102002 = (Integer)dbHelper.getOne(" SELECT count(*) FROM pro_product_form WHERE buy_time = '102002' ",connection);
			Integer buy_time_102003 = (Integer)dbHelper.getOne(" SELECT count(*) FROM pro_product_form WHERE buy_time = '102003' ",connection);
			Integer buy_time_102004 = (Integer)dbHelper.getOne(" SELECT count(*) FROM pro_product_form WHERE buy_time = '102004' ",connection);
			Integer buy_time_102005 = (Integer)dbHelper.getOne(" SELECT count(*) FROM pro_product_form WHERE buy_time = '102005' ",connection);
			Integer buy_time_102006 = (Integer)dbHelper.getOne(" SELECT count(*) FROM pro_product_form WHERE buy_time = '102006' ",connection);
			xml.append("<chart palette='6' caption='预计购买时间（来源于订单询价）' decimals='0' formatNumberScale='0' enableSmartLabels='1' enableRotation='0' bgColor='CCCCCC,FFFFFF' bgAlpha='40,100' bgRatio='0,100' bgAngle='360' showBorder='1' startingAngle='70' baseFont='微软雅黑' baseFontSize='16'>");
			xml.append("<set label='1个月内' value='"+buy_time_102001+"' />");
			xml.append("<set label='1-3个月' value='"+buy_time_102002+"' />");
			xml.append("<set label='4-6个月' value='"+buy_time_102003+"' />");
			xml.append("<set label='7-12个月' value='"+buy_time_102004+"' />");
			xml.append("<set label='1年后' value='"+buy_time_102005+"' />");
			xml.append("<set label='不确定' value='"+buy_time_102006+"' />");
			xml.append("</chart>");
		}
		
		if("ding_gou_pai_ming_shengfen".equals(flag)){ //  订单省份排名
			String sel_sql = " select count(*) as total from pro_product_form where province is not null and province<>'' and province like '" ;
			xml.append("<chart palette='2' caption='省份订单排名'  decimals='0' useRoundEdges='1' legendBorderAlpha='0' formatNumberScale='0' baseFont='微软雅黑' baseFontSize='12'>");
				xml.append("<categories>") ;
				Map myMap = new HashMap() ;
				for(String sheng:provincesCategory){  
					xml.append("<category label='"+CommonString.getFormatPara(sheng)+"' />") ;
				}
				xml.append("</categories>") ;
				xml.append("<dataset seriesName='订单数量(省份)' color='F6BD0F' showValues='1'>") ;
				Map oneMap = new HashMap() ;
				for(int j=0;j<provincesCategory.size();j++){ 
					String province = provincesCategory.get(j) ;
					oneMap = dbHelper.getMap(sel_sql+province+"%'",connection) ;
					StringBuffer sbf = new StringBuffer("") ;
					for(int i=0;i<6;i++){
						sbf.append(base_e.charAt(random.nextInt(base_e.length()))) ;
					}
					xml.append("<set  color='"+sbf.toString()+"' value='"+CommonString.getFormatPara(oneMap.get("total"))+"' tooltext='地区:"+province+"&lt;BR&gt;数量: "+CommonString.getFormatPara(oneMap.get("total"))+"&lt;BR&gt;'/>") ;
				}
				xml.append("</dataset>") ;
				xml.append("<styles><definition><style name='myHTMLFont' type='font' isHTML='1' /></definition><application><apply toObject='TOOLTIP' styles='myHTMLFont' /></application></styles>") ;
			xml.append("</chart>") ;
		}
		if("ding_dan_xiang_qing_shengfen".equals(flag)){// 省份
			Map oneMap = new HashMap() ;
			String sel_total_sql = " select count(*) as total from pro_product_form " ;
			Integer total = Integer.parseInt(CommonString.getFormatPara(dbHelper.getMap(sel_total_sql,connection).get("total"))) ;
			String sel_sql = " select count(*) as total from pro_product_form where province like 'province_val%'" ;
			xml.append("<map animation='1' showShadow='1' showBevel='0' showLabels='1' showMarkerLabels='1' fillColor='F1f1f1' borderColor='CCCCCC' baseFont='Verdana' baseFont='微软雅黑' baseFontSize='12' markerBorderColor='000000' markerBgColor='FF5904'markerRadius='6' legendPosition='bottom' useHoverColor='1' showToolTip='1' showMarkerToolTip='1' >") ;
			xml.append("<data>") ;
				for(String str:provincesCategory){
					oneMap = dbHelper.getMap(sel_sql.replace("province_val",str),connection) ;
					if(str.equals("西藏")){
						xml.append("<entity id='CN.XZ' toolText='地区:"+str+"&lt;BR&gt;数量:"+CommonString.getFormatPara(oneMap.get("total"))+"' displayValue='"+str+"' value='"+CommonString.getFormatPara(oneMap.get("total"))+"' color='"+(((Integer.parseInt(CommonString.getFormatPara(oneMap.get("total")))>5000))?"#FF0000":((Integer.parseInt(CommonString.getFormatPara(oneMap.get("total")))>1000)?"#FF6347":"FF8C69"))+"'/>") ;
					}if(str.equals("山西")){
						xml.append("<entity id='CN.SA' toolText='地区:"+str+"&lt;BR&gt;数量:"+CommonString.getFormatPara(oneMap.get("total"))+"' displayValue='"+str+"' value='"+CommonString.getFormatPara(oneMap.get("total"))+"' color='"+(((Integer.parseInt(CommonString.getFormatPara(oneMap.get("total")))>5000))?"#FF0000":((Integer.parseInt(CommonString.getFormatPara(oneMap.get("total")))>1000)?"#FF6347":"FF8C69"))+"'/>") ;
					}if(str.equals("重庆")){
						xml.append("<entity id='CN.CQ' toolText='地区:"+str+"&lt;BR&gt;数量:"+CommonString.getFormatPara(oneMap.get("total"))+"' displayValue='"+str+"' value='"+CommonString.getFormatPara(oneMap.get("total"))+"' color='"+(((Integer.parseInt(CommonString.getFormatPara(oneMap.get("total")))>5000))?"#FF0000":((Integer.parseInt(CommonString.getFormatPara(oneMap.get("total")))>1000)?"#FF6347":"FF8C69"))+"'/>") ;
					}if(str.equals("河南")){
						xml.append("<entity id='CN.HE' toolText='地区:"+str+"&lt;BR&gt;数量:"+CommonString.getFormatPara(oneMap.get("total"))+"' displayValue='"+str+"' value='"+CommonString.getFormatPara(oneMap.get("total"))+"' color='"+(((Integer.parseInt(CommonString.getFormatPara(oneMap.get("total")))>5000))?"#FF0000":((Integer.parseInt(CommonString.getFormatPara(oneMap.get("total")))>1000)?"#FF6347":"FF8C69"))+"'/>") ;
					}if(str.equals("湖北")){
						xml.append("<entity id='CN.HU' toolText='地区:"+str+"&lt;BR&gt;数量:"+CommonString.getFormatPara(oneMap.get("total"))+"' displayValue='"+str+"' value='"+CommonString.getFormatPara(oneMap.get("total"))+"' color='"+(((Integer.parseInt(CommonString.getFormatPara(oneMap.get("total")))>5000))?"#FF0000":((Integer.parseInt(CommonString.getFormatPara(oneMap.get("total")))>1000)?"#FF6347":"FF8C69"))+"'/>") ;
					}if(str.equals("海南")){
						xml.append("<entity id='CN.HA' toolText='地区:"+str+"&lt;BR&gt;数量:"+CommonString.getFormatPara(oneMap.get("total"))+"' displayValue='"+str+"' color='"+(((Integer.parseInt(CommonString.getFormatPara(oneMap.get("total")))>5000))?"#FF0000":((Integer.parseInt(CommonString.getFormatPara(oneMap.get("total")))>1000)?"#FF6347":"FF8C69"))+"'/>") ;
					}if(str.equals("台湾")){
						xml.append("<entity id='CN.TA' toolText='地区:"+str+"&lt;BR&gt;数量:"+CommonString.getFormatPara(oneMap.get("total"))+"' displayValue='"+str+"' value='"+CommonString.getFormatPara(oneMap.get("total"))+"' color='"+(((Integer.parseInt(CommonString.getFormatPara(oneMap.get("total")))>5000))?"#FF0000":((Integer.parseInt(CommonString.getFormatPara(oneMap.get("total")))>1000)?"#FF6347":"FF8C69"))+"'/>") ;
					}if(str.equals("澳门")){
						xml.append("<entity id='CN.MA' toolText='地区:"+str+"&lt;BR&gt;数量:"+CommonString.getFormatPara(oneMap.get("total"))+"' displayValue='"+str+"' value='"+CommonString.getFormatPara(oneMap.get("total"))+"' color='"+(((Integer.parseInt(CommonString.getFormatPara(oneMap.get("total")))>5000))?"#FF0000":((Integer.parseInt(CommonString.getFormatPara(oneMap.get("total")))>1000)?"#FF6347":"FF8C69"))+"'/>") ;
					}if(str.equals("香港")){
						xml.append("<entity id='CN.HK' toolText='地区:"+str+"&lt;BR&gt;数量:"+CommonString.getFormatPara(oneMap.get("total"))+"' displayValue='"+str+"' value='"+CommonString.getFormatPara(oneMap.get("total"))+"' color='"+(((Integer.parseInt(CommonString.getFormatPara(oneMap.get("total")))>5000))?"#FF0000":((Integer.parseInt(CommonString.getFormatPara(oneMap.get("total")))>1000)?"#FF6347":"FF8C69"))+"'/>") ;
					}else{
					xml.append("<entity id='CN."+CnToFullSpell.getFirstSpell(str.substring(0,1)).toUpperCase()+CnToFullSpell.getFirstSpell(str.substring(1,2)).toUpperCase()+"' toolText='地区:"+str+"&lt;BR&gt;数量:"+CommonString.getFormatPara(oneMap.get("total"))+"' displayValue='"+str+"' value='"+CommonString.getFormatPara(oneMap.get("total"))+"' color='"+(((Integer.parseInt(CommonString.getFormatPara(oneMap.get("total")))>5000))?"#FF0000":((Integer.parseInt(CommonString.getFormatPara(oneMap.get("total")))>1000)?"#FF6347":"FF8C69"))+"'/>") ;
					}
				}
			xml.append("</data>") ;
			xml.append("<styles><definition><style name='myHTMLFont' type='font' isHTML='1' /></definition><application><apply toObject='TOOLTIP' styles='myHTMLFont' /></application></styles>") ;
		    xml.append("</map>") ;
		}
		if("ding_gou_pai_ming_brand".equals(flag)){ //  订单品牌排名
			String sel_sql = " select top 100 factoryname,count(*) total from pro_product_form group by factoryname order by total desc " ;
			List<Map> dingdanList = new ArrayList() ;
			dingdanList = dbHelper.getMapList(sel_sql,connection) ;
			xml.append("<chart palette='2' caption='品牌订单排名' decimals='0' labelDisplay='Stagger' staggerLines='2' useRoundEdges='1' legendBorderAlpha='0' formatNumberScale='0' baseFont='微软雅黑' baseFontSize='12'>");
			if(null!=dingdanList && dingdanList.size()>0){
				xml.append("<categories>") ;
				Map myMap = new HashMap() ;
				for(int i=0;i<dingdanList.size();i++){  
					myMap = dingdanList.get(i) ;
					xml.append("<category label='"+CommonString.getFormatPara(myMap.get("factoryname"))+"' />") ;
				}
				xml.append("</categories>") ;
				xml.append("<dataset seriesName='订单数量(品牌)' color='F6BD0F' showValues='1'>") ;
				for(int j=0;j<dingdanList.size();j++){ 
					Map oneMap = dingdanList.get(j) ;
					StringBuffer sbf = new StringBuffer("") ;
					for(int i=0;i<6;i++){
						sbf.append(base_e.charAt(random.nextInt(base_e.length()))) ;
					}
					xml.append("<set color='"+sbf.toString()+"' value='"+CommonString.getFormatPara(oneMap.get("total"))+"' tooltext='名称:"+CommonString.getFormatPara(oneMap.get("factoryname"))+"&lt;BR&gt;数量: "+CommonString.getFormatPara(oneMap.get("total"))+"&lt;BR&gt;排名:"+(j+1)+"'/>") ;
				}
				xml.append("</dataset>") ;
				xml.append("<styles><definition><style name='myHTMLFont' type='font' isHTML='1' /></definition><application><apply toObject='TOOLTIP' styles='myHTMLFont' /></application></styles>") ;
			}
			xml.append("</chart>") ;
		}
		if("ding_gou_pai_ming_agent".equals(flag)){ //  订单品牌排名
			String sel_sql = "  select top 100 agentname factoryname,count(*) total from pro_product_form where agentname is not null and agentname<>'' group by agentname order by total desc  " ;
			List<Map> dingdanList = new ArrayList() ;
			dingdanList = dbHelper.getMapList(sel_sql,connection) ;
			xml.append("<chart palette='2' caption='代理商订单排名' decimals='0' labelDisplay='Stagger' staggerLines='2' useRoundEdges='1' legendBorderAlpha='0' formatNumberScale='0' baseFont='微软雅黑' baseFontSize='12'>");
			if(null!=dingdanList && dingdanList.size()>0){
				xml.append("<categories>") ;
				Map myMap = new HashMap() ;
				for(int i=0;i<dingdanList.size();i++){  
					myMap = dingdanList.get(i) ;
					xml.append("<category label='"+(CommonString.getFormatPara(myMap.get("factoryname")).length()<=4?CommonString.getFormatPara(myMap.get("factoryname")):CommonString.getFormatPara(myMap.get("factoryname")).substring(0,4)+"...")+"' />") ;
				}
				xml.append("</categories>") ;
				xml.append("<dataset seriesName='订单数量(品牌)' color='F6BD0F' showValues='1'>") ;
				for(int j=0;j<dingdanList.size();j++){ 
					Map oneMap = dingdanList.get(j) ;
					StringBuffer sbf = new StringBuffer("") ;
					for(int i=0;i<6;i++){
						sbf.append(base_e.charAt(random.nextInt(base_e.length()))) ;
					}
					xml.append("<set color='"+sbf.toString()+"' value='"+CommonString.getFormatPara(oneMap.get("total"))+"' tooltext='名称:"+CommonString.getFormatPara(oneMap.get("factoryname"))+"&lt;BR&gt;数量: "+CommonString.getFormatPara(oneMap.get("total"))+"&lt;BR&gt;排名:"+(j+1)+"'/>") ;
				}
				xml.append("</dataset>") ;
				xml.append("<styles><definition><style name='myHTMLFont' type='font' isHTML='1' /></definition><application><apply toObject='TOOLTIP' styles='myHTMLFont' /></application></styles>") ;
			}
			xml.append("</chart>") ;
		}
		if("ding_gou_pai_ming_machine".equals(flag)){ //  订单机型排名
			String iftag = CommonString.getFormatPara(request.getParameter("if_tag")) ; //
			xml.append("<chart palette='2' labelDisplay='Stagger' staggerLines='2' caption='机型订单排名' decimals='0' useRoundEdges='1' legendBorderAlpha='0' formatNumberScale='0' baseFont='微软雅黑' baseFontSize='12'>");
			if("0".equals(iftag)||"".equals(iftag)){
			String sel_sql = " select top 100 cataname,count(*) total from pro_product_form where cataname is not null and cataname<>''group by cataname order by total desc " ;
			List<Map> dingdanList = new ArrayList() ;
			dingdanList = dbHelper.getMapList(sel_sql,connection) ;
			if(null!=dingdanList && dingdanList.size()>0){
				xml.append("<categories>") ;
				Map myMap = new HashMap() ;
				for(int i=0;i<dingdanList.size();i++){  
					myMap = dingdanList.get(i) ;
					xml.append("<category label='"+(CommonString.getFormatPara(myMap.get("cataname")).length()<=4?CommonString.getFormatPara(myMap.get("cataname")):CommonString.getFormatPara(myMap.get("cataname")).substring(0,4))+"' />") ;
				}
				xml.append("</categories>") ;
				xml.append("<dataset seriesName='订单数量(机型)' color='7171C6' showValues='1' >") ;
				for(int j=0;j<dingdanList.size();j++){  
					Map oneMap = dingdanList.get(j) ;
					StringBuffer sbf = new StringBuffer("") ;
					for(int i=0;i<6;i++){
						sbf.append(base_e.charAt(random.nextInt(base_e.length()))) ;
					}
					xml.append("<set color='"+sbf.toString()+"' value='"+CommonString.getFormatPara(oneMap.get("total"))+"' tooltext='名称:"+CommonString.getFormatPara(oneMap.get("cataname"))+"&lt;BR&gt;数量: "+CommonString.getFormatPara(oneMap.get("total"))+"&lt;BR&gt;排名:"+(j+1)+"'/>") ;
				}
				xml.append("</dataset>") ;
				xml.append("<styles><definition><style name='myHTMLFont' type='font' isHTML='1' /></definition><application><apply toObject='TOOLTIP' styles='myHTMLFont' /></application></styles>") ;
			}
		}
			if("1".equals(iftag)){ // 1级类别
				String sel_sql = " select name,num from pro_catalog where len(num)=3" ;
			    List<Map> catalogList = dbHelper.getMapList(sel_sql,connection) ;
				xml.append("<categories>") ;
				for(Map oneMap:catalogList){
					xml.append("<category label='"+CommonString.getFormatPara(oneMap.get("name"))+"' />") ;
				}
				xml.append("</categories>") ;
				xml.append("<dataset seriesName='订单数量(机型)' color='7171C6' showValues='1' >") ;
				for(Map oneMap:catalogList){
					String sel_sql2 = " select count(*) as total from pro_product_form where catanum like '"+oneMap.get("num")+"%'" ;
					Map myMap = dbHelper.getMap(sel_sql2,connection) ;
					StringBuffer sbf = new StringBuffer("") ;
					for(int i=0;i<6;i++){
						sbf.append(base_e.charAt(random.nextInt(base_e.length()))) ;
					}
					xml.append("<set color='"+sbf.toString()+"' value='"+CommonString.getFormatPara(myMap.get("total"))+"' tooltext='名称:"+CommonString.getFormatPara(oneMap.get("name"))+"&lt;BR&gt;数量: "+CommonString.getFormatPara(myMap.get("total"))+"'/>") ;
				}
				xml.append("</dataset>") ;
				xml.append("<styles><definition><style name='myHTMLFont' type='font' isHTML='1' /></definition><application><apply toObject='TOOLTIP' styles='myHTMLFont' /></application></styles>") ;
			}
			if("2".equals(iftag)){ // 2级类别
				String sel_sql = " select name,num from pro_catalog where len(num)=6" ;
			    List<Map> catalogList = dbHelper.getMapList(sel_sql,connection) ;
				xml.append("<categories>") ;
				for(Map oneMap:catalogList){
					xml.append("<category label='"+CommonString.getFormatPara(oneMap.get("name"))+"' />") ;
				}
				xml.append("</categories>") ;
				xml.append("<dataset seriesName='订单数量(机型)' color='7171C6' showValues='1' >") ;
				for(Map oneMap:catalogList){
					String sel_sql2 = " select count(*) as total from pro_product_form where catanum like '"+oneMap.get("num")+"%'" ;
					Map myMap = dbHelper.getMap(sel_sql2,connection) ;
					StringBuffer sbf = new StringBuffer("") ;
					for(int i=0;i<6;i++){
						sbf.append(base_e.charAt(random.nextInt(base_e.length()))) ;
					}
					xml.append("<set color='"+sbf.toString()+"' value='"+CommonString.getFormatPara(myMap.get("total"))+"' tooltext='名称:"+CommonString.getFormatPara(oneMap.get("name"))+"&lt;BR&gt;数量: "+CommonString.getFormatPara(myMap.get("total"))+"'/>") ;
				}
				xml.append("</dataset>") ;
				xml.append("<styles><definition><style name='myHTMLFont' type='font' isHTML='1' /></definition><application><apply toObject='TOOLTIP' styles='myHTMLFont' /></application></styles>") ;
			}
			if("3".equals(iftag)){ // 2级类别
				String sel_sql = " select name,num from pro_catalog where len(num)=9" ;
			    List<Map> catalogList = dbHelper.getMapList(sel_sql,connection) ;
				xml.append("<categories>") ;
				for(Map oneMap:catalogList){
					xml.append("<category label='"+CommonString.getFormatPara(oneMap.get("name"))+"' />") ;
				}
				xml.append("</categories>") ;
				xml.append("<dataset seriesName='订单数量(机型)' color='7171C6' showValues='1' >") ;
				for(Map oneMap:catalogList){
					String sel_sql2 = " select count(*) as total from pro_product_form where catanum like '"+oneMap.get("num")+"%'" ;
					Map myMap = dbHelper.getMap(sel_sql2,connection) ;
					StringBuffer sbf = new StringBuffer("") ;
					for(int i=0;i<6;i++){
						sbf.append(base_e.charAt(random.nextInt(base_e.length()))) ;
					}
					xml.append("<set color='"+sbf.toString()+"' value='"+CommonString.getFormatPara(myMap.get("total"))+"' tooltext='名称:"+CommonString.getFormatPara(oneMap.get("name"))+"&lt;BR&gt;数量: "+CommonString.getFormatPara(myMap.get("total"))+"'/>") ;
				}
				xml.append("</dataset>") ;
				xml.append("<styles><definition><style name='myHTMLFont' type='font' isHTML='1' /></definition><application><apply toObject='TOOLTIP' styles='myHTMLFont' /></application></styles>") ;
			}
			xml.append("</chart>") ;
		}
		// 订单详情
		if("ding_dan_xiang_qing_jixing".equals(flag)){ // 机型
			String total_sql = " select count(*) total from pro_product_form" ;
	    	String wajueji_sql = " select count(*) total from pro_product_form where catanum like '101001%'" ; // 挖掘机订单数量
	    	String zhuangzaiji_sql = " select count(*) total from pro_product_form where catanum like '101002%'" ; // 装载机订单数量 
	    	String yaluji_sql = " select count(*) total from pro_product_form where catanum like '106001%'" ; // 压路机
			String qizhongji_sql = "select count(*) total from pro_product_form where (catanum like '102013%' or catanum like '102002%' or catanum like '102008%' or catanum like '102006%' or catanum like '102007%')" ; // 起重机
			String bengche_sql = " select count(*) total from pro_product_form where catanum like '103001%'" ; // 泵车
			String pingdiji_sql = " select count(*) total from pro_product_form where catanum like '101005%'" ; // 平地机
			String tanpu_sql = " select count(*) total from pro_product_form where catanum like '104001%'" ; // 摊铺机
			String xuanwazhuanji_sql = " select count(*) total from pro_product_form where catanum like '105003%'" ; // 旋挖转机
			String jiaobanji_sql = " select count(*) total from pro_product_form where (catanum = '103002001' or catanum ='104004005')" ; // 搅拌机机
			String xianpaoji_sql = " select count(*) total from pro_product_form where catanum like '104005%'" ; // 铣刨机
			Integer total = Integer.parseInt(dbHelper.getMap(total_sql,connection).get("total").toString()) ;
			Integer wajueji = Integer.parseInt(dbHelper.getMap(wajueji_sql,connection).get("total").toString()) ;
			Integer zhuangzaiji = Integer.parseInt(dbHelper.getMap(zhuangzaiji_sql,connection).get("total").toString()) ;
			Integer yaluji = Integer.parseInt(dbHelper.getMap(yaluji_sql,connection).get("total").toString()) ;
			Integer qizhongji = Integer.parseInt(dbHelper.getMap(qizhongji_sql,connection).get("total").toString()) ;
			Integer bengche = Integer.parseInt(dbHelper.getMap(bengche_sql,connection).get("total").toString()) ;
			Integer pingdiji = Integer.parseInt(dbHelper.getMap(pingdiji_sql,connection).get("total").toString()) ;
			Integer tanpu = Integer.parseInt(dbHelper.getMap(tanpu_sql,connection).get("total").toString()) ;
			Integer xuanwazhuanji = Integer.parseInt(dbHelper.getMap(xuanwazhuanji_sql,connection).get("total").toString()) ;
			Integer jiaobanji = Integer.parseInt(dbHelper.getMap(jiaobanji_sql,connection).get("total").toString()) ;
			Integer xianpaoji = Integer.parseInt(dbHelper.getMap(xianpaoji_sql,connection).get("total").toString()) ;
			int other = (total-(wajueji+zhuangzaiji+yaluji+qizhongji+bengche+pingdiji+tanpu+xuanwazhuanji+jiaobanji+xianpaoji)) ;
			xml.append("<chart palette='6' caption='订单详情（机型）'  decimals='0' bgColor='CCCCCC,FFFFFF' bgAlpha='40,100' bgRatio='0,100' bgAngle='360' useRoundEdges='1' legendBorderAlpha='0' formatNumberScale='0' baseFont='微软雅黑' baseFontSize='12'>") ;
		    xml.append("<set label='挖掘机' value='"+wajueji+"'/>") ;
		    xml.append("<set label='装载机' value='"+zhuangzaiji+"'/>") ;
		    xml.append("<set label='压路机' value='"+yaluji+"'/>") ;
		    xml.append("<set label='起重机' value='"+qizhongji+"'/>") ;
		    xml.append("<set label='泵车' value='"+bengche+"'/>") ;
		    xml.append("<set label='平地机' value='"+pingdiji+"'/>") ;
		    xml.append("<set label='摊铺机' value='"+tanpu+"'/>") ;
		    xml.append("<set label='旋挖转机' value='"+xuanwazhuanji+"'/>") ;
		    xml.append("<set label='搅拌机' value='"+jiaobanji+"'/>") ;
		    xml.append("<set label='铣刨机' value='"+xianpaoji+"'/>") ;
		    xml.append("<set label='其它' value='"+other+"' />") ;
		    xml.append("</chart>") ;
		}
		if("ding_dan_xiang_qing_agent".equals(flag)){ // 代理商
			String sel_sql = " select top 20 agentname,count(*) total from pro_product_form where agentid is not null and agentid<>0 group by agentname order by total desc " ;
			String total_sql = " select count(*) total from pro_product_form where agentid is not null and agentid<>0" ;
		    List<Map> agentList = dbHelper.getMapList(sel_sql,connection) ;
			xml.append("<chart palette='6' caption='订单详情（代理商）' decimals='0' bgColor='CCCCCC,FFFFFF' bgAlpha='40,100' bgRatio='0,100' bgAngle='360' useRoundEdges='1' legendBorderAlpha='0' formatNumberScale='0' baseFont='微软雅黑' baseFontSize='12'>") ;
			if(null!=agentList && agentList.size()>0){
				for(Map oneMap:agentList){
					xml.append("<set label='"+CommonString.getFormatPara(oneMap.get("agentname"))+"' value='"+CommonString.getFormatPara(oneMap.get("total"))+"'/>") ;
				}
			}
		    xml.append("<set label='其它' value='"+Integer.parseInt(dbHelper.getOne(total_sql,connection).toString())+"'/>") ;
		    xml.append("</chart>") ;
		}
		if("ding_dan_xiang_qing_brand".equals(flag)){
			String sel_sql = " select top 10 factoryname,count(*) total from pro_product_form group by factoryname order by total desc " ;
			String get_sql = " select sum(total) total from (select top 10 factoryname,count(*) total from pro_product_form group by factoryname order by total desc) as a" ;
			String total_sql = " select count(*) total from pro_product_form" ;
			List<Map> areaList = dbHelper.getMapList(sel_sql,connection) ;
			if(null!=areaList && areaList.size()>0){
				xml.append("<chart palette='6' caption='订单详情（区域）'  decimals='0' bgColor='CCCCCC,FFFFFF' bgAlpha='40,100' bgRatio='0,100' bgAngle='360' useRoundEdges='1' legendBorderAlpha='0' formatNumberScale='0' baseFont='微软雅黑' baseFontSize='12'>") ;
				for(Map oneMap:areaList){
					xml.append("<set label='"+CommonString.getFormatPara(oneMap.get("factoryname"))+"' value='"+CommonString.getFormatPara(oneMap.get("total"))+"' />") ;
				}
				xml.append("<set label='其它' value='"+(Integer.parseInt(CommonString.getFormatPara(dbHelper.getMap(total_sql,connection).get("total")))-Integer.parseInt(CommonString.getFormatPara(dbHelper.getMap(get_sql,connection).get("total"))))+"' />") ;
				xml.append("</chart>") ;
			}
		}
		// 代理商排名
		if("agent_paiming_news".equals(flag)){ // 登录次数
			String sel_sql = " select top 100 name,login_count as total from pro_agent_factory where flag=2 and login_count is not null and login_count<>0 and login_count<>'' order by login_count desc " ;
			 //  订单品牌排名
			List<Map> dingdanList = new ArrayList() ;
			dingdanList = dbHelper.getMapList(sel_sql,connection) ;
			xml.append("<chart palette='2' labelDisplay='Stagger' staggerLines='2' caption='代理商排名(新闻发布量)' decimals='0' useRoundEdges='1' legendBorderAlpha='0' formatNumberScale='0' baseFont='微软雅黑' baseFontSize='12'>");
			if(null!=dingdanList && dingdanList.size()>0){
				xml.append("<categories>") ;
				Map myMap = new HashMap() ;
				for(int i=0;i<dingdanList.size();i++){  
					myMap = dingdanList.get(i) ;
					xml.append("<category label='"+CommonString.getFormatPara(myMap.get("name"))+"' />") ;
				}
				xml.append("</categories>") ;
				xml.append("<dataset seriesName='代理商排名(新闻发布量)' color='F6BD0F' showValues='1'>") ;
				for(int j=0;j<dingdanList.size();j++){  
					Map oneMap = dingdanList.get(j) ;
					StringBuffer sbf = new StringBuffer("") ;
					for(int i=0;i<6;i++){
						sbf.append(base_e.charAt(random.nextInt(base_e.length()))) ;
					}
					xml.append("<set color='"+sbf.toString()+"' value='"+CommonString.getFormatPara(oneMap.get("total"))+"' tooltext='品牌:"+CommonString.getFormatPara(oneMap.get("name"))+"&lt;BR&gt;数量: "+CommonString.getFormatPara(oneMap.get("total"))+"&lt;BR&gt;排名:"+(j+1)+"'/>") ;
				}
				xml.append("</dataset>") ;
			}
			xml.append("<styles><definition><style name='myHTMLFont' type='font' isHTML='1' /></definition><application><apply toObject='TOOLTIP' styles='myHTMLFont' /></application></styles>") ;
			xml.append("</chart>") ;
		}
		if("agent_paiming_login_count".equals(flag)){ // 登录次数
			String sel_sql = " select top 100 name,login_count as total from pro_agent_factory where flag=2 and login_count is not null and login_count<>0 and login_count<>'' order by login_count desc " ;
			 //  订单品牌排名
			List<Map> dingdanList = new ArrayList() ;
			dingdanList = dbHelper.getMapList(sel_sql,connection) ;
			xml.append("<chart palette='2' labelDisplay='Stagger' staggerLines='2' caption='代理商排名(登录次数)' decimals='0' useRoundEdges='1' legendBorderAlpha='0' formatNumberScale='0' baseFont='微软雅黑' baseFontSize='12'>");
			if(null!=dingdanList && dingdanList.size()>0){
				xml.append("<categories>") ;
				Map myMap = new HashMap() ;
				for(int i=0;i<dingdanList.size();i++){  
					myMap = dingdanList.get(i) ;
					xml.append("<category label='"+CommonString.getFormatPara(myMap.get("name"))+"' />") ;
				}
				xml.append("</categories>") ;
				xml.append("<dataset seriesName='代理商排名(登录次数)' color='F6BD0F' showValues='1'>") ;
				for(int j=0;j<dingdanList.size();j++){  
					Map oneMap = dingdanList.get(j) ;
					StringBuffer sbf = new StringBuffer("") ;
					for(int i=0;i<6;i++){
						sbf.append(base_e.charAt(random.nextInt(base_e.length()))) ;
					}
					xml.append("<set color='"+sbf.toString()+"' value='"+CommonString.getFormatPara(oneMap.get("total"))+"' tooltext='"+CommonString.getFormatPara(oneMap.get("name"))+"&lt;BR&gt;登录次数: "+CommonString.getFormatPara(oneMap.get("total"))+"&lt;BR&gt;排名:"+(j+1)+"'/>") ;
				}
				xml.append("</dataset>") ;
			}
			xml.append("<styles><definition><style name='myHTMLFont' type='font' isHTML='1' /></definition><application><apply toObject='TOOLTIP' styles='myHTMLFont' /></application></styles>") ;
			xml.append("</chart>") ;
		}
		if("agent_paiming_telphone".equals(flag)){ // 电话
			 //  电话查看量排名
			String sel_sql = " select view_phone_click_count,name from pro_agent_factory where view_phone_click_count is not null and flag=2 order by view_phone_click_count desc " ;
			List<Map> dingdanList = new ArrayList() ;
			dingdanList = dbHelper.getMapList(sel_sql,connection) ;
			xml.append("<chart palette='2' labelDisplay='Stagger' staggerLines='2' caption='代理商排名(电话查看量)' decimals='0' useRoundEdges='1' legendBorderAlpha='0' formatNumberScale='0' baseFont='微软雅黑' baseFontSize='12'>");
			if(null!=dingdanList && dingdanList.size()>0){
				xml.append("<categories>") ;
				Map myMap = new HashMap() ;
				for(int i=0;i<dingdanList.size();i++){  
					myMap = dingdanList.get(i) ;
					xml.append("<category label='"+(CommonString.getFormatPara(myMap.get("name")).length()>4?CommonString.getFormatPara(myMap.get("name")).substring(0,4)+"...":CommonString.getFormatPara(myMap.get("name")))+"' />") ;
				}
				xml.append("</categories>") ;
				xml.append("<dataset seriesName='代理商排名(电话查看量)' color='A020F0' showValues='1'>") ;
				for(int j=0;j<dingdanList.size();j++){  
					Map oneMap = dingdanList.get(j) ;
					StringBuffer sbf = new StringBuffer("") ;
					for(int i=0;i<6;i++){
						sbf.append(base_e.charAt(random.nextInt(base_e.length()))) ;
					}
					xml.append("<set color='"+sbf.toString()+"' value='"+CommonString.getFormatPara(oneMap.get("view_phone_click_count"))+"' tooltext='"+CommonString.getFormatPara(oneMap.get("name"))+"&lt;BR&gt;电话查看量: "+CommonString.getFormatPara(oneMap.get("view_phone_click_count"))+"&lt;BR&gt;排名:"+(j+1)+"'/>") ;
				}
				xml.append("</dataset>") ;
			}
			xml.append("<styles><definition><style name='myHTMLFont' type='font' isHTML='1' /></definition><application><apply toObject='TOOLTIP' styles='myHTMLFont' /></application></styles>") ;
			xml.append("</chart>") ;
		
		
		}
		// 访问量排名
		if("fang_wen_liang_agent".equals(flag)){  // 代理商
			String sel_sql = " select name,full_name,view_count from pro_agent_factory where flag=2 and view_count is not null and view_count<> 0 order by view_count desc " ;
			List<Map> dingdanList = new ArrayList() ;
			dingdanList = dbHelper.getMapList(sel_sql,connection) ;
			xml.append("<chart palette='2' labelDisplay='Stagger' staggerLines='2' caption='访问量排名(代理商)' decimals='0' useRoundEdges='1' legendBorderAlpha='0' formatNumberScale='0' baseFont='微软雅黑' baseFontSize='12'>");
			if(null!=dingdanList && dingdanList.size()>0){
				xml.append("<categories>") ;
				Map myMap = new HashMap() ;
				for(int i=0;i<dingdanList.size();i++){  
					myMap = dingdanList.get(i) ;
					xml.append("<category label='"+CommonString.getFormatPara(myMap.get("name"))+"' />") ;
				}
				xml.append("</categories>") ;
				xml.append("<dataset seriesName='访问量排名(代理商)' color='A020F0' showValues='1'>") ;
				for(int j=0;j<dingdanList.size();j++){  
					Map oneMap = dingdanList.get(j) ;
					StringBuffer sbf = new StringBuffer("") ;
					for(int i=0;i<6;i++){
						sbf.append(base_e.charAt(random.nextInt(base_e.length()))) ;
					}
					xml.append("<set color='"+sbf.toString()+"' value='"+CommonString.getFormatPara(oneMap.get("view_count"))+"' tooltext='代理商:"+CommonString.getFormatPara(oneMap.get("full_name"))+"&lt;BR&gt;访问量: "+CommonString.getFormatPara(oneMap.get("view_count"))+"&lt;BR&gt;排名:"+(j+1)+"'/>") ;
				}
				xml.append("</dataset>") ;
			}
			xml.append("<styles><definition><style name='myHTMLFont' type='font' isHTML='1' /></definition><application><apply toObject='TOOLTIP' styles='myHTMLFont' /></application></styles>") ;
			xml.append("</chart>") ;
		}
		if("fang_wen_liang_brand".equals(flag)){  // 品牌
			String sel_sql = " select name,full_name,view_count from pro_agent_factory where flag=1 and view_count is not null and view_count<> 0 order by view_count desc " ;
			List<Map> dingdanList = new ArrayList() ;
			dingdanList = dbHelper.getMapList(sel_sql,connection) ;
			xml.append("<chart palette='2' labelDisplay='Stagger' staggerLines='2' labelDisplay='Rotate' slantLabels='1'caption='访问量排名(品牌)' decimals='0' useRoundEdges='1' legendBorderAlpha='0' formatNumberScale='0' baseFont='微软雅黑' baseFontSize='12'>");
			if(null!=dingdanList && dingdanList.size()>0){
				xml.append("<categories>") ;
				Map myMap = new HashMap() ;
				for(int i=0;i<dingdanList.size();i++){  
					myMap = dingdanList.get(i) ;
					xml.append("<category label='"+CommonString.getFormatPara(myMap.get("name"))+"' />") ;
				}
				xml.append("</categories>") ;
				xml.append("<dataset seriesName='访问量排名(品牌)' color='949494' showValues='1'>") ;
				for(int j=0;j<dingdanList.size();j++){  
					StringBuffer sbf = new StringBuffer("") ;
					for(int i=0;i<6;i++){
						sbf.append(base_e.charAt(random.nextInt(base_e.length()))) ;
					}
					Map oneMap = dingdanList.get(j) ;
					xml.append("<set color='"+sbf.toString()+"' value='"+CommonString.getFormatPara(oneMap.get("view_count"))+"' tooltext='品牌:"+CommonString.getFormatPara(oneMap.get("full_name"))+"&lt;BR&gt;访问量: "+CommonString.getFormatPara(oneMap.get("view_count"))+"&lt;BR&gt;'/>") ;
				}
				xml.append("</dataset>") ;
				xml.append("<styles><definition><style name='myHTMLFont' type='font' isHTML='1' /></definition><application><apply toObject='TOOLTIP' styles='myHTMLFont' /></application></styles>") ;
			}
			xml.append("<styles><definition><style name='myHTMLFont' type='font' isHTML='1' /></definition><application><apply toObject='TOOLTIP' styles='myHTMLFont' /></application></styles>") ;
			xml.append("</chart>") ;
		}
		if("fang_wen_liang_product".equals(flag)){  // 产品
			String sel_sql = " select top 1000 factoryname,catalogname,name,view_count from pro_products where view_count>0 order by view_count desc " ;
			List<Map> dingdanList = new ArrayList() ;
			dingdanList = dbHelper.getMapList(sel_sql,connection) ;
			xml.append("<chart palette='2' labelDisplay='Stagger' staggerLines='2' caption='访问量排名(产品)' decimals='0' useRoundEdges='1' legendBorderAlpha='0' formatNumberScale='0' baseFont='微软雅黑' baseFontSize='12'>");
			if(null!=dingdanList && dingdanList.size()>0){ 
				xml.append("<categories>") ;
				Map myMap = new HashMap() ; 
				for(int i=0;i<dingdanList.size();i++){  
					myMap = dingdanList.get(i) ;
					xml.append("<category label='"+CommonString.getFormatPara(myMap.get("name"))+"' />") ;
				}
				xml.append("</categories>") ;
				xml.append("<dataset seriesName='访问量排名(产品)' color='8B8B00' showValues='1'>") ;
				for(int j=0;j<dingdanList.size();j++){  
					Map oneMap = dingdanList.get(j) ;
					StringBuffer sbf = new StringBuffer("") ;
					for(int i=0;i<6;i++){
						sbf.append(base_e.charAt(random.nextInt(base_e.length()))) ;
					}
					xml.append("<set color='"+sbf.toString()+"' value='"+CommonString.getFormatPara(oneMap.get("view_count"))+"' tooltext='品牌:"+CommonString.getFormatPara(oneMap.get("factoryname"))+"&lt;BR&gt;类别:"+CommonString.getFormatPara(oneMap.get("catalogname"))+"&lt;BR&gt;机型:"+CommonString.getFormatPara(oneMap.get("name"))+"&lt;BR&gt;访问量: "+CommonString.getFormatPara(oneMap.get("view_count"))+"&lt;BR&gt;排名:"+(j+1)+"'/>") ;
				}
				xml.append("</dataset>") ;
			}
			xml.append("<styles><definition><style name='myHTMLFont' type='font' isHTML='1' /></definition><application><apply toObject='TOOLTIP' styles='myHTMLFont' /></application></styles>") ;
			xml.append("</chart>") ;
		}
		if("fang_wen_liang_machine".equals(flag)){  // 机型
			String sel_sql = " select sum(view_count) view_count,catalogname  from pro_products where catalognum<>'' and catalogname<>'' and len(catalognum)=9 and view_count>1000 group by catalogname ,catalognum order by view_count desc " ;
			List<Map> dingdanList = new ArrayList() ;
			dingdanList = dbHelper.getMapList(sel_sql,connection) ;
			xml.append("<chart palette='2' caption='访问量排名(机型)' decimals='0' bgColor='CCCCCC,FFFFFF' bgAlpha='40,100' bgRatio='0,100' bgAngle='360' useRoundEdges='1' legendBorderAlpha='0' formatNumberScale='0' baseFont='微软雅黑' baseFontSize='12'>");
			if(null!=dingdanList && dingdanList.size()>0){
				for(int j=0;j<dingdanList.size();j++){  
					Map oneMap = dingdanList.get(j) ;
					StringBuffer sbf = new StringBuffer("") ;
					for(int i=0;i<6;i++){
						sbf.append(base_e.charAt(random.nextInt(base_e.length()))) ;
					}
					xml.append("<set label='"+CommonString.getFormatPara(oneMap.get("catalogname"))+"' color='"+sbf.toString()+"' value='"+CommonString.getFormatPara(oneMap.get("view_count"))+"'/>") ;
				}
			}
			xml.append("<styles><definition><style name='myHTMLFont' type='font' isHTML='1' /></definition><application><apply toObject='TOOLTIP' styles='myHTMLFont' /></application></styles>") ;
			xml.append("</chart>") ;
		}
		if("agent_chan_pin_shai_xuan".equals(flag)){
			sql = " SELECT pcpvh.id,isnull(paf.name,'') factory,isnull(pc.name,'') catalog, ";
			sql += " pcpvh.tonandmeter,pcpvh.offset,pcpvh.counts FROM ";
			sql += " pro_customer_product_view_habit pcpvh ";
			sql += " LEFT JOIN pro_agent_factory paf ON pcpvh.factory = paf.id ";
			sql += " LEFT JOIN pro_catalog pc ON pcpvh.catalog = pc.num ";
			sql += " WHERE pcpvh.counts > 10 ";
			sql += " ORDER BY pcpvh.counts DESC ";
			List<Map> list = dbHelper.getMapList(sql,connection);
			Map dun_wei_map = new HashMap();
			dun_wei_map.put("grab_1_13","小挖(1T~13T)");
			dun_wei_map.put("grab_14_30","中挖(14T~30T)");
			dun_wei_map.put("grab_30_1","大挖(30T以上)");
			dun_wei_map.put("loader_1_3","3T以下");
			dun_wei_map.put("loader_3_01","3T");
			dun_wei_map.put("loader_3_5","3T~5T");
			dun_wei_map.put("crane_1_16","16T以下");
			dun_wei_map.put("crane_20_70","20T~70T");
			dun_wei_map.put("crane_70_1","70T以上");
			xml.append("<chart palette='2' caption='产品列表页条件筛选次数' shownames='1' showvalues='0' useRoundEdges='1' legendBorderAlpha='0' baseFont='微软雅黑' baseFontSize='12'>");
			if(null!=list&&list.size()>0){
				xml.append("<categories>");
				for(Map m : list){
					xml.append("<category label='"+CommonString.getFormatPara(m.get("counts"))+"' />");
				}
				xml.append("</categories>");
				xml.append("<dataset color='AFD8F8' showValues='0'>");
				int i = 0;
				String name = "";
				for(Map m : list){
					name = "";
					name += "品牌："+CommonString.getFormatPara(m.get("factory"))+"\r";
					name += "机型："+CommonString.getFormatPara(m.get("catalog"))+"\r";
					name += "吨位："+CommonString.getFormatPara(dun_wei_map.get(CommonString.getFormatPara(m.get("tonandmeter"))))+"\r";
					name += "偏移："+CommonString.getFormatPara(m.get("offset"))+"\r";
					name += "次数："+CommonString.getFormatPara(m.get("counts"));
					if(i%2==0){
						xml.append("<set color='F6BD0F' toolText='"+name+"' value='"+CommonString.getFormatPara(m.get("counts"))+"'/>");
					}else{
						xml.append("<set color='8BBA00' toolText='"+name+"' value='"+CommonString.getFormatPara(m.get("counts"))+"'/>");
					}
					i++;
				}
				xml.append("</dataset>");
			}
			xml.append("</chart>");
		}
		if("agent_xin_wen_liu_lan_province".equals(flag)){
			List<String> provinces = new ArrayList<String>();
			provinces.add("安徽");
			provinces.add("北京");
			provinces.add("重庆");
			provinces.add("福建");
			provinces.add("甘肃");
			provinces.add("广东");
			provinces.add("广西");
			provinces.add("贵州");
			provinces.add("海南");
			provinces.add("河北");
			provinces.add("黑龙江");
			provinces.add("河南");
			provinces.add("湖北");
			provinces.add("湖南");
			provinces.add("内蒙古");
			provinces.add("江苏");
			provinces.add("江西");
			provinces.add("吉林");
			provinces.add("辽宁");
			provinces.add("宁夏");
			provinces.add("青海");
			provinces.add("山西");
			provinces.add("山东");
			provinces.add("上海");
			provinces.add("四川");
			provinces.add("天津");
			provinces.add("西藏");
			provinces.add("新疆");
			provinces.add("云南");
			provinces.add("浙江");
			provinces.add("陕西");
			provinces.add("台湾");
			provinces.add("香港");
			provinces.add("澳门");
			xml.append("<chart caption='各省份新闻浏览次数' palette='4' baseFont='微软雅黑' baseFontSize='12'>");
			Integer counts = 0;
			for(String p : provinces){
				sql = " SELECT isnull(sum(pgn.view_count),0) AS counts ";
				sql += " FROM pro_agent_news pgn , pro_agent_factory paf ";
				sql += " WHERE pgn.agent_id = paf.id AND paf.city LIKE '%"+p+"%' ";
				counts = (Integer)dbHelper.getOne(sql,connection);
				xml.append("<set label='"+p+"' value='"+counts+"' /> ");
			}
			xml.append("</chart>");
		}
		if("agent_xin_wen_liu_lan_agent".equals(flag)){
			sql = " SELECT paf.full_name,sum(pgn.view_count) view_count FROM ";
			sql += " pro_agent_news pgn , pro_agent_factory paf ";
			sql += " WHERE pgn.agent_id = paf.id ";
			sql += " GROUP BY paf.full_name ";
			sql += " ORDER BY sum(pgn.view_count) DESC ";
			List<Map> list = dbHelper.getMapList(sql,connection);
			xml.append("<chart palette='2' caption='County Comparison' shownames='1' showvalues='0' useRoundEdges='1' legendBorderAlpha='0'>");
			if(null!=list&&list.size()>0){
				xml.append("<categories>");
				for(Map m : list){
					xml.append("<category label='"+CommonString.getFormatPara(m.get("full_name"))+"' />");
				}
				xml.append("</categories>");
				xml.append("<dataset color='AFD8F8' showValues='0'>");
				for(Map m : list){
					xml.append("<set value='"+CommonString.getFormatPara(m.get("view_count"))+"' />");
				}
				xml.append("</dataset>");
			}
			xml.append("</chart>");
		}
		// 订单趋势
		if("ding_dan_qu_shi_province".equals(flag)){
			String province = URLDecoder.decode(CommonString.getFormatPara(request.getParameter("province"))) ; // 省份
			StringBuffer subcaption = new StringBuffer("") ;
			if("".equals(province)){ // 默认为山东
		// 		province = "山东" ;
			}
			subcaption.append(province) ;
			String year = CommonString.getFormatPara(request.getParameter("year")) ; // 年份
			if("".equals(year)){
				year = "2013" ;
			}
			subcaption.append(year).append("年") ;
			String month = CommonString.getFormatPara(request.getParameter("month")) ;
			if(!"".equals(month)){
				subcaption.append(month).append("月份") ;
			}
			String hour = CommonString.getFormatPara(request.getParameter(("hour"))) ;
			if(!"".equals(hour)){
				subcaption.append(hour).append("号") ;
			}
			subcaption.append("订单趋势") ;
			// String subcaption = province+year+month+hour+"订单趋势" ;
			xml.append("<chart caption='订单趋势(省份)' subcaption='"+subcaption.toString()+"' xAxisName=''  yAxisMinValue='10'  showValues='1' formatNumberScale='0' alternateHGridColor='FCB541' alternateHGridAlpha='20' divLineColor='FCB541' divLineAlpha='50' canvasBorderColor='666666' baseFontColor='666666' lineColor='FCB541' baseFont='微软雅黑' baseFontSize='14'>") ;
			String sel_sql = " select count(*) total from pro_product_form " ;
			StringBuffer whereStr = new StringBuffer(" where 1=1 ") ;
			if(!"".equals(province)){
				whereStr.append(" and province like '"+province+"%'") ;
			}
			if(!"".equals(year)){
				whereStr.append(" and year(add_date)="+year) ;
			}
			if(!"".equals(month)){
				whereStr.append(" and month(add_date)="+month) ;
			}
			Map oneMap = null ;
			for(int i=1;i<=12&&"".equals(month);i++){ // 全年
				if("".equals(month)){
					oneMap = dbHelper.getMap(sel_sql+whereStr.toString()+" and month(add_date)=?",new Object[]{i},connection) ;
				}
				xml.append("<set label='"+i+"月' value='"+CommonString.getFormatPara(oneMap.get("total"))+"'/>") ;
			}
			for(int i=1;"".equals(hour)&&!"".equals(month)&&i<=1;i++){ // 全月
					oneMap = dbHelper.getMap(sel_sql+whereStr.toString()+" and day(add_date)=?",new Object[]{i},connection) ;
				xml.append("<set label='"+i+"号' value='"+CommonString.getFormatPara(oneMap.get("total"))+"'/>") ;
			}
			for(int i=1;!"".equals(hour)&&i<=24;i++){ // 全日
					oneMap = dbHelper.getMap(sel_sql+whereStr.toString()+" and datepart(dd,add_date)=? and datepart(hh,add_date)=?",new Object[]{hour,i},connection) ;
				xml.append("<set label='"+i+"时' value='"+CommonString.getFormatPara(oneMap.get("total"))+"'/>") ;
			}
			xml.append("</chart>") ;
		}
		if("ding_dan_qu_shi_agent".equals(flag)){ // 代理商
			String agent = CommonString.getFormatPara(request.getParameter("agent")) ; // 代理商
			String agentname = CommonString.getFormatPara(request.getParameter("agentname")) ;
			StringBuffer subcaption = new StringBuffer("") ;
			if("".equals(agent)){ // 默认为山东
		// 		province = "山东" ;
			}
			subcaption.append("".equals(agentname)?"全部":agentname) ;
			String year = CommonString.getFormatPara(request.getParameter("year")) ; // 年份
			if("".equals(year)){
				year = "2013" ;
			}
			subcaption.append(year).append("年") ;
			String month = CommonString.getFormatPara(request.getParameter("month")) ;
			if(!"".equals(month)){
				subcaption.append(month).append("月份") ;
			}
			String hour = CommonString.getFormatPara(request.getParameter(("hour"))) ;
			if(!"".equals(hour)){
				subcaption.append(hour).append("号") ;
			}
			subcaption.append("订单趋势") ;
			// String subcaption = province+year+month+hour+"订单趋势" ;
			xml.append("<chart caption='订单趋势(代理商)' subcaption='"+subcaption.toString()+"' xAxisName=''  yAxisMinValue='10'  showValues='1' formatNumberScale='0' alternateHGridColor='FCB541' alternateHGridAlpha='20' divLineColor='FCB541' divLineAlpha='50' canvasBorderColor='666666' baseFontColor='666666' lineColor='FCB541' baseFont='微软雅黑' baseFontSize='14'>") ;
			String sel_sql = " select count(*) total from pro_product_form " ;
			StringBuffer whereStr = new StringBuffer(" where 1=1 and agentid is not null and agentid<>'' ") ;
			if(!"".equals(agent)){
				whereStr.append(" and agentid ='"+agent+"'") ;
			}
			if(!"".equals(year)){
				whereStr.append(" and year(add_date)="+year) ;
			}
			if(!"".equals(month)){
				whereStr.append(" and month(add_date)="+month) ;
			}
			Map oneMap = null ;
			for(int i=1;i<=12&&"".equals(month);i++){ // 全年
				if("".equals(month)){
					oneMap = dbHelper.getMap(sel_sql+whereStr.toString()+" and month(add_date)=?",new Object[]{i},connection) ;
				}
				xml.append("<set label='"+i+"月' value='"+CommonString.getFormatPara(oneMap.get("total"))+"'/>") ;
			}
			for(int i=1;"".equals(hour)&&!"".equals(month)&&i<=1;i++){ // 全月
					oneMap = dbHelper.getMap(sel_sql+whereStr.toString()+" and day(add_date)=?",new Object[]{i},connection) ;
				xml.append("<set label='"+i+"号' value='"+CommonString.getFormatPara(oneMap.get("total"))+"'/>") ;
			}
			for(int i=1;!"".equals(hour)&&i<=24;i++){ // 全日
					oneMap = dbHelper.getMap(sel_sql+whereStr.toString()+" and datepart(dd,add_date)=? and datepart(hh,add_date)=?",new Object[]{hour,i},connection) ;
				xml.append("<set label='"+i+"时' value='"+CommonString.getFormatPara(oneMap.get("total"))+"'/>") ;
			}
			xml.append("</chart>") ;
		}
		if("ding_dan_qu_shi_brand".equals(flag)){ // 品牌
			 // 代理商
			String brand = CommonString.getFormatPara(request.getParameter("brand")) ; // 代理商
			String brandname = CommonString.getFormatPara(request.getParameter("brandname")) ; 
			StringBuffer subcaption = new StringBuffer("") ;
			if("".equals(brand)){ // 默认为山东
		// 		province = "山东" ;
			}
			subcaption.append("".equals(brandname)?"全部":brandname) ;
			String year = CommonString.getFormatPara(request.getParameter("year")) ; // 年份
			if("".equals(year)){
				year = "2013" ;
			}
			subcaption.append(year).append("年") ;
			String month = CommonString.getFormatPara(request.getParameter("month")) ;
			if(!"".equals(month)){
				subcaption.append(month).append("月份") ;
			}
			String hour = CommonString.getFormatPara(request.getParameter(("hour"))) ;
			if(!"".equals(hour)){
				subcaption.append(hour).append("号") ;
			}
			subcaption.append("订单趋势") ;
			// String subcaption = province+year+month+hour+"订单趋势" ;
			xml.append("<chart caption='订单趋势(品牌)' subcaption='"+subcaption.toString()+"' xAxisName=''  yAxisMinValue='10'  showValues='1' formatNumberScale='0' alternateHGridColor='FCB541' alternateHGridAlpha='20' divLineColor='FCB541' divLineAlpha='50' canvasBorderColor='666666' baseFontColor='666666' lineColor='FCB541' baseFont='微软雅黑' baseFontSize='14'>") ;
			String sel_sql = " select count(*) total from pro_product_form " ;
			StringBuffer whereStr = new StringBuffer(" where 1=1 and factoryid is not null and factoryid<>'' ") ;
			if(!"".equals(brand)){
				whereStr.append(" and factoryid ='"+brand+"'") ;
			}
			if(!"".equals(year)){
				whereStr.append(" and year(add_date)="+year) ;
			}
			if(!"".equals(month)){
				whereStr.append(" and month(add_date)="+month) ;
			}
			Map oneMap = null ;
			for(int i=1;i<=12&&"".equals(month);i++){ // 全年
				if("".equals(month)){
					oneMap = dbHelper.getMap(sel_sql+whereStr.toString()+" and month(add_date)=?",new Object[]{i},connection) ;
				}
				xml.append("<set label='"+i+"月' value='"+CommonString.getFormatPara(oneMap.get("total"))+"'/>") ;
			}
			for(int i=1;"".equals(hour)&&!"".equals(month)&&i<=1;i++){ // 全月
					oneMap = dbHelper.getMap(sel_sql+whereStr.toString()+" and day(add_date)=?",new Object[]{i},connection) ;
				xml.append("<set label='"+i+"号' value='"+CommonString.getFormatPara(oneMap.get("total"))+"'/>") ;
			}
			for(int i=1;!"".equals(hour)&&i<=24;i++){ // 全日
					oneMap = dbHelper.getMap(sel_sql+whereStr.toString()+" and datepart(dd,add_date)=? and datepart(hh,add_date)=?",new Object[]{hour,i},connection) ;
				xml.append("<set label='"+i+"时' value='"+CommonString.getFormatPara(oneMap.get("total"))+"'/>") ;
			}
			xml.append("</chart>") ;
		
			
		}
		if("ding_dan_qu_shi_catalog".equals(flag)){   // 类别
			String catalog = CommonString.getFormatPara(request.getParameter("catalog")) ; 
			String catalogname = URLDecoder.decode(CommonString.getFormatPara(request.getParameter("catalogname"))) ; 
			StringBuffer subcaption = new StringBuffer("") ;
			if("".equals(catalog)){ // 默认为山东
		// 		province = "山东" ;
			}
			subcaption.append("".equals(catalogname)?"全部":catalogname) ;
			String year = CommonString.getFormatPara(request.getParameter("year")) ; // 年份
			if("".equals(year)){
				year = "2013" ;
			}
			subcaption.append(year).append("年") ;
			String month = CommonString.getFormatPara(request.getParameter("month")) ;
			if(!"".equals(month)){
				subcaption.append(month).append("月份") ;
			}
			String hour = CommonString.getFormatPara(request.getParameter(("hour"))) ;
			if(!"".equals(hour)){
				subcaption.append(hour).append("号") ;
			}
			subcaption.append("订单趋势") ;
			// String subcaption = province+year+month+hour+"订单趋势" ;
			xml.append("<chart caption='订单趋势(类别)' subcaption='"+subcaption.toString()+"' xAxisName=''  yAxisMinValue='10'  showValues='1' formatNumberScale='0' alternateHGridColor='FCB541' alternateHGridAlpha='20' divLineColor='FCB541' divLineAlpha='50' canvasBorderColor='666666' baseFontColor='666666' lineColor='FCB541' baseFont='微软雅黑' baseFontSize='14'>") ;
			String sel_sql = " select count(*) total from pro_product_form " ;
			StringBuffer whereStr = new StringBuffer(" where 1=1 and catanum is not null and catanum<>'' ") ;
			if(!"".equals(catalog)){
				whereStr.append(" and catanum like'"+catalog+"%'") ;
			}
			if(!"".equals(year)){
				whereStr.append(" and year(add_date)="+year) ;
			}
			if(!"".equals(month)){
				whereStr.append(" and month(add_date)="+month) ;
			}
			Map oneMap = null ;
			for(int i=1;i<=12&&"".equals(month);i++){ // 全年
				if("".equals(month)){
					oneMap = dbHelper.getMap(sel_sql+whereStr.toString()+" and month(add_date)=?",new Object[]{i},connection) ;
				}
				xml.append("<set label='"+i+"月' value='"+CommonString.getFormatPara(oneMap.get("total"))+"'/>") ;
			}
			for(int i=1;"".equals(hour)&&!"".equals(month)&&i<=1;i++){ // 全月
					oneMap = dbHelper.getMap(sel_sql+whereStr.toString()+" and day(add_date)=?",new Object[]{i},connection) ;
				xml.append("<set label='"+i+"号' value='"+CommonString.getFormatPara(oneMap.get("total"))+"'/>") ;
			}
			for(int i=1;!"".equals(hour)&&i<=24;i++){ // 全日
					oneMap = dbHelper.getMap(sel_sql+whereStr.toString()+" and datepart(dd,add_date)=? and datepart(hh,add_date)=?",new Object[]{hour,i},connection) ;
				xml.append("<set label='"+i+"时' value='"+CommonString.getFormatPara(oneMap.get("total"))+"'/>") ;
			}
			xml.append("</chart>") ;
		}
		// 代理商筛选
		if("agent__shai_xuan".equals(flag)){ 
				String sel_sql = " select a.*,catalogs.name catalogname from (select  habit.*,factory.name from pro_customer_agent_view_habit habit left join pro_agent_factory factory  on habit.factoryid=factory.id where counts>10) as a left join pro_catalog catalogs on a.catalogid=catalogs.num where a.id <> 8 order by counts desc" ;
				List<Map> dingdanList = new ArrayList() ;
				dingdanList = dbHelper.getMapList(sel_sql,connection) ;
				xml.append("<chart palette='2' caption='代理商筛选'  decimals='0' useRoundEdges='1' legendBorderAlpha='0' formatNumberScale='0' baseFont='微软雅黑' baseFontSize='12'>");
				if(null!=dingdanList && dingdanList.size()>0){
					xml.append("<categories>") ;
					Map myMap = new HashMap() ;
					for(int i=0;i<dingdanList.size();i++){  
						myMap = dingdanList.get(i) ;
						xml.append("<category label='"+CommonString.getFormatPara(myMap.get("counts"))+"' />") ;
					}
					xml.append("</categories>") ;
					xml.append("<dataset seriesName='浏览次数' color='F6BD0F' showValues='1'>") ;
					for(int j=0;j<dingdanList.size();j++){  
						StringBuffer sbf = new StringBuffer("") ;
						for(int i=0;i<6;i++){
							sbf.append(base_e.charAt(random.nextInt(base_e.length()))) ;
						}
						Map oneMap = dingdanList.get(j) ;
						xml.append("<set  color='"+sbf.toString()+"' value='"+CommonString.getFormatPara(oneMap.get("counts"))+"' tooltext='品牌:"+CommonString.getFormatPara(oneMap.get("name"))+"&lt;BR&gt;省份:"+CommonString.getFormatPara(oneMap.get("province"))+"&lt;BR&gt;城市:"+CommonString.getFormatPara(oneMap.get("city"))+"&lt;BR&gt;型号: "+CommonString.getFormatPara(oneMap.get("catalogname"))+"&lt;BR&gt;排名:"+(j+1)+"&lt;BR&gt;页码:"+CommonString.getFormatPara(oneMap.get("now_page"))+"'/>") ;
					}
					xml.append("</dataset>") ;
					xml.append("<styles><definition><style name='myHTMLFont' type='font' isHTML='1' /></definition><application><apply toObject='TOOLTIP' styles='myHTMLFont' /></application></styles>") ;
				}
				xml.append("</chart>") ;
		}
		if("brand_counts_statistics".equals(flag)){
			String year = CommonString.getFormatPara(request.getParameter("year")).equals("")?"2013":CommonString.getFormatPara(request.getParameter("year")) ;
			String month = CommonString.getFormatPara(request.getParameter("month")) ;
			String hour = CommonString.getFormatPara(request.getParameter("hour")) ;
			String whereStr = "  where name is not null " ;
			String orderByStr = " group by name,factory order by total desc " ;
			String sel_sql = "  select top 10 name,factory,sum(counts) total from ( select counts.*,factory.name from  pro_customer_brand_view_count counts left join pro_agent_factory factory on counts.factory=factory.id) a " ;
		
			if(!"".equals(year)){
				whereStr += " and year(statistics_date)="+year ;
			}
			if(!"".equals(month)){
				whereStr += " and month(statistics_date)="+month ;
			}
			if(!"".equals(hour)){
				whereStr += " and day(statistics_date)="+hour ;
			}
			List<Map> factoryList = null ;
			factoryList = dbHelper.getMapList(sel_sql+whereStr+orderByStr,connection) ;
			xml.append("<chart caption='2013年品牌关注指数' subCaption='前10位' numdivlines='9' lineThickness='2' showValues='1' formatNumberScale='0' anchorRadius='3' anchorBgAlpha='50' showValues='1' showAlternateVGridColor='1' numVisiblePlot='12' animation='0'>") ;
			xml.append("<categories>") ;
				for(int i=1;"".equals(month)&&i<=12;i++){
					xml.append("<category label='"+i+"月'/>") ;
				}
				for(int i=1;"".equals(hour)&&!"".equals(month)&&i<=1;i++){ // 全月
					xml.append("<category label='"+i+"号'/>") ;
				}
			xml.append("</categories>") ;
			if(null!=factoryList && factoryList.size()>0){
				for(Map oneMap:factoryList){
					StringBuffer sbf = new StringBuffer("") ;
					for(int i=0;i<6;i++){
						sbf.append(base_e.charAt(random.nextInt(base_e.length()))) ;
					}
					xml.append("<dataset seriesName='"+CommonString.getFormatPara(oneMap.get("name"))+"' color='"+sbf.toString()+"' anchorBorderColor='"+sbf.toString()+"'>") ;
					   for(int i=1;"".equals(month)&&i<=12;i++){
						   String sel_sql2 = "select sum(counts) total from pro_customer_brand_view_count where year(statistics_date)=? and month(statistics_date)=? and factory=? " ; 
						   xml.append("<set value='"+dbHelper.getMap(sel_sql2,new Object[]{year,i,CommonString.getFormatPara(oneMap.get("factory"))},connection).get("total")+"'/>") ;
					   }
					   for(int i=1;"".equals(hour)&&!"".equals(month)&&i<=1;i++){ // 全月
						   String sel_sql2 = "select sum(counts) total from pro_customer_brand_view_count where year(statistics_date)=? and month(statistics_date)=? and day(statistics_date)=? and factory=? " ; 
						   xml.append("<set value='"+dbHelper.getMap(sel_sql2,new Object[]{year,month,i,CommonString.getFormatPara(oneMap.get("factory"))},connection).get("total")+"'/>") ;
					   }
					xml.append("</dataset>") ;
				}
			}
			xml.append("</chart>") ;
		}
		if("news_view_counts".equals(flag)){
			String year = CommonString.getFormatPara(request.getParameter("year")) ;
			String month = CommonString.getFormatPara(request.getParameter("month")) ;
			String hour = CommonString.getFormatPara(request.getParameter("hour")) ;
			if("".equals(year)){
				year = "2013" ;
			}
			StringBuffer whereStr = new StringBuffer(" where 1=1 ") ;
			Object[] objs = new Object[3] ;
			if(!"".equals(year)){
				whereStr.append(" and year(pub_date)=?") ;
				objs[0] = year ;
			}
			if(!"".equals(month)){
				whereStr.append(" and month(pub_date)=?") ;
				objs[1] = month ;
			}
			if(!"".equals(hour)){
				whereStr.append(" and day(pub_date)=?") ;
				objs[2] = hour ;
			}
			String sel_sql = "   select a.*,factory.name from ( select agent_id,sum(view_count) counnts,count(*) total from pro_agent_news group "+whereStr.toString()+"by agent_id) a left join pro_agent_factory factory on a.agent_id = factory.id" ;
			xml.append("<chart caption='2013年新闻浏览量' subCaption='代理商' numdivlines='9' lineThickness='2' showValues='1' formatNumberScale='0' anchorRadius='3' anchorBgAlpha='50' showAlternateVGridColor='1' numVisiblePlot='12' animation='0'>") ;
			xml.append("<categories>") ;
			for(int i=1;"".equals(month)&&i<=12;i++){
				xml.append("<category label='"+i+"月'/>") ;
			}
			for(int i=1;"".equals(hour)&&!"".equals(month)&&i<=1;i++){ // 全月
				xml.append("<category label='"+i+"号'/>") ;
			}
		xml.append("</categories>") ;
		xml.append("<dataset seriesName='Tue' color='800080' anchorBorderColor='800080'>") ;
		for(int i=0;i<12;i++){
			xml.append("<set value='10'/>") ;
		}
		xml.append("</dataset>") ;
		xml.append("<dataset seriesName='Wed' color='FF8040' anchorBorderColor='FF8040'>") ;
		for(int i=0;i<12;i++){
			xml.append("<set value='10'/>") ;
		}
		xml.append("</dataset>") ;
	    xml.append("</chart>") ;
		}
	}catch(Exception e){
		
	}finally{
		DBHelper.freeConnection(connection);
	}
	out.print(xml.toString());
%>