/*
* ${copyright}
*/
package ${basePackage}.${model}.entity;

import lombok.Data;

<#if oneToOneList??&&(oneToOneList?size>0)>
<#list oneToOneList as oneToOne>
import ${basePackage}.${oneToOne.model}.entity.${oneToOne.className};
</#list>
<#elseif oneToManyList??&&(oneToManyList?size>0)>
<#list oneToManyList as oneToMany>
import ${basePackage}.${oneToMany.model}.entity.${oneToMany.className};
import java.util.List;
</#list>
</#if>

/**
* ${notes} 的实体类
*
* @author ${author}
*/
@Data
public class ${className} implements java.io.Serializable {

<#if fields??&&(fields?size>0)>
<#list fields as field>
    //数据库字段:${field.column}  属性显示:${field.notes}
    private ${field.fieldType} ${field.field};

    <#if field.checkDate>
    //数据库字段:${field.column}  属性显示:${field.notes}
    private ${field.fieldType} ${field.field}Begin;
    //数据库字段:${field.column}  属性显示:${field.notes}
    private ${field.fieldType} ${field.field}End;
    </#if>
</#list>
</#if>

<#if oneToOneList??&&(oneToOneList?size>0)>
<#list oneToOneList as oneToOne>
    //1对1关联查询${oneToOne.className} ${oneToOne.notes}  属性显示:${oneToOne.classNameLower}
    private ${oneToOne.className} ${oneToOne.classNameLower};
</#list>
</#if>

<#if oneToManyList??&&(oneToManyList?size>0)>
<#list oneToManyList as oneToMany>
    //1对多关联查询${oneToMany.className} ${oneToMany.notes}  属性显示:${oneToMany.classNameLower}
    private List<${oneToMany.className}> ${oneToMany.classNameLower}List;
</#list>
</#if>



}
