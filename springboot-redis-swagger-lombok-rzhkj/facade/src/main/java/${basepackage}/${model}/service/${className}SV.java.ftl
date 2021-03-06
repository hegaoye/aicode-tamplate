/*
 * ${copyright}
 */
package ${basePackage}.${model}.service;

import ${basePackage}.core.base.BaseSV;
import com.rzhkj.core.entity.Page;
import ${basePackage}.${model}.entity.${className}State;
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

    <#list pkFields as pkField>
    /**
     * 加载一个对象${className} 通过${pkField.field}
     * @param ${pkField.field} ${pkField.notes}
     * @return ${className}
     */
     ${className} loadBy${pkField.field?cap_first}(${pkField.fieldType} ${pkField.field});
   </#list>


    <#list pkFields as pkField>
    /**
    * 根据主键${pkField.field},oldStates 共同更新 ${className} 的状态到newState状态
    *
    * @param ${pkField.field} ${pkField.notes}
    * @param newState 新状态
    * @param oldStates 旧状态集合
    */
    void updateStateBy${pkField.field?cap_first}(${pkField.fieldType} ${pkField.field},${className}State newState,${className}State... oldStates);
    </#list>

    <#list pkFields as pkField>
    /**
    * 根据主键${pkField.field} 更新 ${className} 的状态到另一个状态
    *
    * @param ${pkField.field} ${pkField.notes}
    * @param state 状态
    */
    void updateBy${pkField.field?cap_first}(${pkField.fieldType} ${pkField.field},${className}State state);
    </#list>


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
     * @param page 分页对象
     * @return Page<${className}>
     */
     Page<${className}> list(${className} ${classNameLower}, Page<${className}> page);
     int count(${className} ${classNameLower});
}
