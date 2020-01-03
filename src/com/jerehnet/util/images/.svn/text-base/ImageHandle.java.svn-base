package com.jerehnet.util.images;

import java.awt.Dimension;
import java.awt.Rectangle;
import java.io.IOException;

import magick.CompositeOperator;
import magick.CompressionType;
import magick.DrawInfo;
import magick.ImageInfo;
import magick.MagickException;
import magick.MagickImage;
import magick.PixelPacket;
import magick.PreviewType;

public class ImageHandle {
	static {
		setproperty();
	}

	public static void setproperty() {
		// 不能漏掉这个，不然jmagick.jar的路径找不到
		System.setProperty("jmagick.systemclassloader", "no");
	}

	/**
	 * 生成图片缩略图，根据传入的高宽
	 * 
	 * @param filePath
	 *            文件路径
	 * @param toPath
	 *            生成缩略图的路径
	 * @param width
	 *            生成缩略图的宽度
	 * @param height
	 *            生成缩略图的高度
	 * @throws Exception
	 */
	public static int createThumbnail(String filePath, String toPath,
			int wideth, int height) {
		ImageInfo info = null;
		MagickImage image = null;
		MagickImage scaleImg = null;

		try {
			// reading image
			info = new ImageInfo(filePath);
			image = new MagickImage(info);
			// resize image
			scaleImg = image.scaleImage(wideth, height);
			// write image to file
			scaleImg.setFileName(toPath);
			scaleImg.profileImage("*", null);
			scaleImg.writeImage(info);
			return 1;
		} catch (Exception e) {
			e.printStackTrace();
			return -1;
		} finally {
			if (scaleImg != null)
				scaleImg.destroyImages();
		}
	}

	/**
	 * 等比例压缩图片，根据传入的宽度
	 * 
	 * @param filePath
	 *            源文件路径
	 * @param toPath
	 *            目标文件路径
	 * @param width
	 *            宽度
	 * @throws MagickException
	 */
	public static int createThumbnail(String filePath, String toPath, int width)
			throws MagickException {
		ImageInfo info = null;
		MagickImage image = null;
		Dimension imageDim = null;
		MagickImage scaled = null;
		try {
			info = new ImageInfo(filePath);
			image = new MagickImage(info);
			imageDim = image.getDimension();
			int wideth = imageDim.width;
			int height = imageDim.height;
			height = width * height / wideth;
			wideth = width;
			scaled = image.scaleImage(wideth, height);// 小图片文件的大小.
			scaled.setFileName(toPath);
			scaled.profileImage("*", null);
			scaled.writeImage(info);
			return 1;
		} catch (Exception e) {
			e.printStackTrace();
			// TODO: handle exception
			return -1;
		} finally {
			if (scaled != null) {
				scaled.destroyImages();
			}
		}
	}

	/**
	 * 水印(图片logo)
	 * 
	 * @param filePath
	 *            源文件路径
	 * @param toImg
	 *            修改图路径
	 * @param logoPath
	 *            logo图路径
	 * @throws MagickException
	 */
	public static int initLogoImg(String filePath, String toImg, String logoPath)
			throws MagickException {
		ImageInfo info = new ImageInfo();
		MagickImage fImage = null;
		MagickImage sImage = null;
		MagickImage fLogo = null;
		MagickImage sLogo = null;
		Dimension imageDim = null;
		Dimension logoDim = null;
		try {
			fImage = new MagickImage(new ImageInfo(filePath));
			imageDim = fImage.getDimension();
			int width = imageDim.width;
			int height = imageDim.height;
			if (width > 660) {
				height = 660 * height / width;
				width = 660;
			}
			sImage = fImage.scaleImage(width, height);
			fLogo = new MagickImage(new ImageInfo(logoPath));
			logoDim = fLogo.getDimension();
			int lw = width / 8;
			int lh = logoDim.height * lw / logoDim.width;
			sLogo = fLogo.scaleImage(lw, lh);
			sImage.compositeImage(CompositeOperator.AtopCompositeOp, sLogo,
					width - (lw + lh / 10), height - (lh + lh / 10));
			// sImage.setMagick("jpg");
			// sImage.setCompression(90);
			sImage.setFileName(toImg);
			sImage.profileImage("*", null);
			sImage.writeImage(info);
			return 1;
		} catch (Exception e) {
			// TODO: handle exception
			return -1;
		} finally {
			if (sImage != null) {
				sImage.destroyImages();
			}
		}
	}

	/**
	 * 切图
	 * 
	 * @param imgPath
	 *            源图路径
	 * @param toPath
	 *            修改图路径
	 * @param w
	 *            宽度
	 * @param h
	 *            高度
	 * @param x
	 * @param y
	 * @throws MagickException
	 */
	public static int cutImg(String imgPath, String toPath, int w, int h,
			int x, int y) throws MagickException {
		ImageInfo infoS = null;
		MagickImage image = null;
		MagickImage cropped = null;
		Rectangle rect = null;
		try {
			infoS = new ImageInfo(imgPath);
			image = new MagickImage(infoS);
			rect = new Rectangle(x, y, w, h);
			cropped = image.cropImage(rect);
			cropped.setFileName(toPath);
			cropped.profileImage("*", null);
			cropped.writeImage(infoS);
			return 1;
		} catch (Exception e) {
			// TODO: handle exception
			return -1;
		} finally {
			if (cropped != null) {
				cropped.destroyImages();
			}
		}
	}

