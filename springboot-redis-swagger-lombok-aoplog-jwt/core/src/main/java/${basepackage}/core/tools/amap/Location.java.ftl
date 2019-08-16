/*
 * ${copyright}
 */
package ${basePackage}.core.tools.amap;

import java.io.Serializable;

/**
 * 存储经纬度信息
 *
 * @author borong
 * @date 2019/5/17
 */
public class Location implements Serializable {

    public static final double MINLAT = -90;
    public static final double MAXLAT = 90;
    public static final double MINLNG = -180;
    public static final double MAXLNG = 180;

    private static final long serialVersionUID = 4442884573965521609L;

    private double longitude;//经度[-180,180]
    private double latitude;//纬度[-90,90]

    public Location(double longitude, double latitude) {
        this.latitude = latitude;
        this.longitude = longitude;
    }

    public double getLatitude() {
        return latitude;
    }

    public void setLatitude(double latitude) {
        this.latitude = latitude;
    }

    public double getLongitude() {
        return longitude;
    }

    public void setLongitude(double longitude) {
        this.longitude = longitude;
    }

    /**
     * 通过经度和纬度构建
     *
     * @param lngAndlat
     */
    public Location(String lngAndlat) {
        String[] lngAndlatAry = lngAndlat.split(",");
        this.longitude = Double.parseDouble(lngAndlatAry[0]);
        this.latitude = Double.parseDouble(lngAndlatAry[1]);
    }
    /**
     * 通过经度和纬度构建
     *
     * @param longitude 经度[-180,180]
     * @param latitude 纬度[-90,90]
     */
    public Location(String longitude, String latitude) {
        this.longitude = Double.parseDouble(longitude);
        this.latitude = Double.parseDouble(latitude);
    }
}
