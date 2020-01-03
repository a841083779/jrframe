package com.jerehnet.mobile.action;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import java.sql.SQLException;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import com.jerehnet.util.common.*;

public class SessionTools
{
  public static final String WEBSITE = "website";
  public static final String WEBSITE_CONFIG = "website_config";
  public static final String MEMBER = "member";
  public static final String ESHOP_MEMBER = "eshop_member";
  public static final String SHOP = "shop";
  public static final String WEI_XIN_PAGE_ACCESS_TOKEN = "wei_xin_page_access_token";
  public static final String WEI_XIN_PAGE_REFRESH_ACCESS_TOKEN = "wei_xin_page_refresh_access_token";
  public static final String WEI_XIN_PAGE_ACCESS_TOKEN_EXPIRES_IN = "wei_xin_page_access_token_expires_in";
  public static final String WEI_XIN_PAGE_ACCESS_OPENID = "wei_xin_page_access_openid";

  public static Map getPageAccessMap(HttpServletRequest request, String code, String info) throws Exception 
  {
    String appid = "wx324b28c48f98f6a3";
    String appsecret = "db694bab62b5450a86a4838cf27f5f19";
    Map m = new HashMap();
    Boolean againGet = Boolean.valueOf(false);
    String accessToken = CommonString.getFormatPara(request.getSession().getAttribute("wei_xin_page_access_token"));
    String refreshAccessToken = CommonString.getFormatPara(request.getSession().getAttribute("wei_xin_page_refresh_access_token"));
    String openid = CommonString.getFormatPara(request.getSession().getAttribute("wei_xin_page_access_openid"));
    if ((accessToken != null) && (!accessToken.equals("")))
    {
      Date date_old = (Date)request.getSession().getAttribute("wei_xin_page_access_token_expires_in");

      if (date_old != null) {
        Date date_new = Calendar.getInstance().getTime();
        long s = (date_new.getTime() - date_old.getTime()) / 1000L;
        if (s >= 7190L) {
          if ((refreshAccessToken != null) && (!refreshAccessToken.equals("")))
          {
            String refreshAccessTokenStr = Common.doGet("https://api.weixin.qq.com/sns/oauth2/refresh_token?appid=" + appid + "&grant_type=refresh_token&refresh_token=" + 
              refreshAccessToken);
            if ((refreshAccessTokenStr != null) && (!refreshAccessTokenStr.equals(""))) {
              JSONObject refreshAccessTokenObj = JSONObject.parseObject(refreshAccessTokenStr);
              accessToken = CommonString.getFormatPara(refreshAccessTokenObj.get("access_token"));
              refreshAccessToken = CommonString.getFormatPara(refreshAccessTokenObj.get("refresh_token"));
              openid = CommonString.getFormatPara(refreshAccessTokenObj.get("openid"));
              request.getSession().setAttribute("wei_xin_page_access_token", accessToken);
              request.getSession().setAttribute("wei_xin_page_refresh_access_token", refreshAccessToken);
              request.getSession().setAttribute("wei_xin_page_access_token_expires_in", Calendar.getInstance().getTime());
              request.getSession().setAttribute("wei_xin_page_access_openid", openid);
            } else {
              againGet = Boolean.valueOf(true);
            }
          } else {
            againGet = Boolean.valueOf(true);
          }
        }

        String accessTokenTrueStr = Common.doGet("https://api.weixin.qq.com/sns/auth?access_token=" + accessToken + "&openid=" + openid);
        JSONObject accessTokenTrueObj = JSONObject.parseObject(accessTokenTrueStr);
        String rstr = CommonString.getFormatPara(accessTokenTrueObj.get("errmsg"));
        if (!"ok".equals(rstr))
          againGet = Boolean.valueOf(true);
      }
      else {
        againGet = Boolean.valueOf(true);
      }
    } else {
      againGet = Boolean.valueOf(true);
    }
    if (againGet.booleanValue()) {
      if ((appid != null) && (!appid.equals("")) && (appsecret != null) && (!appsecret.equals("")) && (code != null) && (!code.equals("")))
      {
        String tokenurl = "https://api.weixin.qq.com/sns/oauth2/access_token?appid=" + appid + "&secret=" + appsecret + "&code=" + code + "&grant_type=authorization_code";
        String tokenStr = Common.doGet(tokenurl);
        if ((tokenStr != null) && (!tokenStr.equals(""))) {
          JSONObject tokenObj = JSONObject.parseObject(tokenStr);
          accessToken = CommonString.getFormatPara(tokenObj.get("access_token"));
          refreshAccessToken = CommonString.getFormatPara(tokenObj.get("refresh_token"));
          openid = CommonString.getFormatPara(tokenObj.get("openid"));
          request.getSession().setAttribute("wei_xin_page_access_token", accessToken);
          request.getSession().setAttribute("wei_xin_page_refresh_access_token", refreshAccessToken);
          request.getSession().setAttribute("wei_xin_page_access_token_expires_in", Calendar.getInstance().getTime());
          request.getSession().setAttribute("wei_xin_page_access_openid", openid);
          m.put("accessToken", accessToken);
          m.put("openid", openid);
        }
      }
    } else {
      m.put("accessToken", accessToken);
      m.put("openid", openid);
    }
    if (("snsapi_userinfo".equals(info)) && (code != null) && (!code.equals(""))) {
      String memberInfoStr = Common.doGet("https://api.weixin.qq.com/sns/userinfo?access_token=" + accessToken + "&openid=" + openid + "&lang=zh_CN");
      if ((memberInfoStr != null) && (!memberInfoStr.equals(""))) {
        JSONObject _member = JSON.parseObject(memberInfoStr);
        m.put("nickname", CommonString.getFormatPara(_member.get("nickname")));
        m.put("sex", CommonString.getFormatPara(_member.get("sex")));
        m.put("province", CommonString.getFormatPara(_member.get("province")));
        m.put("city", CommonString.getFormatPara(_member.get("city")));
        m.put("country", CommonString.getFormatPara(_member.get("country")));
        m.put("headimgurl", CommonString.getFormatPara(_member.get("headimgurl")));
      }
    }
    return m;
  }

}