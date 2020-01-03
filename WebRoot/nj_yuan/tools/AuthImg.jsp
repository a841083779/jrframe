<%@ page pageEncoding="utf-8" contentType="image/jpeg"
	import="javax.imageio.*,java.util.*,java.awt.image.*,java.awt.*"%>
<%!//在此处 获取并生成随机颜色
	Color getRandColor(Random random, int ff, int cc) {
		if (ff > 255)
			ff = 255;
		if (cc > 255)
			cc = 255;
		int r = ff + random.nextInt(cc - ff);
		int g = ff + random.nextInt(cc - ff);
		int b = ff + random.nextInt(cc - ff);
		return new Color(r, g, b);
	}%>
<%
	//在此处 设置JSP页面无缓存
	response.setHeader("Pragma", "No-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setDateHeader("Expires", 0);
	// 设置图片的长宽
	int width = 60;
	int height = 20;
	//设定被随机选取的中文字，此处中文字内容过多，不一一列出，只是举例说明下。
	String base = "\u7684\u4e00\u662f\u5728\u4e0d\u4e86\u6709\u548c\u4eba\u8fd9\u4e2d\u5927\u4e3a\u4e0a\u4e2a\u56fd\u6211\u4ee5\u8981\u4ed6\u65f6\u6765\u7528\u4eec\u751f\u5230\u4f5c\u5730\u4e8e\u51fa\u5c31\u5206\u5bf9\u6210\u4f1a\u53ef\u4e3b\u53d1\u5e74\u52a8\u540c\u5de5\u4e5f\u80fd\u4e0b\u8fc7\u5b50\u8bf4\u4ea7\u79cd\u9762\u800c\u65b9\u540e\u591a\u5b9a\u884c\u5b66\u6cd5\u6240\u6c11\u5f97\u7ecf\u5341\u4e09\u4e4b\u8fdb\u7740\u7b49\u90e8\u5ea6\u5bb6\u7535\u529b\u91cc\u5982\u6c34\u5316\u9ad8\u81ea\u4e8c\u7406\u8d77\u5c0f\u7269\u73b0\u5b9e\u52a0\u91cf\u90fd\u4e24\u4f53\u5236\u673a\u5f53\u4f7f\u70b9\u4ece\u4e1a\u672c\u53bb\u628a\u6027\u597d\u5e94\u5f00\u5b83\u5408\u8fd8\u56e0\u7531\u5176\u4e9b\u7136\u524d\u5916\u5929\u653f\u56db\u65e5\u90a3\u793e\u4e49\u4e8b\u5e73\u5f62\u76f8\u5168\u8868\u95f4\u6837\u4e0e\u5173\u5404\u91cd\u65b0\u7ebf\u5185\u6570\u6b63\u5fc3\u53cd\u4f60\u660e\u770b\u539f\u53c8\u4e48\u5229\u6bd4\u6216\u4f46\u8d28\u6c14\u7b2c\u5411\u9053\u547d\u6b64\u53d8\u6761\u53ea\u6ca1\u7ed3\u89e3\u95ee\u610f\u5efa\u6708\u516c\u65e0\u7cfb\u519b\u5f88\u60c5\u8005\u6700\u7acb\u4ee3\u60f3\u5df2\u901a\u5e76\u63d0\u76f4\u9898\u515a\u7a0b\u5c55\u4e94\u679c\u6599\u8c61\u5458\u9769\u4f4d\u5165\u5e38\u6587\u603b\u6b21\u54c1\u5f0f\u6d3b\u8bbe\u53ca\u7ba1\u7279\u4ef6\u957f\u6c42\u8001\u5934\u57fa\u8d44\u8fb9\u6d41\u8def\u7ea7\u5c11\u56fe\u5c71\u7edf\u63a5\u77e5\u8f83\u5c06\u7ec4\u89c1\u8ba1\u522b\u5979\u624b\u89d2\u671f\u6839\u8bba\u8fd0\u519c\u6307\u51e0\u4e5d\u533a\u5f3a\u653e\u51b3\u897f\u88ab\u5e72\u505a\u5fc5\u6218\u5148\u56de\u5219\u4efb\u53d6\u636e\u5904\u961f\u5357\u7ed9\u8272\u5149\u95e8\u5373\u4fdd\u6cbb\u5317\u9020\u767e\u89c4\u70ed\u9886\u4e03\u6d77\u53e3\u4e1c\u5bfc\u5668\u538b\u5fd7\u4e16\u91d1\u589e\u4e89\u6d4e\u9636\u6cb9\u601d\u672f\u6781\u4ea4\u53d7\u8054\u4ec0\u8ba4\u516d\u5171\u6743\u6536\u8bc1\u6539\u6e05\u5df1\u7f8e\u518d\u91c7\u8f6c\u66f4\u5355\u98ce\u5207\u6253\u767d\u6559\u901f\u82b1\u5e26\u5b89\u573a\u8eab\u8f66\u4f8b\u771f\u52a1\u5177\u4e07\u6bcf\u76ee\u81f3\u8fbe\u8d70\u79ef\u793a\u8bae\u58f0\u62a5\u6597\u5b8c\u7c7b\u516b\u79bb\u534e\u540d\u786e\u624d\u79d1\u5f20\u4fe1\u9a6c\u8282\u8bdd\u7c73\u6574\u7a7a\u5143\u51b5\u4eca\u96c6\u6e29\u4f20\u571f\u8bb8\u6b65\u7fa4\u5e7f\u77f3\u8bb0\u9700\u6bb5\u7814\u754c\u62c9\u6797\u5f8b\u53eb\u4e14\u7a76\u89c2\u8d8a\u7ec7\u88c5\u5f71\u7b97\u4f4e\u6301\u97f3\u4f17\u4e66\u5e03\u590d\u5bb9\u513f\u987b\u9645\u5546\u975e\u9a8c\u8fde\u65ad\u6df1\u96be\u8fd1\u77ff\u5343\u5468\u59d4\u7d20\u6280\u5907\u534a\u529e\u9752\u7701\u5217\u4e60\u54cd\u7ea6\u652f\u822c\u53f2\u611f\u52b3\u4fbf\u56e2\u5f80\u9178\u5386\u5e02\u514b\u4f55\u9664\u6d88\u6784\u5e9c\u79f0\u592a\u51c6\u7cbe\u503c\u53f7\u7387\u65cf\u7ef4\u5212\u9009\u6807\u5199\u5b58\u5019\u6bdb\u4eb2\u5feb\u6548\u65af\u9662\u67e5\u6c5f\u578b\u773c\u738b\u6309\u683c\u517b\u6613\u7f6e\u6d3e\u5c42\u7247\u59cb\u5374\u4e13\u72b6\u80b2\u5382\u4eac\u8bc6\u9002\u5c5e\u5706\u5305\u706b\u4f4f\u8c03\u6ee1\u53bf\u5c40\u7167\u53c2\u7ea2\u7ec6\u5f15\u542c\u8be5\u94c1\u4ef7\u4e25";
	String base_e = "0123456789abcdefghijklmnopqistuvwxyz" ;
	//设置 备选随机汉字的个数
	int length = base_e.length();
	// 创建缓存图像
	BufferedImage image = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);
	// 获取图像
	Graphics g = image.getGraphics();
	// 创建随机函数的实例
	Random random = new Random();
	//此处 设定图像背景色
	g.setColor(getRandColor(random, 188, 235));
	g.fillRect(0, 0, width, height);
	//设置随机 备选的字体类型
	String[] fontTypes = { "\u5b8b\u4f53", "\u65b0\u5b8b\u4f53", "\u5fae\u8f6f\u96c5\u9ed1", "\u6977\u4f53", "\u96b6\u4e66" };
	int fontTypesLength = fontTypes.length;
	// 在图片背景上增加噪点，增加图片分析难度
	g.setColor(getRandColor(random, 180, 199));
	g.setFont(new Font("Times New Roman", Font.PLAIN, 14));
	for (int i = 0; i < 4; i++) {
		g.drawString("@*@*@*@*@*@*@*", 0, 5 * (i + 2));
	}
	// 取随机产生的验证码 (4 个汉字 )
	// 保存生成的汉字字符串
	StringBuffer sRand = new StringBuffer("");
	for (int i = 0; i < 4; i++) {
		int start = random.nextInt(length);
	    StringBuffer rand = new StringBuffer((base_e).substring(start, start + 1).toUpperCase());
		sRand.append(rand);
		// 设置图片上字体的颜色
		g.setColor(getRandColor(random, 10, 150));
		// 设置字体格式
		g.setFont(new Font(fontTypes[random.nextInt(fontTypesLength)], Font.BOLD, 18));
		// 将此汉字画到验证图片上面
		g.drawString(rand.toString(), 15 * i  + random.nextInt(5), 18);
	}
	// 将验证码存入S ession中
	session.setAttribute("rand", sRand.toString());
	g.dispose();
	//将 图象输出到JSP页面中
	ImageIO.write(image, "JPEG", response.getOutputStream());
	//关闭流
	out.clear();
	out = pageContext.pushBody();
%>