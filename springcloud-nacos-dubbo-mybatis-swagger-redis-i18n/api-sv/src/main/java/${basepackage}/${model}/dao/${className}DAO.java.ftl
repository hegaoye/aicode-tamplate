/*
 * ${copyright}
 */
package ${basePackage}.${model}.dao;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.annotations.*;
import org.springframework.stereotype.Repository;
import java.util.List;
import java.util.Map;
import java.util.HashMap;
import java.util.Date;
import ${basePackage}.core.base.BaseDAO;
import ${basePackage}.${model}.entity.${className}State;
import ${basePackage}.${model}.entity.${className};

/**
 * ${notes}
 *
 * @author ${author}
 */
@Mapper
@Repository
public  interface ${className}DAO extends BaseDAO<${className}, Long> {

<#if (pkFields?size>0)>

    <#list pkFields as pkField>
    /**
     * 根据主键${pkField.field},oldStates 共同更新 ${className} 的状态到newState状态
     *
     * @param ${pkField.field} ${pkField.notes}
     * @param newState 新状态
     * @param oldStates 旧状态集合
     */
    void updateStateBy${pkField.field?cap_first}(@Param("${pkField.field}") ${pkField.fieldType} ${pkField.field},@Param("updateTime") Date updateTime,@Param("newState") ${className}State newState,@Param("oldStates") ${className}State... oldStates);
    </#list>

    <#list pkFields as pkField>
    /**
     * 根据主键${pkField.field} 更新 ${className} 的状态到另一个状态
     *
     * @param ${pkField.field} ${pkField.notes}
     * @param state 状态
     */
    void updateBy${pkField.field?cap_first}(@Param("${pkField.field}") ${pkField.fieldType} ${pkField.field},@Param("state") ${className}State state,@Param("updateTime") Date updateTime);
    </#list>

    /**
     * 删除对象${className}
     *@param params 实体的属性
     */
    void delete(Map<String, Object> params);

</#if>

<#if oneToOneList??&&(oneToOneList?size>0) || oneToManyList??&&(oneToManyList?size>0)>
    /**
     * 加载一个对象${className},所有关联数据都将被查询
     <#list pkFields as field>
     * @param ${field.field} ${field.notes}
     </#list>
     * @return ${className}
     */
    ${className} getDetail(<#list pkFields as field>@Param("${field.field}") ${field.fieldType} ${field.field}<#if field_has_next>,</#if></#list>);
</#if>

    /**
     * 查询${className}列表
     * @param rowBounds 分页参数
     * @return List<${className}>
     */
    List<${className}> list(RowBounds rowBounds);
}
