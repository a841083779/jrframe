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
public class UrlFilter implements Filter {

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
		//FLASH上传时会有一个新session，这里是为了放通权限
		if(url.indexOf("/backend/action/upload.jsp")!=-1){
			chain.doFilter(request, response);
			return;
		}
		if(url.indexOf("/backend/action/after")!=-1){
			chain.doFilter(request, response);
			return;
		}
		if(url.indexOf("/backend/action/before")!=-1){
			chain.doFilter(request, response);
			return;
		}
		boolean login = false;
		Map adminInfo = (Map) session.getAttribute("adminInfo");
		if (null != adminInfo) {
			login = true;
		}
		if (login) {
			chain.doFilter(request, response);
			return;
		} else {
			Common.do302(res, "/webadmin/login.jsp");
			return;
		}
	}

	public void destroy() {
		this.config = null;
	}
}