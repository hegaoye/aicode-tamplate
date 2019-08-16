/*
* ${copyright}
*/
package ${basePackage}.${model}.ctrl;

import ${basePackage}.core.enums.ActionTypeEnum;
import ${basePackage}.core.enums.RoleTypeEnum;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiImplicitParams;
import io.swagger.annotations.ApiOperation;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import springfox.documentation.annotations.ApiIgnore;

import javax.annotation.Resource;
import java.util.List;

import ${basePackage}.core.exceptions.BaseException;
import ${basePackage}.core.entity.BeanRet;
import ${basePackage}.core.entity.Page;
import ${basePackage}.core.redis.RedisUtils;
import ${basePackage}.${model}.entity.${className};
import ${basePackage}.${model}.service.${className}SV;
import ${basePackage}.syslog.annotation.SystemControllerLog;

/**
 * ${notes} 控制器
 *
 * @author ${author}
 */
@RestController
@RequestMapping("/${className?uncap_first}")
@Slf4j
@Api(tags = "${className}Ctrl", description = "${notes}控制器")
public class ${className}Ctrl {

    @Resource
    protected RedisUtils redisUtils;
    @Autowired
    private ${className}SV ${classNameLower}SV;


<#if (pkFields?size>0)>
   /**
    * 查询${className}一个详情信息
    <#list pkFields as pkField>
    * @param ${pkField.field} ${pkField.notes}
    </#list>
    * @return BeanRet
    */
    @SystemControllerLog(actionType = ActionTypeEnum.select, roleType = RoleTypeEnum.User, description = "查询${className}一个详情信息")
    @ApiOperation(value = "查询${className}一个详情信息", notes = "查询${className}一个详情信息")
    @ApiImplicitParams({
    <#list pkFields as pkField>
        @ApiImplicitParam(name = "${pkField.field}", value = "${pkField.notes}", dataType = "${pkField.fieldType}", paramType = "query", required = true)<#if pkField_has_next>,</#if>
    </#list>
    })
    @GetMapping(value = "/load")
    @ResponseBody
    public BeanRet load(<#list pkFields as pkField>${pkField.fieldType} ${pkField.field}<#if pkField_has_next>,</#if></#list>) {
    <#list pkFields as pkField>
        if(${pkField.field}==null){
          return null;
        }
    </#list>
    ${className} ${classNameLower} = ${classNameLower}SV.load(<#list pkFields as pkField>${pkField.field}<#if pkField_has_next>,</#if></#list>);
        return BeanRet.create(true, BaseException.ExceptionEnums.success, ${classNameLower});
    }

</#if>

    /**
    * 查询${className}信息集合
    *
    * @return 分页对象
    */
    @SystemControllerLog(actionType = ActionTypeEnum.select, roleType = RoleTypeEnum.User, description = "查询${className}信息集合")
    @ApiOperation(value = "查询${className}信息集合", notes = "查询${className}信息集合")
    @ApiImplicitParams({
        @ApiImplicitParam(name = "curPage", value = "当前页", required = true, paramType = "query", defaultValue = "1"),
        @ApiImplicitParam(name = "pageSize", value = "分页大小", required = true, paramType = "query", defaultValue = "10"),

<#list fields as field>
    <#if field.checkDate>
            @ApiImplicitParam(name = "${field.field}Begin", value = "${field.notes}", paramType = "query"),
            @ApiImplicitParam(name = "${field.field}End", value = "${field.notes}", paramType = "query")<#if field_has_next>,</#if>
    </#if>
</#list>
    })
    @GetMapping(value = "/list")
    @ResponseBody
    public BeanRet list(@ApiIgnore ${className} ${classNameLower},@ApiIgnore Page<${className}> page) {
        if(page==null){
            return BeanRet.create(BaseException.ExceptionEnums.paramIsEmpty("分页设置"));
        }
        List<${className}> ${classNameLower}s = ${classNameLower}SV.list(${classNameLower},page.genRowStart(),page.getPageSize());
        int total = ${classNameLower}SV.count(${classNameLower});
        page.setTotalRow(total);
        page.setVoList(${classNameLower}s);
        return BeanRet.create(true, BaseException.ExceptionEnums.success, "", page);
    }

}