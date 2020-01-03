/**
 * jQuery's jqfaceedit Plugin
 *
 * @author cdm
 * @version 0.1
 * @copyright Copyright(c) 2012.
 * @date 2012-02-20
 */
(function($) {
    var em = [
              {'id':1,'phrase':'[h001]','url':'h001.png'},{'id':2,'phrase':'[h002]','url':'h002.png'},
              {'id':3,'phrase':'[h003]','url':'h003.png'},{'id':4,'phrase':'[h004]','url':'h004.png'},
              {'id':5,'phrase':'[h005]','url':'h005.png'},{'id':6,'phrase':'[h006]','url':'h006.png'},
              {'id':7,'phrase':'[h007]','url':'h007.png'},{'id':8,'phrase':'[h008]','url':'h008.png'},
              {'id':9,'phrase':'[h009]','url':'h009.png'},{'id':10,'phrase':'[h010]','url':'h010.png'},
              {'id':11,'phrase':'[h011]','url':'h011.png'},{'id':12,'phrase':'[h012]','url':'h012.png'},
              {'id':13,'phrase':'[h013]','url':'h013.png'},{'id':14,'phrase':'[h014]','url':'h014.png'},
              {'id':15,'phrase':'[h015]','url':'h015.png'},{'id':16,'phrase':'[h016]','url':'h016.png'},
              {'id':17,'phrase':'[h017]','url':'h017.png'},{'id':18,'phrase':'[h018]','url':'h018.png'},
              {'id':19,'phrase':'[h019]','url':'h019.png'},{'id':20,'phrase':'[h020]','url':'h020.png'},
              {'id':21,'phrase':'[h021]','url':'h021.png'},{'id':22,'phrase':'[h022]','url':'h022.png'},
              {'id':23,'phrase':'[h023]','url':'h023.png'},{'id':24,'phrase':'[h024]','url':'h024.png'},
              {'id':25,'phrase':'[h025]','url':'h025.png'},{'id':26,'phrase':'[h026]','url':'h026.png'},
              {'id':27,'phrase':'[h027]','url':'h027.png'},{'id':28,'phrase':'[h028]','url':'h028.png'},
              {'id':29,'phrase':'[h029]','url':'h029.png'},{'id':30,'phrase':'[h030]','url':'h030.png'},
              {'id':31,'phrase':'[h031]','url':'h031.png'},{'id':32,'phrase':'[h032]','url':'h032.png'},
              {'id':33,'phrase':'[h033]','url':'h033.png'},{'id':34,'phrase':'[h034]','url':'h034.png'},
              {'id':35,'phrase':'[h035]','url':'h035.png'},{'id':36,'phrase':'[h036]','url':'h036.png'},
              {'id':37,'phrase':'[h037]','url':'h037.png'},{'id':38,'phrase':'[h038]','url':'h038.png'},
              {'id':39,'phrase':'[h039]','url':'h039.png'},{'id':40,'phrase':'[h040]','url':'h040.png'},
              {'id':41,'phrase':'[h041]','url':'h041.png'},{'id':42,'phrase':'[h042]','url':'h042.png'},
              {'id':43,'phrase':'[h043]','url':'h043.png'},{'id':44,'phrase':'[h044]','url':'h044.png'},
              {'id':45,'phrase':'[h045]','url':'h045.png'},{'id':46,'phrase':'[h046]','url':'h046.png'},
              {'id':47,'phrase':'[h047]','url':'h047.png'},{'id':48,'phrase':'[h048]','url':'h048.png'},
              {'id':49,'phrase':'[h049]','url':'h049.png'},{'id':50,'phrase':'[h050]','url':'h050.png'},
              {'id':51,'phrase':'[h051]','url':'h051.png'},{'id':52,'phrase':'[h052]','url':'h052.png'},
              {'id':53,'phrase':'[h053]','url':'h053.png'},{'id':54,'phrase':'[h054]','url':'h054.png'},
              {'id':55,'phrase':'[h055]','url':'h055.png'},{'id':56,'phrase':'[h056]','url':'h056.png'},
              {'id':57,'phrase':'[h057]','url':'h057.png'},{'id':58,'phrase':'[h058]','url':'h058.png'},
              {'id':59,'phrase':'[h059]','url':'h059.png'},{'id':60,'phrase':'[h060]','url':'h060.png'},
              {'id':61,'phrase':'[h061]','url':'h061.png'},{'id':62,'phrase':'[h062]','url':'h062.png'},
              {'id':63,'phrase':'[h063]','url':'h063.png'},{'id':64,'phrase':'[h064]','url':'h064.png'},
              {'id':65,'phrase':'[h065]','url':'h065.png'},{'id':66,'phrase':'[h066]','url':'h066.png'},
              {'id':67,'phrase':'[h067]','url':'h067.png'},{'id':68,'phrase':'[h068]','url':'h068.png'},
              {'id':69,'phrase':'[h069]','url':'h069.png'},{'id':70,'phrase':'[h070]','url':'h070.png'},
              {'id':71,'phrase':'[h071]','url':'h071.png'},{'id':72,'phrase':'[h072]','url':'h072.png'},
              {'id':73,'phrase':'[h073]','url':'h073.png'},{'id':74,'phrase':'[h074]','url':'h074.png'},
              {'id':75,'phrase':'[h075]','url':'h075.png'},{'id':76,'phrase':'[h076]','url':'h076.png'},
              {'id':77,'phrase':'[h077]','url':'h077.png'},{'id':78,'phrase':'[h078]','url':'h078.png'},
              {'id':79,'phrase':'[h079]','url':'h079.png'},{'id':80,'phrase':'[h080]','url':'h080.png'},
              {'id':81,'phrase':'[h081]','url':'h081.png'},{'id':82,'phrase':'[h082]','url':'h082.png'},
              {'id':83,'phrase':'[h083]','url':'h083.png'},{'id':84,'phrase':'[h084]','url':'h084.png'},
              {'id':85,'phrase':'[h085]','url':'h085.png'},{'id':86,'phrase':'[h086]','url':'h086.png'},
              {'id':87,'phrase':'[h087]','url':'h087.png'},{'id':88,'phrase':'[h088]','url':'h088.png'},
              {'id':89,'phrase':'[h089]','url':'h089.png'},{'id':90,'phrase':'[h090]','url':'h090.png'}
          ];
          
          
    var em2 = [
              {'id':1,'phrase':'[y001]','url':'y001.png'},{'id':2,'phrase':'[y002]','url':'y002.png'},
              {'id':3,'phrase':'[y003]','url':'y003.png'},{'id':4,'phrase':'[y004]','url':'y004.png'},
              {'id':5,'phrase':'[y005]','url':'y005.png'},{'id':6,'phrase':'[y006]','url':'y006.png'},
              {'id':7,'phrase':'[y007]','url':'y007.png'},{'id':8,'phrase':'[y008]','url':'y008.png'},
              {'id':9,'phrase':'[y009]','url':'y009.png'},{'id':10,'phrase':'[y010]','url':'y010.png'},
              {'id':11,'phrase':'[y011]','url':'y011.png'},{'id':12,'phrase':'[y012]','url':'y012.png'},
              {'id':13,'phrase':'[y013]','url':'y013.png'},{'id':14,'phrase':'[y014]','url':'y014.png'},
              {'id':15,'phrase':'[y015]','url':'y015.png'}
          ];
    $.fn.extend({
    jqfaceedit : function(options) {
        var defaults = {
            txtAreaObj : '', //TextArea对象
            containerObj : '', //表情框父对象
            emotions : em,//表情信息json格式，id表情排序号 phrase表情使用的替代短语url表情文件名
            emotions2 : em2,//表情信息json格式，id表情排序号 phrase表情使用的替代短语url表情文件名
			imageurl: '/plugin/emotions/emotions/',
			imageurl2: '/plugin/emotions/baobao/',
            top : 0, //相对偏移
            left : 0 //相对偏移
        };
        var options = $.extend(defaults, options);
        return this.each(function() {
            var Obj = $(this);
            var container = options.containerObj;
            $(Obj).bind("click", function(e) {
            	jQuery("#imgLayer").hide();
                e.stopPropagation();
                var faceHtml = '';
                faceHtml += '<div id="face">';
                faceHtml += '<div id="texttb">';
                faceHtml += '<ul class="texttbTab">';
                faceHtml += '<li class="selected" onclick="emChoose(this,1);">阳光宝宝</li>';
                faceHtml += '<li onclick="emChoose(this,2);">系统默认</li>';
                faceHtml += '</ul>';
                faceHtml += '<a class="f_close" title="关闭" href="javascript:void(0);"></a>';
                faceHtml += '</div>';
                faceHtml += '<div id="facebox">';
                faceHtml += '<div id="face_detail" class="facebox clearfix faceBaobao">';
                faceHtml += '<ul class="baobao">';
                for( i = 0; i < options.emotions2.length; i++) {
                    faceHtml += '<li text=' + options.emotions2[i].phrase + ' type=' + i + '><img title=' + options.emotions2[i].phrase + ' src="'+options.imageurl2 + options.emotions2[i].url + '" /></li>';
                }
                faceHtml += '</ul>';
                faceHtml += '</div>';
                faceHtml += '<div id="face_detail" class="facebox clearfix faceDetail displayem">';
                faceHtml += '<ul>';
                for( i = 0; i < options.emotions.length; i++) {
                    faceHtml += '<li text=' + options.emotions[i].phrase + ' type=' + i + '><img title=' + options.emotions[i].phrase + ' src="'+options.imageurl + options.emotions[i].url + '"  style="cursor:pointer; position:relative;"   /></li>';
                }
                faceHtml += '</ul></div>';
                faceHtml += '</div><div class="arrow arrow_t"></div></div>';
                container.find('#face').remove();
                container.append(faceHtml)

                container.find("#face_detail ul >li").bind("click", function(e) {
                    var txt = $(this).attr("text");
                    var faceText = txt;

                    options.txtAreaObj.val(options.txtAreaObj.val() + faceText);
					//Limit(oTextarea, 280, oH2);
                    container.find("#face").remove();

                    var setFocusText = options.txtAreaObj;
                    var setFocusTextLeg = setFocusText.val().length;
                    setFocusText.focus();
                    // 默认使用focus方法聚焦
                    // 判断是否为Ie浏览器
                    if($.browser.msie) {
                        var txt = setFocusText[0].createTextRange();
                        // 将传入的控件对象转换为Dom对象，并创建一个TextRange对象
                        txt.moveStart('character', setFocusTextLeg);
                        // 设置光标显示的位置
                        txt.collapse(true);
                        txt.select();
                    }
                });
                //关闭表情框
                container.find(".f_close").bind("click", function() {
                    container.find("#face").remove();
                });
                //处理js事件冒泡问题
                $('body').bind("click", function(e) {
                	e.stopPropagation();
                    container.find('#face').remove();
                });
                container.find('#face').bind("click",function(e){
                	e.stopPropagation();
                });

                var offset = $(e.target).offset();
                offset.top += options.top;
                offset.left += options.left;
                container.find("#face").css(offset).show();
            });
        });
    },
    
    jqfaceedit2 : function(options) {
        var defaults = {
            txtAreaObj : '', //TextArea对象
            containerObj : '', //表情框父对象
            emotions : em,//表情信息json格式，id表情排序号 phrase表情使用的替代短语url表情文件名
            emotions2 : em2,//表情信息json格式，id表情排序号 phrase表情使用的替代短语url表情文件名
			imageurl: '/plugin/emotions/emotions/',
			imageurl2: '/plugin/emotions/baobao/',
            top : 0, //相对偏移
            left : 0 //相对偏移
        };
        var options = $.extend(defaults, options);
        return this.each(function() {
            var Obj = $(this);
            var container = options.containerObj;
            $(Obj).bind("click", function(e) {
            	jQuery("#imgLayer").hide();
                e.stopPropagation();
                var faceHtml = '';
                faceHtml += '<div id="face2">';
                faceHtml += '<div id="texttb">';
                faceHtml += '<ul class="texttbTab">';
                faceHtml += '<li class="selected" onclick="emChoose(this,1);">阳光宝宝</li>';
                faceHtml += '<li onclick="emChoose(this,2);">系统默认</li>';
                faceHtml += '</ul>';
                faceHtml += '<a class="f_close" title="关闭" href="javascript:void(0);"></a>';
                faceHtml += '</div>';
                faceHtml += '<div id="facebox">';
                faceHtml += '<div id="face_detail" class="facebox clearfix faceBaobao">';
                faceHtml += '<ul class="baobao">';
                for( i = 0; i < options.emotions2.length; i++) {
                    faceHtml += '<li text=' + options.emotions2[i].phrase + ' type=' + i + '><img title=' + options.emotions2[i].phrase + ' src="'+options.imageurl2 + options.emotions2[i].url + '" /></li>';
                }
                faceHtml += '</ul>';
                faceHtml += '</div>';
                faceHtml += '<div id="face_detail" class="facebox clearfix faceDetail displayem">';
                faceHtml += '<ul>';
                for( i = 0; i < options.emotions.length; i++) {
                    faceHtml += '<li text=' + options.emotions[i].phrase + ' type=' + i + '><img title=' + options.emotions[i].phrase + ' src="'+options.imageurl + options.emotions[i].url + '"  style="cursor:pointer; position:relative;"   /></li>';
                }
                faceHtml += '</ul></div>';
                faceHtml += '</div><div class="arrow arrow_t"></div></div>';
                container.find('#face2').remove();
                container.append(faceHtml)

                container.find("#face_detail ul >li").bind("click", function(e) {
                    var txt = $(this).attr("text");
                    var faceText = txt;

                    options.txtAreaObj.val(options.txtAreaObj.val() + faceText);
					//Limit(oTextarea, 280, oH2);
                    container.find("#face2").remove();

                    var setFocusText = options.txtAreaObj;
                    var setFocusTextLeg = setFocusText.val().length;
                    setFocusText.focus();
                    // 默认使用focus方法聚焦
                    // 判断是否为Ie浏览器
                    if($.browser.msie) {
                        var txt = setFocusText[0].createTextRange();
                        // 将传入的控件对象转换为Dom对象，并创建一个TextRange对象
                        txt.moveStart('character', setFocusTextLeg);
                        // 设置光标显示的位置
                        txt.collapse(true);
                        txt.select();
                    }
                });
                //关闭表情框
                container.find(".f_close").bind("click", function() {
                    container.find("#face2").remove();
                });
                //处理js事件冒泡问题
                $('body').bind("click", function(e) {
                	e.stopPropagation();
                    container.find('#face2').remove();
                });
                container.find('#face2').bind("click",function(e){
                	e.stopPropagation();
                });

                var offset = $(e.target).offset();
                offset.top += options.top;
                offset.left += options.left;
                container.find("#face2").css(offset).show();
            });
        });
    },
    
    jqfaceedit3 : function(options) {
        var defaults = {
            txtAreaObj : '', //TextArea对象
            containerObj : '', //表情框父对象
            emotions : em,//表情信息json格式，id表情排序号 phrase表情使用的替代短语url表情文件名
            emotions2 : em2,//表情信息json格式，id表情排序号 phrase表情使用的替代短语url表情文件名
			imageurl: '/plugin/emotions/emotions/',
			imageurl2: '/plugin/emotions/baobao/',
            top : 0, //相对偏移
            left : 0 //相对偏移
        };
        var options = $.extend(defaults, options);
        return this.each(function() {
            var Obj = $(this);
            var container = options.containerObj;
            $(Obj).bind("click", function(e) {
            	jQuery("#imgLayer").hide();
                e.stopPropagation();
                var faceHtml = '';
                faceHtml += '<div id="face3">';
                faceHtml += '<div id="texttb">';
                faceHtml += '<ul class="texttbTab">';
                faceHtml += '<li class="selected" onclick="emChoose(this,1);">阳光宝宝</li>';
                faceHtml += '<li onclick="emChoose(this,2);">系统默认</li>';
                faceHtml += '</ul>';
                faceHtml += '<a class="f_close" title="关闭" href="javascript:void(0);"></a>';
                faceHtml += '</div>';
                faceHtml += '<div id="facebox">';
                faceHtml += '<div id="face_detail" class="facebox clearfix faceBaobao">';
                faceHtml += '<ul class="baobao">';
                for( i = 0; i < options.emotions2.length; i++) {
                    faceHtml += '<li text=' + options.emotions2[i].phrase + ' type=' + i + '><img title=' + options.emotions2[i].phrase + ' src="'+options.imageurl2 + options.emotions2[i].url + '" /></li>';
                }
                faceHtml += '</ul>';
                faceHtml += '</div>';
                faceHtml += '<div id="face_detail" class="facebox clearfix faceDetail displayem">';
                faceHtml += '<ul>';
                for( i = 0; i < options.emotions.length; i++) {
                    faceHtml += '<li text=' + options.emotions[i].phrase + ' type=' + i + '><img title=' + options.emotions[i].phrase + ' src="'+options.imageurl + options.emotions[i].url + '"  style="cursor:pointer; position:relative;"   /></li>';
                }
                faceHtml += '</ul></div>';
                faceHtml += '</div><div class="arrow arrow_t"></div></div>';
                container.find('#face3').remove();
                container.append(faceHtml)

                container.find("#face_detail ul >li").bind("click", function(e) {
                    var txt = $(this).attr("text");
                    var faceText = txt;

                    options.txtAreaObj.val(options.txtAreaObj.val() + faceText);
					Limit(oTextarea, 280, oH2);
                    container.find("#face3").remove();

                    var setFocusText = options.txtAreaObj;
                    var setFocusTextLeg = setFocusText.val().length;
                    setFocusText.focus();
                    // 默认使用focus方法聚焦
                    // 判断是否为Ie浏览器
                    if($.browser.msie) {
                        var txt = setFocusText[0].createTextRange();
                        // 将传入的控件对象转换为Dom对象，并创建一个TextRange对象
                        txt.moveStart('character', setFocusTextLeg);
                        // 设置光标显示的位置
                        txt.collapse(true);
                        txt.select();
                    }
                });
                //关闭表情框
                container.find(".f_close").bind("click", function() {
                    container.find("#face3").remove();
                });
                //处理js事件冒泡问题
                $('body').bind("click", function(e) {
                	e.stopPropagation();
                    container.find('#face3').remove();
                });
                container.find('#face3').bind("click",function(e){
                	e.stopPropagation();
                });

                var offset = $(e.target).offset();
                offset.top += options.top;
                offset.left += options.left;
                container.find("#face3").css(offset).show();
            });
        });
    },
    
    
    jqfaceedit4 : function(options) {
        var defaults = {
            txtAreaObj : '', //TextArea对象
            containerObj : '', //表情框父对象
            emotions : em,//表情信息json格式，id表情排序号 phrase表情使用的替代短语url表情文件名
            emotions2 : em2,//表情信息json格式，id表情排序号 phrase表情使用的替代短语url表情文件名
			imageurl: '/plugin/emotions/emotions/',
			imageurl2: '/plugin/emotions/baobao/',
            top : 0, //相对偏移
            left : 0 //相对偏移
        };
        var options = $.extend(defaults, options);
        return this.each(function() {
            var Obj = $(this);
            var container = options.containerObj;
            $(Obj).bind("click", function(e) {
            	jQuery("#imgLayer").hide();
                e.stopPropagation();
                var faceHtml = '';
                faceHtml += '<div id="face4">';
                faceHtml += '<div id="texttb">';
                faceHtml += '<ul class="texttbTab">';
                faceHtml += '<li class="selected" onclick="emChoose(this,1);">阳光宝宝</li>';
                faceHtml += '<li onclick="emChoose(this,2);">系统默认</li>';
                faceHtml += '</ul>';
                faceHtml += '<a class="f_close" title="关闭" href="javascript:void(0);"></a>';
                faceHtml += '</div>';
                faceHtml += '<div id="facebox">';
                faceHtml += '<div id="face_detail" class="facebox clearfix faceBaobao">';
                faceHtml += '<ul class="baobao">';
                for( i = 0; i < options.emotions2.length; i++) {
                    faceHtml += '<li text=' + options.emotions2[i].phrase + ' type=' + i + '><img title=' + options.emotions2[i].phrase + ' src="'+options.imageurl2 + options.emotions2[i].url + '" /></li>';
                }
                faceHtml += '</ul>';
                faceHtml += '</div>';
                faceHtml += '<div id="face_detail" class="facebox clearfix faceDetail displayem">';
                faceHtml += '<ul>';
                for( i = 0; i < options.emotions.length; i++) {
                    faceHtml += '<li text=' + options.emotions[i].phrase + ' type=' + i + '><img title=' + options.emotions[i].phrase + ' src="'+options.imageurl + options.emotions[i].url + '"  style="cursor:pointer; position:relative;"   /></li>';
                }
                faceHtml += '</ul></div>';
                faceHtml += '</div><div class="arrow arrow_t"></div></div>';
                container.find('#face4').remove();
                container.append(faceHtml)

                container.find("#face_detail ul >li").bind("click", function(e) {
                    var txt = $(this).attr("text");
                    var faceText = txt;

                    options.txtAreaObj.val(options.txtAreaObj.val() + faceText);
					//Limit(jQuery("#oplogContent"), 280, oH2);
                    container.find("#face4").remove();

                    var setFocusText = options.txtAreaObj;
                    var setFocusTextLeg = setFocusText.val().length;
                    setFocusText.focus();
                    // 默认使用focus方法聚焦
                    // 判断是否为Ie浏览器
                    if($.browser.msie) {
                        var txt = setFocusText[0].createTextRange();
                        // 将传入的控件对象转换为Dom对象，并创建一个TextRange对象
                        txt.moveStart('character', setFocusTextLeg);
                        // 设置光标显示的位置
                        txt.collapse(true);
                        txt.select();
                    }
                });
                //关闭表情框
                container.find(".f_close").bind("click", function() {
                    container.find("#face4").remove();
                });
                //处理js事件冒泡问题
                $('body').bind("click", function(e) {
                	e.stopPropagation();
                    container.find('#face4').remove();
                });
                container.find('#face4').bind("click",function(e){
                	e.stopPropagation();
                });

                var offset = $(e.target).offset();
                offset.top = options.top-310;
                offset.left += options.left;
                container.find("#face4").css(offset).show();
            });
        });
    },
    
    jqfaceedit5 : function(options) {
        var defaults = {
            txtAreaObj : '', //TextArea对象
            containerObj : '', //表情框父对象
            emotions : em,//表情信息json格式，id表情排序号 phrase表情使用的替代短语url表情文件名
            emotions2 : em2,//表情信息json格式，id表情排序号 phrase表情使用的替代短语url表情文件名
			imageurl: '/plugin/emotions/emotions/',
			imageurl2: '/plugin/emotions/baobao/',
            top : 0, //相对偏移
            left : 0 //相对偏移
        };
        var options = $.extend(defaults, options);
        return this.each(function() {
            var Obj = $(this);
            var container = options.containerObj;
            $(Obj).bind("click", function(e) {
            	jQuery("#imgLayer").hide();
                e.stopPropagation();
                var faceHtml = '';
                faceHtml += '<div id="face5">';
                faceHtml += '<div id="texttb">';
                faceHtml += '<ul class="texttbTab">';
                faceHtml += '<li class="selected" onclick="emChoose(this,1);">阳光宝宝</li>';
                faceHtml += '<li onclick="emChoose(this,2);">系统默认</li>';
                faceHtml += '</ul>';
                faceHtml += '<a class="f_close" title="关闭" href="javascript:void(0);"></a>';
                faceHtml += '</div>';
                faceHtml += '<div id="facebox">';
                faceHtml += '<div id="face_detail" class="facebox clearfix faceBaobao">';
                faceHtml += '<ul class="baobao">';
                for( i = 0; i < options.emotions2.length; i++) {
                    faceHtml += '<li text=' + options.emotions2[i].phrase + ' type=' + i + '><img title=' + options.emotions2[i].phrase + ' src="'+options.imageurl2 + options.emotions2[i].url + '" /></li>';
                }
                faceHtml += '</ul>';
                faceHtml += '</div>';
                faceHtml += '<div id="face_detail" class="facebox clearfix faceDetail displayem">';
                faceHtml += '<ul>';
                for( i = 0; i < options.emotions.length; i++) {
                    faceHtml += '<li text=' + options.emotions[i].phrase + ' type=' + i + '><img title=' + options.emotions[i].phrase + ' src="'+options.imageurl + options.emotions[i].url + '"  style="cursor:pointer; position:relative;"   /></li>';
                }
                faceHtml += '</ul></div>';
                faceHtml += '</div><div class="arrow arrow_t"></div></div>';
                container.find('#face5').remove();
                container.append(faceHtml)

                container.find("#face_detail ul >li").bind("click", function(e) {
                    var txt = $(this).attr("text");
                    var faceText = txt;

                    options.txtAreaObj.val(options.txtAreaObj.val() + faceText);
					Limit(oTextarea, 280, oH2);
                    container.find("#face5").remove();

                    var setFocusText = options.txtAreaObj;
                    var setFocusTextLeg = setFocusText.val().length;
                    setFocusText.focus();
                    // 默认使用focus方法聚焦
                    // 判断是否为Ie浏览器
                    if($.browser.msie) {
                        var txt = setFocusText[0].createTextRange();
                        // 将传入的控件对象转换为Dom对象，并创建一个TextRange对象
                        txt.moveStart('character', setFocusTextLeg);
                        // 设置光标显示的位置
                        txt.collapse(true);
                        txt.select();
                    }
                });
                //关闭表情框
                container.find(".f_close").bind("click", function() {
                    container.find("#face5").remove();
                });
                //处理js事件冒泡问题
                $('body').bind("click", function(e) {
                	e.stopPropagation();
                    container.find('#face5').remove();
                });
                container.find('#face5').bind("click",function(e){
                	e.stopPropagation();
                });

                var offset = $(e.target).offset();
                offset.top += options.top-303;
                offset.left += options.left;
                container.find("#face5").css(offset).show();
            });
        });
    },
    

    //表情文字符号转换为html格式
    emotionsToHtml : function(options) {
        return this.each(function() {
            var msgObj = $(this);
            var rContent = msgObj.html();			

            var regx=/\[h(\d{3})\]*?\]/g;//正则查找“[]”格式
            var regx2=/\[y(\d{3})\]*?\]/g;//正则查找“[]”格式
            var rs=rContent.match(regx);
            var rs2=rContent.match(regx2);
             
            for( i = 0; i < rs.length; i++) {
                for( n=0; n< em.length; n++ ){
                    if(em[n].phrase == rs[i]){
                        var t = "<img src='/plugin/emotions/emotions/"+em[n].url+"' />";
                        rContent = rContent.replace(rs[i],t);
                        break;
                    }
                }
            }
            for( i = 0; i < rs2.length; i++) {
            
                for( n=0; n< em2.length; n++ ){
                    if(em2[n].phrase == rs2[i]){ 
                        var t2 = "<img src='/plugin/emotions/baobao/"+em2[n].url+"' />";
                        rContent = rContent.replace(rs2[i],t2);
                        break;
                    }
                }
            }
            msgObj.html(rContent);
        });
    }
    })
})(jQuery);


    var em = [
              {'id':1,'phrase':'[h001]','url':'h001.png'},{'id':2,'phrase':'[h002]','url':'h002.png'},
              {'id':3,'phrase':'[h003]','url':'h003.png'},{'id':4,'phrase':'[h004]','url':'h004.png'},
              {'id':5,'phrase':'[h005]','url':'h005.png'},{'id':6,'phrase':'[h006]','url':'h006.png'},
              {'id':7,'phrase':'[h007]','url':'h007.png'},{'id':8,'phrase':'[h008]','url':'h008.png'},
              {'id':9,'phrase':'[h009]','url':'h009.png'},{'id':10,'phrase':'[h010]','url':'h010.png'},
              {'id':11,'phrase':'[h011]','url':'h011.png'},{'id':12,'phrase':'[h012]','url':'h012.png'},
              {'id':13,'phrase':'[h013]','url':'h013.png'},{'id':14,'phrase':'[h014]','url':'h014.png'},
              {'id':15,'phrase':'[h015]','url':'h015.png'},{'id':16,'phrase':'[h016]','url':'h016.png'},
              {'id':17,'phrase':'[h017]','url':'h017.png'},{'id':18,'phrase':'[h018]','url':'h018.png'},
              {'id':19,'phrase':'[h019]','url':'h019.png'},{'id':20,'phrase':'[h020]','url':'h020.png'},
              {'id':21,'phrase':'[h021]','url':'h021.png'},{'id':22,'phrase':'[h022]','url':'h022.png'},
              {'id':23,'phrase':'[h023]','url':'h023.png'},{'id':24,'phrase':'[h024]','url':'h024.png'},
              {'id':25,'phrase':'[h025]','url':'h025.png'},{'id':26,'phrase':'[h026]','url':'h026.png'},
              {'id':27,'phrase':'[h027]','url':'h027.png'},{'id':28,'phrase':'[h028]','url':'h028.png'},
              {'id':29,'phrase':'[h029]','url':'h029.png'},{'id':30,'phrase':'[h030]','url':'h030.png'},
              {'id':31,'phrase':'[h031]','url':'h031.png'},{'id':32,'phrase':'[h032]','url':'h032.png'},
              {'id':33,'phrase':'[h033]','url':'h033.png'},{'id':34,'phrase':'[h034]','url':'h034.png'},
              {'id':35,'phrase':'[h035]','url':'h035.png'},{'id':36,'phrase':'[h036]','url':'h036.png'},
              {'id':37,'phrase':'[h037]','url':'h037.png'},{'id':38,'phrase':'[h038]','url':'h038.png'},
              {'id':39,'phrase':'[h039]','url':'h039.png'},{'id':40,'phrase':'[h040]','url':'h040.png'},
              {'id':41,'phrase':'[h041]','url':'h041.png'},{'id':42,'phrase':'[h042]','url':'h042.png'},
              {'id':43,'phrase':'[h043]','url':'h043.png'},{'id':44,'phrase':'[h044]','url':'h044.png'},
              {'id':45,'phrase':'[h045]','url':'h045.png'},{'id':46,'phrase':'[h046]','url':'h046.png'},
              {'id':47,'phrase':'[h047]','url':'h047.png'},{'id':48,'phrase':'[h048]','url':'h048.png'},
              {'id':49,'phrase':'[h049]','url':'h049.png'},{'id':50,'phrase':'[h050]','url':'h050.png'},
              {'id':51,'phrase':'[h051]','url':'h051.png'},{'id':52,'phrase':'[h052]','url':'h052.png'},
              {'id':53,'phrase':'[h053]','url':'h053.png'},{'id':54,'phrase':'[h054]','url':'h054.png'},
              {'id':55,'phrase':'[h055]','url':'h055.png'},{'id':56,'phrase':'[h056]','url':'h056.png'},
              {'id':57,'phrase':'[h057]','url':'h057.png'},{'id':58,'phrase':'[h058]','url':'h058.png'},
              {'id':59,'phrase':'[h059]','url':'h059.png'},{'id':60,'phrase':'[h060]','url':'h060.png'},
              {'id':61,'phrase':'[h061]','url':'h061.png'},{'id':62,'phrase':'[h062]','url':'h062.png'},
              {'id':63,'phrase':'[h063]','url':'h063.png'},{'id':64,'phrase':'[h064]','url':'h064.png'},
              {'id':65,'phrase':'[h065]','url':'h065.png'},{'id':66,'phrase':'[h066]','url':'h066.png'},
              {'id':67,'phrase':'[h067]','url':'h067.png'},{'id':68,'phrase':'[h068]','url':'h068.png'},
              {'id':69,'phrase':'[h069]','url':'h069.png'},{'id':70,'phrase':'[h070]','url':'h070.png'},
              {'id':71,'phrase':'[h071]','url':'h071.png'},{'id':72,'phrase':'[h072]','url':'h072.png'},
              {'id':73,'phrase':'[h073]','url':'h073.png'},{'id':74,'phrase':'[h074]','url':'h074.png'},
              {'id':75,'phrase':'[h075]','url':'h075.png'},{'id':76,'phrase':'[h076]','url':'h076.png'},
              {'id':77,'phrase':'[h077]','url':'h077.png'},{'id':78,'phrase':'[h078]','url':'h078.png'},
              {'id':79,'phrase':'[h079]','url':'h079.png'},{'id':80,'phrase':'[h080]','url':'h080.png'},
              {'id':81,'phrase':'[h081]','url':'h081.png'},{'id':82,'phrase':'[h082]','url':'h082.png'},
              {'id':83,'phrase':'[h083]','url':'h083.png'},{'id':84,'phrase':'[h084]','url':'h084.png'},
              {'id':85,'phrase':'[h085]','url':'h085.png'},{'id':86,'phrase':'[h086]','url':'h086.png'},
              {'id':87,'phrase':'[h087]','url':'h087.png'},{'id':88,'phrase':'[h088]','url':'h088.png'},
              {'id':89,'phrase':'[h089]','url':'h089.png'},{'id':90,'phrase':'[h090]','url':'h090.png'}
          ];
		
		var em2 = [
              {'id':1,'phrase':'[y001]','url':'y001.png'},{'id':2,'phrase':'[y002]','url':'y002.png'},
              {'id':3,'phrase':'[y003]','url':'y003.png'},{'id':4,'phrase':'[y004]','url':'y004.png'},
              {'id':5,'phrase':'[y005]','url':'y005.png'},{'id':6,'phrase':'[y006]','url':'y006.png'},
              {'id':7,'phrase':'[y007]','url':'y007.png'},{'id':8,'phrase':'[y008]','url':'y008.png'},
              {'id':9,'phrase':'[y009]','url':'y009.png'},{'id':10,'phrase':'[y010]','url':'y010.png'},
              {'id':11,'phrase':'[y011]','url':'y011.png'},{'id':12,'phrase':'[y012]','url':'y012.png'},
              {'id':13,'phrase':'[y013]','url':'y013.png'},{'id':14,'phrase':'[y014]','url':'y014.png'},
              {'id':15,'phrase':'[y015]','url':'y015.png'}
          ];

