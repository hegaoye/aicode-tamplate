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
