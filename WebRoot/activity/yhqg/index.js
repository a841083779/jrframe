jQuery.getJSON("action.jsp?callback=?&flag=gz", function(json){
    jQuery("#gz_1").html(json.gz_1);
    jQuery("#gz_2").html(json.gz_2);
    jQuery("#gz_3").html(json.gz_3);
    jQuery("#gz_4").html(json.gz_4);
});
jQuery.jBox.setDefaults({
    defaults: {
        border: 0
    }
});
function doLogin(){
    jQuery.jBox("iframe:login.jsp", {
        title: "手机号登录",
        top: "40%",
        width: 300,
        height: 160,
        buttons: {
            '提交': false,
            '关闭': true
        },
        submit: function(v, h, f){
            if (!v) {
                var vRs = jQuery.jBox.getIframe().contentWindow.doSub();
                return vRs;
            }
            return true;
        }
    });
}

function doReg(){
    jQuery.jBox("iframe:reg.jsp", {
        title: "用户注册",
        width: 300,
        top: '30%',
        height: 200,
        buttons: {
            '提交': false,
            '关闭': true
        },
        submit: function(v, h, f){
            if (!v) {
                var vRs = jQuery.jBox.getIframe().contentWindow.doSub();
                if (vRs) {
                    showRegSuccess();
                }
                return vRs;
            }
            return true;
        }
    });
}

document.getElementById("bdshell_js").src = "http://bdimg.share.baidu.com/static/js/shell_v2.js?cdnversion=" + Math.ceil(new Date() / 3600000);
/**
 * 开始抢购
 */
