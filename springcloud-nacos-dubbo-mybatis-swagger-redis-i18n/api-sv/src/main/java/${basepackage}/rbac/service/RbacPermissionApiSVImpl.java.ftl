/*
 * ${copyright}
 */
package ${basePackage}.rbac.service;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.serializer.SerializerFeature;
import com.baidu.fsg.uid.UidGenerator;
import ${basePackage}.core.base.BaseDAO;
import ${basePackage}.core.base.BaseSVImpl;
import ${basePackage}.core.entity.Page;
import ${basePackage}.core.exceptions.BaseException;
import ${basePackage}.rbac.dao.RbacPermissionApiDAO;
import ${basePackage}.rbac.entity.RbacPermissionApi;
import lombok.extern.slf4j.Slf4j;
import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service("rbacPermissionApiSV")
@Slf4j
public class RbacPermissionApiSVImpl extends BaseSVImpl<RbacPermissionApi, Long> implements RbacPermissionApiSV {

    @Autowired
    private RbacPermissionApiDAO rbacPermissionApiDAO;

    @Resource
    private UidGenerator uidGenerator;

    @Override
    protected BaseDAO getBaseDAO() {
        return rbacPermissionApiDAO;
    }

    /**
    * 保存account对象
    *
    * @param entity 实体
    * @throws BaseException
    */
    @Override
    public void save(RbacPermissionApi entity) throws BaseException {
        entity.setCreateTime(new Date());
        entity.setUpdateTime(new Date());
        super.save(entity);
    }

    /**
     * 加载一个对象RbacPermissionApi
     * @param id 权限授权记录id
     * @return RbacPermissionApi
     */
    @Override
    public RbacPermissionApi load(Long id) {
        if(id==null){
             throw new BaseException(BaseException.ExceptionEnums.paramIsInvalid(""));
        }

        Map<String,Object> param=new HashMap<>();
        param.put("id",id);
        return rbacPermissionApiDAO.load(param);
    }

    /**
    * 加载一个对象RbacPermissionApi,(将查询关联数据)
        * @param id 权限授权记录id
    * @return RbacPermissionApi
    */
    @Override
    public RbacPermissionApi get(Long id) {
        if(id==null){
            throw new BaseException(BaseException.ExceptionEnums.paramIsInvalid(""));
        }

        Map<String,Object> param=new HashMap<>();
        param.put("id",id);
        return rbacPermissionApiDAO.getDetail(id);
    }

    /**
     * 加载一个对象RbacPermissionApi 通过id
     * @param id 权限授权记录id
     * @return RbacPermissionApi
     */
    @Override
    public RbacPermissionApi loadById(Long id) {
            if(id==null){
                 throw new BaseException(BaseException.ExceptionEnums.paramIsInvalid(""));
            }
            return rbacPermissionApiDAO.loadById(id);
    }


    /**
     * 删除对象RbacPermissionApi
     * @param id 权限授权记录id
     * @return RbacPermissionApi
     */
    @Override
    public void delete(Long id) {
        if(id==null){
            throw new BaseException(BaseException.ExceptionEnums.paramIsInvalid(""));
        }
        Map<String,Object> param=new HashMap<>();
        param.put("id",id);
        rbacPermissionApiDAO.delete(param);
    }



    /**
    * 查询RbacPermissionApi分页
    *
    * @param rbacPermissionApi  对象
    * @param offset 查询开始行
    * @param limit  查询行数
    * @return List<RbacPermissionApi>
    */
    @Override
    public List<RbacPermissionApi> list(RbacPermissionApi rbacPermissionApi, int offset, int limit) {
            if (offset < 0) {
               offset = 0;
            }

            if (limit < 0) {
               limit = Page.limit;
            }

            Map<String, Object> map = null;
            if (rbacPermissionApi != null) {
               map = JSON.parseObject(JSON.toJSONString(rbacPermissionApi, SerializerFeature.WriteDateUseDateFormat));
            } else {
               map = new HashMap<>();
            }
        return rbacPermissionApiDAO.list(map, new RowBounds(offset, limit));
    }

    @Override
    public  int count(RbacPermissionApi rbacPermissionApi){
        Map<String, Object> map = null;
        if (rbacPermissionApi != null) {
           map = JSON.parseObject(JSON.toJSONString(rbacPermissionApi, SerializerFeature.WriteDateUseDateFormat));
        } else {
           map = new HashMap<>();
        }
       return rbacPermissionApiDAO.count(map);
     }
}