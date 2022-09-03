package $package$.cache.entity;


public enum RedisKey {
    ,
    ;

    private static final String preFix = "$projectName$";

    public static String getCachekey() {
        return preFix + "enum";
    }


}

