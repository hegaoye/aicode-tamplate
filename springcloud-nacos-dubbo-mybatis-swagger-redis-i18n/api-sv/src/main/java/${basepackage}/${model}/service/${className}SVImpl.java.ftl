/*
 * ${copyright}
 */
package ${basePackage}.${model}.service;

import com.alibaba.dubbo.config.annotation.Service;
import ${basePackage}.core.entity.Page;
import ${basePackage}.core.exceptions.BaseException;
import ${basePackage}.${model}.dao.${className}DAO;
import ${basePackage}.${model}.entity.${className};
import ${basePackage}.core.base.BaseDAO;
import ${basePackage}.core.base.BaseSVImpl;
import com.alibaba.fastjson.serializer.SerializerFeature;
import lombok.extern.slf4j.Slf4j;
import com.alibaba.fastjson.JSON;
import org.springframework.beans.factory.annotation.Autowired;
import javax.annotation.Resource;
import java.util.List;
import java.util.HashMap;
import java.util.Date;
import java.util.Map;
import org.apache.ibatis.session.RowBounds;
import com.baidu.fsg.uid.UidGenerator;

@Slf4j
@Service(version = "${r'${dubbo.provider.version}'}")
public class ${className}SVImpl extends BaseSVImpl<${className}, Long> implements ${className}SV {

    @Autowired
    private ${className}DAO ${classNameLower}DAO;

    @Resource
    private UidGenerator uidGenerator;

    @Override
    protected BaseDAO getBaseDAO() {
        return ${classNameLower}DAO;
    }

    /**
    * 保存account对象
    *
    * @param entity 实体
    * @throws BaseException
    */
    @Override
    public void save(${className} entity) throws BaseException {
        <#list fields as field>
        <#if field.checkPk && field.field?contains("code")>
        entity.set${field.field?cap_first}(String.valueOf(uidGenerator.getUID()));
        </#if>
        <#if field.checkDate>
        entity.set${field.field?cap_first}(new Date());
        </#if>
        </#list>
        super.save(entity);
    }

<#if (pkFields?size>0)>
    /**
     * 加载一个对象${className}
     <#list pkFields as field>* @param ${field.field} ${field.notes}</#list>
     * @return ${className}
     */
    @Override
    public ${className} load(<#list pkFields as field>${field.fieldType} ${field.field}<#if field_has_next>,</#if></#list>) {
        if(<#list pkFields as field>${field.field}==null<#if field_has_next>&&</#if></#list>){
             throw new BaseException(BaseException.ExceptionEnums.paramIsInvalid(""));
        }

        Map<String,Object> param=new HashMap<>();
        <#list pkFields as field>
        param.put("${field.field}",${field.field});
        </#list>
        return ${classNameLower}DAO.load(param);
    }

    /**
     * 删除对象${className}
     <#list pkFields as pkField>* @param ${pkField.field} ${pkField.notes}</#list>
     * @return ${className}
     */
    @Override
    public void delete(<#list pkFields as pkField>${pkField.fieldType} ${pkField.field}<#if pkField_has_next>,</#if></#list>) {
        if(<#list pkFields as field>${field.field}==null<#if field_has_next>&&</#if></#list>){
            throw new BaseException(BaseException.ExceptionEnums.paramIsInvalid(""));
        }
        Map<String,Object> param=new HashMap<>();
        <#list pkFields as pkField>
        param.put("${pkField.field}",${pkField.field});
        </#list>
        ${classNameLower}DAO.delete(param);
    }
</#if>

    /**
    * 查询${className}分页
    *
    * @param ${classNameLower}  对象
    * @param offset 查询开始行
    * @param limit  查询行数
    * @return List<${className}>
    */
    @Override
    public List<${className}> list(${className} ${classNameLower}, int offset, int limit) {
            if (offset < 0) {
               offset = 0;
            }

            if (limit < 0) {
               limit = Page.limit;
            }

            Map<String, Object> map = null;
            if (${classNameLower} != null) {
               map = JSON.parseObject(JSON.toJSONString(${classNameLower}, SerializerFeature.WriteDateUseDateFormat));
            } else {
               map = new HashMap<>();
            }
        return ${classNameLower}DAO.list(map, new RowBounds(offset, limit));
    }

    @Override
    public  int count(${className} ${classNameLower}){
        Map<String, Object> map = null;
        if (${classNameLower} != null) {
           map = JSON.parseObject(JSON.toJSONString(${classNameLower}, SerializerFeature.WriteDateUseDateFormat));
        } else {
           map = new HashMap<>();
        }
       return ${classNameLower}DAO.count(map);
     }
}