package $package$.cache.entity;

public enum RedisKey {
    Gateway(24 * 60 * 60),
    ;

    RedisKey(Integer time) {
        this.time = time;
    }

    public Integer time;
    private static final String preFix = "demo:";

    public static String getCachekey() {
        return preFix + "enum";
    }

    /**
     * 获取Gateway的缓存 Key
     *
     * @return
     */
    public String getGatewayKey() {
        return new StringBuffer(preFix).append(this.name()).toString();
    }


}