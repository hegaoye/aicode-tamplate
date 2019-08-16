/*
 * ${copyright}
 */
package ${basePackage}.core.tools.amap;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

/**
 * 地图坐标的 geohash 工具类
 *
 * @author borong
 * @date 2019/5/17
 */
public class GeoHashTools {

    private Location location;

    /**
     * 经纬度转化为geohash长度
     * 1 2500km;2 630km;3 78km;4 30km
     * 5 2.4km; 6 610m; 7 76m; 8 19m
     */
    private int hashLength = 8;

    /**
     * 纬度转化为二进制长度
     */
    private int latitudeLength = 20;

    /**
     * 经度转化为二进制长度
     */
    private int longitudeLength = 20;

    /**
     * 每格纬度的单位大小
     */
    private double minLatitude;

    /**
     * 每个经度的倒下
     */
    private double minLongitude;

    private static final char[] CHARS = {'0', '1', '2', '3', '4', '5', '6', '7',
            '8', '9', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'j', 'k', 'm', 'n',
            'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z'};

    /**
     * 构造器
     *
     * @param longitude 经度
     * @param latitude  纬度
     */
    public GeoHashTools(double longitude, double latitude) {
        location = new Location(longitude, latitude);
        setMinLatLng();
    }

    public int gethashLength() {
        return hashLength;
    }

    /**
     * @Author:jiyan
     * @Description: 设置经纬度的最小单位
     */
    private void setMinLatLng() {
        minLatitude = Location.MAXLAT - Location.MINLAT;
        for (int i = 0; i < latitudeLength; i++) {
            minLatitude /= 2.0;
        }
        minLongitude = Location.MAXLNG - Location.MINLNG;
        for (int i = 0; i < longitudeLength; i++) {
            minLongitude /= 2.0;
        }
    }

    /**
     * @return
     * @Author:jiyan
     * @Description: 求所在坐标点及周围点组成的九个
     */
    public List<String> getGeoHashBase32For9() {
        double leftLat = location.getLatitude() - minLatitude;
        double rightLat = location.getLatitude() + minLatitude;
        double upLng = location.getLongitude() - minLongitude;
        double downLng = location.getLongitude() + minLongitude;
        List<String> base32For9 = new ArrayList<>();
        //左侧从上到下 3个
        String leftUp = getGeoHashBase32(leftLat, upLng);
        if (!(leftUp == null || "".equals(leftUp))) {
            base32For9.add(leftUp);
        }
        String leftMid = getGeoHashBase32(leftLat, location.getLongitude());
        if (!(leftMid == null || "".equals(leftMid))) {
            base32For9.add(leftMid);
        }
        String leftDown = getGeoHashBase32(leftLat, downLng);
        if (!(leftDown == null || "".equals(leftDown))) {
            base32For9.add(leftDown);
        }
        //中间从上到下 3个
        String midUp = getGeoHashBase32(location.getLatitude(), upLng);
        if (!(midUp == null || "".equals(midUp))) {
            base32For9.add(midUp);
        }
        String midMid = getGeoHashBase32(location.getLatitude(), location.getLongitude());
        if (!(midMid == null || "".equals(midMid))) {
            base32For9.add(midMid);
        }
        String midDown = getGeoHashBase32(location.getLatitude(), downLng);
        if (!(midDown == null || "".equals(midDown))) {
            base32For9.add(midDown);
        }
        //右侧从上到下 3个
        String rightUp = getGeoHashBase32(rightLat, upLng);
        if (!(rightUp == null || "".equals(rightUp))) {
            base32For9.add(rightUp);
        }
        String rightMid = getGeoHashBase32(rightLat, location.getLongitude());
        if (!(rightMid == null || "".equals(rightMid))) {
            base32For9.add(rightMid);
        }
        String rightDown = getGeoHashBase32(rightLat, downLng);
        if (!(rightDown == null || "".equals(rightDown))) {
            base32For9.add(rightDown);
        }
        return base32For9;
    }

    /**
     * @param length
     * @return
     * @Author:jiyan
     * @Description: 设置经纬度转化为geohash长度
     */
    public boolean sethashLength(int length) {
        if (length < 1) {
            return false;
        }
        hashLength = length;
        latitudeLength = (length * 5) / 2;
        if (length % 2 == 0) {
            longitudeLength = latitudeLength;
        } else {
            longitudeLength = latitudeLength + 1;
        }
        setMinLatLng();
        return true;
    }

    /**
     * @return
     * @Author:jiyan
     * @Description: 获取经纬度的base32字符串
     */
    public String getGeoHashBase32() {
        return getGeoHashBase32(location.getLatitude(), location.getLongitude());
    }

