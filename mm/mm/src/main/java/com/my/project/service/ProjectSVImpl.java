/*
 * mm
 */
package com.my.project.service;

import com.baidu.fsg.uid.UidGenerator;
import com.my.core.base.BaseDAO;
import com.my.core.base.BaseSVImpl;
import com.my.core.exceptions.BaseException;
import com.my.core.exceptions.ProjectException;
import com.my.project.dao.ProjectDAO;
import com.my.project.entity.Project;
import com.my.project.entity.ProjectState;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.Date;

/**
 * 账户
 *
 * @author mm
 */
@Service("projectSV")
@Slf4j
public class ProjectSVImpl extends BaseSVImpl<Project> implements ProjectSV {

    @Autowired
    private ProjectDAO projectDAO;

    @Autowired
    private UidGenerator uidGenerator;

    @Override
    public BaseDAO getBaseDAO() {
        return projectDAO;
    }

    /**
     * 保存
     *
     * @param project 对象
     * @return Project
     */
    @Transactional(rollbackFor = BaseException.class)
    @Override
    public Project save(Project project) {
        project.setCode(String.valueOf(uidGenerator.getUID()));
        project.setCreateTime(new Date());
        project.setUpdateTime(new Date());
        return super.save(project);
    }


    /**
     * 加载一个对象Project
     *
     * @param id @param code 账户编码
     * @return Project
     */
    @Override
    public Project load(Long id, String code) {
        return projectDAO.selectOne(id, code);
    }

    /**
     * 加载一个对象Project 通过id
     *
     * @param id
     * @return Project
     */
    @Override
    public Project loadById(Long id) {
        return projectDAO.selectById(id);
    }

    /**
     * 加载一个对象Project 通过code
     *
     * @param code 账户编码
     * @return Project
     */
    @Override
    public Project loadByCode(String code) {
        Project project = projectDAO.selectByCode(code);
        if (null == project) {
            throw new ProjectException(BaseException.BaseExceptionEnum.Result_Not_Exist);
        }
        return project;
    }

    /**
     * 根据 id 更新 状态
     *
     * @param id        数据id
     * @param newState  新状态
     * @param oldStates 旧状态集合
     */
    @Transactional(rollbackFor = BaseException.class)
    @Override
    public boolean updateStateById(Long id, ProjectState newState, ProjectState... oldStates) {
        Project project = projectDAO.selectById(id);
        if (null == project) {
            throw new ProjectException(BaseException.BaseExceptionEnum.Result_Not_Exist);
        }

        return projectDAO.updateStateById(id, newState, oldStates) > 0 ? true : false;
    }

    /**
     * 根据主键code,oldStates 共同更新 Project 的状态到newState状态
     *
     * @param code      账户编码
     * @param newState  新状态
     * @param oldStates 旧状态集合
     */
    @Transactional(rollbackFor = BaseException.class)
    @Override
    public boolean updateStateByCode(String code, ProjectState newState, ProjectState... oldStates) {
        Project project = projectDAO.selectByCode(code);
        if (null == project) {
            throw new ProjectException(BaseException.BaseExceptionEnum.Result_Not_Exist);
        }

        int updateCount = projectDAO.updateStateByCode(code, newState, oldStates);
        return updateCount > 0 ? true : false;
    }

}
