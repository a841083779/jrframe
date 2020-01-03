
(function(){
    var thisWin = window, 
    thisDoc = document, 
	thisReferrer = thisDoc.referrer,   // Referrer是不允许修改的，所以没必要动态获取
    thisDocEl = thisDoc.documentElement, 
    thisLoc = location, 
	thisUA = navigator.userAgent.toLowerCase();
    if (thisWin.jereiReceiver) {
        return;
    }
var utility =  {
    errorUrls: ["receiver-error.jerei.com/a.gif"],
    funcList: [],
	handlers : [],
	voidFunc: function(o){
		return o;
	},
	lower:function(str){
		return (str && str.toLowerCase) ? str.toLowerCase() : str;
	},
	indexOf:function(source, searchValue, fromIndex){
		if (source) {
			if (source.indexOf) {
				return source.indexOf(searchValue, fromIndex);
			} else if (source.length) {
				for (var i = fromIndex || 0, len = source.length; i < len; i++) {
					if (source[i] === searchValue) {
						return i;
					}
				}
			}
		}
		return -1;
	},
	getHashCode:function(str,caseSensitive){
		var hash = 1315423911, i, ch;
		if (!caseSensitive) {
			str = lower(str);
		}        
		for (i = str.length - 1; i >= 0; i--) {
			ch = str.charCodeAt(i);
			hash ^= ((hash << 5) + ch + (hash >> 2));
		}
		return (hash & 0x7FFFFFFF);
	},
	getRandomString:function(randLength){
		var i,randomString=[],randMatrix = "abcdefghijklmnopqrstuvwxyz0123456789",max = 35;        
		for(i = 0; i < randLength; i++){
			randomString.push(randMatrix.charAt(Math.round(Math.random() * max)));
		}        
		return randomString.join("");
	},    
	getRandomID:function(){
		var date = new Date().getTime()+'';
		var hash = "" + Math.abs(utility.getHashCode(thisLoc.href + thisReferrer + thisUA));
		var len = hash.length > 2 ? 2 : hash.length;
		hash = hash.substring(0,len);
		return date.substring(2,date.length - 3) + utility.getRandomString(6) + hash;
	},
	getUrlParam: function(url, key, caseSensitive, autoDecode){
		if(!key){
			return null;
		}
		url = (url || (thisLoc.pathname + thisLoc.search)).replace(/\#.*/ig, '');
		var prefixList = ['&', '?'];
		for(var i = 0; i < 3; i++){
			var value = utility.find(url,prefixList[i] + key + "=", "&",caseSensitive);
			if(value != null){
				return autoDecode ? decode(value) : value;
			}
		}
		return null;
	},
	find: function(str, prefix, suffix, caseSensitive, noTrim){
		var results = utility.findArray(str,prefix, suffix, caseSensitive, noTrim), len = results.length;
		return len > 0 ? results[len - 1] : null;
	},
	findArray: function(str, prefix, suffix, caseSensitive, noTrim){
		if(!str || !str.length){
			return [];
		}
		var results = [], left, right, middle, search, value, begin = 0;
		prefix = prefix || "";
		if (!caseSensitive) {
			search = lower(str);
			prefix = lower(prefix);
			suffix = lower(suffix);
		}
		while (begin > -1) {
			value = null;
			if ((left = indexOf(search, prefix, begin)) > -1) {
				middle = left + prefix.length;
				if (!suffix) {
					value = str.substring(middle);
					begin = - 1;
				} else {
					right = indexOf(search, suffix, middle);					
					if(right >= middle){
						value = str.substring(middle, right);
						begin = right + suffix.length;
					}else{
						value = str.substring(middle);
						begin = - 1;
					}
				}
			}
			if (!value) {
				break;
			}
			results.push(!noTrim ? utility.trim(value) : value);
		}
		return results;
	},
	getTimeZone:function(){
		return Math.round(new Date().getTimezoneOffset() / -60)+'';
	},    
	getLocalTime:function(){
		return new Date().getTime() + utility.getTimeZone() * 3600000;
	},
	isPageMatch: function(target, type, page){
		page = lower(page || thisLoc.pathname);
		type = lower(type);
		if (!isArray(target)) {
			target = [target];
		}
		for (var i = 0, len = target.length; i < len; i++) {
			var t = lower(target[i]);
			if ((type == 'contains' && indexOf(page, t) > -1) ||
			(type == 'startswith' && indexOf(page, t) == 0) ||
			(type == 'endswith' && indexOf(page, t, page.length - t.length) > -1) ||
			(type == 'exactmatch' && page == t) ||
			(type == 'regex' && t.test && t.test(page))) {
				return true;
			}
		}
		return false;
	},
	getCookie:function(key,defValue, noDecode){
		if(!key){
			return null;
		}
		var p, cookies = utility.toDict(thisDoc.cookie, "=",";",true);
		key = lower(key);
		for(p in cookies){
			if(isProperty(cookies, p) && lower(p) === key){
				return noDecode ? cookies[p] : decode(cookies[p]);
			}
		}        
		return defValue || null;
	},
	setCookie: function(key, value, expires, path,domain,secure, noEncode){
		if(!key){
			return;
		}
		key = lower(key);
		if(!noEncode){
			value = encode(value);
		}
		key = key + '=' + value + ";";
		expires = expires ? ("expires=" + utility.getExpireDate(expires).toGMTString()) + ";" : "";
		path = !!path ? "path=" + path + ";" : "path=/;";
		domain = domain ? ("domain=" + domain) + ";" : "";
		secure = secure ? "secure=true;" : "";
		thisDoc.cookie =[key,expires,path,domain,secure].join("");
	},
	delCookie: function(key,path,domain){
		utility.setCookie(key,"",-1000,path,domain);    
	},
	getExpireDate:function(seconds){
		return new Date(new Date().getTime() + seconds * 1000);
	},
	trim: function(str){
		return (str && str.replace) ? str.replace(/(^\s+)|(\s+$)/ig, '') : str;
	},
	toDict:function(str,assignment,delim,trimBoth){        
		var i,before,params,len,trimFunc,retnObj = {};
		assignment = assignment || "=";// 默认以=作键值对分隔符
		delim = delim || '&';  // 默认以&作为每组键值对的分隔符
		params = str.split(delim);
		trimFunc = trimBoth ? utility.trim : utility.voidFunc;
		for (i = 0, len = params.length; i < len; i++) {
			before = indexOf(params[i], assignment);
			if (before > -1) {
				retnObj[trimFunc(params[i].substring(0, before))] = trimFunc(params[i].substring(before+1));
			} else {
				retnObj[params[i]] = null;
			}
		}
		return retnObj;
	},
	resolveUrl: function (url) {
	    url = utility.trim(url);
		var match,re = /((\w+:)?\/\/([^\/\#&?]*))?\/?([^?#&]*)?(\?[^#]*)?(#.*)?/,retn = {'url':url},protocol;
		if ((match = url.match(re))) {
			protocol = match[2] || thisLoc.protocol;
			retn.protocol = protocol.substring(0, protocol.length - 1);
			retn.local = retn.protocol == "file";
			retn.host = match[3] || thisLoc.host;
			retn.path = '/' + (match[4] || "");
			retn.fullPath = retn.path;
			retn.query = (match[5] || '').substring(1);
			retn.anchor = (match[6] || '').substring(1);
			if (retn.query) {
				retn.fullPath += "?" + retn.query;
				retn.params = utility.toDict(retn.query.replace(/\?/g, "&"));
			}
		}
		else {
			retn.local = true;
			retn.protocol = "file";
			retn.fullPath = retn.path = "/" + url.replace(/\\/g, "/");
		}
		return retn;
	},
	encode:function(str){
		if(!str || !str.replace){
			return str;
		}
		return (thisWin.encodeURIComponent || escape)(str);
	},
	decode: function(str){
		if (str && str.replace) {
			str = str.replace(/\+/ig, "%20");
			try {
				return (thisWin.decodeURIComponent || unescape)(str);
			} 
			catch (e) {
			}
		}
		return str;
	},
	serialize: function (obj, assignment, delim, noValueCheck, noEncode) {
	    function customSerializeAndEncode(obj1) {
	        if (!obj1) return '';
	        var buf1 = [], prop1;
	        for (prop1 in obj1) {
	            if (isProperty(obj1, prop1) && (obj1[prop1] || obj1[prop1] === 0)) {
	                buf1.push(prop1 + ":" + encode(obj1[prop1]));
	            }
	        }
	        return buf1.join(";");
	    }
	    var buf = [], encodeFunc = !noEncode ? encode : utility.voidFunc, prop,
		priorityList = ["ubc", "gstl", "gsflver", "gsalexaver", "gsdotnetver", "gssil", "gsclr", "gsscr", "gsbrlang",  
	        "gsmcurl", "lt", "lk",
            "gsclkpa","gsclktl"
		];
		assignment = assignment || "=";
	    delim = delim || "&";
	    for (prop in obj) {
	        var p = true;
	        for (var m in priorityList)
	            if (priorityList[m] == prop) p = false;
	        if (p && isProperty(obj, prop) && (noValueCheck || obj[prop] || obj[prop] === 0)) {
	            buf.push(prop + assignment + (prop == "pcp" || prop == "ecp" ? customSerializeAndEncode(obj[prop]) : encodeFunc(obj[prop])));
	        }
	    }
	    for (prop = 0; prop < priorityList.length; prop++) {
	        if (isProperty(obj, priorityList[prop]) && (noValueCheck || obj[priorityList[prop]] || obj[priorityList[prop]] === 0)) {
	            buf.push(priorityList[prop] + assignment + encodeFunc(obj[priorityList[prop]]));
	        }
	    }
	    return buf.join(delim);
	},
	getEl:function(el){
		return el.split ? thisDoc.getElementById(el) : el;
	},
    waitFor: function(id, callback, checkInterval, retryCount, failCallback){
		checkInterval = checkInterval || 1000;
		retryCount = retryCount || 30;
		var timer = setInterval(function(){
			if (id.split) {
				var el, parts = id.split('.', 3), len = parts.length, target = thisWin;
				if (len > 1) {
					for (var i = 0; i < len; i++) {
						if (!i || parts[i] != 'window') {
							target = target[parts[i]];
							if (!target) {
								break;
							}
						}
					}
					el = target;
				}
			}
			if (el || (el = utility.getEl(id))) {
				clearInterval(timer);
				callback(el);
			} else {
				if (retryCount > 0) {
					retryCount -= 1;
				} else {
					clearInterval(timer);
					if(failCallback){
						failCallback(el);
					}
				}
			}
		}, checkInterval);
	},
	getPos: function(el){
		var scrollTop,scrollLeft,box,
		parent = null, 
		pos = [],
		body = thisDoc.body,
		point = {};
		if (el.parentNode === null || el.style.display == 'none') {
			return false;
		}
		if (el.getBoundingClientRect) { 
			box = el.getBoundingClientRect();
			scrollTop = Math.max(thisDocEl.scrollTop, body.scrollTop);
			scrollLeft = Math.max(thisDocEl.scrollLeft, body.scrollLeft);
			if (thisDoc.compatMode == 'BackCompat' && isIE) {
				point = {
					x: box.left,
					y: box.top
				};
			}
			else {
				point = {
					x: box.left + scrollLeft,
					y: box.top + scrollTop
				};
			}
			return point;
		} else if (thisDoc.getBoxObjectFor){
			box = thisDoc.getBoxObjectFor(el);
			var borderLeft = (el.style.borderLeftWidth) ? parseInt(el.style.borderLeftWidth, 10) : 0;
			var borderTop = (el.style.borderTopWidth) ? parseInt(el.style.borderTopWidth, 10) : 0;
			pos = [box.x - borderLeft, box.y - borderTop];
		} else{
			pos = [el.offsetLeft, el.offsetTop];
			parent = el.offsetParent;
			if (parent != el) {
				while (parent) {
					pos[0] += parent.offsetLeft;
					pos[1] += parent.offsetTop;
					parent = parent.offsetParent;
				}
			}
			if (indexOf(thisUA, 'opera') != -1 ||
			(indexOf(thisUA, 'safari') != -1 && el.style.position == 'absolute')) {
				pos[0] -= body.offsetLeft;
				pos[1] -= body.offsetTop;
			}
		}
		if (el.parentNode) {
			parent = el.parentNode;
		} else {
			parent = null;
		}
		while (parent && parent.tagName != 'BODY' && parent.tagName != 'HTML') { 
			pos[0] -= parent.scrollLeft;
			pos[1] -= parent.scrollTop;
			if (parent.parentNode) {
				parent = parent.parentNode;
			} else {
				parent = null;
			}
		}
		point = {
			x: pos[0],
			y: pos[1]
		};
		return point;
	},
	getDocWidth:function(){
		return (thisDocEl && thisDocEl.scrollWidth) ||
		(thisDoc.body && thisDoc.body.scrollWidth) ||
		0;
	},     
	getPointer:function(e){
		var body = thisDoc.body || {scrollLeft: 0,scrollTop: 0};
		return {
			x: e.pageX || (e.clientX + (thisDocEl.scrollLeft || body.scrollLeft) - (thisDocEl.clientLeft || 0)),
			y: e.pageY || (e.clientY + (thisDocEl.scrollTop || body.scrollTop) - (thisDocEl.clientTop || 0))
		};
	},
	observe:function(element, eventName, callback){
		element = utility.getEl(element);
		if(!element){
			return null;
		} 
		function wrapper(e){
			if (!e.target) {
				e.target = e.srcElement || element;
			}
			if (!e.pageX) {
				var point = utility.getPointer(e);
				e.pageX = point.x;
				e.pageY = point.y;
			}
			e.root = element;
			callback.call(element, e);
		}
		if (element.addEventListener) {
			element.addEventListener(eventName, wrapper, false);
		} else {
			element.attachEvent("on" + eventName, wrapper);
		}
		return element;
	},
	observeTouch: function (element, callback) {
	    var mx, my;
        element = utility.getEl(element);
        if (!element) {
            return null;
        }
        function wrapper(e) {
            mx = e.pageX;
            my = e.pageY;
        }
        function wrapper2(e) {
            if (!e.target) {
                e.target = e.srcElement || element;
            }
            try {
                if (e.changedTouches[0].pageX != mx || e.changedTouches[0].pageY != my) {
                    mx = null;
                    my = null;
                    return;
                }
            } catch(ex) {
                utility.report(config.serviceID, "M_utility_observeTouch", ex);
                mx = null;
                my = null;
                return;
            }
            utility.touchPoint = { X: mx, Y: my };
            mx = null;
            my = null;
            e.root = element;
            callback.call(element, e);
        }
        if (element.addEventListener) {
            element.addEventListener("touchstart", wrapper, false);
            element.addEventListener("touchend", wrapper2, false);
        } else {
            element.attachEvent("ontouchstart", wrapper);
            element.attachEvent("ontouchend", wrapper2);
        }
	    return element;
	},
	format: function(formatString){
		if (arguments.length == 1) {
			return formatString;
		}else {
			var argNum = arguments.length;
			for (var i = 1; i < argNum; i++) {
				formatString = formatString.replace(new RegExp("\\{" + (i-1) + "\\}","g"), arguments[i]);
			}
			return formatString;
		}
	},
	getInnerText:function(el){
		el = utility.getEl(el);
		if(el && el.innerHTML){
		    return utility.trim(el.innerHTML.replace(/<[^>]+>/ig, ''));
		}
		return null;
	},
	getInnerUnvisibleText: function (el, attr) {
	    el = utility.getEl(el);
	    var ans = "";
	    if (el && el.innerHTML) {
	        var str = el.innerHTML, ind = str.indexOf(attr + '="');
	        while (ind != -1) {
	            ind += attr.length + 2;
	            var end = str.indexOf('"', ind);
	            ans += str.substr(ind, end - ind);
	            str = str.substr(end);
	            ind = str.indexOf(attr + '="');
	        }
	    }
	    return ans;
	},
	searchUp: function(root, event, tagName, properties, depth){
		var p, mismatch, lowerCaseTagName = lower(tagName), parentOfRoot = root && root.parentNode, va;
		var eventTarget=event.target;
		do {
			mismatch = true;
			if ( !lowerCaseTagName || lower( eventTarget.tagName ) == lowerCaseTagName ) {
				mismatch = false;
				for (p in properties) {
				    if ( isProperty( properties, p ) && indexOf( lower( eventTarget[p] || eventTarget.getAttribute( p ) ), lower( properties[p] ) ) < 0 ) {
						mismatch = true;
						break;
					}
				}
			}
			if (mismatch) {
			    eventTarget = eventTarget.parentNode;
			} else {
			    return eventTarget;
			}
			if(depth == 0){
				break;
			}
            depth--;
		} while ( eventTarget && eventTarget != parentOfRoot && eventTarget.getAttribute );
		return null;
	},
	report: function (profile, errorCode, errObj, account) {
		try {
		    errObj = errObj || {};
		    for (var ui = 0; ui < utility.errorUrls.length; ui++) {
		        var url = utility.errorUrls[ui] + "?gscmd=err&gsrd={0}&gsver={1}&gserrc={2}&gssrvid={3}&gserrobj={4}", ver = jereiReceiver.version, img = new Image(1, 1), rand = Math.round(Math.random() * 2147483647);
		        url = (location.protocol == "https:" ? 'https://' : 'http://') + url;
		        url = utility.format(url, rand, ver, errorCode, profile, utility.serialize(errObj, "~", "'"));
		        img.onload = function () {
		            return true;
		        };
		        img.onerror = function () {
		            return true;
		        };
		        img.src = url;
		    }
		}catch(e){}
	}
};
var lower = utility.lower, indexOf = utility.indexOf, encode = utility.encode, decode = utility.decode, slice = Array.prototype.slice;
function isArray(obj){
	return !!(obj && obj.constructor == Array);
}
function isProperty(obj, prop){
	return (obj && obj.hasOwnProperty) ? obj.hasOwnProperty(prop) : false;
}
function isString(s){
	return typeof s == 'string';
}
function UrlEvaluator(host, reqParams, optParams){
    var that = this;
    that.host = host;
    that.reqParams = reqParams || [];
    that.optParams = optParams || [];
}
UrlEvaluator.prototype = {
    testHost:function(host){
        var pattern = this.host;
        if(isString(pattern)){
            return indexOf(host, pattern) > -1;
        }else{
            return pattern.test && pattern.test(host);
        }
    },
    match: function(url){
        var i, len, value, queryObj, paramCount = 0, that = this, urlObj = utility.resolveUrl(url), params = {}, reqParams = that.reqParams, optParams = that.optParams, host = urlObj.host;
        if (that.testHost(host)) {
            if ((queryObj = urlObj.params)) {
                for (i in queryObj) {
                    if (isProperty(queryObj, i)) {
                        queryObj[lower(i)] = queryObj[i];
                    }
                }
                for (i = 0, len = reqParams.length; i < len; i++) {
                    value = queryObj[reqParams[i]];
                    if (!value) {
                        return false;
                    } else {
                        params[reqParams[i]] = value;
                        paramCount++;
                    }
                }
                for (i = 0, len = optParams.length; i < len; i++) {
                    value = queryObj[optParams[i]];
                    if (value) {
                        params[optParams[i]] = value;
                        paramCount++;
                    }
                }
            } else {
                if (reqParams.length) {
                    return false;
                }
            }            
            return {
                host: host,
                params: params,
                paramCount: paramCount
            };
        }
        return false;
    }
};
function getDotNetVer(){
    var re = /\.net clr ([\d\.]+?)[;$ ]|.net([\d\.]+?)[ce][;$ ]/ig, match, ver, max;
    while ((match = re.exec(thisUA))) {
        ver = match[1] || match[2];
        if(!max || ver > max){
            max = ver;
        }
    }
    return max;
}
function getVersion(pattern, source){
    source = source || thisUA;
    var match = source.match(pattern);
    return match ? match[1] : null;
}
function getSilverlightAndFlashVer(){
    var description, i, plugins = navigator.plugins, len, name,flVer,slVer,silverObj;
    if (plugins && (len = plugins.length) > 0) {
        for (i = 0; i < len; i++) {
            description = lower(plugins[i].description);
            name = lower(plugins[i].name);
            if (!flVer && description && indexOf(description, 'shockwave flash') > -1) {
                flVer = getVersion(/shockwave flash (\d+\.\d+)/i, description);
            }
            if(!slVer && name && description && indexOf(name, "silverlight") > -1){
                slVer = getVersion(/(\d+\.\d+)/i, description);
            }
        }
    } else if (thisWin.ActiveXObject) {
        for (i = 20; i >= 2; i--) {
            try {
                if (new ActiveXObject('ShockwaveFlash.ShockwaveFlash.' + i)) {
                    flVer = i + '.0';
                    break;
                }
            }catch (e) {}
        }
        try {            
            if ((silverObj = new ActiveXObject("AgControl.AgControl"))) {
                for (i = 10; i > 0; i--) {
                    if (silverObj.IsVersionSupported(i + ".0")) {
                        slVer = i + ".0";
                        break;
                    }
                }
            }
        }catch(e){}
    }
    return {
        flash:flVer,
        silverlight:slVer
    };
}
function isIE(){
    return "\v" == "v";
}
function Browser(name, pattern){
    this.name = name;
    this.pattern = pattern;
}
Browser.prototype.match = function(source){
    var i, len, that = this, match = source.match(that.pattern), name = that.name;
    if(match){
        for(i = 0, len = match.length; i < len; i++){
           name = name.replace('$' + i, match[i] || '');    
        }
        return utility.trim(name);
    }
    return null;    
};
function newBrowser(name, pattern){
    return new Browser(name, pattern);
}
function OS(name, pattern, mobile){
    var that = this;
    that.name = name;
    that.pattern = pattern;
    that.mobile = mobile;
}
OS.prototype.match = function(source){
    var i, len, that = this, match = source.match(that.pattern), name = that.name;
    if(match){
        for(i = 0, len = match.length; i < len; i++){
           name = name.replace('$' + i, match[i] || '');    
        }
        return {
            name:utility.trim(name),
            mobile:that.mobile
        };
    }
    return null;
};
function newOS(name, pattern, mobile){
    return new OS(name, pattern, mobile);
}
function isCookieEnabled(){
	utility.setCookie("gs_tc","1");
	var enabled = utility.getCookie("gs_tc");
	utility.delCookie("gs_tc");
	return !!enabled;
}
function BrowserAnalyzer(config){
	var that = this, nav = navigator;
    that.analyze = function(){
        if(that.browser){
			return that.browser;
		}
		var browser = {};
        try {
            var result, i, len, scr = screen, brLang = isIE() ? nav.browserLanguage : nav.language, osList = config.os, browsers = config.browsers, vers = getSilverlightAndFlashVer(), ua = nav.userAgent.replace('_', '.');
            browser.os = nav.platform;
            for (i = 0, len = osList.length; i < len; i++) {
                if ((result = osList[i].match(ua))) {
                    browser.os = result.name;
                    browser.mobile = result.mobile;
                    break;
                }
            }
            browser.browser = nav.appName;
            for (i = 0, len = browsers.length; i < len; i++) {
                if ((result = browsers[i].match(ua))) {
                    browser.browser = result;
                    break;
                }
            }
            browser.flash = vers.flash;
            browser.silverlight = vers.silverlight;
            browser.alexa = indexOf(thisUA, "alexa") > -1 ? 1 : 0;
            browser.resolution = scr.width + "*" + scr.height;
            browser.colorDepth = scr.colorDepth || 32;
            browser.osLang = lower(nav.systemLanguage);
            try {
                browser.javaEnabled = nav.javaEnabled() ? 1 : 0;
            } 
            catch (e) {
            }
            browser.dotNet = getDotNetVer();
            browser.browserLang = lower(brLang);
            browser.cookieEnabled = isCookieEnabled() ? 1: 0;
            return (that.browser = browser);
        }catch(e){
            utility.report(config.serviceID, "M_Browser", e);
            return browser;
        }
    };
}
function SearchEngine(name, host, termKey, encKey, defEnc, startKey, numKey, pagingType){
	var that = this;
	that.name = name;
	that.host = host;
	that.termKey = termKey;
	that.encKey = encKey;
	that.startKey = startKey;
	that.numKey = numKey;
	that.defEnc = defEnc || 'utf-8'; // 如果没有传默认编码,则以UTF-8作为默认编码
	that.pagingType = pagingType;
	encKey = encKey || 'ie';
	that.evaluator = new UrlEvaluator(host, [termKey], [startKey, numKey, encKey]);
}
SearchEngine.prototype.match = function(url){
	var start, num, page, params, that = this, result = that.evaluator.match(url);
	if (!result) {
		return false;
	}
	params = result.params;
	start = Number(params[that.startKey]);
	num = Number(params[that.numKey]);
	start = (isNaN(start) ? 1 : start);// 开始条目索引,默认为0,翻到第二页为10
	num = (isNaN(num) ? 10 : num);// 默认每页显示10个条目，这是大多数搜索引擎的行为
	if (!that.pagingType) {
		page = Math.round(start / num) + 1;
	} else if(that.pagingType == 1){
		page = start + 1;
	} else{
		page = start;
	}
	result.page = page;
	result.keywords = params[that.termKey]; // 关键词
	result.encoding = params[that.encKey] || that.defEnc;
	if (result.encoding === "utf8") {
		result.encoding = "utf-8";
	}
	return result;
};
function se(name, host, termKey, encKey, defEnc, startKey, numKey, pagingType){
    return new SearchEngine(name, host, termKey, encKey, defEnc, startKey, numKey, pagingType);
}
function Storage(config){
    var that = this;
    function encodeName(name){
        if(that.suffix){
            name = name + that.suffix;
        }else{
            name = name + "_" + utility.getHashCode(config.serviceID + "_" + config.domain);
        }
        return encode(name);
    }
    that.get = function(name,defValue){
        var internalName = encodeName(name);
        return utility.getCookie(internalName, defValue, true);
    };
    that.set = function(name, value, expires, path,domain,secure){
        var internalName = encodeName(name);
        domain = domain || config.domain;
        path = path || config.path;
        secure = secure || config.secure;
        utility.setCookie(internalName,value,expires,path,domain,secure, true);
    };
    that.remove = function(name){
        that.set(name,"0", -1000);
    };
}
function Sender(config){
	var that = this, tracker = config.tracker, account = "UA-26783561-2";
	function getUrl(obj, noEncode, destUrl){
        destUrl = destUrl || config.serviceUrls[0];
        return destUrl + '?' + utility.serialize(obj,"=",'&',false, noEncode);
	}
    function send(obj, noEncode, destUrl){
        obj.rd = utility.getRandomString(5);
        var serviceID = config.serviceID, url, img = new Image(1, 1),outArgs={};
        jereiReceiver.execHook('sender.send', obj, destUrl, outArgs);
        if(outArgs.cancel){
            return;
        }
        url = getUrl(obj, noEncode, destUrl).substring(0, 2000);
        img.onerror = function(){
            setTimeout(function(){
                var newImg = new Image(1, 1);
                newImg.onload = function(){
                    utility.report(serviceID, "RetrySuccess", {
                        cmd: obj.gscmd
                    },account);
                };
                newImg.onerror = function(){
                    utility.report(serviceID, "SendingFailed", {
                        cmd: obj.gscmd
                    },account);
                    return true;
                };
                newImg.src = url;
            }, 2000);
            return true;
        };
        img.onload = function(){
        };
        img.src = url;
        that.img = img;
    }
    that.checkUrl = function(obj, noEncode,destUrl){
        obj.rd = utility.getRandomString(5);
		return getUrl(obj,noEncode, destUrl).length <= 2000;
    };
    that.send = function(obj, noEncode, destUrl){		
        if (!obj) {
            return;
        }
        if(!destUrl){
            var urls = config.serviceUrls;
            for (var i = 0, len = urls.length; i < len; i++) {
                send(obj, noEncode, urls[i]);
            }
        }else{
            send(obj, noEncode, destUrl);
        }
	};
}
function Url(config){
	var that = this;
	that.parse = function(url){
		try {
			var i, q, urlInfo, urlObj, urlEvaluator, match, params, keepAnchor = config.keepAnchor, ignoreParams = config.ignoreParams, campaignKey = config.campaignKey, keywordKey = config.keywordKey, sourceKey = config.sourceKey, mediumKey = config.mediumKey, contentKey = config.contentKey, groupKey = config.groupKey, channelKey = config.channelKey, adidKey = config.adidKey, ad= config.ad, cleanUrl = config.cleanUrl;
			url = url || thisLoc.href;
			urlObj = utility.resolveUrl(url);
			urlInfo = {
				protocol: urlObj.protocol,
				local: urlObj.isLocal,
				host: urlObj.host,
				path: urlObj.fullPath,
				anchor: urlObj.anchor,
				params: urlObj.params
			};
			if (keepAnchor && urlObj.anchor) {
				urlInfo.path += "#" + urlObj.anchor;
			}
			if (cleanUrl) {
				urlInfo.cleanUrl = cleanUrl;
			} else if (ignoreParams.length !== 0 && urlObj.params) {
				for(var p in urlObj.params){
					for (i = 0; i < ignoreParams.length; i++) {
						if (lower(p) == ignoreParams[i]) {
							delete urlObj.params[p];
						}
					}
				}
				for (i = 0; i < ignoreParams.length; i++) {
					delete urlObj.params[ignoreParams[i]];
				}
				q = utility.serialize(urlObj.params, "=", "&", false, true);
				if (q) {
					q = "?" + q;
				}
				if (keepAnchor && urlObj.anchor) {
					q += ("#" + urlObj.anchor);
				}
				urlInfo.cleanUrl = [urlObj.protocol, "://", urlObj.host, urlObj.path, q].join("");
			}else{
				urlInfo.cleanUrl = [urlObj.protocol, "://", urlObj.host, urlInfo.path].join("");
			}
			if (!urlInfo.local) {
				urlEvaluator = new UrlEvaluator(urlObj.host, [], [campaignKey, keywordKey, sourceKey, mediumKey, contentKey, groupKey, channelKey, adidKey]);
				var tempAd = {
			        campaign: ad.campaign,
			        group: ad.group,
			        source: ad.source,
			        medium: ad.medium,
			        keyword: ad.keyword,
			        content: ad.content,
                    channel: ad.channel
			    };
				if ((match = urlEvaluator.match(url.replace(/#/g, "?")))) {
					params = match.params;
					if (match.paramCount !== 0) {
						tempAd.campaign = ad.campaign ||  decode(params[campaignKey]);
						tempAd.group = ad.group || decode(params[groupKey]);
						tempAd.source = ad.source || decode(params[sourceKey]);
						tempAd.medium = ad.medium || decode(params[mediumKey]);
						tempAd.keyword = ad.keyword || decode(params[keywordKey]);
						tempAd.content = ad.content || decode(params[contentKey]);
						tempAd.channel = ad.channel || decode(params[channelKey]);
						tempAd.adid = ad.adid || decode(params[adidKey]);
					}
				}
				urlInfo.ad = tempAd;
			}
			return urlInfo;
		}catch(e){
			utility.report(config.serviceID, "M_Url", e);
		}
	};
}
function User(config){
	var that = this, storage = new Storage(config), uData = {}, sData={};	
	function update(){
		var p, uid = that.uid, sid = that.sid, userData = [],sessionData = [];
		for(p in uData){
			if (isProperty(uData, p)) {
				userData.push(p + ':' + encode(uData[p]));
			}
		}
		if(userData.length > 0){
			uid = uid + '|' + userData.join("|");
		}
		for(p in sData){
			if (isProperty(sData, p)) {
				sessionData.push(p + ':' + encode(sData[p]));
			}
		}
		if(sessionData.length > 0){
			sid = sid + '|' + sessionData.join("|");
		}
		storage.set("_gscu", uid, 63072000);		
		storage.set("_gscs", sid, 1800);
		storage.set("_gscbrs", 1);
	}
	function parse(value){
		if(!value){
			return null;
		}
		var i,len,re = /[^\d\w]+/i, result = {}, data={}, splits = value.split('|'),nvPair;
		if(splits[0].length > 30 || re.test(splits[0])){
			return null;
		}
		result.id = splits[0];
		for(i = 1, len = splits.length; i < len; i++){
			nvPair = splits[i].split(':');
			data[nvPair[0]] = decode(nvPair[1]);
		}
		result.data = data;
		return result;
	}
	that.init = function(noUpdate){
		try {
			var data, gscbrs, success, userData, sessionData, prefix = "";
            uData = {};            
            sData = {};
			if (config.crossDomain) {
				data = utility.getUrlParam(thisLoc.href.replace('#', '&'), "_gsc");
				if (data) {
					data = data.split(';');
					if (data.length == 2) {
						userData = decode(data[0]);
						sessionData = decode(data[1]);
						gscbrs = 1;
						success = true;
					}
				}
			}
			if (!success) {
				userData = storage.get("_gscu");
				sessionData = storage.get("_gscs");
				gscbrs = storage.get("_gscbrs");
			}
			if ((userData = parse(userData))) {
				that.uid = userData.id;
				uData = userData.data;
				if (sessionData = parse(sessionData)) {
					that.sid = sessionData.id;
					sData = sessionData.data;
				} else {
					if (!sessionData && gscbrs) {
						prefix = "t";
					}
					that.sid = prefix + utility.getRandomID();
				}
			} else {
				that.uid = utility.getRandomID();
				that.sid = utility.getRandomID();
			}
			if (!noUpdate) update();
		}catch(e){
			utility.report(config.serviceID, "M_User", e);	
            that.uid = utility.getRandomID();
			that.sid = utility.getRandomID();
			uData = {};
			sData={};
			update();
		}
	};
	that.saveSessionData = function(key, value){
		sData[key] = value+'';
		update();
	};
	that.saveUserData= function(key, value){
		uData[key] = value+'';
		update();
	};
	that.get = function(key){
		return uData[key] || sData[key] || null;
	};
	that.serialize = function(){
		return "_gsc=" + storage.get('_gscu') + ';' + storage.get('_gscs');
	};	
	that.isSampled = function(){
		var sample = config.sample, visitCode = utility.getHashCode(that.uid);
		return visitCode % 10000 < sample * 100;
	};
}
function Referrer(config){
	var that =this;
    that.parse = function(referrer){
		try {
			var match, i, len, se, urlObj, refObj = {}, searchEngines = config.searchEngines;
			if (!referrer) {
				try {
					referrer = thisWin.top.document.referrer;
				} 
				catch (e) {
					referrer = thisReferrer;
				}
			}
			if (!referrer) {
				try {
					if (thisWin.opener) {
						referrer = thisWin.opener.location.href;
					}
				} 
				catch (e) {
				}
			}
			if (!referrer) {
				refObj.type = "direct";
			} else {
				urlObj = utility.resolveUrl(referrer);
				refObj.referrer = referrer;
				refObj.domain = lower(urlObj.host);
				refObj.path = urlObj.fullPath;
				refObj.type = "referral";
				if (!urlObj.local) {
					for (i = 0, len = searchEngines.length; i < len; i++) {
						se = searchEngines[i];
						match = se.match(referrer);
						if (match) {
							refObj.type = "organic search";
							refObj.keywords = match.keywords;
							refObj.searchEngine = se.name;
							refObj.encoding = match.encoding;
							refObj.page = match.page;
							break;
						}
					}
				}
			}
			return refObj;
		}catch(e){
			 utility.report(config.serviceID, "M_Referrer", e);
		}
    };
}
function Heatmap(config){
    var that = this, offsetX, offsetY, tracker = config.tracker,origin = config.origin;
	function isEnabled(){		
		if(!config.heatmap){
			return false;
		}
		if (config.mcSample == 100) {
			return true;
		}
		return Math.round(Math.random() * 10000) < config.mcSample * 100;
	}
    function updateCoordinate(){
		if (config.docWidth) {
			offsetX = (utility.getDocWidth() - config.docWidth) / 2;
			offsetY = 0;
		} else if (origin) {
			var originPos = utility.getPos(origin);
			offsetX = originPos.x;
			offsetY = originPos.y;
		} else {
		    offsetX = 0;
		    offsetY = 0;
		}
	}
    function getPos(targetX, targetY){
        updateCoordinate();
        return getRoundedXY({
            x: targetX - offsetX,
            y: targetY - offsetY
        });
    }
	function getRoundedXY(xy){
		xy.x = Math.round(xy.x/10.0)*10;
		xy.y = Math.round(xy.y/10.0)*10;
		return xy;
	}
    function sendData(x, y, clickSrc, clickEvent){        
        var p, region, pos, snapshotID = Number(thisWin[config.snapshotVar] || 0),data = tracker.getCommon("mc"),url = tracker.url, urlObj = url.parse(),temp=[], outArgs={};
        if (!(snapshotID > -1 && snapshotID < 256)) {
            snapshotID = 0;
        }
        jereiReceiver.execHook('heatmap.send', data, x, y, clickSrc, clickEvent, outArgs);
        if(outArgs.cancel){
            return;
        }       
        var match = utility.searchUp(null, clickEvent, "A", null, 3);
        if (match != null) {
            data.lk = match.href;
            data.lt = _gsUtility.getInnerText(match) || _gsUtility.getInnerUnvisibleText(match, 'title') + match.title || _gsUtility.getInnerUnvisibleText(match, 'alt');
            pos = _gsUtility.getPos(match);
			pos = getPos(pos.x, pos.y);
            data.lx = pos.x;
            data.ly = pos.y;
        }
		match = utility.searchUp(null, clickEvent, null, {gsregion:""});
        if (match != null) {
			region = Number(match.getAttribute("gsregion"));
			if(region > -1 && region < 256){
	            data.re = region;
	            if(match.getAttribute("gsposfixed")=="1"){
					pos = utility.getPos(match);
					pos = getPos(pos.x, pos.y);
                    x = x - pos.x;
                    y = y - pos.y;
	            }
	            match = utility.searchUp(null, clickEvent, null, {gssnapshot: ""});
	            if (match) {
	                snapshotID = Number(match.getAttribute("gssnapshot"));
	                if (snapshotID < 0 || snapshotID > 255) {
	                    snapshotID = 0;
	                }
	            }
			}			
		}
        data.gspver = config.pageVer;
        data.gsmcoffsetx = x;
        data.gsmcoffsety = y;
		temp = [urlObj.protocol, "://", urlObj.host, urlObj.path];
		if(config.keepAnchor && urlObj.anchor){
			temp.push("#", urlObj.anchor);
		}
        data.gsmcurl = temp.join("");
        data.gstl = config.pageName || thisDoc.title;
        data.gssn = snapshotID;
        data.gsorurl = urlObj.cleanUrl;
        tracker.sender.send(data);
    }
    function onMouseUp(e) {
        if (checkTouchPointShouldBeIgnored(e)) return;
        try {
			if (!isEnabled()) {
				return;
			}
			var i, len, tagName = lower(e.target.tagName);
			if(tagName == 'body' || tagName == 'html'){
                return;
            }
            var tx = e.pageX, ty = e.pageY;
			if (utility.touchPoint) tx = utility.touchPoint.X, ty = utility.touchPoint.Y, utility.touchPoint = null;
			var pos = getPos(tx, ty);
			sendData(pos.x, pos.y, this, e);
		}catch(ex){
			utility.report(config.serviceID, "M_Heatmap_doc", ex);
		}
    }
    function iframeClickHandler(iframe, e){
        if (checkTouchPointShouldBeIgnored(e)) return;
        try {
            var tx = e.clientX, ty = e.clientY;
            if (utility.touchPoint) tx = utility.touchPoint.X, ty = utility.touchPoint.Y, utility.touchPoint = null;
            var iframePos = getRoundedXY(utility.getPos(iframe)), pos = getPos(tx, ty);
            sendData(pos.x + iframePos.x, pos.y + iframePos.y, iframe, e);
        }catch(ex){
            utility.report(config.serviceID, "M_Heatmap_iframe", ex);
        }
    }
    function checkTouchPointShouldBeIgnored(e) {
        return utility.touchPoint && utility.touchPoint.X == e.pageX && utility.touchPoint.Y == e.pageY;
    }
	function bindFrames(){
		var i, len, iframes = config.iframes,frms = frames;
        if (iframes.length == 0) {
            for (i = 0, len = frms.length; i < len; i++) {
                try {
                    var frameEl = frms[i].frameElement || frms[i];
                    if (frameEl.contentDocument || frms[i].document) {
                        frameEl.contentDocument = frameEl.contentDocument || frms[i].document;
                        iframes.push(frameEl);
                    }
                } 
                catch (e) {
                }
            }
        }
        for (i = 0, len = iframes.length; i < len; i++) {
            var frame = utility.getEl(iframes[i]);
            if (frame) {
                try {
                    frame = frame.frameElement || frame;
                    var doc = frame.contentDocument;
                    var callback = (function (fr) {
                        return function(args) {
                            iframeClickHandler(fr, args);
                        };
                    })(frame);
                    if (thisDoc.ontouchstart !== undefined) utility.observeTouch(doc, callback);
                    utility.observe(doc, "mouseup", callback);
                } 
                catch (e) {
                }
            }
        }
	}
	that.bind = function(){
		if(that.isBind || !config.heatmap){
			return;
		}
		that.isBind = true;
		if (thisDoc.ontouchstart !== undefined) utility.observeTouch(thisDoc, onMouseUp);
	    utility.observe(thisDoc, "mouseup", onMouseUp);
		if(/loaded|complete/.test(thisDoc.readyState)){
			bindFrames();
		}else{
			utility.observe(thisWin, 'load', bindFrames);
		}
	};
    that.init = function(){
		that.bind();
    };
}
function ECom(config){
	var that = this;
	that.orders = [];
    that.ordersForEcom = [];
    that.addOrder = function(orderid, totalPrice, userID){
		totalPrice = Number(totalPrice);
        that.orders.push({
            orderid: orderid+'',
            price: totalPrice || 0,
            quantity: 0,
            user: userID,
            products: [],
            recal: !totalPrice
        });
    };
    that.addProduct = function(orderid, productName, sku, unitPrice, quantity, category){
        try {
            var i, len, curOrder, recal, price, allOrders = that.orders, product = {};
            orderid = orderid + '';
            unitPrice = Number(unitPrice) || 0;
            quantity = Number(quantity) || 0;
            for (i = 0, len = allOrders.length; i < len; i++) {
                if (allOrders[i].orderid == orderid) {
                    curOrder = allOrders[i];
                    break;
                }
            }
            if (!curOrder) {
                curOrder = {
                    orderid: orderid,
                    price: 0,
                    quantity: 0,
                    products: [],
                    recal: true
                };
                allOrders.push(curOrder);
            }
            recal = curOrder.recal;
            price = Number((unitPrice * quantity).toFixed(2));
            product = {
                orderid: orderid,
                name: productName,
                sku: sku,
                quantity: quantity,
                unitPrice: unitPrice,
                price: price,
                category: category
            };
            curOrder.quantity += product.quantity;
            curOrder.products.push(product);
            if (recal) {
                curOrder.price = Number((curOrder.price + price).toFixed(2));
            }
        }catch(e){
            utility.report(config.serviceID, "FC_addProduct", e);
        }
    };
}
function Config(serviceID){
	var that = this,domain = thisLoc.hostname;
	that.ad = {};
	that.properties = {};
	that.pageProperties = null;
	that.serviceID = serviceID;
	that.serviceUrls = ["//21sun.v.jerei.com/recv/a.gif"];
	that.heatmapUrl = "//21sun.v.jerei.com/js/heatmap.js";
	that.redirectServer = "";
	that.redirectServerPath = "";
	that.campaignKey = "utm_campaign";
	that.mediumKey = "utm_medium";
	that.sourceKey = "utm_source";
	that.groupKey = "utm_adgroup";
	that.keywordKey = "utm_term";
	that.contentKey = "utm_content";
	that.channelKey = "utm_channel";
	that.accountKey = "utm_account";
    that.adidKey = "gsadid";
	that.ignoreParams = ["gclid", "bdclkid", "gs_ws", that.campaignKey, that.mediumKey, that.sourceKey, that.groupKey, that.keywordKey, that.contentKey, that.channelKey, that.accountKey, "gsadid"];
	that.searchEngines = [
		se("google",/(\w+\.)*google\.(\w+|(com|co)\.\w+)/i,"q","ie","utf-8","start","num"),
		se("baidu",/(\w+\.)*baidu\.(com|cn|com\.cn)/i,"wd","ie","gb2312","pn","rn"),
		se("baidu",/(\w+\.)*baidu\.(com|cn|com\.cn)/i,"word","ie","gb2312","pn","rn"),
		se("yahoo",/(\w+\.)cn\.yahoo\.com/i,"q","ei","utf-8","b"),
		se("yahoo",/(\w+\.)*yahoo\.(\w+|(com|co)\.\w+)/i,"p","ei","utf-8","b"),
		se("yahoo",/(\w+\.)*yahoo\.cn/i,"q","ei","utf-8","b"),
		se("live",/(\w+\.)*live\.\w+/i,"q",null,"utf-8","first"),
		se("youdao",/(\w+\.)*youdao\.com/i,"q","ue","utf-8","start"),
        se("soso",/(\w+\.)*soso\.com/i,"w",null,"gb2312","pg",null,2),
		se("gougou",/(\w+\.)*gougou\.com/i,"search",null,"utf-8","page",null,1),
		se("sogou",/(\w+\.)*sogou\.com/i,"query",null,"gb2312","page",null,1),
		se("bing",/\bbing\.(\w+)/i,"q",null,"utf-8","first"),
		se("118114",/\b118114\.cn/i,"kw",null,"gb2312","start"),
		se("jike",/\bjike\.com/i,"q",null,"utf-8","page", "ps", 2),
		se("panguso",/\bpanguso\.com/i,"q",null,"utf-8","p", "n", 1),
		se("360", /\b360\.cn/i, "q", null, "utf-8", "pn", "", 2),
        se("360", /\bso\.com/i, "q", null, "utf-8", "pn", "", 2),
		se("UC",/glb\.uc\.cn/i,"keyword",null,"utf-8","page", "pagesize", 2),
		se("OCN",/ocnsearch\.goo\.ne\.jp/i,"MT",null,"utf-8","FR", "", 1),
		se("fenrir",/search\.fenrir-inc\.com/i,"q",null,"utf-8","start", "", 1),
		se("nifty",/search\.nifty\.com/i,"q",null,"utf-8","start", "", 1),
		se("biglobe",/search\.biglobe\.ne\.jp/i,"q",null,"utf-8","start", "num", 1),
		se("sweetim",/search\.sweetim\.com/i,"q",null,"utf-8","start", "", 1),
		se("AVG",/isearch\.avg\.com/i,"q",null,"utf-8","pagenum", "", 1),
		se("mywebsearch", /search\.mywebsearch\.com/i, "searchfor", null, "utf-8"),
        se("shenma", /^m\.(\w+\.)?sm\.cn/i, "q", null, "utf-8"),
		se("aol",".aol.com","q"),se("lycos",".lycos.com","query"),
		se("ask",".ask.com","q"),se("altavista",".altavista.com","q"),se("netscape",".netscape.com","query"),se("cnn",".cnn.com","query"),
		se("gigablast",".gigablast.com","q"),se("search",".search.com","q"),se("pchome",".pchome.com","q")
	];
	that.contentNetworkKey = "content_";
	that.os = [
	   newOS("$1 / iOS$2", /^.*(iPhone|iPad|iPod).*? i?OS[\. ](\d(\.\d)?).*$/i, 1),
	   newOS("$1 $2", /(Android)[ \/\.]?(\d+[\._]\d+?)?/i, 1),
	   newOS("WindowsMobile $1", /WindowsMobile\/(\d+\.\d+)|windows ce/i, 1),	   
	   newOS("$1 $2", /(Windows Phone).*?(\d+\.\d+)/i, 1),
	   newOS("Symbian S$1", /Series ?(60|40)/i, 1),
	   newOS("$1 OS $2", /(BlackBerry)[^\/]*\/(\d\.\d)/i, 1),
	   newOS("$0", /Palm|Symbian|BlackBerry|Nokia|iPhone|Android|WindowsMobile/i, 1), 
	   newOS('$1 8', /(Windows) nt 6.2/i),
	   newOS('$1 7 or 2008R2', /(Windows) nt 6.1/i),
	   newOS('$1 Vista or 2008', /(Windows) nt 6.0/i),
	   newOS('$1 Server 2003', /(Windows) nt 5.2/i),
	   newOS('$1 XP', /(Windows) nt 5.1/i),
	   newOS('$1 2000', /(Windows) nt 5.0/i),
	   newOS("Mac $1", /Mac os x (\d+\.\d+)|Macintosh/i),
	   newOS("$0", /Linux|Windows 98/i)
	];
	that.browsers = [	   
	   newBrowser("$1 $2", /(Firefox|Chrome|Opera|IEMobile|UCWeb|Opera Mini|NetFront|IceweaselBlackBerry|QQBrowser)[\/ ]?(\d+\.\d)/i),
	   newBrowser("UCWeb $2", /(UCWeb|UCBrowser|\sUC\s)[ \/\.]?((\d+(\.\d+)?))?/i),
	   newBrowser("$2 $1", /Version\/(\d+\.\d).*(Safari)/i),
	   newBrowser("Safari", /AppleWebKit/i),
	   newBrowser("$2$3 / IE $1", /msie (\d+)\.\d.*(Maxthon|TheWorld|Avant Browser|TencentTraveler|GreenBrowser|360SE)[ \/]?(\d+\.\d)?/i), // IE内核型浏览器
	   newBrowser("Maxthon$3 / $1", /Apple(WebKit).*(Maxthon)[ \/]?(\d+\.\d)?/i),
	   newBrowser("Sogou / IE $1", /msie (\d+)\.\d.*?se \d+/i),
	   newBrowser("IE $1", /msie ?(\d+)\.\d?/i)
	];
	if(domain.substring(0,4) == "www."){
		domain = domain.substring(4);
	}
	that.domain = domain;
	that.path = "/";
	that.sessionTimeout = 30 * 60;
	that.sample = 100;    
	that.origin = thisDoc.body;
	that.mcSample = 100;
	that.iframes = [];
	that.snapshotVar = "GridsumSnapshotID";
	that.tsVar = "GSTS";
}
function Tracker(serviceID) {
    var that = this, config = new Config(serviceID);
    config.tracker = that;
    that.serviceID = serviceID;
    that.config = config;
    function check() {
        try {
            if (utility.getCookie("_gsHijack")) {
                return;
            }
            if (top != thisWin && top.location.href === thisLoc.href) {
                utility.report(serviceID, "WebPageHijack");
                utility.setCookie("_gsHijack", 1);
            }
        } catch (e) {
        }
    }
    function isLocal() {
        if (config.trackLocal) {
            return false;
        }
        var hostname = thisLoc.hostname;
        return thisLoc.protocol === "file:" ||
            //indexOf(hostname, "localhost") > -1 ||
            indexOf(hostname, "127.") == 0 ||
            indexOf(hostname, "192.168.") == 0 ||
            indexOf(hostname, "10.") == 0 ||
            indexOf(hostname, "172.") == 0;
    }
    function isHeatmapModeOn() {
        var urlHash = lower(thisLoc.hash);
        return config.heatmap &&
            indexOf(urlHash, "#gwdheatmap&") > -1 &&
            indexOf(urlHash, serviceID.substring(4)) > -1;
    }
    function isDisable() {
        return !serviceID || isLocal() || isHeatmapModeOn() || indexOf(thisUA, config.ignoreUA) > -1 || !that.user.isSampled();
    }
    function getCommon(cmd) {
        var user = that.user;
        return {
            gsver: jereiReceiver.version,
            gscmd: cmd,
            gssrvid: serviceID,
            gsuid: user.uid,
            gssid: user.sid,
            gsltime: utility.getLocalTime(),
            gstmzone: utility.getTimeZone(),
            gsjp: config.junction,
            rd: 1
        };
    }
    function appendBrowserInfo(data) {
        var browserInfo = that.browser.analyze();
        data.gsflver = browserInfo.flash;
        data.gsalexaver = browserInfo.alexa;
        data.gsbrname = browserInfo.browser;
        data.gsdotnetver = browserInfo.dotNet;
        data.gssil = browserInfo.silverlight;
        data.gsbrlang = browserInfo.browserLang;
        data.gsscr = browserInfo.resolution;
        data.gsclr = browserInfo.colorDepth;
        data.gsoslang = browserInfo.osLang;
        data.gsosname = browserInfo.os;
        data.gsje = browserInfo.javaEnabled;
        data.gsce = browserInfo.cookieEnabled;
        data.gsim = browserInfo.mobile;
    }
    function calculateDuration(begin) {
        var end = new Date(), duration = Math.round((end - begin) / 1000);
        if (duration > 180) {
            duration = 180;
        }
        if (duration < 0) {
            duration = 0;
        }
        that.duration = duration;
    }
    function sendHeartbeat(sid, uid) {
        if (!that.hbSent) {
            that.trackHeartbeat(sid, uid);
            that.hbSent = 1;
            return true;
        }
    }
    that.getCommon = getCommon;
    that.init = function() {
        if (that.isInit) {
            that.user.init();
            return;
        }
        that.user = new User(config);
        that.browser = new BrowserAnalyzer(config);
        that.referrer = new Referrer(config);
        that.url = new Url(config);
        that.ecom = new ECom(config);
        that.sender = new Sender(config);
        that.heatmap = new Heatmap(config);
        that.user.init();
        var i, plugins = jereiReceiver.plugins, len = plugins.length;
        for (i = 0; i < len; i++) {
            var plugin = plugins[i], name = plugin.name;
            that[name] = new plugin.template(config);
        }
        if (isHeatmapModeOn()) {
            that.showHeatmap();
        }
        if (!isDisable()) {
            if (config.lazyBinding) {
                utility.observe(thisWin, "load", function() {
                    that.heatmap.init();
                });
            } else {
                that.heatmap.init();
            }
            that.pvid = utility.getRandomID();
            var initTS = new Date();
            utility.observe(thisWin, "load", function() {
                var begin = thisWin[config.tsVar] || initTS;
                calculateDuration(begin);
            });
            utility.observe(thisWin, "beforeunload", function() {
                if (that.duration == null) {
                    var begin = thisWin[config.tsVar] || initTS;
                    calculateDuration(begin);
                }
                sendHeartbeat();
            });
            var lastPVCount;
            var sid = that.user.sid;
            var uid = that.user.uid;
            var timer = thisWin.setInterval(function() {
                if (!that.conditionMatch) {
                    that.user.init(true);
                    var pvCount = that.user.get("pv");
                    if (lastPVCount && lastPVCount < pvCount) {
                        that.conditionMatch = 1;
                    } else if (that.user.sid != sid) {
                        that.conditionMatch = 1;
                    }
                    lastPVCount = pvCount;
                }
                if (that.conditionMatch && that.duration != null) {
                    sendHeartbeat(sid, uid);
                    thisWin.clearInterval(timer);
                }
            }, 1000);
        } else {
            that.disabled = true;
        }
        that.isInit = true;
    };
    that.track = function(page, changeReferrer) {
        try {
            that.init();
            if (that.disabled) {
                return;
            }
            var properties = config.properties, pageProperties = config.pageProperties, ispaid, ad, user = that.user, pvCount, url = that.url, referrerParser = that.referrer, pageVer = config.pageVer, data = getCommon("pv"), referrer = (page && changeReferrer) ? thisLoc.href : "", contentNetworkKey = config.contentNetworkKey;
            page = page || thisLoc.href;
            page = url.parse(page);
            referrer = referrerParser.parse(referrer);
            pvCount = Number(user.get("pv")) || 0;
            data.gsissecpv = (pvCount == 1 ? 1 : 0);
            if (!that.isSent) {
                data.pvid = that.pvid;
                that.isSent = 1;
            }
            data.gstl = config.pageName || thisDoc.title;
            data.ubc = config.breadcrumb;
            data.gspro = page.protocol;
            data.gsdm = page.host;
            data.gscp = utility.serialize(properties, "::", "||", false, false);
            data.pcp = pageProperties;
            if (pageVer) {
                data.gspver = pageVer;
            }
            data.gsreftype = referrer.type || '';
            data.gsrefdm = referrer.domain;
            data.gssename = referrer.searchEngine;
            data.gskwd = referrer.keywords;
            data.gsenc = referrer.encoding;
            data.gssepage = referrer.page;
            ad = page.ad;
            for (var p in ad) {
                if (isProperty(ad, p) && ad[p]) {
                    data.gsispaid = (ispaid = 1);
                    break;
                }
            }
            data.gscamp = ad.campaign;
            data.gsgroup = ad.group;
            data.gscampsrc = ad.source;
            data.gsmedium = ad.medium;
            data.gscampkwd = ad.keyword;
            data.gscampcontent = ad.content;
            data.adch = ad.channel;
            data.gsadid = ad.adid;
            if (ispaid) {
                if (!thisReferrer) {
                    data.gsrefdm = "(lost)";
                    data.gsrefpa = "(lost)";
                    data.gsreftype = "referral";
                } else if (referrer.searchEngine) {
                    data.gsreftype = "paid search";
                }
                if (!referrer.searchEngine && indexOf(ad.medium, contentNetworkKey) == 0) {
                    data.gsreftype = "content network";
                }
            }
            appendBrowserInfo(data);
            data.gsorurl = page.cleanUrl;
            data.gspa = page.path;
            data.gsrefpa = referrer.path || '';
            that.sender.send(data);
            user.saveSessionData("pv", ++pvCount);
            if (that.rsDomain && pvCount == 1 && (!thisReferrer || indexOf(thisReferrer, that.rsDomain) > -1)) {
                var rData = data;
                rData.gscmd = "rpv";
                var rUrl = [config.redirectServer, utility.getHashCode(that.rsDomain), config.redirectServerPath].join("");
                that.sender.send(rData, false, rUrl);
            }
            check();
        } catch (e) {
            utility.report(serviceID, "FC_track", e);
        }
    };
    that.trackLink = function(page, el, tagName, attrs) {
        return that.bindEvent(el, "click", function(e) {
            that.track(page, true);
        }, tagName, attrs);
    };
    that.trackECom = function() {
        try {
            that.init();
            if (that.disabled) {
                return;
            }
            var i, j, len, len2, orderid, sender = that.sender, allOrders = that.ecom.orders, data = getCommon("ecom"), allProducts, order, product, products = [], user = that.user, oldOrderIDs = user.get('_gsecom');
            if (oldOrderIDs) {
                oldOrderIDs = oldOrderIDs.split(",");
            } else {
                oldOrderIDs = [];
            }
            for (i = 0, len = allOrders.length; i < len; i++) {
                order = allOrders[i];
                orderid = encode(order.orderid);
                if (indexOf(oldOrderIDs, orderid) > -1) {
                    continue;
                }
                oldOrderIDs.push(orderid);
                data.gsorderid = order.orderid;
                data.gstotal = order.price;
                data.gsquan = order.quantity;
                data.gsuserid = order.user;
                for (var ind in that.ecom.ordersForEcom)
                    if (that.ecom.ordersForEcom[ind].orderid == order.orderid) {
                        data.ecp = that.ecom.ordersForEcom[ind].ecomProperties;
                        break;
                    }
                allProducts = order.products;
                products = [];
                for (j = 0, len2 = allProducts.length; j < len2; j++) {
                    product = allProducts[j];
                    product = utility.serialize(product, "::", ",,", false, true);
                    products.push(product);
                }
                data.gsproducts = products.join("||");
                if (!sender.checkUrl(data)) {
                    for (j = 0; j < allProducts.length; j++) {
                        product = allProducts[j];
                        product = utility.serialize(product, "::", ",,", false, true);
                        data.gsproducts = product;
                        sender.send(data);
                    }
                } else {
                    sender.send(data);
                }
            }
            user.saveSessionData('_gsecom', oldOrderIDs.join(","));
            that.ecom.orders = [];
        } catch (e) {
            utility.report(serviceID, "FC_trackECom", e);
        }
    };
    that.trackClickthrough = function(title, url) {
        try {
            that.init();
            if (that.disabled) {
                return;
            }
            if (title || url) {
                var data = getCommon("ct"), searchID = that.lastSearchID;
                if (searchID) {
                    data.gsssid = searchID;
                    if (url) {
                        var urlObj = utility.resolveUrl(url);
                        data.gsclkpro = urlObj.protocol;
                        data.gsclkdm = urlObj.host;
                        data.gsclkpa = urlObj.fullPath;
                    }
                    data.gsclktl = title;
                    that.sender.send(data);
                }
            }
        } catch (e) {
            utility.report(serviceID, "FC_trackClickthrough", e);
        }
    };
    that.trackHeartbeat = function(sid, uid) {
        var data = getCommon("hb");
        data.pvid = that.pvid;
        data.pld = that.duration;
        data.gssid = sid || data.gssid;
        data.gsuid = uid || data.gsuid;
        that.sender.send(data);
    };
    that.trackSiteSearch = function(keyword, category, encoding, fromQuery, referrer) {
        try {
            that.init();
            if (that.disabled) {
                return;
            }
            var data = getCommon("ss"), searchID = utility.getRandomID();
            if (fromQuery) {
                data.gsskwd = utility.getUrlParam(thisLoc.href, keyword);
                data.gssenc = encoding || "utf-8";
                data.gsscat = utility.getUrlParam(thisLoc.href, category);
            } else if (encoding) {
                data.gsskwd = keyword;
                data.gsscat = category;
                data.gssenc = encoding;
            } else {
                data.gsskwd = encode(keyword);
                data.gsscat = encode(category);
                data.gssenc = "utf-8";
            }
            if (!data.gsskwd) {
                return;
            }
            data.gsssid = that.lastSearchID = searchID;
            referrer = referrer || thisReferrer;
            if (referrer) {
                var refObj = utility.resolveUrl(referrer);
                data.gssrefpa = refObj.fullPath;
                data.gssrefdm = refObj.host;
            }
            that.sender.send(data);
        } catch (e) {
            utility.report(serviceID, "FC_trackSiteSearch", e);
        }
    };
    that.trackEvent = function(category, name, detail, value) {
        that.init();
        if (that.disabled) {
            return;
        }
        try {
            var data = getCommon("ev"), page = thisLoc.href;
            data.eca = category;
            data.eac = name;
            data.eva = value;
            data.ela = detail;
            page = that.url.parse(page);
            data.gsourl = page.cleanUrl;
            that.sender.send(data);
        } catch (e) {
            utility.report(serviceID, "FC_trackEvent", e);
        }
    };
    that.bindEvent = function(el, eventName, callback, tagName, properties) {
        properties = properties || {};
        return utility.observe(el, eventName, function(e) {
            if (!e || !e.target) {
                return;
            }
            var match = utility.searchUp(el, e, tagName, properties);
            if (match != null) {
                e.matched = match;
                callback(e);
                return;
            }
        });
    };
    that.bindSearchResults = function(root, attrs) {
        return that.bindEvent(root, 'click', function(e) {
            var link = e.matched;
            that.trackClickthrough(utility.getInnerText(link), link.href);
        }, 'a', attrs);
    };
    that.trackIde = function (reg) {
      	var re=new RegExp(reg);
        return utility.observe(document.body, "click", function (e) {
            if (utility.trim(e.target.id) && re.exec(e.target.outerHTML)) {
                try {
                    that.init();
                    var data = getCommon("ide");
                    data.id = e.target.id;
                    data.tagname = e.target.tagName;
                    data.evc = e.target.category || "";
                    data.innertext = e.target.eventname || e.target.value || e.target.alt || e.target.title || utility.getInnerText(e.target)
                    that.sender.send(data);
                } catch (e) {
                    utility.report(serviceID, "FC_trackIde", e);
                }
            }
        });
    };
    that.trackOrderPay = function(orderId){
      	try{
          	that.init();
          	var data = getCommon("op");
          	data.oid = orderId;
          	that.sender.send(data);
        }catch(e){
        }
    }
    that.trackCart = function (stage,quantity,totalprice){
    	try{
    		that.init();
    		var data = getCommon("ca");
    		data.stage = stage;
    		data.quantity = quantity;
    		data.totalprice = totalprice;
    		that.sender.send(data);
    	}catch(e){
    		utility.report(serviceID, "FC_trackCart", e);
    	}
    }
    that.trackFmStart = function (formName,prod) {
        try {
            that.init();
            var data = getCommon("fm");
            data.fms = 1;
            data.fmn = formName;
            data.url = location.href;
            data.prod = prod;
            that.sender.send(data);
        } catch (e) {
            utility.report(serviceID, "FC_trackFmStart", e);
        }
    };
    that.trackFmTry = function (formName,prod,itemname) {
        try {
            that.init();
            var data = getCommon("fm");
            data.fms = 2;
            data.fmn = formName;
            data.url = location.href;
            data.prod = prod;
            data.fmin = itemname;
            that.sender.send(data);
        } catch (e) {
            utility.report(serviceID, "FC_trackFmTry", e);
        }
    };
    that.trackFmFill = function (formName,prod, itemname, itemvalue) {
        try {
            that.init();
            var data = getCommon("fm");
            data.fms = 3;
            data.fmn = formName;
            data.url = location.href;
            data.prod = prod;
            data.fmin = itemname;
            data.fmiv = itemvalue;
            that.sender.send(data);
        } catch (e) {
            utility.report(serviceID, "FC_trackFmFill", e);
        }
    };
    that.trackFmSubmit = function (formName,prod) {
        try {
            that.init();
            var data = getCommon("fm");
            data.fms = 4;
            data.fmn = formName;
            data.url = location.href;
            data.prod = prod;
            that.sender.send(data);
        } catch (e) {
            utility.report(serviceID, "FC_trackFmSubmit", e);
        }
    };
    that.trackFmFinish = function (formName,prod) {
        try {
            that.init();
            var data = getCommon("fm");
            data.fms = 5;
            data.fmn = formName;
            data.url = location.href;
            data.prod = prod;
            that.sender.send(data);
        } catch (e) {
            utility.report(serviceID, "FC_trackFmFinish", e);
        }
    };
    that.showHeatmap = function() {
        var heatmapUrl = config.heatmapUrl;
        jereiReceiver.heatmapUrl = thisLoc.href;
        var script = thisDoc.createElement("script");
        script.src = heatmapUrl;
        thisDoc.getElementsByTagName("head")[0].appendChild(script);
    };
    that.addOrder = function(orderID, totalPrice, userID) {
        that.ecom.addOrder(orderID, Number(totalPrice),userID);
    };
    that.addProduct = function(orderID, productName, sku, unitPrice, quantity, category) {
        that.ecom.addProduct(orderID, productName, sku, Number(unitPrice), Number(quantity), category);
    };
    that.setSessionTimeout = function(seconds) {
        if (seconds < 1 || seconds > 3600) {
            return;
        }
        config.sessionTimeout = seconds;
    };
    that.setBreadcrumb = function(breadcrumb) {
        that.config.breadcrumb = breadcrumb;
    };
    that.setCampaign = function(campaign) {
        if (campaign && campaign.length != 0) {
            config.ad.campaign = campaign;
        }
    };
    that.setGroup = function(group) {
        if (group && group.length != 0) {
            config.ad.group = group;
        }
    };
    that.setContent = function(content) {
        if (content && content.length != 0) {
            config.ad.content = content;
        }
    };
    that.setKeyword = function(keyword) {
        if (keyword && keyword.length != 0) {
            config.ad.keyword = keyword;
        }
    };
    that.setMedium = function(medium) {
        if (medium && medium.length != 0) {
            config.ad.medium = medium;
        }
    };
    that.setSource = function(source) {
        if (source && source.length != 0) {
            config.ad.source = source;
        }
    };
    that.setAdid = function(adid) {
        if (adid && adid.length != 0) {
            config.ad.adid = adid;
        }
    };
    that.setCampaignKey = function(key) {
        config.ignoreParams.push(config.campaignKey = lower(key));
    };
    that.setMediumKey = function(key) {
        config.ignoreParams.push(config.mediumKey = lower(key));
    };
    that.setContentKey = function(key) {
        config.ignoreParams.push(config.contentKey = lower(key));
    };
    that.setSourceKey = function(key) {
        config.ignoreParams.push(config.sourceKey = lower(key));
    };
    that.setKeywordKey = function(key) {
        config.ignoreParams.push(config.keywordKey = lower(key));
    };
    that.setGroupKey = function(key) {
        config.ignoreParams.push(config.groupKey = lower(key));
    };
    that.setChannelKey = function(key) {
        config.ignoreParams.push(config.channelKey = lower(key));
    };
    that.setAdidKey = function(key) {
        config.ignoreParams.push(config.adidKey = lower(key));
    };
    that.setContentNetworkPrefix = function(prefix) {
        config.contentNetworkKey = prefix;
    };
    that.setChannel = function(value, key, fromReferrer) {
        var param;
        if (key) {
            if (fromReferrer) {
                param = utility.getUrlParam(thisReferrer, key);
            } else {
                param = utility.getUrlParam(thisLoc.href, key);
            }
            if (param) {
                value = param;
            }
        }
        if (value && value.length != 0) {
            config.ad.channel = value;
        }
    };
    that.setIgnoreTrafficKeyword = function(keyword) {
        if (keyword) {
            config.ignoreUA = keyword;
        }
    };
    that.setCustomProperty = function(propertyName, defaultValue, type, key) {
        var value = defaultValue;
        if (type === "cookie") {
            value = utility.getCookie(key) || defaultValue;
        } else if (type === "query") {
            value = utility.getUrlParam(thisLoc.href, key) || defaultValue;
        }
        if (value != null) {
            config.properties[propertyName] = value;
        }
    };
    that.setPageProperty = function(index, value) {
        if (index == null || value == null) return;
        if (!config.pageProperties) config.pageProperties = {};
        config.pageProperties[index] = value;
    };
    that.setEcomProperty = function(orderId, index, value) {
        if (orderId == null || index == null || value == null) return;
        for (var i in that.ecom.ordersForEcom)
            if (that.ecom.ordersForEcom[i].orderid == orderId) {
                that.ecom.ordersForEcom[i].ecomProperties[index] = value;
                return;
            }
        var l = that.ecom.ordersForEcom.push({
            orderid: orderId,
            ecomProperties: {}
        });
        that.ecom.ordersForEcom[l - 1].ecomProperties[index] = value;
    };
    that.setHeatmapScriptUrl = function(url) {
        config.heatmapUrl = url;
    };
    that.setPageName = function(pageName) {
        config.pageName = pageName;
    };
    that.setServiceUrl = function(url) {
        config.serviceUrls = [url];
    };
    that.setServiceUrls = function(urls) {
        if (!isArray(urls)) {
            urls = slice.call(arguments);
        }
        config.serviceUrls = urls;
    };
    that.setJunctionPoint = function(junction) {
        config.junction = junction;
    };
    that.setCookieProperties = function(domain, path, isSecure) {
        if (domain && domain.charAt(0) === ".") {
            domain = domain.substring(1);
        }
        config.domain = domain || config.domain;
        config.path = path || config.path;
        config.secure = !!isSecure;
    };
    that.setSamplingRate = function(newRate) {
        config.sample = newRate;
    };
    that.setClickSamplingRate = function(newRate) {
        config.mcSample = newRate;
    };
    that.setDocWidth = function(width) {
        config.docWidth = Number(width);
    };
    that.setOriginalUrl = function(url) {
        config.cleanUrl = url;
    };
    that.setOriginElement = function(element) {
        config.origin = utility.getEl(element);
    };
    that.setPageVersion = function(ver) {
        config.pageVer = ver;
    };
    that.addOrganicSearch = function(name, domain, keywordKey, encodingKey, defEncoding, pageStartKey, pageNumKey, pagingType) {
        config.searchEngines.push(se(name, domain, lower(keywordKey), lower(encodingKey), lower(defEncoding), lower(pageStartKey), lower(pageNumKey), pagingType));
    };
    that.getWDCookieString = function() {
        that.init();
        return that.user.serialize();
    };
    that.jump = function(target) {
        var ck = that.getWDCookieString(), targetUrl = isString(target) ? target : target.action;
        thisLoc.href = targetUrl + "#" + ck;
    };
    that.addIgnoreParams = function() {
        config.ignoreParams = config.ignoreParams.concat(slice.call(arguments));
    };
    that.enableLazyClickTrace = function(disable) {
        config.lazyBinding = !disable;
    };
    that.enableHeatmap = function(disable) {
        config.heatmap = !disable;
        if (that.heatmap) {
            that.heatmap.bind();
        }
    };
    that.enableCrossDomain = function(disable) {
        config.crossDomain = !disable;
    };
    that.enableLocalTraffic = function() {
        config.trackLocal = true;
    };
    that.enableAnchor = function(disable) {
    };
    that.keepAnchor = function(disable) {
        config.keepAnchor = !disable;
    };
    that.enableRedirectServer = function(domain) {
        that.rsDomain = domain || config.domain;
    };
    that.setErrorUrls = function(urls) {
        if (!isArray(urls)) {
            urls = slice.call(arguments);
        }
        utility.errorUrls = urls || [];
    };
}
var jereiReceiver = {
    version: "2.1.0.6",
    hooks:[],
    plugins:[],    
    trackers : {},
    register: function(instanceName, plugin, apiObject){
        jereiReceiver.plugins.push({
            name:instanceName,
            template:plugin
        });
		jereiReceiver.addApis(apiObject);
    },
    addApis:function(apiObject){
		if (apiObject) {
			for (var p in apiObject) {
				if (isProperty(apiObject, p)) {
					Tracker.prototype[p] = apiObject[p];
				}
			}
		}
    },
	addHook:function(name, func){
        var hooks = jereiReceiver.hooks;
        name = lower(name);
		hooks[name] = hooks[name] || [];
		hooks[name].push(func);
	},
	execHook:function(name){
        var hook;
		if((hook = jereiReceiver.hooks[name])){
			for(var i = 0, len = hook.length; i < len; i++){
				var h = hook[i];
				h.apply(h, slice.call(arguments,1));
			}
		}
	},
    isTrackerExist:function(serviceID){
        return !!jereiReceiver.trackers[serviceID];
    },
    getTracker:function(serviceID){
        return jereiReceiver.trackers[serviceID] || (jereiReceiver.trackers[serviceID] = new Tracker(serviceID));
    },
    loadCallback: function(callbackName, checkInterval, retryCount){
        callbackName = callbackName || '_gsCallback';
        return utility.waitFor("window." + callbackName, function(target){
            target();
        }, checkInterval, retryCount);
    }
};
_Log = {
	trace: function(){
	},
	info: function(){
	},
	warnIf: function(){
	},
	errorIf: function(){
	}
};
    thisWin.jereiReceiver = jereiReceiver;
	thisWin._gsUtility = utility;    
    utility.resolveURL = utility.resolveUrl;
})();