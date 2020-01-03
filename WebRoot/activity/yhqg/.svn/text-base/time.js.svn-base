var timeIsOver = true;
function GetServerTime(nowTime, endTime){
    var NowTime = new Date(nowTime.replace(/-/g, "/"));
    var EndTime = new Date(endTime.replace(/-/g, "/"));
    var nMS = EndTime.getTime() - NowTime.getTime();
    var nD = Math.floor(nMS / (1000 * 60 * 60 * 24));
    var nH = Math.floor(nMS / (1000 * 60 * 60)) % 24;
    var nM = Math.floor(nMS / (1000 * 60)) % 60;
    var nS = Math.floor(nMS / 1000) % 60;
    var nMS = Math.floor(nMS / 100) % 10;
    if (nD >= 0) {
        var htm = nD + "天" + nH + "时" + nM + "分" + nS + "秒";
        jQuery(".tian").html(nD);
        jQuery(".xiaoshi").html(nH);
        jQuery(".fenzhong").html(nM);
        jQuery(".miao").html(nS);
    }
    else {
        timeIsOver = true;
    }
    EndTime = EndTime.AddSeconds(-1);
    endTime = EndTime.Format('yyyy/MM/dd HH:mm:ss');
    setTimeout("GetServerTime('" + nowTime + "','" + endTime + "')", 1000);
}

/*
 前言：
 Javascript的日期时间处理函数总时那么不尽人意。
 用惯了.Net日期时间对象，非常期望Javascript的日期时间对象Date也能提供诸如日期时间增减、格式化输出、日期时间比较及简单判断等相关功能。
 因此，为了实际项目开发中能使用此类功能，我为Javascript中的日期时间对象Date做了相关功能的扩展。
 只要在脚本中加载此扩展类，即可如.Net下的Date使用相关功能。（By:Sinsyne 2008-09-03）
 扩展函数功能列表：
 1、IsLeap           判断是否是闰年
 2、MonthDaysList    获得某一年度各月份最大天数集合
 3、YearDaysCount    获得某一年度总天数
 4、MonthDaysCount   获得某一年特定月的总天数
 5、Format           格式化输出日期时间数据
 6、AddDateTime      给指定日期时间增加或减少日期时间(年、月、日、小时、分、秒、毫秒)
 7、AddSeconds       给指定日期时间增加或减少秒
 8、AddMinutes       给指定日期时间增加或减少分钟
 9、AddHours         给指定日期时间增加或减少小时
 A、AddDays          给指定日期时间增加或减少天数
 B、AddMonths        给指定日期时间增加或减少月数
 C、AddYears         给指定日期时间增加或减少年数
 D、StringToDate     将日期字符串转化为日期
 E、Comparison       日期时间比较
 */
/*
 扩展：判断是否是闰年
 参数：无参数或传入一个参数(年度)
 返回：bool
 说明：无参数调用或单个参数非数值或由数值组成的字符串时，校验当前年度
 例子：1、Date.IsLeap():校验当前年；2、Date.IsLeep(2008):校验2008年
 */
Date.prototype.IsLeap = function(){
    var cYear = this.getFullYear();
    if (arguments.length > 0) {
        var str = arguments[0];
        if (str != null) {
            switch (typeof str) {
                case 'number':{
                    if (str > 0) {
                        cYear = str;
                    }
                    break;
                }
                case 'string':{
                    str = str.replace(/(^[\s　]*)|([\s　]*$)/g, '');
                    var regu = /^[-]{0,1}[0-9]{1,}$/;
                    if (regu.test(str)) {
                        cYear = parseInt(str);
                    }
                    break;
                }
            }
        }
    }
    var isLeap = (cYear % 4 == 0) ? ((cYear % 100 == 0) ? ((cYear % 400 == 0) ? true : false) : true) : false;
    return isLeap;
};

/*
 扩展：获得某一年度各月份最大天数集合
 参数：无参数或传入一个参数(年度)
 返回：Array
 调用：IsLeap():判断是否闰年
 说明：无参数调用或单个参数非数值或由数值组成的字符串时，获取当前年度
 例子：1、Date.MonthDaysList():当前年；2、Date.MonthDaysList(2008):2008年
 */
