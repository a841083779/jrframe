package com.jerehnet.filter;

import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import com.jerehnet.util.common.CommonString;

public class SetCharacterEncodingFilter implements Filter {

	protected String encoding = null;
	protected FilterConfig filterConfig = null;
	protected String isFilter = null;
	protected boolean ignore = true;

	public void destroy() {
		this.encoding = null;
		this.filterConfig = null;
		this.isFilter = null;
	}

	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		if (ignore || (request.getCharacterEncoding() == null)) {
			String encoding = selectEncoding(request);
			if (encoding != null)
				request.setCharacterEncoding(encoding);
		}
		HttpServletRequest req = (HttpServletRequest) request;
		if (null != this.isFilter && this.isFilter.equals("false")) {
			chain.doFilter(req, response);
		} else {
			chain.doFilter(new MyHttpServletRequestWrapper(req), response);
		}
	}

	public void init(FilterConfig filterConfig) throws ServletException {
		this.filterConfig = filterConfig;
		this.encoding = filterConfig.getInitParameter("encoding");
		String value = filterConfig.getInitParameter("ignore");
		if (value == null) {
			this.ignore = true;
		} else if (value.equalsIgnoreCase("true")) {
			this.ignore = true;
		} else if (value.equalsIgnoreCase("yes")) {
			this.ignore = true;
		} else {
			this.ignore = false;
		}
		this.isFilter = CommonString.getFormatPara(filterConfig.getInitParameter("isFilter"));
	}

	protected String selectEncoding(ServletRequest request) {
		return (this.encoding);
	}

}