//表情替换
function changFace(txt){
	var rContent = txt;			
	var regx=/\[h(\d{3})\]*?\]/g			//正则查找"[]"格式，数字格式时
	var regx2=/\[y(\d{3})\]*?\]/g;			//正则查找"[]"格式，数字格式时
	var rs=rContent.match(regx);
	var rs2=rContent.match(regx2);
	if(rs!=null&&rs2==null){
		rContent=changDetaultFace(rContent);
	}else if(rs==null&&rs2!=null){
		rContent=changBaoBaoFace(rContent);
	}else if(rs!=null&&rs2!=null){
		rContent=changBaoBaoFace(rContent);
		rContent=changDetaultFace(rContent);
	}
	return rContent;
}


//表情替换
function changMinFace(txt){
	var rContent = txt;			
	var regx=/\[h(\d{3})\]*?\]/g			//正则查找"[]"格式，数字格式时
	var regx2=/\[y(\d{3})\]*?\]/g;			//正则查找"[]"格式，数字格式时
	var rs=rContent.match(regx);
	var rs2=rContent.match(regx2);
	if(rs!=null&&rs2==null){
		rContent=changDetaultFace(rContent);
	}else if(rs==null&&rs2!=null){
		rContent=changMinBaoBaoFace(rContent);
	}else if(rs!=null&&rs2!=null){
		rContent=changMinBaoBaoFace(rContent);
		rContent=changDetaultFace(rContent);
	}
	return rContent;
}

