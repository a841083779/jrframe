package com.jerehnet.util.common;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

	public class DwrPushOrderInfo {
		private ServletContext  application = null ;
		private String  newOrderId = "" ;
		
		
	public String  getOrderInfo(String cookieorderId,HttpServletRequest  request ){
		this.application = request.getSession().getServletContext() ;
		return getNewOrderId(cookieorderId) ; 
	}
	/**
	 * 设置新订单编号 
	 * @param newOrderId
	 * @param request
	 */
	public void  setOrderInfo(String newOrderId,HttpServletRequest  request ){
		this.application = request.getSession().getServletContext() ;
		if(!"".equals(newOrderId)){
			this.application.setAttribute("applicationOrderId", newOrderId) ;
		}else{
			this.application.removeAttribute("applicationOrderId") ;
		}
	}
	
	public String getNewOrderId(String cookieOrderId){
		if(cookieOrderId.trim()==CommonString.getFormatPara(application.getAttribute("applicationOrderId")) || "".equals(cookieOrderId)){  // 如果没有新订单
			return "";
		}
		return CommonString.getFormatPara(application.getAttribute("applicationOrderId"));
	}
	
}
