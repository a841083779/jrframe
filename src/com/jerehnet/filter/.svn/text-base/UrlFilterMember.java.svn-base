package com.jerehnet.filter;

import java.io.IOException;
import java.util.Map;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.jerehnet.util.common.Common;

/**
 * 后台url过滤
 */
public class UrlFilterMember implements Filter {

	@SuppressWarnings("unused")
	private FilterConfig config;

	public void init(FilterConfig filterConfig) throws ServletException {
		config = filterConfig;
	}

	@SuppressWarnings("unchecked")
	public void doFilter(ServletRequest request, ServletResponse response,
			FilterChain chain) throws IOException, ServletException {
		HttpServletRequest req = (HttpServletRequest) request;
		HttpServletResponse res = (HttpServletResponse) response;
		String url = req.getRequestURI();
		// 设置编码格式
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		HttpSession session = req.getSession();
		
		boolean login = false;
		Map factoryInfo = (Map) session.getAttribute("factoryInfo");
		Map agentInfo = (Map) session.getAttribute("agentInfo");
		
		if(factoryInfo ==null && url.indexOf("/admin/factory/") >= 0){
			Common.do302(res, "/admin/login.jsp");
		}else if(agentInfo == null && url.indexOf("/admin/agent/") >= 0){
			Common.do302(res, "/admin/login.jsp");
		}else{
			chain.doFilter(request, response);
			return;
		}
	}
	public void destroy() {
		this.config = null;
	}
}