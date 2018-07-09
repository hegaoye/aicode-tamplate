/*
 * ${copyright}
 */
package ${basePackage}.${model}.entity;

import ${basePackage}.core.base.BaseEntity;
import lombok.Data;
import com.alibaba.fastjson.annotation.JSONField;

/**
 * ${notes}
 * @author ${author}
 */
@Data
public class ${className} extends BaseEntity implements java.io.Serializable {

<#list fields as field>
<#if field.field!='id'>
	<#if field.field=='password'>
    @JSONField(serialize = false)
    private ${field.fieldType} ${field.field};//数据库字段:${field.column}  属性显示:${field.notes}
	<#else>
    private ${field.fieldType} ${field.field};//数据库字段:${field.column}  属性显示:${field.notes}
	</#if>
</#if>
<#if field.checkDate>
	private ${field.fieldType} ${field.field}Begin;//数据库字段:${field.column}  属性显示:${field.notes}
	private ${field.fieldType} ${field.field}End;//数据库字段:${field.column}  属性显示:${field.notes}
</#if>
</#list>
}
