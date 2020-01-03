package com.mer;

import javax.servlet.ServletConfig;
import javax.servlet.http.HttpServlet;
import com.czbank.netpay.api.APIConstance;
public class StartUp extends HttpServlet
{
	public void init(ServletConfig sc)
	{
		try
		{
			APIConstance.initialize("/sun21/webpro/sun21_03/21sun_product_2012_test/WEB-INF/classes/MerchantConfig.xml");// 绝对路径
			//APIConstance.initialize("D:/workpace/21sun_product_2012_test/WEB-INF/classes/MerchantConfig.xml");// 绝对路径
			//APIConstance.initialize("D:/workpace/jrframe/WebRoot/WEB-INF/classes/MerchantConfig.xml");// 绝对路径
		}
		catch (Exception e)
		{
			e.printStackTrace();
		}// 该代码只需调用一次
	}
	public void destroy()
	{
		super.destroy();
	}
}
