/*
 * ${copyright}
 */
package ${basePackage}.core.tools;

import lombok.extern.slf4j.Slf4j;

import java.io.*;
import java.net.URLDecoder;
import java.util.HashSet;
import java.util.Set;


/**
 * @author borong
 * 公用函数
 */
@Slf4j
public class HandleFuncs {

    /**
     * 单例模式
     */
    private static HandleFuncs instance;

    public static HandleFuncs getInstance() {
        if (instance == null) {
            instance = new HandleFuncs();
        }
        return instance;
    }

    // ////////////////////////////////////基本操作/////////////////////////////////////////////



    /**
     * 把字节数组保存为一个文件
     */
    public static File getFileFromBytes(byte[] b, String outputFile) {
        BufferedOutputStream stream = null;
        File file = null;
        FileOutputStream fstream = null;
        try {
            file = new File(outputFile);
            fstream = new FileOutputStream(file);
            stream = new BufferedOutputStream(fstream);
            stream.write(b);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (stream != null) {
                try {
                    stream.close();
                } catch (IOException e1) {
                    e1.printStackTrace();
                }
            }
            if (fstream != null) {
                try {
                    fstream.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
        return file;
    }

    /**
     * 数组去重复
     */
    public static String[] toDiffArray(String[] s) {
        Set<String> set = new HashSet<String>();
        for (String sa : s) {
            set.add(sa);
        }
        return set.toArray(new String[]{});
    }

    /**
     * 字符串数组去重复
     */
    public static String toDiffString(String s) {
        if ((s == null) || !s.contains(",")) {
            return null;
        }
        // 去重复
        String[] strArr = toDiffArray(s.split(","));
        // 循环组合
        StringBuffer sb = new StringBuffer();
        for (String string : strArr) {
            sb.append("," + string);
        }
        if (sb.length() == 0) {
            return null;
        }
        return sb.toString().substring(1);
    }

    // ////////////////////////////////////文件操作////////////////////////////////////////////

    /**
     * 文件copy
     *
     * @throws IOException
     */
    public void copyTo(File in, File out) {
        FileInputStream fis = null;
        FileOutputStream fos = null;
        try {
            fis = new FileInputStream(in);
            fos = new FileOutputStream(out);
            byte[] buf = new byte[1024];
            int i = 0;
            while ((i = fis.read(buf)) != -1) {
                fos.write(buf, 0, i);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (fis != null) {
                try {
                    fis.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
            try {
                if (fos != null) {
                    fos.close();
                }
            } catch (IOException e) {
                e.printStackTrace();
            }
        }


    }


    /**
     * 获取本机的类
     */
    public String getCurrentClassPath() {
        try {
            String path = this.getClass().getClassLoader().getResource("").getPath();
            path = URLDecoder.decode(path, "utf-8");
            int pos = path.indexOf("/WEB-INF/classes/");
            if (pos > 0) {
                path = path.substring(0, pos);
            }
            return path;
        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }
}
