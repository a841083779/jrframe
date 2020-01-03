package com.jerehnet.mobile.sync;

import com.jerehnet.util.common.Common;
import com.jerehnet.util.common.CommonString;
import com.jerehnet.util.dbutil.DBHelper;
import java.io.PrintStream;
import java.sql.Connection;
import java.util.HashMap;
import java.util.Map;

public class UserServiceAction extends BaseSyncActon
{
  public String sync(String flag, String method, String jsonStr)
  {
    Connection connection = null;
    DBHelper dbHelper = DBHelper.getInstance();

    net.sf.json.JSONObject jsonObject = new net.sf.json.JSONObject();
    try
    {
      connection = dbHelper.getConnection();

      String sql = "";

      if (flag.equals("base")) {
        if (method.equals("getPwdInfo")) {
          if ((!jsonStr.equals("")) && (jsonStr != null)) {
            org.json.JSONObject objone = new org.json.JSONObject(jsonStr);
            int flag_no = objone.getInt("flag_no");
            String usern = objone.getString("usern");
            if ((flag_no == 101002) || (flag_no == 101003))
              sql = sql + "select usern,passw_bak as pwd,mobile as phone,flag from pro_agent_factory where usern='" + usern + "'";
            else {
              sql = sql + "select usern,phone,password as pwd from pro_agent_personnel where usern='" + usern + "'";
            }
          }
          Map map = null;
          map = dbHelper.getMap(sql);

          if ((map != null) && (!"".equals(map))) {
            String srt;
            try {
              Map root = new HashMap();
              root.put("phone", CommonString.getFormatPara(map.get("phone")));
              root.put("content", CommonString.getFormatPara(map.get("usern")) + "，您好！订单宝注册密码为：" + CommonString.getFormatPara(map.get("pwd")) + ",请小心保管。");
              root.put("source", "195002");
              srt = Common.doPost("http://service.21-sun.com/http/utils/sms.jsp", root);
            }
            catch (Exception localException1)
            {
            }
            jsonObject.put("resultCode", "0001");
            jsonObject.put("resultMessage", "发送短信成功");
            jsonObject.put("resultObject", "");
          } else {
            jsonObject.put("resultCode", "0002");
            jsonObject.put("resultMessage", "失败");
            jsonObject.put("resultObject", "");
          }
        }
        else {
          jsonObject.put("resultCode", "0002");
          jsonObject.put("resultMessage", "失败");
          jsonObject.put("resultObject", "");
        }
      } else {
        jsonObject.put("resultCode", "0002");
        jsonObject.put("resultMessage", "失败");
        jsonObject.put("resultObject", "");
      }

      System.out.println("测试返回字符串:" + jsonObject.toString());
    }
    catch (Exception e) {
      e.printStackTrace();
      jsonObject.put("resultCode", "0002");
      jsonObject.put("resultMessage", "失败");
      jsonObject.put("resultObject", "");
    } finally {
      DBHelper.freeConnection(connection);
    }

    return jsonObject.toString();
  }
}