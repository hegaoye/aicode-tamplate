package com.my.project.dao;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.UpdateWrapper;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.my.core.base.BaseDAO;
import com.my.project.dao.mapper.ProjectMapper;
import com.my.project.entity.Project;
import com.my.project.entity.ProjectState;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

/**
 * Project DAO
 * 数据服务层
 */
@Repository
public class ProjectDAO extends BaseDAO<Project> {


    /**
     * Project mapper
     */
    @Autowired
    private ProjectMapper projectMapper;

    @Override
    protected BaseMapper<Project> getBaseMapper() {
        return projectMapper;
    }


    /**
     * 根据id，code查询 一条 Project 信息
     *
     * @param id   id
     * @param code 编码
     * @return Project
     */
    public Project selectOne(Long id, String code) {
        QueryWrapper<Project> queryWrapper = new QueryWrapper<>();
        queryWrapper.lambda()
                .eq(Project::getId, id)
                .eq(Project::getCode, code)
                .last("limit 1");
        Project project = this.selectOne(queryWrapper);
        return project;
    }

    /**
     * 根据id 查询 一条 Project 信息
     *
     * @param id id
     * @return Project
     */
    public Project selectById(Long id) {
        QueryWrapper<Project> queryWrapper = new QueryWrapper<>();
        queryWrapper.lambda()
                .eq(Project::getId, id);
        Project project = this.selectOne(queryWrapper);
        return project;
    }

    /**
     * 根据code 查询 一条 Project 信息
     *
     * @param code 编码
     * @return Project
     */
    public Project selectByCode(String code) {
        QueryWrapper<Project> queryWrapper = new QueryWrapper<>();
        queryWrapper.lambda()
                .eq(Project::getCode, code);
        Project project = this.selectOne(queryWrapper);
        return project;
    }


    /**
     * 更新 状态根据主键id
     *
     * @param id        id
     * @param newState  新状态
     * @param oldStates 老状态集合
     * @return 条数
     */
    public int updateStateById(Long id, ProjectState newState, ProjectState... oldStates) {
        UpdateWrapper<Project> updateWrapper = new UpdateWrapper<>();
        //条件
        updateWrapper.lambda().eq(Project::getId, id);
        int updateCount = this.updateByPk(updateWrapper, newState, oldStates);
        return updateCount;
    }


    /**
     * 更新 状态根据 主键 code
     *
     * @param code      code
     * @param newState  新状态
     * @param oldStates 老状态集合
     * @return 条数
     */
    public int updateStateByCode(String code, ProjectState newState, ProjectState... oldStates) {
        UpdateWrapper<Project> updateWrapper = new UpdateWrapper<>();
        updateWrapper.lambda().eq(Project::getCode, code);
        int updateCount = this.updateByPk(updateWrapper, newState, oldStates);
        return updateCount;
    }

    private int updateByPk(UpdateWrapper<Project> updateWrapper, ProjectState newState, ProjectState... oldStates) {
        updateWrapper.lambda().set(Project::getStatus, newState.name());
        if (oldStates != null && oldStates.length > 0) {
            List<String> statusList = Arrays.asList(oldStates).stream()
                    .map(projectState -> projectState.name())
                    .collect(Collectors.toList());
            updateWrapper.lambda().in(Project::getStatus, statusList);
        }
        int updateCount = projectMapper.update(null, updateWrapper);
        return updateCount;
    }

}
