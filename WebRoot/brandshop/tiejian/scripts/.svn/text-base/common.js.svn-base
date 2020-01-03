(function(c) {
    var d = c.jQuery;  // d -- jQuery
    if (typeof  b == "undefined" || !b) {
        var b = {
		    wordLimit: function(num,obj){	// DK.wordLimit(3,jQuery(".show")) ; js 截取一定长度的字符串
				obj.each(function(){	
					if(!num){
						var copyThis = $(this.cloneNode(true)).hide().css({
							'position': 'absolute',
							'width': 'auto',
							'overflow': 'visible'
						});	
						$(this).after(copyThis);
						if(copyThis.width()>$(this).width()){
							$(this).text($(this).text().substring(0,$(this).text().length-4));
							$(this).html($(this).html()+'...');
							copyThis.remove();
							$(this).wordLimit();
						}else{
							copyThis.remove(); //清除复制
							return;
						}	
					}else{
						var maxwidth=num;
						if($(this).text().length>maxwidth){
							$(this).text($(this).text().substring(0,maxwidth));
							$(this).html($(this).html()+'...');
						}
					}					 
				});
			},
            getRandom: function(j, h) {  // 产生 长度为 h ,最大为 j 的数组  j>=h
                var f = [],
                g,
                e = function(k, i) {
                    var l = b.getRandom(k);
					 // jQuery.inArray( value, array ) 搜索数组中指定值并返回它的索引（如果没有找到则返回-1）。
					 // value要搜索的值。
					// array一个数组，通过它来搜索。				
                    return (d.inArray(l, i) < 0) ? l: e(k, i)  ;  
                };
                if (h) {
                    for (g = 0; g < h; g++) {
                        f[g] = e(j, f)
                    }					
                    return f ;
                } else {				
                    return Math.floor(Math.random() * j)
                }
            },
            _debug: c.location.search.indexOf("debug=true") != -1 || false,
            trim: function(f) {
                var e = new RegExp("(^[\\s\\t\\xa0\\u3000]+)|([\\u3000\\xa0\\s\\t]+\x24)", "g");
                return String(f).replace(e, "")
            },
            truncate: function(g, f, e) {  // 截取字符串
                if (!e) {
                    e = "..." ;
                }
                if (g.length > f) {
                    return g.substring(0, f) + e ;
                }
                return g ;
            },
            quote: function(e) {
                return '"' + e + '"'
            },
            ajax: function(g, e, f, i) {
                function h(k, l) {
                    return k + (k.indexOf("?") === -1 ? "?": "&") + l
                }
                if (g == "GET") {
                    var e = i ? h(e, i) : e
                }
                var j = c.ActiveXObject ? new c.ActiveXObject("Microsoft.XMLHTTP") : new c.XMLHttpRequest();
                j.open(g, e, true);
                i ? j.setRequestHeader("Content-type", "application/x-www-form-urlencoded") : "";
                j.send(g === "POST" ? i: null);
                j.onreadystatechange = function() {
                    if (j.readyState == 4) {
                        if (j.status == 200) {
                            f(j.responseText)
                        }
                    }
                    return j
                }
            },
            isOldIE: !+"\v1",
            log: function(e) {
                if (b._debug) {
                    console ? console.log(e) : alert(e)
                }
            },
            merge: function(f, e) {
                var g;				
                for (g in e) {			
                    f[g] = e[g]
                }
                return f
            },
            load: function(f, h) {   // 可以做到延时加载 js ?
                var g = document.getElementsByTagName("head")[0],
                e = function(j, k) {
                    b.load._map = b.load._map || {};
                    if ( !! b.load._map[j]) {
                        if (k) {
                            setTimeout(k, 500) ;
                        }
                        return ;
                    }
                    var i = document.createElement("script") ;
                    i.async = true ;
                    i.src = j ;
                    g.insertBefore(i, g.firstChild);  // insertBefore() 方法：可在已有的子节点前插入一个新的子节点。语法 ：insertBefore(newchild,refchild)
                    i.onloadDone = false;
                    i.onload = function() {
                        i.onloadDone = true;
                        b.load._map[j] = 1;
                        if (k) {     // 延时执行
                            setTimeout(k, 500)
                        }
                    };
                    if (b.isOldIE) {
                        i.onreadystatechange = function() {
                            if (("loaded" === i.readyState || "complete" === i.readyState) && !i.onloadDone) {
                                i.onloadDone = true;
                                b.load._map[j] = 1;
                                if (k) {
                                    setTimeout(k, 500)
                                }
                            }
                        }
                    }
                };
                e(f, h)
            },
            add: function(i, k, l) {
                if (b[i]) {
                    a("DK." + i + " 已被破处, 换个名字吧");
                    return
                }
                var g = i.split(","),
                h = g.length;
                for (p in g) {
                    var f = b.trim(g[p]);
                    try {
                        b[f] = (h == 1) ? k: null
                    } catch(j) {}
                }
                if (k && typeof(k) == "function") {
                    try {
                        l ? setTimeout(k, 0) : ""
                    } catch(j) {}
                }
            },
            get: function(e, g, i, f) {
                var h;
                if (jQuery.isFunction(g)) {
                    f = f || i;
                    i = g;
                    g = h
                }
                jQuery.get(e, g, 
                function(l) {
                    var k = this,
                    j = jQuery.parseJSON(l);
                    if (j.status.code != 0) {
                        return
                    }
                    if (i) {
                        i.call(k, l)
                    }
                },
                f)
            },
            post: function(f, h, j, g) {
                var i;
                function e(k) {
                    var l = document.cookie.match("\\b" + k + "=([^;]*)\\b");
                    return l ? l[1] : i
                }
                if (jQuery.isFunction(h)) {
                    g = g || j;
                    j = h;
                    h = i
                }
                if (h && !h._xsrf) {
                    h._xsrf = b._xsrf = b._xsrf || e("_xsrf") || i
                }
                jQuery.post(f, h, 
                function(m) {
                    var l = this,
                    k = jQuery.parseJSON(m);
                    if (k.status.code != 0) {
                        return
                    }
                    if (j) {
                        j.call(l, m)
                    }
                },
                g)
            }
        }
    }
    c.DK = b;
    var a = b.log
})(window, document);

