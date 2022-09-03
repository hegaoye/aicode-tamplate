package $package$.cache.entity;

public enum RedisOpenApiKey {
    ;
    private static final String preFix = "$projectName$:";

    public static String getCachekey() {
        return preFix + "enum";
    }


}