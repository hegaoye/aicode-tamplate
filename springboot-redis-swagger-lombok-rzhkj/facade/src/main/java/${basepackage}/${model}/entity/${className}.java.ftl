/*
* ${copyright}
*/
package ${basePackage}.${model}.entity;

import lombok.Data;

/**
* ${notes} 的实体类
*
* @author ${author}
*/
@Data
public class ${className} implements java.io.Serializable {

<#list fields as field>
    /**
     * 数据库字段:${field.column}  属性显示:${field.notes}
     */
    private ${field.fieldType} ${field.field};

    <#if field.checkDate>
    /**
     * 数据库字段:${field.column}  属性显示:${field.notes}
     */
    private ${field.fieldType} ${field.field}Begin;
    /**
     * 数据库字段:${field.column}  属性显示:${field.notes}
     */
    private ${field.fieldType} ${field.field}End;
    </#if>
</#list>
}
