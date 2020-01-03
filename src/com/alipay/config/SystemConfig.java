package com.alipay.config;

import java.io.IOException;
import java.io.InputStream;
import java.util.Map;
import java.util.Properties;
import java.util.concurrent.ConcurrentHashMap;

/**
 * Modified by hedf on 20160622, add:
 * 多配置文件访问. (默认读取config.properties)
 */
public class SystemConfig {

  /**
   * 系统默认编码
   */
  public static final String ENCODING = "UTF-8";

  /**
   * 默认配置文件名
   */
  public static final String DEFAULT_CONF = "config.properties";

  /**
   * 当前系统是否属于LINUX/UNIX
   */
  public static final boolean SYS_LINUX;

  private static final Map<String, Properties> CONFS = new ConcurrentHashMap<String, Properties>(16, .75f, 16);

  static {
    SYS_LINUX = !System.getProperty("os.name").toString().toUpperCase().contains("WINDOWS");
  }

  private static final Map<Object, Object> PROPS = new ConcurrentHashMap<Object, Object>(512, .75f, 1000);

  /**
   * 读取配置项
   *
   * @param key
   * @return
   */
  public static String get(String key) {
    return get(DEFAULT_CONF, key);
  }

  /**
   * 从指定配置集合中读取配置项
   *
   * @param propertiesName
   * @param key
   * @return
   */
  public static String get(String propertiesName, String key) {
    validProps(propertiesName);

    Object o = PROPS.get(key);
    if (o != null)
      return o.toString();
    return null;
  }

  /**
   * 读取长整型配置项
   *
   * @param key
   * @return
   */
  public static long getLong(String key) {
    return getLong(DEFAULT_CONF, key);
  }

  /**
   * 读取长整型配置项
   *
   * @param propertiesName
   * @param key
   * @return
   */
  public static long getLong(String propertiesName, String key) {
    validProps(propertiesName);

    Object o = PROPS.get(key);
    if (o instanceof Number) {
      return ((Number) o).longValue();
    } else if (o != null) {
      try {
        long l = Long.parseLong(o.toString());
        return l;
      } catch (NumberFormatException e) {
      }
    }
    return 0;
  }

  /**
   * 读取整型配置项
   *
   * @param key
   * @return
   */
  public static Integer getInteger(String key) {
    return getInteger(DEFAULT_CONF, key);
  }

  /**
   * 读取整型配置项
   *
   * @param propertiesName
   * @param key
   * @return
   */
  public static Integer getInteger(String propertiesName, String key) {
    validProps(propertiesName);

    Object o = PROPS.get(key);
    if (o instanceof Number) {
      return ((Number) o).intValue();
    } else if (o != null) {
      try {
        Integer l = Integer.parseInt(o.toString());
        return l;
      } catch (NumberFormatException e) {
      }
    }
    return 0;
  }

  /**
   * 验证是否加载过指定配置文件, 未加载的, 执行加载
   */
  public static void validProps() {
    validProps(DEFAULT_CONF);
  }

  /**
   * 验证是否加载过指定配置文件, 未加载的, 执行加载
   *
   * @param propertiesName
   */
  public static void validProps(String propertiesName) {
    if (!isLoaded(propertiesName))
      reloadProps(propertiesName);
  }

  /**
   * 重新加载默认配置
   */
  public static void reloadProps() {
    reloadProps(DEFAULT_CONF);
  }

  /**
   * 重新加载配置
   *
   * @param propertiesName
   */
  public static void reloadProps(String propertiesName) {
    Properties properties = loadProperties(propertiesName);
    reloadProps(propertiesName, properties);
  }

  /**
   * 重新加载配置
   *
   * @param propertiesName
   * @param properties
   */
  public static void reloadProps(String propertiesName, Properties properties) {
    CONFS.remove(propertiesName);
    if (properties != null) {
      merge(properties);
    } else {
      properties = new Properties();
    }
    CONFS.put(propertiesName, properties);
  }

  /**
   * 读取配置
   *
   * @param resourceName
   * @return
   */
  public static Properties loadProperties(String resourceName) {
    Properties properties = null;
    InputStream in = null;
    try {
      properties = new Properties();
      in = SystemConfig.class.getClassLoader().getResourceAsStream(resourceName);
      properties.load(in);
    } catch (Exception e) {
      e.printStackTrace();
    } finally {
      try {
        if (in != null)
          in.close();
      } catch (IOException ioe) {
        ioe.printStackTrace();
      }
    }
    return properties;
  }

  /**
   * 检查指定的配置文件是否已加载
   *
   * @param propertiesName
   * @return
   */
  public static boolean isLoaded(String propertiesName) {
    return CONFS.containsKey(propertiesName);
  }

  public static Properties getLoadedConfig(String propertiesName) {
    return CONFS.get(propertiesName);
  }

  /**
   * 合并数据到map
   *
   * @param properties
   */
  public static void merge(Properties properties) {
    if (properties != null) {
      PROPS.putAll(properties);
    }
  }
}