//系统表情
function changDetaultFace(txt){
	var rContent = txt;			
	var regx=/\[h(\d{3})\]*?\]/g			//正则查找"[]"格式，数字格式时
	//var regx=/\[[*\u4e00-\u9fa5]*?\]/g;	//正则查找"[]"格式,中文格式时
	var rs=rContent.match(regx);
	for( i = 0; rs!=null && i < rs.length; i++) {
		for( n=0; n< em.length; n++ ){
			if(em[n].phrase == rs[i]){
				var t = "<img class='emImg' src='/plugin/emotions/emotions/"+em[n].url+"' style=\"width:30px;height:30px;border:0px;\"/>";
				rContent = rContent.replace(rs[i],t);
				break;
			}
		}
	}
	return rContent;
}
//宝宝表情
function changBaoBaoFace(txt){
	var rContent = txt;
	var regx=/\[y(\d{3})\]*?\]/g;			//正则查找"[]"格式，数字格式时
	var rs=rContent.match(regx);
	for( i = 0; rs!=null && i < rs.length; i++) {
		for( n=0; n< em2.length; n++ ){
			if(em2[n].phrase == rs[i]){
				var t = "<img class='emImg' src='/plugin/emotions/baobao/"+em2[n].url+"' style=\"width:75px;height:85px;border:0px;\"/>";
				rContent = rContent.replace(rs[i],t);
				break;
			}
		}
	}
	return rContent;
}

//宝宝表情小图26*24
function changMinBaoBaoFace(txt){
	var rContent = txt;
	var regx=/\[y(\d{3})\]*?\]/g;			//正则查找"[]"格式，数字格式时
	var rs=rContent.match(regx);
	for( i = 0; rs!=null && i < rs.length; i++) {
		for( n=0; n< em2.length; n++ ){
			if(em2[n].phrase == rs[i]){
				var t = "<img class='emImg' src='/plugin/emotions/baobao/"+em2[n].url+"' style=\"width:24px;height:26px;border:0px;\"/>";
				rContent = rContent.replace(rs[i],t);
				break;
			}
		}
	}
	return rContent;
}

//表情切换栏
function emChoose(obj,id){
	jQuery(".texttbTab li").removeClass("selected");
	jQuery(obj).addClass("selected") ;
	if(id==1){
		jQuery(".faceBaobao").removeClass("displayem");
		jQuery(".faceDetail").addClass("displayem");
	}else if(id==2){
		jQuery(".faceDetail").removeClass("displayem");
		jQuery(".faceBaobao").addClass("displayem");
	}
}