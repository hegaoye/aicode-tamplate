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

            /**
            * 对象合并（用于属性为空时合并，不相互覆盖）
            * <p>
                * 例如：
                * oldObj :{"a":"aaaa","b":"ccccccccc"}
                * 向
                * newObj: {"a":null,"b":"bbbbb"}
                * 合并
                * 结果：
                * return :{"a":"aaaa","b":"bbbbb"}
                *
                * @param newObj 最终获得对象
                * @param oldObj 数据携带对象
                * @param clazz  最终获得对象类型
                * @return 最终获得对象
                */
                public static <T> T mergeObject(Object newObj, Object oldObj, Class<T> clazz) {
                Map newMap = (Map) JSON.toJSON(newObj);
                Map oldMap = (Map) JSON.toJSON(oldObj);
                for (Object key : newMap.keySet()) {
                if (newMap.get(key) == null && oldMap.containsKey(key) && oldMap.get(key) != null) {
                newMap.put(key, oldMap.get(key));
                }
                }
                return JSON.parseObject(JSON.toJSONString(newMap), clazz);
                }
}