package com.jerehnet.alipay.config;

public class AlipayConfig {
	// 商户appid
	public static String APPID = "2016031001199173";
	// 私钥 pkcs8格式的
	public static String RSA_PRIVATE_KEY = "MIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQDJVCFgkGr/ZQ4TscmSfJw5q2bVRqX50bDA7wRj3GdWB/kYGNfL1OlSbXWQc0Pyybigx+AQkRQPY8gWs/RgEwWTLP2BdJO1ZEYOg6WQzWaf3N6aHPs3svZPb/+PIABT0t0I1ARiOauB6eLdO3UOrBEKzyesm51xkT4M4MwoFyooGi/K0zLL7NrC2Q+K9cc7/e29v+XZfKs5gjIjj2X9qlXgnra5QeuVJ0Yna8Ku9J8DDkf+JHchqfD8OdibdFI2gogtwKBitP7uQmkyrxR/93QzymwOW6JeUsJeGi1OZpi+x5+u3ph0t91BcJ2/m9tYILzXavvoVuAtitEqeua/rfoLAgMBAAECggEAR1Tbjo8cmeiAGFJBjPlBkN09zgr9+4lkCrek4ozQwBaLFxKWQs3o7R+DK+7rADagh7bJmJUOenVsCz8vMmsK6p5iI1/ehcJFYBccrjVYSwPCivABwjZSNssDzP4Vn51yWxJjiznLnnfzvVa3nr8wOpgzAmEQY5CGX6G2M+4hLZuYsVVe+KwHbRtMrs8wjZ4RsgEoZK1V0yhSt+ydiJp59V+iBtOLFpk/J4z3psLsS+nZIA0HBHlHRqOv/tto49OBDlv+2dv799wVXoawt++SI1wjVcGg4lcs2GBe6xqOXLG/Ea5+hKBUwDFOpSBBN5sa9IBinPG6gyP8DJTiJCcygQKBgQDoKZohMJnyFRG1pwJSxo8LSPvKQB8fiLaRVK0G+eK3+jE8Z2HnWKON1vEtDg4vfpJ+9DhVqvouHK3cyBIn6u76Bob++WJR7WKX152zQbeYYhb0AjopQ7hv7nAID3ulDWrjRAnSkQdwwCJwBac4boZJDyOcNRKwf1/yZ4ZY2RvT0QKBgQDeAA8gW5EAIKECMlFlDxepnErOfgEg9qBB27mEwDf0g5UKw5doL/E+rZKKHxXxDUIAwpbOwn216KSP+S8DGUxS/qRAMduskGs/iFubvBt/WnlQxw9GWGLacf0PpIH6XDRBQKeGOAVYWH2CuWT6JMgn2Lw/lLOLZglc+CEnRMwzGwKBgQCIjg/OfdvO/H2SL026ingQ1zji2Zx02+Em0nuDou+r70mOkfCQNx7cixUIvz+wx+47JkMMgKju/od1WWj0ecde4P/+cYlXTx2y2mwzx+/JfciqdbToGKEflUvoMdM0XhQE4Tw10oBh3WFkKq8VDk2GI5V6h+0aS5GP7zyiffFUQQKBgBjDDOzhCcVn3k2uayHIky0Z/8YUi++vUqTF62WBQzyEyMUQl/zJDDGfjq7VVM80WV5YVhXt37PApUph0vqXgcnoGU4Hwab33N6TSRSP4MlNwCZgbbW8+hm/iSiLguv4COQWYBk6em4mQKmqIDc+jwzSwfydi4FK+lRiYOBObjBtAoGAf2eU8oRbIgM0tur6u3Qn9ykN8J/GtWKaXybJm5+WqQBJjaIkCLFAUcgatqx98cjuBnLwEMSdEpmNzpTcRp55/UpEf3fSkxr5b3xXMs+lw5ag6fgbfMsjn2t0QrzcDWqYvQtHd9M/O3ahklzJ6aU200cqzzHjY+b33BzwWBwpBYs=";
	// 服务器异步通知页面路径 需http://或者https://格式的完整路径，不能加?id=123这类自定义参数，必须外网可以正常访问
	public static String notify_url = "http://product.21-sun.com/activity/sany518/action/alipay/notify_url.jsp";
	// 页面跳转同步通知页面路径 需http://或者https://格式的完整路径，不能加?id=123这类自定义参数，必须外网可以正常访问 商户可以自定义同步跳转地址
	public static String return_url = "http://product.21-sun.com/activity/sany518/alipay_success.jsp";
	// 请求网关地址
	public static String URL = "https://openapi.alipay.com/gateway.do";
	// 编码
	public static String CHARSET = "UTF-8";
	// 返回格式
	public static String FORMAT = "json";
	// 支付宝公钥
	public static String ALIPAY_PUBLIC_KEY = "MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAjrEVFMOSiNJXaRNKicQuQdsREraftDA9Tua3WNZwcpeXeh8Wrt+V9JilLqSa7N7sVqwpvv8zWChgXhX/A96hEg97Oxe6GKUmzaZRNh0cZZ88vpkn5tlgL4mH/dhSr3Ip00kvM4rHq9PwuT4k7z1DpZAf1eghK8Q5BgxL88d0X07m9X96Ijd0yMkXArzD7jg+noqfbztEKoH3kPMRJC2w4ByVdweWUT2PwrlATpZZtYLmtDvUKG/sOkNAIKEMg3Rut1oKWpjyYanzDgS7Cg3awr1KPTl9rHCazk15aNYowmYtVabKwbGVToCAGK+qQ1gT3ELhkGnf3+h53fukNqRH+wIDAQAB";
	// 日志记录目录
	public static String log_path = "/log";
	// RSA2
	public static String SIGNTYPE = "RSA2";
}
