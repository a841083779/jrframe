package com.jerehnet.wxpay;

import java.io.*;
import java.util.*;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


public class WXPayServlet extends HttpServlet
{
  protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException
  {
	  BufferedReader reader;
	  try{
	   	reader = request.getReader();
	   	String line="";
	   	StringBuffer inputString = new StringBuffer();
	   	while((line = reader.readLine()) !=null){
	   		inputString.append(line);
	   	}
	   	request.getReader().close();
	   	Map<String,String> map = WXPayUtil.xmlToMap(inputString.toString());
	   	if("SUCCESS".equals(map.get("return_code"))){
	   		if("SUCCESS".equals(map.get("result_code"))){
		   		map.remove("xml");
		   		//业务处理
		   		response.getWriter().write("<xml><return_code><![CDATA[SUCCESS]]></return_code></xml>");
		   	}
	   	}
	  }catch (Exception e) {
	    e.printStackTrace();
	  }
  }

  protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
  {
    doGet(request, response);
  }
}