<%@ page language="java" import="java.util.*,java.sql.*,com.jerehnet.util.dbutil.*" pageEncoding="UTF-8"%>
<%@page import="com.jerehnet.util.freemarker.FreemarkerUtils"%>
<%@page import="com.jerehnet.util.common.Common"%>
<%@page import="com.jerehnet.webservice.*"%>
<%@page import="com.jerehnet.util.freemarker.FreemarkerWebserviceUtils"%>
<%@page import="com.jerehnet.util.common.CommonString"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
   
    DBHelper dbHelper = DBHelper.getInstance() ;
	String realPath = Common.getAbsolutePath(request) ;
	FreemarkerUtils freemarkerUtils = new FreemarkerUtils(realPath+"template/") ; 
	String resule="false";
	String sql="";
	String sql1="";
	try{
		List <Map>list = null;
		List <Map>list1 = null;
		List <Map>list2 = null;
		Map root = new HashMap();
		Map root1 = new HashMap();
			//产品列表首页左侧类别
			sql = "select id,num,name from pro_catalog where parentid=0 and is_show=1 order by id asc";
			list = dbHelper.getMapList(sql);
			if(list != null && list.size() > 0){
				root.put("list",list);
				freemarkerUtils.generate("products_page/products_list_index_catalog.htm",root,realPath+"include/products_page/products_list_index_catalog.htm");
				resule="true";
			}
			
			//产品列表首页左侧品牌,有品牌
			sql = "select num from pro_catalog where  is_show=1   order by id asc";
			list = dbHelper.getMapList(sql);
			for(Map brand:list){
			String hasLetters = "";
			List<String> letters = new ArrayList<String>(0);
			String catalogNum="";
			   catalogNum=CommonString.getFormatPara(brand.get("num"));
				String zmSql=" select paf.upper_index as upper_index from pro_products pp ,pro_agent_factory paf where pp.factoryid = paf.id and pp.catalognum like '"+catalogNum+"%'  group by paf.upper_index order by paf.upper_index";
				list1 = dbHelper.getMapList(zmSql);
					if(list1 != null && list1.size() > 0){
					  for(Map m : list1){
						hasLetters += m.get("upper_index").toString().toUpperCase()+",";
					   }
				     }
				letters.add("A");letters.add("B");letters.add("C");letters.add("D");letters.add("E");letters.add("F");letters.add("G");letters.add("H");
				letters.add("I");letters.add("J");letters.add("K");letters.add("L");letters.add("M");letters.add("N");letters.add("O");letters.add("P");
				letters.add("Q");letters.add("R");letters.add("S");letters.add("T");letters.add("U");letters.add("V");letters.add("W");letters.add("X");
				letters.add("Y");letters.add("Z");
				String sql2 ="select paf.id,paf.upper_index,paf.name,paf.usern from pro_products pp ,pro_agent_factory paf where pp.factoryid = paf.id and pp.catalognum like '"+catalogNum+"%'   and pp.is_show=1 and paf.is_show=1 group by paf.upper_index,paf.name,paf.usern,paf.id order by paf.upper_index,paf.name";
				list2 = dbHelper.getMapList(sql2);
				if(list != null && list.size() > 0&&list1 != null && list1.size() > 0&&list2 != null && list2.size() > 0){
					root.put("letters",letters);
					root.put("hasLetters",hasLetters);
					root.put("list2",list2);
					freemarkerUtils.generate("products_page/products_list_index_brand.htm",root,realPath+"include/products_page/products_list_index_brand/products_list_index_brand_"+catalogNum+".htm");
					resule="true";
				}
		    }
			
			    //产品列表首页左侧品牌,没有品牌
		        String hasLetterss = "";
			    List<String> letterss = new ArrayList<String>(0);
				String zmSql=" select paf.upper_index as upper_index from pro_products pp ,pro_agent_factory paf where pp.factoryid = paf.id group by paf.upper_index order by paf.upper_index";
				list1 = dbHelper.getMapList(zmSql);
					if(list1 != null && list1.size() > 0){
					  for(Map m : list1){
						hasLetterss += m.get("upper_index").toString().toUpperCase()+",";
					   }
				     }
				letterss.add("A");letterss.add("B");letterss.add("C");letterss.add("D");letterss.add("E");letterss.add("F");letterss.add("G");letterss.add("H");
				letterss.add("I");letterss.add("J");letterss.add("K");letterss.add("L");letterss.add("M");letterss.add("N");letterss.add("O");letterss.add("P");
				letterss.add("Q");letterss.add("R");letterss.add("S");letterss.add("T");letterss.add("U");letterss.add("V");letterss.add("W");letterss.add("X");
				letterss.add("Y");letterss.add("Z");
				String sql2 ="select paf.id,paf.upper_index,paf.name,paf.usern from pro_products pp ,pro_agent_factory paf where pp.factoryid = paf.id   and pp.is_show=1 and paf.is_show=1 group by paf.upper_index,paf.name,paf.usern,paf.id order by paf.upper_index,paf.name";
				list2 = dbHelper.getMapList(sql2);
				if(list != null && list.size() > 0&&list1 != null && list1.size() > 0&&list2 != null && list2.size() > 0){
					root.put("letters",letterss);
					root.put("hasLetters",hasLetterss);
					root.put("list2",list2);
					freemarkerUtils.generate("products_page/products_list_index_brand.htm",root,realPath+"include/products_page/products_list_index_brand/products_list_index_brand_0.htm");
					resule="true";
				}
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		
	}
	out.println(resule) ;	
	%>