<%@ page language="java" import="java.util.*,org.json.*,com.jerehnet.util.dbutil.*,java.sql.*,com.jerehnet.manage.*,java.util.*,com.jerehnet.util.common.*,com.jerehnet.webservice.*" pageEncoding="UTF-8"%>
<%@page import="com.jerehnet.util.dbutil.DBHelper"%>
<%@page import="com.jerehnet.util.common.CommonString"%>
<%@page import="com.jerehnet.util.common.CommonDate"%>
<%@page import="com.jerehnet.util.common.Common"%>
<%@page import="org.apache.commons.httpclient.HttpClient"%>
<%@page import="org.apache.commons.httpclient.Header"%>
<%@page import="org.apache.commons.httpclient.HttpStatus"%>
<%@page import="org.apache.commons.httpclient.NameValuePair"%>
<%@page import="org.apache.commons.httpclient.methods.PostMethod"%>
<%@page import="com.jerehnet.webservice.WEBEmail"%>
 <%@page import="com.jerehnet.util.common.*"%>

<%@page import="java.net.HttpURLConnection"%>
<%@page import="org.codehaus.xfire.client.Client,com.jerehnet.util.common.Env,java.net.URL"%>
<%@page import="org.apache.commons.httpclient.HttpMethod"%>
<%@page import="org.apache.commons.httpclient.methods.GetMethod"%>