Date.prototype.MonthDaysList = function(){
    var cYear = this.getFullYear();
    if (arguments.length > 0) {
        var str = arguments[0];
        if (str != null) {
            switch (typeof str) {
                case 'number':{
                    if (str > 0) {
                        cYear = str;
                    }
                    break;
                }
                case 'string':{
                    str = str.replace(/(^[\s　]*)|([\s　]*$)/g, '');
                    var regu = /^[-]{0,1}[0-9]{1,}$/;
                    if (regu.test(str)) {
                        cYear = parseInt(str);
                    }
                    break;
                }
            }
        }
    }
    var dayAry = new Array();
    dayAry.push(31);
    var dc = (this.IsLeap(cYear)) ? 29 : 28;
    dayAry.push(dc);
    for (var k = 3; k < 8; k++) {
        dayAry.push(((k % 2 == 1) ? 31 : 30));
    }
    for (var k = 8; k <= 12; k++) {
        dayAry.push(((k % 2 == 0) ? 31 : 30));
    }
    return dayAry;
};

/*
 扩展：获得某一年度总天数
 参数：无参数或传入一个参数(年度)
 返回：Array
 调用：MonthDaysList():获得某一年度各月份最大天数集合
 说明：无参数调用或单个参数非数值或由数值组成的字符串时，获取当前年度
 例子：1、Date.YearDaysCount():当前年；2、Date.YearDaysCount(2008):2008年
 */
Date.prototype.YearDaysCount = function(){
    var cYear = this.getFullYear();
    if (arguments.length > 0) {
        var str = arguments[0];
        if (str != null) {
            switch (typeof str) {
                case 'number':{
                    if (str > 0) {
                        cYear = str;
                    }
                    break;
                }
                case 'string':{
                    str = str.replace(/(^[\s　]*)|([\s　]*$)/g, '');
                    var regu = /^[-]{0,1}[0-9]{1,}$/;
                    if (regu.test(str)) {
                        cYear = parseInt(str);
                    }
                    break;
                }
            }
        }
    }
    var dList = this.MonthDaysList(cYear);
    var dCount = 0;
    for (var k = 0; k < dList.length; k++) {
        dCount += dList[k];
        ;
    }
    return dCount;
};

/*
 扩展：获得某一年特定月的总天数
 参数：无参数或传入一个参数(月份)或两个参数(月份、年度)
 返回：Array
 调用：MonthDaysList():获得某一年度各月份最大天数集合
 说明：无参数调用或单个参数非数值或由数值组成的字符串时，获取当前年度
 例子：
 1、Date.MonthDaysCount():当前年度当前月；
 2、Date.MonthDaysCount(2):当前年度2月份；
 3、Date.MonthDaysCount(2,2008):2008年2月份；
 */
Date.prototype.MonthDaysCount = function(){
    var cYear = this.getFullYear();
    var cMonth = this.getMonth();
    if (arguments.length > 0) {
        var mstr = arguments[0];
        if (mstr != null) {
            switch (typeof mstr) {
                case 'number':{
                    if (mstr > 0) {
                        cMonth = mstr;
                    }
                    break;
                }
                case 'string':{
                    mstr = mstr.replace(/(^[\s　]*)|([\s　]*$)/g, '');
                    var regu = /^[-]{0,1}[0-9]{1,}$/;
                    if (regu.test(mstr)) {
                        cMonth = parseInt(mstr);
                    }
                    break;
                }
            }
        }
    }
    if (arguments.length > 1) {
        var ystr = arguments[1];
        if (ystr != null) {
            switch (typeof ystr) {
                case 'number':{
                    if (ystr > 0) {
                        cYear = ystr;
                    }
                    break;
                }
                case 'string':{
                    ystr = ystr.replace(/(^[\s　]*)|([\s　]*$)/g, '');
                    var regu = /^[-]{0,1}[0-9]{1,}$/;
                    if (regu.test(ystr)) {
                        cYear = parseInt(ystr);
                    }
                    break;
                }
            }
        }
    }
    cMonth = (cMonth > 12) ? 12 : cMonth;
    var dList = this.MonthDaysList(cYear);
    var dCount = dList[cMonth - 1];
    return dCount;
};

