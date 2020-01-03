function doSub(){
    if (!vForm()) {
        return false;
    }
    jQuery("#theform").ajaxSubmit({
        type: "POST",
        async: false,
        cache: false,
        success: function(data){
            var tData = jQuery.trim(data);
            if (tData == 'error_password') {
                parent.jBox.error("您的密码输入错误！", "温馨提示", {
                    top: "40%"
                });
            }
            else 
                if (tData == 'no_id') {
                    parent.jBox.error("该帐号不存在！", "温馨提示", {
                        top: "40%"
                    });
                }
                else 
                    if (tData == 'ok') {
                        parent.loadLogin();
                        parent.jBox.close();
                    }
                    else {
                        parent.jBox.error("服务器故障，请您稍后再试！", {
                            top: "40%"
                        });
                    }
        }
    });
    return false;
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
    if (jQuery("#password").val() == '') {
        parent.jQuery.jBox.error("请输入密码！", "温馨提示", {
            top: "40%"
        });
        return false;
    }
    return true;
}

jQuery("#phone").keyup(function(e){
    if (e.keyCode == 13) {
        jQuery("#password").focus();
    }
});

jQuery("#password").keyup(function(e){
    if (e.keyCode == 13) {
        doSub();
    }
});

jQuery(function(){
    jQuery("#phone").focus();
});
