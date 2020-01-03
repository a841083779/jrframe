<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="com.jerehnet.util.common.CommonString"%>  
<%
	String factoryid = CommonString.getFormatPara(request.getParameter("factoy_id")) ;
	String catalog = CommonString.getFormatPara(request.getParameter("catalog")) ;
	String catalog_detail = CommonString.getFormatPara(request.getParameter("catalog_detail")) ;
	String tonandmeter = CommonString.getFormatPara(request.getParameter("tonandmeter")) ;
	String order = CommonString.getFormatPara(request.getParameter("order")) ;
	String flag = CommonString.getFormatPara(request.getParameter("flag")) ;
	String url = "/products/prolist.jsp";
	if(flag.equals("photo")){
		url = "/list.jsp";
	}
%>


<%if(catalog_detail.equals("101001")){%>
         
                       
             <a href="<%=url%>?catalog=101001001<%= factoryid.equals("")?"":"&factory="+factoryid%>" target="_top" <%if("101001001".equals(catalog)){%> class='selected' <%}%>> 履带式挖掘机 <i></i></a>
			 <a href="<%=url%>?catalog=101001004<%= factoryid.equals("")?"":"&factory="+factoryid%>" target="_top" <%if("101001004".equals(catalog)){%> class='selected' <%}%>> 轮式挖掘机 <i></i></a>
             <a href="<%=url%>?catalog=101001006<%= factoryid.equals("")?"":"&factory="+factoryid%>" target="_top" <%if("101001006".equals(catalog)){%> class='selected' <%}%>> 正铲挖掘机 <i></i></a>
             <a href="<%=url%>?catalog=101001007<%= factoryid.equals("")?"":"&factory="+factoryid%>" target="_top" <%if("101001007".equals(catalog)){%> class='selected' <%}%>> 其它挖掘机 <i></i></a><br />
			 <a href="<%=url%>?catalog=101001<%= factoryid.equals("")?"":"&factory="+factoryid%>&tonandmeter=grab_1_13"<%if("grab_1_13".equals(tonandmeter)){%> class="selected" <%}%>>小挖(1T～13T)</a>
			 <a href="<%=url%>?catalog=101001<%= factoryid.equals("")?"":"&factory="+factoryid%>&tonandmeter=grab_14_30"<%if("grab_14_30".equals(tonandmeter)){%> class="selected"<%}%>>中挖(14T～30T)</a>
			 <a href="<%=url%>?catalog=101001<%= factoryid.equals("")?"":"&factory="+factoryid%>&tonandmeter=grab_30_1"<%if("grab_30_1".equals(tonandmeter)){%> class="selected" <%}%>>大挖(30T以上)</a>
          
            
       <%  }else if(catalog_detail.equals("101002")){%>
	         <a href="<%=url%>?catalog=101002007<%= factoryid.equals("")?"":"&factory="+factoryid%>" target="_top" <%if("101002007".equals(catalog)){%> class='selected' <%}%>> 轮式装载机 <i></i></a>
             <a href="<%=url%>?catalog=101002004<%= factoryid.equals("")?"":"&factory="+factoryid%>" target="_top" <%if("101002004".equals(catalog)){%> class='selected' <%}%>> 其它装载机 <i></i></a>
             <a href="<%=url%>?catalog=101002006<%= factoryid.equals("")?"":"&factory="+factoryid%>" target="_top" <%if("101002006".equals(catalog)){%> class='selected' <%}%>> 履带式装载机 <i></i></a>
             <a href="<%=url%>?catalog=101002010<%= factoryid.equals("")?"":"&factory="+factoryid%>" target="_top" <%if("101002010".equals(catalog)){%> class='selected' <%}%>> 叉装机 <i></i></a> <br />
			 <a href="<%=url%>?catalog=101002<%= factoryid.equals("")?"":"&factory="+factoryid%>&tonandmeter=loader_1_3"<%if("loader_1_3".equals(tonandmeter)){%> class="selected" <%}%>>3T以下</a>
		     <a href="<%=url%>?catalog=101002<%= factoryid.equals("")?"":"&factory="+factoryid%>&tonandmeter=loader_3_01"<%if("loader_3_01".equals(tonandmeter)){%> class="selected"<%}%>>3T</a>
			 <a href="<%=url%>?catalog=101002<%= factoryid.equals("")?"":"&factory="+factoryid%>&tonandmeter=loader_3_5"<%if("loader_3_5".equals(tonandmeter)){%> class="selected" <%}%>>3T～5T</a>
			 <a href="<%=url%>?catalog=101002<%= factoryid.equals("")?"":"&factory="+factoryid%>&tonandmeter=loader_5_1"<%if("loader_5_1".equals(tonandmeter)){%> class="selected" <%}%>>5T以上</a>
            
           <%  }else if(catalog_detail.equals("101003")){%>
                      
             <a href="<%=url%>?catalog=101003001<%= factoryid.equals("")?"":"&factory="+factoryid%>" target="_top" <%if("101003001".equals(catalog)){%> class='selected' <%}%>> 履带式推土机 <i></i></a>
             <a href="<%=url%>?catalog=101003004<%= factoryid.equals("")?"":"&factory="+factoryid%>" target="_top" <%if("101003004".equals(catalog)){%> class='selected' <%}%>> 轮式推土机 <i></i></a>
             
           
           <%  }else if(catalog_detail.equals("103020")){%>             
             <a href="<%=url%>?catalog=103020002<%= factoryid.equals("")?"":"&factory="+factoryid%>" target="_top" <%if("103020002".equals(catalog)){%> class='selected' <%}%>> 电动泵 <i></i></a>
             <a href="<%=url%>?catalog=103020001<%= factoryid.equals("")?"":"&factory="+factoryid%>" target="_top" <%if("103020001".equals(catalog)){%> class='selected' <%}%>> 柴油泵 <i></i></a>
             <%  }else if(catalog_detail.equals("101004")){%>             
             <a href="<%=url%>?catalog=101004001<%= factoryid.equals("")?"":"&factory="+factoryid%>" target="_top" <%if("101004001".equals(catalog)){%> class='selected' <%}%>> 自行式铲运机 <i></i></a>
             <a href="<%=url%>?catalog=101004003<%= factoryid.equals("")?"":"&factory="+factoryid%>" target="_top" <%if("101004003".equals(catalog)){%> class='selected' <%}%>> 地下铲运机 <i></i></a>
            
			 <%  }else if(catalog_detail.equals("101008")){%>             
             <a href="<%=url%>?catalog=101008003<%= factoryid.equals("")?"":"&factory="+factoryid%>" target="_top" <%if("101008003".equals(catalog)){%> class='selected' <%}%>> 矿用车 <i></i></a>
			  <a href="<%=url%>?catalog=101008<%= factoryid.equals("")?"":"&factory="+factoryid%>" target="_top" <%if("".equals(catalog)){%> class='selected' <%}%>> 自卸车 <i></i></a>
             <a href="<%=url%>?catalog=101008002<%= factoryid.equals("")?"":"&factory="+factoryid%>" target="_top" <%if("101008002".equals(catalog)){%> class='selected' <%}%>> 刚性自卸卡车 <i></i></a>
             <a href="<%=url%>?catalog=101008001<%= factoryid.equals("")?"":"&factory="+factoryid%>" target="_top" <%if("101008001".equals(catalog)){%> class='selected' <%}%>> 铰接式自卸卡车 <i></i></a>
         
			<%     }else if(catalog_detail.equals("106001")){%>              
             <a href="<%=url%>?catalog=106001009<%= factoryid.equals("")?"":"&factory=="+factoryid%>" target="_top" <%if("106001009".equals(catalog)){%> class='selected' <%}%>> 振动压路机 <i></i></a>
             <a href="<%=url%>?catalog=106001008<%= factoryid.equals("")?"":"&factory="+factoryid%>" target="_top" <%if("106001008".equals(catalog)){%> class='selected' <%}%>> 静碾压路机 <i></i></a>
             <a href="<%=url%>?catalog=106001006<%= factoryid.equals("")?"":"&factory="+factoryid%>" target="_top" <%if("106001006".equals(catalog)){%> class='selected' <%}%>> 冲击式压路机 <i></i></a>
             <a href="<%=url%>?catalog=106001005<%= factoryid.equals("")?"":"&factory="+factoryid%>" target="_top" <%if("106001005".equals(catalog)){%> class='selected' <%}%>> 轮胎压路机 <i></i></a>
             <a href="<%=url%>?catalog=106001004<%= factoryid.equals("")?"":"&factory="+factoryid%>" target="_top" <%if("106001004".equals(catalog)){%> class='selected' <%}%>> 光轮压路机 <i></i></a>
             <a href="<%=url%>?catalog=106001003<%= factoryid.equals("")?"":"&factory="+factoryid%>" target="_top" <%if("106001003".equals(catalog)){%> class='selected' <%}%>> 三轮压路机 <i></i></a>
             <a href="<%=url%>?catalog=106001002<%= factoryid.equals("")?"":"&factory="+factoryid%>" target="_top" <%if("106001002".equals(catalog)){%> class='selected' <%}%>> 双钢轮压路机 <i></i></a>
             <a href="<%=url%>?catalog=106001001<%= factoryid.equals("")?"":"&factory="+factoryid%>" target="_top" <%if("106001001".equals(catalog)){%> class='selected' <%}%>> 单钢轮压路机 <i></i></a>
            
			<%  }else if(catalog_detail.equals("104001")){%>               
             <a href="<%=url%>?catalog=104001005<%= factoryid.equals("")?"":"&factory="+factoryid%>" target="_top" <%if("104001005".equals(catalog)){%> class='selected' <%}%>> 滑模摊铺机 <i></i></a>
             <a href="<%=url%>?catalog=104001004<%= factoryid.equals("")?"":"&factory="+factoryid%>" target="_top" <%if("104001004".equals(catalog)){%> class='selected' <%}%>> 熨平板 <i></i></a>
             <a href="<%=url%>?catalog=104001002<%= factoryid.equals("")?"":"&factory="+factoryid%>" target="_top" <%if("104001002".equals(catalog)){%> class='selected' <%}%>> 履带式摊铺机 <i></i></a>
             <a href="<%=url%>?catalog=104001001<%= factoryid.equals("")?"":"&factory="+factoryid%>" target="_top" <%if("104001001".equals(catalog)){%> class='selected' <%}%>> 轮式摊铺机 <i></i></a>
            
			<%  }else if(catalog_detail.equals("103018")){%>               
             <a href="<%=url%>?catalog=103018002<%= factoryid.equals("")?"":"&factory="+factoryid%>" target="_top" <%if("103018002".equals(catalog)){%> class='selected' <%}%>> 电动 <i></i></a>
             <a href="<%=url%>?catalog=103018001<%= factoryid.equals("")?"":"&factory="+factoryid%>" target="_top" <%if("103018001".equals(catalog)){%> class='selected' <%}%>> 柴油 <i></i></a>
           <%}else if(catalog_detail.equals("102")){%>
		   		<a href="<%=url%>?catalog=102<%= factoryid.equals("")?"":"&factory="+factoryid%>&tonandmeter=crane_1_16"<%if("crane_1_16".equals(tonandmeter)){%> class="selected" <%}%>>16T以下</a>
				<a href="<%=url%>?catalog=102<%= factoryid.equals("")?"":"&factory="+factoryid%>&tonandmeter=crane_20_70"<%if("crane_20_70".equals(tonandmeter)){%> class="selected"<%}%>>20T～70T</a>
				<a href="<%=url%>?catalog=102<%= factoryid.equals("")?"":"&factory="+factoryid%>&tonandmeter=crane_70_1"<%if("crane_70_1".equals(tonandmeter)){%> class="selected" <%}%>>70T以上</a>
          
		   
		   
 <%}%>