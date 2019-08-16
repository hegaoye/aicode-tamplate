/*
* ${copyright}
*/
package ${basePackage}.${model}.entity;

/**
* ${notes} 的实体类的状态
*
* @author ${author}
*/
public enum ${className}State implements java.io.Serializable {
    //枚举定义在此
    ;

    public String val;
    ${className}State(String val) {
        this.val=val;
    }

    /**
     * 根据状态名称查询状态
     *
     * @param name
     * @return
     */
    public static ${className}State getEnum(String name) {
        for (${className}State enums : ${className}State.values()) {
            if (enums.name().equalsIgnoreCase(name)) {
                return enums;
            }
        }
        return null;
    }

    @Override
    public String toString() {
         return this.name();
    }
}