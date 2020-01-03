<%@ page language="java" import="java.util.*,com.jerehnet.util.common.*" pageEncoding="UTF-8"%>
<%@page import="com.jerehnet.util.dbutil.DBHelper"%>
<%@page import="com.jerehnet.util.dbutil.PageBean"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.Connection"%>
<%
	Map catalogMap = (Map)application.getAttribute("catalogMap") ;
    String flag = CommonString.getFormatPara(request.getParameter("flag")) ;
    String catalognum = CommonString.getFormatPara(request.getParameter("catalognum")) ;
	System.out.println("============="+catalognum);
    String province = CommonString.getFormatPara(request.getParameter("province")) ;
    String factoryid = CommonString.getFormatPara(request.getParameter("factoryid")) ;
	String nowPage = CommonString.getFormatPara(request.getParameter("nowPage"));
	int nowpage = Integer.parseInt(nowPage.equals("")?"1":nowPage) ;
	PageBean pageBean = new  PageBean() ;
	Connection conn = null ;
	Connection connection = null;
	
	Calendar calendar = Calendar.getInstance();//此时打印它获取的是系统当前时间
    String today = new SimpleDateFormat("yyyy-MM-dd").format(calendar.getTime())+"" ;
	calendar.add(Calendar.DATE, -1);  
	String yesday = new SimpleDateFormat("yyyy-MM-dd").format(calendar.getTime()) +"";

	String ts = CommonString.getFormatPara(request.getParameter("ts")); // 开始时间
	String te = CommonString.getFormatPara(request.getParameter("te")); // 结束时间
	if(ts.equals("undefined")||"".equals(ts)){
		ts = yesday ;   // 默认今天 
	}
	if(te.equals("undefined")||"".equals(te)){
		te = today ;   // 默认今天 
	}
	String whereStr = "" ;
	if(ts.equals(te)&&!ts.equals("")&&!te.equals("")){
		whereStr += " and add_date>='"+ts+" 00:00:00' and add_date<='"+te+" 23:59:59'" ;
	}else{
		whereStr += " and add_date>='"+ts+" 16:00:00' and add_date<='"+te+" 16:00:00'" ;
	}
	if(!"".equals(catalognum)){
		whereStr += " and catanum like '%"+catalognum+"%'" ;
	}
	if(!"".equals(province)){
		whereStr += " and province like '%"+province+"%'" ;
	}
	if(!"".equals(factoryid)){
		whereStr += " and factoryid = "+factoryid ;
	}
 
	//获得当前url
	//判断当前url是否有参数
    String url = CommonString.getFormatPara(request.getQueryString());
    DBHelper dbHelper = DBHelper.getInstance();
    
	
	   int a_1=0,a_2=0,a_3=0,a_4=0,a_5=0,a_6=0,a_7=0,a_8=0,a_9=0,a_10=0,a_11=0,a_12=0,a_13=0,a_14=0,a_15=0,a_16=0,a_17=0,a_18=0,a_19=0,a_20=0,a_21=0,a_22=0,a_23=0,a_24=0,a_25=0,a_26=0,a_27=0,a_28=0,a_29=0,a_30=0,a_31=0,a_32=0;
	   int b_1=0,b_2=0,b_3=0,b_4=0,b_5=0,b_6=0,b_7=0,b_8=0,b_9=0,b_10=0,b_11=0,b_12=0,b_13=0,b_14=0,b_15=0,b_16=0,b_17=0,b_18=0,b_19=0,b_20=0,b_21=0,b_22=0,b_23=0,b_24=0,b_25=0,b_26=0,b_27=0,b_28=0,b_29=0,b_30=0,b_31=0,b_32=0;
	   int c_1=0,c_2=0,c_3=0,c_4=0,c_5=0,c_6=0,c_7=0,c_8=0,c_9=0,c_10=0,c_11=0,c_12=0,c_13=0,c_14=0,c_15=0,c_16=0,c_17=0,c_18=0,c_19=0,c_20=0,c_21=0,c_22=0,c_23=0,c_24=0,c_25=0,c_26=0,c_27=0,c_28=0,c_29=0,c_30=0,c_31=0,c_32=0;
       int d_1=0,d_2=0,d_3=0,d_4=0,d_5=0,d_6=0,d_7=0,d_8=0,d_9=0,d_10=0,d_11=0,d_12=0,d_13=0,d_14=0,d_15=0,d_16=0,d_17=0,d_18=0,d_19=0,d_20=0,d_21=0,d_22=0,d_23=0,d_24=0,d_25=0,d_26=0,d_27=0,d_28=0,d_29=0,d_30=0,d_31=0,d_32=0;
       int e_1=0,e_2=0,e_3=0,e_4=0,e_5=0,e_6=0,e_7=0,e_8=0,e_9=0,e_10=0,e_11=0,e_12=0,e_13=0,e_14=0,e_15=0,e_16=0,e_17=0,e_18=0,e_19=0,e_20=0,e_21=0,e_22=0,e_23=0,e_24=0,e_25=0,e_26=0,e_27=0,e_28=0,e_29=0,e_30=0,e_31=0,e_32=0;
       int f_1=0,f_2=0,f_3=0,f_4=0,f_5=0,f_6=0,f_7=0,f_8=0,f_9=0,f_10=0,f_11=0,f_12=0,f_13=0,f_14=0,f_15=0,f_16=0,f_17=0,f_18=0,f_19=0,f_20=0,f_21=0,f_22=0,f_23=0,f_24=0,f_25=0,f_26=0,f_27=0,f_28=0,f_29=0,f_30=0,f_31=0,f_32=0;
       int g_1=0,g_2=0,g_3=0,g_4=0,g_5=0,g_6=0,g_7=0,g_8=0,g_9=0,g_10=0,g_11=0,g_12=0,g_13=0,g_14=0,g_15=0,g_16=0,g_17=0,g_18=0,g_19=0,g_20=0,g_21=0,g_22=0,g_23=0,g_24=0,g_25=0,g_26=0,g_27=0,g_28=0,g_29=0,g_30=0,g_31=0,g_32=0;
	   int h_1=0,h_2=0,h_3=0,h_4=0,h_5=0,h_6=0,h_7=0,h_8=0,h_9=0,h_10=0,h_11=0,h_12=0,h_13=0,h_14=0,h_15=0,h_16=0,h_17=0,h_18=0,h_19=0,h_20=0,h_21=0,h_22=0,h_23=0,h_24=0,h_25=0,h_26=0,h_27=0,h_28=0,h_29=0,h_30=0,h_31=0,h_32=0;
	   int i_1=0,i_2=0,i_3=0,i_4=0,i_5=0,i_6=0,i_7=0,i_8=0,i_9=0,i_10=0,i_11=0,i_12=0,i_13=0,i_14=0,i_15=0,i_16=0,i_17=0,i_18=0,i_19=0,i_20=0,i_21=0,i_22=0,i_23=0,i_24=0,i_25=0,i_26=0,i_27=0,i_28=0,i_29=0,i_30=0,i_31=0,i_32=0;
	   int j_1=0,j_2=0,j_3=0,j_4=0,j_5=0,j_6=0,j_7=0,j_8=0,j_9=0,j_10=0,j_11=0,j_12=0,j_13=0,j_14=0,j_15=0,j_16=0,j_17=0,j_18=0,j_19=0,j_20=0,j_21=0,j_22=0,j_23=0,j_24=0,j_25=0,j_26=0,j_27=0,j_28=0,j_29=0,j_30=0,j_31=0,j_32=0;
	   int k_1=0,k_2=0,k_3=0,k_4=0,k_5=0,k_6=0,k_7=0,k_8=0,k_9=0,k_10=0,k_11=0,k_12=0,k_13=0,k_14=0,k_15=0,k_16=0,k_17=0,k_18=0,k_19=0,k_20=0,k_21=0,k_22=0,k_23=0,k_24=0,k_25=0,k_26=0,k_27=0,k_28=0,k_29=0,k_30=0,k_31=0,k_32=0;
	   int l_1=0,l_2=0,l_3=0,l_4=0,l_5=0,l_6=0,l_7=0,l_8=0,l_9=0,l_10=0,l_11=0,l_12=0,l_13=0,l_14=0,l_15=0,l_16=0,l_17=0,l_18=0,l_19=0,l_20=0,l_21=0,l_22=0,l_23=0,l_24=0,l_25=0,l_26=0,l_27=0,l_28=0,l_29=0,l_30=0,l_31=0,l_32=0;
	   int m_1=0,m_2=0,m_3=0,m_4=0,m_5=0,m_6=0,m_7=0,m_8=0,m_9=0,m_10=0,m_11=0,m_12=0,m_13=0,m_14=0,m_15=0,m_16=0,m_17=0,m_18=0,m_19=0,m_20=0,m_21=0,m_22=0,m_23=0,m_24=0,m_25=0,m_26=0,m_27=0,m_28=0,m_29=0,m_30=0,m_31=0,m_32=0;
	   int n_1=0,n_2=0,n_3=0,n_4=0,n_5=0,n_6=0,n_7=0,n_8=0,n_9=0,n_10=0,n_11=0,n_12=0,n_13=0,n_14=0,n_15=0,n_16=0,n_17=0,n_18=0,n_19=0,n_20=0,n_21=0,n_22=0,n_23=0,n_24=0,n_25=0,n_26=0,n_27=0,n_28=0,n_29=0,n_30=0,n_31=0,n_32=0;
	   
	   int o_1=0,o_2=0,o_3=0,o_4=0,o_5=0,o_6=0,o_7=0,o_8=0,o_9=0,o_10=0,o_11=0,o_12=0,o_13=0,o_14=0,o_15=0,o_16=0,o_17=0,o_18=0,o_19=0,o_20=0,o_21=0,o_22=0,o_23=0,o_24=0,o_25=0,o_26=0,o_27=0,o_28=0,o_29=0,o_30=0,o_31=0,o_32=0;
	   int p_1=0,p_2=0,p_3=0,p_4=0,p_5=0,p_6=0,p_7=0,p_8=0,p_9=0,p_10=0,p_11=0,p_12=0,p_13=0,p_14=0,p_15=0,p_16=0,p_17=0,p_18=0,p_19=0,p_20=0,p_21=0,p_22=0,p_23=0,p_24=0,p_25=0,p_26=0,p_27=0,p_28=0,p_29=0,p_30=0,p_31=0,p_32=0;
	   int q_1=0,q_2=0,q_3=0,q_4=0,q_5=0,q_6=0,q_7=0,q_8=0,q_9=0,q_10=0,q_11=0,q_12=0,q_13=0,q_14=0,q_15=0,q_16=0,q_17=0,q_18=0,q_19=0,q_20=0,q_21=0,q_22=0,q_23=0,q_24=0,q_25=0,q_26=0,q_27=0,q_28=0,q_29=0,q_30=0,q_31=0,q_32=0;
	   int r_1=0,r_2=0,r_3=0,r_4=0,r_5=0,r_6=0,r_7=0,r_8=0,r_9=0,r_10=0,r_11=0,r_12=0,r_13=0,r_14=0,r_15=0,r_16=0,r_17=0,r_18=0,r_19=0,r_20=0,r_21=0,r_22=0,r_23=0,r_24=0,r_25=0,r_26=0,r_27=0,r_28=0,r_29=0,r_30=0,r_31=0,r_32=0;
	   int s_1=0,s_2=0,s_3=0,s_4=0,s_5=0,s_6=0,s_7=0,s_8=0,s_9=0,s_10=0,s_11=0,s_12=0,s_13=0,s_14=0,s_15=0,s_16=0,s_17=0,s_18=0,s_19=0,s_20=0,s_21=0,s_22=0,s_23=0,s_24=0,s_25=0,s_26=0,s_27=0,s_28=0,s_29=0,s_30=0,s_31=0,s_32=0;
	   
	   
	   int t_1=0,t_2=0,t_3=0,t_4=0,t_5=0,t_6=0,t_7=0,t_8=0,t_9=0,t_10=0,t_11=0,t_12=0,t_13=0,t_14=0,t_15=0,t_16=0,t_17=0,t_18=0,t_19=0,t_20=0,t_21=0,t_22=0,t_23=0,t_24=0,t_25=0,t_26=0,t_27=0,t_28=0,t_29=0,t_30=0,t_31=0,t_32=0;
	   int u_1=0,u_2=0,u_3=0,u_4=0,u_5=0,u_6=0,u_7=0,u_8=0,u_9=0,u_10=0,u_11=0,u_12=0,u_13=0,u_14=0,u_15=0,u_16=0,u_17=0,u_18=0,u_19=0,u_20=0,u_21=0,u_22=0,u_23=0,u_24=0,u_25=0,u_26=0,u_27=0,u_28=0,u_29=0,u_30=0,u_31=0,u_32=0;
	
	try{
       
	    List<Map> list=dbHelper.getMapList("select   factoryid,count(factoryid) as counts,province from pro_product_form where is_deleted=0 "+whereStr+" group by factoryid,province   ");
	   

	
	if(list != null && list.size() > 0){
				for(Map m : list){
					if(CommonString.getFormatPara(m.get("province")).equals("北京")){
						
						if(CommonString.getFormatPara(m.get("factoryid")).equals("133")){
							a_1=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("209")){
							b_1=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("174")){
							c_1=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("136")){
							d_1=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("141")){
							e_1=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("138")){
							f_1=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("182")){
							g_1=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("137")){
							h_1=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("192")){
							i_1=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("175")){
							j_1=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("184")){
							k_1=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("135")){
							l_1=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("139")){
							m_1=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("183")){
							n_1=CommonString.getFormatInt(m.get("counts"));
						}
						else if(CommonString.getFormatPara(m.get("factoryid")).equals("194")){
							o_1=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("187")){
							p_1=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("190")){
							q_1=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("14238")){
							r_1=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("134")){
							s_1=CommonString.getFormatInt(m.get("counts"));
						}
						
						/*
						else if(CommonString.getFormatPara(m.get("factoryid")).equals("444444")){
							t_1=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("444444")){
							u_1=CommonString.getFormatInt(m.get("counts"));
						}
						*/
						
					}else if(CommonString.getFormatPara(m.get("province")).equals("天津")){
						
						if(CommonString.getFormatPara(m.get("factoryid")).equals("133")){
							a_2=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("209")){
							b_2=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("174")){
							c_2=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("136")){
							d_2=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("141")){
							e_2=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("138")){
							f_2=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("182")){
							g_2=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("137")){
							h_2=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("192")){
							i_2=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("175")){
							j_2=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("184")){
							k_2=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("135")){
							l_2=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("139")){
							m_2=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("183")){
							n_2=CommonString.getFormatInt(m.get("counts"));
						}
						else if(CommonString.getFormatPara(m.get("factoryid")).equals("194")){
							o_2=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("187")){
							p_2=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("190")){
							q_2=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("14238")){
							r_2=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("134")){
							s_2=CommonString.getFormatInt(m.get("counts"));
						}
					}else if(CommonString.getFormatPara(m.get("province")).equals("上海")){

						if(CommonString.getFormatPara(m.get("factoryid")).equals("133")){
							a_3=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("209")){
							b_3=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("174")){
							c_3=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("136")){
							d_3=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("141")){
							e_3=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("138")){
							f_3=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("182")){
							g_3=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("137")){
							h_3=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("192")){
							i_3=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("175")){
							j_3=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("184")){
							k_3=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("135")){
							l_3=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("139")){
							m_3=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("183")){
							n_3=CommonString.getFormatInt(m.get("counts"));
						}
						
						else if(CommonString.getFormatPara(m.get("factoryid")).equals("194")){
							o_3=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("187")){
							p_3=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("190")){
							q_3=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("14238")){
							r_3=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("134")){
							s_3=CommonString.getFormatInt(m.get("counts"));
						}
					
					}else if(CommonString.getFormatPara(m.get("province")).equals("广西")){
						
						if(CommonString.getFormatPara(m.get("factoryid")).equals("133")){
							a_4=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("209")){
							b_4=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("174")){
							c_4=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("136")){
							d_4=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("141")){
							e_4=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("138")){
							f_4=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("182")){
							g_4=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("137")){
							h_4=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("192")){
							i_4=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("175")){
							j_4=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("184")){
							k_4=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("135")){
							l_4=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("139")){
							m_4=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("183")){
							n_4=CommonString.getFormatInt(m.get("counts"));
						}
						
						else if(CommonString.getFormatPara(m.get("factoryid")).equals("194")){
							o_4=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("187")){
							p_4=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("190")){
							q_4=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("14238")){
							r_4=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("134")){
							s_4=CommonString.getFormatInt(m.get("counts"));
						}
						
					}else if(CommonString.getFormatPara(m.get("province")).equals("河北")){
						
						if(CommonString.getFormatPara(m.get("factoryid")).equals("133")){
							a_5=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("209")){
							b_5=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("174")){
							c_5=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("136")){
							d_5=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("141")){
							e_5=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("138")){
							f_5=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("182")){
							g_5=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("137")){
							h_5=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("192")){
							i_5=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("175")){
							j_5=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("184")){
							k_5=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("135")){
							l_5=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("139")){
							m_5=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("183")){
							n_5=CommonString.getFormatInt(m.get("counts"));
						}
						
						else if(CommonString.getFormatPara(m.get("factoryid")).equals("194")){
							o_5=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("187")){
							p_5=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("190")){
							q_5=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("14238")){
							r_5=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("134")){
							s_5=CommonString.getFormatInt(m.get("counts"));
						}
						
					}else if(CommonString.getFormatPara(m.get("province")).equals("江西")){
						
						if(CommonString.getFormatPara(m.get("factoryid")).equals("133")){
							a_6=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("209")){
							b_6=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("174")){
							c_6=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("136")){
							d_6=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("141")){
							e_6=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("138")){
							f_6=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("182")){
							j_6=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("137")){
							h_6=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("192")){
							i_6=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("175")){
							g_6=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("184")){
							k_6=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("135")){
							l_6=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("139")){
							m_6=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("183")){
							n_6=CommonString.getFormatInt(m.get("counts"));
						}
						
						else if(CommonString.getFormatPara(m.get("factoryid")).equals("194")){
							o_6=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("187")){
							p_6=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("190")){
							q_6=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("14238")){
							r_6=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("134")){
							s_6=CommonString.getFormatInt(m.get("counts"));
						}
						
					}else if(CommonString.getFormatPara(m.get("province")).equals("安徽")){
						
						if(CommonString.getFormatPara(m.get("factoryid")).equals("133")){
							a_7=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("209")){
							b_7=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("174")){
							c_7=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("136")){
							d_7=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("141")){
							e_7=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("138")){
							f_7=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("182")){
							j_7=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("137")){
							h_7=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("192")){
							i_7=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("175")){
							g_7=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("184")){
							k_7=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("135")){
							l_7=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("139")){
							m_7=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("183")){
							n_7=CommonString.getFormatInt(m.get("counts"));
						}
						
						else if(CommonString.getFormatPara(m.get("factoryid")).equals("194")){
							o_7=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("187")){
							p_7=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("190")){
							q_7=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("14238")){
							r_7=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("134")){
							s_7=CommonString.getFormatInt(m.get("counts"));
						}
						
						
					}else if(CommonString.getFormatPara(m.get("province")).equals("河南")){
						
						if(CommonString.getFormatPara(m.get("factoryid")).equals("133")){
							a_8=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("209")){
							b_8=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("174")){
							c_8=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("136")){
							d_8=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("141")){
							e_8=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("138")){
							f_8=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("182")){
							g_8=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("137")){
							h_8=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("192")){
							i_8=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("175")){
							j_8=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("184")){
							k_8=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("135")){
							l_8=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("139")){
							m_8=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("183")){
							n_8=CommonString.getFormatInt(m.get("counts"));
						}
						
						else if(CommonString.getFormatPara(m.get("factoryid")).equals("194")){
							o_8=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("187")){
							p_8=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("190")){
							q_8=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("14238")){
							r_8=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("134")){
							s_8=CommonString.getFormatInt(m.get("counts"));
						}
						
					}else if(CommonString.getFormatPara(m.get("province")).equals("贵州")){
						
						
						if(CommonString.getFormatPara(m.get("factoryid")).equals("133")){
							a_9=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("209")){
							b_9=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("174")){
							c_9=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("136")){
							d_9=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("141")){
							e_9=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("138")){
							f_9=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("182")){
							g_9=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("137")){
							h_9=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("192")){
							i_9=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("175")){
							j_9=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("184")){
							k_9=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("135")){
							l_9=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("139")){
							m_9=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("183")){
							n_9=CommonString.getFormatInt(m.get("counts"));
						}
						
						else if(CommonString.getFormatPara(m.get("factoryid")).equals("194")){
							o_9=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("187")){
							p_9=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("190")){
							q_9=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("14238")){
							r_9=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("134")){
							s_9=CommonString.getFormatInt(m.get("counts"));
						}
						
					}else if(CommonString.getFormatPara(m.get("province")).equals("山东")){
						
						if(CommonString.getFormatPara(m.get("factoryid")).equals("133")){
							a_10=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("209")){
							b_10=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("174")){
							c_10=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("136")){
							d_10=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("141")){
							e_10=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("138")){
							f_10=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("182")){
							g_10=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("137")){
							h_10=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("192")){
							i_10=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("175")){
							j_10=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("184")){
							k_10=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("135")){
							l_10=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("139")){
							m_10=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("183")){
							n_10=CommonString.getFormatInt(m.get("counts"));
						}
						
						else if(CommonString.getFormatPara(m.get("factoryid")).equals("194")){
							o_10=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("187")){
							p_10=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("190")){
							q_10=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("14238")){
							r_10=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("134")){
							s_10=CommonString.getFormatInt(m.get("counts"));
						}
						
						
					}else if(CommonString.getFormatPara(m.get("province")).equals("云南")){
						
						if(CommonString.getFormatPara(m.get("factoryid")).equals("133")){
							a_11=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("209")){
							b_11=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("174")){
							c_11=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("136")){
							d_11=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("141")){
							e_11=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("138")){
							f_11=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("182")){
							g_11=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("137")){
							h_11=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("192")){
							i_11=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("175")){
							j_11=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("184")){
							k_11=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("135")){
							l_11=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("139")){
							m_11=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("183")){
							n_11=CommonString.getFormatInt(m.get("counts"));
						}
						
						else if(CommonString.getFormatPara(m.get("factoryid")).equals("194")){
							o_11=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("187")){
							p_11=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("190")){
							q_11=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("14238")){
							r_11=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("134")){
							s_11=CommonString.getFormatInt(m.get("counts"));
						}
						
					}else if(CommonString.getFormatPara(m.get("province")).equals("青海")){
						
						if(CommonString.getFormatPara(m.get("factoryid")).equals("133")){
							a_12=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("209")){
							b_12=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("174")){
							c_12=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("136")){
							d_12=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("141")){
							e_12=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("138")){
							f_12=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("182")){
							g_12=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("137")){
							h_12=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("192")){
							i_12=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("175")){
							j_12=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("184")){
							k_12=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("135")){
							l_12=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("139")){
							m_12=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("183")){
							n_12=CommonString.getFormatInt(m.get("counts"));
						}
						
						else if(CommonString.getFormatPara(m.get("factoryid")).equals("194")){
							o_12=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("187")){
							p_12=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("190")){
							q_12=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("14238")){
							r_12=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("134")){
							s_12=CommonString.getFormatInt(m.get("counts"));
						}
						
					}else if(CommonString.getFormatPara(m.get("province")).equals("海南")){
						
						if(CommonString.getFormatPara(m.get("factoryid")).equals("133")){
							a_13=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("209")){
							b_13=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("174")){
							c_13=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("136")){
							d_13=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("141")){
							e_13=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("138")){
							f_13=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("182")){
							g_13=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("137")){
							h_13=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("192")){
							i_13=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("175")){
							j_13=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("184")){
							k_13=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("135")){
							l_13=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("139")){
							m_13=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("183")){
							n_13=CommonString.getFormatInt(m.get("counts"));
						}
						
						else if(CommonString.getFormatPara(m.get("factoryid")).equals("194")){
							o_13=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("187")){
							p_13=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("190")){
							q_13=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("14238")){
							r_13=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("134")){
							s_13=CommonString.getFormatInt(m.get("counts"));
						}
						
					}else if(CommonString.getFormatPara(m.get("province")).equals("内蒙古")){
						
						if(CommonString.getFormatPara(m.get("factoryid")).equals("133")){
							a_14=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("209")){
							b_14=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("174")){
							c_14=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("136")){
							d_14=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("141")){
							e_14=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("138")){
							f_14=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("182")){
							g_14=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("137")){
							h_14=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("192")){
							i_14=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("175")){
							j_14=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("184")){
							k_14=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("135")){
							l_14=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("139")){
							m_14=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("183")){
							n_14=CommonString.getFormatInt(m.get("counts"));
						}
						
						else if(CommonString.getFormatPara(m.get("factoryid")).equals("194")){
							o_14=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("187")){
							p_14=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("190")){
							q_14=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("14238")){
							r_14=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("134")){
							s_14=CommonString.getFormatInt(m.get("counts"));
						}
						
					}else if(CommonString.getFormatPara(m.get("province")).equals("福建")){
						
						if(CommonString.getFormatPara(m.get("factoryid")).equals("133")){
							a_15=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("209")){
							b_15=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("174")){
							c_15=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("136")){
							d_15=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("141")){
							e_15=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("138")){
							f_15=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("182")){
							g_15=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("137")){
							h_15=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("192")){
							i_15=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("175")){
							j_15=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("184")){
							k_15=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("135")){
							l_15=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("139")){
							m_15=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("183")){
							n_15=CommonString.getFormatInt(m.get("counts"));
						}
						
						else if(CommonString.getFormatPara(m.get("factoryid")).equals("194")){
							o_15=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("187")){
							p_15=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("190")){
							q_15=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("14238")){
							r_15=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("134")){
							s_15=CommonString.getFormatInt(m.get("counts"));
						}
						
					}else if(CommonString.getFormatPara(m.get("province")).equals("广东")){
						
						if(CommonString.getFormatPara(m.get("factoryid")).equals("133")){
							a_16=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("209")){
							b_16=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("174")){
							c_16=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("136")){
							d_16=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("141")){
							e_16=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("138")){
							f_16=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("182")){
							g_16=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("137")){
							h_16=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("192")){
							i_16=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("175")){
							j_16=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("184")){
							k_16=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("135")){
							l_16=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("139")){
							m_16=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("183")){
							n_16=CommonString.getFormatInt(m.get("counts"));
						}
						
						else if(CommonString.getFormatPara(m.get("factoryid")).equals("194")){
							o_16=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("187")){
							p_16=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("190")){
							q_16=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("14238")){
							r_16=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("134")){
							s_16=CommonString.getFormatInt(m.get("counts"));
						}
						
					}else if(CommonString.getFormatPara(m.get("province")).equals("新疆")){
						
						if(CommonString.getFormatPara(m.get("factoryid")).equals("133")){
							a_17=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("209")){
							b_17=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("174")){
							c_17=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("136")){
							d_17=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("141")){
							e_17=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("138")){
							f_17=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("182")){
							g_17=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("137")){
							h_17=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("192")){
							i_17=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("175")){
							j_17=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("184")){
							k_17=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("135")){
							l_17=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("139")){
							m_17=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("183")){
							n_17=CommonString.getFormatInt(m.get("counts"));
						}
						
						else if(CommonString.getFormatPara(m.get("factoryid")).equals("194")){
							o_17=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("187")){
							p_17=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("190")){
							q_17=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("14238")){
							r_17=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("134")){
							s_17=CommonString.getFormatInt(m.get("counts"));
						}
						
					}else if(CommonString.getFormatPara(m.get("province")).equals("湖北")){
						
						if(CommonString.getFormatPara(m.get("factoryid")).equals("133")){
							a_18=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("209")){
							b_18=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("174")){
							c_18=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("136")){
							d_18=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("141")){
							e_18=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("138")){
							f_18=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("182")){
							g_18=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("137")){
							h_18=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("192")){
							i_18=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("175")){
							j_18=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("184")){
							k_18=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("135")){
							l_18=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("139")){
							m_18=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("183")){
							n_18=CommonString.getFormatInt(m.get("counts"));
						}
						
						else if(CommonString.getFormatPara(m.get("factoryid")).equals("194")){
							o_18=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("187")){
							p_18=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("190")){
							q_18=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("14238")){
							r_18=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("134")){
							s_18=CommonString.getFormatInt(m.get("counts"));
						}
						
					}else if(CommonString.getFormatPara(m.get("province")).equals("山西")){
						
						if(CommonString.getFormatPara(m.get("factoryid")).equals("133")){
							a_19=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("209")){
							b_19=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("174")){
							c_19=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("136")){
							d_19=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("141")){
							e_19=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("138")){
							f_19=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("182")){
							g_19=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("137")){
							h_19=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("192")){
							i_19=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("175")){
							j_19=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("184")){
							k_19=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("135")){
							l_19=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("139")){
							m_19=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("183")){
							n_19=CommonString.getFormatInt(m.get("counts"));
						}
						
						else if(CommonString.getFormatPara(m.get("factoryid")).equals("194")){
							o_19=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("187")){
							p_19=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("190")){
							q_19=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("14238")){
							r_19=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("134")){
							s_19=CommonString.getFormatInt(m.get("counts"));
						}
						
					}else if(CommonString.getFormatPara(m.get("province")).equals("吉林")){
						
						if(CommonString.getFormatPara(m.get("factoryid")).equals("133")){
							a_20=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("209")){
							b_20=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("174")){
							c_20=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("136")){
							d_20=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("141")){
							e_20=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("138")){
							f_20=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("182")){
							g_20=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("137")){
							h_20=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("192")){
							i_20=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("175")){
							j_20=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("184")){
							k_20=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("135")){
							l_20=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("139")){
							m_20=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("183")){
							n_20=CommonString.getFormatInt(m.get("counts"));
						}
						
						else if(CommonString.getFormatPara(m.get("factoryid")).equals("194")){
							o_20=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("187")){
							p_20=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("190")){
							q_20=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("14238")){
							r_20=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("134")){
							s_20=CommonString.getFormatInt(m.get("counts"));
						}
						
					}else if(CommonString.getFormatPara(m.get("province")).equals("辽宁")){
						
						if(CommonString.getFormatPara(m.get("factoryid")).equals("133")){
							a_21=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("209")){
							b_21=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("174")){
							c_21=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("136")){
							d_21=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("141")){
							e_21=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("138")){
							f_21=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("182")){
							g_21=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("137")){
							h_21=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("192")){
							i_21=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("175")){
							j_21=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("184")){
							k_21=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("135")){
							l_21=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("139")){
							m_21=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("183")){
							n_21=CommonString.getFormatInt(m.get("counts"));
						}
						
						else if(CommonString.getFormatPara(m.get("factoryid")).equals("194")){
							o_21=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("187")){
							p_21=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("190")){
							q_21=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("14238")){
							r_21=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("134")){
							s_21=CommonString.getFormatInt(m.get("counts"));
						}
						
					}else if(CommonString.getFormatPara(m.get("province")).equals("黑龙江")){
						
						if(CommonString.getFormatPara(m.get("factoryid")).equals("133")){
							a_22=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("209")){
							b_22=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("174")){
							c_22=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("136")){
							d_22=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("141")){
							e_22=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("138")){
							f_22=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("182")){
							g_22=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("137")){
							h_22=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("192")){
							i_22=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("175")){
							j_22=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("184")){
							k_22=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("135")){
							l_22=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("139")){
							m_22=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("183")){
							n_22=CommonString.getFormatInt(m.get("counts"));
						}
						
						
						else if(CommonString.getFormatPara(m.get("factoryid")).equals("194")){
							o_22=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("187")){
							p_22=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("190")){
							q_22=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("14238")){
							r_22=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("134")){
							s_22=CommonString.getFormatInt(m.get("counts"));
						}
						
					}else if(CommonString.getFormatPara(m.get("province")).equals("甘肃")){
						
						if(CommonString.getFormatPara(m.get("factoryid")).equals("133")){
							a_23=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("209")){
							b_23=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("174")){
							c_23=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("136")){
							d_23=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("141")){
							e_23=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("138")){
							f_23=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("182")){
							g_23=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("137")){
							h_23=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("192")){
							i_23=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("175")){
							j_23=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("184")){
							k_23=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("135")){
							l_23=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("139")){
							m_23=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("183")){
							n_23=CommonString.getFormatInt(m.get("counts"));
						}
						
						
						else if(CommonString.getFormatPara(m.get("factoryid")).equals("194")){
							o_23=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("187")){
							p_23=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("190")){
							q_23=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("14238")){
							r_23=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("134")){
							s_23=CommonString.getFormatInt(m.get("counts"));
						}
						
					}else if(CommonString.getFormatPara(m.get("province")).equals("陕西")){
						
						if(CommonString.getFormatPara(m.get("factoryid")).equals("133")){
							a_24=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("209")){
							b_24=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("174")){
							c_24=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("136")){
							d_24=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("141")){
							e_24=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("138")){
							f_24=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("182")){
							g_24=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("137")){
							h_24=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("192")){
							i_24=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("175")){
							j_24=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("184")){
							k_24=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("135")){
							l_24=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("139")){
							m_24=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("183")){
							n_24=CommonString.getFormatInt(m.get("counts"));
						}
						
						else if(CommonString.getFormatPara(m.get("factoryid")).equals("194")){
							o_24=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("187")){
							p_24=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("190")){
							q_24=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("14238")){
							r_24=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("134")){
							s_24=CommonString.getFormatInt(m.get("counts"));
						}
						
					}else if(CommonString.getFormatPara(m.get("province")).equals("湖南")){
						
						if(CommonString.getFormatPara(m.get("factoryid")).equals("133")){
							a_25=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("209")){
							b_25=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("174")){
							c_25=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("136")){
							d_25=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("141")){
							e_25=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("138")){
							f_25=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("182")){
							g_25=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("137")){
							h_25=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("192")){
							i_25=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("175")){
							j_25=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("184")){
							k_25=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("135")){
							l_25=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("139")){
							m_25=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("183")){
							n_25=CommonString.getFormatInt(m.get("counts"));
						}
						
						else if(CommonString.getFormatPara(m.get("factoryid")).equals("194")){
							o_25=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("187")){
							p_25=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("190")){
							q_25=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("14238")){
							r_25=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("134")){
							s_25=CommonString.getFormatInt(m.get("counts"));
						}						
						
					}else if(CommonString.getFormatPara(m.get("province")).equals("江苏")){
						
						if(CommonString.getFormatPara(m.get("factoryid")).equals("133")){
							a_26=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("209")){
							b_26=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("174")){
							c_26=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("136")){
							d_26=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("141")){
							e_26=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("138")){
							f_26=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("182")){
							g_26=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("137")){
							h_26=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("192")){
							i_26=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("175")){
							j_26=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("184")){
							k_26=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("135")){
							l_26=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("139")){
							m_26=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("183")){
							n_26=CommonString.getFormatInt(m.get("counts"));
						}
						
						else if(CommonString.getFormatPara(m.get("factoryid")).equals("194")){
							o_26=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("187")){
							p_26=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("190")){
							q_26=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("14238")){
							r_26=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("134")){
							s_26=CommonString.getFormatInt(m.get("counts"));
						}	
						
					}else if(CommonString.getFormatPara(m.get("province")).equals("浙江")){
						
						if(CommonString.getFormatPara(m.get("factoryid")).equals("133")){
							a_27=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("209")){
							b_27=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("174")){
							c_27=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("136")){
							d_27=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("141")){
							e_27=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("138")){
							f_27=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("182")){
							g_27=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("137")){
							h_27=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("192")){
							i_27=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("175")){
							j_27=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("184")){
							k_27=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("135")){
							l_27=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("139")){
							m_27=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("183")){
							n_27=CommonString.getFormatInt(m.get("counts"));
						}
						
						else if(CommonString.getFormatPara(m.get("factoryid")).equals("194")){
							o_27=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("187")){
							p_27=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("190")){
							q_27=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("14238")){
							r_27=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("134")){
							s_27=CommonString.getFormatInt(m.get("counts"));
						}
						
					}else if(CommonString.getFormatPara(m.get("province")).equals("重庆")){
						
						if(CommonString.getFormatPara(m.get("factoryid")).equals("133")){
							a_28=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("209")){
							b_28=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("174")){
							c_28=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("136")){
							d_28=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("141")){
							e_28=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("138")){
							f_28=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("182")){
							g_28=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("137")){
							h_28=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("192")){
							i_28=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("175")){
							j_28=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("184")){
							k_28=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("135")){
							l_28=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("139")){
							m_28=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("183")){
							n_28=CommonString.getFormatInt(m.get("counts"));
						}
						
						else if(CommonString.getFormatPara(m.get("factoryid")).equals("194")){
							o_28=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("187")){
							p_28=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("190")){
							q_28=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("14238")){
							r_28=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("134")){
							s_28=CommonString.getFormatInt(m.get("counts"));
						}
						
					}else if(CommonString.getFormatPara(m.get("province")).equals("四川")){
						
						if(CommonString.getFormatPara(m.get("factoryid")).equals("133")){
							a_29=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("209")){
							b_29=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("174")){
							c_29=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("136")){
							d_29=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("141")){
							e_29=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("138")){
							f_29=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("182")){
							g_29=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("137")){
							h_29=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("192")){
							i_29=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("175")){
							j_29=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("184")){
							k_29=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("135")){
							l_29=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("139")){
							m_29=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("183")){
							n_29=CommonString.getFormatInt(m.get("counts"));
						}
						
						else if(CommonString.getFormatPara(m.get("factoryid")).equals("194")){
							o_29=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("187")){
							p_29=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("190")){
							q_29=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("14238")){
							r_29=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("134")){
							s_29=CommonString.getFormatInt(m.get("counts"));
						}
					}else if(CommonString.getFormatPara(m.get("province")).equals("宁夏")){
						
						
						if(CommonString.getFormatPara(m.get("factoryid")).equals("133")){
							a_30=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("209")){
							b_30=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("174")){
							c_30=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("136")){
							d_30=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("141")){
							e_30=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("138")){
							f_30=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("182")){
							g_30=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("137")){
							h_30=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("192")){
							i_30=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("175")){
							j_30=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("184")){
							k_30=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("135")){
							l_30=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("139")){
							m_30=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("183")){
							n_30=CommonString.getFormatInt(m.get("counts"));
						}
						else if(CommonString.getFormatPara(m.get("factoryid")).equals("194")){
							o_30=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("187")){
							p_30=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("190")){
							q_30=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("14238")){
							r_30=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("134")){
							s_30=CommonString.getFormatInt(m.get("counts"));
						}
					}else if(CommonString.getFormatPara(m.get("province")).equals("西藏")){
						
						if(CommonString.getFormatPara(m.get("factoryid")).equals("133")){
							a_31=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("209")){
							b_31=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("174")){
							c_31=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("136")){
							d_31=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("141")){
							e_31=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("138")){
							f_31=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("182")){
							g_31=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("137")){
							h_31=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("192")){
							i_31=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("175")){
							j_31=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("184")){
							k_31=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("135")){
							l_31=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("139")){
							m_31=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("183")){
							n_31=CommonString.getFormatInt(m.get("counts"));
						}
						else if(CommonString.getFormatPara(m.get("factoryid")).equals("194")){
							o_31=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("187")){
							p_31=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("190")){
							q_31=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("14238")){
							r_31=CommonString.getFormatInt(m.get("counts"));
						}else if(CommonString.getFormatPara(m.get("factoryid")).equals("134")){
							s_31=CommonString.getFormatInt(m.get("counts"));
						}
						
					}
				}
        }				
	   
	   //List<Map> list2=dbHelper.getMapList("select top 50  factoryid,count(factoryid) as a from pro_product_form where is_deleted=0 and province='天津' group by factoryid  order by count(factoryid) desc,factoryid desc  ");
	   //List<Map> list3=dbHelper.getMapList("select top 50  factoryid,count(factoryid) as a from pro_product_form where is_deleted=0 and province='上海' group by factoryid  order by count(factoryid) desc,factoryid desc  ");
	   //List<Map> list4=dbHelper.getMapList("select top 50  factoryid,count(factoryid) as a from pro_product_form where is_deleted=0 and province='广西' group by factoryid  order by count(factoryid) desc,factoryid desc  ");
	   //List<Map> list5=dbHelper.getMapList("select top 50  factoryid,count(factoryid) as a from pro_product_form where is_deleted=0 and province='河北' group by factoryid  order by count(factoryid) desc,factoryid desc  ");
	   //List<Map> list6=dbHelper.getMapList("select top 50  factoryid,count(factoryid) as a from pro_product_form where is_deleted=0 and province='江西' group by factoryid  order by count(factoryid) desc,factoryid desc  ");
	   //List<Map> list7=dbHelper.getMapList("select top 50  factoryid,count(factoryid) as a from pro_product_form where is_deleted=0 and province='安徽' group by factoryid  order by count(factoryid) desc,factoryid desc  ");
	   //List<Map> list8=dbHelper.getMapList("select top 50  factoryid,count(factoryid) as a from pro_product_form where is_deleted=0 and province='河南' group by factoryid  order by count(factoryid) desc,factoryid desc  ");
	   
	   //List<Map> list9=dbHelper.getMapList("select top 50  factoryid,count(factoryid) as a from pro_product_form where is_deleted=0 and province='贵州' group by factoryid  order by count(factoryid) desc,factoryid desc  ");
	   //List<Map> list10=dbHelper.getMapList("select top 50  factoryid,count(factoryid) as a from pro_product_form where is_deleted=0 and province='山东' group by factoryid  order by count(factoryid) desc,factoryid desc  ");
	   //List<Map> list11=dbHelper.getMapList("select top 50  factoryid,count(factoryid) as a from pro_product_form where is_deleted=0 and province='云南' group by factoryid  order by count(factoryid) desc,factoryid desc  ");
	   //List<Map> list12=dbHelper.getMapList("select top 50  factoryid,count(factoryid) as a from pro_product_form where is_deleted=0 and province='青海' group by factoryid  order by count(factoryid) desc,factoryid desc  ");
	   //List<Map> list13=dbHelper.getMapList("select top 50  factoryid,count(factoryid) as a from pro_product_form where is_deleted=0 and province='海南' group by factoryid  order by count(factoryid) desc,factoryid desc  ");
	   //List<Map> list14=dbHelper.getMapList("select top 50  factoryid,count(factoryid) as a from pro_product_form where is_deleted=0 and province='内蒙古' group by factoryid  order by count(factoryid) desc,factoryid desc  ");
	   //List<Map> list15=dbHelper.getMapList("select top 50  factoryid,count(factoryid) as a from pro_product_form where is_deleted=0 and province='福建' group by factoryid  order by count(factoryid) desc,factoryid desc  ");
	   //List<Map> list16=dbHelper.getMapList("select top 50  factoryid,count(factoryid) as a from pro_product_form where is_deleted=0 and province='广东' group by factoryid  order by count(factoryid) desc,factoryid desc  ");
	   
	   //List<Map> list17=dbHelper.getMapList("select top 50  factoryid,count(factoryid) as a from pro_product_form where is_deleted=0 and province='新疆' group by factoryid  order by count(factoryid) desc,factoryid desc  ");
	   //List<Map> list18=dbHelper.getMapList("select top 50  factoryid,count(factoryid) as a from pro_product_form where is_deleted=0 and province='湖北' group by factoryid  order by count(factoryid) desc,factoryid desc  ");
	   //List<Map> list19=dbHelper.getMapList("select top 50  factoryid,count(factoryid) as a from pro_product_form where is_deleted=0 and province='山西' group by factoryid  order by count(factoryid) desc,factoryid desc  ");
	   //List<Map> list21=dbHelper.getMapList("select top 50  factoryid,count(factoryid) as a from pro_product_form where is_deleted=0 and province='吉林' group by factoryid  order by count(factoryid) desc,factoryid desc  ");
	   //List<Map> list22=dbHelper.getMapList("select top 50  factoryid,count(factoryid) as a from pro_product_form where is_deleted=0 and province='辽宁' group by factoryid  order by count(factoryid) desc,factoryid desc  ");
	   //List<Map> list23=dbHelper.getMapList("select top 50  factoryid,count(factoryid) as a from pro_product_form where is_deleted=0 and province='黑龙江' group by factoryid  order by count(factoryid) desc,factoryid desc  ");
	   //List<Map> list24=dbHelper.getMapList("select top 50  factoryid,count(factoryid) as a from pro_product_form where is_deleted=0 and province='甘肃' group by factoryid  order by count(factoryid) desc,factoryid desc  ");
	   //List<Map> list25=dbHelper.getMapList("select top 50  factoryid,count(factoryid) as a from pro_product_form where is_deleted=0 and province='陕西' group by factoryid  order by count(factoryid) desc,factoryid desc  ");
	   
	   //List<Map> list26=dbHelper.getMapList("select top 50  factoryid,count(factoryid) as a from pro_product_form where is_deleted=0 and province='湖南' group by factoryid  order by count(factoryid) desc,factoryid desc  ");
	   //List<Map> list27=dbHelper.getMapList("select top 50  factoryid,count(factoryid) as a from pro_product_form where is_deleted=0 and province='江苏' group by factoryid  order by count(factoryid) desc,factoryid desc  ");
	   //List<Map> list28=dbHelper.getMapList("select top 50  factoryid,count(factoryid) as a from pro_product_form where is_deleted=0 and province='浙江' group by factoryid  order by count(factoryid) desc,factoryid desc  ");
	   //List<Map> list29=dbHelper.getMapList("select top 50  factoryid,count(factoryid) as a from pro_product_form where is_deleted=0 and province='重庆' group by factoryid  order by count(factoryid) desc,factoryid desc  ");
	   //List<Map> list30=dbHelper.getMapList("select top 50  factoryid,count(factoryid) as a from pro_product_form where is_deleted=0 and province='四川' group by factoryid  order by count(factoryid) desc,factoryid desc  ");
	   //List<Map> list31=dbHelper.getMapList("select top 50  factoryid,count(factoryid) as a from pro_product_form where is_deleted=0 and province='宁夏' group by factoryid  order by count(factoryid) desc,factoryid desc  ");
	   //List<Map> list32=dbHelper.getMapList("select top 50  factoryid,count(factoryid) as a from pro_product_form where is_deleted=0 and province='西藏' group by factoryid  order by count(factoryid) desc,factoryid desc  ");

		//List<Map> orderList = pageBean.getDatas() ;
		List <Map> catalogAppList = (ArrayList<Map>)application.getAttribute("catalogList");
		List <Map> catalogList = CommonApplication.getTreeByPno("0", catalogAppList , "parentid","id");
		List<Map> brandList = (ArrayList)application.getAttribute("brandList") ;
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title><%=Env.getInstance().getProperty("project_name") %></title>
<link href="/plugin/ui/ligerUI/ligerUI/skins/Aqua/css/ligerui-all.css" rel="stylesheet" type="text/css" />
<link href="/plugin/ui/ligerUI/ligerUI/skins/Gray/css/all.css" rel="stylesheet" type="text/css" />
<link href="/plugin/ui/ligerUI/ligerUI/skins/ligerui-icons.css" rel="stylesheet" type="text/css" />
<link href="/backend/style/style.css" rel="stylesheet" type="text/css" />
<style type="text/css">
.l-grid-body-table tr td {
	height:25px;
}
.tableList01 {
	border:1px solid #D9D9D9;
	border-collapse:collapse;
}
.tableList01 th, .tableList01 td {
	border:1px solid #D9D9D9;
}
.tableList01 th {
	background-color:#F3F3F3;
	font-weight:bold;
	height:12px;
	line-height:12px;
	padding:10px 0;
	text-align:center;
}
.tableList01 th img {
	vertical-align:-2px;
}
.tableList01 td {
	color:#949494;
*line-height:60%;
	line-height:40%;
	padding:10px 0;
	text-align:center;
}
.tableList01 td.bt {
	text-align:left;
}
.tableList01 td.zt {
	color:#2E7FDC;
}
.tableList01 td.zt font {
	color:#D12610;
}
.tableList01 td.bt em.d {
	font-family:宋体;
}
.tableList01 td.blue a {
	display:inline-block;
	white-space:nowrap;
}
.tableList tr.hover td {
	background-color:#F9F9F9;
}
.orderSelect {
	background-color:#F8F8F8;
	clear:both;
	margin-bottom:10px;
}
.orderSelect td {
	padding:5px 18px;
}
.orderSelect .select01 {
	border:1px solid #B5B6B3;
	padding:3px;
}
.orderSelect .input03 {
	border:1px solid #B5B6B3;
	height:22px;
	line-height:22px;
	padding-left:5px;
	width:120px;
}
.orderSelect span.n {
	display:inline-block;
	float:left;
	height:24px;
	line-height:24px;
	padding-left:5px;
}
.orderSelect .btn01 {
	background:url("/images/btns.gif") no-repeat scroll 0 -248px transparent;
	border:medium none;
	cursor:pointer;
	height:27px;
	vertical-align:-2px;
	width:66px;
}
a.btn_search, a.btn_reset {
	background:url("/images/btns.gif") no-repeat scroll 0 0 transparent;
	cursor:pointer;
	display:inline-block;
	height:25px;
	margin-right:5px;
	width:auto;
}
a.btn_search span, a.btn_reset span {
	background:url("/images/btns.gif") no-repeat scroll 0 0 transparent;
	display:inline-block;
	height:25px;
	line-height:25px;
	padding:0 12px 0 30px;
	width:auto;
}
a.btn_search {
	background-position:left -248px;
	color:#FFFFFF !important;
}
a.btn_search span {
	background-position:right -248px;
}
a.btn_reset {
	background-position:left -325px;
	color:#333333 !important;
}
a.btn_reset span {
	background-position:right -325px;
}
.menuLinks {
	display:inline-block;
	padding-left:10px;
	white-space:nowrap;
	width:290px;
}
.menuLinks em {
	color:#BAB8B8;
	margin:0 13px;
}
a:link, a:visited {
	color:#444444;
	text-decoration:none;
}
.page {
	-moz-border-bottom-colors: none;
	-moz-border-left-colors: none;
	-moz-border-right-colors: none;
	-moz-border-top-colors: none;
	background: url("/images/pagebg.gif") repeat-x scroll center bottom #FFFFFF;
	border-image: none;
	border-width: medium 1px 1px;
	clear: both;
	height: 18px;
	line-height: 18px;
	padding: 7px;
	text-align: right;
}
</style>
<script src="/plugin/jquery/jquery.min.js" type="text/javascript"></script>
<script type="text/javascript" src="/plugin/date/My97DatePicker/WdatePicker.js"></script>
</head>
<script type="text/javascript" src="/plugin/chat/FusionChartsV3/FusionCharts.js"></script>
<script type="text/javascript" src="/scripts/pinyin.js"></script>
<body>
<form id="theform" name="theform" action="">
  <input type="hidden" name="t_flag" id="t_flag" value="<%=flag %>"/>
  <table width="100%" cellspacing="0" cellpadding="0" border="0" class="orderSelect">
    <tbody>
      <tr>
        <td><div class="menuLinks">统计时间：
            <input type="text" value="<%=ts %>" onfocus="WdatePicker({maxDate:'<%=CommonDate.getToday("yyyy-MM-dd") %>'})" style="*vertical-align: -5px;" class="input03 Wdate" id="ts" name="ts"/>
            ~
            <input type="text" value="<%=te %>" onfocus="WdatePicker({maxDate:'<%=CommonDate.getToday("yyyy-MM-dd") %>'})" style="*vertical-align: -5px;" class="input03 Wdate" id="te" name="te"/>
            <a href="javascript:;" onclick="checkInput();" class="btn_search"><span>查询</span></a> </div>
          <div class="menuLinks" style="float:left;">机<span class="span2">&nbsp;</span>型:
            <select class="jr_select" id="catalognum" name="catalognum">
              <option value="">--请选择--</option>
              <%if(catalogList != null){for(Map m : catalogList){%>
              <option value="<%=m.get("num")%>"><%=CommonForm.getSpace(m.get("num").toString(),1)%><%=m.get("name")%></option>
              <%}}%>
            </select>
          </div></td>
      </tr>
    </tbody>
  </table>
</form>
<div style="clear: left;"></div>
<div style="float:left;width:100%;height:30px;text-align:center;padding:3px;background-color:#ccc;line-height:30px;font-size:15px; font-family:微软雅黑; color:#434343;font-weight:bold;"> <b id="ts_date"><%=ts%></b>~<b id="te_date"><%=te%></b> </div>
<div style="width:100% ;float:left;margin-top:1px;height:100%;">
  <div style="height:72%;">
    <table width="100%;height:100%;" cellspacing="0" cellpadding="0" border="0" class="tableList tableList01">
      <tbody>
        <tr class="">
          <th width="4%">品牌/区域</th>
          <th width="2%">北京</th>
          <th width="2%">天津</th>
          <th width="2%">上海</th>
          <th width="2%">广西</th>
          <th width="2%">河北</th>
          <th width="2%">江西</th>
          <th width="2%">安徽</th>
          <th width="2%">河南</th>
          <th width="2%">贵州</th>
          <th width="2%">山东</th>
          <th width="2%">云南</th>
          <th width="2%">青海</th>
          <th width="2%">海南</th>
          <th width="2%">内蒙</th>
          <th width="2%">福建</th>
          <th width="2%">广东</th>
          <th width="2%">新疆</th>
          <th width="2%">湖北</th>
          <th width="2%">山西</th>
          <th width="2%">吉林</th>
          <th width="2%">辽宁</th>
          <th width="2%">黑龙</th>
          <th width="2%">甘肃</th>
          <th width="2%">陕西</th>
          <th width="2%">湖南</th>
          <th width="2%">江苏</th>
          <th width="2%">浙江</th>
          <th width="2%">重庆</th>
          <th width="2%">四川</th>
          <th width="2%">宁夏</th>
          <th width="2%">西藏</th>
        </tr>
        <tr class="">
          <td style="text-align:center;">三一</td>
          <td style="text-align: center;color: #000;"><%=a_1%></td>
          <td style="text-align: center;color: #000;"><%=a_2%></td>
          <td style="text-align: center;color: #000;"><%=a_3%></td>
          <td style="text-align: center;color: #000;"><%=a_4%></td>
          <td style="text-align: center;color: #000;"><%=a_5%></td>
          <td style="text-align: center;color: #000;"><%=a_6%></td>
          <td style="text-align: center;color: #000;"><%=a_7%></td>
          <td style="text-align: center;color: #000;"><%=a_8%></td>
          <td style="text-align: center;color: #000;"><%=a_9%></td>
          <td style="text-align: center;color: #000;"><%=a_10%></td>
          <td style="text-align: center;color: #000;"><%=a_11%></td>
          <td style="text-align: center;color: #000;"><%=a_12%></td>
          <td style="text-align: center;color: #000;"><%=a_13%></td>
          <td style="text-align: center;color: #000;"><%=a_14%></td>
          <td style="text-align: center;color: #000;"><%=a_15%></td>
          <td style="text-align: center;color: #000;"><%=a_16%></td>
          <td style="text-align: center;color: #000;"><%=a_17%></td>
          <td style="text-align: center;color: #000;"><%=a_18%></td>
          <td style="text-align: center;color: #000;"><%=a_19%></td>
          <td style="text-align: center;color: #000;"><%=a_20%></td>
          <td style="text-align: center;color: #000;"><%=a_21%></td>
          <td style="text-align: center;color: #000;"><%=a_22%></td>
          <td style="text-align: center;color: #000;"><%=a_23%></td>
          <td style="text-align: center;color: #000;"><%=a_24%></td>
          <td style="text-align: center;color: #000;"><%=a_25%></td>
          <td style="text-align: center;color: #000;"><%=a_26%></td>
          <td style="text-align: center;color: #000;"><%=a_27%></td>
          <td style="text-align: center;color: #000;"><%=a_28%></td>
          <td style="text-align: center;color: #000;"><%=a_29%></td>
          <td style="text-align: center;color: #000;"><%=a_30%></td>
          <td style="text-align: center;color: #000;"><%=a_31%></td>
        </tr>
        <tr class="">
          <td style="text-align:center;">徐工</td>
          <td style="text-align: center;color: #000;"><%=b_1%></td>
          <td style="text-align: center;color: #000;"><%=b_2%></td>
          <td style="text-align: center;color: #000;"><%=b_3%></td>
          <td style="text-align: center;color: #000;"><%=b_4%></td>
          <td style="text-align: center;color: #000;"><%=b_5%></td>
          <td style="text-align: center;color: #000;"><%=b_6%></td>
          <td style="text-align: center;color: #000;"><%=b_7%></td>
          <td style="text-align: center;color: #000;"><%=b_8%></td>
          <td style="text-align: center;color: #000;"><%=b_9%></td>
          <td style="text-align: center;color: #000;"><%=b_10%></td>
          <td style="text-align: center;color: #000;"><%=b_11%></td>
          <td style="text-align: center;color: #000;"><%=b_12%></td>
          <td style="text-align: center;color: #000;"><%=b_13%></td>
          <td style="text-align: center;color: #000;"><%=b_14%></td>
          <td style="text-align: center;color: #000;"><%=b_15%></td>
          <td style="text-align: center;color: #000;"><%=b_16%></td>
          <td style="text-align: center;color: #000;"><%=b_17%></td>
          <td style="text-align: center;color: #000;"><%=b_18%></td>
          <td style="text-align: center;color: #000;"><%=b_19%></td>
          <td style="text-align: center;color: #000;"><%=b_20%></td>
          <td style="text-align: center;color: #000;"><%=b_21%></td>
          <td style="text-align: center;color: #000;"><%=b_22%></td>
          <td style="text-align: center;color: #000;"><%=b_23%></td>
          <td style="text-align: center;color: #000;"><%=b_24%></td>
          <td style="text-align: center;color: #000;"><%=b_25%></td>
          <td style="text-align: center;color: #000;"><%=b_26%></td>
          <td style="text-align: center;color: #000;"><%=b_27%></td>
          <td style="text-align: center;color: #000;"><%=b_28%></td>
          <td style="text-align: center;color: #000;"><%=b_29%></td>
          <td style="text-align: center;color: #000;"><%=b_30%></td>
          <td style="text-align: center;color: #000;"><%=b_31%></td>
        </tr>
        </tr>
        
        <tr class="">
          <td style="text-align:center;">卡特</td>
          <td style="text-align: center;color: #000;"><%=c_1%></td>
          <td style="text-align: center;color: #000;"><%=c_2%></td>
          <td style="text-align: center;color: #000;"><%=c_3%></td>
          <td style="text-align: center;color: #000;"><%=c_4%></td>
          <td style="text-align: center;color: #000;"><%=c_5%></td>
          <td style="text-align: center;color: #000;"><%=c_6%></td>
          <td style="text-align: center;color: #000;"><%=c_7%></td>
          <td style="text-align: center;color: #000;"><%=c_8%></td>
          <td style="text-align: center;color: #000;"><%=c_9%></td>
          <td style="text-align: center;color: #000;"><%=c_10%></td>
          <td style="text-align: center;color: #000;"><%=c_11%></td>
          <td style="text-align: center;color: #000;"><%=c_12%></td>
          <td style="text-align: center;color: #000;"><%=c_13%></td>
          <td style="text-align: center;color: #000;"><%=c_14%></td>
          <td style="text-align: center;color: #000;"><%=c_15%></td>
          <td style="text-align: center;color: #000;"><%=c_16%></td>
          <td style="text-align: center;color: #000;"><%=c_17%></td>
          <td style="text-align: center;color: #000;"><%=c_18%></td>
          <td style="text-align: center;color: #000;"><%=c_19%></td>
          <td style="text-align: center;color: #000;"><%=c_20%></td>
          <td style="text-align: center;color: #000;"><%=c_21%></td>
          <td style="text-align: center;color: #000;"><%=c_22%></td>
          <td style="text-align: center;color: #000;"><%=c_23%></td>
          <td style="text-align: center;color: #000;"><%=c_24%></td>
          <td style="text-align: center;color: #000;"><%=c_25%></td>
          <td style="text-align: center;color: #000;"><%=c_26%></td>
          <td style="text-align: center;color: #000;"><%=c_27%></td>
          <td style="text-align: center;color: #000;"><%=c_28%></td>
          <td style="text-align: center;color: #000;"><%=c_29%></td>
          <td style="text-align: center;color: #000;"><%=c_30%></td>
          <td style="text-align: center;color: #000;"><%=c_31%></td>
        </tr>
        <tr class="">
          <td style="text-align:center;">柳工</td>
          <td style="text-align: center;color: #000;"><%=d_1%></td>
          <td style="text-align: center;color: #000;"><%=d_2%></td>
          <td style="text-align: center;color: #000;"><%=d_3%></td>
          <td style="text-align: center;color: #000;"><%=d_4%></td>
          <td style="text-align: center;color: #000;"><%=d_5%></td>
          <td style="text-align: center;color: #000;"><%=d_6%></td>
          <td style="text-align: center;color: #000;"><%=d_7%></td>
          <td style="text-align: center;color: #000;"><%=d_8%></td>
          <td style="text-align: center;color: #000;"><%=d_9%></td>
          <td style="text-align: center;color: #000;"><%=d_10%></td>
          <td style="text-align: center;color: #000;"><%=d_11%></td>
          <td style="text-align: center;color: #000;"><%=d_12%></td>
          <td style="text-align: center;color: #000;"><%=d_13%></td>
          <td style="text-align: center;color: #000;"><%=d_14%></td>
          <td style="text-align: center;color: #000;"><%=d_15%></td>
          <td style="text-align: center;color: #000;"><%=d_16%></td>
          <td style="text-align: center;color: #000;"><%=d_17%></td>
          <td style="text-align: center;color: #000;"><%=d_18%></td>
          <td style="text-align: center;color: #000;"><%=d_19%></td>
          <td style="text-align: center;color: #000;"><%=d_20%></td>
          <td style="text-align: center;color: #000;"><%=d_21%></td>
          <td style="text-align: center;color: #000;"><%=d_22%></td>
          <td style="text-align: center;color: #000;"><%=d_23%></td>
          <td style="text-align: center;color: #000;"><%=d_24%></td>
          <td style="text-align: center;color: #000;"><%=d_25%></td>
          <td style="text-align: center;color: #000;"><%=d_26%></td>
          <td style="text-align: center;color: #000;"><%=d_27%></td>
          <td style="text-align: center;color: #000;"><%=d_28%></td>
          <td style="text-align: center;color: #000;"><%=d_29%></td>
          <td style="text-align: center;color: #000;"><%=d_30%></td>
          <td style="text-align: center;color: #000;"><%=d_31%></td>
        </tr>
        <tr class="">
          <td style="text-align:center;">雷沃</td>
          <td style="text-align: center;color: #000;"><%=e_1%></td>
          <td style="text-align: center;color: #000;"><%=e_2%></td>
          <td style="text-align: center;color: #000;"><%=e_3%></td>
          <td style="text-align: center;color: #000;"><%=e_4%></td>
          <td style="text-align: center;color: #000;"><%=e_5%></td>
          <td style="text-align: center;color: #000;"><%=e_6%></td>
          <td style="text-align: center;color: #000;"><%=e_7%></td>
          <td style="text-align: center;color: #000;"><%=e_8%></td>
          <td style="text-align: center;color: #000;"><%=e_9%></td>
          <td style="text-align: center;color: #000;"><%=e_10%></td>
          <td style="text-align: center;color: #000;"><%=e_11%></td>
          <td style="text-align: center;color: #000;"><%=e_12%></td>
          <td style="text-align: center;color: #000;"><%=e_13%></td>
          <td style="text-align: center;color: #000;"><%=e_14%></td>
          <td style="text-align: center;color: #000;"><%=e_15%></td>
          <td style="text-align: center;color: #000;"><%=e_16%></td>
          <td style="text-align: center;color: #000;"><%=e_17%></td>
          <td style="text-align: center;color: #000;"><%=e_18%></td>
          <td style="text-align: center;color: #000;"><%=e_19%></td>
          <td style="text-align: center;color: #000;"><%=e_20%></td>
          <td style="text-align: center;color: #000;"><%=e_21%></td>
          <td style="text-align: center;color: #000;"><%=e_22%></td>
          <td style="text-align: center;color: #000;"><%=e_23%></td>
          <td style="text-align: center;color: #000;"><%=e_24%></td>
          <td style="text-align: center;color: #000;"><%=e_25%></td>
          <td style="text-align: center;color: #000;"><%=e_26%></td>
          <td style="text-align: center;color: #000;"><%=e_27%></td>
          <td style="text-align: center;color: #000;"><%=e_28%></td>
          <td style="text-align: center;color: #000;"><%=e_29%></td>
          <td style="text-align: center;color: #000;"><%=e_30%></td>
          <td style="text-align: center;color: #000;"><%=e_31%></td>
        </tr>
        <tr class="">
          <td style="text-align:center;">山工</td>
          <td style="text-align: center;color: #000;"><%=f_1%></td>
          <td style="text-align: center;color: #000;"><%=f_2%></td>
          <td style="text-align: center;color: #000;"><%=f_3%></td>
          <td style="text-align: center;color: #000;"><%=f_4%></td>
          <td style="text-align: center;color: #000;"><%=f_5%></td>
          <td style="text-align: center;color: #000;"><%=f_6%></td>
          <td style="text-align: center;color: #000;"><%=f_7%></td>
          <td style="text-align: center;color: #000;"><%=f_8%></td>
          <td style="text-align: center;color: #000;"><%=f_9%></td>
          <td style="text-align: center;color: #000;"><%=f_10%></td>
          <td style="text-align: center;color: #000;"><%=f_11%></td>
          <td style="text-align: center;color: #000;"><%=f_12%></td>
          <td style="text-align: center;color: #000;"><%=f_13%></td>
          <td style="text-align: center;color: #000;"><%=f_14%></td>
          <td style="text-align: center;color: #000;"><%=f_15%></td>
          <td style="text-align: center;color: #000;"><%=f_16%></td>
          <td style="text-align: center;color: #000;"><%=f_17%></td>
          <td style="text-align: center;color: #000;"><%=f_18%></td>
          <td style="text-align: center;color: #000;"><%=f_19%></td>
          <td style="text-align: center;color: #000;"><%=f_20%></td>
          <td style="text-align: center;color: #000;"><%=f_21%></td>
          <td style="text-align: center;color: #000;"><%=f_22%></td>
          <td style="text-align: center;color: #000;"><%=f_23%></td>
          <td style="text-align: center;color: #000;"><%=f_24%></td>
          <td style="text-align: center;color: #000;"><%=f_25%></td>
          <td style="text-align: center;color: #000;"><%=f_26%></td>
          <td style="text-align: center;color: #000;"><%=f_27%></td>
          <td style="text-align: center;color: #000;"><%=f_28%></td>
          <td style="text-align: center;color: #000;"><%=f_29%></td>
          <td style="text-align: center;color: #000;"><%=f_30%></td>
          <td style="text-align: center;color: #000;"><%=f_31%></td>
        </tr>
        <tr class="">
          <td style="text-align:center;">小松</td>
          <td style="text-align: center;color: #000;"><%=g_1%></td>
          <td style="text-align: center;color: #000;"><%=g_2%></td>
          <td style="text-align: center;color: #000;"><%=g_3%></td>
          <td style="text-align: center;color: #000;"><%=g_4%></td>
          <td style="text-align: center;color: #000;"><%=g_5%></td>
          <td style="text-align: center;color: #000;"><%=g_6%></td>
          <td style="text-align: center;color: #000;"><%=g_7%></td>
          <td style="text-align: center;color: #000;"><%=g_8%></td>
          <td style="text-align: center;color: #000;"><%=g_9%></td>
          <td style="text-align: center;color: #000;"><%=g_10%></td>
          <td style="text-align: center;color: #000;"><%=g_11%></td>
          <td style="text-align: center;color: #000;"><%=g_12%></td>
          <td style="text-align: center;color: #000;"><%=g_13%></td>
          <td style="text-align: center;color: #000;"><%=g_14%></td>
          <td style="text-align: center;color: #000;"><%=g_15%></td>
          <td style="text-align: center;color: #000;"><%=g_16%></td>
          <td style="text-align: center;color: #000;"><%=g_17%></td>
          <td style="text-align: center;color: #000;"><%=g_18%></td>
          <td style="text-align: center;color: #000;"><%=g_19%></td>
          <td style="text-align: center;color: #000;"><%=g_20%></td>
          <td style="text-align: center;color: #000;"><%=g_21%></td>
          <td style="text-align: center;color: #000;"><%=g_22%></td>
          <td style="text-align: center;color: #000;"><%=g_23%></td>
          <td style="text-align: center;color: #000;"><%=g_24%></td>
          <td style="text-align: center;color: #000;"><%=g_25%></td>
          <td style="text-align: center;color: #000;"><%=g_26%></td>
          <td style="text-align: center;color: #000;"><%=g_27%></td>
          <td style="text-align: center;color: #000;"><%=g_28%></td>
          <td style="text-align: center;color: #000;"><%=g_29%></td>
          <td style="text-align: center;color: #000;"><%=g_30%></td>
          <td style="text-align: center;color: #000;"><%=g_31%></td>
        </tr>
        <tr class="">
          <td style="text-align:center;">临工</td>
          <td style="text-align: center;color: #000;"><%=h_1%></td>
          <td style="text-align: center;color: #000;"><%=h_2%></td>
          <td style="text-align: center;color: #000;"><%=h_3%></td>
          <td style="text-align: center;color: #000;"><%=h_4%></td>
          <td style="text-align: center;color: #000;"><%=h_5%></td>
          <td style="text-align: center;color: #000;"><%=h_6%></td>
          <td style="text-align: center;color: #000;"><%=h_7%></td>
          <td style="text-align: center;color: #000;"><%=h_8%></td>
          <td style="text-align: center;color: #000;"><%=h_9%></td>
          <td style="text-align: center;color: #000;"><%=h_10%></td>
          <td style="text-align: center;color: #000;"><%=h_11%></td>
          <td style="text-align: center;color: #000;"><%=h_12%></td>
          <td style="text-align: center;color: #000;"><%=h_13%></td>
          <td style="text-align: center;color: #000;"><%=h_14%></td>
          <td style="text-align: center;color: #000;"><%=h_15%></td>
          <td style="text-align: center;color: #000;"><%=h_16%></td>
          <td style="text-align: center;color: #000;"><%=h_17%></td>
          <td style="text-align: center;color: #000;"><%=h_18%></td>
          <td style="text-align: center;color: #000;"><%=h_19%></td>
          <td style="text-align: center;color: #000;"><%=h_20%></td>
          <td style="text-align: center;color: #000;"><%=h_21%></td>
          <td style="text-align: center;color: #000;"><%=h_22%></td>
          <td style="text-align: center;color: #000;"><%=h_23%></td>
          <td style="text-align: center;color: #000;"><%=h_24%></td>
          <td style="text-align: center;color: #000;"><%=h_25%></td>
          <td style="text-align: center;color: #000;"><%=h_26%></td>
          <td style="text-align: center;color: #000;"><%=h_27%></td>
          <td style="text-align: center;color: #000;"><%=h_28%></td>
          <td style="text-align: center;color: #000;"><%=h_29%></td>
          <td style="text-align: center;color: #000;"><%=h_30%></td>
          <td style="text-align: center;color: #000;"><%=h_31%></td>
        </tr>
        <tr class="">
          <td style="text-align:center;">斗山</td>
          <td style="text-align: center;color: #000;"><%=i_1%></td>
          <td style="text-align: center;color: #000;"><%=i_2%></td>
          <td style="text-align: center;color: #000;"><%=i_3%></td>
          <td style="text-align: center;color: #000;"><%=i_4%></td>
          <td style="text-align: center;color: #000;"><%=i_5%></td>
          <td style="text-align: center;color: #000;"><%=i_6%></td>
          <td style="text-align: center;color: #000;"><%=i_7%></td>
          <td style="text-align: center;color: #000;"><%=i_8%></td>
          <td style="text-align: center;color: #000;"><%=i_9%></td>
          <td style="text-align: center;color: #000;"><%=i_10%></td>
          <td style="text-align: center;color: #000;"><%=i_11%></td>
          <td style="text-align: center;color: #000;"><%=i_12%></td>
          <td style="text-align: center;color: #000;"><%=i_13%></td>
          <td style="text-align: center;color: #000;"><%=i_14%></td>
          <td style="text-align: center;color: #000;"><%=i_15%></td>
          <td style="text-align: center;color: #000;"><%=i_16%></td>
          <td style="text-align: center;color: #000;"><%=i_17%></td>
          <td style="text-align: center;color: #000;"><%=i_18%></td>
          <td style="text-align: center;color: #000;"><%=i_19%></td>
          <td style="text-align: center;color: #000;"><%=i_20%></td>
          <td style="text-align: center;color: #000;"><%=i_21%></td>
          <td style="text-align: center;color: #000;"><%=i_22%></td>
          <td style="text-align: center;color: #000;"><%=i_23%></td>
          <td style="text-align: center;color: #000;"><%=i_24%></td>
          <td style="text-align: center;color: #000;"><%=i_25%></td>
          <td style="text-align: center;color: #000;"><%=i_26%></td>
          <td style="text-align: center;color: #000;"><%=i_27%></td>
          <td style="text-align: center;color: #000;"><%=i_28%></td>
          <td style="text-align: center;color: #000;"><%=i_29%></td>
          <td style="text-align: center;color: #000;"><%=i_30%></td>
          <td style="text-align: center;color: #000;"><%=i_31%></td>
        </tr>
        <tr class="">
          <td style="text-align:center;">沃尔沃</td>
          <td style="text-align: center;color: #000;"><%=j_1%></td>
          <td style="text-align: center;color: #000;"><%=j_2%></td>
          <td style="text-align: center;color: #000;"><%=j_3%></td>
          <td style="text-align: center;color: #000;"><%=j_4%></td>
          <td style="text-align: center;color: #000;"><%=j_5%></td>
          <td style="text-align: center;color: #000;"><%=j_6%></td>
          <td style="text-align: center;color: #000;"><%=j_7%></td>
          <td style="text-align: center;color: #000;"><%=j_8%></td>
          <td style="text-align: center;color: #000;"><%=j_9%></td>
          <td style="text-align: center;color: #000;"><%=j_10%></td>
          <td style="text-align: center;color: #000;"><%=j_11%></td>
          <td style="text-align: center;color: #000;"><%=j_12%></td>
          <td style="text-align: center;color: #000;"><%=j_13%></td>
          <td style="text-align: center;color: #000;"><%=j_14%></td>
          <td style="text-align: center;color: #000;"><%=j_15%></td>
          <td style="text-align: center;color: #000;"><%=j_16%></td>
          <td style="text-align: center;color: #000;"><%=j_17%></td>
          <td style="text-align: center;color: #000;"><%=j_18%></td>
          <td style="text-align: center;color: #000;"><%=j_19%></td>
          <td style="text-align: center;color: #000;"><%=j_20%></td>
          <td style="text-align: center;color: #000;"><%=j_21%></td>
          <td style="text-align: center;color: #000;"><%=j_22%></td>
          <td style="text-align: center;color: #000;"><%=j_23%></td>
          <td style="text-align: center;color: #000;"><%=j_24%></td>
          <td style="text-align: center;color: #000;"><%=j_25%></td>
          <td style="text-align: center;color: #000;"><%=j_26%></td>
          <td style="text-align: center;color: #000;"><%=j_27%></td>
          <td style="text-align: center;color: #000;"><%=j_28%></td>
          <td style="text-align: center;color: #000;"><%=j_29%></td>
          <td style="text-align: center;color: #000;"><%=j_30%></td>
          <td style="text-align: center;color: #000;"><%=j_31%></td>
        </tr>
        <tr class="">
          <td style="text-align:center;">日立</td>
          <td style="text-align: center;color: #000;"><%=k_1%></td>
          <td style="text-align: center;color: #000;"><%=k_2%></td>
          <td style="text-align: center;color: #000;"><%=k_3%></td>
          <td style="text-align: center;color: #000;"><%=k_4%></td>
          <td style="text-align: center;color: #000;"><%=k_5%></td>
          <td style="text-align: center;color: #000;"><%=k_6%></td>
          <td style="text-align: center;color: #000;"><%=k_7%></td>
          <td style="text-align: center;color: #000;"><%=k_8%></td>
          <td style="text-align: center;color: #000;"><%=k_9%></td>
          <td style="text-align: center;color: #000;"><%=k_10%></td>
          <td style="text-align: center;color: #000;"><%=k_11%></td>
          <td style="text-align: center;color: #000;"><%=k_12%></td>
          <td style="text-align: center;color: #000;"><%=k_13%></td>
          <td style="text-align: center;color: #000;"><%=k_14%></td>
          <td style="text-align: center;color: #000;"><%=k_15%></td>
          <td style="text-align: center;color: #000;"><%=k_16%></td>
          <td style="text-align: center;color: #000;"><%=k_17%></td>
          <td style="text-align: center;color: #000;"><%=k_18%></td>
          <td style="text-align: center;color: #000;"><%=k_19%></td>
          <td style="text-align: center;color: #000;"><%=k_20%></td>
          <td style="text-align: center;color: #000;"><%=k_21%></td>
          <td style="text-align: center;color: #000;"><%=k_22%></td>
          <td style="text-align: center;color: #000;"><%=k_23%></td>
          <td style="text-align: center;color: #000;"><%=k_24%></td>
          <td style="text-align: center;color: #000;"><%=k_25%></td>
          <td style="text-align: center;color: #000;"><%=k_26%></td>
          <td style="text-align: center;color: #000;"><%=k_27%></td>
          <td style="text-align: center;color: #000;"><%=k_28%></td>
          <td style="text-align: center;color: #000;"><%=k_29%></td>
          <td style="text-align: center;color: #000;"><%=k_30%></td>
          <td style="text-align: center;color: #000;"><%=k_31%></td>
        </tr>
        <tr class="">
          <td style="text-align:center;">龙工</td>
          <td style="text-align: center;color: #000;"><%=l_1%></td>
          <td style="text-align: center;color: #000;"><%=l_2%></td>
          <td style="text-align: center;color: #000;"><%=l_3%></td>
          <td style="text-align: center;color: #000;"><%=l_4%></td>
          <td style="text-align: center;color: #000;"><%=l_5%></td>
          <td style="text-align: center;color: #000;"><%=l_6%></td>
          <td style="text-align: center;color: #000;"><%=l_7%></td>
          <td style="text-align: center;color: #000;"><%=l_8%></td>
          <td style="text-align: center;color: #000;"><%=l_9%></td>
          <td style="text-align: center;color: #000;"><%=l_10%></td>
          <td style="text-align: center;color: #000;"><%=l_11%></td>
          <td style="text-align: center;color: #000;"><%=l_12%></td>
          <td style="text-align: center;color: #000;"><%=l_13%></td>
          <td style="text-align: center;color: #000;"><%=l_14%></td>
          <td style="text-align: center;color: #000;"><%=l_15%></td>
          <td style="text-align: center;color: #000;"><%=l_16%></td>
          <td style="text-align: center;color: #000;"><%=l_17%></td>
          <td style="text-align: center;color: #000;"><%=l_18%></td>
          <td style="text-align: center;color: #000;"><%=l_19%></td>
          <td style="text-align: center;color: #000;"><%=l_20%></td>
          <td style="text-align: center;color: #000;"><%=l_21%></td>
          <td style="text-align: center;color: #000;"><%=l_22%></td>
          <td style="text-align: center;color: #000;"><%=l_23%></td>
          <td style="text-align: center;color: #000;"><%=l_24%></td>
          <td style="text-align: center;color: #000;"><%=l_25%></td>
          <td style="text-align: center;color: #000;"><%=l_26%></td>
          <td style="text-align: center;color: #000;"><%=l_27%></td>
          <td style="text-align: center;color: #000;"><%=l_28%></td>
          <td style="text-align: center;color: #000;"><%=l_29%></td>
          <td style="text-align: center;color: #000;"><%=l_30%></td>
          <td style="text-align: center;color: #000;"><%=l_31%></td>
        </tr>
        <tr class="">
          <td style="text-align:center;">厦工</td>
          <td style="text-align: center;color: #000;"><%=m_1%></td>
          <td style="text-align: center;color: #000;"><%=m_2%></td>
          <td style="text-align: center;color: #000;"><%=m_3%></td>
          <td style="text-align: center;color: #000;"><%=m_4%></td>
          <td style="text-align: center;color: #000;"><%=m_5%></td>
          <td style="text-align: center;color: #000;"><%=m_6%></td>
          <td style="text-align: center;color: #000;"><%=m_7%></td>
          <td style="text-align: center;color: #000;"><%=m_8%></td>
          <td style="text-align: center;color: #000;"><%=m_9%></td>
          <td style="text-align: center;color: #000;"><%=m_10%></td>
          <td style="text-align: center;color: #000;"><%=m_11%></td>
          <td style="text-align: center;color: #000;"><%=m_12%></td>
          <td style="text-align: center;color: #000;"><%=m_13%></td>
          <td style="text-align: center;color: #000;"><%=m_14%></td>
          <td style="text-align: center;color: #000;"><%=m_15%></td>
          <td style="text-align: center;color: #000;"><%=m_16%></td>
          <td style="text-align: center;color: #000;"><%=m_17%></td>
          <td style="text-align: center;color: #000;"><%=m_18%></td>
          <td style="text-align: center;color: #000;"><%=m_19%></td>
          <td style="text-align: center;color: #000;"><%=m_20%></td>
          <td style="text-align: center;color: #000;"><%=m_21%></td>
          <td style="text-align: center;color: #000;"><%=m_22%></td>
          <td style="text-align: center;color: #000;"><%=m_23%></td>
          <td style="text-align: center;color: #000;"><%=m_24%></td>
          <td style="text-align: center;color: #000;"><%=m_25%></td>
          <td style="text-align: center;color: #000;"><%=m_26%></td>
          <td style="text-align: center;color: #000;"><%=m_27%></td>
          <td style="text-align: center;color: #000;"><%=m_28%></td>
          <td style="text-align: center;color: #000;"><%=m_29%></td>
          <td style="text-align: center;color: #000;"><%=m_30%></td>
          <td style="text-align: center;color: #000;"><%=m_31%></td>
        </tr>
        <tr class="">
          <td style="text-align:center;">神钢</td>
          <td style="text-align: center;color: #000;"><%=n_1%></td>
          <td style="text-align: center;color: #000;"><%=n_2%></td>
          <td style="text-align: center;color: #000;"><%=n_3%></td>
          <td style="text-align: center;color: #000;"><%=n_4%></td>
          <td style="text-align: center;color: #000;"><%=n_5%></td>
          <td style="text-align: center;color: #000;"><%=n_6%></td>
          <td style="text-align: center;color: #000;"><%=n_7%></td>
          <td style="text-align: center;color: #000;"><%=n_8%></td>
          <td style="text-align: center;color: #000;"><%=n_9%></td>
          <td style="text-align: center;color: #000;"><%=n_10%></td>
          <td style="text-align: center;color: #000;"><%=n_11%></td>
          <td style="text-align: center;color: #000;"><%=n_12%></td>
          <td style="text-align: center;color: #000;"><%=n_13%></td>
          <td style="text-align: center;color: #000;"><%=n_14%></td>
          <td style="text-align: center;color: #000;"><%=n_15%></td>
          <td style="text-align: center;color: #000;"><%=n_16%></td>
          <td style="text-align: center;color: #000;"><%=n_17%></td>
          <td style="text-align: center;color: #000;"><%=n_18%></td>
          <td style="text-align: center;color: #000;"><%=n_19%></td>
          <td style="text-align: center;color: #000;"><%=n_20%></td>
          <td style="text-align: center;color: #000;"><%=n_21%></td>
          <td style="text-align: center;color: #000;"><%=n_22%></td>
          <td style="text-align: center;color: #000;"><%=n_23%></td>
          <td style="text-align: center;color: #000;"><%=n_24%></td>
          <td style="text-align: center;color: #000;"><%=n_25%></td>
          <td style="text-align: center;color: #000;"><%=n_26%></td>
          <td style="text-align: center;color: #000;"><%=n_27%></td>
          <td style="text-align: center;color: #000;"><%=n_28%></td>
          <td style="text-align: center;color: #000;"><%=n_29%></td>
          <td style="text-align: center;color: #000;"><%=n_30%></td>
          <td style="text-align: center;color: #000;"><%=n_31%></td>
        </tr>
        <tr class="">
          <td style="text-align:center;">现代</td>
          <td style="text-align: center;color: #000;"><%=o_1%></td>
          <td style="text-align: center;color: #000;"><%=o_2%></td>
          <td style="text-align: center;color: #000;"><%=o_3%></td>
          <td style="text-align: center;color: #000;"><%=o_4%></td>
          <td style="text-align: center;color: #000;"><%=o_5%></td>
          <td style="text-align: center;color: #000;"><%=o_6%></td>
          <td style="text-align: center;color: #000;"><%=o_7%></td>
          <td style="text-align: center;color: #000;"><%=o_8%></td>
          <td style="text-align: center;color: #000;"><%=o_9%></td>
          <td style="text-align: center;color: #000;"><%=o_10%></td>
          <td style="text-align: center;color: #000;"><%=o_11%></td>
          <td style="text-align: center;color: #000;"><%=o_12%></td>
          <td style="text-align: center;color: #000;"><%=o_13%></td>
          <td style="text-align: center;color: #000;"><%=o_14%></td>
          <td style="text-align: center;color: #000;"><%=o_15%></td>
          <td style="text-align: center;color: #000;"><%=o_16%></td>
          <td style="text-align: center;color: #000;"><%=o_17%></td>
          <td style="text-align: center;color: #000;"><%=o_18%></td>
          <td style="text-align: center;color: #000;"><%=o_19%></td>
          <td style="text-align: center;color: #000;"><%=o_20%></td>
          <td style="text-align: center;color: #000;"><%=o_21%></td>
          <td style="text-align: center;color: #000;"><%=o_22%></td>
          <td style="text-align: center;color: #000;"><%=o_23%></td>
          <td style="text-align: center;color: #000;"><%=o_24%></td>
          <td style="text-align: center;color: #000;"><%=o_25%></td>
          <td style="text-align: center;color: #000;"><%=o_26%></td>
          <td style="text-align: center;color: #000;"><%=o_27%></td>
          <td style="text-align: center;color: #000;"><%=o_28%></td>
          <td style="text-align: center;color: #000;"><%=o_29%></td>
          <td style="text-align: center;color: #000;"><%=o_30%></td>
          <td style="text-align: center;color: #000;"><%=o_31%></td>
        </tr>
        <tr class="">
          <td style="text-align:center;">久保田</td>
          <td style="text-align: center;color: #000;"><%=p_1%></td>
          <td style="text-align: center;color: #000;"><%=p_2%></td>
          <td style="text-align: center;color: #000;"><%=p_3%></td>
          <td style="text-align: center;color: #000;"><%=p_4%></td>
          <td style="text-align: center;color: #000;"><%=p_5%></td>
          <td style="text-align: center;color: #000;"><%=p_6%></td>
          <td style="text-align: center;color: #000;"><%=p_7%></td>
          <td style="text-align: center;color: #000;"><%=p_8%></td>
          <td style="text-align: center;color: #000;"><%=p_9%></td>
          <td style="text-align: center;color: #000;"><%=p_10%></td>
          <td style="text-align: center;color: #000;"><%=p_11%></td>
          <td style="text-align: center;color: #000;"><%=p_12%></td>
          <td style="text-align: center;color: #000;"><%=p_13%></td>
          <td style="text-align: center;color: #000;"><%=p_14%></td>
          <td style="text-align: center;color: #000;"><%=p_15%></td>
          <td style="text-align: center;color: #000;"><%=p_16%></td>
          <td style="text-align: center;color: #000;"><%=p_17%></td>
          <td style="text-align: center;color: #000;"><%=p_18%></td>
          <td style="text-align: center;color: #000;"><%=p_19%></td>
          <td style="text-align: center;color: #000;"><%=p_20%></td>
          <td style="text-align: center;color: #000;"><%=p_21%></td>
          <td style="text-align: center;color: #000;"><%=p_22%></td>
          <td style="text-align: center;color: #000;"><%=p_23%></td>
          <td style="text-align: center;color: #000;"><%=p_24%></td>
          <td style="text-align: center;color: #000;"><%=p_25%></td>
          <td style="text-align: center;color: #000;"><%=p_26%></td>
          <td style="text-align: center;color: #000;"><%=p_27%></td>
          <td style="text-align: center;color: #000;"><%=p_28%></td>
          <td style="text-align: center;color: #000;"><%=p_29%></td>
          <td style="text-align: center;color: #000;"><%=p_30%></td>
          <td style="text-align: center;color: #000;"><%=p_31%></td>
        </tr>
        <tr class="">
          <td style="text-align:center;">石川岛</td>
          <td style="text-align: center;color: #000;"><%=q_1%></td>
          <td style="text-align: center;color: #000;"><%=q_2%></td>
          <td style="text-align: center;color: #000;"><%=q_3%></td>
          <td style="text-align: center;color: #000;"><%=q_4%></td>
          <td style="text-align: center;color: #000;"><%=q_5%></td>
          <td style="text-align: center;color: #000;"><%=q_6%></td>
          <td style="text-align: center;color: #000;"><%=q_7%></td>
          <td style="text-align: center;color: #000;"><%=q_8%></td>
          <td style="text-align: center;color: #000;"><%=q_9%></td>
          <td style="text-align: center;color: #000;"><%=q_10%></td>
          <td style="text-align: center;color: #000;"><%=q_11%></td>
          <td style="text-align: center;color: #000;"><%=q_12%></td>
          <td style="text-align: center;color: #000;"><%=q_13%></td>
          <td style="text-align: center;color: #000;"><%=q_14%></td>
          <td style="text-align: center;color: #000;"><%=q_15%></td>
          <td style="text-align: center;color: #000;"><%=q_16%></td>
          <td style="text-align: center;color: #000;"><%=q_17%></td>
          <td style="text-align: center;color: #000;"><%=q_18%></td>
          <td style="text-align: center;color: #000;"><%=q_19%></td>
          <td style="text-align: center;color: #000;"><%=q_20%></td>
          <td style="text-align: center;color: #000;"><%=q_21%></td>
          <td style="text-align: center;color: #000;"><%=q_22%></td>
          <td style="text-align: center;color: #000;"><%=q_23%></td>
          <td style="text-align: center;color: #000;"><%=q_24%></td>
          <td style="text-align: center;color: #000;"><%=q_25%></td>
          <td style="text-align: center;color: #000;"><%=q_26%></td>
          <td style="text-align: center;color: #000;"><%=q_27%></td>
          <td style="text-align: center;color: #000;"><%=q_28%></td>
          <td style="text-align: center;color: #000;"><%=q_29%></td>
          <td style="text-align: center;color: #000;"><%=q_30%></td>
          <td style="text-align: center;color: #000;"><%=q_31%></td>
        </tr>
        <tr class="">
          <td style="text-align:center;">约翰迪尔</td>
          <td style="text-align: center;color: #000;"><%=r_1%></td>
          <td style="text-align: center;color: #000;"><%=r_2%></td>
          <td style="text-align: center;color: #000;"><%=r_3%></td>
          <td style="text-align: center;color: #000;"><%=r_4%></td>
          <td style="text-align: center;color: #000;"><%=r_5%></td>
          <td style="text-align: center;color: #000;"><%=r_6%></td>
          <td style="text-align: center;color: #000;"><%=r_7%></td>
          <td style="text-align: center;color: #000;"><%=r_8%></td>
          <td style="text-align: center;color: #000;"><%=r_9%></td>
          <td style="text-align: center;color: #000;"><%=r_10%></td>
          <td style="text-align: center;color: #000;"><%=r_11%></td>
          <td style="text-align: center;color: #000;"><%=r_12%></td>
          <td style="text-align: center;color: #000;"><%=r_13%></td>
          <td style="text-align: center;color: #000;"><%=r_14%></td>
          <td style="text-align: center;color: #000;"><%=r_15%></td>
          <td style="text-align: center;color: #000;"><%=r_16%></td>
          <td style="text-align: center;color: #000;"><%=r_17%></td>
          <td style="text-align: center;color: #000;"><%=r_18%></td>
          <td style="text-align: center;color: #000;"><%=r_19%></td>
          <td style="text-align: center;color: #000;"><%=r_20%></td>
          <td style="text-align: center;color: #000;"><%=r_21%></td>
          <td style="text-align: center;color: #000;"><%=r_22%></td>
          <td style="text-align: center;color: #000;"><%=r_23%></td>
          <td style="text-align: center;color: #000;"><%=r_24%></td>
          <td style="text-align: center;color: #000;"><%=r_25%></td>
          <td style="text-align: center;color: #000;"><%=r_26%></td>
          <td style="text-align: center;color: #000;"><%=r_27%></td>
          <td style="text-align: center;color: #000;"><%=r_28%></td>
          <td style="text-align: center;color: #000;"><%=r_29%></td>
          <td style="text-align: center;color: #000;"><%=r_30%></td>
          <td style="text-align: center;color: #000;"><%=r_31%></td>
        </tr>
        <tr class="">
          <td style="text-align:center;">中联</td>
          <td style="text-align: center;color: #000;"><%=s_1%></td>
          <td style="text-align: center;color: #000;"><%=s_2%></td>
          <td style="text-align: center;color: #000;"><%=s_3%></td>
          <td style="text-align: center;color: #000;"><%=s_4%></td>
          <td style="text-align: center;color: #000;"><%=s_5%></td>
          <td style="text-align: center;color: #000;"><%=s_6%></td>
          <td style="text-align: center;color: #000;"><%=s_7%></td>
          <td style="text-align: center;color: #000;"><%=s_8%></td>
          <td style="text-align: center;color: #000;"><%=s_9%></td>
          <td style="text-align: center;color: #000;"><%=s_10%></td>
          <td style="text-align: center;color: #000;"><%=s_11%></td>
          <td style="text-align: center;color: #000;"><%=s_12%></td>
          <td style="text-align: center;color: #000;"><%=s_13%></td>
          <td style="text-align: center;color: #000;"><%=s_14%></td>
          <td style="text-align: center;color: #000;"><%=s_15%></td>
          <td style="text-align: center;color: #000;"><%=s_16%></td>
          <td style="text-align: center;color: #000;"><%=s_17%></td>
          <td style="text-align: center;color: #000;"><%=s_18%></td>
          <td style="text-align: center;color: #000;"><%=s_19%></td>
          <td style="text-align: center;color: #000;"><%=s_20%></td>
          <td style="text-align: center;color: #000;"><%=s_21%></td>
          <td style="text-align: center;color: #000;"><%=s_22%></td>
          <td style="text-align: center;color: #000;"><%=s_23%></td>
          <td style="text-align: center;color: #000;"><%=s_24%></td>
          <td style="text-align: center;color: #000;"><%=s_25%></td>
          <td style="text-align: center;color: #000;"><%=s_26%></td>
          <td style="text-align: center;color: #000;"><%=s_27%></td>
          <td style="text-align: center;color: #000;"><%=s_28%></td>
          <td style="text-align: center;color: #000;"><%=s_29%></td>
          <td style="text-align: center;color: #000;"><%=s_30%></td>
          <td style="text-align: center;color: #000;"><%=s_31%></td>
        </tr>
      </tbody>
    </table>
  </div>
</div>
</body>
</html>
<script type="text/javascript">
	//增加和编辑的方法
	jQuery(".searchForm input[type=text]").keypress(function(e){
		if(e.keyCode==13){
			doSearch();
		}
	});
	/*列表页条件查询*/
	/*列表页清空查询*/
	function doClearForm(){
		jQuery(".searchForm input:text,select").val('');
		 // alert(jQuery(".searchForm select option:eq(0)").html()) ;
       jQuery("#catanum option:eq(0)").attr("selected",true) ;
       jQuery("#factoryid option:eq(0)").attr("selected",true) ;
	}
		// 回车提交表单
	 document.onkeydown=function(event){ 
        e = event ? event :(window.event ? window.event : null); 
        if(e.keyCode==13){ 
            doSearch();
        } 
        }

jQuery(function(){
	//getBrandRanking();
	jQuery("#today_s").attr("style","font-size:12px; font-weight:bold; color:#236ad0;") ;
	jQuery("#zd_province option").each(function(){
			jQuery(this).text(codefans_net_CC2PY(jQuery(this).text()).substring(0,1)+"-"+jQuery(this).text());
		}) ;
	jQuery("#catalognum option").each(function(){
	      if(jQuery(this).val()=='<%=catalognum%>'){
	      	jQuery(this).attr("selected","selected") ;
	      	return  ;
	      }
	}) ;
		jQuery("#zd_province option").each(function(){
	      if(jQuery(this).val()=='<%=province%>'){
	      	jQuery(this).attr("selected","selected") ;
	      	return  ;
	      }
	}) ;
	jQuery("#factoryid option").each(function(){
	      if(jQuery(this).val()=='<%=factoryid%>'){
	      	jQuery(this).attr("selected","selected") ;
	      	return  ;
	      }
	}) ;
}) ;
function getChoseOrderRanking(obj,start_date,end_date){
	jQuery(".menuLinks a").removeAttr("style") ;
	jQuery(obj).attr("style","font-size:12px; font-weight:bold; color:#236ad0;") ;
	jQuery("#ts_date").text(start_date) ;
	jQuery("#te_date").text(end_date) ;
	getBrandRanking(start_date,end_date);
}
function checkInput(){
	var ts = jQuery("#ts").val() ;
	var te = jQuery("#te").val() ;
	var catalognum = jQuery("#catalognum").val() ;

	if(ts>te){
		 jQuery("#te").select() ;
	}else{
	     window.location.href="?flag=tt&ts="+ts+"&te="+te+"&catalognum="+catalognum ;
	}
}

 





</script>
<%



	} catch(Exception e){
		e.printStackTrace() ;
	}finally{
		DBHelper.freeConnection(conn) ;
	}
%>