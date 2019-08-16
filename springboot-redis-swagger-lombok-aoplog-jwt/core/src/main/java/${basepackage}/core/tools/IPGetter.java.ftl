/*
 * ${copyright}
 */
package ${basePackage}.core.tools;

import lombok.extern.slf4j.Slf4j;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.servlet.http.HttpServletRequest;
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.Inet4Address;
import java.net.InetAddress;
import java.net.URL;
import java.net.UnknownHostException;

/**
 * @author borong
 */
@Slf4j
public class IPGetter {
    /**
     * @return
     * @Enclosing_Method : getUserAccessIp
     * @Written by : robot
     * @Creation Date : Sep 3, 2010 11:23:35 AM
     * @version : v1.00
     * @Description : 获取用户访问Ip地址
     */
    public static String getAccessIp() {
        try {
            // 获取action的servletRequest对象
            HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
            return getAccessIp(request);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    /**
     * 从 request 获取用户真实访问 ip 地址
     *
     * @param request
     * @return
     */
    public static String getAccessIp(HttpServletRequest request) {
        //Nginx下取得真实ip
        String ip = request.getHeader("X-Real-IP");
        //---------------------------普通服务器环境使用下列方式取得访问ip------------------------------
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip) || "null".equalsIgnoreCase(ip)) {
            ip = request.getHeader("X-Forwarded-For");
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip) || "null".equalsIgnoreCase(ip)) {
            ip = request.getHeader("Proxy-Client-IP");
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip) || "null".equalsIgnoreCase(ip)) {
            ip = request.getHeader("WL-Proxy-Client-IP");
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip) || "null".equalsIgnoreCase(ip)) {
            ip = request.getHeader("HTTP_CLIENT_IP");
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip) || "null".equalsIgnoreCase(ip)) {
            ip = request.getHeader("HTTP_X_FORWARDED_FOR");
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip) || "null".equalsIgnoreCase(ip)) {
            ip = request.getRemoteAddr();
        }
        //对于通过多个代理的情况，第一个IP为客户端真实IP,多个IP按照','分割
        if (ip != null && ip.length() > 15) { //"***.***.***.***".length() = 15
            if (ip.indexOf(",") > 0) {
                ip = ip.substring(0, ip.indexOf(","));
            }
        }
        return ip;
    }

    /**
     * @return : String
     * @Enclosing_Method : getWebLocalIp
     * @Written by        : liyanping
     * @Creation Date     : Nov 19, 2010 1:22:11 PM
     * @version : v1.00
     * @Description : 获取本机的外部IP
     */
    public static String getWebLocalIp() {
        try {
            URL url = new URL("http://www.ip138.com/ip2city.asp");
            BufferedReader br = new BufferedReader(new InputStreamReader(url.openStream()));
            String s = "";
            StringBuffer sb = new StringBuffer("");
            String ip = "";
            while ((s = br.readLine()) != null) {
                sb.append(s + "\r\n");
            }
            br.close();
            ip = sb.toString();
            int start = ip.indexOf("[") + 1;
            int end = ip.indexOf("]");
            ip = ip.substring(start, end);
            return ip;
        } catch (Exception e) {
            return null;
        }
    }

    /**
     * @return : String
     * @Enclosing_Method : getLocalIp
     * @Creation Date     : 2012-3-20 下午04:22:23
     * @version : v1.00
     * @Description : 获得本机Ip
     */
    public static String getLocalIp() {
        String ip = "";
        try {
            InetAddress addr = InetAddress.getLocalHost();
            ip = addr.getHostAddress().toString();//获得本机IP
        } catch (UnknownHostException e) {
            e.printStackTrace();
        }
        return ip;
    }

    /**
     * 转换 二进制 的 long 型 ip 地址 为 可识别的 ip 地址
     *
     * @param add
     * @return
     */
    public static String inetNtoa(long add) {
        return ((add & 0xff000000) >> 24) + "." + ((add & 0xff0000) >> 16)
                + "." + ((add & 0xff00) >> 8) + "." + ((add & 0xff));
    }

    /**
     * 转换 ip 地址为 二进制的 long 类型数值
     *
     * @param add
     * @return
     */
    public static long inetAton(Inet4Address add) {
        byte[] bytes = add.getAddress();
        long result = 0;
        for (byte b : bytes) {
            if ((b & 0x80L) != 0) {
                result += 256L + b;
            } else {
                result += b;
            }
            result <<= 8;
        }
        result >>= 8;
        return result;
    }

    /**
     * 转换 ipv4 ip 地址为 二进制的 long 类型数值
     */
    public static long inetAton(String ipAddress) {
        long result = 0;
        // number between a dot
        long section = 0;
        // which digit in a number
        int times = 1;
        // which section
        int dots = 0;
        for (int i = ipAddress.length() - 1; i >= 0; --i) {
            if (ipAddress.charAt(i) == '.') {
                times = 1;
                section <<= dots * 8;
                result += section;
                section = 0;
                ++dots;
            } else {
                section += (ipAddress.charAt(i) - '0') * times;
                times *= 10;
            }
        }
        section <<= dots * 8;
        result += section;
        return result;
    }
}