<%@page import="java.net.URLEncoder"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="java.io.InputStreamReader"%>
<%@page import="java.security.MessageDigest"%>
<%@page import="java.net.URLDecoder" %>
<%@page import="java.io.DataOutputStream"%>
<%
    System.out.println("进来了"); 
    int statusCode=0;
	request.setCharacterEncoding("utf-8");
	DBHelper dbHelper = DBHelper.getInstance();
	String id = CommonString.getFormatPara(request.getParameter("id"));
	Connection connection = null;
	Map one_proform=null;
	Map contentMap=null;
    String strIds="";
 	try{
		 //connection = PoolManager.getConnection(DBType.getDBTypeByEnum("106018"));
		 List <Map> list = WEBDBHelper.getMapList("  select top 60   id from article where id=187221  order by id asc","Web21NewsDBHelper");
		 for(Map qiuMap : list){
	     one_proform = WEBDBHelper.getMap("  select  * from article where id=" + CommonString.getFormatPara(qiuMap.get("id")) + "","Web21NewsDBHelper");
		 

	    if(one_proform !=null && one_proform.get("id") != null){
	    contentMap= WEBDBHelper.getMap("  select  content  from News_content where groud_id=" + CommonString.getFormatPara(qiuMap.get("id")) + "","Web21NewsDBHelper");
	    String site_id="";
		String ch_id="";
		String media_id="";
		String media_name="";
		String exsite_id="";
		String exsite_url="";
		String article_title=CommonString.getFormatPara(one_proform.get("title"));
		String article_summary=CommonString.getFormatPara(one_proform.get("summary"));
		if(article_summary.equals("")){article_summary="暂无简介";}
		String rich_media_count="";
		String list_imgs=CommonString.getFormatPara(one_proform.get("image"));
		String list_style="0";
		String target_pub_time=CommonString.getFormatPara(one_proform.get("add_date"));
		String tags=CommonString.getFormatPara(one_proform.get("keyword"));
		if(!tags.equals("")){
			tags=tags.replaceAll("-",",");
		}
		String article_status="";
		String create_date="";
		String status="";
		String version="";
		String article_id="";
		String article_content=CommonString.getFormatPara(contentMap.get("content"));
 		String []listImgs=CommonString.getPicFromContent(article_content);
		strIds+=CommonString.getFormatPara(one_proform.get("id"))+",";
		if(!list_imgs.equals("")){
			list_style="1";
		}
		if(listImgs!=null&&listImgs.length>=3){
			list_style="2";
			list_imgs="";
			for(int i=0;i<=listImgs.length-1;i++){
				list_imgs=list_imgs+listImgs[i]+",";
			}
			if(!list_imgs.equals("")){
			    list_imgs.substring(0,list_imgs.length()-1);
		    }	
		}
		String sort=CommonString.getFormatPara(one_proform.get("sort_num"));
		String link_other=CommonString.getFormatPara(one_proform.get("link_other"));
		String channel="13";
		String childId="0";
		//趋势
		if(sort.indexOf(",3,")>=0){
			childId="28";
		}
		//外贸
		if(sort.indexOf(",9,")>=0){
			childId="29";
		}
		//展会
		if(sort.indexOf(",37,")>=0){
			childId="16";
		}
		//人物
		if(sort.indexOf(",5,")>=0){
			childId="30";
		}
		
		//企业
		if(sort.indexOf(",1,")>=0){
			channel="14";
		}
		if(article_title.indexOf("三一")>=0){
			childId="31";
		}		
		if(article_title.indexOf("徐工")>=0){
			childId="32";
		}
		if(article_title.indexOf("中联")>=0){
			childId="33";
		}
		if(article_title.indexOf("柳工")>=0){
			childId="34";
		}		
		
		//产品
		if(sort.indexOf(",2,")>=0){
			channel="24";
		}
		if(article_title.indexOf("挖掘机")>=0){
			childId="38";
		}		
		if(article_title.indexOf("装载机")>=0){
			childId="39";
		}
		if(article_title.indexOf("推土机")>=0){
			childId="40";
		}
		if(article_title.indexOf("起重机")>=0){
			childId="41";
		}	
		
		//二手
		if(article_title.indexOf("二手")>=0){
			channel="27";
			childId="35";
		}	
		
		//租赁
		if(article_title.indexOf("租赁")>=0){
			channel="26";
			childId="42";
		}	
		
		
		//配件
		if(article_title.indexOf("配件")>=0){
			channel="25";
			childId="45";
		}
		
		//工程
		if(article_title.indexOf("项目")>=0){
			channel="22";
			childId="0";
		}		
		
		//上下游
		if(sort.indexOf(",10,")>=0||sort.indexOf(",7,")>=0){
			channel="19";
		}	
 		if(sort.indexOf(",7,")>=0){
			channel="19";
			childId="18";
		}	
		if(article_title.indexOf("钢铁")>=0){
			channel="19";
			childId="48";
 		}
		if(article_title.indexOf("煤炭")>=0){
			channel="19";
			childId="49";
 		}
		if(article_title.indexOf("矿山")>=0){
			channel="19";
			childId="50";
 		}
		
		//铁腕儿
		if(article_title.indexOf("铁腕儿")>=0){
			channel="23";
			childId="55";
			if(article_title.indexOf("聚焦")>=0){
				childId="58";

			}
			if(article_title.indexOf("测评")>=0){
				childId="57";
			}
 		}
		
		HttpClient httpClient = new HttpClient(); 
		PostMethod postMethod = new UTF8PostMethod("http://toutiao.21-sun.com/m/3/content/doPublishs.do"); 
		NameValuePair[] arr = new NameValuePair[14]; 
		List<NameValuePair> formParams = new ArrayList<NameValuePair>(); 
 		formParams.add(new NameValuePair("channel", channel)); 
		formParams.add(new NameValuePair("childId", childId)); 
		formParams.add(new NameValuePair("mediaId", "3")); 
		formParams.add(new NameValuePair("mediaName", "铁臂资讯")); 
		formParams.add(new NameValuePair("version", "1")); 
		formParams.add(new NameValuePair("exsite_url", "")); 
		formParams.add(new NameValuePair("title", article_title)); 
		formParams.add(new NameValuePair("summary", article_summary)); 
 		formParams.add(new NameValuePair("list_imgs", list_imgs)); 
		formParams.add(new NameValuePair("list_style", list_style)); 
		formParams.add(new NameValuePair("targetPubTime", target_pub_time)); 
		formParams.add(new NameValuePair("content", article_content)); 
 		formParams.add(new NameValuePair("tags",tags)); 
		formParams.add(new NameValuePair("id", "")); 
 
		postMethod.addParameters(formParams.toArray(arr)); 
		statusCode = httpClient.executeMethod(postMethod); 
	    String str = postMethod.getResponseBodyAsString(); 
		System.out.println(str);
		
		}
 		 
	}
	
	if(!strIds.equals("")){
		strIds=strIds.substring(0,strIds.length()-1);
	}
	//dbHelper.execute(" update News set is_push=1 where id in("+strIds+")",connection);
	
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		DBHelper.freeConnection(connection);
	}
	out.println(statusCode);
%>
 