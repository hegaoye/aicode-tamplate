/*
 * ${copyright}
 */
package ${basePackage}.rbac.service;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.serializer.SerializerFeature;
import com.baidu.fsg.uid.UidGenerator;
${basePackage}.core.base.BaseDAO;
${basePackage}.core.base.BaseSVImpl;
${basePackage}.core.entity.Page;
${basePackage}.core.exceptions.BaseException;
${basePackage}.rbac.dao.RbacPermissionActionDAO;
${basePackage}.rbac.entity.RbacPermissionAction;
import lombok.extern.slf4j.Slf4j;
import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service("rbacPermissionActionSV")
@Slf4j
public class RbacPermissionActionSVImpl extends BaseSVImpl<RbacPermissionAction, Long> implements RbacPermissionActionSV {

    @Autowired
    private RbacPermissionActionDAO rbacPermissionActionDAO;

    @Resource
    private UidGenerator uidGenerator;

    @Override
    protected BaseDAO getBaseDAO() {
        return rbacPermissionActionDAO;
    }

    /**
    * 保存account对象
    *
    * @param entity 实体
    * @throws BaseException
    */
    @Override
    public void save(RbacPermissionAction entity) throws BaseException {
        entity.setCreateTime(new Date());
        entity.setUpdateTime(new Date());
        super.save(entity);
    }

    /**
     * 加载一个对象RbacPermissionAction
     * @param id 主键ID
     * @return RbacPermissionAction
     */
    @Override
    public RbacPermissionAction load(Long id) {
        if(id==null){
             throw new BaseException(BaseException.ExceptionEnums.paramIsInvalid(""));
        }

        Map<String,Object> param=new HashMap<>();
        param.put("id",id);
        return rbacPermissionActionDAO.load(param);
    }

    /**
    * 加载一个对象RbacPermissionAction,(将查询关联数据)
        * @param id 主键ID
    * @return RbacPermissionAction
    */
    @Override
    public RbacPermissionAction get(Long id) {
        if(id==null){
            throw new BaseException(BaseException.ExceptionEnums.paramIsInvalid(""));
        }

        Map<String,Object> param=new HashMap<>();
        param.put("id",id);
        return rbacPermissionActionDAO.getDetail(id);
    }

    /**
     * 加载一个对象RbacPermissionAction 通过id
     * @param id 主键ID
     * @return RbacPermissionAction
     */
    @Override
    public RbacPermissionAction loadById(Long id) {
            if(id==null){
                 throw new BaseException(BaseException.ExceptionEnums.paramIsInvalid(""));
            }
            return rbacPermissionActionDAO.loadById(id);
    }


    /**
     * 删除对象RbacPermissionAction
     * @param id 主键ID
     * @return RbacPermissionAction
     */
    @Override
    public void delete(Long id) {
        if(id==null){
            throw new BaseException(BaseException.ExceptionEnums.paramIsInvalid(""));
        }
        Map<String,Object> param=new HashMap<>();
        param.put("id",id);
        rbacPermissionActionDAO.delete(param);
    }



    /**
    * 查询RbacPermissionAction分页
    *
    * @param rbacPermissionAction  对象
    * @param offset 查询开始行
    * @param limit  查询行数
    * @return List<RbacPermissionAction>
    */
    @Override
    public List<RbacPermissionAction> list(RbacPermissionAction rbacPermissionAction, int offset, int limit) {
            if (offset < 0) {
               offset = 0;
            }

            if (limit < 0) {
               limit = Page.limit;
            }

            Map<String, Object> map = null;
            if (rbacPermissionAction != null) {
               map = JSON.parseObject(JSON.toJSONString(rbacPermissionAction, SerializerFeature.WriteDateUseDateFormat));
            } else {
               map = new HashMap<>();
            }
        return rbacPermissionActionDAO.list(map, new RowBounds(offset, limit));
    }

    @Override
    public  int count(RbacPermissionAction rbacPermissionAction){
        Map<String, Object> map = null;
        if (rbacPermissionAction != null) {
           map = JSON.parseObject(JSON.toJSONString(rbacPermissionAction, SerializerFeature.WriteDateUseDateFormat));
        } else {
           map = new HashMap<>();
        }
       return rbacPermissionActionDAO.count(map);
     }
}