<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
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
<%@page import="com.jerehnet.mobile.sync.PushSyncActon"%>
<%@page import="com.jerehnet.util.common.*"%>

<%@page import="org.codehaus.xfire.client.Client,com.jerehnet.util.common.Env,java.net.URL"%>
<%
	request.setCharacterEncoding("utf-8");
	DBHelper dbHelper = DBHelper.getInstance();
	String uuid = CommonString.getFormatPara(request.getParameter("uuid"));
	String comfirm = CommonString.getFormatPara(request.getParameter("comfirm"));
	Map one_proform = dbHelper.getMap("  select  * from pro_product_form where uuid='" + uuid + "' ");
	if(one_proform !=null && one_proform.get("id") != null){
		String id = CommonString.getFormatPara(one_proform.get("id"));
		String product_id = CommonString.getFormatPara(one_proform.get("product_id"));
		String name = CommonString.getFormatPara(one_proform.get("name"));                   //联系人 购买人
		String mobile_phone = CommonString.getFormatPara(one_proform.get("mobile_phone"));   //联系电话
		String message = CommonString.getFormatPara(one_proform.get("call_result1"));           //询价内容
		String province = CommonString.getFormatPara(one_proform.get("province")).trim(); // 省份
		String city = CommonString.getFormatPara(one_proform.get("city"));              //城市
		String cataname = CommonString.getFormatPara(one_proform.get("cataname"));   //产品类型
		String catanum = CommonString.getFormatPara(one_proform.get("catanum"));
        if(province.equals("北京")){city="北京市";}
		if(province.equals("上海")){city="上海市";}
		if(province.equals("天津")){city="天津市";}
		if(province.equals("重庆")){city="重庆市";}
		if(city.equals("临夏州")){city="临夏回族自治州";}
		if(city.equals("甘南州")){city="甘南藏族自治州";}
		if(city.equals("毕节地区")){city="毕节市";}
		if(city.equals("铜仁地区")){city="铜仁市";}
		if(city.equals("黔东南州")){city="黔东南苗族侗族自治州";}
		if(city.equals("黔南州")){city="黔南布依族苗族自治州";}
		if(city.equals("黔西南州")){city="黔西南布依族苗族自治州";}
		if(city.equals("西南中沙群岛办事处")){city="三沙市";}
		if(city.equals("恩施州")){city="恩施土家族苗族自治州";}
		if(city.equals("湘西州")){city="湘西土家族苗族自治州";}
		if(city.equals("海东地区")){city="海东市";}
		if(city.equals("海北州")){city="海北藏族自治州";}
		if(city.equals("黄南州")){city="黄南藏族自治州";}
		if(city.equals("海南州")){city="海南藏族自治州";}
		if(city.equals("果洛州")){city="果洛藏族自治州";}
		if(city.equals("玉树州")){city="玉树藏族自治州";}
		if(city.equals("海西州")){city="海西蒙古族藏族自治州";}
		if(city.equals("阿坝州")){city="阿坝藏族羌族自治州";}
		if(city.equals("甘孜州")){city="甘孜藏族自治州";}
		if(city.equals("凉山州")){city="凉山彝族自治州";}	
		if(city.equals("楚雄州")){city="楚雄彝族自治州";}
		if(city.equals("大理州")){city="大理白族自治州";}
		if(city.equals("德宏州")){city="德宏傣族景颇族自治州";}
		if(city.equals("迪庆州")){city="迪庆藏族自治州";}
		if(city.equals("红河州")){city="红河哈尼族彝族自治州";}
		if(city.equals("文山州")){city="文山壮族苗族自治州";}
		if(city.equals("怒江州")){city="怒江傈僳族自治州";}
		if(city.equals("西双版纳州")){city="西双版纳傣族自治州";}

		//挖掘机
		if(catanum.indexOf("101001")>=0){cataname="挖掘机";}
		//滑移
		if(catanum.indexOf("101002009")>=0){cataname="滑移";}
		//装载机
		if("101002010".equals(catanum)){cataname="条石叉";}
		if("101002004".equals(catanum)){cataname="装载机";}
		if("101002007".equals(catanum)){cataname="装载机";}
		if("101002008".equals(catanum)){cataname="挖装机";}	
		if("101001004".equals(catanum)){cataname="轮挖";}	
		//叉车 
		if("107010".equals(catanum)||"107005".equals(catanum)||"107003".equals(catanum)||"107001002".equals(catanum)||"107012".equals(catanum)){cataname="电瓶叉车";}	
		if("107001001".equals(catanum)||"107011".equals(catanum)){cataname="内燃叉车";}	
		if("107013".equals(catanum)){cataname="侧面叉车";}	
		//压路机
		if(catanum.indexOf("106001")>=0){cataname="轻型压路机";}
		if("106001".equals(catanum)){cataname="轻型压路机";}	
	    if("106001009".equals(catanum)){cataname="机械式压路机";}	
		if("106001005".equals(catanum)){cataname="轮胎式压路机";}	
		
		if("106001002".equals(catanum)){cataname="机械式压路机";}	
        if("106001004".equals(catanum)){cataname="机械式压路机";}
        if("106001005".equals(catanum)){cataname="轮胎式压路机";}	
        if("106001020".equals(catanum)){cataname="垃圾压实机";}			
		//平地机
		if("101005002".equals(catanum)){cataname="平地机";}	
		//推土机
		if(catanum.indexOf("101003")>=0){cataname="推土机";}
		//筑养路机械
		if(catanum.indexOf("104")>=0){cataname="铣刨机";}
		//环卫机械
		if("104002010".equals(catanum)||"122002".equals(catanum)){cataname="垃圾中转站";}
        //压实机械
		if(catanum.indexOf("104")>=0){cataname="垃圾压实机";}
		//泵车
		if(catanum.indexOf("103")>=0){cataname="泵车";}
	    if(catanum.equals("103017")){cataname="车载泵";}
		
		String product_name = CommonString.getFormatPara(one_proform.get("product_name")); // 产品名字 
		String add_date = CommonDate.getFormatDate("yyyy-MM-dd HH:mm:ss",one_proform.get("add_date")); 
		Client client = new Client(new URL("http://crm.xiagong.com:8088/webservice/webservice.asmx?wsdl"));
        Object [] s =  client.invoke("insertWillAccount", new Object[]{"xunjia","xj@123!",name,name,mobile_phone,province.replace("省",""),city,"",cataname,"","",message,4,comfirm});
        String upSql = "";
        if(s != null && s.length > 0){
			  System.out.println(s[0].toString());
			  if(s[0].toString().equals("成功")){
			  upSql = " update pro_product_form set is_success = 1 where uuid = '"+uuid+"' ";
			  dbHelper.execute(upSql);
			  }
		}
  

	}
	out.println("ok");
%>
