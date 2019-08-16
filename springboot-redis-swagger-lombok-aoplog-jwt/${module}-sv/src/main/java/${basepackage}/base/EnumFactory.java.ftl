/*  * ${copyright}  */ package ${basePackage}.base;

import com.google.common.collect.Maps;
import ${basePackage}.core.enums.*;
import jdk.nashorn.internal.ir.annotations.Ignore;

import java.lang.reflect.Field;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class EnumFactory {

    /**
     * 枚举管理器
     */
    public enum Enums {
        //-- 通用枚举 --
        EnvEnums(1000, EnvEnums.class, "项目运行的环境"),
        YNEnum(1001, YNEnum.class, "是否"),
        SexEnum(1002, SexEnum.class, "性别"),
        RoleEnum(1003, RoleTypeEnum.class, "角色（token）类型枚举"),
        RequestCodeEnum(1004, RequestCodeEnum.class, "请求状态码及说明"),
        FormatEnum(1005, FormatEnum.class, "内容格式枚举"),
        BucketNameEnum(1006, BucketNameEnum.class, "上传文件的归类目录"),

        //业务枚举 2000 开始
        UserState(2000, UserState.class, "用户状态"),
        UserAuthType(2001, AuthTypeEnum.class, "用户认证类别"),

        ;

        public int code;
        public Class clazz;
        public String desc;

        Enums(int code, Class clazz, String desc) {
            this.code = code;
            this.clazz = clazz;
            this.desc = desc;
        }

        public static Enums getEnums(int code) {
            for (Enums enums : Enums.values()) {
                if (enums.code == code) {
                    return enums;
                }
            }
            return null;
        }

        public static List<Map<String, String>> getEnumsDescs() {
            List<Map<String, String>> list = new ArrayList<Map<String, String>>();
            for (Enums enums : Enums.values()) {
                Map<String, String> map = new HashMap<>();
                map.put("枚举编码 [code = " + String.valueOf(enums.code) + "]", enums.desc);
                list.add(map);
            }
            return list;
        }

        /**
         * 反射获取枚举键值关系
         *
         * @param code 枚举编号
         * @return
         * @throws InstantiationException
         */
        public static Map<String, String> genMap(int code) {
            try {
                Class clazz = getEnums(code).clazz;
                Map<String, String> map = Maps.newHashMap();
                if (clazz.isEnum()) {
                    Field[] fs = clazz.getDeclaredFields();
                    List<String> ignoreKeys = new ArrayList<String>();
                    for (Field field : fs) {
                        Ignore ignore = field.getAnnotation(Ignore.class);
                        if (ignore != null) {
                            ignoreKeys.add(field.getName());
                        }
                    }
                    for (Object obj : clazz.getEnumConstants()) {
                        String type = obj.toString();
                        String classType = obj.getClass().getTypeName();
                        classType = classType.substring(classType.lastIndexOf(".") + 1);
                        for (int i = 0; i < fs.length; i++) {
                            Field f = fs[i];
                            f.setAccessible(true);
                            String fType = f.getType().getTypeName();

                            if (!fType.contains(classType)) {
                                Object val = f.get(obj);
                                map.put(type, val == null ? type : val.toString());
                            }
                        }
                    }
                    //删除 忽略key
                    if (ignoreKeys != null && ignoreKeys.size() > 0) {
                        ignoreKeys.forEach(ignoreKey -> map.remove(ignoreKey));
                    }
                }
                return map;
            } catch (IllegalAccessException e) {
                e.printStackTrace();
            }
            return null;
        }

    }
}
