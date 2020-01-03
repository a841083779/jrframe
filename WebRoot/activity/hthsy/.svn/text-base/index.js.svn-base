var getBtn = jQuery("#getBtn");
function getCode(o){
    if (!vPhone()) {
        return;
    }
    var _bool = true;
    getBtn.html("发送中");
    jQuery.ajax({
        url: 'action.jsp',
        data: {
            flag: 'getCode',
            phone: jQuery("#phone").val()
        },
        async: false,
        cache: false,
        success: function(data){
            var tData = jQuery.trim(data);
            if (tData == 'code_no_time') {
                jQuery.jBox.error("一分钟之内您只能获取一次验证码，请您稍后再获取！", "温馨提示", {
                    top: "40%"
                });
                getBtn.html("获取");
                _bool = false;
            }
        }
    });
    if (!_bool) {
        return;
    }
    miao = 60;
    getBtn.unbind("click");
    var self = jQuery(o);
    t = window.setInterval(function(){
        if (miao == 0) {
            window.clearInterval(t);
            getBtn.html("获取");
            miao = 60;
            getBtn.click(function(){
                getCode(this);
            });
        }
        else {
            getBtn.html(miao + "秒");
        }
        miao--;
    }, 1000);
}

function vPhone(){
    if (jQuery("#phone").val() == '') {
        jQuery.jBox.error("请您输入手机号！", "温馨提示", {
            top: "40%",
            submit: function(){
                var myPhone = jQuery("#phone");
                myPhone.val("");
                myPhone.focus();
            }
        });
        return false;
    }
    return true;
}

function vForm(){
    if (jQuery("#city").val() == '') {
        jQuery.jBox.error("请选择所在城市！", "温馨提示", {
            top: "40%"
        });
        jQuery("#city").focus();
        return false;
    }
    if (jQuery("#model").val() == '') {
        jQuery.jBox.error("请选择预约车型！", "温馨提示", {
            top: "40%"
        });
        jQuery("#model").focus();
        return false;
    }
    if (jQuery("#name").val() == '') {
        jQuery.jBox.error("请输入真实姓名！", "温馨提示", {
            top: "40%"
        });
        jQuery("#name").focus();
        return false;
    }
    if (!vPhone()) {
        return false;
    }
    /**
     * 如果有验证码
     */
    if (jQuery("#code").length > 0) {
        if (jQuery("#code").val() == '') {
            jQuery.jBox.error("请输入验证码！", "温馨提示", {
                top: "40%"
            });
            jQuery("#code").focus();
            return false;
        }
    }
    return true;
}

function doSub(){
	jQuery.jBox.tip("活动已结束！");
	return false;
    if (!vForm()) {
        return false;
    }
    var rs = false;
    jQuery("#theform").ajaxSubmit({
        type: "POST",
        async: false,
        cache: false,
        success: function(data){
            var tData = jQuery.trim(data);
            if (tData == 'code_error') {
                jQuery.jBox.error("验证码输入错误，请重新输入！", "温馨提示", {
                    top: "40%"
                });
                jQuery("#code").val("");
                jQuery("#code").focus();
            }
            else 
                if (tData == 'exist') {
                    var content = '该手机号已经注册过该活动，请您更换手机号后再注册！';
                    jBox.error(content, "温馨提示", {
                        top: "40%",
                        buttons: null
                    });
                }
                else 
                    if (tData == 'overtime') {
                        jQuery.jBox.error("验证码已超时，请您重新获取验证码！", "温馨提示", {
                            top: "40%"
                        });
                    }
                    else 
                        if (tData == 'no_code') {
                            jQuery.jBox.error("您尚未获取验证码，请您获取验证码后再进行注册！", "温馨提示", {
                                top: "40%"
                            });
                        }
                        else {
                            jQuery.jBox.info("恭喜您，信息提交成功，稍后您将会收到我们发送的优惠码。", "温馨提示", {
                                top: "40%"
                            });
							jQuery("#theform").resetForm();
                        }
        }
    });
    return rs;
}

function doZhongJiangChaXun(){
    jQuery("#theform").ajaxSubmit({
        type: "POST",
        async: false,
        cache: false,
        success: function(data){
            var tData = jQuery.trim(data);
            if (tData == 'no') {
                jQuery.jBox.error("该优惠码与手机号不匹配，请重新输入优惠码！", "温馨提示", {
                    top: "40%"
                });
            }
            else {
                jQuery.jBox.info(tData, "温馨提示", {
                    top: "40%"
                })
            }
        }
    });
}
