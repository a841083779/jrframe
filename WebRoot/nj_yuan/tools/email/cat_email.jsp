<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.jerehnet.util.dbutil.DBHelper"%>
<%@page import="com.jerehnet.util.common.CommonString"%>
<%@page import="com.jerehnet.webservice.WEBEmail"%>
<%
	/*
		1、北京、天津、河北、黑龙江、辽宁、吉林、山西 
		这几个区域发送至：
		Allen.he@westrac.com.cn
		wtcleads@westrac.com.cn
		抄送：
		Baker Huang/1P/Caterpillar
		Chen.Su@westrac.com.cn
		Teresa.li@westrac.com.cn
		toh_mervin@cat.com
		2、云南、贵州、四川、重庆、陕西、宁夏、甘肃、青海  1
		发送至：
		liujian@eci-metro.cn
		抄送：
		clara <clara_xie@eci-metro.cn>
		Erin Xu/0P/Caterpillar
		kelley_ren@eci-metro.cn
		toh_mervin@cat.com
		3、江苏、浙江、湖北、安徽、河南、山东、上海  3
		发送至：
		jingqi@lsh.com
		LeadGen@lsh.com
		抄送：
		fiona.qhzhu@lsh.com
		xu_katherine@cat.com
		toh_mervin@cat.com
		4、香港、广东、广西、福建、湖南、江西、海南 2
		发送至
		 jane.cao.lizhen@simedarby.com.hk 
		Joyce.zhuo.jingyun@simedarby.com.hk 
		抄送：
		Frank Zhou/0P/Caterpillar
		toh_mervin@cat.com 
	 */
%>
<%
	request.setCharacterEncoding("utf-8");
	DBHelper dbHelper = DBHelper.getInstance();
	String factoryid = CommonString.getFormatPara(request.getParameter("factoryid")); // 获得厂家id
	String uuid = CommonString.getFormatPara(request.getParameter("uuid"));
	Map one_proform = dbHelper.getMap("  select  * from pro_product_form where uuid='" + uuid + "'");
	Map one_factory = dbHelper.getMap(" select email from pro_agent_factory where id ='" + factoryid + "'");
	String product_name = CommonString.getFormatPara((one_proform.get("product_name")).toString()); // 产品名字
	String factoryname = CommonString.getFormatPara(one_proform.get("factoryname")); // 品牌名字
	String cataname = CommonString.getFormatPara(one_proform.get("cataname")); // 类别型号 
	String province = CommonString.getFormatPara(one_proform.get("province")).trim(); // 省份
	String emails = CommonString.getFormatPara(one_factory.get("email")); // 厂家邮箱
	//北京、天津、河北、黑龙江、辽宁、吉林、山西 
	if (province.equals("北京") || province.equals("天津") || province.equals("河北") || province.equals("黑龙江") || province.equals("辽宁")
			|| province.equals("吉林") || province.equals("山西")) {
		WEBEmail.sendMailByUrl("zuan.guo@westrac.com.cn,wtcleads@westrac.com.cn", "Chen.Su@westrac.com.cn,Teresa.li@westrac.com.cn,toh_mervin@cat.com ", null, CommonString.getFormatPara(one_proform.get("factoryname"))
				+ CommonString.getFormatPara(one_proform.get("product_name"))
				+ CommonString.getFormatPara(one_proform.get("catalogname"))
				+ "询价单  -  来自中国工程机械商贸网(www.21-sun.com) 产品中心", "http://product.21-sun.com/tools/email/email_detail_new.jsp?uuid=" + uuid, "utf-8");
	}
		//云南、贵州、四川、重庆、陕西、宁夏、甘肃、青海 
		if (province.equals("云南") || province.equals("贵州") || province.equals("四川") || province.equals("重庆") || province.equals("陕西")
				|| province.equals("宁夏") || province.equals("甘肃") ||province.equals("青海")) {
			WEBEmail.sendMailByUrl("liujian@eci-metro.cn", "clara_xie@eci-metro.cn,kelley_ren@eci-metro.cn,toh_mervin@cat.com ", null, CommonString.getFormatPara(one_proform.get("factoryname"))
					+ CommonString.getFormatPara(one_proform.get("product_name")) + CommonString.getFormatPara(one_proform.get("catalogname"))
					+ "询价单  -  来自中国工程机械商贸网(www.21-sun.com) 产品中心", "http://product.21-sun.com/tools/email/email_detail_new.jsp?uuid=" + uuid, "utf-8");	
		}
		//江苏、浙江、湖北、安徽、河南、山东、上海
		if (province.equals("江苏") || province.equals("浙江") || province.equals("湖北") || province.equals("安徽") || province.equals("河南")
				|| province.equals("山东") || province.equals("上海") ) {
			WEBEmail.sendMailByUrl("jingqi@lsh.com,LeadGen@lsh.com", "fiona.qhzhu@lsh.com,xu_katherine@cat.com,toh_mervin@cat.com ", null, CommonString.getFormatPara(one_proform.get("factoryname"))
					+ CommonString.getFormatPara(one_proform.get("product_name")) + CommonString.getFormatPara(one_proform.get("catalogname"))
					+ "询价单  -  来自中国工程机械商贸网(www.21-sun.com) 产品中心", "http://product.21-sun.com/tools/email/email_detail_new.jsp?uuid=" + uuid, "utf-8");
		}
		//香港、广东、广西、福建、湖南、江西、海南 
		if (province.equals("香港") || province.equals("广东") || province.equals("广西") || province.equals("福建") || province.equals("湖南")
				|| province.equals("湖南") || province.equals("江西")|| province.equals("海南") ) {
			WEBEmail.sendMailByUrl("jane.cao.lizhen@simedarby.com.hk,Joyce.zhuo.jingyun@simedarby.com.hk", "toh_mervin@cat.com ", null, CommonString.getFormatPara(one_proform.get("factoryname"))
					+ CommonString.getFormatPara(one_proform.get("product_name")) + CommonString.getFormatPara(one_proform.get("catalogname"))
					+ "询价单  -  来自中国工程机械商贸网(www.21-sun.com) 产品中心", "http://product.21-sun.com/tools/email/email_detail_new.jsp?uuid=" + uuid, "utf-8");
		}
		WEBEmail.sendMailByUrl("mujie@21-sun.com", null, null, CommonString.getFormatPara(one_proform.get("factoryname"))
				+ CommonString.getFormatPara(one_proform.get("product_name")) + CommonString.getFormatPara(one_proform.get("catalogname"))
				+ "询价单  -  来自中国工程机械商贸网(www.21-sun.com) 产品中心", "http://product.21-sun.com/tools/email/email_detail_new.jsp?uuid=" + uuid, "utf-8");
%>
