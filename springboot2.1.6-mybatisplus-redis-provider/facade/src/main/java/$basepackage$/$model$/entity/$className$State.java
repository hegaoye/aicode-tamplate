/*
* $copyright$
 */
package $package$.$model$.entity;

/**
 * $notes$ 的实体类的状态
 *
 * @author $author$
 */
public enum $className$State implements java.io.Serializable {
    /***
     if(statusList!=null && statusList.~size>0){
     for(state in statusList){
     ***/
    $state.name$("$state.desc$"),
    /***}}***/
    ;

    public String val;

    $className$State(String val) {
        this.val = val;
    }

    /**
     * 根据状态名称查询状态
     *
     * @param stateName
     * @return
     */
    public static $className$State getEnum(String stateName) {
        for ($className$State $classNameLower$State : $className$State.values()) {
            if ($classNameLower$State.name().equalsIgnoreCase(stateName)) {
                return $classNameLower$State;
            }
        }
        return null;
    }

    @Override
    public String toString() {
        return this.name();
    }

}