/*
 扩展：格式化输出日期时间数据
 参数：无参数或传入一个参数(输出格式)或两个参数(输出格式、日期时间)
 返回：string
 说明：无参数时按'y-M-d h:m:s'默认格式输出当前时间
 1、输出格式说明：y:年;M:月;d:日;h(H)小时;m:分钟;s:秒;n:毫秒
 例子：
 */
Date.prototype.Format = function(){
    var myF = '';//输出格式y-M-d h:m:s
    var myD = this; //输出的日期时间
    if (arguments.length > 0) {
        if (arguments[0] != null) {
            if (typeof arguments[0] == 'string') {
                myF = arguments[0];
            }
        }
    }
    if (arguments.length > 1) {
        if (arguments[1] != null) {
            if (typeof arguments[1] == 'object') {
                myD = arguments[1];
            }
        }
    }
    var dstr = '';
    try {
        var giYear = myD.getFullYear();
        var giMonth = myD.getMonth() + 1;
        var giDay = myD.getDate();
        var giHour = myD.getHours();
        var giMinute = myD.getMinutes();
        var giSecond = myD.getSeconds();
        var giMillisecond = myD.getMilliseconds();
        
        var gM = (giMonth < 10) ? ('0' + giMonth) : giMonth;
        var gD = (giDay < 10) ? ('0' + giDay) : giDay;
        var gH = (giHour < 10) ? ('0' + giHour) : giHour;
        var gm = (giMinute < 10) ? ('0' + giMinute) : giMinute;
        var gS = (giSecond < 10) ? ('0' + giSecond) : giSecond;
        var gN = (giMillisecond < 10) ? ('00' + giMillisecond) : ((giMillisecond < 100) ? ('0' + giMillisecond) : giMillisecond);
        
        if (myF == '') { //默认格式
            myF = 'yyyy-MM-dd';
            //      dstr = giYear+'-'+giMonth+'-'+giDay+' '+giHour+':'+giMinute+':'+giSecond;
        }
        //年
        var YAry = ['YYYY', 'YYYy', 'YYyY', 'YyYY', 'yYYY', 'YYyy', 'YyYy', 'YyyY', 'yYYy', 'yYyY', 'yyYY', 'Yyyy', 'yYyy', 'yyYy', 'yyyY', 'yyyy'];
        for (var yIdx = 0; yIdx < YAry.length; yIdx++) {
            myF = myF.replace(YAry[yIdx], giYear);
        }
        YAry = ['YYY', 'YYy', 'YyY', 'yYY', 'Yyy', 'yYy', 'yyY', 'yyy']
        for (var yIdx = 0; yIdx < YAry.length; yIdx++) {
            myF = myF.replace(YAry[yIdx], (giYear + '').substr(3, 4));
        }
        YAry = ['YY', 'Yy', 'yY', 'yy']
        for (var yIdx = 0; yIdx < YAry.length; yIdx++) {
            myF = myF.replace(YAry[yIdx], (giYear + '').substr(2, 4));
        }
        YAry = ['Y', 'y']
        for (var yIdx = 0; yIdx < YAry.length; yIdx++) {
            myF = myF.replace(YAry[yIdx], giYear);
        }
        //月
        myF = myF.replace('MM', gM);
        myF = myF.replace('M', giMonth);
        //日
        myF = myF.replace('DD', gD);
        myF = myF.replace('Dd', gD);
        myF = myF.replace('dD', gD);
        myF = myF.replace('dd', gD);
        myF = myF.replace('D', giDay);
        myF = myF.replace('d', giDay);
        //小时
        myF = myF.replace('HH', gH);
        myF = myF.replace('hH', gH);
        myF = myF.replace('Hh', gH);
        myF = myF.replace('hh', gH);
        myF = myF.replace('H', giHour);
        myF = myF.replace('h', giHour);
        //分钟
        myF = myF.replace('mm', gm);
        myF = myF.replace('m', giMinute);
        //秒
        myF = myF.replace('SS', gS);
        myF = myF.replace('Ss', gS);
        myF = myF.replace('sS', gS);
        myF = myF.replace('ss', gS);
        myF = myF.replace('S', giSecond);
        myF = myF.replace('s', giSecond);
        //毫秒
        myF = myF.replace('NN', gS);
        myF = myF.replace('Nn', gS);
        myF = myF.replace('nN', gS);
        myF = myF.replace('nn', gS);
        myF = myF.replace('N', giSecond);
        myF = myF.replace('n', giSecond);
        
        dstr = myF;
    } 
    catch (e) {
    }
    return dstr;
};

