//2013-6-7
if (tq_invit_title == "") {
    if (tq_displaytype == "100" || tq_displaytype == "10") {
        tq_invit_title = TQKF.words[18]
    } else {
        tq_invit_title = TQKF.words[2]
    }
    if (typeof(TQKF.isAgent) != "undefined" && TQKF.isAgent == 1) tq_invit_title = ""
}
if (tq_welcome_msg == "") tq_welcome_msg = TQKF.words[4];
if (tq_global_invite_words == "") tq_global_invite_words = TQKF.words[4];
TQUtils.SetValueIfUndefinedOrEmpty("tq_is_parse_ip", 0);
TQUtils.SetValueIfUndefinedOrEmpty("tq_is_mask", 0);
TQUtils.SetValueIfUndefinedOrEmpty("tq_not_reshow", 0);
TQUtils.SetValueIfUndefinedOrEmpty("tq_type", "1");
TQUtils.SetValueIfUndefinedOrEmpty("tq_invit_style", "1");
TQUtils.SetValueIfUndefinedOrEmpty("tq_displaytype", "1");
TQUtils.SetValueIfUndefinedOrEmpty("tq_invit_color", "1");
var tq_appuin = "";
TQKF.inviter = {
    chat_url: "",
    allKefuIsOffLine: true,
    isStopGetJS: false,
    hasInited: false,
    isAntiKaKa: true,
    autiTimer: null,
    heartBeat1Timer: null,
    sendOnlinemsgTimer: null,
    isHeartBeatting: false,
    getAppUinTimer: null,
    hide2Timer: null,
    show2Timer: null,
    autoReshowTimer: null,
    isClosed: false,
    comflag: Math.floor(Math.random() * 1000000) + "" + Math.floor(Math.random() * 1000000) + "" + Math.floor(Math.random() * 100000),
    DOM: null,
    DOMinnerHTML: null,
    pageLocker: null,
    isgetappwords: 0,
    isAutoInvit: 0,
    isSendAutoInvitPara: 0,
    showTimes: 0,
    left: 320,
    top: 200,
    h: 0,
    w: 0,
    lastScrollX: 0,
    lastScrollY: 0,
    t: tq_invit_style,
    s: tq_displaytype,
    c: tq_invit_color,
    isInvited: false,
    isflux: 0,
    response_type: 0,
    online_msg_success: 0,
    refuse_msg_inqueue: 0,
    GetResponseType: function() {
        var t = 0;
        if (!TQUtils.IsUndefined("tq_invit_response_uins") && tq_invit_response_uins != "" && tq_invit_response_uins[0] && tq_invit_response_uins[0].m && tq_invit_response_uins[0].m[0] && tq_invit_response_uins[0].m[0].t == "tactic") {
            t = 1
        } else t = 0;
        return t
    },
    invit_layout_cfg: new Object(),
    userCfg: null,
    DefaultCfg: {
        t1: {
            s0: {
                bg_ext: "png",
                btn_ext: "png",
                bg: {
                    t: "c",
                    l: "c",
                    h: 144,
                    w: 402,
                    img: "",
                    effect: ""
                },
                title: {
                    t: 7,
                    l: 31,
                    h: 17,
                    w: 345,
                    disp: 1
                },
                close: {
                    t: 4,
                    l: 378,
                    h: 19,
                    w: 19
                },
                words: {
                    t: 35,
                    l: 118,
                    h: 65,
                    w: 280
                },
                accept: {
                    t: 110,
                    l: 238,
                    h: 25,
                    w: 81,
                    img: "",
                    disp: 1
                },
                message: {
                    t: 110,
                    l: 238,
                    h: 25,
                    w: 81,
                    img: "",
                    disp: 1
                },
                call: {
                    t: 110,
                    l: 158,
                    h: 25,
                    w: 81,
                    img: "",
                    disp: 1
                },
                refuse: {
                    t: 110,
                    l: 318,
                    h: 25,
                    w: 81,
                    img: "",
                    disp: 1
                }
            },
            s1: {
                bg_ext: "gif",
                btn_ext: "gif",
                bg: {
                    t: "c",
                    l: "c",
                    h: 190,
                    w: 385,
                    img: "",
                    effect: ""
                },
                title: {
                    t: 10,
                    l: 31,
                    h: 17,
                    w: 320,
                    disp: 1
                },
                close: {
                    t: 7,
                    l: 358,
                    h: 19,
                    w: 19
                },
                words: {
                    t: 40,
                    l: 107,
                    h: 100,
                    w: 260
                },
                accept: {
                    t: 150,
                    l: 180,
                    h: 23,
                    w: 81,
                    img: "",
                    disp: 1
                },
                message: {
                    t: 150,
                    l: 180,
                    h: 23,
                    w: 81,
                    img: "",
                    disp: 1
                },
                call: {
                    t: 150,
                    l: 280,
                    h: 23,
                    w: 81,
                    img: "",
                    disp: 1
                },
                refuse: {
                    t: 150,
                    l: 380,
                    h: 23,
                    w: 81,
                    img: "",
                    disp: 0
                }
            },
            s2: {
                bg_ext: "png",
                btn_ext: "gif",
                bg: {
                    t: "c",
                    l: "c",
                    h: 190,
                    w: 411,
                    img: "",
                    effect: ""
                },
                title: {
                    t: 10,
                    l: 31,
                    h: 17,
                    w: 345,
                    disp: 1
                },
                close: {
                    t: 6,
                    l: 383,
                    h: 19,
                    w: 19
                },
                words: {
                    t: 40,
                    l: 122,
                    h: 110,
                    w: 280
                },
                accept: {
                    t: 155,
                    l: 150,
                    h: 23,
                    w: 80,
                    img: "",
                    disp: 1
                },
                message: {
                    t: 155,
                    l: 150,
                    h: 23,
                    w: 80,
                    img: "",
                    disp: 1
                },
                call: {
                    t: 155,
                    l: 235,
                    h: 23,
                    w: 80,
                    img: "",
                    disp: 1
                },
                refuse: {
                    t: 155,
                    l: 320,
                    h: 23,
                    w: 80,
                    img: "",
                    disp: 1
                }
            },
            s3: {
                bg_ext: "png",
                btn_ext: "gif",
                bg: {
                    t: "c",
                    l: "c",
                    h: 142,
                    w: 399,
                    img: "",
                    effect: ""
                },
                title: {
                    t: 17,
                    l: 39,
                    h: 17,
                    w: 325,
                    disp: 1
                },
                close: {
                    t: 14,
                    l: 365,
                    h: 19,
                    w: 19
                },
                words: {
                    t: 48,
                    l: 125,
                    h: 40,
                    w: 250
                },
                accept: {
                    t: 97,
                    l: 125,
                    h: 24,
                    w: 71,
                    img: "",
                    disp: 1
                },
                message: {
                    t: 97,
                    l: 125,
                    h: 24,
                    w: 71,
                    img: "",
                    disp: 1
                },
                call: {
                    t: 97,
                    l: 210,
                    h: 24,
                    w: 71,
                    img: "",
                    disp: 1
                },
                refuse: {
                    t: 97,
                    l: 295,
                    h: 24,
                    w: 71,
                    img: "",
                    disp: 1
                }
            },
            s4: {
                bg_ext: "png",
                btn_ext: "gif",
                bg: {
                    t: "c",
                    l: "c",
                    h: 142,
                    w: 399,
                    img: "",
                    effect: ""
                },
                title: {
                    t: 17,
                    l: 39,
                    h: 17,
                    w: 325,
                    disp: 1
                },
                close: {
                    t: 14,
                    l: 365,
                    h: 19,
                    w: 19
                },
                words: {
                    t: 48,
                    l: 125,
                    h: 40,
                    w: 250
                },
                accept: {
                    t: 97,
                    l: 125,
                    h: 24,
                    w: 71,
                    img: "",
                    disp: 1
                },
                message: {
                    t: 97,
                    l: 125,
                    h: 24,
                    w: 71,
                    img: "",
                    disp: 1
                },
                call: {
                    t: 97,
                    l: 210,
                    h: 24,
                    w: 71,
                    img: "",
                    disp: 1
                },
                refuse: {
                    t: 97,
                    l: 295,
                    h: 24,
                    w: 71,
                    img: "",
                    disp: 1
                }
            },
            s5: {
                bg_ext: "png",
                btn_ext: "gif",
                bg: {
                    t: "c",
                    l: "c",
                    h: 142,
                    w: 399,
                    img: "",
                    effect: ""
                },
                title: {
                    t: 17,
                    l: 39,
                    h: 17,
                    w: 325,
                    disp: 1
                },
                close: {
                    t: 14,
                    l: 365,
                    h: 19,
                    w: 19
                },
                words: {
                    t: 48,
                    l: 125,
                    h: 40,
                    w: 250
                },
                accept: {
                    t: 97,
                    l: 125,
                    h: 24,
                    w: 71,
                    img: "",
                    disp: 1
                },
                message: {
                    t: 97,
                    l: 125,
                    h: 24,
                    w: 71,
                    img: "",
                    disp: 1
                },
                call: {
                    t: 97,
                    l: 210,
                    h: 24,
                    w: 71,
                    img: "",
                    disp: 1
                },
                refuse: {
                    t: 97,
                    l: 295,
                    h: 24,
                    w: 71,
                    img: "",
                    disp: 1
                }
            },
            s6: {
                bg_ext: "png",
                btn_ext: "gif",
                bg: {
                    t: "c",
                    l: "c",
                    h: 128,
                    w: 390,
                    img: "",
                    effect: ""
                },
                title: {
                    t: 10,
                    l: 35,
                    h: 17,
                    w: 325,
                    disp: 1
                },
                close: {
                    t: 7,
                    l: 365,
                    h: 19,
                    w: 19
                },
                words: {
                    t: 43,
                    l: 125,
                    h: 47,
                    w: 250
                },
                accept: {
                    t: 97,
                    l: 125,
                    h: 24,
                    w: 71,
                    img: "",
                    disp: 1
                },
                message: {
                    t: 97,
                    l: 125,
                    h: 24,
                    w: 71,
                    img: "",
                    disp: 1
                },
                call: {
                    t: 97,
                    l: 210,
                    h: 24,
                    w: 71,
                    img: "",
                    disp: 1
                },
                refuse: {
                    t: 97,
                    l: 295,
                    h: 24,
                    w: 71,
                    img: "",
                    disp: 1
                }
            },
            s7: {
                bg_ext: "png",
                btn_ext: "png",
                bg: {
                    t: "c",
                    l: "c",
                    h: 309,
                    w: 352,
                    img: "",
                    effect: ""
                },
                title: {
                    t: -20,
                    l: 35,
                    h: 17,
                    w: 325,
                    disp: 0
                },
                close: {
                    t: 155,
                    l: 257,
                    h: 19,
                    w: 19
                },
                words: {
                    t: 30,
                    l: 165,
                    h: 100,
                    w: 157
                },
                accept: {
                    t: 243,
                    l: 107,
                    h: 37,
                    w: 84,
                    img: "",
                    disp: 1
                },
                message: {
                    t: 243,
                    l: 107,
                    h: 37,
                    w: 84,
                    img: "",
                    disp: 1
                },
                call: {
                    t: 184,
                    l: 34,
                    h: 69,
                    w: 61,
                    img: "",
                    disp: 1
                },
                refuse: {
                    t: 180,
                    l: 205,
                    h: 78,
                    w: 54,
                    img: "",
                    disp: 1
                }
            },
            s8: {
                bg_ext: "png",
                btn_ext: "gif",
                bg: {
                    t: "c",
                    l: "c",
                    h: 193,
                    w: 391,
                    img: "",
                    effect: ""
                },
                title: {
                    t: 8,
                    l: 60,
                    h: 17,
                    w: 265,
                    disp: 1
                },
                close: {
                    t: 5,
                    l: 332,
                    h: 19,
                    w: 19
                },
                words: {
                    t: 43,
                    l: 115,
                    h: 100,
                    w: 240
                },
                accept: {
                    t: 150,
                    l: 115,
                    h: 24,
                    w: 71,
                    img: "",
                    disp: 1
                },
                message: {
                    t: 150,
                    l: 115,
                    h: 24,
                    w: 71,
                    img: "",
                    disp: 1
                },
                call: {
                    t: 150,
                    l: 200,
                    h: 24,
                    w: 71,
                    img: "",
                    disp: 1
                },
                refuse: {
                    t: 150,
                    l: 285,
                    h: 24,
                    w: 71,
                    img: "",
                    disp: 1
                }
            },
            s9: {
                bg_ext: "png",
                btn_ext: "gif",
                bg: {
                    t: "c",
                    l: "c",
                    h: 164,
                    w: 436,
                    img: "",
                    effect: ""
                },
                title: {
                    t: 17,
                    l: 124,
                    h: 17,
                    w: 252,
                    disp: 1
                },
                close: {
                    t: 67,
                    l: 404,
                    h: 19,
                    w: 19
                },
                words: {
                    t: 43,
                    l: 120,
                    h: 70,
                    w: 245
                },
                accept: {
                    t: 120,
                    l: 120,
                    h: 24,
                    w: 71,
                    img: "",
                    disp: 1
                },
                message: {
                    t: 120,
                    l: 120,
                    h: 24,
                    w: 71,
                    img: "",
                    disp: 1
                },
                call: {
                    t: 120,
                    l: 205,
                    h: 24,
                    w: 71,
                    img: "",
                    disp: 1
                },
                refuse: {
                    t: 120,
                    l: 290,
                    h: 24,
                    w: 71,
                    img: "",
                    disp: 1
                }
            },
            s10: {
                bg_ext: "gif",
                btn_ext: "gif",
                bg: {
                    t: "b",
                    l: "r",
                    h: 130,
                    w: 200,
                    img: "",
                    effect: "slideH"
                },
                title: {
                    t: 6,
                    l: 24,
                    h: 15,
                    w: 146,
                    disp: 1
                },
                close: {
                    t: 3,
                    l: 177,
                    h: 19,
                    w: 19
                },
                words: {
                    t: 30,
                    l: 75,
                    h: 70,
                    w: 120
                },
                accept: {
                    t: 102,
                    l: 120,
                    h: 20,
                    w: 66,
                    img: "",
                    disp: 1
                },
                message: {
                    t: 102,
                    l: 120,
                    h: 20,
                    w: 66,
                    img: "",
                    disp: 1
                },
                call: {
                    t: 0,
                    l: 120,
                    h: 20,
                    w: 66,
                    img: "",
                    disp: 0
                },
                refuse: {
                    t: 0,
                    l: 120,
                    h: 20,
                    w: 66,
                    img: "",
                    disp: 0
                }
            },
            s100: {
                bg_ext: "png",
                btn_ext: "png",
                bg: {
                    t: "b",
                    l: "r",
                    h: 133,
                    w: 202,
                    img: "",
                    effect: "slideH"
                },
                title: {
                    t: 6,
                    l: 24,
                    h: 15,
                    w: 146,
                    disp: 1
                },
                close: {
                    t: 3,
                    l: 177,
                    h: 19,
                    w: 19
                },
                words: {
                    t: 30,
                    l: 75,
                    h: 70,
                    w: 120
                },
                accept: {
                    t: 108,
                    l: 130,
                    h: 19,
                    w: 60,
                    img: "",
                    disp: 1
                },
                message: {
                    t: 108,
                    l: 130,
                    h: 19,
                    w: 60,
                    img: "",
                    disp: 1
                },
                call: {
                    t: 0,
                    l: 120,
                    h: 19,
                    w: 60,
                    img: "",
                    disp: 0
                },
                refuse: {
                    t: 0,
                    l: 120,
                    h: 19,
                    w: 60,
                    img: "",
                    disp: 0
                }
            },
            s101: {
                bg_ext: "gif",
                btn_ext: "gif",
                bg: {
                    t: "c",
                    l: "c",
                    h: 207,
                    w: 415,
                    img: "",
                    effect: ""
                },
                title: {
                    t: 8,
                    l: 16,
                    h: 15,
                    w: 360,
                    disp: 1
                },
                close: {
                    t: 4,
                    l: 387,
                    h: 20,
                    w: 20
                },
                words: {
                    t: 45,
                    l: 145,
                    h: 120,
                    w: 253
                },
                kefu: {
                    disp: 0
                },
                accept: {
                    t: 165,
                    l: 178,
                    h: 26,
                    w: 82,
                    img: "",
                    disp: 1
                },
                message: {
                    t: 165,
                    l: 178,
                    h: 26,
                    w: 82,
                    img: "",
                    disp: 1
                },
                call: {
                    t: 165,
                    l: 178,
                    h: 26,
                    w: 82,
                    img: "",
                    disp: 0
                },
                refuse: {
                    t: 165,
                    l: 288,
                    h: 26,
                    w: 82,
                    img: "",
                    disp: 1
                }
            },
            s102: {
                bg_ext: "gif",
                btn_ext: "gif",
                bg: {
                    t: "c",
                    l: "c",
                    h: 238,
                    w: 517,
                    img: "",
                    effect: ""
                },
                title: {
                    t: 9,
                    l: 26,
                    h: 15,
                    w: 450,
                    disp: 1
                },
                close: {
                    t: 7,
                    l: 481,
                    h: 20,
                    w: 20
                },
                words: {
                    t: 46,
                    l: 214,
                    h: 135,
                    w: 280
                },
                kefu: {
                    disp: 0
                },
                accept: {
                    t: 195,
                    l: 303,
                    h: 24,
                    w: 83,
                    img: "",
                    disp: 1
                },
                message: {
                    t: 195,
                    l: 303,
                    h: 24,
                    w: 83,
                    img: "",
                    disp: 1
                },
                call: {
                    t: 195,
                    l: 303,
                    h: 24,
                    w: 83,
                    img: "",
                    disp: 0
                },
                refuse: {
                    t: 195,
                    l: 403,
                    h: 24,
                    w: 83,
                    img: "",
                    disp: 1
                }
            },
            s103: {
                bg_ext: "gif",
                btn_ext: "gif",
                bg: {
                    t: "c",
                    l: "c",
                    h: 175,
                    w: 379,
                    img: "",
                    effect: ""
                },
                title: {
                    t: 8,
                    l: 22,
                    h: 17,
                    w: 332,
                    disp: 1
                },
                close: {
                    t: 9,
                    l: 351,
                    h: 19,
                    w: 19
                },
                words: {
                    t: 40,
                    l: 120,
                    h: 88,
                    w: 245
                },
                kefu: {
                    disp: 0
                },
                accept: {
                    t: 140,
                    l: 188,
                    h: 22,
                    w: 77,
                    img: "",
                    disp: 1
                },
                message: {
                    t: 140,
                    l: 188,
                    h: 22,
                    w: 77,
                    img: "",
                    disp: 1
                },
                call: {
                    t: 140,
                    l: 188,
                    h: 22,
                    w: 77,
                    img: "",
                    disp: 0
                },
                refuse: {
                    t: 140,
                    l: 280,
                    h: 22,
                    w: 77,
                    img: "",
                    disp: 1
                }
            },
            s104: {
                bg_ext: "gif",
                btn_ext: "gif",
                bg: {
                    t: "c",
                    l: "c",
                    h: 194,
                    w: 483,
                    img: "",
                    effect: ""
                },
                title: {
                    t: 10,
                    l: 31,
                    h: 17,
                    w: 345,
                    disp: 0
                },
                close: {
                    t: 11,
                    l: 450,
                    h: 19,
                    w: 19
                },
                words: {
                    t: 35,
                    l: 232,
                    h: 102,
                    w: 230
                },
                kefu: {
                    disp: 0
                },
                accept: {
                    t: 145,
                    l: 273,
                    h: 24,
                    w: 83,
                    img: "",
                    disp: 1
                },
                message: {
                    t: 145,
                    l: 273,
                    h: 24,
                    w: 83,
                    img: "",
                    disp: 1
                },
                call: {
                    t: 145,
                    l: 273,
                    h: 24,
                    w: 83,
                    img: "",
                    disp: 0
                },
                refuse: {
                    t: 145,
                    l: 372,
                    h: 24,
                    w: 83,
                    img: "",
                    disp: 1
                }
            },
            s105: {
                bg_ext: "gif",
                btn_ext: "gif",
                bg: {
                    t: "c",
                    l: "c",
                    h: 154,
                    w: 336,
                    img: "",
                    effect: ""
                },
                title: {
                    t: 10,
                    l: 31,
                    h: 17,
                    w: 100,
                    disp: 0
                },
                close: {
                    t: 2,
                    l: 311,
                    h: 15,
                    w: 15
                },
                words: {
                    t: 26,
                    l: 104,
                    h: 80,
                    w: 220
                },
                kefu: {
                    disp: 0
                },
                accept: {
                    t: 119,
                    l: 148,
                    h: 24,
                    w: 83,
                    img: "",
                    disp: 1
                },
                message: {
                    t: 119,
                    l: 148,
                    h: 24,
                    w: 83,
                    img: "",
                    disp: 1
                },
                call: {
                    t: 119,
                    l: 148,
                    h: 24,
                    w: 83,
                    img: "",
                    disp: 0
                },
                refuse: {
                    t: 119,
                    l: 240,
                    h: 24,
                    w: 83,
                    img: "",
                    disp: 1
                }
            },
            s106: {
                bg_ext: "gif",
                btn_ext: "gif",
                bg: {
                    t: "c",
                    l: "c",
                    h: 259,
                    w: 479,
                    img: "",
                    effect: ""
                },
                title: {
                    t: 10,
                    l: 31,
                    h: 17,
                    w: 345,
                    disp: 0
                },
                close: {
                    t: 39,
                    l: 447,
                    h: 19,
                    w: 19
                },
                words: {
                    t: 62,
                    l: 170,
                    h: 140,
                    w: 290
                },
                kefu: {
                    disp: 0
                },
                accept: {
                    t: 210,
                    l: 245,
                    h: 26,
                    w: 82,
                    img: "",
                    disp: 1
                },
                message: {
                    t: 210,
                    l: 245,
                    h: 26,
                    w: 82,
                    img: "",
                    disp: 1
                },
                call: {
                    t: 210,
                    l: 245,
                    h: 26,
                    w: 82,
                    img: "",
                    disp: 0
                },
                refuse: {
                    t: 210,
                    l: 355,
                    h: 26,
                    w: 82,
                    img: "",
                    disp: 1
                }
            },
            s107: {
                bg_ext: "gif",
                btn_ext: "gif",
                bg: {
                    t: "c",
                    l: "c",
                    h: 237,
                    w: 539,
                    img: "",
                    effect: ""
                },
                title: {
                    t: 10,
                    l: 31,
                    h: 17,
                    w: 345,
                    disp: 0
                },
                close: {
                    t: 1,
                    l: 450,
                    h: 19,
                    w: 19
                },
                words: {
                    t: 45,
                    l: 213,
                    h: 120,
                    w: 250
                },
                kefu: {
                    disp: 0
                },
                accept: {
                    t: 180,
                    l: 235,
                    h: 24,
                    w: 83,
                    img: "",
                    disp: 1
                },
                message: {
                    t: 180,
                    l: 235,
                    h: 24,
                    w: 83,
                    img: "",
                    disp: 1
                },
                call: {
                    t: 180,
                    l: 235,
                    h: 24,
                    w: 83,
                    img: "",
                    disp: 0
                },
                refuse: {
                    t: 180,
                    l: 330,
                    h: 24,
                    w: 83,
                    img: "",
                    disp: 1
                }
            },
            s108: {
                bg_ext: "gif",
                btn_ext: "gif",
                bg: {
                    t: "c",
                    l: "c",
                    h: 249,
                    w: 571,
                    img: "",
                    effect: ""
                },
                title: {
                    t: 10,
                    l: 31,
                    h: 17,
                    w: 345,
                    disp: 0
                },
                close: {
                    t: 13,
                    l: 482,
                    h: 19,
                    w: 19
                },
                words: {
                    t: 42,
                    l: 200,
                    h: 130,
                    w: 310
                },
                kefu: {
                    disp: 0
                },
                accept: {
                    t: 187,
                    l: 255,
                    h: 26,
                    w: 82,
                    img: "",
                    disp: 1
                },
                message: {
                    t: 187,
                    l: 255,
                    h: 26,
                    w: 82,
                    img: "",
                    disp: 1
                },
                call: {
                    t: 187,
                    l: 255,
                    h: 26,
                    w: 82,
                    img: "",
                    disp: 0
                },
                refuse: {
                    t: 187,
                    l: 365,
                    h: 26,
                    w: 82,
                    img: "",
                    disp: 1
                }
            },
            s109: {
                bg_ext: "gif",
                btn_ext: "gif",
                bg: {
                    t: "c",
                    l: "c",
                    h: 259,
                    w: 492,
                    img: "",
                    effect: ""
                },
                title: {
                    t: 10,
                    l: 31,
                    h: 17,
                    w: 345,
                    disp: 0
                },
                close: {
                    t: 20,
                    l: 426,
                    h: 19,
                    w: 19
                },
                words: {
                    t: 52,
                    l: 172,
                    h: 115,
                    w: 250
                },
                kefu: {
                    disp: 0
                },
                accept: {
                    t: 183,
                    l: 200,
                    h: 24,
                    w: 83,
                    img: "",
                    disp: 1
                },
                message: {
                    t: 183,
                    l: 200,
                    h: 24,
                    w: 83,
                    img: "",
                    disp: 1
                },
                call: {
                    t: 183,
                    l: 200,
                    h: 24,
                    w: 83,
                    img: "",
                    disp: 0
                },
                refuse: {
                    t: 183,
                    l: 295,
                    h: 24,
                    w: 83,
                    img: "",
                    disp: 1
                }
            },
            s110: {
                bg_ext: "gif",
                btn_ext: "gif",
                bg: {
                    t: "c",
                    l: "c",
                    h: 252,
                    w: 513,
                    img: "",
                    effect: ""
                },
                title: {
                    t: 10,
                    l: 31,
                    h: 17,
                    w: 345,
                    disp: 0
                },
                close: {
                    t: 57,
                    l: 450,
                    h: 19,
                    w: 19
                },
                words: {
                    t: 81,
                    l: 223,
                    h: 120,
                    w: 280
                },
                kefu: {
                    disp: 0
                },
                accept: {
                    t: 210,
                    l: 230,
                    h: 26,
                    w: 82,
                    img: "",
                    disp: 1
                },
                message: {
                    t: 210,
                    l: 230,
                    h: 26,
                    w: 82,
                    img: "",
                    disp: 1
                },
                call: {
                    t: 210,
                    l: 230,
                    h: 26,
                    w: 82,
                    img: "",
                    disp: 0
                },
                refuse: {
                    t: 210,
                    l: 340,
                    h: 26,
                    w: 82,
                    img: "",
                    disp: 1
                }
            },
            s114: {
                bg_ext: "png",
                btn_ext: "png",
                bg: {
                    t: "c",
                    l: "c",
                    h: 190,
                    w: 358,
                    img: "",
                    effect: ""
                },
                title: {
                    t: 10,
                    l: 31,
                    h: 17,
                    w: 345,
                    disp: 0
                },
                close: {
                    t: 7,
                    l: 334,
                    h: 19,
                    w: 19
                },
                words: {
                    t: 45,
                    l: 126,
                    h: 90,
                    w: 220
                },
                kefu: {
                    disp: 0
                },
                accept: {
                    t: 150,
                    l: 160,
                    h: 24,
                    w: 68,
                    img: "",
                    disp: 1
                },
                message: {
                    t: 150,
                    l: 160,
                    h: 24,
                    w: 68,
                    img: "",
                    disp: 1
                },
                call: {
                    t: 150,
                    l: 160,
                    h: 24,
                    w: 68,
                    img: "",
                    disp: 0
                },
                refuse: {
                    t: 150,
                    l: 260,
                    h: 24,
                    w: 68,
                    img: "",
                    disp: 1
                }
            },
            s201: {
                bg_ext: "gif",
                btn_ext: "gif",
                bg: {
                    t: "c",
                    l: "c",
                    h: 190,
                    w: 385,
                    img: "",
                    effect: ""
                },
                title: {
                    t: 10,
                    l: 31,
                    h: 17,
                    w: 320,
                    disp: 0
                },
                close: {
                    t: 7,
                    l: 358,
                    h: 19,
                    w: 19
                },
                words: {
                    t: 40,
                    l: 107,
                    h: 100,
                    w: 260
                },
                accept: {
                    t: 150,
                    l: 180,
                    h: 23,
                    w: 81,
                    img: "",
                    disp: 1
                },
                message: {
                    t: 150,
                    l: 180,
                    h: 23,
                    w: 81,
                    img: "",
                    disp: 1
                },
                call: {
                    t: 150,
                    l: 280,
                    h: 23,
                    w: 81,
                    img: "",
                    disp: 1
                },
                refuse: {
                    t: 150,
                    l: 380,
                    h: 23,
                    w: 81,
                    img: "",
                    disp: 0
                }
            }
        },
        t2: {
            s2: {
                bg_ext: "png",
                btn_ext: "gif",
                kefu_ext: "png",
                bg: {
                    t: "c",
                    l: "c",
                    w: 404,
                    img: "",
                    effect: ""
                },
                bg_top: {
                    h: 45
                },
                bg_btm: {
                    h: 25
                },
                title: {
                    t: 18,
                    l: 44,
                    h: 17,
                    w: 320,
                    disp: 1
                },
                close: {
                    t: 16,
                    l: 368,
                    h: 19,
                    w: 19
                },
                words: {
                    t: 0,
                    r: 20,
                    b: 6,
                    l: 0
                },
                kefu: {
                    w: 130,
                    l: 8,
                    t: 0,
                    img: ""
                },
                accept: {
                    t: 97,
                    l: 135,
                    h: 24,
                    w: 71,
                    img: "",
                    disp: 1
                },
                message: {
                    t: 97,
                    l: 135,
                    h: 24,
                    w: 71,
                    img: "",
                    disp: 1
                },
                call: {
                    t: 97,
                    l: 220,
                    h: 24,
                    w: 71,
                    img: "",
                    disp: 1
                },
                refuse: {
                    t: 97,
                    l: 305,
                    h: 24,
                    w: 71,
                    img: "",
                    disp: 1
                }
            },
            s3: {
                bg_ext: "png",
                btn_ext: "gif",
                kefu_ext: "png",
                bg: {
                    t: "c",
                    l: "c",
                    w: 391,
                    img: "",
                    effect: ""
                },
                bg_top: {
                    h: 33
                },
                bg_btm: {
                    h: 8
                },
                title: {
                    t: 11,
                    l: 32,
                    h: 17,
                    w: 320,
                    disp: 1
                },
                close: {
                    t: 9,
                    l: 366,
                    h: 19,
                    w: 19
                },
                words: {
                    t: 6,
                    r: 8,
                    b: 3,
                    l: 0
                },
                kefu: {
                    w: 125,
                    l: 8,
                    t: 0,
                    img: ""
                },
                accept: {
                    t: 97,
                    l: 135,
                    h: 24,
                    w: 71,
                    img: "",
                    disp: 1
                },
                message: {
                    t: 97,
                    l: 135,
                    h: 24,
                    w: 71,
                    img: "",
                    disp: 1
                },
                call: {
                    t: 97,
                    l: 220,
                    h: 24,
                    w: 71,
                    img: "",
                    disp: 1
                },
                refuse: {
                    t: 97,
                    l: 305,
                    h: 24,
                    w: 71,
                    img: "",
                    disp: 1
                }
            },
            s4: {
                bg_ext: "png",
                btn_ext: "gif",
                kefu_ext: "png",
                bg: {
                    t: "c",
                    l: "c",
                    w: 404,
                    img: "",
                    effect: ""
                },
                bg_top: {
                    h: 45
                },
                bg_btm: {
                    h: 25
                },
                title: {
                    t: 18,
                    l: 44,
                    h: 17,
                    w: 320,
                    disp: 1
                },
                close: {
                    t: 16,
                    l: 368,
                    h: 19,
                    w: 19
                },
                words: {
                    t: 0,
                    r: 20,
                    b: 6,
                    l: 0
                },
                kefu: {
                    w: 130,
                    l: 8,
                    t: 0,
                    img: ""
                },
                accept: {
                    t: 97,
                    l: 135,
                    h: 24,
                    w: 71,
                    img: "",
                    disp: 1
                },
                message: {
                    t: 97,
                    l: 135,
                    h: 24,
                    w: 71,
                    img: "",
                    disp: 1
                },
                call: {
                    t: 97,
                    l: 220,
                    h: 24,
                    w: 71,
                    img: "",
                    disp: 1
                },
                refuse: {
                    t: 97,
                    l: 305,
                    h: 24,
                    w: 71,
                    img: "",
                    disp: 1
                }
            },
            s5: {
                bg_ext: "png",
                btn_ext: "gif",
                kefu_ext: "png",
                bg: {
                    t: "c",
                    l: "c",
                    w: 404,
                    img: "",
                    effect: ""
                },
                bg_top: {
                    h: 45
                },
                bg_btm: {
                    h: 25
                },
                title: {
                    t: 20,
                    l: 44,
                    h: 17,
                    w: 320,
                    disp: 1
                },
                close: {
                    t: 16,
                    l: 368,
                    h: 19,
                    w: 19
                },
                words: {
                    t: 0,
                    r: 20,
                    b: 6,
                    l: 0
                },
                kefu: {
                    w: 120,
                    l: 8,
                    t: 0,
                    img: ""
                },
                accept: {
                    t: 97,
                    l: 135,
                    h: 24,
                    w: 71,
                    img: "",
                    disp: 1
                },
                message: {
                    t: 97,
                    l: 135,
                    h: 24,
                    w: 71,
                    img: "",
                    disp: 1
                },
                call: {
                    t: 97,
                    l: 220,
                    h: 24,
                    w: 71,
                    img: "",
                    disp: 1
                },
                refuse: {
                    t: 97,
                    l: 305,
                    h: 24,
                    w: 71,
                    img: "",
                    disp: 1
                }
            }
        }
    },
    elementVariCfg: {
        title: ["w"],
        close: ["l"],
        words: ["w", "h"],
        accept: ["t", "l"],
        message: ["t", "l"],
        call: ["t", "l"],
        refuse: ["t", "l"]
    },
    CreatDOM: function() {
        this.userCfg = this.DefaultCfg["t" + this.t]["s" + this.s];
        TQUtils.SetValue(this.invit_layout_cfg, this.userCfg);
        if (this.DOM == null) {
            this.DOM = document.createElement("div");
            this.DOM.id = "tq_invit_container";
            this.DOM.className = "tracq_fix_div";
            this.DOM.style.visibility = "hidden";
            this.DOM.style.border = "0px ridge #EAEAEA";
            this.DOM.style.position = "absolute";
            this.DOM.style.zIndex = "9999";
            if (TQKF.userDefined.isNotCreatInvit == "1") {
                this.DOM.style.overflow = "visible"
            } else {
                this.DOM.style.width = this.w = this.userCfg.bg.w
            }
            if (tq_is_mask == 1) {
                this.pageLocker = document.createElement("div");
                this.pageLocker.id = "tq_lock_page_div";
                this.pageLocker.style.visibility = "hidden";
                this.pageLocker.style.border = "0px ridge #EAEAEA";
                this.pageLocker.style.backgroundColor = "#000";
                this.pageLocker.style.position = "absolute";
                this.pageLocker.style.width = TQUtils.GetPageSize().w + "px";
                this.pageLocker.style.height = TQUtils.GetPageSize().h + "px";
                this.pageLocker.style.left = "0px";
                this.pageLocker.style.top = "0px";
                this.pageLocker.style.opacity = "0.2";
                this.pageLocker.style.filter = "alpha(opacity=20)";
                this.pageLocker.style.zIndex = "7999";
                this.pageLocker.style.padding = "0px"
            }
        }
        var html = [];
        var bg_img = (this.userCfg.bg.img == '') ? (TQKF.invite_image_url + 't' + this.t + '/s' + this.s + '/bg_c' + this.c + '.' + this.DefaultCfg["t" + this.t]["s" + this.s].bg_ext) : this.userCfg.bg.img;
        var accept_img = (this.userCfg.accept.img == '') ? (TQKF.invite_image_url + 't' + this.t + '/s' + this.s + '/accept' + TQKF.ltype_str + '_c' + this.c + '.' + this.DefaultCfg["t" + this.t]["s" + this.s].btn_ext) : this.userCfg.accept.img;
        var message_img = (this.userCfg.message.img == '') ? (TQKF.invite_image_url + 't' + this.t + '/s' + this.s + '/message' + TQKF.ltype_str + '_c' + this.c + '.' + this.DefaultCfg["t" + this.t]["s" + this.s].btn_ext) : this.userCfg.message.img;
        var call_img = (this.userCfg.call.img == '') ? (TQKF.invite_image_url + 't' + this.t + '/s' + this.s + '/call_c' + this.c + '.' + this.DefaultCfg["t" + this.t]["s" + this.s].btn_ext) : this.userCfg.call.img;
        var refuse_img = (this.userCfg.refuse.img == '') ? (TQKF.invite_image_url + 't' + this.t + '/s' + this.s + '/refuse' + TQKF.ltype_str + '_c' + this.c + '.' + this.DefaultCfg["t" + this.t]["s" + this.s].btn_ext) : this.userCfg.refuse.img;
        var fixPng = TQUtils.IE && !TQUtils.higherThanIE6;
        var fixStr = 'background-image:none;filter:progid:dximagetransform.microsoft.alphaimageloader(src={bgImg}, sizingMethod={isRepeat},enabled=true);';
        if (this.t == 1) {
            html.push((TQUtils.IsFlash(bg_img) || !fixPng) ? '<div id=tq_invit_bg >': '<div id=tq_invit_bg style="' + fixStr.replace("{bgImg}", bg_img).replace("{isRepeat}", "crop") + '">', TQUtils.IsFlash(bg_img) ? '<object id=tq_invit_bg_img classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" width="' + this.userCfg.bg.w + '" height="' + this.userCfg.bg.h + '"><param name="movie" value="' + bg_img + '" /><param name="allowScriptAccess" value="always" /><PARAM NAME="WMode" VALUE="Transparent"><object  type="application/x-shockwave-flash" data="' + bg_img + '" width="' + this.userCfg.bg.w + '" height="' + this.userCfg.bg.h + '"><PARAM NAME="WMode" VALUE="Transparent"><param name="allowScriptAccess" value="always" /></object></object>': ((!TQUtils.ieVersion || TQUtils.higherThanIE6) ? '<img id=tq_invit_bg_img src=' + bg_img + ' />': '<img id=tq_invit_bg_img src=' + bg_img + ' />'), '<div id=tq_invit_title style="position: absolute;' + (this.userCfg.title.disp == 0 ? 'display:none;': '') + 'font-weight:bold;">' + tq_invit_title + '</div>', '<div id=tq_invit_head style="overflow: hidden;position: absolute;BACKGROUND-COLOR: #FFFFFF; FILTER: Alpha(opacity=0); opacity: 0;"></div>', '<div id=tq_invit_close style="position: absolute;BACKGROUND-COLOR: #FFFFFF; FILTER: Alpha(opacity=0); opacity: 0;" onclick="TQKF.inviter.Refuse()"></div>', '<div id=tq_invit_words style="overflow-x:hidden;overflow-y:auto"><div id=tq_invit_parse_ip></div>' + tq_global_invite_words + '</div>', (this.userCfg.accept.disp == 0) ? '<div id=tq_invit_accept style="position: absolute;display:none"></div>': '<div style="position: absolute;" id=tq_invit_accept><img src=' + accept_img + ' onclick="TQKF.inviter.Accept()" /></div>', (this.userCfg.message.disp == 0) ? '<div id=tq_invit_message style="position:absolute;display:none"></div>': '<div style="position: absolute;" id=tq_invit_message><img src=' + message_img + ' onclick="TQKF.inviter.Accept()" /></div>', (this.userCfg.call.disp == 0 || tq_iscallback == 0 || tq_language == 100) ? '<div id=tq_invit_call style="position: absolute;display:none"></div>': '<div style="position: absolute;" id=tq_invit_call><img src=' + call_img + ' onclick="TQKF.inviter.OpenCallback()" /></div>', (this.userCfg.refuse.disp == 0) ? '<div id=tq_invit_refuse style="position: absolute;display:none"></div>': '<div style="position: absolute;" id=tq_invit_refuse><img style="width:auto;height:auto" width=auto src=' + refuse_img + ' onclick="TQKF.inviter.Refuse()" /></div>', '</div>')
        }
        if (this.t == 2) {
            if (this.userCfg.call.disp == 0 || tq_iscallback == 0 || tq_language == 100) {
                this.userCfg.accept.l = this.userCfg.call.l;
                this.userCfg.accept.w = this.userCfg.call.w;
                this.userCfg.accept.h = this.userCfg.call.h;
                this.userCfg.message.l = this.userCfg.call.l;
                this.userCfg.message.w = this.userCfg.call.w;
                this.userCfg.message.h = this.userCfg.call.h
            }
            var bg_top_img = TQKF.invite_image_url + 't' + this.t + '/s' + this.s + '/bg_top_c' + this.c + '.' + this.DefaultCfg["t" + this.t]["s" + this.s].bg_ext;
            var bg_cet_img = TQKF.invite_image_url + 't' + this.t + '/s' + this.s + '/bg_cet_c' + this.c + '.' + this.DefaultCfg["t" + this.t]["s" + this.s].bg_ext;
            var bg_msk_img = TQKF.invite_image_url + 't' + this.t + '/s' + this.s + '/bg_msk_c' + this.c + '.' + this.DefaultCfg["t" + this.t]["s" + this.s].bg_ext;
            var bg_btm_img = TQKF.invite_image_url + 't' + this.t + '/s' + this.s + '/bg_btm_c' + this.c + '.' + this.DefaultCfg["t" + this.t]["s" + this.s].bg_ext;
            var kefu_img = (this.userCfg.kefu.img == '') ? (TQKF.invite_image_url + 't' + this.t + '/s' + this.s + '/kefu.' + this.DefaultCfg["t" + this.t]["s" + this.s].kefu_ext) : this.userCfg.kefu.img;
            html.push('<div id=tq_invit_bg style="overflow:visible;width:' + this.userCfg.bg.w + 'px">', '<div id=tq_invit_head style="BACKGROUND-COLOR: #FFFFFF;FILTER: Alpha(opacity=0); opacity: 0;"></div>', '<div id=tq_invit_bg_top style="height:' + this.userCfg.bg_top.h + 'px;' + (fixPng ? fixStr.replace("{bgImg}", bg_top_img).replace("{isRepeat}", "crop") : 'background-image:url(' + bg_top_img + ');') + '">', '<div id=tq_invit_title style="' + (this.userCfg.title.disp == 0 ? 'display:none;': '') + 'width:' + this.userCfg.title.w + 'px;height:' + this.userCfg.title.h + 'px;top:' + this.userCfg.title.t + 'px;left:' + this.userCfg.title.l + 'px;font-weight:bold;">' + tq_invit_title + '</div>', '<div id=tq_invit_close style="width:' + this.userCfg.close.w + 'px;height:' + this.userCfg.close.h + 'px;top:' + this.userCfg.close.t + 'px;left:' + this.userCfg.close.l + 'px;BACKGROUND-COLOR: #FFFFFF; FILTER: Alpha(opacity=0); opacity: 0;" onclick="TQKF.inviter.Refuse()"></div>', '</div>', '<div id=tq_invit_bg_cet style="' + (fixPng ? fixStr.replace("{bgImg}", bg_cet_img).replace("{isRepeat}", "scale") : 'background-image:url(' + bg_cet_img + ');') + '">', '<table id="tq_invit_bg_msk" border="0" style="' + (fixPng ? fixStr.replace("{bgImg}", bg_msk_img).replace("{isRepeat}", "crop") : 'background-image:url(' + bg_msk_img + ');') + '">', '<tr>', '<td id=tq_invit_kefu style="width:' + this.userCfg.kefu.w + 'px;background-position: ' + this.userCfg.kefu.l + 'px ' + this.userCfg.kefu.t + 'px; ' + (fixPng ? fixStr.replace("{bgImg}", kefu_img).replace("{isRepeat}", "crop") : 'background-image:url(' + kefu_img + ');') + 'background-repeat:no-repeat;" rowspan="2"></td>', '<td><div id=tq_invit_words style="padding-left:' + this.userCfg.words.l + 'px;padding-right:' + this.userCfg.words.r + 'px;padding-top:' + this.userCfg.words.t + 'px;padding-bottom:' + this.userCfg.words.b + 'px"><div id=tq_invit_parse_ip></div>' + tq_global_invite_words + '</div></td>', '</tr>', '<tr>', '<td>', '<div>', (this.userCfg.refuse.disp == 0) ? '<div id=tq_invit_refuse style="display:none"></div>': '<div id=tq_invit_refuse  style="left:' + this.userCfg.refuse.l + 'px;right:' + this.userCfg.refuse.r + 'px;width:' + this.userCfg.refuse.w + 'px;height:' + this.userCfg.refuse.h + 'px"><img src=' + refuse_img + ' onclick="TQKF.inviter.Refuse()" /></div>', '<div class=tq_btn_split></div>', (this.userCfg.call.disp == 0) ? '<div id=tq_invit_call style="display:none"></div>': '<div id=tq_invit_call style="left:' + this.userCfg.call.l + 'px;right:' + this.userCfg.call.r + 'px;width:' + this.userCfg.call.w + 'px;height:' + this.userCfg.call.h + 'px"><img src=' + call_img + ' onclick="TQKF.inviter.OpenCallback()" /></div>', '<div class=tq_btn_split></div>', (this.userCfg.accept.disp == 0) ? '<div id=tq_invit_accept style="display:none"></div>': '<div id=tq_invit_accept style="left:' + this.userCfg.accept.l + 'px;right:' + this.userCfg.accept.r + 'px;width:' + this.userCfg.accept.w + 'px;height:' + this.userCfg.accept.h + 'px"><img style="cursor:pointer;border:1px solid red" src=' + accept_img + ' onclick="TQKF.inviter.Accept()" /></div>', (this.userCfg.message.disp == 0) ? '<div id=tq_invit_message style="display:none"></div>': '<div id=tq_invit_message style="left:' + this.userCfg.message.l + 'px;right:' + this.userCfg.message.r + 'px;width:' + this.userCfg.message.w + 'px;height:' + this.userCfg.message.h + 'px"><img src=' + message_img + ' onclick="TQKF.inviter.Accept()" /></div>', '</div>', '</td>', '</tr>', '</table>', '</div>', '<div id=tq_invit_bg_btm style="height:' + this.userCfg.bg_btm.h + 'px;' + (fixPng ? fixStr.replace("{bgImg}", bg_btm_img).replace("{isRepeat}", "crop") : 'background-image:url(' + bg_btm_img + ');') + '"></div>', '</div>');
        }
        if (TQKF.userDefined.isNotCreatInvit == "1") {
            this.DOMinnerHTML = this.DOM.innerHTML = document.getElementById("tq_invit_container_copy").innerHTML;
            document.getElementById("tq_invit_container_copy").innerHTML = "";
        } else {
            this.DOMinnerHTML = this.DOM.innerHTML = html.join('');
        }
    },
    AppendDOM: function() {
        TQUtils.AppendDOM(TQKF.inviter.DOM);
        if (tq_is_mask == 1) TQUtils.AppendDOM(TQKF.inviter.pageLocker);
    },
    AdjustLayout: function() {
        var p = this.userCfg;
        var h = p.bg.h;
        var w = p.bg.w;
        document.getElementById("tq_invit_bg").style.width = w + "px";
        document.getElementById("tq_invit_container").style.width = w + "px";
        if (! (this.t == 1 && (this.s == 0 || this.s == 7 || this.s == 10 || this.s == 100)) && (this.userCfg.call.disp == 0 || tq_iscallback == 0 || tq_language == 100)) {
            p.accept.t = p.call.t;
            p.accept.l = p.call.l;
            p.message.t = p.call.t;
            p.message.l = p.call.l;
        }
        if (this.t == 1) {
            document.getElementById("tq_invit_bg").style.height = h + "px";
            document.getElementById("tq_invit_container").style.height = h + "px";
        }
        for (var eName in this.elementVariCfg) {
            if (typeof(this.elementVariCfg[eName]) == "function") continue;
            if (eName != "toJSONString" && eName != "toString" && eName != "IsInArray") {
                try {
                    document.getElementById("tq_invit_" + eName).style.width = p[eName].w + "px";
                    document.getElementById("tq_invit_" + eName).style.height = p[eName].h + "px";
                } catch(e) {}
            }
            if (eName != "bg" && eName != "toJSONString" && eName != "toString" && eName != "IsInArray") {
                try {
                    document.getElementById("tq_invit_" + eName).style.left = p[eName].l + "px";
                    document.getElementById("tq_invit_" + eName).style.top = p[eName].t + "px";
                } catch(e) {}
            }
            if (typeof(p[eName].disp) != "undefined" && p[eName].disp == "0") {
                document.getElementById("tq_invit_" + eName).style.display = "none";
            }
            if (this.IsNotChange(eName)) {
                var attrs = this.elementVariCfg[eName];
                for (var index in attrs) {
                    switch (attrs[index]) {
                    case "w":
                        {
                            try {
                                document.getElementById("tq_invit_" + eName).style.width = w - this.DefaultCfg["t" + this.t]["s" + this.s].bg.w + p[eName].w + "px";
                            } catch(e) {
                                document.getElementById("tq_invit_" + eName).style.width = p[eName].w + "px";
                            }
                            break;
                        }
                    case "h":
                        {
                            try {
                                document.getElementById("tq_invit_" + eName).style.height = h - this.DefaultCfg["t" + this.t]["s" + this.s].bg.h + p[eName].h + "px";
                            } catch(e) {
                                document.getElementById("tq_invit_" + eName).style.height = p[eName].h + "px";
                            }
                            break;
                        }
                    case "l":
                        {
                            if (eName != "bg") document.getElementById("tq_invit_" + eName).style.left = w - this.DefaultCfg["t" + this.t]["s" + this.s].bg.w + p[eName].l + "px";
                            break;
                        }
                    case "t":
                        {
                            if (eName != "bg") document.getElementById("tq_invit_" + eName).style.top = h - this.DefaultCfg["t" + this.t]["s" + this.s].bg.h + p[eName].t + "px";
                            break;
                        }
                    default:
                        var nouse = null;
                    }
                }
            }
        }
    },
    IsNotChange: function(eName) {
        return (this.userCfg[eName].w == this.DefaultCfg["t" + this.t]["s" + this.s][eName].w && this.userCfg[eName].h == this.DefaultCfg["t" + this.t]["s" + this.s][eName].h && this.userCfg[eName].t == this.DefaultCfg["t" + this.t]["s" + this.s][eName].t && this.userCfg[eName].l == this.DefaultCfg["t" + this.t]["s" + this.s][eName].l);
    },
    PlaySound: function(url) {
        if (TQUtils.GetObj("tq_invit_sound_div") == null) var div = document.createElement("div");
        div.id = "tq_invit_sound_div";
        div.style.position = "absolute";
        div.style.top = "-500px";
        div.style.left = "0px";
        div.innerHTML = '<embed src="' + url + '" width=0 height=0 type="application/x-mplayer2" REPEAT=false loop="false" autostart="true"></embed>';
        TQUtils.AppendDOM(div);
    },
    StopSound: function() {
        try {
            TQUtils.GetObj("tq_invit_sound_div").innerHTML = "";
        } catch(e) {}
    },
    Show: function() {
        try {
            clearTimeout(TQKF.inviter.autoReshowTimer);
        } catch(e) {}
        TQKF.inviter.isInvited = true;
        if (TQKF.isInviter == "2" || TQKF.isInviter == "3") return;
        TQ_DEBUG("TQKF.inviter.Show()", 3);
        if (tq_not_reshow == 1) {
            TQ_DEBUG("tq_not_reshow = 1(show once in 10 minitus)", 3);
            try {
                var tq_invite_showed = TQUtils.GetCookie("tq_invite_showed");
                TQ_DEBUG("tq_invite_showed=" + tq_invite_showed, 3);
                if (tq_invite_showed == 1) {
                    TQ_DEBUG("tq_not_reshow", 3);
                    return;
                }
                TQUtils.SetCookie("tq_invite_showed", "1", TQKF.not_reshow_time * (1 / 60));
            } catch(e) {}
        } else if (tq_not_reshow == 2) {
            TQ_DEBUG("tq_not_reshow = 2(come once,show once)", 3);
            if (TQKF.inviter.showTimes > 0) {
                TQ_DEBUG("TQKF.inviter.showTimes >0, so return", 3);
                return;
            }
        } else if (tq_not_reshow == 4) {
            TQ_DEBUG("tq_not_reshow = 4(only show on the first page of the site)", 3);
            try {
                var tq_invite_showed_site = TQUtils.GetCookie("tq_invite_showed_site");
                TQ_DEBUG("tq_invite_showed_site=" + tq_invite_showed_site, 3);
                if (tq_invite_showed_site == 1) {
                    TQ_DEBUG("tq_invite_showed_site", 3);
                    return;
                }
                TQUtils.SetCookie2("tq_invite_showed_site", "1", TQKF.not_reshow_time_site * (1 / 60));
            } catch(e) {}
        }
        var parseIp = "<div id=tq_invit_parse_ip>";
        if (tq_is_parse_ip == 1 && !(TQUtils.IsUndefined("tq_userfrom")) && tq_userfrom != "") {
            try {
                if (typeof(TQKF.clientInfo.cn) != "undefined" && TQKF.clientInfo.cn != "" && TQKF.clientInfo.cn != "%u60A8") {
                    TQKF.words[15] = escape(TQKF.words[15]).replace("%u5BA2%u4EBA", TQKF.clientInfo.cn);
                }
                parseIp += unescape(unescape(TQKF.words[15])).replace("${area}", tq_userfrom) + "<br><br>";
            } catch(e) {}
        }
        parseIp += "</div>";
        if (TQKF.inviter.allKefuIsOffLine) {
            TQUtils.GetObj("tq_invit_words").innerHTML = parseIp + unescape(tq_welcome_msg);
            if (TQKF.userDefined.isNotCreatInvit == "0") {
                TQUtils.GetObj("tq_invit_accept").style.display = "none";
                TQUtils.GetObj("tq_invit_message").style.display = "";
            }
        } else {
            if (! (TQUtils.IsUndefined("tq_isminichat")) && (tq_isminichat == 1 || tq_isminichat == "1") && tq_if_tryout == 1) {
                if (! (TQUtils.IsUndefined("tq_isminichat")) && tq_if_tryout != 1) return;
                TQ_DEBUG("tq_isminichat,ready to load minichat.js"/*tpa=http://sysimages.tq.cn/js/vip/100501/tq_isminichat,ready to load minichat.js*/, 3);
                if (TQUtils.IsUndefined("http://sysimages.tq.cn/js/vip/100501/TQKF.miniChat.DOM")) TQUtils.LoadJS(TQKF.userDefined.minichatJS, true);
                return;
            }
            if (TQKF.inviter.isAutoInvit == 1) {
                TQ_DEBUG("use auto invit words", 3);
                TQUtils.GetObj("tq_invit_words").innerHTML = parseIp + unescape(tq_global_invite_words);
            } else {
                TQ_DEBUG("use realtime invit words", 3);
                if (TQUtils.IsUndefined("tq_apptext")) tq_apptext = tq_global_invite_words;
                TQUtils.GetObj("tq_invit_words").innerHTML = parseIp + tq_apptext;
            }
            if (TQKF.userDefined.isNotCreatInvit == "0") {
                TQUtils.GetObj("tq_invit_accept").style.display = "";
                TQUtils.GetObj("tq_invit_message").style.display = "none";
            }
        }
        TQKF.inviter.isClosed = false;
        var self = TQKF.inviter;
        var bg = TQUtils.GetObj("tq_invit_bg");
        if (self.userCfg.bg.effect == "fade") self.Effect.fade(TQKF.inviter.DOM, 100);
        else if (self.userCfg.bg.effect == "slideH" || self.userCfg.bg.effect == "slideV") {
            {
                TQKF.inviter.Slide("in", false);
            }
        } else if (self.userCfg.bg.effect == "fadeSlideH" || self.userCfg.bg.effect == "fadeSlideV") {
            {
                TQKF.inviter.Slide("in", true);
            }
        } else {
            TQUtils.Disp(TQKF.inviter.DOM);
        }
        if (tq_is_mask == 1) {
            TQKF.inviter.InitPageLockerSize();
            TQUtils.Disp(TQKF.inviter.pageLocker);
        }
        TQKF.inviter.showTimes++;
        TQKF.inviter.ToggleFloat("hide");
        if (tq_invit_sound != "") {
            TQKF.inviter.PlaySound(tq_invit_sound);
        }
        if (tq_invit_auto_hide_delay != "" && tq_invit_auto_hide_delay != 0) {
            setTimeout(function() {
                TQKF.inviter.Refuse();
            },
            parseInt(tq_invit_auto_hide_delay) * 1000);
        }
        TQKF.inviter.autiTimer = window.setInterval(TQKF.inviter.Anti, 3000);
    },
    Close: function() {
        if (this.userCfg.bg.effect == "fade") {
            this.Effect.fade(TQKF.inviter.DOM, 0);
        } else if (this.userCfg.bg.effect == "slideH" || this.userCfg.bg.effect == "slideV") {
            {
                TQKF.inviter.Slide("out", false);
            }
        } else if (this.userCfg.bg.effect == "fadeSlideH" || this.userCfg.bg.effect == "fadeSlideV") {
            {
                TQKF.inviter.Slide("out", true);
            }
        } else {
            TQUtils.Hide(this.DOM);
            if (tq_is_mask == 1) TQUtils.Hide(this.pageLocker);
            this.isClosed = true;
            TQKF.inviter.ToggleFloat("show");
        }
        if (tq_invit_sound != "") TQKF.inviter.StopSound();
        this.isAntiKaKa = false;
        clearInterval(TQKF.inviter.autiTimer);
        if (tq_not_reshow == 3) {
            TQ_DEBUG("tq_not_reshow = 3(auto show after refuse)", 3);
            try {
                TQKF.inviter.autoReshowTimer = setTimeout(function() {
                    TQKF.inviter.Show();
                    var temp = TQKF.invite_server_url + "/sendmain.jsp?rand=" + TQKF.clientInfo.r + "&clientid=" + tq_clientid + "&uin=" + tq_adminid + "&comflag=" + TQKF.inviter.comflag + "&nocache=" + Math.random() + "&msg=AUTO_RESHOW";
                    TQUtils.LoadJS(temp, false);
                },
                (TQKF.auto_reshow_time) * 1000);
            } catch(e) {}
        }
    },
    Slide: function(inOrOut, isFade) {
        var fpos = {
            b: "",
            t: "",
            l: "",
            r: ""
        };
        var tpos = {
            b: "",
            t: "",
            l: "",
            r: ""
        };
        var self = this;
        var bg = TQUtils.GetObj("tq_invit_bg");
        if (TQUtils.isSupportFixedPos) {
            if (self.userCfg.bg.t == "t") {
                fpos.t = "0";
                tpos.t = "0";
            } else if (self.userCfg.bg.t == "b") {
                fpos.b = "0";
                tpos.b = "0";
            } else {
                fpos.t = "0";
                tpos.t = parseInt((TQUtils.GetWinSize().h - bg.offsetHeight) / 2);
            }
            if (self.userCfg.bg.l == "l") {
                fpos.l = "0";
                tpos.l = "0";
            } else if (self.userCfg.bg.l == "r") {
                fpos.r = "0";
                tpos.r = "0";
            } else {
                fpos.l = "0";
                tpos.l = parseInt((TQUtils.GetWinSize().w - bg.offsetWidth) / 2);
            }
        } else {
            if (self.userCfg.bg.t == "t") {
                fpos.t = TQUtils.GetScrollTop() + "";
                tpos.t = TQUtils.GetScrollTop() + "";
            } else if (self.userCfg.bg.t == "b") {
                fpos.t = TQUtils.GetScrollTop() + TQUtils.GetWinSize().h;
                tpos.t = TQUtils.GetScrollTop() + TQUtils.GetWinSize().h - bg.offsetHeight;
            } else {
                fpos.t = TQUtils.GetScrollTop() + "";
                tpos.t = TQUtils.GetScrollTop() + parseInt((TQUtils.GetWinSize().h - bg.offsetHeight) / 2);
            }
            if (self.userCfg.bg.l == "l") {
                fpos.l = TQUtils.GetScrollLeft() + "";
                tpos.l = TQUtils.GetScrollLeft() + "";
            } else if (self.userCfg.bg.l == "r") {
                fpos.l = TQUtils.GetScrollLeft() + TQUtils.GetWinSize().w;
                tpos.l = TQUtils.GetScrollLeft() + TQUtils.GetWinSize().w - bg.offsetWidth;
            } else {
                fpos.l = TQUtils.GetScrollLeft() + "";
                tpos.l = TQUtils.GetScrollLeft() + parseInt((TQUtils.GetWinSize().w - bg.offsetWidth) / 2);
            }
        }
        var direction = "";
        if (self.userCfg.bg.effect == "slideH" || self.userCfg.bg.effect == "fadeSlideH") {
            direction = "h";
        } else {
            direction = "v";
        }
        if (inOrOut == "in") {
            if (isFade) self.Effect.fade(TQKF.inviter.DOM, 100);
            TQUtils.Disp(TQKF.inviter.DOM);
            self.Effect.slide(self.DOM, bg, fpos, tpos, direction, inOrOut);
        } else {
            if (isFade) self.Effect.fade(TQKF.inviter.DOM, 0);
            self.Effect.slide(self.DOM, bg, tpos, fpos, direction, inOrOut);
        }
    },
    Effect: {
        fade: function(o, v) {
            var opcity = function() {
                var args = arguments,
                obj = args[0],
                f = obj.style.filter;
                if (args.length == 2) {
                    var v = args[1];
                    TQUtils.IE && (obj.style.filter = "alpha(opacity=" + v + ")") || (obj.style.opacity = v / 100);
                } else {
                    if (TQUtils.IE) return (f && f.indexOf("opacity=") >= 0) ? (parseInt(f.match(/opacity=([^)]*)/)[1])) : 100;
                    else return obj.style.opacity * 100;
                }
            };
            TQUtils.Disp(o);
            var fadeIn = function() {
                var op = opcity(o);
                if (op < 100) {
                    TQUtils.GetObj("tq_invit_head").style.display = "none";
                    TQUtils.GetObj("tq_invit_close").style.display = "none";
                    opcity(o, op + 5);
                    setTimeout(fadeIn, 50);
                } else {
                    TQUtils.GetObj("tq_invit_head").style.display = "";
                    TQUtils.GetObj("tq_invit_close").style.display = "";
                    o.style.filter = "";
                    o.style.backgroundColor = "transparent";
                }
            };
            var fadeOut = function() {
                var op = opcity(o);
                if (op > 0) {
                    TQUtils.GetObj("tq_invit_head").style.display = "none";
                    TQUtils.GetObj("tq_invit_close").style.display = "none";
                    opcity(o, op - 5);
                    setTimeout(fadeOut, 50);
                } else {
                    TQUtils.GetObj("tq_invit_head").style.display = "";
                    TQUtils.GetObj("tq_invit_close").style.display = "";
                    o.style.filter = "";
                    o.style.backgroundColor = "transparent";
                    o.style.visibility = "hidden";
                    if (tq_is_mask == 1) TQUtils.Hide(TQKF.inviter.pageLocker);
                    TQKF.inviter.ToggleFloat("show");
                }
            };
            if (v == 100) {
                opcity(o, 0);
                fadeIn();
            } else {
                opcity(o, 100);
                fadeOut();
            }
        },
        slide: function(obj, inobj, fpos, tpos, dirc, inOut) {
            if (dirc == "h") {
                if (inOut == "in") obj.style.height = "1px";
                if (fpos.b) obj.style.bottom = fpos.b + "px";
                if (fpos.t) obj.style.top = fpos.t + "px";
            }
            if (dirc == "v") {
                if (inOut == "in") obj.style.width = "100px";
                if (fpos.r) obj.style.right = fpos.r + "px";
                if (fpos.l) obj.style.left = fpos.l + "px";
            }
            var s = 0;
            var t = 0;
            var vt = 0;
            if (dirc == "h") {
                if (TQUtils.isSupportFixedPos) tpos.t ? s = parseInt(inobj.offsetHeight) + parseInt((inOut == "in") ? tpos.t: fpos.t) : s = parseInt(inobj.offsetHeight) + parseInt((inOut == "in") ? tpos.b: fpos.b);
                else s = Math.abs(tpos.t - fpos.t) + parseInt(inobj.offsetHeight);
            } else {
                if (TQUtils.isSupportFixedPos) tpos.l ? s = parseInt(inobj.offsetWidth) + parseInt((inOut == "in") ? tpos.l: fpos.l) : s = parseInt(inobj.offsetWidth) + parseInt((inOut == "in") ? tpos.r: fpos.r);
                else s = Math.abs(tpos.l - fpos.l) + parseInt(inobj.offsetWidth);
            }
            var a = -0.3 * s / 100;
            var v0 = Math.sqrt(2 * ( - a) * s);
            var doSlide = function() {
                if (dirc == "h") {
                    var pos = fpos.t ? "top": "bottom";
                    vt = v0 + a * t;
                    t++;
                    if (vt < 1) vt = 2;
                    obj.style.width = inobj.offsetWidth + "px";
                    if (inOut == "in") {
                        if (parseInt(obj.style.height) < inobj.offsetHeight) {
                            var h = Math.ceil(parseInt(obj.style.height) + vt);
                            obj.style.height = h + "px";
                            if (!TQUtils.isSupportFixedPos && parseInt(obj.style[pos]) > 0) obj.style[pos] = Math.ceil(parseInt(obj.style[pos]) - vt) + "px";
                            setTimeout(function() {
                                doSlide()
                            },
                            50);
                        } else {
                            obj.style.height = inobj.offsetHeight;
                            if (tpos.t && (parseInt(obj.style.top) < tpos.t) || tpos.b && (parseInt(obj.style.bottom) < tpos.b)) {
                                obj.style[pos] = Math.ceil(parseInt(obj.style[pos]) + vt) + "px";
                                setTimeout(function() {
                                    doSlide()
                                },
                                50);
                            } else {
                                obj.style[pos] = tpos.t + "px";
                            }
                        }
                    } else {
                        if (tpos.t && (parseInt(obj.style.top) > tpos.t) || tpos.b && (parseInt(obj.style.bottom) > tpos.b)) {
                            obj.style[pos] = Math.ceil(parseInt(obj.style[pos]) - vt) + "px";
                            setTimeout(function() {
                                doSlide()
                            },
                            50);
                        } else {
                            if (parseInt(obj.style.height) > 0) {
                                var h = Math.ceil(parseInt(obj.style.height) - vt);
                                obj.style.height = ((h > 0) ? h: 0) + "px";
                                if (!TQUtils.isSupportFixedPos && parseInt(obj.style[pos]) > 0) obj.style[pos] = Math.ceil(parseInt(obj.style[pos]) + vt) + "px";
                                setTimeout(function() {
                                    doSlide()
                                },
                                50);
                            } else {
                                TQUtils.Hide(TQKF.inviter.DOM);
                                if (tq_is_mask == 1) TQUtils.Hide(TQKF.inviter.pageLocker);
                                TQKF.inviter.ToggleFloat("show");
                            }
                        }
                    }
                } else {
                    var pos = fpos.l ? "left": "right";
                    vt = v0 + a * t;
                    t++;
                    if (vt < 1) vt = 2;
                    obj.style.height = inobj.offsetHeight + "px";
                    if (inOut == "in") {
                        if (parseInt(obj.style.width) < inobj.offsetWidth) {
                            var w = Math.ceil(parseInt(obj.style.width) + vt);
                            obj.style.width = w + "px";
                            if (!TQUtils.isSupportFixedPos && parseInt(obj.style[pos]) > 0) obj.style[pos] = Math.ceil(parseInt(obj.style[pos]) - vt) + "px";
                            setTimeout(function() {
                                doSlide()
                            },
                            50);
                        } else {
                            obj.style.width = inobj.offsetWidth;
                            if (tpos.l && (parseInt(obj.style.left) < tpos.l) || tpos.r && (parseInt(obj.style.right) < tpos.r)) {
                                obj.style[pos] = Math.ceil(parseInt(obj.style[pos]) + vt) + "px";
                                setTimeout(function() {
                                    doSlide()
                                },
                                50);
                            } else {
                                TQKF.inviter.fixPos();
                            }
                        }
                    } else {
                        if (tpos.l && (parseInt(obj.style.left) > tpos.l) || tpos.r && (parseInt(obj.style.right) > tpos.r)) {
                            obj.style[pos] = Math.ceil(parseInt(obj.style[pos]) - vt) + "px";
                            setTimeout(function() {
                                doSlide()
                            },
                            50);
                        } else {
                            if (parseInt(obj.style.width) > 0) {
                                var w = Math.ceil(parseInt(obj.style.width) - vt);
                                obj.style.width = ((w > 0) ? w: 0) + "px";
                                if (!TQUtils.isSupportFixedPos && parseInt(obj.style[pos]) > 0) obj.style[pos] = Math.ceil(parseInt(obj.style[pos]) + vt) + "px";
                                setTimeout(function() {
                                    doSlide()
                                },
                                50);
                            } else {
                                TQUtils.Hide(TQKF.inviter.DOM);
                                if (tq_is_mask == 1) TQUtils.Hide(TQKF.inviter.pageLocker);
                                TQKF.inviter.ToggleFloat("show");
                            }
                        }
                    }
                }
            };
            doSlide();
        }
    },
    RefreshParseIp: function() {
        TQ_DEBUG("send online msg over,begin to RefreshParseIp() ", 3);
        if ((TQKF.inviter.isAutoInvit == 1 || tq_showtime == "1" && TQKF.inviter.allKefuIsOffLine == true) && tq_is_parse_ip == 1 && !(TQUtils.IsUndefined("tq_userfrom")) && tq_userfrom != "") {
            var parseIp = "";
            try {
                parseIp = unescape(TQKF.words[15]).replace("${area}", tq_userfrom) + "<br><br>";
            } catch(e) {
                parseIp = "";
            }
            TQUtils.GetObj("tq_invit_parse_ip").innerHTML = parseIp;
            setTimeout(function() {
                if (TQKF.userDefined.isNotCreatInvit == "0") {
                    TQKF.inviter.DOM.style.height = TQUtils.GetObj("tq_invit_bg").offsetHeight + "px";
                }
                TQKF.inviter.SetPos();
            },
            100);
        }
    },
    SetPos: function() {
        var o = TQKF.inviter.DOM;
        var bg = TQUtils.GetObj("tq_invit_bg");
        var t = TQKF.inviter.userCfg.bg.t;
        var l = TQKF.inviter.userCfg.bg.l;
        if (TQUtils.isSupportFixedPos) {
            o.style.position = 'fixed';
            if (t == "t") o.style.top = "0px";
            else if (t == "b") o.style.bottom = "0px";
            else o.style.top = parseInt((TQUtils.GetWinSize().h - bg.offsetHeight) / 2) + "px";
            if (l == "l") o.style.left = "0px";
            else if (l == "r") o.style.right = "0px";
            else o.style.left = parseInt((TQUtils.GetWinSize().w - bg.offsetWidth) / 2) + "px";
        } else {
            TQKF.inviter.fixPos();
        }
        if (tq_is_mask == 1) {
            TQKF.inviter.InitPageLockerSize();
            TQUtils.AddEvent(window, "resize", TQKF.inviter.InitPageLockerSize);
        }
    },
    fixPos: function() {
        if (TQKF.inviter.isClosed == true) return;
        var o = TQKF.inviter.DOM;
        var bg = TQUtils.GetObj("tq_invit_bg");
        var t = TQKF.inviter.userCfg.bg.t;
        var l = TQKF.inviter.userCfg.bg.l;
        if (t == "t") o.style.top = TQUtils.GetScrollTop() + 'px';
        else if (t == "b") {
            o.style.top = TQUtils.GetScrollTop() + TQUtils.GetWinSize().h - bg.offsetHeight + 'px';
        } else {
            o.style.top = TQUtils.GetScrollTop() + parseInt((TQUtils.GetWinSize().h - bg.offsetHeight) / 2) + "px";
        }
        if (l == "l") o.style.left = TQUtils.GetScrollLeft() + 'px';
        else if (l == "r") {
            o.style.left = TQUtils.GetScrollLeft() + TQUtils.GetWinSize().w - bg.offsetWidth + "px";
        } else o.style.left = TQUtils.GetScrollLeft() + parseInt((TQUtils.GetWinSize().w - bg.offsetWidth) / 2) + "px";
    },
    InitPageLockerSize: function() {
        try {
            TQKF.inviter.pageLocker.style.width = "0px";
            TQKF.inviter.pageLocker.style.height = "0px";
            setTimeout(function() {
                TQKF.inviter.pageLocker.style.width = TQUtils.GetPageSize().w + "px";
                TQKF.inviter.pageLocker.style.height = TQUtils.GetPageSize().h + "px";
            },
            10);
        } catch(e) {}
    },
    HandleAutoApp: function() {
        TQ_DEBUG("HandleAutoApp ", 3);
        if (TQKF.inviter.allKefuIsOffLine == false) {
            if (tq_is_global_invite == "1") {
                if (typeof(tq_invit_come_times) != "undefined" && tq_invit_come_times != 0) {
                    var comTimes = 0;
                    try {
                        comTimes = TQKF.clientInfo.ct;
                    } catch(e) {
                        comTimes = 0;
                    }
                    if (tq_invit_come_times > 0) {
                        if (comTimes <= tq_invit_come_times) return;
                    } else {
                        if (comTimes >= -tq_invit_come_times) return;
                    }
                }
                TQ_DEBUG("HandleAutoApp(),online auto invit is true ", 3);
                TQKF.inviter.isAutoInvit = 1;
                TQKF.inviter.isSendAutoInvitPara = 1;
                if (typeof(tq_auto_invit_delay) != "undefined" && tq_auto_invit_delay != "") {
                    TQ_DEBUG("invit will show after " + tq_auto_invit_delay + " second", 3);
                    setTimeout(TQKF.inviter.Show, tq_auto_invit_delay * 1000);
                } else {
                    TQKF.inviter.Show();
                }
            }
        } else {
            if (tq_showtime == "1") {
                TQ_DEBUG("auto invit leavemsg when allKefuIsOffLine", 3);
                TQKF.inviter.Show();
            }
        }
    },
    IsAllKefuOffLine: function() {
        TQ_DEBUG("IsAllKefuOffLine", 3);
        if (TQKF.inviter.response_type == 1) {
            if (TQUtils.isInCode(tq_invit_response_uins[0].m[0].o, TQKF.ONLINE)) TQKF.inviter.allKefuIsOffLine = false;
            else if (! (TQUtils.IsUndefined("tq_isminichat")) && (tq_isminichat == 1 || tq_isminichat == "1") && tq_if_tryout == 1 && TQUtils.isInCode(tq_invit_response_uins[0].m[0].o, TQKF.BUSY)) {
                TQKF.inviter.allKefuIsOffLine = false;
            } else {
                TQKF.inviter.allKefuIsOffLine = true;
                return;
            }
        } else if (!TQUtils.IsUndefined("tq_invit_response_uins") && tq_invit_response_uins[0].m.length > 0) {
            try {
                var allTqUin = [];
                var onlineUins = [];
                var tqnum = 0;
                var m = tq_invit_response_uins[0].m;
                for (var i = 0; i < m.length; i++) {
                    allTqUin.push(m[i].id);
                    if (m[i].t == "tq" && TQUtils.isInCode(m[i].o, TQKF.ONLINE)) {
                        TQKF.inviter.allKefuIsOffLine = false;
                        onlineUins[tqnum] = m[i].id;
                        TQ_DEBUG("onlineUins[" + tqnum + "]=" + m[i].id, 3);
                        tqnum++;
                    }
                }
                if (onlineUins.length > 0) {
                    var tqpos = Math.round(Math.random() * (tqnum - 1));
                    tq_appuin = onlineUins[tqpos];
                    TQ_DEBUG("tq_appuin=" + tq_appuin, 3);
                } else {
                    var tqpos = Math.round(Math.random() * (allTqUin.length - 1));
                    tq_appuin = allTqUin[tqpos];
                }
            } catch(e) {
                TQKF.inviter.allKefuIsOffLine = false;
                TQ_DEBUG("response type is kefu,but catch error,.allKefuIsOffLine = " + TQKF.inviter.allKefuIsOffLine + ",tq_appuin=" + tq_appuin, 3);
            }
            if (TQKF.inviter.allKefuIsOffLine == false) {
                return;
            }
        } else {
            TQKF.inviter.allKefuIsOffLine = false;
        }
        TQ_DEBUG("allKefuIsOffLine=" + TQKF.inviter.allKefuIsOffLine, 3);
    },
    Online: function() {
        if (TQKF.AS.cookies_handle_ok) {
            TQ_DEBUG("tq_cookies_handle_ok,start TQKF.inviter.SendOnlineMsg()", 3);
            TQKF.inviter.sendOnlinemsgTimer = setTimeout(TQKF.inviter.SendOnlineMsg, 3000);
        } else {
            TQ_DEBUG("tq_cookies_handle_ok=false)", 3);
            setTimeout(TQKF.inviter.Online, 100);
        }
    },
    SendOnlineMsg: function() {
        try {
            if (typeof(tq_adminid) == "undefined" || tq_adminid == null || tq_adminid == "NULL" || tq_adminid == "null" || tq_adminid == "" || tq_adminid == 0 || tq_adminid < 1000) return;
        } catch(e) {}
        TQ_DEBUG("send online msg", 3);
        try {
            var isautoinvit = "";
            if (TQKF.inviter.isSendAutoInvitPara == 1) isautoinvit = "&isautoinvit=1";
            var isfluxStr = "";
            if (TQKF.inviter.isflux != 0) isfluxStr = "&isflux=" + TQKF.inviter.isflux;
            var url_temp = TQKF.page_url.replace(/\&/g, "*");
            if (url_temp.length > 300) url_temp = url_temp.substring(0, 300);
            var sortStr = "";
            if (typeof(tq_title_en) != "undefined" && tq_title_en == "1") {
                if (typeof(tq_sort) == "undefined") tq_sort = -1;
                sortStr = "&sort=" + tq_sort;
            }
            var temp = TQKF.invite_server_url + "/scriptonline.js?uin=" + tq_adminid + sortStr + TQKF.inviter.CreatParaStr(tq_language, "ltype") + TQKF.inviter.CreatParaStr(TQKF.inviter.comflag, "comflag") + TQKF.inviter.CreatParaStr(TQKF.clientInfo.r, "rand") + TQKF.inviter.CreatParaStr(tq_clientid, "clientid") + TQKF.inviter.CreatParaStr(TQKF.clientInfo.cn, "nickname") + TQKF.inviter.CreatParaStr(tq_is_parse_ip, "isparseip") + isautoinvit + isfluxStr + TQKF.inviter.CreatParaStr(TQKF.winSize, "visionsize") + TQKF.inviter.CreatParaStr(TQKF.winColor, "visioncolor") + TQKF.inviter.CreatParaStr(TQKF.clientInfo.ct, "comtimes") + TQKF.inviter.CreatParaStr(unescape(TQKF.clientInfo.lv), "lastvisittime") + TQKF.inviter.CreatParaStr(TQKF.clientInfo.TalkTimes, "talktimes") + TQKF.inviter.CreatParaStr(unescape(TQKF.clientInfo.lt), "lasttalktime") + TQKF.inviter.CreatParaStr(TQKF.clientInfo.pu, "lasttalkuin") + ((TQUtils.IsUndefined('tq_siteid') || tq_siteid == "") ? "": "&siteid=" + tq_siteid) + TQKF.inviter.CreatParaStr(TQKF.visit_title, "visittitle") + TQKF.inviter.CreatParaStr(TQKF.local_url, "visiturl") + TQKF.inviter.CreatParaStr(url_temp.replace(/\^/g, "%"), "lastvisit") + "&nocache=" + parseInt(Math.random() * 100000000);
            TQ_DEBUG("send online msg url=" + temp, 3);
            TQUtils.LoadJS2(temp,
            function() {
                setTimeout(TQKF.inviter.RefreshParseIp, 200)
            });
        } catch(e) {
            TQ_DEBUG("send online Msg to server error", 1);
        }
    },
    CreatParaStr: function(para, paraName) {
        if (para == "") return "";
        return "&" + paraName + "=" + para
    },
    StartGetAppUin: function() {
        TQKF.inviter.online_msg_success = 1;
        try {
            clearTimeout(TQKF.inviter.sendOnlinemsgTimer);
        } catch(e) {}
        if (TQKF.inviter.refuse_msg_inqueue == 1) {
            TQKF.inviter.SendRefuseMsg();
            TQKF.inviter.refuse_msg_inqueue = 0;
        }
        setTimeout(TQKF.inviter.GetAppUin, TQKF.appDelayTime);
    },
    GetAppUin: function() {
        if (TQKF.isInviter == "2" || TQKF.isInviter == "3") return;
        if (TQKF.inviter.isStopGetJS == true) return;
        TQ_DEBUG("begin TQKF.inviter.GetAppUin(),send heartbeat ", 3);
        TQKF.inviter.getAppUinTimer = setTimeout(TQKF.inviter.GetAppUin, TQKF.appInterval);
        if (TQKF.appInterval < 12 * 1000) {
            if (TQKF.inviter.isInvited && TQKF.appInterval < (8 * 1000)) TQKF.appInterval = 8 * 1000;
            else TQKF.appInterval = TQKF.appInterval + 1 * 1000;
        } else {
            TQKF.appInterval = 12 * 1000;
        }
        var temp = TQKF.invite_server_url + "/getrequesttype.js?uin=" + tq_adminid + "&rand=" + TQKF.clientInfo.r + TQKF.inviter.CreatParaStr(tq_clientid, "clientid") + "&comflag=" + TQKF.inviter.comflag + "&isgetappwords=" + TQKF.inviter.isgetappwords + "&nocache=" + Math.random();
        TQ_DEBUG("send GetAppUin msg url=" + temp, 3);
        TQUtils.LoadJSAndAutoRemoveSelf("TQGetrequestUser_JS", temp);
    },
    StopGetAppUin: function() {
        TQ_DEBUG("TQKF.inviter.StopGetAppUin()", 3);
        TQKF.inviter.isStopGetJS = true;
        try {
            window.clearTimeout(TQKF.inviter.getAppUinTimer);
        } catch(e) {}
        if (tq_if_tryout == 0 && (tq_invit_response_uins == "" || tq_invit_response_uins[0].m.length == 0)) {
            TQKF.inviter.allKefuIsOffLine = true;
            if (tq_showtime == "1" && TQKF.isInviter != "2" && TQKF.isInviter != "3") {
                TQ_DEBUG("auto invit leavemsg when allKefuIsOffLine", 3);
                TQUtils.GetObj("tq_invit_message").style.display = "";
                TQUtils.GetObj("tq_invit_accept").style.display = "none";
                TQKF.inviter.Show();
            }
            tq_appuin = tq_adminid;
            if (typeof(tq_is_minimess) != "undefined" && tq_is_minimess == 2 && TQKF.isMinimessLoaded == false) {
                TQUtils.LoadJS(TQKF.userDefined.minimessJS, TQKF.userDefined.defer);
                TQKF.isMinimessLoaded = true;
            }
        }
    },
    GetOnlineStatus: function() {
        if (TQKF.floater.isClosed == true || TQKF.inviter.isStopGetJS == true || TQKF.isInviter == "2" || TQKF.isInviter == "3") return;
        var str = [];
        for (var j = 0; j < tq_invit_response_uins[0].m.length; j++) {
            var m = tq_invit_response_uins[0].m[j];
            if (m.t == "tq" || m.t == "tactic") {
                str.push("{\"t\":\"" + m.t + "\",\"id\":\"" + m.id + "\"}")
            }
        }
        var rstr = str.join(",");
        var rq_url = TQKF.float_server_url + "/getonlinestatus.js?adminid=" + tq_adminid + "&sort=" + tq_sort + "&m=[" + rstr + "]&callback=TQKF.inviter.RefreshOnlineStatus&nocache=" + Math.random();
        TQUtils.LoadJSAndAutoRemoveSelf("TQGetonlinestatus_JS_invite", rq_url);
        TQKF.getOnlineFlagInteval += 2000;
        setTimeout(TQKF.inviter.GetOnlineStatus, TQKF.getOnlineFlagInteval)
    },
    RefreshOnlineStatus: function(m_flags) {
        var index = 0;
        for (var j = 0; j < tq_invit_response_uins[0].m.length; j++) {
            var m = tq_invit_response_uins[0].m[j];
            if (m.t == "tq" || m.t == "tactic") {
                m.o = m_flags[index].o;
                index++
            }
        }
        if (TQKF.inviter.response_type == 1) {
            if (TQUtils.isInCode(tq_invit_response_uins[0].m[0].o, TQKF.ONLINE)) TQKF.inviter.allKefuIsOffLine = false;
            else {
                TQKF.inviter.allKefuIsOffLine = true
            }
        } else {
            for (var i = 0; i < m.length; i++) {
                if (m[i].t == "tq" && TQUtils.isInCode(m[i].o, TQKF.ONLINE)) {
                    TQKF.inviter.allKefuIsOffLine = false
                }
            }
        }
        if (TQKF.inviter.allKefuIsOffLine == true) {
            TQUtils.GetObj("tq_invit_message").style.display = "";
            TQUtils.GetObj("tq_invit_accept").style.display = "none"
        } else {
            TQUtils.GetObj("tq_invit_message").style.display = "none";
            TQUtils.GetObj("tq_invit_accept").style.display = ""
        }
    },
    Accept: function() {
        if (typeof(TQKF.userDefined.kefuClickEvent) != "undefined" && TQKF.userDefined.kefuClickEvent != null) {
            try {
                eval(TQKF.userDefined.kefuClickEvent + "()")
            } catch(e) {}
            return
        }
        if (typeof(TQKF.userDefined.invitClickEvents) != "undefined" && typeof(TQKF.userDefined.invitClickEvents.accept) != "undefined") {
            try {
                if (TQKF.userDefined.invitClickEvents.accept == "") return;
                else eval(TQKF.userDefined.invitClickEvents.accept + "()")
            } catch(e) {}
            return
        }
        try {
            this.Close()
        } catch(e) {}
        try {
            if (this.allKefuIsOffLine || !TQUtils.IsUndefined('TQ_RQC') && TQ_RQC == 3) {
                if (this.response_type == 1) {
                    this.chat_url = TQKF.CreatURL(TQKF.pageinfo_url, "acd&pagetype=leavemsg&tag=leavemsg", "", tq_invit_response_uins[0].m[0].id, "invite")
                } else {
                    this.chat_url = TQKF.CreatURL(TQKF.leavemsg_url, "leavemsg", tq_appuin, "", "invite")
                }
            } else {
                if ((tq_appuin == "" && this.response_type == 1) || TQUtils.IsUndefined("tq_isminichat") && ((!(TQUtils.IsUndefined("tq_isautoapp")) && (tq_isautoapp == 1 || tq_isautoapp == "1") || (this.isAutoInvit == 1)) && this.response_type == 1)) {
                    TQ_DEBUG("response kefu is tactic", 3);
                    this.chat_url = TQKF.CreatURL(TQKF.pageinfo_url, "acd", "", tq_invit_response_uins[0].m[0].id, "invite")
                } else {
                    TQ_DEBUG("response kefu is kefu " + tq_appuin, 3);
                    this.chat_url = TQKF.CreatURL(TQKF.webchat_url2, "chat", tq_appuin, "", "invite")
                }
            }
            var temp = TQKF.invite_server_url + "/sendmain.jsp?rand=" + TQKF.clientInfo.r + TQKF.inviter.CreatParaStr(tq_clientid, "clientid") + "&uin=" + tq_adminid + "&comflag=" + TQKF.inviter.comflag + "&nocache=" + Math.random() + "&msg=APPLYSUCC";
            TQUtils.LoadJS(temp, false);
            TQ_DEBUG("open win url=" + this.chat_url, 3);
            if (TQUtils.IsUndefined("tq_isminichat") || tq_isminichat == 0) TQKF.OpenWindow(this.chat_url, tq_appuin)
        } catch(e) {}
    },
    Refuse: function() {
        if (typeof(TQKF.userDefined.kefuClickEvent) != "undefined" && TQKF.userDefined.kefuClickEvent != null) {
            try {
                eval(TQKF.userDefined.kefuClickEvent + "()")
            } catch(e) {}
            return
        }
        if (typeof(TQKF.userDefined.invitClickEvents) != "undefined" && typeof(TQKF.userDefined.invitClickEvents.refuse) != "undefined") {
            try {
                if (TQKF.userDefined.invitClickEvents.refuse == "") return;
                else eval(TQKF.userDefined.invitClickEvents.refuse + "()")
            } catch(e) {}
            return
        }
        TQKF.inviter.isAutoInvit = 0;
        try {
            TQKF.inviter.Close()
        } catch(e) {}
        if (TQKF.inviter.online_msg_success == 1) {
            TQKF.inviter.SendRefuseMsg()
        } else {
            TQKF.inviter.refuse_msg_inqueue = 1
        }
    },
    SendRefuseMsg: function() {
        try {
            {
                var temp = TQKF.invite_server_url + "/sendmain.jsp?rand=" + TQKF.clientInfo.r + TQKF.inviter.CreatParaStr(tq_clientid, "clientid") + "&uin=" + tq_adminid + "&comflag=" + TQKF.inviter.comflag + "&nocache=" + Math.random() + "&msg=APPLYFAIL_DISAGREE";
                TQUtils.LoadJS(temp, false)
            }
        } catch(e) {}
    },
    OpenCallback: function() {
        if (typeof(TQKF.userDefined.kefuClickEvent) != "undefined" && TQKF.userDefined.kefuClickEvent != null) {
            try {
                eval(TQKF.userDefined.kefuClickEvent + "()")
            } catch(e) {}
            return
        }
        if (typeof(TQKF.userDefined.invitClickEvents) != "undefined" && typeof(TQKF.userDefined.invitClickEvents.call) != "undefined") {
            try {
                if (TQKF.userDefined.invitClickEvents.call == "") return;
                else eval(TQKF.userDefined.invitClickEvents.call + "()")
            } catch(e) {}
            return
        }
        if (this.response_type == 1) {
            TQKF.OpenWindow(TQKF.CreatURL(TQKF.pageinfo_url, "acd&tag=call&pagetype=leavemsg", "", tq_invit_response_uins[0].m[0].id, "invite"), "")
        } else {
            var toCallUin = tq_appuin;
            if (toCallUin == "" || toCallUin == "null" || toCallUin == null || toCallUin == 0) toCallUin = tq_adminid;
            TQKF.OpenWindow(TQKF.CreatURL(TQKF.leavemsg_url, "leavemsg&tag=call", toCallUin, "", "invite"), "")
        }
        try {
            TQKF.inviter.Close()
        } catch(e) {}
    },
    Anti: function() {
        TQKF.inviter.AntiKaKa(TQKF.inviter.DOM, 'TQKF.inviter', TQKF.inviter.DOMinnerHTML)
    },
    AntiKaKa: function(div, checkElement, savedHTML) {
        if (TQKF.inviter.isAntiKaKa) {
            if (div.innerHTML.indexOf(checkElement) == -1) {
                div.innerHTML = savedHTML;
                TQKF.inviter.isAntiKaKa = false
            }
            if (div.style.visibility == "hidden") {
                div.style.visibility = "visible"
            }
        }
    },
    ToggleFloat: function(m) {
        if (tq_invit_is_hide_float == 1) {
            try {
                if (TQKF.isFloater) {
                    if (m == "show") {
                        TQKF.floater.Show()
                    } else TQKF.floater.Hide()
                }
                if (TQKF.isKefuImg) {
                    if (m == "show") TQKF.kefuimg.Show();
                    else TQKF.kefuimg.Hide()
                }
            } catch(e) {}
        }
    },
    Init: function() {
        if (TQKF.inviter.hasInited) return;
        TQKF.inviter.hasInited = true;
        if (TQKF.isInviter != 2 && TQKF.isInviter != 3) {
            TQKF.inviter.AppendDOM();
            if (TQKF.inviter.t == 1) {
                TQ_DEBUG("TQKF.inviter.t == 1", 3);
                if (TQKF.userDefined.isNotCreatInvit == "0") TQKF.inviter.AdjustLayout()
            }
            setTimeout(function() {
                TQKF.inviter.SetPos();
                var t = TQKF.inviter.userCfg.bg.t;
                var l = TQKF.inviter.userCfg.bg.l;
                if ((t == "c" || l == "c")) {
                    TQUtils.AddEvent(window, "resize", TQKF.inviter.SetPos)
                }
                if (!TQUtils.isSupportFixedPos) {
                    TQUtils.AddEvent(window, "scroll", TQKF.inviter.fixPos);
                    TQUtils.AddEvent(window, "resize", TQKF.inviter.fixPos)
                }
                TQ_DEBUG("http://sysimages.tq.cn/js/vip/100501/TQUtils.Drag.init", 3);
                TQUtils.Drag.init(TQUtils.GetObj("tq_invit_head"), TQKF.inviter.DOM, null, null, null, null, (TQKF.inviter.userCfg.bg.l == "r" && TQUtils.isSupportFixedPos) ? true: false, (TQKF.inviter.userCfg.bg.t == "b" && TQUtils.isSupportFixedPos) ? true: false);
                TQKF.inviter.isgetappwords = (tq_not_reshow == "0");
                TQKF.inviter.IsAllKefuOffLine();
                TQKF.inviter.HandleAutoApp();
                TQKF.inviter.Online();
                if (TQKF.isUpdateOnlineFlag == 1) {
                    setTimeout(TQKF.inviter.GetOnlineStatus, TQKF.getOnlineFlagInteval)
                }
                if (tq_type == "3" && typeof(tq_is_minimess) != "undefined" && tq_is_minimess == 2 && TQKF.inviter.allKefuIsOffLine == true && TQKF.isMinimessLoaded == false) {
                    TQUtils.LoadJS(TQKF.userDefined.minimessJS, TQKF.userDefined.defer);
                    TQKF.isMinimessLoaded = true
                }
            },
            TQKF.userDefined.inviteInitDelay)
        } else {
            setTimeout(TQKF.inviter.Online, 1000)
        }
    }
};
function tq_ShowInviteDiv() {
    if ((TQKF.inviter.response_type == 1) && TQUtils.isInCode(tq_invit_response_uins[0].m[0].o, TQKF.BUSY) && !(TQUtils.IsUndefined("tq_isminichat")) && (tq_isminichat == 1 || tq_isminichat == "1")) TQKF.inviter.allKefuIsOffLine = false;
    if (TQKF.inviter.allKefuIsOffLine == true) {
        return
    }
    if (TQKF.inviter.isAutoInvit == 1) {
        if (! (TQUtils.IsUndefined("tq_isminichat")) && (tq_isminichat == 1 || tq_isminichat == "1")) {
            TQKF.inviter.Accept();
            TQKF.inviter.Show()
        } else return
    } else {
        TQKF.inviter.isAutoInvit = 0;
        TQKF.inviter.allKefuIsOffLine = false;
        TQKF.inviter.Show()
    }
}
function tq_StopGetJS() {
    TQKF.inviter.online_msg_success = 1;
    TQKF.inviter.StopGetAppUin();
    if (TQKF.inviter.refuse_msg_inqueue == 1) {
        setTimeout(function() {
            TQKF.inviter.SendRefuseMsg()
        },
        200);
        TQKF.inviter.refuse_msg_inqueue = 0
    }
}
if (tq_version == "" || parseInt(tq_version) < parseInt(TQKF.version)) {
    if (tq_if_tryout == 0) {
        tq_invit_style = 1;
        tq_invit_color = 1;
        if (tq_displaytype == 1) tq_displaytype = 0;
        else {
            tq_displaytype = 100
        }
        TQKF.inviter.c = tq_invit_color;
        TQKF.inviter.t = tq_invit_style;
        TQKF.inviter.s = tq_displaytype
    } else {
        if (tq_invit_style == 2) {
            TQKF.inviter.t = 1;
            TQKF.inviter.s = 10
        }
    }
    TQUtils.SetValueIfUndefinedOrEmpty("tq_acd", "0");
    TQKF.inviter.response_type = tq_acd;
    if (TQKF.inviter.response_type == 1) {
        var b = (tq_isalloffline == true) ? 0 : 22;
        tq_invit_response_uins = [{
            n: "",
            b: "",
            h: "",
            m: [{
                id: tq_tactic_id,
                n: "",
                t: "tacitc",
                w: "",
                o: b
            }]
        }]
    } else {
        tq_invit_response_uins = [{
            n: "",
            b: "",
            h: "",
            m: []
        }];
        for (var j = 0; j < tq_member_uins.length; j++) {
            var member = {};
            member.t = "tq";
            member.id = tq_member_uins[j];
            member.o = tq_OnLineFlagArray[j];
            tq_invit_response_uins[0].m.push(member)
        }
    }
    TQUtils.SetValueIfUndefinedOrEmpty("tq_invit_sound", "");
    TQUtils.SetValueIfUndefinedOrEmpty("tq_invit_auto_hide_delay", 0);
    TQUtils.SetValueIfUndefinedOrEmpty("tq_invit_is_hide_float", 0);
    TQUtils.SetValueIfUndefinedOrEmpty("tq_invit_response_uins", "");
    tq_invit_layout_cfg = TQKF.inviter.DefaultCfg["t" + TQKF.inviter.t]["s" + TQKF.inviter.s];
    tq_invit_layout_cfg.bg.img = tq_invit_bg_img;
    tq_invit_layout_cfg.accept.img = tq_invit_accept_img;
    tq_invit_layout_cfg.message.img = tq_invit_accept_img_en;
    tq_invit_layout_cfg.refuse.img = tq_invit_refuse_img;
    tq_invit_layout_cfg.call.img = tq_invit_call_img;
    if (TQKF.inviter.s == 10 || TQKF.inviter.s == 100) {
        tq_invit_layout_cfg.bg.effect = "slideH";
        tq_invit_layout_cfg.bg.t = "b";
        tq_invit_layout_cfg.bg.l = "r"
    }
    TQKF.inviter.invit_layout_cfg = tq_invit_layout_cfg
}
if (typeof(tq_invit_layout_cfg) == "string" && tq_invit_layout_cfg != "") {
    eval('TQKF.inviter.invit_layout_cfg=' + tq_invit_layout_cfg)
}
if (typeof(tq_invit_response_uins) == "string" && tq_invit_response_uins != "") {
    eval('tq_invit_response_uins=' + tq_invit_response_uins)
}
TQKF.inviter.response_type = TQKF.inviter.GetResponseType();
if (TQKF.isInviter != 2 && TQKF.isInviter != 3) TQKF.inviter.CreatDOM();
else {
    if (TQKF.isInviter == 2) TQKF.inviter.isflux = 1;
    else TQKF.isInviter.isflux = 2
}
setTimeout(TQKF.inviter.Init, TQKF.userDefined.inviteInitDelay);