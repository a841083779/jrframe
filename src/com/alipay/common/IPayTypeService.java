package com.alipay.common;

import com.alipay.common.PayType;


import java.util.List;

/**
 * 付款方式
 */
public interface IPayTypeService {
  /**
   * 查找付款方式
   *
   * @param payTypeId
   * @return
   */
  PayType findPayType(long payTypeId);

  /**
   * 查找付款方式
   *
   * @param payTypeNO
   * @return
   */
  PayType findPayType(String payTypeNO);

  /**
   * 查找指定平台适用的支付方式
   *
   * @param platform
   * @return
   */
  //List<PayType> listPayTypes(Platform platform);

}
