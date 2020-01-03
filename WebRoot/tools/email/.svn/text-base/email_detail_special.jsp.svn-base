<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.jerehnet.util.common.CommonString"%>
<%@page import="com.jerehnet.util.dbutil.DBHelper"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%
   String zd_name = CommonString.getFormatPara(request.getParameter("zd_name")) ;  // 获取uuid
   String zd_mobile_phone = CommonString.getFormatPara(request.getParameter("zd_mobile_phone")) ;  // 获取uuid
   String zd_contact_address = CommonString.getFormatPara(request.getParameter("zd_contact_address")) ;  // 获取uuid
   String zd_message = CommonString.getFormatPara(request.getParameter("zd_message")) ;  // 获取uuid
   String zd_pro = CommonString.getFormatPara(request.getParameter("zd_pro")) ;  // 获取uuid
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>订单通知--中国工程机械商贸网</title>
</head>
<body>
<base target="_blank" />
<style type="text/css">
html{ word-wrap:break-word;}
body{ background-color: #ffffff;font-size:14px; font-family:arial,verdana,sans-serif; line-height:180%; padding:10px 8px; margin:0; overflow:auto; color:#4d4d4d; text-align:center;}
</style>
<table width="653" border="0" cellspacing="0" cellpadding="0" align="center" style="margin:0 auto; text-align:left;">
  <tr>
    <td><a href="http://www.21-sun.com/" target="_blank"><img src="http://product.21-sun.com/images/mail02_img01.gif" alt="中国工程机械商贸网" width="127" height="75" border="0" /></a></td>
  </tr>
  <tr>
    <td style="line-height:0px; font-size:0px;"><img src="http://product.21-sun.com/images/mail02_img02.gif" alt="感谢您加入中国工程机械商贸网" width="653" height="105" /></td>
  </tr>
  <tr>
    <td style="vertical-align:top; border-bottom:#e5e5e5 1px solid; border-left:#e5e5e5 1px solid; border-right:#e5e5e5 1px solid; padding:20px; line-height:180%;">
        <p style="line-height:180%; margin-top:0px;"><span style="font-weight:bold;">尊敬的中国工程机械商贸网用户：</span><br />
        <span style="font-size:12px;">您好！</span><br />
        <span style="font-size:12px; padding-left:24px;">以下是来自中国工程机械商贸网(<a href="http://www.21-sun.com/" target="_blank" style="color:#4d4d4d;">www.21-sun.com</a>) 优买团活动订单:</span><br />
        <span style="font-size:12px; padding-left:24px; color:#969696;"><img src="http://product.21-sun.com/images/mail02_img03.gif" width="9" height="14" align="absmiddle" />友情提示：请关注来自网络的每一个订单，请阅后及时联系，以免错失商机！</span>
        </p>
        <p style="text-align:center; font-size:22px; font-weight:bold; font-family:微软雅黑; margin:0px; padding:10px;">关于<%=zd_pro%> 的询价单</p>
        <table width="610" border="0" cellspacing="0" cellpadding="0" style="font-size:12px; text-align:left;">
          <tr>
            <td width="20%" align="right" style="border-bottom:#b8b8b8 1px dotted; line-height:12px; background-color:#ffffff; padding:8px 20px 8px 0px;">订单人：</td>
            <td style="border-bottom:#b8b8b8 1px dotted; line-height:12px; background-color:#ffffff; color:#969696; padding:8px 0px;" width="80%"><%=zd_name%></td>
          </tr>


    

          <tr>
            <td align="right" style="border-bottom:#b8b8b8 1px dotted; line-height:12px; background-color:#f3f3f3; padding:8px 20px 8px 0px;">电话：</td>
            <td style="border-bottom:#b8b8b8 1px dotted; line-height:12px; background-color:#f3f3f3; color:#969696; padding:8px 0px;"><%=zd_mobile_phone%></td>
          </tr>

          <tr>
            <td align="right" style="border-bottom:#b8b8b8 1px dotted; line-height:12px; background-color:#f3f3f3; padding:8px 20px 8px 0px;">所在地区：</td>
            <td style="border-bottom:#b8b8b8 1px dotted; line-height:12px; background-color:#f3f3f3; color:#969696; padding:8px 0px;"><%=zd_contact_address%></td>
          </tr>

          <tr>
            <td align="right" style="border-bottom:#b8b8b8 1px dotted; line-height:12px; background-color:#f3f3f3; padding:8px 20px 8px 0px;">留言内容：</td>
            <td style="border-bottom:#b8b8b8 1px dotted; line-height:12px; background-color:#f3f3f3; color:#969696; padding:8px 0px;"><%=zd_message%></td>
          </tr>
        </table>
    </td>
  </tr>
  <tr>
    <td style="padding:20px;">
      <p style="margin:0px; font-size:14px;">以上信息是来自中国工程机械商贸网倾力打造的全新工程机械产品数据平台——"铁臂商城":</p>
      <p style="font-size:12px; color:#969696; margin:0px; line-height:22px; text-indent:2em;">该“产品中心”（<a href="http://product.21-sun.com/" target="_blank" style="color:#969696;">product.21-sun.com</a>）是目前国内最全面、最丰富、产品信息最完善的工程机械行业产品信息库。产品中心包含了近万余条产品、制造商和代理商信息以及相应的图片信息，给广大业内人士提供了一个快速、高效、实用的针对工程机械产品查询、比较和采购的网络平台。</p>
      <p style="font-size:12px; color:#969696; margin:0px; line-height:22px; text-indent:2em;">感谢您对商贸网的支持和关注！愿我们成为长期的合作伙伴！</p>
      <p style="font-size:12px; color:#969696; margin:0px; line-height:22px; text-indent:2em;">如您在其它方面有任何问题，如退订等，请拨打我们的热线电话：<span style="color:#e40000; font-weight:bold; font-size:14px;">400-521-526</span>，中国工程机械商贸网竭诚为您服务！</p>
    </td>
  </tr>
</table>
</body>
</html>
