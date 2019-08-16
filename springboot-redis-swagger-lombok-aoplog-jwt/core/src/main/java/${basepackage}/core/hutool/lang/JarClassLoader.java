package ${basePackage}.core.hutool.lang;

import ${basePackage}.core.hutool.exceptions.UtilException;
import ${basePackage}.core.hutool.io.FileUtil;
import ${basePackage}.core.hutool.io.IoUtil;
import ${basePackage}.core.hutool.util.ClassUtil;

import java.io.File;
import java.io.FileFilter;
import java.io.IOException;
import java.lang.reflect.Method;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLClassLoader;
import java.util.List;

/**
 * 外部Jar的类加载器
 *
 * @author Looly
 */
public class JarClassLoader extends URLClassLoader {

    /**
     * 加载Jar到ClassPath
     *
     * @param jarFile jar文件或所在目录
     * @return JarClassLoader
     */
    public static JarClassLoader loadJar(File jarFile) {
        final JarClassLoader loader = new JarClassLoader();
        try {
            loader.addJar(jarFile);
        } finally {
            IoUtil.close(loader);
        }
        return loader;
    }

    /**
     * 加载Jar文件到指定loader中
     *
     * @param loader  {@link URLClassLoader}
     * @param jarFile 被加载的jar
     */
    public static void loadJar(URLClassLoader loader, File jarFile) {
        try {
            final Method method = ClassUtil.getDeclaredMethod(URLClassLoader.class, "addURL", URL.class);
            if (null != method) {
                method.setAccessible(true);
                final List<File> jars = loopJar(jarFile);
                for (File jar : jars) {
                    ClassUtil.invoke(loader, method, new Object[]{jar.toURI().toURL()});
                }
            }
        } catch (IOException | ReflectiveOperationException e) {
            throw new UtilException(e);
        }
    }

    /**
     * 加载Jar文件到System ClassLoader中
     *
     * @param jarFile 被加载的jar
     * @return System ClassLoader
     */
    public static URLClassLoader loadJarToSystemClassLoader(File jarFile) {
        URLClassLoader urlClassLoader = (URLClassLoader) ClassLoader.getSystemClassLoader();
        loadJar(urlClassLoader, jarFile);
        return urlClassLoader;
    }

    // ------------------------------------------------------------------- Constructor start

    /**
     * 构造
     */
    public JarClassLoader() {
        this(new URL[]{});
    }

    /**
     * 构造
     *
     * @param urls 被加载的URL
     */
    public JarClassLoader(URL[] urls) {
        super(urls, ClassUtil.getClassLoader());
    }
    // ------------------------------------------------------------------- Constructor over

    /**
     * 加载Jar文件，或者加载目录
     *
     * @param jarFile jar文件或者jar文件所在目录
     * @return this
     */
    public JarClassLoader addJar(File jarFile) {
        final List<File> jars = loopJar(jarFile);
        try {
            for (File jar : jars) {
                super.addURL(jar.toURI().toURL());
            }
        } catch (MalformedURLException e) {
            throw new UtilException(e);
        }
        return this;
    }

    @Override
    public void addURL(URL url) {
        super.addURL(url);
    }

    // ------------------------------------------------------------------- Private method start

    /**
     * 递归获得Jar文件
     *
     * @param file jar文件或者包含jar文件的目录
     * @return jar文件列表
     */
    private static List<File> loopJar(File file) {
        return FileUtil.loopFiles(file, new FileFilter() {

            @Override
            public boolean accept(File file) {
                final String path = file.getPath();
                if (path != null && path.toLowerCase().endsWith(".jar")) {
                    return true;
                }
                return false;
            }
        });
    }
    // ------------------------------------------------------------------- Private method over
}
