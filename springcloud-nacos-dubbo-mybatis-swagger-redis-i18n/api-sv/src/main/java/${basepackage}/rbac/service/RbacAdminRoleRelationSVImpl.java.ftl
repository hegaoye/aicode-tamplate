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
import ${basePackage}.rbac.dao.RbacAdminDAO;
import ${basePackage}.rbac.dao.RbacAdminRoleRelationDAO;
import ${basePackage}.rbac.dao.RbacRoleDAO;
import ${basePackage}.rbac.entity.RbacAdmin;
import ${basePackage}.rbac.entity.RbacAdminRoleRelation;
import ${basePackage}.rbac.util.RbacUtil;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.*;

import static ${basePackage}.core.exceptions.BaseException.*;

@Service("rbacAdminRoleRelationSV")
@Slf4j
public class RbacAdminRoleRelationSVImpl extends BaseSVImpl<RbacAdminRoleRelation, Long> implements RbacAdminRoleRelationSV {

    @Autowired
    private RbacAdminRoleRelationDAO rbacAdminRoleRelationDAO;

    @Autowired
    private RbacRoleDAO rbacRoleDAO;

    @Autowired
    private RbacAdminDAO adminDAO;

    @Resource
    private UidGenerator uidGenerator;

    @Override
    protected BaseDAO getBaseDAO() {
        return rbacAdminRoleRelationDAO;
    }

    /**
     * 为授权用户（管理员）绑定角色
     * 检查授权用户
     *
     * @param adminCode 被授权用户（管理员）编码
     * @param roleIds   要绑定的角色id
     * @param rbacAdmin 授权人
     * @return
     */
    @Override
    public List<RbacAdminRoleRelation> bindRoleAndPermission(String adminCode, List<Long> roleIds, RbacAdmin rbacAdmin) {
        if (StringUtils.isBlank(adminCode)) {
            throw new BaseException(ExceptionEnums.paramIsEmpty("授权用户"));
        }
        if (null == roleIds || roleIds.size() == 0) {
            throw new BaseException(ExceptionEnums.paramIsEmpty("绑定角色"));
        }
        // 根据编码查询授权用户（管理员）
        RbacAdmin authRbacAdmin = adminDAO.loadByCode(adminCode);
        if (null == authRbacAdmin) {
            throw new BaseException(ExceptionEnums.objIsNotExist("管理员"));
        }

        // 如果修改对象是超级管理员，仅允许超管自己修改
        RbacUtil.checkAdminPermission(authRbacAdmin, rbacAdmin);

        // 删除被授权用户当前已绑定的所有角色
        rbacAdminRoleRelationDAO.deleteByAdminCode(adminCode);

        Date now = new Date();

        List<RbacAdminRoleRelation> rbacAdminRoleRelations = new ArrayList<>();
        roleIds.forEach(roleId -> {
            rbacAdminRoleRelations.add(new RbacAdminRoleRelation(adminCode, roleId, rbacAdmin.getCode(), now));
        });

        rbacAdminRoleRelationDAO.batchInsert(rbacAdminRoleRelations);
        return rbacAdminRoleRelations;
    }

    /**
     * 加载一个对象RbacAdminRoleRelation
     *
     * @param id 关系记录ID
     * @return RbacAdminRoleRelation
     */
    @Override
    public RbacAdminRoleRelation load(Long id) {
        if (id == null) {
            throw new BaseException(ExceptionEnums.paramIsInvalid(""));
        }

        Map<String, Object> param = new HashMap<>();
        param.put("id", id);
        return rbacAdminRoleRelationDAO.load(param);
    }

    /**
     * 加载一个对象RbacAdminRoleRelation,(将查询关联数据)
     *
     * @param id 关系记录ID
     * @return RbacAdminRoleRelation
     */
    @Override
    public RbacAdminRoleRelation get(Long id) {
        if (id == null) {
            throw new BaseException(ExceptionEnums.paramIsInvalid(""));
        }

        Map<String, Object> param = new HashMap<>();
        param.put("id", id);
        return rbacAdminRoleRelationDAO.getDetail(id);
    }

    /**
     * 加载一个对象RbacAdminRoleRelation 通过id
     *
     * @param id 关系记录ID
     * @return RbacAdminRoleRelation
     */
    @Override
    public RbacAdminRoleRelation loadById(Long id) {
        if (id == null) {
            throw new BaseException(ExceptionEnums.paramIsInvalid(""));
        }
        return rbacAdminRoleRelationDAO.loadById(id);
    }


    /**
     * 删除对象RbacAdminRoleRelation
     *
     * @param id 关系记录ID
     * @return RbacAdminRoleRelation
     */
    @Override
    public void delete(Long id) {
        if (id == null) {
            throw new BaseException(ExceptionEnums.paramIsInvalid(""));
        }
        Map<String, Object> param = new HashMap<>();
        param.put("id", id);
        rbacAdminRoleRelationDAO.delete(param);
    }


    /**
     * 查询RbacAdminRoleRelation分页
     *
     * @param rbacAdminRoleRelation 对象
     * @param offset                查询开始行
     * @param limit                 查询行数
     * @return List<RbacAdminRoleRelation>
     */
    @Override
    public List<RbacAdminRoleRelation> list(RbacAdminRoleRelation rbacAdminRoleRelation, int offset, int limit) {
        if (offset < 0) {
            offset = 0;
        }

        if (limit < 0) {
            limit = Page.limit;
        }

        Map<String, Object> map = null;
        if (rbacAdminRoleRelation != null) {
            map = JSON.parseObject(JSON.toJSONString(rbacAdminRoleRelation, SerializerFeature.WriteDateUseDateFormat));
        } else {
            map = new HashMap<>();
        }
        return rbacAdminRoleRelationDAO.list(map, new RowBounds(offset, limit));
    }

    @Override
    public int count(RbacAdminRoleRelation rbacAdminRoleRelation) {
        Map<String, Object> map = null;
        if (rbacAdminRoleRelation != null) {
            map = JSON.parseObject(JSON.toJSONString(rbacAdminRoleRelation, SerializerFeature.WriteDateUseDateFormat));
        } else {
            map = new HashMap<>();
        }
        return rbacAdminRoleRelationDAO.count(map);
    }
}