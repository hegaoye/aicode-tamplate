/*
* mm
*/
package com.my.project.entity;

/**
* 账户 的实体类的状态
*
* @author mm
*/
public enum ProjectState implements java.io.Serializable {
   //枚举定义在此
    ;

    public String val;
    ProjectState(String val) {
        this.val=val;
    }

    /**
    * 根据状态名称查询状态
    *
    * @param stateName
    * @return
    */
    public static ProjectState getEnum(String stateName) {
        for (ProjectState projectState : ProjectState.values()) {
            if (projectState.name().equalsIgnoreCase(stateName)) {
                return projectState;
            }
        }
        return null;
    }

    @Override
    public String toString() {
         return this.name();
    }

}
