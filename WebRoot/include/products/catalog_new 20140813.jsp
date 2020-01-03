<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="com.jerehnet.util.common.CommonString"%>  
<%
	String factoryid = CommonString.getFormatPara(request.getParameter("factoy_id")) ;
	String catalog = CommonString.getFormatPara(request.getParameter("catalog")) ;
	String catalog_first = CommonString.getFormatPara(request.getParameter("catalog_first")) ;
	String tonandmeter = CommonString.getFormatPara(request.getParameter("tonandmeter")) ;
	String order = CommonString.getFormatPara(request.getParameter("order")) ;
	String flag = CommonString.getFormatPara(request.getParameter("flag")) ;
	String url = "/products/prolist_text.jsp";
	if(flag.equals("photo")){
		url = "/list.jsp";
	}
%>


<%if(catalog_first.equals("101")){%>
         
                       
             <a href="<%=url%>?catalog=101003" target="_top" <%if("101003".equals(catalog)){%> class='selected' <%}%>> 推土机 <i></i></a>
             <a href="<%=url%>?catalog=101002" target="_top" <%if("101002".equals(catalog)){%> class='selected' <%}%>> 装载机 <i></i></a>
             <a href="<%=url%>?catalog=101001" target="_top" <%if("101001".equals(catalog)){%> class='selected' <%}%>> 挖掘机 <i></i></a>
             <a href="<%=url%>?catalog=101005" target="_top" <%if("101005".equals(catalog)){%> class='selected' <%}%>> 平地机 <i></i></a>
             <a href="<%=url%>?catalog=101004" target="_top" <%if("101004".equals(catalog)){%> class='selected' <%}%>> 铲运机 <i></i></a>
             <a href="<%=url%>?catalog=101008" target="_top" <%if("101008".equals(catalog)){%> class='selected' <%}%>> 自卸卡车 <i></i></a>
       <%  }else if(catalog_first.equals("102")){%>
	  
                      
             <a href="<%=url%>?catalog=102013" target="_top" <%if("102013".equals(catalog)){%> class='selected' <%}%>> 桥梁式起重机 <i></i></a>
             <a href="<%=url%>?catalog=102012" target="_top" <%if("102012".equals(catalog)){%> class='selected' <%}%>> 伸缩臂叉装机 <i></i></a>
             <a href="<%=url%>?catalog=102002" target="_top" <%if("102002".equals(catalog)){%> class='selected' <%}%>> 塔式起重机 <i></i></a>
             <a href="<%=url%>?catalog=102011" target="_top" <%if("102011".equals(catalog)){%> class='selected' <%}%>> 施工升降机 <i></i></a>
             <a href="<%=url%>?catalog=102010" target="_top" <%if("102010".equals(catalog)){%> class='selected' <%}%>> 高空作业车 <i></i></a>
             <a href="<%=url%>?catalog=102007" target="_top" <%if("102007".equals(catalog)){%> class='selected' <%}%>> 汽车起重机 <i></i></a>
             <a href="<%=url%>?catalog=102008" target="_top" <%if("102008".equals(catalog)){%> class='selected' <%}%>> 履带式起重机 <i></i></a>
             <a href="<%=url%>?catalog=102006" target="_top" <%if("102006".equals(catalog)){%> class='selected' <%}%>> 随车起重机 <i></i></a>
             <a href="<%=url%>?catalog=102003" target="_top" <%if("102003".equals(catalog)){%> class='selected' <%}%>> 高空作业平台 <i></i></a>
           <%  }else if(catalog_first.equals("103")){%>
                      
             <a href="<%=url%>?catalog=103008" target="_top" <%if("103008".equals(catalog)){%> class='selected' <%}%>> 干粉砂浆生产设备 <i></i></a>
             <a href="<%=url%>?catalog=103009" target="_top" <%if("103009".equals(catalog)){%> class='selected' <%}%>> 粉粒物料运输车 <i></i></a>
             <a href="<%=url%>?catalog=103005" target="_top" <%if("103005".equals(catalog)){%> class='selected' <%}%>> 混凝土布料设备 <i></i></a>
             <a href="<%=url%>?catalog=103006" target="_top" <%if("103006".equals(catalog)){%> class='selected' <%}%>> 混凝土搅拌运输车 <i></i></a>
             <a href="<%=url%>?catalog=103015" target="_top" <%if("103015".equals(catalog)){%> class='selected' <%}%>> 其它混凝土设备 <i></i></a>
             <a href="<%=url%>?catalog=103012" target="_top" <%if("103012".equals(catalog)){%> class='selected' <%}%>> 干混砂浆生产线 <i></i></a>
             <a href="<%=url%>?catalog=103011" target="_top" <%if("103011".equals(catalog)){%> class='selected' <%}%>> 沥青砂浆车 <i></i></a>
             <a href="<%=url%>?catalog=103014" target="_top" <%if("103014".equals(catalog)){%> class='selected' <%}%>> 干混砂浆背罐车 <i></i></a>
             <a href="<%=url%>?catalog=103002" target="_top" <%if("103002".equals(catalog)){%> class='selected' <%}%>> 混凝土搅拌设备 <i></i></a>
             <a href="<%=url%>?catalog=103001" target="_top" <%if("103001".equals(catalog)){%> class='selected' <%}%>> 混凝土泵车 <i></i></a>
             <a href="<%=url%>?catalog=103010" target="_top" <%if("103010".equals(catalog)){%> class='selected' <%}%>> 喷湿机 <i></i></a>
           
           <%  }else if(catalog_first.equals("104")){%>             
             <a href="<%=url%>?catalog=104006" target="_top" <%if("104006".equals(catalog)){%> class='selected' <%}%>> 稳定土拌合机 <i></i></a>
             <a href="<%=url%>?catalog=104005" target="_top" <%if("104005".equals(catalog)){%> class='selected' <%}%>> 铣刨机 <i></i></a>
             <a href="<%=url%>?catalog=104008" target="_top" <%if("104008".equals(catalog)){%> class='selected' <%}%>> 稳定土厂拌设备 <i></i></a>
             <a href="<%=url%>?catalog=104007" target="_top" <%if("104007".equals(catalog)){%> class='selected' <%}%>> 沥青混合料搅拌设备 <i></i></a>
             <a href="<%=url%>?catalog=104009" target="_top" <%if("104009".equals(catalog)){%> class='selected' <%}%>> 沥青搅拌站 <i></i></a>
             <a href="<%=url%>?catalog=104004" target="_top" <%if("104004".equals(catalog)){%> class='selected' <%}%>> 其它路面机械 <i></i></a>
             <a href="<%=url%>?catalog=104001" target="_top" <%if("104001".equals(catalog)){%> class='selected' <%}%>> 摊铺机 <i></i></a>
             <a href="<%=url%>?catalog=104002" target="_top" <%if("104002".equals(catalog)){%> class='selected' <%}%>> 养护机械 <i></i></a>
          <%    }else if(catalog_first.equals("105")){%>
                        
             <a href="<%=url%>?catalog=105017" target="_top" <%if("105017".equals(catalog)){%> class='selected' <%}%>> 强夯机 <i></i></a>
             <a href="<%=url%>?catalog=105018" target="_top" <%if("105018".equals(catalog)){%> class='selected' <%}%>> 长螺旋钻孔机 <i></i></a>
             <a href="<%=url%>?catalog=105009" target="_top" <%if("105009".equals(catalog)){%> class='selected' <%}%>> 液压静力压桩机 <i></i></a>
             <a href="<%=url%>?catalog=105019" target="_top" <%if("105019".equals(catalog)){%> class='selected' <%}%>> 多功能钻机 <i></i></a>
             <a href="<%=url%>?catalog=105007" target="_top" <%if("105007".equals(catalog)){%> class='selected' <%}%>> 连续墙抓斗 <i></i></a>
             <a href="<%=url%>?catalog=105028" target="_top" <%if("105028".equals(catalog)){%> class='selected' <%}%>> 截桩机/破桩机 <i></i></a>
             <a href="<%=url%>?catalog=105011" target="_top" <%if("105011".equals(catalog)){%> class='selected' <%}%>> 打桩机 <i></i></a>
             <a href="<%=url%>?catalog=105016" target="_top" <%if("105016".equals(catalog)){%> class='selected' <%}%>> 连续墙钻机 <i></i></a>
             <a href="<%=url%>?catalog=105015" target="_top" <%if("105015".equals(catalog)){%> class='selected' <%}%>> 打桩锤 <i></i></a>
             <a href="<%=url%>?catalog=105027" target="_top" <%if("105027".equals(catalog)){%> class='selected' <%}%>> 其它桩工机械 <i></i></a>
             <a href="<%=url%>?catalog=105026" target="_top" <%if("105026".equals(catalog)){%> class='selected' <%}%>> 多轴钻孔机 <i></i></a>
             <a href="<%=url%>?catalog=105013" target="_top" <%if("105013".equals(catalog)){%> class='selected' <%}%>> 液压步履式桩架 <i></i></a>
             <a href="<%=url%>?catalog=105003" target="_top" <%if("105003".equals(catalog)){%> class='selected' <%}%>> 旋挖钻机 <i></i></a>
             <a href="<%=url%>?catalog=105004" target="_top" <%if("105004".equals(catalog)){%> class='selected' <%}%>> 潜孔钻机 <i></i></a>
             <a href="<%=url%>?catalog=105005" target="_top" <%if("105005".equals(catalog)){%> class='selected' <%}%>> 水平定向钻 <i></i></a>
           
         <%  }else if(catalog_first.equals("106")){%>             
             <a href="<%=url%>?catalog=106004" target="_top" <%if("106004".equals(catalog)){%> class='selected' <%}%>> 夯实机 <i></i></a>
             <a href="<%=url%>?catalog=106003" target="_top" <%if("106003".equals(catalog)){%> class='selected' <%}%>> 压实机 <i></i></a>
             <a href="<%=url%>?catalog=106001" target="_top" <%if("106001".equals(catalog)){%> class='selected' <%}%>> 压路机 <i></i></a>
         <%  }else if(catalog_first.equals("107")){%>
                       
             <a href="<%=url%>?catalog=107010" target="_top" <%if("107010".equals(catalog)){%> class='selected' <%}%>> 专用叉车 <i></i></a>
             <a href="<%=url%>?catalog=107001" target="_top" <%if("107001".equals(catalog)){%> class='selected' <%}%>> 内燃叉车 <i></i></a>
             <a href="<%=url%>?catalog=107003" target="_top" <%if("107003".equals(catalog)){%> class='selected' <%}%>> 电动叉车 <i></i></a>
             <a href="<%=url%>?catalog=107005" target="_top" <%if("107005".equals(catalog)){%> class='selected' <%}%>> 仓储叉车 <i></i></a>
          <%    }else if(catalog_first.equals("109")){%>
                     
             <a href="<%=url%>?catalog=109004" target="_top" <%if("109004".equals(catalog)){%> class='selected' <%}%>> 提梁机 <i></i></a>
             <a href="<%=url%>?catalog=109005" target="_top" <%if("109005".equals(catalog)){%> class='selected' <%}%>> 检测车 <i></i></a>
             <a href="<%=url%>?catalog=109002" target="_top" <%if("109002".equals(catalog)){%> class='selected' <%}%>> 运梁车 <i></i></a>
             <a href="<%=url%>?catalog=109006" target="_top" <%if("109006".equals(catalog)){%> class='selected' <%}%>> 砂浆车 <i></i></a>
             <a href="<%=url%>?catalog=109001" target="_top" <%if("109001".equals(catalog)){%> class='selected' <%}%>> 架桥机 <i></i></a>
           
         <%    }else if(catalog_first.equals("110")){%>              
             <a href="<%=url%>?catalog=110010" target="_top" <%if("110010".equals(catalog)){%> class='selected' <%}%>> 凿岩钻车 <i></i></a>
             <a href="<%=url%>?catalog=110008" target="_top" <%if("110008".equals(catalog)){%> class='selected' <%}%>> 凿岩台车 <i></i></a>
             <a href="<%=url%>?catalog=110009" target="_top" <%if("110009".equals(catalog)){%> class='selected' <%}%>> 破碎机 <i></i></a>
             <a href="<%=url%>?catalog=110011" target="_top" <%if("110011".equals(catalog)){%> class='selected' <%}%>> 凿岩机和钻机 <i></i></a>
             <a href="<%=url%>?catalog=110012" target="_top" <%if("110012".equals(catalog)){%> class='selected' <%}%>> 筛分机 <i></i></a>
             <a href="<%=url%>?catalog=110013" target="_top" <%if("110013".equals(catalog)){%> class='selected' <%}%>> 装载及搬运设备 <i></i></a>
             <a href="<%=url%>?catalog=110014" target="_top" <%if("110014".equals(catalog)){%> class='selected' <%}%>> 连续采煤机和隧道掘进机 <i></i></a>
             <a href="<%=url%>?catalog=110005" target="_top" <%if("110005".equals(catalog)){%> class='selected' <%}%>> 采煤机 <i></i></a>
             <a href="<%=url%>?catalog=110015" target="_top" <%if("110015".equals(catalog)){%> class='selected' <%}%>> 输送和辅助设备 <i></i></a>
             <a href="<%=url%>?catalog=110002" target="_top" <%if("110002".equals(catalog)){%> class='selected' <%}%>> 矿用掘进机 <i></i></a>
             <a href="<%=url%>?catalog=110016" target="_top" <%if("110016".equals(catalog)){%> class='selected' <%}%>> 全液压凿岩钻机 <i></i></a>
             <a href="<%=url%>?catalog=110017" target="_top" <%if("110017".equals(catalog)){%> class='selected' <%}%>> 隧道轨道设备 <i></i></a>
             <a href="<%=url%>?catalog=110001" target="_top" <%if("110001".equals(catalog)){%> class='selected' <%}%>> 盾构掘进机 <i></i></a>
           
          <%  }else if(catalog_first.equals("111")){%>              
             <a href="<%=url%>?catalog=111003" target="_top" <%if("111003".equals(catalog)){%> class='selected' <%}%>> 吊具 <i></i></a>
             <a href="<%=url%>?catalog=111001" target="_top" <%if("111001".equals(catalog)){%> class='selected' <%}%>> 正面吊 <i></i></a>
             <a href="<%=url%>?catalog=111002" target="_top" <%if("111002".equals(catalog)){%> class='selected' <%}%>> 堆高机 <i></i></a>
             <a href="<%=url%>?catalog=111007" target="_top" <%if("111007".equals(catalog)){%> class='selected' <%}%>> 推耙机 <i></i></a>
             <a href="<%=url%>?catalog=111006" target="_top" <%if("111006".equals(catalog)){%> class='selected' <%}%>> 场桥 <i></i></a>
           
          <%  }else if(catalog_first.equals("113")){%>               
             <a href="<%=url%>?catalog=113002" target="_top" <%if("113002".equals(catalog)){%> class='selected' <%}%>> 液压剪 <i></i></a>
             <a href="<%=url%>?catalog=113001" target="_top" <%if("113001".equals(catalog)){%> class='selected' <%}%>> 破碎锤 <i></i></a>
           
         <%     }else if(catalog_first.equals("118")){%>              
             <a href="<%=url%>?catalog=118004" target="_top" <%if("118004".equals(catalog)){%> class='selected' <%}%>> 牵引车 <i></i></a>
             <a href="<%=url%>?catalog=118002" target="_top" <%if("118002".equals(catalog)){%> class='selected' <%}%>> 专用车辆 <i></i></a>
             <a href="<%=url%>?catalog=118003" target="_top" <%if("118003".equals(catalog)){%> class='selected' <%}%>> 消防车 <i></i></a>
         <%  }else if(catalog_first.equals("119")){%>
                       
             <a href="<%=url%>?catalog=119001" target="_top" <%if("119001".equals(catalog)){%> class='selected' <%}%>> 煤炭机械 <i></i></a>
           
 <%}%>