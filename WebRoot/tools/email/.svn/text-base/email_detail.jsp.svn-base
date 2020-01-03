<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.jerehnet.util.common.CommonString"%>
<%@page import="com.jerehnet.util.dbutil.DBHelper"%>
<%@page import="com.jerehnet.util.common.CommonDate"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%
	DBHelper dbHelper = DBHelper.getInstance() ;
	String uuid = CommonString.getFormatPara(request.getParameter("uuid")) ;  // 获取uuid
	Map oneOrderInfo = new HashMap() ;
	if(!"".equals(uuid)){
		  oneOrderInfo = dbHelper.getMap(" select  * from pro_product_form where uuid='"+uuid+"'") ;
	}
	if(null == oneOrderInfo){
		oneOrderInfo = new HashMap() ;
	}
	String factoryid = CommonString.getFormatPara(oneOrderInfo.get("factoryid")) ;  // 品牌id 
	String product_id = CommonString.getFormatPara(oneOrderInfo.get("product_id")) ;
	Map product_info = null ;
	if(!"".equals(product_id)){
		product_info  = dbHelper.getMap(" select * from pro_products where id='"+product_id+"'") ;
	}
	if(null==product_info){
		product_info = new HashMap() ;
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>无标题文档</title>
<style type="text/css">
body { background-color: #ffffff; margin-left: 0px; margin-top: 0px; margin-right: 0px; margin-bottom: 0px; }
body,td,th { font-family: Verdana, Geneva, sans-serif; }
</style>
</head>
<body>
<div style="width:668px; margin:0 auto; padding:0px; font-family:微软雅黑; background-color:#f7f7f7;">
  <div style="width:100%; height:86px; border-top:#286f9d 4px solid; background-color:#fff;">
    <div style="float:left;"><a href="http://product.21-sun.com" target="_blank">
    <img src="http://product.21-sun.com/images/pro_21sunlogo.gif" style=" border:none" alt="产品中心-中国工程机械商贸网" title="产品中心-中国工程机械商贸网" /></a></div>
    <div style="float:right; line-height:86px; font-size:14px;"><strong>热线电话：<span style="color:#ff0000; font-size:18px">0535-6792733</span></strong></div>
  </div>
  <div style="clear:both;"><img src="http://product.21-sun.com/images/mail_shadow.gif" /></div>
  <div style="padding:20px; font-size:14px; line-height:24px; color:#555555;">
    <span style="color:#545454; font-size:18px; font-weight:bold;">尊敬的中国工程机械商贸网用户：</span><br />
        您好！<br />
    　　以下是来自中国工程机械商贸网<a href="http://www.21-sun.com" target="_blank">(www.21-sun.com)</a> 产品中心有关贵公司产品的询价单:<br />
    　　<span style="color:#ff0000">(友情提示：请关注来自网络的每一个订单，请阅后及时联系，以免错失商机！)</span><br />
    <div style="text-align:center; font-size:18px; color:#003f97; font-weight:bold; line-height:30px; padding:15px 0px;">关于<a href="http://product.21-sun.com/proDetail/<%=CommonString.getFormatPara(product_info.get("file_name")) %>" target="_blank"><%=CommonString.getFormatPara(oneOrderInfo.get("factoryname")) %> <%=CommonString.getFormatPara(oneOrderInfo.get("product_name"))%><%=CommonString.getFormatPara(oneOrderInfo.get("catalogname")) %></a> 的询价单</div>
    <table width="628" border="0" cellspacing="1" cellpadding="0" bgcolor="#c6c6c6">
      <tr>
        <td width="108" height="22" align="right" bgcolor="#ffffff"><strong>订单人：</strong></td>
        <td width="517" bgcolor="#ffffff"><%=CommonString.getFormatPara(oneOrderInfo.get("name")) %></td>
      </tr>
      <tr>
        <td height="22" align="right" bgcolor="#ffffff"><strong>产品型号：</strong></td>
        <td bgcolor="#ffffff"><%=CommonString.getFormatPara(oneOrderInfo.get("product_name")) %></td>
      </tr>
      <tr>
        <td height="22" align="right" bgcolor="#ffffff"><strong>产品类别：</strong></td>
        <td bgcolor="#ffffff"><%=CommonString.getFormatPara(oneOrderInfo.get("cataname")) %></td>
      </tr>
      <tr>
        <td height="22" align="right" bgcolor="#ffffff"><strong>所属厂家：</strong></td>
        <td bgcolor="#ffffff"><%=CommonString.getFormatPara(oneOrderInfo.get("factoryname")) %></td>
      </tr>
      <tr>
        <td height="22" align="right" bgcolor="#ffffff"><strong>代理商：</strong></td>
        <td bgcolor="#ffffff">&nbsp;<%=CommonString.getFormatPara(oneOrderInfo.get("agentname")) %></td>
      </tr>
      <tr>
        <td height="22" align="right" bgcolor="#ffffff"><strong>手机：</strong></td>
        <td bgcolor="#ffffff"><%=CommonString.getFormatPara(oneOrderInfo.get("mobile_phone")) %></td>
      </tr>
      <tr>
        <td height="22" align="right" bgcolor="#ffffff"><strong>固定电话：</strong></td>
        <td bgcolor="#ffffff"><%=CommonString.getFormatPara(oneOrderInfo.get("contact_tel")) %></td>
      </tr>
      <tr>
        <td height="22" align="right" bgcolor="#ffffff"><strong>所在地区：</strong></td>
        <td bgcolor="#ffffff"><%=CommonString.getFormatPara(oneOrderInfo.get("contact_address")) %></td>
      </tr>
      <tr>
        <td height="22" align="right" bgcolor="#ffffff"><strong>所在公司：</strong></td>
        <td bgcolor="#ffffff"><%=CommonString.getFormatPara(oneOrderInfo.get("company")) %></td>
      </tr>
      <tr>
        <td height="22" align="right" bgcolor="#ffffff"><strong>公司地址：</strong></td>
        <td bgcolor="#ffffff"><%=CommonString.getFormatPara(oneOrderInfo.get("")) %></td>
      </tr>
      <tr>
        <td height="22" align="right" bgcolor="#ffffff"><strong>订购时间：</strong></td>
        <td bgcolor="#ffffff"><%=CommonString.getFormatPara(oneOrderInfo.get("add_date")).length()>16?CommonString.substringByte(CommonString.getFormatPara(oneOrderInfo.get("add_date")),16):CommonString.getFormatPara(oneOrderInfo.get("add_date")) %></td>
      </tr>
      <tr>
        <td height="22" align="right" bgcolor="#ffffff"><strong>留言内容：</strong></td>
        <td bgcolor="#ffffff"><%=CommonString.getFormatPara(oneOrderInfo.get("message")) %></td>
      </tr>
    </table>
    <div style="padding-top:10px;">
    　　<span style="color:#ff0000; font-size:18px;">以上信息是来自中国工程机械商贸网倾力打造的全新工程机械产品数据平台——“产品中心”:<br /></span>
    　　该“产品中心”<a href="http://product.21-sun.com" target="_blank">（product.21-sun.com）</a>是目前国内最全面、最丰富、产品信息最完善的工程机械行业产品信息库。产品中心包含了近万余条产品、制造商和代理商信息以及相应的图片信息，给广大业内人士提供了一个快速、高效、实用的针对工程机械产品查询、比较和采购的网络平台。<br />
    　　感谢您对商贸网的支持和关注！愿我们成为长期的合作伙伴！<br />
    　　如您在其它方面有任何问题，如退订等，请拨打我们的热线电话：<span style="color:#ff0000;">0535-6792733</span>，中国工程机械商贸网竭诚为您服务！<br />
    </div> 
  </div>
  <div><img src="http://product.21-sun.com/images/main_bottom.gif" width="668" height="42" /></div>
</div>
</body>
</html>

