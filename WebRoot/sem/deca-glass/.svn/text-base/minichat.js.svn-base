//2013-6-8
TQKF.miniChat = {
	DOM: null,
	Container: null,
	isClosed: false,
	isAppended: false,
	heartBeatTimer: null,
	pos: {
		t: "c",
		l: "c"
	},
	CreatDOM: function() {
		this.DOM = document.createElement("div");
		this.DOM.id = "tq_miniChatDiv";
		this.DOM.style.visibility = "hidden";
		this.DOM.style.display = "none";
		this.DOM.style.border = "0px solid #EAEAEA";
		this.DOM.style.position = "absolute";
		if (TQUtils.isSupportFixedPos) {
			this.DOM.style.position = "fixed"
		}
		this.DOM.style.width = "381px";
		this.DOM.style.height = "264px";
		if (tq_version == "" || parseInt(tq_version) < parseInt(TQKF.version)) {
			if (tq_invit_style != "1") {
				this.pos.t = "b";
				this.pos.l = "r"
			}
		} else {
			this.pos.t = TQKF.inviter.userCfg.bg.t;
			this.pos.l = TQKF.inviter.userCfg.bg.l
		}
		this.DOM.style.zIndex = "99998";
		this.DOM.style.cursor = "move";
		this.Container = document.createElement("div");
		this.Container.id = "tq_miniChatDivContainer";
		this.Container.style.visibility = "visible";
		this.Container.style.display = "";
		this.Container.style.border = "0px solid #EAEAEA";
		this.Container.style.background = "url(" + TQKF.invite_image_url + "mini_bg_c" + tq_invit_color + ".png) no-repeat scroll 0% 0%";
		this.Container.style.width = "100%";
		this.Container.style.height = "100%";
		this.Container.style.zIndex = "99999";
		this.Container.style.cursor = "move";
		var tempHTML = "";
		tempHTML += ('<div style="border: 0px none;position: absolute;left:30px; top:9px;width: 300px; height: 20px;text-align:left;line-height:15px;font-size:12px;color:#000000;filter:Dropshadow(offx=1,offy=0,color=white)Dropshadow(offx=0,offy=1,color=white)Dropshadow(offx=0,offy=-1,color=white)Dropshadow(offx=-1,offy=0,color=white);">' + tq_invit_title + '</div>');
		tempHTML += ('<div style="border: 0px none;position: absolute;left:10px; top:25px;width: 361px; height: 230px;">');
		if (TQKF.inviter.response_type == 1) tempHTML += ('<iframe frameborder="0" id=\'tq_miniChatIframe\' name="tq_miniChatIframe" width=100% height=100% src=' + TQKF.CreatURL(TQKF.webchat_url2, "acd&pagetype=mini", "", tq_invit_response_uins[0].m[0].id, "minichat") + ' allowtransparency="true" scrolling=no ></iframe>');
		else tempHTML += ('<iframe frameborder="0" id=\'tq_miniChatIframe\' name="tq_miniChatIframe" width=100% height=100% src=' + TQKF.CreatURL(TQKF.webchat_url2, "chat&pagetype=mini", tq_appuin, "", "minichat") + ' allowtransparency="true" scrolling=no ></iframe>');
		tempHTML += ('</div>');
		tempHTML += ('<div title="' + TQKF.words[8] + '" onmouseover="TQKF.miniChat.CannotMove()" onmouseout="TQKF.miniChat.CanMove()" style="background-image:url(' + TQKF.invite_image_url + 'min.gif);background-repeat:no-repeat;cursor:pointer;position: absolute; width: 12px; height: 11px;; left: 315px; top: 8px" onclick="TQKF.miniChat.Mini()"></div>');
		tempHTML += ('<div title="' + TQKF.words[7] + '" onmouseover="TQKF.miniChat.CannotMove()" onmouseout="TQKF.miniChat.CanMove()" style="background-image:url(' + TQKF.invite_image_url + 'max.gif);background-repeat:no-repeat;cursor:pointer;position: absolute; width: 12px; height: 11px;; left: 335px; top: 8px" onclick="TQKF.miniChat.Max()"></div>');
		tempHTML += ('<div title="' + TQKF.words[1] + '" onmouseover="TQKF.miniChat.CannotMove()" onmouseout="TQKF.miniChat.CanMove()" style="background-image:url(' + TQKF.invite_image_url + 'close.gif);background-repeat:no-repeat;cursor:pointer;position: absolute; width: 12px; height: 11px;; left: 355px; top: 8px" onclick="TQKF.miniChat.Close()"></div>');
		this.Container.innerHTML = tempHTML;
		this.DOM.appendChild(this.Container)
	},
	AppendDOM: function() {
		document.body.appendChild(this.DOM)
	},
	Mini: function() {
		this.Hide();
		TQKF.miniChatMini.Show()
	},
	Max: function() {
		TQKF.OpenWindow(TQKF.CreatURL(TQKF.webchat_url + "/sendmain.jsp", "chat&pagetype=frommini", tq_appuin, "", "minichat"), tq_appuin);
		try {
			TQKF.miniChatMini.StopGetIsNewMsg();
			this.Hide();
			this.isClosed = true;
			TQKF.miniChatMini.Hide();
			TQKF.inviter.HidePageLocker()
		} catch(e) {}
	},
	Close: function() {
		if (confirm(TQKF.words[11])) {
			TQKF.miniChatMini.StopGetIsNewMsg();
			this.Go();
			this.Hide();
			this.isClosed = true;
			TQKF.miniChatMini.Hide();
			TQKF.inviter.HidePageLocker()
		}
	},
	CannotMove: function() {
		TQUtils.Drag.canDrag = false
	},
	CanMove: function() {
		TQUtils.Drag.canDrag = true
	},
	Go: function() {
		tq_miniChatIframe.location = TQKF.webchat_url + "/close.jsp?uin=" + tq_appuin + "&pagetype=mini&nocache=" + Math.random()
	},
	Hide: function() {
		this.isClosed = true;
		this.DOM.style.display = "none";
		this.DOM.style.visibility = "hidden"
	},
	Show: function() {
		TQKF.miniChat.DOM.style.display = "";
		TQKF.miniChat.DOM.style.visibility = "visible";
		TQKF.miniChat.isClosed = false
	},
	GetMaxDragX: function() {
		return TQUtils.GetWinSize().w - parseInt(TQKF.miniChat.DOM.style.width) - 1
	},
	GetMaxDragY: function() {
		return TQUtils.GetWinSize().h - parseInt(TQKF.miniChat.DOM.style.height) - 1
	},
	SetPos: function() {
		if (TQKF.miniChat.isClosed == true) return;
		var o = TQKF.miniChat.DOM;
		var t = TQKF.miniChat.pos.t;
		var l = TQKF.miniChat.pos.l;
		if (TQUtils.isSupportFixedPos) {
			o.style.position = 'fixed';
			if (t == "t") o.style.top = "0px";
			else if (t == "b") o.style.bottom = "0px";
			else o.style.top = parseInt((TQUtils.GetWinSize().h - o.offsetHeight) / 2) + "px";
			if (l == "l") o.style.left = "0px";
			else if (l == "r") o.style.right = "0px";
			else o.style.left = parseInt((TQUtils.GetWinSize().w - o.offsetWidth) / 2) + "px"
		} else {
			TQKF.miniChat.fixPos()
		}
	},
	fixPos: function() {
		if (TQKF.miniChat.isClosed == true) return;
		var o = TQKF.miniChat.DOM;
		var t = TQKF.miniChat.pos.t;
		var l = TQKF.miniChat.pos.l;
		if (t == "t") o.style.top = TQUtils.GetScrollTop() + 'px';
		else if (t == "b") {
			o.style.top = TQUtils.GetScrollTop() + TQUtils.GetWinSize().h - o.offsetHeight + 'px'
		} else {
			o.style.top = TQUtils.GetScrollTop() + parseInt((TQUtils.GetWinSize().h - o.offsetHeight) / 2) + "px"
		}
		if (l == "l") o.style.left = TQUtils.GetScrollLeft() + 'px';
		else if (l == "r") {
			o.style.left = TQUtils.GetScrollLeft() + TQUtils.GetWinSize().w - o.offsetWidth + "px"
		} else o.style.left = TQUtils.GetScrollLeft() + parseInt((TQUtils.GetWinSize().w - o.offsetWidth) / 2) + "px"
	}
};
TQKF.miniChatMini = {
	DOM: null,
	ICO: null,
	getIsNewMsgTimer: null,
	getIsNewMsgIntever: 15000,
	isHeartBeatting: false,
	isClosed: false,
	heartBeatTimer: null,
	CreatDOM: function() {
		this.DOM = document.createElement("div");
		this.DOM.id = "tq_miniChatMiniDiv";
		this.DOM.style.visibility = "hidden";
		this.DOM.style.display = "none";
		this.DOM.style.border = "0px solid #EAEAEA";
		this.DOM.style.position = "absolute";
		this.DOM.style.width = "41px";
		this.DOM.style.height = "73px";
		this.DOM.style.left = TQUtils.GetWinSize().w - parseInt(TQKF.miniChatMini.DOM.style.width) - 5 + "px";
		this.DOM.style.top = TQUtils.GetWinSize().h - parseInt(TQKF.miniChatMini.DOM.style.height) - 5 + "px";
		this.DOM.style.zIndex = "99997";
		this.DOM.onclick = function() {
			TQKF.miniChatMini.Max()
		};
		this.ICO = document.createElement("img");
		this.ICO.id = "tq_miniIco";
		this.ICO.border = "0px";
		this.ICO.src = TQKF.invite_image_url + 'monk.gif';
		this.DOM.appendChild(this.ICO)
	},
	AppendDOM: function() {
		document.body.appendChild(this.DOM)
	},
	Hide: function() {
		this.isClosed = true;
		this.DOM.style.display = "none";
		this.DOM.style.visibility = "hidden";
		this.StopGetIsNewMsg()
	},
	Show: function() {
		this.isClosed = false;
		this.DOM.style.display = "";
		this.DOM.style.visibility = "visible";
		this.SendMiniedCommand();
		setTimeout(TQKF.miniChatMini.StartGetIsNewMsg, 2000);
		if (! (this.isHeartBeatting)) {
			TQUtils.HeartBeat(TQKF.miniChatMini.DOM, 20, TQKF.miniChatMini.heartBeatTimer, {
				x: 0,
				y: 0
			},
			(!TQKF.miniChatMini.isClosed));
			this.isHeartBeatting = true
		}
	},
	Max: function() {
		this.Hide();
		TQKF.miniChat.Show();
		this.StopGetIsNewMsg();
		setTimeout(TQKF.miniChatMini.SendMiniOverCommand, 2000)
	},
	Close: function() {
		TQKF.miniChat.Close()
	},
	SendMiniedCommand: function() {
		TQUtils.LoadJS(TQKF.webchat_url + "/mini.jsp?uin=" + tq_appuin + "&nocache=" + Math.random(), false)
	},
	SendMiniOverCommand: function() {
		TQUtils.LoadJS(TQKF.webchat_url + "/miniover.jsp?uin=" + tq_appuin + "&nocache=" + Math.random(), false)
	},
	StartGetIsNewMsg: function() {
		TQKF.miniChatMini.getIsNewMsgTimer = setTimeout(TQKF.miniChatMini.StartGetIsNewMsg, TQKF.getIsNewMsgIntever);
		TQUtils.LoadJSAndAutoRemoveSelf("TQGetIsNewMsg_JS", TQKF.webchat_url + "/getisnewmsg.jsp?uin=" + tq_appuin + "&nocache=" + Math.random())
	},
	StopGetIsNewMsg: function() {
		if (this.getIsNewMsgTimer != null) window.clearTimeout(this.getIsNewMsgTimer);
		this.ICO.src = TQKF.invite_image_url + 'monk.gif'
	},
	NewMsg: function() {
		this.ICO.src = TQKF.invite_image_url + 'newmsg.gif'
	},
	ResetPos: function() {
		try {
			TQKF.miniChatMini.DOM.style.top = TQUtils.GetScrollTop() + TQUtils.GetWinSize().h - parseInt(TQKF.miniChatMini.DOM.style.height) - 5 + "px";
			TQKF.miniChatMini.DOM.style.left = TQUtils.GetScrollLeft() + TQUtils.GetWinSize().w - parseInt(TQKF.miniChatMini.DOM.style.width) - 3 + "px"
		} catch(e) {}
	}
};
TQKF.miniChat.CreatDOM();
TQKF.miniChatMini.CreatDOM();
setTimeout(function() {
	try {
		TQKF.inviter.Close()
	} catch(e) {}
	TQKF.miniChat.AppendDOM();
	TQKF.miniChatMini.AppendDOM();
	if ((TQKF.miniChat.pos.t == "c" || TQKF.miniChat.pos.l == "c")) {
		TQUtils.AddEvent(window, "resize", TQKF.miniChat.SetPos)
	}
	if (!TQUtils.isSupportFixedPos) {
		TQUtils.AddEvent(window, "scroll", TQKF.miniChat.fixPos);
		TQUtils.AddEvent(window, "resize", TQKF.miniChat.fixPos)
	}
	TQ_DEBUG("http://sysimages.tq.cn/js/vip/100501/TQUtils.Drag.init", 3);
	TQUtils.Drag.init(TQKF.miniChat.DOM, null, null, null, null, null, (TQKF.inviter.userCfg.bg.l == "r" && TQUtils.isSupportFixedPos) ? true: false, (TQKF.inviter.userCfg.bg.t == "b" && TQUtils.isSupportFixedPos) ? true: false);
	TQKF.miniChat.Show();
	TQKF.miniChat.SetPos();
	if (tq_is_mask == 1) TQKF.inviter.ShowPageLocker();
	TQUtils.AddEvent(window, "resize", TQKF.miniChatMini.ResetPos)
},
200);