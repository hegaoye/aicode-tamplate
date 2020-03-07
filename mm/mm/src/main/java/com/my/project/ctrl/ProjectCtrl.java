/*
 * mm
 */
package com.my.project.ctrl;

import com.alibaba.fastjson.JSON;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.my.core.entity.Page;
import com.my.core.entity.PageVO;
import com.my.core.entity.R;
import com.my.project.entity.Project;
import com.my.project.service.ProjectSV;
import com.my.project.vo.ProjectPageVO;
import com.my.project.vo.ProjectSaveVO;
import com.my.project.vo.ProjectVO;
import io.swagger.annotations.*;
import lombok.extern.slf4j.Slf4j;
import org.beetl.core.Configuration;
import org.beetl.core.GroupTemplate;
import org.beetl.core.Template;
import org.beetl.core.resource.FileResourceLoader;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import springfox.documentation.annotations.ApiIgnore;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

/**
 * 账户 控制器
 *
 * @author mm
 */
@RestController
@RequestMapping("/project")
@Slf4j
@Api(value = "账户控制器", description = "账户控制器")
public class ProjectCtrl {
    @Autowired
    private ProjectSV projectSV;

    /**
     * 创建Project
     *
     * @return R
     */
    @ApiOperation(value = "创建Project", notes = "创建Project")
    @PostMapping("/build")
    @ResponseBody
    public ProjectSaveVO build(@ApiParam(name = "创建Project", value = "传入json格式", required = true) @RequestBody ProjectSaveVO projectSaveVO) {
        if (null == projectSaveVO) {
            return null;
        }
        Project newProject = new Project();
        BeanUtils.copyProperties(projectSaveVO, newProject);

        Project project = projectSV.save(newProject);
        if (null == project) {
            return null;
        }

        projectSaveVO = new ProjectSaveVO();
        BeanUtils.copyProperties(project, projectSaveVO);
        log.debug(JSON.toJSONString(projectSaveVO));
        return projectSaveVO;
    }


