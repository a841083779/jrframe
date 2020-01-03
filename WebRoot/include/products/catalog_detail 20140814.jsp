<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="com.jerehnet.util.common.CommonString"%>  
<%
	String factoryid = CommonString.getFormatPara(request.getParameter("factoy_id")) ;
	String catalog = CommonString.getFormatPara(request.getParameter("catalog")) ;
	String catalog_detail = CommonString.getFormatPara(request.getParameter("catalog_detail")) ;
	String tonandmeter = CommonString.getFormatPara(request.getParameter("tonandmeter")) ;
	String order = CommonString.getFormatPara(request.getParameter("order")) ;
	String flag = CommonString.getFormatPara(request.getParameter("flag")) ;
	String url = "/products/prolist_text.jsp";
	if(flag.equals("photo")){
		url = "/list.jsp";
	}
%>


<%if(catalog_detail.equals("101001")){%>
         
                       
             <a href="<%=url%>?catalog=101001001" target="_top" <%if("101001001".equals(catalog)){%> class='selected' <%}%>> 挖掘机 <i></i></a>
			 <a href="<%=url%>?catalog=101001004" target="_top" <%if("101001004".equals(catalog)){%> class='selected' <%}%>> 轮式挖掘机 <i></i></a>
             <a href="<%=url%>?catalog=101001006" target="_top" <%if("101001006".equals(catalog)){%> class='selected' <%}%>> 正铲挖掘机 <i></i></a>
             <a href="<%=url%>?catalog=101001007" target="_top" <%if("101001007".equals(catalog)){%> class='selected' <%}%>> 其它挖掘机 <i></i></a>
             <a href="<%=url%>?catalog=101001008" target="_top" <%if("101001008".equals(catalog)){%> class='selected' <%}%>> 反铲挖掘机 <i></i></a>
       <%  }else if(catalog_detail.equals("101002")){%>
	  
                      
             <a href="<%=url%>?catalog=101002003" target="_top" <%if("101002003".equals(catalog)){%> class='selected' <%}%>> 装载机 <i></i></a>
			  <a href="<%=url%>?catalog=101002007" target="_top" <%if("101002007".equals(catalog)){%> class='selected' <%}%>> 轮式装载机 <i></i></a>
             <a href="<%=url%>?catalog=101002004" target="_top" <%if("101002004".equals(catalog)){%> class='selected' <%}%>> 其它装载机 <i></i></a>
             <a href="<%=url%>?catalog=101002008" target="_top" <%if("101002008".equals(catalog)){%> class='selected' <%}%>> 挖掘装载机 <i></i></a>
             <a href="<%=url%>?catalog=101002009" target="_top" <%if("101002009".equals(catalog)){%> class='selected' <%}%>> 滑移装载机 <i></i></a>
             <a href="<%=url%>?catalog=101002010" target="_top" <%if("101002010".equals(catalog)){%> class='selected' <%}%>> 叉装机 <i></i></a>
           <%  }else if(catalog_detail.equals("101003")){%>
                      
             <a href="<%=url%>?catalog=101003001" target="_top" <%if("101003001".equals(catalog)){%> class='selected' <%}%>> 推土机 <i></i></a>
             <a href="<%=url%>?catalog=101003004" target="_top" <%if("101003004".equals(catalog)){%> class='selected' <%}%>> 轮式推土机 <i></i></a>
             
           
           <%  }else if(catalog_detail.equals("101004")){%>             
             <a href="<%=url%>?catalog=101004001" target="_top" <%if("101004001".equals(catalog)){%> class='selected' <%}%>> 自行式铲运机 <i></i></a>
             <a href="<%=url%>?catalog=101004003" target="_top" <%if("101004003".equals(catalog)){%> class='selected' <%}%>> 地下铲运机 <i></i></a>
           
          <%    }else if(catalog_detail.equals("101005")){%>
                        
             <a href="<%=url%>?catalog=101005002" target="_top" <%if("101005002".equals(catalog)){%> class='selected' <%}%>> 自行式平地机 <i></i></a>
            
           
         <%  }else if(catalog_detail.equals("101008")){%>             
             <a href="<%=url%>?catalog=101008003" target="_top" <%if("101008003".equals(catalog)){%> class='selected' <%}%>> 矿用车 <i></i></a>
             <a href="<%=url%>?catalog=101008002" target="_top" <%if("101008002".equals(catalog)){%> class='selected' <%}%>> 刚性自卸卡车 <i></i></a>
             <a href="<%=url%>?catalog=101008001" target="_top" <%if("101008001".equals(catalog)){%> class='selected' <%}%>> 铰接式自卸卡车 <i></i></a>
         <%  }else if(catalog_detail.equals("103002")){%>
                       
             <a href="<%=url%>?catalog=103002003" target="_top" <%if("103002003".equals(catalog)){%> class='selected' <%}%>> 搅拌楼 <i></i></a>
             <a href="<%=url%>?catalog=103002002" target="_top" <%if("103002002".equals(catalog)){%> class='selected' <%}%>> 搅拌站 <i></i></a>
             <a href="<%=url%>?catalog=103002001" target="_top" <%if("103002001".equals(catalog)){%> class='selected' <%}%>> 搅拌机 <i></i></a>
          <%    }else if(catalog_detail.equals("103005")){%>
                     
             <a href="<%=url%>?catalog=103005002" target="_top" <%if("103005002".equals(catalog)){%> class='selected' <%}%>> 布料机 <i></i></a>
             <a href="<%=url%>?catalog=103005001" target="_top" <%if("103005001".equals(catalog)){%> class='selected' <%}%>> 布料杆 <i></i></a>
           
         <%    }else if(catalog_detail.equals("104002")){%>              
             <a href="<%=url%>?catalog=104002011" target="_top" <%if("104002011".equals(catalog)){%> class='selected' <%}%>> 路面破碎机 <i></i></a>
             <a href="<%=url%>?catalog=104002010" target="_top" <%if("104002010".equals(catalog)){%> class='selected' <%}%>> 环卫机械 <i></i></a>
             <a href="<%=url%>?catalog=104002008" target="_top" <%if("104002008".equals(catalog)){%> class='selected' <%}%>> 清扫机 <i></i></a>
             <a href="<%=url%>?catalog=104002007" target="_top" <%if("104002007".equals(catalog)){%> class='selected' <%}%>> 洒水车 <i></i></a>
             <a href="<%=url%>?catalog=104002009" target="_top" <%if("104002009".equals(catalog)){%> class='selected' <%}%>> 沥青洒布车 <i></i></a>
             <a href="<%=url%>?catalog=104002006" target="_top" <%if("104002006".equals(catalog)){%> class='selected' <%}%>> 开槽机 <i></i></a>
             <a href="<%=url%>?catalog=104002005" target="_top" <%if("104002005".equals(catalog)){%> class='selected' <%}%>> 灌缝机械 <i></i></a>
             <a href="<%=url%>?catalog=104002004" target="_top" <%if("104002004".equals(catalog)){%> class='selected' <%}%>> 再生机械 <i></i></a>
           
          <%  }else if(catalog_detail.equals("104004")){%>              
             <a href="<%=url%>?catalog=104004001" target="_top" <%if("104004001".equals(catalog)){%> class='selected' <%}%>> 沥青混合料转运车 <i></i></a>
             <a href="<%=url%>?catalog=104004008" target="_top" <%if("104004008".equals(catalog)){%> class='selected' <%}%>> 碎石撒布机 <i></i></a>
             <a href="<%=url%>?catalog=104004005" target="_top" <%if("104004005".equals(catalog)){%> class='selected' <%}%>> 沥青搅拌机 <i></i></a>
           
          <%  }else if(catalog_detail.equals("104001")){%>               
             <a href="<%=url%>?catalog=104001006" target="_top" <%if("104001006".equals(catalog)){%> class='selected' <%}%>> 混凝土摊铺机 <i></i></a>
             <a href="<%=url%>?catalog=104001005" target="_top" <%if("104001005".equals(catalog)){%> class='selected' <%}%>> 滑模摊铺机 <i></i></a>
             <a href="<%=url%>?catalog=104001004" target="_top" <%if("104001004".equals(catalog)){%> class='selected' <%}%>> 熨平板 <i></i></a>
             <a href="<%=url%>?catalog=104001002" target="_top" <%if("104001002".equals(catalog)){%> class='selected' <%}%>> 履带式摊铺机 <i></i></a>
             <a href="<%=url%>?catalog=104001001" target="_top" <%if("104001001".equals(catalog)){%> class='selected' <%}%>> 轮式摊铺机 <i></i></a>
         <%     }else if(catalog_detail.equals("106001")){%>              
             <a href="<%=url%>?catalog=106001009" target="_top" <%if("106001009".equals(catalog)){%> class='selected' <%}%>> 振动压路机 <i></i></a>
             <a href="<%=url%>?catalog=106001008" target="_top" <%if("106001008".equals(catalog)){%> class='selected' <%}%>> 静碾压路机 <i></i></a>
             <a href="<%=url%>?catalog=106001006" target="_top" <%if("106001006".equals(catalog)){%> class='selected' <%}%>> 冲击式压路机 <i></i></a>
             <a href="<%=url%>?catalog=106001005" target="_top" <%if("106001005".equals(catalog)){%> class='selected' <%}%>> 轮胎压路机 <i></i></a>
             <a href="<%=url%>?catalog=106001004" target="_top" <%if("106001004".equals(catalog)){%> class='selected' <%}%>> 光轮压路机 <i></i></a>
             <a href="<%=url%>?catalog=106001003" target="_top" <%if("106001003".equals(catalog)){%> class='selected' <%}%>> 三轮压路机 <i></i></a>
             <a href="<%=url%>?catalog=106001002" target="_top" <%if("106001002".equals(catalog)){%> class='selected' <%}%>> 双钢轮压路机 <i></i></a>
             <a href="<%=url%>?catalog=106001001" target="_top" <%if("106001001".equals(catalog)){%> class='selected' <%}%>> 单钢轮压路机 <i></i></a>
         <%  }else if(catalog_detail.equals("107001")){%>
                       
             <a href="<%=url%>?catalog=107001003" target="_top" <%if("107001003".equals(catalog)){%> class='selected' <%}%>> 侧面叉车 <i></i></a>
			 <a href="<%=url%>?catalog=107001002" target="_top" <%if("107001002".equals(catalog)){%> class='selected' <%}%>> 重型叉车 <i></i></a>
			 <a href="<%=url%>?catalog=107001001" target="_top" <%if("107001001".equals(catalog)){%> class='selected' <%}%>> 普通内燃叉车 <i></i></a>
		
           
 <%}%>