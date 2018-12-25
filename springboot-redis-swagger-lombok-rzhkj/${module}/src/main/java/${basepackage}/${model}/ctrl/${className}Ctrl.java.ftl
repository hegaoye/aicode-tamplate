/*
* ${copyright}
*/
package ${basePackage}.${model}.ctrl;

import com.alibaba.fastjson.JSON;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiImplicitParams;
import io.swagger.annotations.ApiOperation;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;
import springfox.documentation.annotations.ApiIgnore;
import javax.annotation.Resource;
import java.util.List;
import java.util.HashMap;

import ${basePackage}.core.entity.BeanRet;
import ${basePackage}.core.entity.Page;
import ${basePackage}.core.tools.redis.RedisUtils;
import ${basePackage}.${model}.entity.${className};
import ${basePackage}.${model}.service.${className}SV;

/**
* ${notes} 控制器
*
* @author ${author}
*/
@RestController
@RequestMapping("/${className?uncap_first}")
@Slf4j
@Api(tags = "${notes}控制器", description = "${notes}控制器")
public class ${className}Ctrl {

    @Resource
    protected RedisUtils redisUtils;

    @Resource
    private ${className}SV ${className?uncap_first}SV;

    <#list pkFields as pkField>
    /**
    * 根据条件${pkField.field}查询${className}一个详情信息
    *
    * @param ${pkField.field} ${pkField.notes}
    * @return BeanRet
    */
    @ApiOperation(value = "查询${className}一个详情信息", notes = "查询${className}一个详情信息")
    @ApiImplicitParams({
       @ApiImplicitParam(name = "${pkField.field}", value = "${pkField.notes}",dataType = "${pkField.fieldType}", paramType = "path")
    })
    @GetMapping(value = "/load/${pkField.field}/{${pkField.field}}")
    @ResponseBody
    public ${className} loadBy${pkField.field?cap_first}(@PathVariable ${pkField.fieldType} ${pkField.field}) {
        if(${pkField.field}==null){
           return null;
        }
        ${className} ${classNameLower} = ${className?uncap_first}SV.loadBy${pkField.field?cap_first}(${pkField.field});
        log.info(JSON.toJSONString(${classNameLower}));
        return ${classNameLower};
    }
    </#list>


    /**
    * 查询${className}信息集合
    *
    * @return 分页对象
    */
    @ApiOperation(value = "查询${className}信息集合", notes = "查询${className}信息集合")
    @ApiImplicitParams({
    @ApiImplicitParam(name = "curPage", value = "当前页", required = true, paramType = "query"),
    @ApiImplicitParam(name = "pageSize", value = "分页大小", required = true, paramType = "query"),
    <#list fields as field>
        <#if field.checkDate>
        @ApiImplicitParam(name = "${field.field}Begin", value = "${field.notes}", paramType = "query"),
        @ApiImplicitParam(name = "${field.field}End", value = "${field.notes}", paramType = "query")<#if field_has_next>,</#if>
        </#if>
        @ApiImplicitParam(name = "curPage", value = "当前页", paramType = "query", dataType = "int"),
        @ApiImplicitParam(name = "pageSize", value = "分页大小", paramType = "query", dataType = "int")
    </#list>
    })
    @GetMapping(value = "/list")
    @ResponseBody
    public BeanRet list(@RequestBody @ApiIgnore ${className} ${classNameLower},@ApiIgnore Page<${className}> page) {
        page = ${className?uncap_first}SV.list(${classNameLower},page);
        log.info(JSON.toJSONString(page));
        return BeanRet.create(true, "查询成功", page);
    }


    /**
    * 创建${className}
    *
    * @return BeanRet
    */
    @ApiOperation(value = "创建${className}", notes = "创建${className}")
    @ApiImplicitParams({
    <#list notPkFields as field>
    @ApiImplicitParam(name = "${field.field}", value = "${field.notes}", paramType = "query")<#if field_has_next>,</#if>
    </#list>
    })
    @PostMapping("/save")
    @ResponseBody
    public BeanRet save(@RequestBody @ApiIgnore ${className} ${classNameLower}) {
        ${classNameLower} = ${className?uncap_first}SV.save(${classNameLower});
        return BeanRet.create(true, "保存成功", ${classNameLower});
    }


    /**
    * 修改${className}
    *
    * @return BeanRet
    */
    @ApiOperation(value = "修改${className}", notes = "修改${className}")
    @ApiImplicitParams({
    <#list fields as field>
        @ApiImplicitParam(name = "${field.field}", value = "${field.notes}", paramType = "query")<#if field_has_next>,</#if>
    </#list>
    })
    @PutMapping("/update")
    @ResponseBody
    public BeanRet update(@ApiIgnore ${className} ${classNameLower}) {
        ${classNameLower} = ${className?uncap_first}SV.modify(${classNameLower});
        return BeanRet.create(true, "修改成功", ${classNameLower});
    }

    /**
    * 删除${className}
    *
    * @return BeanRet
    */
    @ApiOperation(value = "删除${className}", notes = "删除${className}")
    @ApiImplicitParams({
    <#list pkFields as pkField>
        @ApiImplicitParam(name = "${pkField.field}", value = "${pkField.notes}", paramType = "query")<#if pkField_has_next>,</#if>
    </#list>
    })
    @DeleteMapping("/delete")
    @ResponseBody
    public BeanRet delete(<#list pkFields as pkField>${pkField.fieldType} ${pkField.field}<#if pkField_has_next>,</#if></#list>) {
        ${className?uncap_first}SV.delete(<#list pkFields as pkField>${pkField.field}<#if pkField_has_next>,</#if></#list>);
        return BeanRet.create(true, "删除成功");
    }

}