    /**
     * @param lat
     * @param lng
     * @return
     * @Author:jiyan
     * @Description: 获取经纬度的base32字符串
     */
    private String getGeoHashBase32(double lat, double lng) {
        boolean[] bools = getGeoBinary(lat, lng);
        if (bools == null) {
            return null;
        }
        StringBuffer sb = new StringBuffer();
        for (int i = 0; i < bools.length; i = i + 5) {
            boolean[] base32 = new boolean[5];
            for (int j = 0; j < 5; j++) {
                base32[j] = bools[i + j];
            }
            char cha = getBase32Char(base32);
            if (' ' == cha) {
                return null;
            }
            sb.append(cha);
        }
        return sb.toString();
    }

    /**
     * @param base32
     * @return
     * @Author:jiyan
     * @Description: 将五位二进制转化为base32
     */
    private char getBase32Char(boolean[] base32) {
        if (base32 == null || base32.length != 5) {
            return ' ';
        }
        int num = 0;
        for (boolean bool : base32) {
            num <<= 1;
            if (bool) {
                num += 1;
            }
        }
        return CHARS[num % CHARS.length];
    }

    /**
     * @param lat
     * @param lng
     * @return
     * @Author:jiyan
     * @Description: 获取坐标的geo二进制字符串
     */
    private boolean[] getGeoBinary(double lat, double lng) {
        boolean[] latArray = getHashArray(lat, Location.MINLAT, Location.MAXLAT, latitudeLength);
        boolean[] lngArray = getHashArray(lng, Location.MINLNG, Location.MAXLNG, longitudeLength);
        return merge(latArray, lngArray);
    }

    /**
     * @param latArray
     * @param lngArray
     * @return
     * @Author:jiyan
     * @Description: 合并经纬度二进制
     */
    private boolean[] merge(boolean[] latArray, boolean[] lngArray) {
        if (latArray == null || lngArray == null) {
            return null;
        }
        boolean[] result = new boolean[lngArray.length + latArray.length];
        Arrays.fill(result, false);
        for (int i = 0; i < lngArray.length; i++) {
            result[2 * i] = lngArray[i];
        }
        for (int i = 0; i < latArray.length; i++) {
            result[2 * i + 1] = latArray[i];
        }
        return result;
    }

    /**
     * @param value
     * @param min
     * @param max
     * @return
     * @Author:jiyan
     * @Description: 将数字转化为geohash二进制字符串
     */
    private boolean[] getHashArray(double value, double min, double max, int length) {
        if (value < min || value > max) {
            return null;
        }
        if (length < 1) {
            return null;
        }
        boolean[] result = new boolean[length];
        for (int i = 0; i < length; i++) {
            double mid = (min + max) / 2.0;
            if (value > mid) {
                result[i] = true;
                min = mid;
            } else {
                result[i] = false;
                max = mid;
            }
        }
        return result;
    }

    public static void main(String[] args) {

        List<Location> arrayList = new ArrayList<>();
        arrayList.add(new Location("113.670476", "34.774333"));
        arrayList.add(new Location("113.556296", "34.810991"));
        arrayList.add(new Location("113.662582", "34.800919"));
        arrayList.add(new Location("113.614996", "34.737774"));
        arrayList.add(new Location("113.656277", "34.739537"));
        arrayList.add(new Location("113.316305", "34.81199"));
        arrayList.add(new Location("113.627998", "34.748664"));
        arrayList.add(new Location("113.627998", "34.748664"));
        arrayList.add(new Location("113.684336", "34.787161"));
        arrayList.add(new Location("113.684336", "34.787161"));
        arrayList.add(new Location("113.015592", "34.448595"));
        arrayList.add(new Location("113.038315", "34.473736"));
        arrayList.add(new Location("113.051765", "34.461535"));
        arrayList.add(new Location("113.060719", "34.463061"));
        arrayList.add(new Location("112.978875", "34.374968"));
        arrayList.add(new Location("114.50255 ", "38.023922"));
        arrayList.add(new Location("114.685021", "38.02587"));
        arrayList.add(new Location("114.531375", "38.055846"));
        arrayList.add(new Location("114.514366", "38.058347"));
        arrayList.add(new Location("113.638153", "34.809036"));
        arrayList.add(new Location("106.443688", "30.110837"));
        arrayList.add(new Location("113.681634", "34.743589"));
        arrayList.add(new Location("118.078069", "39.596812"));
        arrayList.add(new Location("113.658631", "34.74641"));
        arrayList.add(new Location("113.631337", "34.76136"));

        for (Location location : arrayList) {
            GeoHashTools g = new GeoHashTools(location.getLongitude(), location.getLatitude());
            System.out.println(location.getLatitude() + "\t" + location.getLongitude() + "\t" + g.getGeoHashBase32());
        }
    }
}