/*
 扩展：给指定日期时间增加或减少日期时间(年、月、日、小时、分、秒、毫秒)
 参数：无参数或传入两个参数(增减单位、增减秒数)或三个参数(增减单位、增减秒数、日期时间)
 返回：date
 说明：
 例子：
 */
Date.prototype.AddDateTime = function(){
    if (arguments.length < 2) {
        return this;
    }
    var AddFormat = 'd';
    if (arguments[0] != null) {
        if (typeof arguments[0] == 'string') {
            AddFormat = arguments[0];
            AddFormat = AddFormat.replace(/(^[\s　]*)|([\s　]*$)/g, '');
            AddFormat = AddFormat.toLowerCase();
        }
    }
    var AddNum = 0;
    if (arguments[1] != null) {
        if (typeof arguments[1] == 'number') {
            AddNum = arguments[1];
        }
    }
    if (AddNum == 0) {
        return this;
    }
    var myD = this;
    if (arguments.length > 2) {
        if (arguments[2] != null) {
            if (typeof arguments[2] == 'object') {
                myD = arguments[2];
            }
        }
    }
    try {
        var giYear = myD.getFullYear();
        var giMonth = myD.getMonth();
        var giDay = myD.getDate();
        var giHour = myD.getHours();
        var giMinute = myD.getMinutes();
        var giSecond = myD.getSeconds();
        var giMillisecond = myD.getMilliseconds();
        
        switch (AddFormat) {
            case 'millisecond':{
                giMillisecond += AddNum;
                break;
            }
            case 'second':{
                giSecond += AddNum;
                break;
            }
            case 'minute':{
                giMinute += AddNum;
                break;
            }
            case 'hour':{
                giHour += AddNum;
                break;
            }
            case 'day':{
                giDay += AddNum;
                break;
            }
            case 'month':{
                giMonth += AddNum;
                break;
            }
            case 'year':{
                giYear += AddNum;
                break;
            }
        }
        
        myD.setFullYear(giYear);
        myD.setMonth(giMonth);
        myD.setDate(giDay);
        myD.setHours(giHour);
        myD.setMinutes(giMinute);
        myD.setSeconds(giSecond);
        myD.setMilliseconds(giMillisecond);
    } 
    catch (e) {
    }
    
    return myD;
};

/*
 扩展：给指定日期时间增加或减少秒
 参数：无参数或传入一个参数(增减秒数)或两个参数(增减秒数、日期时间)
 返回：date
 说明：
 例子：
 */
Date.prototype.AddSeconds = function(){
    var myD = this;
    if (arguments.length > 1) {
        if (arguments[1] != null) {
            if (typeof arguments[1] == 'object') {
                myD = arguments[1];
            }
        }
    }
    var AddNum = 0;
    if (arguments.length > 0) {
        if (arguments[0] != null) {
            if (typeof arguments[0] == 'number') {
                AddNum = arguments[0];
            }
        }
    }
    if (AddNum == 0) {
        return this;
    }
    return this.AddDateTime('second', AddNum, myD);
};

/*
 扩展：给指定日期时间增加或减少分钟
 参数：无参数或传入一个参数(增减分钟)或两个参数(增减分钟、日期时间)
 返回：date
 说明：
 例子：
 */
Date.prototype.AddMinutes = function(){
    var myD = this;
    if (arguments.length > 1) {
        if (arguments[1] != null) {
            if (typeof arguments[1] == 'object') {
                myD = arguments[1];
            }
        }
    }
    var AddNum = 0;
    if (arguments.length > 0) {
        if (arguments[0] != null) {
            if (typeof arguments[0] == 'number') {
                AddNum = arguments[0];
            }
        }
    }
    if (AddNum == 0) {
        return this;
    }
    return this.AddDateTime('minute', AddNum, myD);
};

