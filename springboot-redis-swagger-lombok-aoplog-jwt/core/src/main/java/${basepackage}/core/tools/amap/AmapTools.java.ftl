/*
 * ${copyright}
 */
package ${basePackage}.core.tools.amap;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import ${basePackage}.core.tools.BigDecimalArith;
import ${basePackage}.core.tools.HttpUtil;
import okhttp3.Response;
import org.apache.commons.lang.StringUtils;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.HashMap;
import java.util.Map;

/**
 * 高德地图工具
 *
 * @author borong
 * @date 2019/5/17
 */
public class AmapTools {
    private static final String key = "f3b470526ff9e4799e2a1e1d771e3916";
    private static final double EARTH_RADIUS = 6378.137;    //赤道半径（km）

    /**
     * 地理编码，根据地址转换为高德经纬度坐标
     *
     * @param address  地址
     * @param areaCode 区域编码（传入此参数会在区域编码下查询，否则会在全国范围内查询）
     * @return 经纬度坐标对象
     */
    public static Location geo(String address, String areaCode) {
        if (StringUtils.isBlank(address)) {
            return null;
        }
        Location location = null;
        Map<String, String> params = new HashMap<>();
        params.put("key", key);
        params.put("address", address);
        if (StringUtils.isNotBlank(areaCode)) {
            params.put("city", areaCode.substring(0, 6));   //转换为6位区域编码
        }
        Response response = HttpUtil.httpPost("http://restapi.amap.com/v3/geocode/geo", params);

        try {
            JSONObject jsonObject = JSON.parseObject(response.body().string());
            if (jsonObject.get("status").equals("1")) {
                JSONArray geocodes = jsonObject.getJSONArray("geocodes");
                if (geocodes.size() > 0) {
                    JSONObject geocode = (JSONObject) geocodes.get(0);
                    location = new Location((String) geocode.get("location"));
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return location;
    }

    /**
     * 通过经纬度获取距离(单位：米)
     *
     * @param lat1 纬度1
     * @param lng1 经度1
     * @param lat2 纬度2
     * @param lng2 经度2
     * @return 距离(米)
     */
    public static double getDistance(double lat1, double lng1, double lat2,
                                     double lng2) {
        double radLat1 = rad(lat1);
        double radLat2 = rad(lat2);
        double a = radLat1 - radLat2;
        double b = rad(lng1) - rad(lng2);
        Double s = 2 * Math.asin(Math.sqrt(Math.pow(Math.sin(a / 2), 2)
                + Math.cos(radLat1) * Math.cos(radLat2)
                * Math.pow(Math.sin(b / 2), 2)));
        s = s * EARTH_RADIUS;
        s = Math.round(s * 10000d) / 10000d;
        s = s * 1000;
        return BigDecimalArith.roundDouble(s);
    }

    private static double rad(double d) {
        return d * Math.PI / 180.0;
    }

    /**
     * 把大于1千米的数据转化为km
     * * @param distance 距离
     */
    public static String transformKm(String distance) {
        if(Double.valueOf(distance)< 1000) return distance + "m";
        BigDecimal b = new BigDecimal(Double.valueOf(distance)/1000);
        return b.setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue() + "km";
    }
}
