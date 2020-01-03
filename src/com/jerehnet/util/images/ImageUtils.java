package com.jerehnet.util.images;

import java.awt.Image;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.imageio.ImageIO;

import net.coobird.thumbnailator.Thumbnails;
import net.coobird.thumbnailator.geometry.Positions;

import com.jerehnet.util.common.Env;

/**
 * 图片工具类
 * 
 * @author Administrator
 * 
 */
public class ImageUtils {

	/**
	 * 生成 300 最大宽或高的缩略图
	 * 
	 * @param pathFile
	 *            文件路径
	 * @throws IOException
	 */
	public static void createThumbnail(String pathFile) throws IOException {
		Integer width = 100;
		try {
			String widthStr = Env.getInstance().getProperty("small_img");
			width = Integer.parseInt(widthStr);
		} catch (Exception e) {
			width = 100;
		}
		createThumbnail(pathFile, width);
	}

	/**
	 * 生成缩略图
	 * 
	 * @param pathFile
	 *            文件路径
	 * @param offset
	 *            最大宽或高
	 * @throws IOException
	 */
	public static void createThumbnail(String pathFile, int offset)
			throws IOException {
		if (null != pathFile && !"".equals(pathFile)
				&& pathFile.indexOf(".") != -1) {
			pathFile = pathFile.toLowerCase();
			// 扩展名
			String ex = pathFile.substring(pathFile.lastIndexOf("."));
			if (ex.equals(".jpg") || ex.equals(".png") || ex.equals(".gif")
					|| ex.equals(".bmp")) {

				String fPath = pathFile;
				if (pathFile.lastIndexOf("\\") != -1) {
					fPath = pathFile.substring(0, pathFile.lastIndexOf("\\"));
				}
				if (pathFile.lastIndexOf("/") != -1) {
					fPath = pathFile.substring(0, pathFile.lastIndexOf("/"));
				}
				String bPath = pathFile;
				if (pathFile.lastIndexOf("\\") != -1) {
					bPath = pathFile.substring(pathFile.lastIndexOf("\\"));
				}
				if (pathFile.lastIndexOf("/") != -1) {
					bPath = pathFile.substring(pathFile.lastIndexOf("/"));
				}
				File fPathFile = new File(fPath + "/small");
				if (!fPathFile.exists()) {
					fPathFile.mkdir();
				}
				String path = fPath + "/small" + bPath;
				File oldFile = new File(pathFile);
				File newFile = new File(path);
				if (newFile.exists()) {
					newFile.delete();
				}
				try {
					BufferedImage o = ImageIO.read(oldFile);
					if (null != o) {
						float width = o.getWidth();
						float height = o.getHeight();
						float scale = 0;
						if (width > height) {
							scale = offset / width;
							width = offset;
							height = Math.round(height * scale);
							if (height == 0) {
								height = 1;
							}
						} else {
							scale = offset / height;
							height = offset;
							width = Math.round(width * scale);
							if (width == 0) {
								width = 1;
							}
						}
						Thumbnails.of(pathFile).size((int) width, (int) height)
								.keepAspectRatio(false).outputQuality(1f)
								.toFile(newFile);
						if (null != o) {
							o.flush();
						}
					}
				} catch (Exception e) {
					e.printStackTrace();
					// 将原文件复制到小图中
					try {
						int bytesum = 0;
						int byteread = 0;
						InputStream inStream = new FileInputStream(pathFile); // 读入原文件
						FileOutputStream fs = new FileOutputStream(path);
						byte[] buffer = new byte[1444];
						while ((byteread = inStream.read(buffer)) != -1) {
							bytesum += byteread; // 字节数 文件大小
							fs.write(buffer, 0, byteread);
						}
						fs.close();
						inStream.close();
					} catch (Exception e2) {
						e2.printStackTrace();
					}
				}
			}
		}
	}