/*
 扩展：给指定日期时间增加或减少小时
 参数：无参数或传入一个参数(增减小时)或两个参数(增减小时、日期时间)
 返回：date
 说明：
 例子：
 */
Date.prototype.AddHours = function(){
    var myD = this;
    if (arguments.length > 1) {
        if (arguments[1] != null) {
            if (typeof arguments[1] == 'object') {
                myD = arguments[1];
            }
        }
    }
    var AddNum = 0;
    if (arguments.length > 0) {
        if (arguments[0] != null) {
            if (typeof arguments[0] == 'number') {
                AddNum = arguments[0];
            }
        }
    }
    if (AddNum == 0) {
        return this;
    }
    return this.AddDateTime('hour', AddNum, myD);
};

/*
 扩展：给指定日期时间增加或减少天数
 参数：无参数或传入一个参数(增减天数)或两个参数(增减天数、日期时间)
 返回：date
 说明：
 例子：
 */
Date.prototype.AddDays = function(){
    var myD = this;
    if (arguments.length > 1) {
        if (arguments[1] != null) {
            if (typeof arguments[1] == 'object') {
                myD = arguments[1];
            }
        }
    }
    var AddNum = 0;
    if (arguments.length > 0) {
        if (arguments[0] != null) {
            if (typeof arguments[0] == 'number') {
                AddNum = arguments[0];
            }
        }
    }
    if (AddNum == 0) {
        return this;
    }
    return this.AddDateTime('day', AddNum, myD);
};

/*
 扩展：给指定日期时间增加或减少月数
 参数：无参数或传入一个参数(增减月数)或两个参数(增减月数、日期时间)
 返回：date
 说明：
 例子：
 */
Date.prototype.AddMonths = function(){
    var myD = this;
    if (arguments.length > 1) {
        if (arguments[1] != null) {
            if (typeof arguments[1] == 'object') {
                myD = arguments[1];
            }
        }
    }
    var AddNum = 0;
    if (arguments.length > 0) {
        if (arguments[0] != null) {
            if (typeof arguments[0] == 'number') {
                AddNum = arguments[0];
            }
        }
    }
    if (AddNum == 0) {
        return this;
    }
    return this.AddDateTime('month', AddNum, myD);
};

/*
 扩展：给指定日期时间增加或减少年数
 参数：无参数或传入一个参数(增减年数)或两个参数(增减年数、日期时间)
 返回：date
 说明：
 例子：
 */
Date.prototype.AddYears = function(){
    var myD = this;
    if (arguments.length > 1) {
        if (arguments[1] != null) {
            if (typeof arguments[1] == 'object') {
                myD = arguments[1];
            }
        }
    }
    var AddNum = 0;
    if (arguments.length > 0) {
        if (arguments[0] != null) {
            if (typeof arguments[0] == 'number') {
                AddNum = arguments[0];
            }
        }
    }
    if (AddNum == 0) {
        return this;
    }
    return this.AddDateTime('year', AddNum, myD);
};

/*
 扩展：将日期字符串转化为日期
 参数：传入一个参数(日期字符)如：'2008-09-01'
 返回：date
 说明：
 例子：
 */
Date.prototype.StringToDate = function(str){
    try {
        var r = str.match(/^(\d{1,4})(-|\/)(\d{1,2})\2(\d{1,2})$/);
        if (r == null) 
            return false;
        var d = new Date(r[1], r[3] - 1, r[4]);
        alert(d.Format());
        return d;
    } 
    catch (e) {
        return null;
    }
};

/*
 扩展：日期时间比较
 参数：传入两个参数(日期时间1、日期时间2)
 返回：bool
 说明：
 例子：
 */
Date.prototype.Comparison = function(d1, d2){
    var rV = false;
    try {
        rV = (d1.valueOf() > d2.valueOf())
    } 
    catch (e) {
    }
    alert((d1.valueOf() > d2.valueOf()) + String.fromCharCode(13) + d1.Format() + String.fromCharCode(13) + d2.Format());
    return rV;
};
