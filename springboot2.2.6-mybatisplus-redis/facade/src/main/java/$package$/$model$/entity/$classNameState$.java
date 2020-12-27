/*
* $copyright$
 */
package $package$.$model$.entity;

/**
 * $notes$ 的实体类的状态
 *
 * @author $author$
 */
public enum $classNameState$ implements java.io.Serializable {
    /***
     if(states!=null && states.~size>0){
     for(state in states){
     ***/
    $state.name$("$state.value$"),
    /***}}***/
    ;

    public String val;

    $classNameState$(String val) {
        this.val = val;
    }

    /**
     * 根据状态名称查询状态
     *
     * @param stateName
     * @return
     */
    public static $classNameState$ getEnum(String stateName) {
        for ($classNameState$ enumName : $classNameState$.values()) {
            if (enumName.name().equalsIgnoreCase(stateName)) {
                return enumName;
            }
        }
        return null;
    }

    @Override
    public String toString() {
        return this.name();
    }

}
