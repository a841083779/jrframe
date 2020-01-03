package com.mer;
import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLDecoder;
import java.sql.Connection;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.czbank.netpay.api.KeyStoreUtil;
import com.jerehnet.util.dbutil.DBHelper;
/**
 * 对客户端通过Http上送的交易请求进行处理<br>
 * 
 * @author Wangjm
 */
public class ResReplyServlet extends HttpServlet
{
	private static final long serialVersionUID=200712201815002L;
	private static final String LOG_ID="->TCPIP";
	/**
	 * 客户端通信约定，post携带参数tranCode(交易码),signedData（签名数据）,reqPack（上送报文） <br>
	 * 除签名数据外都经过了Base4编码，接受后都应做解码处理 service:该方法主要处理商户请求信息对商户请求信息预处理
	 * 
	 */
	protected void service(HttpServletRequest httpservletrequest,HttpServletResponse httpservletresponse) throws IOException
	{
		httpservletrequest.setCharacterEncoding("UTF-8");
		String interfaceName=URLDecoder.decode(httpservletrequest.getParameter("interfaceName"),"UTF-8");
		String interfaceVersion=URLDecoder.decode(httpservletrequest.getParameter("interfaceVersion"),"UTF-8");
		String merID=URLDecoder.decode(httpservletrequest.getParameter("merId"),"UTF-8");
		String orderId=URLDecoder.decode(httpservletrequest.getParameter("orderId"),"UTF-8");
		String result=URLDecoder.decode(httpservletrequest.getParameter("result"),"UTF-8");
		String remark=URLDecoder.decode(httpservletrequest.getParameter("remark"),"UTF-8");
		String signedMsg = URLDecoder.decode(httpservletrequest.getParameter("signMsg"),"UTF-8");
		String oridata=interfaceName+interfaceVersion+merID+orderId+result+remark;
		int i=KeyStoreUtil.verifySignData(oridata,signedMsg);
		if (i!=0)
		{
			System.out.println("验签不正确，数据被篡改!");
		}else {
			if(result.equals("0")){
			    Connection conn = null;
	            DBHelper dbHelper = DBHelper.getInstance();
				try{
				    conn = dbHelper.getConnection();
					dbHelper.execute("update pro_online_order set order_state=1 where order_no='"+orderId+"'", conn);
				}catch(Exception e){
		               e.printStackTrace();
	            }finally{
		           DBHelper.freeConnection(conn);
	            }
			}
		}
		// ============交易处理的日期时间 请求地址
		// ============处理商户请求验证签名前的数据
		// ============处理商户请求验证签名通过后的数据
		writeBackData(httpservletresponse);
	}
	/**
	 * 将交易返回写回给商户
	 * 
	 * @param msg
	 *            返回报文
	 * @param httpservletresponse
	 * @throws IOException
	 */
	private void writeBackData(HttpServletResponse httpservletresponse)
	{
		//ServletOutputStream sos=null;
		PrintWriter sos=null;
		try
		{
			//Thread.sleep(10000);
			httpservletresponse.setCharacterEncoding("GBK");
			httpservletresponse.addHeader("Content-Type","text/html");
			//httpservletresponse.addHeader("Content-Type","application/x-www-form-urlencoded");
			//sos=httpservletresponse.getOutputStream();
			sos=httpservletresponse.getWriter();
			//sos.close();
			//BufferedReader in=new BufferedReader(new FileReader("D://test.txt"));
			//String pageURL=in.readLine();
			String pageURL = "http://10.0.7.5:9080/CORPORBANK";
			//sos.write((pageURL+"|"+KeyStoreUtil.signData(pageURL)));
			sos.print((pageURL+"|"+KeyStoreUtil.signData(pageURL)));
			//sos.print(pageURL);
			sos.flush();
		}
		catch (Exception e)
		{
			System.out.println("写回客户数据失败："+e.getMessage());
		}
		finally
		{
			if (sos!=null)
			{
				try
				{
					sos.close();
				}
				catch (Exception ee)
				{}
			}
		}
	}
}