jQuery.cookie = function(b, j, m) {
    if (typeof j != "undefined") {
        m = m || {};
        if (j === null) {
            j = "";
            m.expires = -1
        }
        var e = "";
        if (m.expires && (typeof m.expires == "number" || m.expires.toUTCString)) {
            var f;
            if (typeof m.expires == "number") {
                f = new Date();
                f.setTime(f.getTime() + (m.expires * 24 * 60 * 60 * 1000))
            } else {
                f = m.expires
            }
            e = "; expires=" + f.toUTCString()
        }
        var l = m.path ? "; path=" + (m.path) : "";
        var g = m.domain ? "; domain=" + (m.domain) : "";
        var a = m.secure ? "; secure": "";
        document.cookie = [b, "=", encodeURIComponent(j), e, l, g, a].join("")
    } else {
        var d = null;
        if (document.cookie && document.cookie != "") {
            var k = document.cookie.split(";");
            for (var h = 0; h < k.length; h++) {
                var c = jQuery.trim(k[h]);
                if (c.substring(0, b.length + 1) == (b + "=")) {
                    d = decodeURIComponent(c.substring(b.length + 1));
                    break
                }
            }
        }
        return d
    }
};
DK.add("tips", {
    defconf: {
        key: "",
        holder: null,
        trigger: null,
        callback: function() {},
        expires: 999
    },
    _init: function(e) {
        var g = "true",
        a = "false";
        var h = this,
        l = $.extend({},
        h.defconf, e),
        c = $(l.trigger),
        i = $(l.holder),
        k = l.key,
        b = l.expires,
        f;
        if (!k || !i || !c) {
            return
        }
        function d() {
            i.addClass("hide")
        }
        function j() {
            i.removeClass("hide")
        }
        f = jQuery.cookie(k) || a;
        if (g == f) {
            d();
            return
        }
        j();
        c.click(function() {
            $.cookie(k, g, b);
            d();
            l.callback.call(h);
            return false
        })
    },
    init: function(a) {
        var b = this;
        if ($.isArray(a)) {
            $.each(a, 
            function(c, d) {
                b._init(d)
            })
        } else {
            b._init(a)
        }
    }
});
DK.add("chapterselector", {
    defconf: {
        trigger: null
    },
    _renderResult: function(c) {
        var e = this,
        b = $.parseJSON(c),
        f = (b && b.result && b.result.list) ? b.result.list: [],
        g = b.result.needjump;
        e._is_loading = false;
        e.body.html('<p class="chapter-selector-title">请选择来源网站:</p><p><select class="chapter-selector-select"></select><a href="#" class="blue-button J_jump-to-third">确定</a></p>');
        var a = $("select", e.body),
        d = $(".J_jump-to-third", e.body);
        dataConf = {
            type: "link_report",
            report_type: "dead",
            link_type: "chapter"
        };
        dataConf.bookid = e._trigger.attr("data-bookid");
        a[0].options.length = 0;
        $.each(f, 
        function(h, j) {
            $("<option></option>").attr({
                "data-linkid": j.id,
                "data-url": j.url
            }).text(j.project_name).val(j.id).appendTo(a)
        });
        if (g) {
            e.body.html('<p class="chapter-selector-title">PC暂不提供在线阅读</p><p>请用手机访问m.shupeng.com</p>')
        }
        d.click(function() {
            var h = $(a[0].options[a[0].selectedIndex]).attr("data-url");
            if ( !! dataConf.bookid) {
                DK.get("/ajax?_s" + Math.random(), {
                    type: "bookrack",
                    action: "add",
                    id: dataConf.bookid
                },
                function() {})
            }
            window.open(h, "_blank");
            return false
        });
        return e
    },
    loading: function() {
        var a = this;
        a._is_loading = true;
        a.body.html('<div class="loading" title="加载中……"></div>');
        a.show();
        return a
    },
    hide: function() {
        this.holder.addClass("hide");
        return this
    },
    show: function() {
        this.holder.removeClass("hide");
        return this
    },
    createNode: function() {
        var b = this,
        a;
        if ( !! b.holder && !!b.body) {
            return b
        }
        a = $("#J_dk-chapter-selector")[0] ? $("#J_dk-chapter-selector") : $('<div id="J_dk-chapter-selector" class="chapter-selector-wrap hide"><div class="chapter-selector"></div><div class="arrow"><div class="out"></div><div class="in"></div></div><a class="close" href="#!close" title="关闭"></a></div>').appendTo(document.body);
        b.holder = a;
        b.body = a.find(".chapter-selector");
        a.find(".close").click(function() {
            b.hide();
            return false
        });
        return b
    },
    _initDialog: function() {
        var a = this;
        a.createNode().loading().updatePosition()
    },
    getChapter: function() {
        var a = this,
        b = {
            type: "getchapter"
        };
        b.id = a._trigger.attr("data-chapterid");
        DK.get("/ajax", b, 
        function(c) {
            a._renderResult(c)
        })
    },
    updatePosition: function() {
        var b = this;
        if (!b._trigger) {
            return b
        }
        var c = $(b._trigger).offset(),
        a = $(b._trigger).height();
        c.top += a + 4;
        b.holder.css({
            left: c.left,
            top: c.top
        });
        return b
    },
    bindEvent: function() {
        var d = this,
        b = d.options,
        a = $(b.trigger);
        function c() {
            d.updatePosition()
        }
        a.click(function() {
            d._trigger = $(this);
            d._initDialog();
            d.getChapter();
            return false
        });
        return d
    },
    init: function(a) {
        var b = this;
        b.options = $.extend({},
        b.defconf, a);
        b.bindEvent()
    }
});