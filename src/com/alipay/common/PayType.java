package com.alipay.common;



/**
 * 付款方式
 */
public class PayType implements java.io.Serializable {
  /**
   * 支付宝
   */
  public static final String TYPE_ALIPAY = "ALIPAY";
  /**
   * 手机支付宝
   */
  public static final String TYPE_MOALIPAY = "MOALIPAY";
  /**
   * 微信支付
   */
  public static final String TYPE_WX = "WX";
  /**
   * 线上支付
   */
  public static final String TYPE_ONLINE = "ONLINE";
  /**
   * 汇款/转账
   */
  public static final String TYPE_REMIT = "REMIT";
  /**
   * 货到付款 cash on delivery
   */
  public static final String TYPE_COD = "COD";
  /**
   * 银联支付 cash on delivery
   */
  public static final String TYPE_UNIONPAY = "UNIONPAY";

  private long id;
  private String no;
  private String name;
  private boolean isCod;

  private boolean isPayByVoucher;
  private int platformTypes;
  private int expireDays;

  private String logoUrl;
  private String implClass;
  private String appId;
  private String appPwd;

  // 冗余字段
  private String prop1, prop2;


  public long getId() {
    return id;
  }

  public void setId(long id) {
    this.id = id;
  }

  public String getNo() {
    return no;
  }

  public void setNo(String no) {
    this.no = no;
  }

  public String getName() {
    return name;
  }

  public void setName(String name) {
    this.name = name;
  }

  /**
   * 是否货到付款
   *
   * @return
   */
  public boolean isCod() {
    return isCod;
  }

  public void setIsCod(boolean isCod) {
    this.isCod = isCod;
  }

  /**
   * 是否根据支付凭证确认支付
   *
   * @return
   */
  public boolean isPayByVoucher() {
    return isPayByVoucher;
  }

  public void setIsPayByVoucher(boolean isPayByVoucher) {
    this.isPayByVoucher = isPayByVoucher;
  }

  /**
   * 使用平台（按位组合，参考Platform枚举）
   *
   * @return
   */
  public int getPlatformTypes() {
    return platformTypes;
  }

  public void setPlatformTypes(int platformTypes) {
    this.platformTypes = platformTypes;
  }

  /**
   * 检查是否适用指定平台
   *
   * @param platform
   * @return
   */
  //public boolean supports(Platform platform) {
  //  return (this.platformTypes & platform.getValue()) == platform.getValue();
  //}

  /**
   * 支付超期天数(从当天24：00开始计算)，如果小于0表示永不超时，等于0表示使用系统设置
   *
   * @return
   */
  public int getExpireDays() {
    return expireDays;
  }

  public void setExpireDays(int expireDays) {
    this.expireDays = expireDays;
  }

  /**
   * 支付方式logo地址
   *
   * @return
   */
  public String getLogoUrl() {
    return logoUrl;
  }

  public void setLogoUrl(String logoUrl) {
    this.logoUrl = logoUrl;
  }

  /**
   * 第三方支付使用appId/Key
   *
   * @return
   */
  public String getAppId() {
    return appId;
  }

  public void setAppId(String appId) {
    this.appId = appId;
  }

  /**
   * 第三方支付使用appSecret/Pwd
   *
   * @return
   */
  public String getAppPwd() {
    return appPwd;
  }

  public void setAppPwd(String appPwd) {
    this.appPwd = appPwd;
  }

  /**
   * 第三方支付接口实现类名称
   *
   * @return
   */
  public String getImplClass() {
    return implClass;
  }

  public void setImplClass(String implClass) {
    this.implClass = implClass;
  }

  /**
   * 冗余字段1
   *
   * @return
   */
  public String getProp1() {
    return prop1;
  }

  public void setProp1(String prop1) {
    this.prop1 = prop1;
  }

  /**
   * 冗余字段2
   *
   * @return
   */
  public String getProp2() {
    return prop2;
  }

  public void setProp2(String prop2) {
    this.prop2 = prop2;
  }
}
