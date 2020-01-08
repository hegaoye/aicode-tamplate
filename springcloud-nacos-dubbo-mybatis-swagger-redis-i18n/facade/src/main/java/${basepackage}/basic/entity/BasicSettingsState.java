/*
* 仁中和
*/
package ${basePackage}.basic.entity;

/**
* 系统基础关键配置表 的实体类的状态
*
* @author borong
*/
public enum BasicSettingsState implements java.io.Serializable {
   //枚举定义在此
    ;

    public String val;
    BasicSettingsState(String val) {
       this.val=val;
    }

    /**
    * 根据状态名称查询状态
    *
    * @param stateName
    * @return
    */
    public static BasicSettingsState getEnum(String stateName) {
        for (BasicSettingsState basicSettingsState : BasicSettingsState.values()) {
            if (basicSettingsState.name().equalsIgnoreCase(stateName)) {
                return basicSettingsState;
            }
        }
        return null;
    }

    @Override
    public String toString() {
         return this.name();
    }

}
