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
${basePackage}.rbac.dao.RbacRoleDAO;
${basePackage}.rbac.dao.RbacRolePermissionRelationDAO;
${basePackage}.rbac.entity.RbacPermission;
${basePackage}.rbac.entity.RbacRole;
${basePackage}.rbac.entity.RbacRolePermissionRelation;
${basePackage}.rbac.vo.TreeMenuNodeVO;
import lombok.extern.slf4j.Slf4j;
import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.*;

import static com.rzhkj.nt.core.exceptions.BaseException.ExceptionEnums;

@Service("rbacRolePermissionRelationSV")
@Slf4j
public class RbacRolePermissionRelationSVImpl extends BaseSVImpl<RbacRolePermissionRelation, Long> implements RbacRolePermissionRelationSV {

    @Autowired
    private RbacRolePermissionRelationDAO rbacRolePermissionRelationDAO;

    @Autowired
    private RbacRoleDAO roleDAO;

    @Resource
    private UidGenerator uidGenerator;

    @Override
    protected BaseDAO getBaseDAO() {
        return rbacRolePermissionRelationDAO;
    }

    /**
     * 角色 绑定权限
     *
     * @param roleId        角色id
     * @param permissionIds 要绑定的权限id
     * @return
     */
    @Override
    public List<RbacRolePermissionRelation> bindRoleAndPermission(Long roleId, List<Long> permissionIds) {
        if (null == roleId) {
            throw new BaseException(ExceptionEnums.paramIsEmpty("角色"));
        }

        if (null == permissionIds || permissionIds.size() == 0) {
            throw new BaseException(ExceptionEnums.paramIsEmpty("要绑定的权限id"));
        }

        // 检查角色是否存在
        RbacRole role = roleDAO.loadById(roleId);
        if (null == role) {
            throw new BaseException(ExceptionEnums.objIsNotExist("角色"));
        }
        // 删除角色当前已经绑定的所有权限
        rbacRolePermissionRelationDAO.deleteByRoleId(roleId);

        Date now = new Date();

        List<RbacRolePermissionRelation> rbacRolePermissionRelations = new ArrayList<>();
        permissionIds.forEach(permissionId -> {
            rbacRolePermissionRelations.add(new RbacRolePermissionRelation(roleId, permissionId, now));
        });

        // 为角色新增绑定的权限
        rbacRolePermissionRelationDAO.batchInsert(rbacRolePermissionRelations);
        return rbacRolePermissionRelations;
    }

    /**
     * 根据角色查询绑定的所有权限，返回树结构
     *
     * @param roleId
     * @return
     */
    @Override
    public List<TreeMenuNodeVO> queryRolePermissionsTree(Long roleId) {
        // 根据角色查询绑定的所有权限
        List<RbacPermission> permissionList = queryRolePermissions(roleId);
        // 转换权限集合为权限树
        return TreeMenuNodeVO.permissionListToTree(permissionList);
    }

    /**
     * 根据角色查询绑定的所有权限
     *
     * @param roleId 角色id
     * @return
     */
    @Override
    public List<RbacPermission> queryRolePermissions(Long roleId) {
        if (null == roleId) {
            throw new BaseException(ExceptionEnums.paramIsEmpty("角色ID"));
        }
        // 查询角色 与 权限的所有关系
        List<RbacRolePermissionRelation> relations = rbacRolePermissionRelationDAO.queryRolePermissions(roleId);
        // 角色绑定的权限集合 转 权限集合
        List<RbacPermission> permissionList = RbacRolePermissionRelation.relationList2PermissionList(relations);
        return permissionList;
    }

    /**
     * 根据多角色查询绑定的所有权限
     *
     * @param roleIds 角色id
     * @return
     */
    @Override
    public List<RbacPermission> queryRolePermissions(List<Long> roleIds) {
        // 如果角色id为空，此处必须返回空（管理员登录时，会查询拥有的角色权限，不能抛异常）
        if (null == roleIds || roleIds.size() == 0) {
            return null;
        }
        // 查询角色 与 权限的所有关系
        List<RbacRolePermissionRelation> relations = rbacRolePermissionRelationDAO.queryRolesPermissions(roleIds);
        // 角色绑定的权限集合 转 权限集合
        List<RbacPermission> permissionList = RbacRolePermissionRelation.relationList2PermissionList(relations);
        return permissionList;
    }

    /**
     * 加载一个对象RbacRolePermissionRelation
     *
     * @param id 关系记录id
     * @return RbacRolePermissionRelation
     */
    @Override
    public RbacRolePermissionRelation load(Long id) {
        if (id == null) {
            throw new BaseException(ExceptionEnums.paramIsInvalid(""));
        }

        Map<String, Object> param = new HashMap<>();
        param.put("id", id);
        return rbacRolePermissionRelationDAO.load(param);
    }

    /**
     * 加载一个对象RbacRolePermissionRelation,(将查询关联数据)
     *
     * @param id 关系记录id
     * @return RbacRolePermissionRelation
     */
    @Override
    public RbacRolePermissionRelation get(Long id) {
        if (id == null) {
            throw new BaseException(ExceptionEnums.paramIsInvalid(""));
        }

        Map<String, Object> param = new HashMap<>();
        param.put("id", id);
        return rbacRolePermissionRelationDAO.getDetail(id);
    }

    /**
     * 加载一个对象RbacRolePermissionRelation 通过id
     *
     * @param id 关系记录id
     * @return RbacRolePermissionRelation
     */
    @Override
    public RbacRolePermissionRelation loadById(Long id) {
        if (id == null) {
            throw new BaseException(ExceptionEnums.paramIsInvalid(""));
        }
        return rbacRolePermissionRelationDAO.loadById(id);
    }


    /**
     * 删除对象RbacRolePermissionRelation
     *
     * @param id 关系记录id
     * @return RbacRolePermissionRelation
     */
    @Override
    public void delete(Long id) {
        if (id == null) {
            throw new BaseException(ExceptionEnums.paramIsInvalid(""));
        }
        Map<String, Object> param = new HashMap<>();
        param.put("id", id);
        rbacRolePermissionRelationDAO.delete(param);
    }


    /**
     * 查询RbacRolePermissionRelation分页
     *
     * @param rbacRolePermissionRelation 对象
     * @param offset                     查询开始行
     * @param limit                      查询行数
     * @return List<RbacRolePermissionRelation>
     */
    @Override
    public List<RbacRolePermissionRelation> list(RbacRolePermissionRelation rbacRolePermissionRelation, int offset, int limit) {
        if (offset < 0) {
            offset = 0;
        }

        if (limit < 0) {
            limit = Page.limit;
        }

        Map<String, Object> map = null;
        if (rbacRolePermissionRelation != null) {
            map = JSON.parseObject(JSON.toJSONString(rbacRolePermissionRelation, SerializerFeature.WriteDateUseDateFormat));
        } else {
            map = new HashMap<>();
        }
        return rbacRolePermissionRelationDAO.list(map, new RowBounds(offset, limit));
    }

    @Override
    public int count(RbacRolePermissionRelation rbacRolePermissionRelation) {
        Map<String, Object> map = null;
        if (rbacRolePermissionRelation != null) {
            map = JSON.parseObject(JSON.toJSONString(rbacRolePermissionRelation, SerializerFeature.WriteDateUseDateFormat));
        } else {
            map = new HashMap<>();
        }
        return rbacRolePermissionRelationDAO.count(map);
    }
}