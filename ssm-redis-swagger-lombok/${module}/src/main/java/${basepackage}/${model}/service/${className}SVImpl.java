/*
 * ${copyright}
 */
package ${basePackage}.${model}.service;

import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;
import javax.annotation.Resource;

import com.rzhkj.core.base.BaseMybatisDAO;
import com.rzhkj.core.base.BaseMybatisSVImpl;

import ${basePackage}.${model}.facade.${className}SV;
import ${basePackage}.${model}.dao.${className}DAO;
import ${basePackage}.${model}.entity.${className};


/**
 * ${notes}
 * @author ${author}
 */
@Component
@Service
public class ${className}SVImpl extends BaseMybatisSVImpl<${className},Long> implements ${className}SV{


	@Resource
	private ${className}DAO ${classNameLower}DAO;

    @Override
    protected BaseMybatisDAO getBaseMybatisDAO(){
		return ${classNameLower}DAO;
	}

<#if (pkFields?size>0)>

	<#list pkFields as pkField>
	<#if pkField.field!='id'>
	/**
	 * 加载对象${notes} 通过${pkField.field}
	 * @param ${pkField.field} ${pkField.notes}
	 * @return ${className}
	 */
     @Override
     public ${className} loadBy${pkField.field?cap_first}(${pkField.fieldType} ${pkField.field}) {
		return ${classNameLower}DAO.loadBy${pkField.field?cap_first}(${pkField.field});
	 }
	</#if>
	</#list>

     /**
      * 删除对象${notes}
	   <#list pkFields as pkField>* @param ${pkField.field} ${pkField.notes}</#list>
      */
	 @Override
     public void delete(<#list pkFields as pkField>${pkField.fieldType} ${pkField.field}<#if pkField_has_next>,</#if></#list>) {
		${classNameLower}DAO.delete(<#list pkFields as pkField>${pkField.field}<#if pkField_has_next>,</#if></#list>);
	 }

</#if>


}