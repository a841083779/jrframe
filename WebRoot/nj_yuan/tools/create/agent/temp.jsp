<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.jerehnet.util.common.Common"%>
<%@page import="com.jerehnet.util.freemarker.FreemarkerUtils"%>
<%@page import="com.jerehnet.util.freemarker.FreemarkerWebserviceUtils"%>
<%@page import="com.jerehnet.util.dbutil.DBHelper"%>
<%@page import="com.jerehnet.util.common.CommonString"%>
<%
// 生成所有的品牌详显页
	String zd_id = CommonString.getFormatPara(request.getParameter("id")) ;
	String realPath = Common.getAbsolutePath(request) ;
	FreemarkerUtils freemarkerUtils = new FreemarkerUtils(realPath+"template/") ;
    FreemarkerWebserviceUtils freemarkerWebserviceUtils = new FreemarkerWebserviceUtils(realPath+"template/") ;
	DBHelper dbHelper = DBHelper.getInstance() ;
	Map root = new HashMap() ;
	String topSql ="";
	String productSql ="";
	String rightSql ="";
	String listSql ="";
	Map topMap=null;
	List<Map> rightList=null;
	List<Map> productList=null;
	List<Map> list=null;
	List<Map> Comlist=null;
	List<Map> Newslist=null;
	//topSql="select id,usern,name,full_name,city,introduce as intro,logo,img1,agent_fac,agent_fac_name,lng,lat,introduce,is_made,is_qijiandian from pro_agent_factory where is_show=1 and flag = 2 and id="+agentid;
	//topMap = dbHelper.getMap(topSql) ;
	String agentSql="select  * from  pro_agent_factory where  is_show=1 and flag =2 and  agent_fac like  '%154%' and  levelflag=0  and full_name like '%宣工%'   ";
	List<Map> agentlist = dbHelper.getMapList(agentSql) ;//所有代理商
    String comSql="select agent_id from pro_agent_news GROUP BY agent_id";
	Comlist= dbHelper.getMapList(comSql);//有新闻的代理商
	    for(Map agent:agentlist){
		     List<Map> agentFaList = new ArrayList() ;
		    String agentid=CommonString.getFormatPara(agent.get("id"));
			out.print("agentid="+agentid+"--");
		    String usern=CommonString.getFormatPara(agent.get("usern"));
			String agent_fac=CommonString.getFormatPara(agent.get("agent_fac"));
			String agent_facId[]=null;
			topMap=agent;
			if(agent_fac.indexOf(",")!=-1){
				  agent_facId=agent_fac.split(",");
				 
				 for(int i=0;i<agent_facId.length;i++){
				  agent_fac=agent_facId[i];
					  if(!agent_fac.equals("")&&!agent_fac.equals(",")){
					    break;
					  }
				  }
				 /* if(!agent_facId[0].equals("")&&!agent_facId[0].equals(",")){
				  agent_fac=agent_facId[0];
				  }else{
					agent_fac=agent_facId[1];
				  }*/
			}else{
			     agent_facId= new String [] {agent_fac};
			}
			//分页
			String pro_page="select count(id) as count from pro_agent_product_vi  where is_show=1 and  agentid="+agentid;
			Map pageMap = dbHelper.getMap(pro_page);
			int count_all=CommonString.getFormatInt(pageMap.get("count"));//总条数
			    //总页数
				int page_count=0;
				if(count_all%16>0){
				page_count=(int)(count_all/16)+1;
				}else{
				page_count=(int)(count_all/16);
				}
			root.put("pageCount",page_count);//总页数

			//右侧品牌类别
			Map map = null ;
			if(null!=agent_facId && agent_facId.length>0){
				for(int i=0;i<agent_facId.length;i++){
					 if(!agent_facId[i].equals("")){
					    String sel_map = "select id,usern,name,logo from pro_agent_factory where id ="+agent_facId[i] ;
						  map = dbHelper.getMap(sel_map);
					 }
					 agentFaList.add(map) ;
				}
			}

			
			
			//首页主推产品
			if(agentid.equals("16680")){
			productSql="select top 16 id,name,catalogname,factoryname,factoryid,file_name,img2 from pro_agent_product_vi where is_show=1 and agentid="+agentid+" order by view_count desc ";
			}else{
			productSql="select top 16 id,name,catalogname,factoryname,factoryid,file_name,img2 from pro_agent_product_vi where is_show=1 and agentid="+agentid+" order by view_count desc";
			}
			productList = dbHelper.getMapList(productSql) ;
	
			        root.put("Comlist",Comlist) ;//资讯导航显示信息
			        root.put("topMap",topMap) ;//基本信息
					root.put("productList",productList) ;
					root.put("agentFaList",agentFaList) ;//右侧品牌类别信息
			freemarkerUtils.generate("agent_detail/agent_intro.htm",root,realPath+"/agent/"+usern+"/index.shtm") ;  // 生成首页
			freemarkerUtils.generate("agent_detail/agent_product.htm",root,realPath+"/agent/"+usern+"/agent_products.shtm") ;  // 生成产品页面
			freemarkerUtils.generate("agent_detail/agent_contact.htm",root,realPath+"/agent/"+usern+"/contact.shtm") ;  // 生成办事处页面
			freemarkerUtils.generate("agent_detail/agent_intro.htm",root,realPath+"/agent/"+usern+"/introduce.shtm") ;  // 生成公司介绍
                
				


	     }
	out.println("ok") ;
%>