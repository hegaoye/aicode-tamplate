/*
 * ${copyright}
 */
package ${basePackage}.core.tools;


import com.alibaba.fastjson.JSON;

import java.lang.reflect.Field;
import java.lang.reflect.Modifier;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


/**
 * @author borong
 * 对象转换工具类
 */
public class ObjectTools implements java.io.Serializable {

    private static final long serialVersionUID = 8170874679531395675L;

    /**
     * 把 Object2 中的值设置到 Object1 中
     *
     * @param targetObject
     * @param Object2
     * @param calsz
     * @return
     */
    public static Object mergeObject(Object targetObject, Object Object2, Class calsz) {
        Map targetPara = (Map) JSON.toJSON(targetObject);
        Map oldPara = (Map) JSON.toJSON(Object2);
        for (Object key : targetPara.keySet()) {
            if (targetPara.get(key) == null || targetPara.get(key).toString().length() < 1) {
                if (oldPara.get(key) != null && oldPara.get(key).toString().length() > 0) {
                    targetPara.put(key, oldPara.get(key));
                }
            }
        }
        return JSON.parseObject(JSON.toJSONString(targetPara), calsz);
    }

    /**
     * 将对像转化为需要的类型
     *
     * @param obj   需要转化对象
     * @param clazz 转化结果
     * @return
     */
    public static <T> T toVo(Object obj, Class<T> clazz) {
        if (obj == null) {
            return null;
        }
        String json = JSON.toJSONString(obj);
        return JSON.parseObject(json, clazz);
    }


    /**
     * 将对像转化为需要的类型
     *
     * @param obj   需要转化对象
     * @param clazz 转化结果
     * @return
     */

    public static <T> T toEntity(Object obj, Class<T> clazz) {
        return toVo(obj, clazz);
    }


    /**
     * 将集合转化为需要的类型
     *
     * @param obj   需要转化对象
     * @param clazz 转化结果
     * @return
     */
    public static <T> List<T> convertList(Object obj, Class<T> clazz) {
        String json = JSON.toJSONString(obj);
        return JSON.parseArray(json, clazz);
    }


    /**
     * 实体对象转成Map
     *
     * @param obj 实体对象
     * @return
     */
    public static Map<String, Object> object2Map(Object obj) {
        Map<String, Object> map = new HashMap<>();
        if (obj == null) {
            return map;
        }
        Class clazz = obj.getClass();
        Field[] fields = clazz.getDeclaredFields();
        try {
            for (Field field : fields) {
                field.setAccessible(true);
                map.put(field.getName(), field.get(obj));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return map;
    }

    /**
     * Map转成实体对象
     *
     * @param map   实体对象包含属性
     * @param clazz 实体对象类型
     * @return
     */
    public static Object map2Object(Map<String, Object> map, Class<?> clazz) {
        if (map == null) {
            return null;
        }
        Object obj = null;
        try {
            obj = clazz.newInstance();

            Field[] fields = obj.getClass().getDeclaredFields();
            for (Field field : fields) {
                int mod = field.getModifiers();
                if (Modifier.isStatic(mod) || Modifier.isFinal(mod)) {
                    continue;
                }
                field.setAccessible(true);
                field.set(obj, map.get(field.getName()));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return obj;
    }
}
