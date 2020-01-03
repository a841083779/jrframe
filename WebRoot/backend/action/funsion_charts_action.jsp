<%@ page language="java" import="java.util.*,java.sql.Connection,com.jerehnet.util.dbutil.*,com.jerehnet.util.common.*" pageEncoding="utf-8"%>
<%@page import="com.jerehnet.action.PoolManager"%>
<%
	response.setHeader("Pragma", "No-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setDateHeader("Expires", 0);
	//response.setContentType("text/xml;");
	StringBuffer xml = new StringBuffer("");
	//xml.append("<?xml version='1.0' encoding='gbk'?>");
	DBHelper dbHelper = DBHelper.getInstance();
	Connection connection = null;
	String flag = CommonString.getFormatPara(request.getParameter("flag"));
	String ts = CommonString.getFormatPara(request.getParameter("ts")); // 开始时间
	String te = CommonString.getFormatPara(request.getParameter("te")); // 结束时间
	if(ts.equals("undefined")||"".equals(ts)){
		ts = CommonDate.getToday("yyyy-MM-dd") ;   // 默认今天 
	}
	if(te.equals("undefined")||"".equals(te)){
		te = CommonDate.getToday("yyyy-MM-dd") ;   // 默认今天 
	}
	String whereStr = "" ;
	List<Map> dataList = null ;
	try {
		connection = dbHelper.getConnection() ;
		if("brand_order".equals(flag)){
			String catalognum = CommonString.getFormatPara(request.getParameter("catalognum")) ;
			String province = CommonString.getFormatPara(request.getParameter("province")) ;
			String factoryid = CommonString.getFormatPara(request.getParameter("factoryid")) ;
			whereStr += " and add_date>='"+ts+" 00:00:00' and add_date<='"+te+" 23:59:59'" ;
			if(!"".equals(catalognum)){
				whereStr += " and catanum like '%"+catalognum+"%'" ;
			}
			if(!"".equals(province)){
				whereStr += " and province like '%"+province+"%'" ;
			}
			if(!"".equals(factoryid)){
				whereStr += " and factoryid ="+factoryid ;
			}
			String sel_sql = " select top 10 factoryname,count(id) total from pro_product_form where factoryname is not null and factoryname<>'' "+whereStr+"group by factoryname order by total desc" ;
			dataList = dbHelper.getMapList(sel_sql) ;
			if(null!=dataList && dataList.size()>0){
				String sel_total_sql = " select count(*) as total from pro_product_form " ;
				Integer total = Integer.parseInt(CommonString.getFormatPara(dbHelper.getMap(sel_total_sql+" where 1=1 "+whereStr,connection).get("total"))) ;
			xml.append("<chart bgColor='FFFFFF' formatNumberScale='0' baseFont='微软雅黑' baseFontSize='12' showValues='0'>") ;
				for(Map oneMap:dataList){
					String part = CommonString.getFormatPara(Integer.parseInt(CommonString.getFormatPara(oneMap.get("total")))/(total+0.0)*100) ;
					String show_part = part.length()>4?part.substring(0,4):part ;
					xml.append("<set isSliced='1' toolText='品牌:"+CommonString.getFormatPara(oneMap.get("factoryname"))+"&lt;BR&gt;数量:"+CommonString.getFormatPara(oneMap.get("total"))+"&lt;BR&gt;比例:"+show_part+"%' label='"+CommonString.getFormatPara(oneMap.get("factoryname"))+","+show_part+"%' value='"+CommonString.getFormatPara(oneMap.get("total"))+"'/>") ;
				}
				xml.append("<styles><definition><style name='myHTMLFont' type='font' isHTML='1' /></definition><application><apply toObject='TOOLTIP' styles='myHTMLFont' /></application></styles>") ;
				xml.append("</chart>") ;
			}else{
				xml.append("<chart bgColor='FFFFFF' formatNumberScale='0' baseFont='微软雅黑' showValues='0' baseFontSize='12'>") ;
				xml.append("<set label='暂无记录' value='10' />") ;
				xml.append("</chart>") ;
			}
		}
		if("province_order".equals(flag)){
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
			provincesCategory.add("湖北省");
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
			String factoryid = CommonString.getFormatPara(request.getParameter("factoryid")) ;
			String province = CommonString.getFormatPara(request.getParameter("province")) ;
			String catalognum = CommonString.getFormatPara(request.getParameter("catalognum")) ;
			whereStr += " and add_date>='"+ts+" 00:00:00' and add_date<='"+te+" 23:59:59'" ;
			if(!"".equals(factoryid)){
				whereStr += " and factoryid = '"+factoryid+"'" ;
			}
			if(!"".equals(catalognum)){
				whereStr += " and catanum like '%"+catalognum+"%'" ;
			} 
			Map oneMap = new HashMap() ;
			String sel_total_sql = " select count(*) as total from pro_product_form " ;
			Integer total = Integer.parseInt(CommonString.getFormatPara(dbHelper.getMap(sel_total_sql+" where 1=1 "+whereStr,connection).get("total"))) ;
			String sel_sql = " select count(*) as total from pro_product_form where province like 'province_val%'" ;
			xml.append("<map animation='1' showShadow='1' showBevel='0' showLabels='1' showMarkerLabels='1' fillColor='F1f1f1' borderColor='CCCCCC' baseFont='Verdana' baseFont='微软雅黑' baseFontSize='12' markerBorderColor='000000' markerBgColor='FF5904'markerRadius='6' legendPosition='bottom' useHoverColor='1' showToolTip='1' showMarkerToolTip='1' >") ;
			xml.append("<data>") ;
				for(String str:provincesCategory){
					oneMap = dbHelper.getMap(sel_sql.replace("province_val",str.substring(0,2))+whereStr,connection) ;
					String color = (((Integer.parseInt(CommonString.getFormatPara(oneMap.get("total")))/(total+0.0))>=0.1)?"#FF0000":(((Integer.parseInt(CommonString.getFormatPara(oneMap.get("total")))/(total+0.0))>=0.05)?"#FF6347":"FF8C69")) ;
					String part = CommonString.getFormatPara(Integer.parseInt(CommonString.getFormatPara(oneMap.get("total")))/(total+0.0)*100) ;
					String show_part = part.length()>4?part.substring(0,4):part ;
					if(str.equals("西藏")){
						xml.append("<entity id='CN.XZ' toolText='地区:"+str+"&lt;BR&gt;数量:"+CommonString.getFormatPara(oneMap.get("total"))+"&lt;BR&gt;比例:"+show_part+"%' displayValue='"+str+"' value='"+CommonString.getFormatPara(oneMap.get("total"))+"' color='"+color+"'/>") ;
					}if(str.equals("山西")){
						xml.append("<entity id='CN.SA' toolText='地区:"+str+"&lt;BR&gt;数量:"+CommonString.getFormatPara(oneMap.get("total"))+"&lt;BR&gt;比例:"+show_part+"%' displayValue='"+str+"' value='"+CommonString.getFormatPara(oneMap.get("total"))+"' color='"+color+"'/>") ;
					}if(str.equals("重庆")){
						xml.append("<entity id='CN.CQ' toolText='地区:"+str+"&lt;BR&gt;数量:"+CommonString.getFormatPara(oneMap.get("total"))+"&lt;BR&gt;比例:"+show_part+"%' displayValue='"+str+"' value='"+CommonString.getFormatPara(oneMap.get("total"))+"' color='"+color+"'/>") ;
					}if(str.equals("河南")){
						xml.append("<entity id='CN.HE' toolText='地区:"+str+"&lt;BR&gt;数量:"+CommonString.getFormatPara(oneMap.get("total"))+"&lt;BR&gt;比例:"+show_part+"%' displayValue='"+str+"' value='"+CommonString.getFormatPara(oneMap.get("total"))+"' color='"+color+"'/>") ;
					}if(str.equals("海南")){
						xml.append("<entity id='CN.HA' toolText='地区:"+str+"&lt;BR&gt;数量:"+CommonString.getFormatPara(oneMap.get("total"))+"&lt;BR&gt;比例:"+show_part+"%' displayValue='"+str+"' color='"+color+"'/>") ;
					}if(str.equals("台湾")){
						xml.append("<entity id='CN.TA' toolText='地区:"+str+"&lt;BR&gt;数量:"+CommonString.getFormatPara(oneMap.get("total"))+"&lt;BR&gt;比例:"+show_part+"%' displayValue='"+str+"' value='"+CommonString.getFormatPara(oneMap.get("total"))+"' color='"+color+"'/>") ;
					}if(str.equals("澳门")){
						xml.append("<entity id='CN.MA' toolText='地区:"+str+"&lt;BR&gt;数量:"+CommonString.getFormatPara(oneMap.get("total"))+"&lt;BR&gt;比例:"+show_part+"%' displayValue='"+str+"' value='"+CommonString.getFormatPara(oneMap.get("total"))+"' color='"+color+"'/>") ;
					}if(str.equals("香港")){
						xml.append("<entity id='CN.HK' toolText='地区:"+str+"&lt;BR&gt;数量:"+CommonString.getFormatPara(oneMap.get("total"))+"&lt;BR&gt;比例:"+show_part+"%' displayValue='"+str+"' value='"+CommonString.getFormatPara(oneMap.get("total"))+"' color='"+color+"'/>") ;
					}if(str.equals("湖北省")){
						xml.append("<entity id='CN.HU' toolText='地区:"+str+"&lt;BR&gt;数量:"+CommonString.getFormatPara(oneMap.get("total"))+"&lt;BR&gt;比例:"+show_part+"%' displayValue='"+str+"' value='"+CommonString.getFormatPara(oneMap.get("total"))+"' color='"+color+"'/>") ;
					}else{
					xml.append("<entity id='CN."+CnToFullSpell.getFirstSpell(str.substring(0,1)).toUpperCase()+CnToFullSpell.getFirstSpell(str.substring(1,2)).toUpperCase()+"' toolText='地区:"+str+"&lt;BR&gt;数量:"+CommonString.getFormatPara(oneMap.get("total"))+"&lt;BR&gt;比例:"+show_part+"%' displayValue='"+str+"' value='"+CommonString.getFormatPara(oneMap.get("total"))+"' color='"+color+"'/>") ;
					}
				}
			xml.append("</data>") ;
			xml.append("<styles><definition><style name='myHTMLFont' type='font' isHTML='1' /></definition><application><apply toObject='TOOLTIP' styles='myHTMLFont' /></application></styles>") ;
		    xml.append("</map>") ;
		}
		if("brand_catalog".equals(flag)){
			String catalognum = CommonString.getFormatPara(request.getParameter("catalognum")) ;
			String province = CommonString.getFormatPara(request.getParameter("province")) ;
			String factoryid = CommonString.getFormatPara(request.getParameter("factoryid")) ;
			whereStr += " and add_date>='"+ts+" 00:00:00' and add_date<='"+te+" 23:59:59'" ;
			if(!"".equals(catalognum)){
				whereStr += " and catanum like '%"+catalognum+"%'" ;
			}
			if(!"".equals(province)){
				whereStr += " and province like '%"+province+"%'" ;
			}
			if(!"".equals(factoryid)){
				whereStr += " and factoryid="+factoryid ;
			}
			String sel_sql = " select top 10 cataname,count(id) total from pro_product_form where cataname is not null and cataname<>'' and len(catanum)>6 "+whereStr+"group by cataname order by total desc" ;
			dataList = dbHelper.getMapList(sel_sql) ;
			if(null!=dataList && dataList.size()>0){
				String sel_total_sql = " select count(*) as total from pro_product_form " ;
				Integer total = Integer.parseInt(CommonString.getFormatPara(dbHelper.getMap(sel_total_sql+" where 1=1 "+whereStr,connection).get("total"))) ;
				xml.append("<chart bgColor='FFFFFF' formatNumberScale='0' baseFont='微软雅黑' baseFontSize='12' showValues='0'>") ;
			    StringBuffer part = new StringBuffer("") ;
			    StringBuffer show_part = new StringBuffer("") ;
				for(Map oneMap:dataList){
					 part = new StringBuffer(CommonString.getFormatPara(Integer.parseInt(CommonString.getFormatPara(oneMap.get("total")))/(total+0.0)*100)) ;
					 show_part = new StringBuffer(part.length()>4?part.substring(0,4):part.toString()) ;
					xml.append("<set isSliced='1' toolText='类型:"+CommonString.getFormatPara(oneMap.get("cataname"))+"&lt;BR&gt;数量:"+CommonString.getFormatPara(oneMap.get("total"))+"&lt;BR&gt;比例:"+show_part+"%' label='"+CommonString.getFormatPara(oneMap.get("cataname"))+","+show_part+"%' value='"+CommonString.getFormatPara(oneMap.get("total"))+"'/>") ;
				}
				xml.append("<styles><definition><style name='myHTMLFont' type='font' isHTML='1' /></definition><application><apply toObject='TOOLTIP' styles='myHTMLFont' /></application></styles>") ;
				xml.append("</chart>") ;
			}else{
				xml.append("<chart bgColor='FFFFFF' formatNumberScale='0' baseFont='微软雅黑' showValues='0' baseFontSize='12'>") ;
				xml.append("<set label='暂无记录' value='10' />") ;
				xml.append("</chart>") ;
			}
		}
	} catch (Exception e) {
		e.printStackTrace();
	} finally {
		DBHelper.freeConnection(connection);
	}
	out.print(xml.toString());
%>