    /**
     * 查询Project一个详情信息
     *
     * @param id
     * @param code 账户编码
     * @return R
     */
    @ApiOperation(value = "查询Project一个详情信息", notes = "查询Project一个详情信息")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "id", value = "", dataType = "java.lang.Long", paramType = "query"),
            @ApiImplicitParam(name = "code", value = "账户编码", dataType = "java.lang.String", paramType = "query")
    })
    @GetMapping(value = "/load")
    @ResponseBody
    public ProjectVO load(java.lang.Long id, java.lang.String code) {
        if (id == null) {
            return null;
        }
        if (code == null) {
            return null;
        }
        Project project = projectSV.load(id, code);
        if (null == project) {
            return null;
        }
        ProjectVO projectVO = new ProjectVO();
        BeanUtils.copyProperties(project, projectVO);
        log.debug(JSON.toJSONString(projectVO));
        return projectVO;
    }


    /**
     * 根据条件id查询Project一个详情信息
     *
     * @param id
     * @return R
     */
    @ApiOperation(value = "查询Project一个详情信息", notes = "查询Project一个详情信息")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "id", value = "", dataType = "java.lang.Long", paramType = "path")
    })
    @GetMapping(value = "/load/id/{id}")
    @ResponseBody
    public ProjectVO loadById(@PathVariable java.lang.Long id) {
        if (id == null) {
            return null;
        }
        Project project = projectSV.loadById(id);
        if (null == project) {
            return null;
        }
        ProjectVO projectVO = new ProjectVO();
        BeanUtils.copyProperties(project, projectVO);
        log.debug(JSON.toJSONString(projectVO));
        return projectVO;
    }

    /**
     * 根据条件code查询Project一个详情信息
     *
     * @param code 账户编码
     * @return R
     */
    @ApiOperation(value = "查询Project一个详情信息", notes = "查询Project一个详情信息")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "code", value = "账户编码", dataType = "java.lang.String", paramType = "path")
    })
    @GetMapping(value = "/load/code/{code}")
    @ResponseBody
    public ProjectVO loadByCode(@PathVariable java.lang.String code) {
        if (code == null) {
            return null;
        }
        Project project = projectSV.loadByCode(code);
        if (null == project) {
            return null;
        }
        ProjectVO projectVO = new ProjectVO();
        BeanUtils.copyProperties(project, projectVO);
        log.debug(JSON.toJSONString(projectVO));
        return projectVO;
    }

    /**
     * 查询Project信息集合
     *
     * @return 分页对象
     */
    @ApiOperation(value = "查询Project信息集合", notes = "查询Project信息集合")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "curPage", value = "当前页", required = true, paramType = "query"),
            @ApiImplicitParam(name = "pageSize", value = "分页大小", required = true, paramType = "query"),
            @ApiImplicitParam(name = "createTimeBegin", value = "", paramType = "query"),
            @ApiImplicitParam(name = "createTimeEnd", value = "", paramType = "query"),
            @ApiImplicitParam(name = "updateTimeBegin", value = "", paramType = "query"),
            @ApiImplicitParam(name = "updateTimeEnd", value = "", paramType = "query")
    })
    @GetMapping(value = "/list")
    @ResponseBody
    public PageVO<ProjectVO> list(@ApiIgnore ProjectPageVO projectVO, Integer curPage, Integer pageSize) {
        Page<Project> page = new Page<>(pageSize, curPage);
        QueryWrapper<Project> queryWrapper = new QueryWrapper<>();
        if (projectVO.getCreateTimeBegin() != null) {
            queryWrapper.lambda().gt(Project::getCreateTime, projectVO.getCreateTimeBegin());
        }
        if (projectVO.getCreateTimeEnd() != null) {
            queryWrapper.lambda().lt(Project::getCreateTime, projectVO.getCreateTimeEnd());
        }
        if (projectVO.getStatus() != null) {
            queryWrapper.lambda().eq(Project::getStatus, projectVO.getStatus());
        }

        int total = projectSV.count(queryWrapper);
        PageVO<ProjectVO> projectVOPageVO = new PageVO<>();
        if (total > 0) {
            List<Project> projectList = projectSV.list(queryWrapper, page.genRowStart(), page.getPageSize());
            page.setTotalRow(total);
            page.setRecords(projectList);
            BeanUtils.copyProperties(page, projectVOPageVO);
            log.debug(JSON.toJSONString(page));
        }
        return projectVOPageVO;
    }


    /**
     * 统计Project信息数量
     *
     * @return 总条数
     */
    @ApiOperation(value = "统计Project信息数量", notes = "统计Project信息数量")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "code", value = "账户编码", paramType = "query"),
            @ApiImplicitParam(name = "account", value = "账户", paramType = "query"),
            @ApiImplicitParam(name = "password", value = "密码", paramType = "query"),
            @ApiImplicitParam(name = "status", value = "", paramType = "query"),
            @ApiImplicitParam(name = "createTime", value = "", paramType = "query")
    })
    @GetMapping(value = "/count")
    @ResponseBody
    public Integer count(@ApiIgnore ProjectPageVO projectPageVO) {
        QueryWrapper<Project> queryWrapper = new QueryWrapper<>();
        if (projectPageVO.getCreateTimeBegin() != null) {
            queryWrapper.lambda().gt(Project::getCreateTime, projectPageVO.getCreateTimeBegin());
        }
        if (projectPageVO.getCreateTimeEnd() != null) {
            queryWrapper.lambda().lt(Project::getCreateTime, projectPageVO.getCreateTimeEnd());
        }
        if (projectPageVO.getStatus() != null) {
            queryWrapper.lambda().eq(Project::getStatus, projectPageVO.getStatus());
        }
        return projectSV.count(queryWrapper);
    }


    /**
     * 修改Project
     *
     * @return R
     */
    @ApiOperation(value = "修改Project", notes = "修改Project")
    @PutMapping("/modify")
    @ResponseBody
    public boolean modify(@ApiParam(name = "创建Project", value = "传入json格式", required = true) @RequestBody ProjectVO projectVO) {
        Project newProject = new Project();
        BeanUtils.copyProperties(projectVO, newProject);
        boolean isUpdated = projectSV.modify(newProject, Project::getCode);
        return isUpdated;
    }

    /**
     * 删除Project
     *
     * @return R
     */
    @ApiOperation(value = "删除Project", notes = "删除Project")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "id", value = "", paramType = "query"),
            @ApiImplicitParam(name = "code", value = "账户编码", paramType = "query")
    })
    @DeleteMapping("/delete")
    @ResponseBody
    public R delete(@ApiIgnore ProjectVO projectVO) {
        Project newProject = new Project();
        BeanUtils.copyProperties(projectVO, newProject);
        projectSV.delete(newProject, Project::getCode);
        return R.success("删除Project成功");
    }


    @GetMapping(value = "/b")
    @ResponseBody
    public String b() throws IOException {
        String s = this.a();
        return s;
    }

    public String a() throws IOException {
        String root = System.getProperty("user.dir") + File.separator + "\\mm\\src\\main\\resources";
        FileResourceLoader resourceLoader = new FileResourceLoader(root, "utf-8");
        Configuration cfg = Configuration.defaultConfiguration();
        cfg.setPlaceholderStart("$");
        cfg.setPlaceholderEnd("$");
        cfg.setStatementStart("/***");
        cfg.setStatementEnd("***/");
        GroupTemplate gt = new GroupTemplate(resourceLoader, cfg);

        Project project = new Project();
        project.setCode("123");
        project.setAccount("abc");
        List<Project> list = new ArrayList<>();
        list.add(project);
        Template t = gt.getTemplate("pojo.beetl");
        t.binding("className", "Beetl");
        t.binding("projectList", list);
        String str = t.render();
        System.out.println(str);
        return str;
    }
}
