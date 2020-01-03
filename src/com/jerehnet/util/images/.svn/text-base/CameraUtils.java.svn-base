package com.jerehnet.util.images;

import java.io.FileOutputStream;
import java.net.URLDecoder;
import java.net.URLEncoder;

public class CameraUtils {
	/**
	 * Camera模式生成上传flash用
	 * 
	 * @param flashPath
	 *            flash路径
	 * @param uploadPath
	 *            上传路径
	 * @param input
	 * @param uploadSize 可上传的文件大小
	 * @return
	 */
	@SuppressWarnings("deprecation")
	public static String renderHtml(String flashPath, String uploadPath,
			String input,Integer uploadSize) {
		String outinput = "";
		try {
			outinput = URLDecoder.decode(input);
		} catch (Exception e) {
			System.out.println("解码错误!");
		}
		@SuppressWarnings("unused")
		String[] tmp_input = outinput.split("@");// input传递的类型和uid
		String uc_api = URLEncoder.encode(uploadPath);
		String urlCameraFlash = flashPath
				+ "camera.swf?nt=1&inajax=1&appid=1&input=" + input
				+ "&uploadSize="+uploadSize+"&ucapi=" + uc_api;
		urlCameraFlash = "<script src=\""
				+ flashPath
				+ "common.js?B6k\" type=\"text/javascript\"></script><script type=\"text/javascript\">document.write(AC_FL_RunContent(\"width\",\"450\",\"height\",\"253\",\"scale\",\"exactfit\",\"src\",\""
				+ urlCameraFlash
				+ "\",\"id\",\"mycamera\",\"name\",\"mycamera\",\"quality\",\"high\",\"bgcolor\",\"#ffffff\",\"wmode\",\"transparent\",\"menu\",\"false\",\"swLiveConnect\",\"true\",\"allowScriptAccess\",\"always\"));</script>";
		return urlCameraFlash;
	}

	public static byte[] getFlashDataDecode(String src) {
		char[] s = src.toCharArray();
		int len = s.length;
		byte[] r = new byte[len / 2];
		for (int i = 0; i < len; i = i + 2) {
			int k1 = s[i] - 48;
			k1 -= k1 > 9 ? 7 : 0;
			int k2 = s[i + 1] - 48;
			k2 -= k2 > 9 ? 7 : 0;
			r[i / 2] = (byte) (k1 << 4 | k2);
		}
		return r;
	}
	
	public static boolean saveFile(String path, byte[] b) {
		try {
			FileOutputStream fs = new FileOutputStream(path);
			fs.write(b, 0, b.length);
			fs.close();
			return false;
		} catch (Exception e) {
			return true;
		}
	}
}