	/**
	 * 水印(文字,如果源图宽度大于660,则源图自动压缩为宽度为660)
	 * 
	 * @param filePath
	 *            源文件路径
	 * @param toImg
	 *            修改图路径
	 * @param text
	 *            名字(文字内容自己随意)
	 * @throws MagickException
	 */
	public static int initTextToImg(String filePath, String toImg, String text,
			int fontSize, String position) throws MagickException {
		ImageInfo info = new ImageInfo(filePath);
		if (filePath.toUpperCase().endsWith("JPG")
				|| filePath.toUpperCase().endsWith("JPEG")) {
			info.setCompression(CompressionType.JPEGCompression); // 压缩类别为JPEG格式
			info.setPreviewType(PreviewType.JPEGPreview); // 预览格式为JPEG格式
			info.setQuality(95);// 设置图片品质
		}

		MagickImage aImage = new MagickImage(info);

		// 根据源图的高度和宽度来计算出来缩略图的高度和宽度
		Dimension imageDim = aImage.getDimension();
		int wideth = imageDim.width;
		int height = imageDim.height;
		if (wideth > 660) {
			height = 660 * height / wideth;
			wideth = 660;
		}

		// 计算出字体的宽度 tl
		int a = 0;
		int b = 0;
		int c = 0;
		String[] as = text.split("");
		for (String string : as) {
			if (string.matches("[\u4E00-\u9FA5]")) {
				a++;
			}
			if (string.matches("[a-zA-Z0-9]")) {
				b++;
			}
			if (string.matches(" ")) {// 空格在这里占四个像素
				c++;
			}
		}
		int tl = a * fontSize + b * fontSize / 2 + c * 4;

		// 生成缩略图，并且对缩略图添加水印效果.
		MagickImage scaled = aImage.scaleImage(wideth, height);
		if (wideth > tl && height > 5) {
			DrawInfo aInfo = new DrawInfo(info);
			aInfo.setFill(PixelPacket.queryColorDatabase("white"));
			aInfo.setUnderColor(new PixelPacket(0, 0, 0, 100));// 设置背景颜色
			aInfo.setPointsize(fontSize);
			// 解决中文乱码问题,自己可以去随意定义个自己喜欢字体，我在这用的微软雅黑
			String fontPath = "C:/WINDOWS/Fonts/MSYH.TTF";
			// String fontPath = "/usr/maindata/MSYH.TTF";
			aInfo.setFont(fontPath);
			aInfo.setTextAntialias(true);
			aInfo.setOpacity(0);// 透明度 0 - 100, 0 为不透明
			aInfo.setText(text);
			// aInfo.setText(" " + text + "于 "+
			// newSimpleDateFormat("yyyy-MM-dd").format(new
			// Date())+"上传于网络,作者朱华清,版权归作者所有！ ");
			// aInfo.setGeometry("+" + (wideth - tl) + "+" + (height - 5));//右下
			// aInfo.setGeometry("+" + 0 + "+" + fontSize);//左上
			// aInfo.setGeometry("+" + (wideth - tl) + "+" + fontSize);//右上
			// aInfo.setGeometry("+" + (wideth-tl)/2 + "+" + height/2);//中间
			// aInfo.setGeometry("+" + 0 + "+" + (height-fontSize));//左下

			// position
			if ("topleft".equals(position)) {
				aInfo.setGeometry("+" + 0 + "+" + fontSize);// 左上
			} else if ("topright".equals(position)) {
				aInfo.setGeometry("+" + (wideth - tl) + "+" + fontSize);// 右上
			} else if ("middle".equals(position)) {
				aInfo.setGeometry("+" + (wideth - tl) / 2 + "+" + height / 2);
			} else if ("bottomleft".equals(position)) {
				aInfo.setGeometry("+" + 0 + "+" + (height - fontSize));
			} else if ("bottomright".equals(position)) {
				aInfo.setGeometry("+" + (wideth - tl) + "+"
						+ (height - fontSize));
			}
			scaled.annotateImage(aInfo);
		}
		scaled.setFileName(toImg);
		scaled.profileImage("*", null);
		scaled.writeImage(info);
		scaled.destroyImages();
		return 1;
	}


	public static void main(String[] args) {
		try {
			Runtime.getRuntime()
					.exec("cmd /c convert -colorspace rgb E:/workspace/lg_ziliao/WebRoot/uploadfiles/small/1206201755504.jpg E:/workspace/lg_ziliao/WebRoot/uploadfiles/small/123.jpg");
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
