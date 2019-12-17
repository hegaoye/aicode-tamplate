/*
 * ${copyright}
 */
package ${basePackage}.${model}.service;

import java.util.List;
import ${basePackage}.core.base.BaseSV;
import ${basePackage}.${model}.entity.${className};

/**
 * ${notes}
 *
 * @author ${author}
 */
public interface ${className}SV extends BaseSV<${className},Long> {

<#if (pkFields?size>0)>

    /**
     * 加载一个对象${className}
     * <#list pkFields as pkField>@param ${pkField.field} ${pkField.notes}</#list>
     * @return ${className}
     */
    ${className} load(<#list pkFields as pkField>${pkField.fieldType} ${pkField.field}<#if pkField_has_next>,</#if></#list>);

    /**
     * 删除对象${className}
     * <#list pkFields as pkField>@param ${pkField.field} ${pkField.notes}</#list>
     * @return ${className}
     */
     void delete(<#list pkFields as pkField>${pkField.fieldType} ${pkField.field}<#if pkField_has_next>,</#if></#list>);
</#if>

    /**
     * 查询${className}分页
     *
     * @param ${classNameLower}  ${notes}
     * @param offset 查询开始行
     * @param limit  查询行数
     * @return List<${className}>
     */
     List<${className}> list(${className} ${classNameLower}, int offset, int limit);

     int count(${className} ${classNameLower});
}
