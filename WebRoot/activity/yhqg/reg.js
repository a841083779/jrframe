var t;
var getBtn = jQuery("#getBtn");
function getCode(o){
    if (!vPhone()) {
        return;
    }
    var _bool = true;
    getBtn.val("发送中");
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
                parent.jQuery.jBox.error("一分钟之内您只能获取一次验证码，请您稍后再获取！", "温馨提示", {
                    top: "40%"
                });
                getBtn.val("获取");
                _bool = false;
            }
        }
    });
    if (!_bool) {
        return;
    }
    miao = 60;
    getBtn.attr("disabled", "disabled");
    var self = jQuery(o);
    t = window.setInterval(function(){
        if (miao == 0) {
            window.clearInterval(t);
            getBtn.val("获取");
            miao = 60;
            getBtn.removeAttr("disabled", "disabled");
        }
        else {
            getBtn.val(miao + "秒");
        }
        miao--;
    }, 1000);
}

function vPhone(){
    if (jQuery("#phone").val() == '') {
        parent.jQuery.jBox.error("请您输入手机号！", "温馨提示", {
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
    if (!vPhone()) {
        return false;
    }
    if (jQuery("#name").val() == '') {
        parent.jQuery.jBox.error("请输入姓名！", "温馨提示", {
            top: "40%"
        });
        jQuery("#name").focus();
        return false;
    }
    if (jQuery("#password").val() == '') {
        parent.jQuery.jBox.error("请输入密码！", "温馨提示", {
            top: "40%"
        });
        jQuery("#password").focus();
        return false;
    }
    /**
     * 如果有验证码
     */
    if (jQuery("#code").length > 0) {
        if (jQuery("#code").val() == '') {
            parent.jQuery.jBox.error("请输入验证码！", "温馨提示", {
                top: "40%"
            });
            jQuery("#code").focus();
            return false;
        }
    }
    return true;
}

function doSub(){
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
                parent.jQuery.jBox.error("验证码输入错误，请重新输入！", "温馨提示", {
                    top: "40%"
                });
                jQuery("#code").val("");
                jQuery("#code").focus();
            }
            else 
                if (tData == 'exist') {
                    var content = '该手机号已经注册过该活动！<br />';
                    content += '您可以选择<a href="javascript:void(0);" style="text-decoration: underline;" onclick="toLogin();">登录</a><br />';
                    content += '或者<a href="javascript:void(0);" style="text-decoration: underline;" onclick="toChange();">更换手机号</a>进行注册<br />';
                    parent.jBox.error(content, "温馨提示", {
                        top: "40%",
                        buttons: null
                    });
                }
                else 
                    if (tData == 'overtime') {
                        parent.jQuery.jBox.error("验证码已超时，请您重新获取验证码！", "温馨提示", {
                            top: "40%"
                        });
                    }
                    else 
                        if (tData == 'no_code') {
                            parent.jQuery.jBox.error("您尚未获取验证码，请您获取验证码后再进行注册！", "温馨提示", {
                                top: "40%"
                            });
                        }
                        else {
                            rs = true;
                        }
        }
    });
    return rs;
}

/**
 * 验证手机是否存在
 */
function vPhoneIsIn(){
    jQuery.post("action.jsp", {
        flag: 'vPhoneIsIn',
        phone: jQuery("#phone").val()
    }, function(data){
        if (jQuery.trim(data) == 'exist') {
            var content = '该手机号已经注册过该活动！<br />';
            content += '您可以选择<a href="javascript:void(0);" style="text-decoration: underline;" onclick="toLogin();">登录</a><br />';
            content += '或者<a href="javascript:void(0);" style="text-decoration: underline;" onclick="toChange();">更换手机号</a>进行注册<br />';
            parent.jBox.error(content, "温馨提示", {
                top: "40%",
                buttons: null
            });
        }
    });
}

jQuery("#phone").blur(function(){
    if (jQuery("#phone").val() != '') {
        vPhoneIsIn();
    }
});


jQuery("#phone").keyup(function(e){
    if (e.keyCode == 13) {
        jQuery("#name").focus();
    }
});

jQuery("#name").keyup(function(e){
    if (e.keyCode == 13) {
        jQuery("#password").focus();
    }
});

jQuery("#password").keyup(function(e){
    if (e.keyCode == 13) {
        /**
         * 如果有验证码
         */
        if (jQuery("#code").length > 0) {
            jQuery("#code").focus();
        }
        else {
            if (doSub()) {
                parent.showRegSuccess();
            }
        }
    }
});


jQuery("#code").keyup(function(e){
    if (e.keyCode == 13) {
        if (doSub()) {
            parent.showRegSuccess();
        }
    }
});

jQuery(function(){
    jQuery("#phone").focus();
});
