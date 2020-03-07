/*
 * mm
 */
package com.my.project.service;

import com.my.core.base.BaseSV;
import com.my.project.entity.Project;
import com.my.project.entity.ProjectState;

/**
 * 账户
 *
 * @author mm
 */
public interface ProjectSV extends BaseSV<Project> {


    /**
     * 加载一个对象Project
     *
     * @param id @param code 账户编码
     * @return Project
     */
    Project load(java.lang.Long id, java.lang.String code);


    /**
     * 加载一个对象Project 通过id
     *
     * @param id
     * @return Project
     */
    Project loadById(java.lang.Long id);

    /**
     * 加载一个对象Project 通过code
     *
     * @param code 账户编码
     * @return Project
     */
    Project loadByCode(java.lang.String code);


    /**
     * 根据主键id,oldStates 共同更新 Project 的状态到newState状态
     *
     * @param id
     * @param newState  新状态
     * @param oldStates 旧状态集合
     */
    boolean updateStateById(java.lang.Long id, ProjectState newState, ProjectState... oldStates);

    /**
     * 根据主键code,oldStates 共同更新 Project 的状态到newState状态
     *
     * @param code      账户编码
     * @param newState  新状态
     * @param oldStates 旧状态集合
     */
    boolean updateStateByCode(java.lang.String code, ProjectState newState, ProjectState... oldStates);

}
