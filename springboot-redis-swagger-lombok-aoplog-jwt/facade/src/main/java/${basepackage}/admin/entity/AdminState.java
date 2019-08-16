/*
* 仁中和
*/
package ${basePackage}.admin.entity;

/**
* 管理员表 的实体类的状态
*
* @author borong
*/
public enum AdminState implements java.io.Serializable {
   //枚举定义在此
    ;

    public String val;
    AdminState(String val) {
       this.val=val;
    }

    /**
    * 根据状态名称查询状态
    *
    * @param stateName
    * @return
    */
    public static AdminState getEnum(String stateName) {
        for (AdminState adminState : AdminState.values()) {
            if (adminState.name().equalsIgnoreCase(stateName)) {
                return adminState;
            }
        }
        return null;
    }

    @Override
    public String toString() {
         return this.name();
    }

}