	/**
	 * 限定图片分辨率
	 * 
	 * @param imgFile
	 *            文件
	 * @param maxWidth
	 *            最大宽度
	 * @param maxHeight
	 *            最大高度
	 * @return
	 * @throws IOException
	 */
	public static boolean resizeImg(File imgFile) throws IOException {
		Integer width = 674;
		try {
			String widthStr = Env.getInstance().getProperty("upload_img_width");
			width = Integer.parseInt(widthStr);
		} catch (Exception e) {
			width = 674;
		}
		Integer height = 506;
		try {
			String heightStr = Env.getInstance().getProperty(
					"upload_img_height");
			width = Integer.parseInt(heightStr);
		} catch (Exception e) {
			height = 506;
		}
		return resizeImg(imgFile, width, height);
	}

	/**
	 * 根据高度等比例缩放
	 * 
	 * @param imgFile
	 *            文件
	 * @param toHeight
	 *            高度缩小尺寸
	 * @return
	 */
	public static void resizeImgByHeight(File imgFile, int toHeight) {
		try {
			BufferedImage o = ImageIO.read(imgFile);
			if (null != o) {
				float width = o.getWidth();
				float height = o.getHeight();
				float scale = 0;
				scale = toHeight / height;
				height = toHeight;
				width = Math.round(width * scale);
				if (width == 0) {
					width = 1;
				}
				Thumbnails.of(imgFile).size((int) width, (int) height)
						.keepAspectRatio(false).outputQuality(1f).toFile(
								imgFile);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	/**
	 * 根据宽度等比例缩放
	 * 
	 * @param imgFile
	 *            文件
	 * @param width
	 *            宽度缩小尺寸
	 * @return
	 */
	public static void resizeImgByWidth(File imgFile, int toWidth) {
		try {
			BufferedImage o = ImageIO.read(imgFile);
			if (null != o) {
				float width = o.getWidth();
				float height = o.getHeight();
				float scale = 0;
				scale = toWidth / width;
				width = toWidth;
				height = Math.round(height * scale);
				if (height == 0) {
					height = 1;
				}
				Thumbnails.of(imgFile).size((int) width, (int) height)
						.keepAspectRatio(false).outputQuality(1f).toFile(
								imgFile);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	/**
	 * 限定图片分辨率
	 * 
	 * @param imgFile
	 *            文件
	 * @param maxWidth
	 *            最大宽度
	 * @param maxHeight
	 *            最大高度
	 * @return
	 * @throws IOException
	 */
	public static boolean resizeImg(File imgFile, int maxWidth, int maxHeight)
			throws IOException {
		boolean isResize = false;
		try {
			BufferedImage o = ImageIO.read(imgFile);
			if (null != o) {
				float width = o.getWidth();
				float height = o.getHeight();
				float scale = 0;
				if (width > height) {
					if (width > maxWidth) {
						isResize = true;
						scale = maxWidth / width;
						width = maxWidth;
						height = Math.round(height * scale);
						if (height == 0) {
							height = 1;
						}
					}
				} else {
					if (height > maxHeight) {
						isResize = true;
						scale = maxHeight / height;
						height = maxHeight;
						width = Math.round(width * scale);
						if (width == 0) {
							width = 1;
						}
					}
				}
				if (isResize) {
					Thumbnails.of(imgFile).size((int) width, (int) height)
							.keepAspectRatio(false).outputQuality(1f).toFile(
									imgFile);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return isResize;
	}

	/**
	 * 计算图片尺寸大小等信息：w宽、h高、s大小。异常时返回null。
	 * 
	 * @param imgpath
	 *            图片路径
	 * @return 图片信息map
	 */
	public static Map<String, Long> getImgInfo(String imgpath) {
		Map<String, Long> map = new HashMap<String, Long>(3);
		File imgfile = new File(imgpath);
		try {
			FileInputStream fis = new FileInputStream(imgfile);
			BufferedImage buff = ImageIO.read(imgfile);
			map.put("w", buff.getWidth() * 1L);
			map.put("h", buff.getHeight() * 1L);
			map.put("s", imgfile.length());
			fis.close();
		} catch (FileNotFoundException e) {
			System.err.println("所给的图片文件" + imgfile.getPath()
					+ "不存在！计算图片尺寸大小信息失败！");
			map = null;
		} catch (IOException e) {
			System.err.println("计算图片" + imgfile.getPath() + "尺寸大小信息失败！");
			map = null;
		}
		return map;
	}

	/**
	 * 修改某文件夹下的所有图片大小
	 * 
	 * @param ex
	 *            扩展名集合
	 * @param folder
	 *            文件夹
	 * @throws IOException
	 */
	public static void resizeFoderAllImg(List<String> ex, File folder)
			throws IOException {
		File[] files = folder.listFiles();
		String exStr = "";
		for (int i = 0; i < files.length; i++) {
			if (files[i].isDirectory()) {
				resizeFoderAllImg(ex, files[i]);
			} else {
				exStr = files[i].getName().substring(
						files[i].getName().indexOf("."));
				if (ex.contains(exStr)) {
					ImageUtils.resizeImg(files[i]);
				}
			}
		}
	}

	/**
	 * 创建某文件夹下的所有图片缩略图
	 * 
	 * @param ex
	 *            扩展名集合
	 * @param folder
	 *            文件夹
	 * @throws IOException
	 */
	public static void createSmallFoderAllImg(List<String> ex, File folder)
			throws IOException {
		File[] files = folder.listFiles();
		String exStr = "";
		for (int i = 0; i < files.length; i++) {
			if (files[i].isDirectory()) {
				resizeFoderAllImg(ex, files[i]);
			} else {
				exStr = files[i].getName().substring(
						files[i].getName().indexOf("."));
				if (ex.contains(exStr)) {
					createThumbnail(files[i].getAbsolutePath());
				}
			}
		}
	}

	/**
	 * 把图片印刷到图片上
	 * 
	 * @param pressImg --
	 *            水印文件
	 * @param targetImg --
	 *            目标文件
	 * @param x
	 *            --x坐标
	 * @param y
	 *            --y坐标
	 */
	public final static void pressImage(String pressImg, String targetImg) {
		pressImage(pressImg, targetImg, Positions.BOTTOM_RIGHT);
	}

	/**
	 * 把图片印刷到图片上
	 * 
	 * @param pressImg --
	 *            水印文件
	 * @param targetImg --
	 *            目标文件
	 * @param positions
	 *            位置
	 */
	public final static void pressImage(String pressImg, String targetImg,
			Positions positions) {
		try {
			File _file = new File(targetImg);
			Image src = ImageIO.read(_file);
			int width = src.getWidth(null);
			int height = src.getHeight(null);
			Thumbnails.of(_file).size(width, height).keepAspectRatio(false)
					.watermark(positions, ImageIO.read(new File(pressImg)),
							0.5f).outputQuality(0.9f).toFile(_file);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public static byte[] imageToBytes(File file) {// file是读取图片形成的File
		InputStream is = null;
		try {
			is = new FileInputStream(file);
		} catch (FileNotFoundException e1) {
			e1.printStackTrace();
		}
		// 获取文件大小
		long length = file.length();
		if (length > Integer.MAX_VALUE) {
			// 文件太大，无法读取
			try {
				throw new IOException("File is to large " + file.getName());
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		// 创建一个数据来保存文件数据
		byte[] bytes = new byte[(int) length];

		// 读取数据到byte数组中
		int offset = 0;
		int numRead = 0;
		try {
			while (offset < bytes.length
					&& (numRead = is.read(bytes, offset, bytes.length - offset)) >= 0) {
				offset += numRead;
			}
		} catch (IOException e) {
			e.printStackTrace();
		}

		// 确保所有数据均被读取
		if (offset < bytes.length) {
			try {
				throw new IOException("Could not completely read file "
						+ file.getName());
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		try {
			is.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return bytes;
	}
}