function doRealQianggou(name){
    //首先判断是否登录，如果登录了
    if (isLogin()) {
        jQuery.jBox.tip("抢购进行中。。。", "loading");
        setTimeout(function(){
            //进行抢购
            jQuery.ajax({
                url: 'action.jsp',
                type: 'post',
                data: {
                    flag: 'qiangGou',
                    items: name
                },
                aysnc: false,
                cache: false,
                success: function(data){
                    jQuery.jBox.closeTip();
                    var tData = jQuery.trim(data);
                    var content = '';
                    if (tData == 'exist') {
                        content = '';
                        content += '<div class="tip clearfix">';
                        content += '<span class="img01"><img src="images/tip_img.gif"></span>';
                        content += '<span class="text01" style="width:220px;"><span class="red">您已经抽取过该产品</span><br />请勿重复抽取，谢谢！</span>';
                        content += '<span class="text02">';
                        content += '<span>温馨提示：本次活动仅限山东地区</span>';
                        content += '</span>';
                        content += '</div>';
                        jQuery.jBox.error(content, "温馨提示", {
                            top: "40%",
                            width: 500,
                            height: 200
                        });
                    }
                    else 
                        if (tData == 'other2') {
                            content = '';
                            content += '<div class="tip clearfix">';
                            content += '<span class="img01"><img src="images/tip_img.gif"></span>';
                            content += '<span class="text01" style="width:220px; font-size:14px; line-height:20px;"><span class="red">恭喜您，抢购成功!</span><br />您获得了挖掘机产品2000小时保养配件及5000元优惠券，请您在72小时之内去当地代理商处进行领取，<br />谢谢！</span>';
                            content += '<span class="text02">';
                            content += '<span>温馨提示：本次活动仅限山东地区</span>';
                            content += '</span>';
                            content += '</div>';
                            jQuery.jBox.alert(content, "温馨提示", {
                                top: "40%",
                                width: 500,
                                height: 250
                            });
                        }
                        else 
                            if (tData == 'DX345LC_2') {
                                content = '';
                                content += '<div class="tip clearfix">';
                                content += '<span class="img01"><img src="images/tip_img.gif"></span>';
                                content += '<span class="text01" style="width:220px; font-size:14px; line-height:20px;"><span class="red">恭喜您，抢购成功!</span><br />';
                                content += '您获得了DX345LC挖掘机抢购第二名，可以享受8.8折购买该机的优惠，请您在72小时之内到当地代理商处进行兑换！</span>';
                                content += '<span class="text02">';
                                content += '<span>温馨提示：本次活动仅限山东地区</span>';
                                content += '</span>';
                                content += '</div>';
                                jQuery.jBox.alert(content, "温馨提示", {
                                    top: "40%",
                                    width: 500,
                                    height: 250
                                });
                            }
                            else 
                                if (tData == 'DX345LC_3') {
                                    content = '';
                                    content += '<div class="tip clearfix">';
                                    content += '<span class="img01"><img src="images/tip_img.gif"></span>';
                                    content += '<span class="text01" style="width:220px; font-size:14px; line-height:20px;"><span class="red">恭喜您，抢购成功!</span><br />';
                                    content += '您获得了DX345LC挖掘机抢购第三名，可以享受9折购买该机的优惠，请您在72小时之内到当地代理商处进行兑换！</span>';
                                    content += '<span class="text02">';
                                    content += '<span>温馨提示：本次活动仅限山东地区</span>';
                                    content += '</span>';
                                    content += '</div>';
                                    jQuery.jBox.alert(content, "温馨提示", {
                                        top: "40%",
                                        width: 500,
                                        height: 250
                                    });
                                }
                                else 
                                    if (tData == 'DX380LC_2') {
                                        content = '';
                                        content += '<div class="tip clearfix">';
                                        content += '<span class="img01"><img src="images/tip_img01.gif"></span>';
                                        content += '<span class="text01" style="width:220px; font-size:14px; line-height:20px;"><span class="red">恭喜您，抢购成功!</span><br />';
                                        content += '您获得了DX380LC挖掘机抢购第二名，可以享受3年6000小时超长保修期及10000元优惠券，请您在72小时之内到当地代理商处进行兑换！</span>';
                                        content += '<span class="text02">';
                                        content += '<span>温馨提示：本次活动仅限山东地区</span>';
                                        content += '</span>';
                                        content += '</div>';
                                        jQuery.jBox.alert(content, "温馨提示", {
                                            top: "40%",
                                            width: 500,
                                            height: 250
                                        });
                                    }
                                    else 
                                        if (tData == 'DX380LC_3') {
                                            content = '';
                                            content += '<div class="tip clearfix">';
                                            content += '<span class="img01"><img src="images/tip_img01.gif"></span>';
                                            content += '<span class="text01" style="width:225px; font-size:14px; line-height:20px;"><span class="red">恭喜您，抢购成功!</span><br />';
                                            content += '您获得了DX380LC挖掘机抢购第三名，可以享受3年6000小时超长保修期及5000元优惠券，请您在72小时之内到当地代理商处进行兑换！</span>';
                                            content += '<span class="text02">';
                                            content += '<span>温馨提示：本次活动仅限山东地区</span>';
                                            content += '</span>';
                                            content += '</div>';
                                            jQuery.jBox.alert(content, "温馨提示", {
                                                top: "40%",
                                                width: 500,
                                                height: 250
                                            });
                                        }
                                        else 
                                            if (tData == 'other1_2') {
                                                content = '';
                                                content += '<div class="tip clearfix">';
                                                content += '<span class="img01"><img src="images/tip_img02.gif"></span>';
                                                content += '<span class="text01" style="width:215px; font-size:14px; line-height:20px;"><span class="red">恭喜您，抢购成功!</span><br />';
                                                content += '您获得了斗山其他挖掘机产品保养及优惠券抢购第二名，可以享受4000小时保养配件，请您在72小时之内到当地代理商处进行兑换！</span>';
                                                content += '<span class="text02">';
                                                content += '<span>温馨提示：本次活动仅限山东地区</span>';
                                                content += '</span>';
                                                content += '</div>';
                                                jQuery.jBox.alert(content, "温馨提示", {
                                                    top: "40%",
                                                    width: 500,
                                                    height: 250
                                                });
                                            }
                                            else 
                                                if (tData == 'other1_3') {
                                                    content = '';
                                                    content += '<div class="tip clearfix">';
                                                    content += '<span class="img01"><img src="images/tip_img02.gif"></span>';
                                                    content += '<span class="text01" style="width:225px; font-size:14px; line-height:20px;"><span class="red">恭喜您，抢购成功!</span><br />';
                                                    content += '您获得了斗山其他挖掘机产品保养及优惠券抢购第三名，可以享受3000小时保养配件，请您在72小时之内到当地代理商处进行兑换！</span>';
                                                    content += '<span class="text02">';
                                                    content += '<span>温馨提示：本次活动仅限山东地区</span>';
                                                    content += '</span>';
                                                    content += '</div>';
                                                    jQuery.jBox.alert(content, "温馨提示", {
                                                        top: "40%",
                                                        width: 500,
                                                        height: 250
                                                    });
                                                }
                                                else 
                                                    if (tData == 'no') {
                                                        content = '';
                                                        content += '<div class="tip clearfix" style="margin-left:10px;">';
                                                        content += '<span class="img01" style="padding-top:11px;"><img src="images/tip_img.gif"></span>';
                                                        content += '<span class="text01" style="width:220px; font-size:14px; line-height:20px;"><span class="red" style="font-size:20px;">很遗憾，您未抢购成功</span><br />';
                                                        content += '您还有机会抢购其它机器哦，不要放弃，马上抢购</span>';
                                                        content += '<span class="text02">';
                                                        content += '<a href="javascript:void(0);" onclick="toNextQiangGou();" title="确定"><img src="images/tip_03.gif" alt="确定" /></a>';
                                                        content += '<span style="padding:10px 0px 10px;">温馨提示：本次活动仅限山东地区</span>';
                                                        content += '</span>';
                                                        content += '</div>';
                                                        //判断是否可以继续进行抢购了
                                                        jQuery.jBox(content, {
                                                            title: "温馨提示",
                                                            top: "40%",
                                                            buttons: null,
                                                            width: 450,
                                                            height: 210
                                                        });
                                                    }
                                                    else 
                                                        if (tData == 'no_over') {
                                                            toNextQiangGou(true);
                                                        }
                                                        else {
                                                            jQuery.jBox.error("服务器故障，请您稍后再试！", "温馨提示", {
                                                                top: "40%"
                                                            });
                                                        }
                }
            });
        }, 1000);
        
    }
}

function isLogin(){
    var rs = true;
    jQuery.ajax({
        url: "action.jsp",
        data: {
            flag: 'isLogin'
        },
        cache: false,
        async: false,
        success: function(data){
            if (jQuery.trim(data) == 'no_login') {
                rs = false;
                var content = '';
                content += '<div class="tip clearfix">';
                content += '<span class="text01">您尚未登录，登录后才能参与抢购活动！</span>';
                content += '<span class="text02">';
                content += '<a href="javascript:void(0);" onclick="jQuery.jBox.close();doLogin();"><img src="images/tip_01.gif" alt="我要登录" /></a> <a href="javascript:void(0);" onclick="jQuery.jBox.close();doReg();"><img src="images/tip_02.gif" alt="我要注册" /></a>';
                content += '<span>温馨提示：本次活动仅限山东地区</span>';
                content += '</span>';
                content += '<span class="img01"><img src="images/tip_img.gif" /></span>';
                content += '</div>';
                jQuery.jBox.error(content, "温馨提示", {
                    title: "温馨提示",
                    top: "40%",
                    buttons: null,
                    width: 500,
                    height: 210
                });
            }
        }
    });
    return rs;
}

function toNextQiangGou(bool){
    if (typeof(bool) == 'undefined') {
        jQuery.jBox.close();
        jQuery.jBox.tip("抢购进行中。。。", "loading");
    }
    setTimeout(function(){
        jQuery.post("action.jsp", {
            flag: "getNextQiangGou"
        }, function(data){
            jQuery.jBox.closeTip();
            var tData = jQuery.trim(data);
            if (tData == 'no') {
                var content = '';
                content += '<div class="tip clearfix">';
                content += '<span class="img01" style="padding-top:11px;"><a href="javascript:void(0);" onclick="doLingQuYouHui();"><img src="images/quan.gif"></a></span>';
                content += '<span class="text01" style="width:210px; font-size:14px; line-height:20px;"><span class="red" style="font-size:20px;">很遗憾，您未抢购成功</span><br />';
                content += '不要气馁，您还有机会领取2000小时保养配件及5000元优惠券<br /><span style="color:#fd9933; font-size:12px;">（仅限参与活动挖掘机产品）</span></span>';
                content += '<span class="text02">';
                content += '<span>温馨提示：本次活动仅限山东地区</span>';
                content += '<span>如有疑问，请联系：0535-6792733</span>';
                content += '</span>';
                content += '</div>';
                jQuery.jBox.error(content, "温馨提示", {
                    top: "40%",
                    buttons: null,
                    width: 500,
                    height: 220
                });
            }
            else {
                window.location.href = "/activity/yhqg/index.jsp#" + tData;
            }
        });
    }, 1000);
}

function doLingQuYouHui(){
    jQuery.jBox.close();
    var content = '';
    content += '<div class="tip clearfix">';
    content += '<span class="img01"><img src="images/tip_img.gif"></span>';
    content += '<span class="text01" style="width:220px; font-size:14px; line-height:20px;"><span class="red">优惠券领取成功!</span><br />您获得了挖掘机产品2000小时保养配件及5000元优惠券，请您在72小时之内去当地代理商处进行领取，<br />谢谢！</span>';
    content += '<span class="text02">';
    content += '<span>温馨提示：本次活动仅限山东地区</span>';
    content += '</span>';
    content += '</div>';
    jQuery.jBox.alert(content, "温馨提示", {
        top: "40%",
        width: 500,
        height: 250
    });
    jQuery.post("action.jsp", {
        flag: "qiangGou",
        items: 'other2'
    });
}

function doQiangGou(name){
    //如果时间到了
    if (timeIsOver) {
        doRealQianggou(name);
        return;
    }
    jQuery.post("action.jsp", {
        flag: 'counts',
        name: name
    });
    //判断是否登录
    if (isLogin()) {
        var content = '';
        content += '<div class="tip clearfix">';
        content += '<span class="text01">抢购还未开始哦，先看看<a href="process.jsp" style="color:red;">活动规则</a>吧</span>';
        content += '<span class="text02">';
        content += '<span>温馨提示：本次活动仅限山东地区</span>';
        content += '</span>';
        content += '<span class="img01"><img src="images/tip_img.gif"></span>';
        content += '</div>';
        jQuery.jBox.error(content, "温馨提示", {
            title: "温馨提示",
            top: "40%",
            buttons: null,
            width: 500,
            height: 200
        });
    }
}

function jrOpen(xh){
    var url = '';
    if (xh == 'DX345LC') {
        url = 'http://product.21-sun.com/proDetail/DX345LC.shtm';
    }
    else 
        if (xh == 'DX380LC') {
            url = 'http://product.21-sun.com/proDetail/DX380LC.shtm';
        }
        else 
            if (xh == 'other1') {
                url = 'http://product.21-sun.com/products/prolist.jsp?factory=192';
            }
            else 
                if (xh == 'other2') {
                    url = 'http://product.21-sun.com/products/prolist.jsp?factory=192';
                }
    jQuery.post("action.jsp", {
        flag: 'counts',
        name: xh
    });
    window.open(url);
}

function toLogin(){
    jQuery.jBox.close();
    jQuery.jBox.close();
    doLogin();
}

function toChange(){
    jQuery.jBox.close();
    var myPhone = jQuery.jBox.getIframe().contentWindow.jQuery("#phone");
    myPhone.val("");
    myPhone.focus();
}

loadLogin();

function loadLogin(){
    jQuery.post("action.jsp", {
        flag: "isLogin"
    }, function(data){
        var tData = jQuery.trim(data);
        if (tData != 'no_login') {
            jQuery("#login_reg").html("<a href='exit.jsp' style='text-decoration: underline;'>登出</a> | 欢迎您，" + tData + "，您可以参加抢购！");
        }
    });
}

function oneNext(){
    jQuery(".step01").hide();
    jQuery(".step02").show();
}

function twoPrev(){
    jQuery(".step02").hide();
    jQuery(".step01").show();
}

function tiYanClose(){
    jQuery(".tsCover").remove();
    jQuery(".ts").remove();
    jQuery.cookies.set("yhqg_tiyan", "yhqg_tiyan");
}

jQuery(function(){
    var yhqg_tiyan = jQuery.cookies.get("yhqg_tiyan");
    if (yhqg_tiyan != 'yhqg_tiyan') {
        jQuery(".tsCover").show();
        jQuery(".ts").show();
    }
});

function showRegSuccess(){
    jQuery.jBox.close();
    var content = '';
    content += '<div class="tip clearfix">';
    content += '<span class="img01"><img src="images/tip_img.gif"></span>';
    content += '<span class="text01" style="width:210px;">恭喜您注册成功！</span>';
    content += '<span class="text02" style="padding:0px 0px 5px;">';
    content += '<span style="padding:0px 0px 10px;">温馨提示：本次活动仅限山东地区</span>';
    content += '<a href="javascript:void(0);" onclick="jQuery.jBox.close();" title="确定"><img src="images/tip_03.gif" alt="确定" /></a>';
    content += '</span>';
    content += '</div>';
    jQuery.jBox.alert(content, "温馨提示", {
        top: "40%",
        width: 500,
        height: 200,
        buttons: null
    });
    loadLogin();
}

function zhongJiangJieGuo(){
    jQuery.jBox("iframe:result.jsp", {
        title: "中奖结果",
        top: "40%",
        width: 260,
        height: 120,
        buttons: {
            '查询': true,
            '关闭': false
        },
        submit: function(v, h, f){
        
        }
    });
}

/**
 * 时间到了以后开放该方法
 */
function doQiangGou(){
    jQuery.jBox.error("活动时间已过，感谢您的关注，下来抢购再来！", "提示", {
        top: "40%"
    });
}
