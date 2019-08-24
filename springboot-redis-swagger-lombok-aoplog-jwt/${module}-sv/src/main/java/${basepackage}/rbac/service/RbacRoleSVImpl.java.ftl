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
${basePackage}.core.enums.CheckboxEnum;
${basePackage}.core.enums.EnableStateEnum;
${basePackage}.core.enums.PermissionTypeEnum;
${basePackage}.core.enums.YNEnum;
${basePackage}.core.exceptions.BaseException;
${basePackage}.rbac.common.ConstantsRbac;
${basePackage}.rbac.dao.RbacAdminRoleRelationDAO;
${basePackage}.rbac.dao.RbacRoleDAO;
${basePackage}.rbac.dao.RbacRolePermissionRelationDAO;
${basePackage}.rbac.entity.RbacPermission;
${basePackage}.rbac.entity.RbacRole;
${basePackage}.rbac.vo.TreeMenuNodeVO;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static com.rzhkj.nt.core.exceptions.BaseException.ExceptionEnums;

@Service("rbacRoleSV")
@Slf4j
public class RbacRoleSVImpl extends BaseSVImpl<RbacRole, Long> implements RbacRoleSV {

    @Autowired
    private RbacRoleDAO rbacRoleDAO;

    @Autowired
    private RbacRolePermissionRelationDAO rolePermissionRelationDAO;

    @Autowired
    private RbacAdminRoleRelationDAO adminRoleRelationDAO;

    @Autowired
    private RbacRolePermissionRelationSV rolePermissionRelationSV;

    @Autowired
    private RbacPermissionSV permissionSV;

    @Resource
    private UidGenerator uidGenerator;

    @Override
    protected BaseDAO getBaseDAO() {
        return rbacRoleDAO;
    }

    /**
     * 保存account对象
     *
     * @param entity 实体
     * @throws BaseException
     */
    @Override
    public void save(RbacRole entity) throws BaseException {
        entity.setCreateTime(new Date());
        entity.setUpdateTime(new Date());
        super.save(entity);
    }

    /**
     * 新增角色
     * 检查同级角色是否重名
     *
     * @param roleName    必填，角色名
     * @param idPre       选填，上级角色id；为空时 默认 0
     * @param description 选填，描述
     * @return
     */
    @Override
    public RbacRole addRole(String roleName, Long idPre, String description) {
        if (StringUtils.isBlank(roleName)) {
            throw new BaseException(ExceptionEnums.paramIsEmpty("角色名"));
        }

        //1 检查同级角色名是否有重复
        boolean roleNameIsRepeat = checkRoleIsRepeat(roleName, idPre);
        if (roleNameIsRepeat) {
            throw new BaseException(ExceptionEnums.objIsExist(String.format("角色名：%s", roleName)));
        }

        //2 构造并新增菜单
        RbacRole rbacRole = new RbacRole(idPre, roleName, EnableStateEnum.enable, description, YNEnum.Y, new Date());
        rbacRoleDAO.insert(rbacRole);

        // 如果上级角色id不为空时，更新上级角色为非叶子节点
        if (null != idPre) {
            rbacRoleDAO.updateRoleLeaf(idPre, YNEnum.N);
        }

        return rbacRole;
    }

    /**
     * 检查同级角色名是否有重复
     *
     * @param roleName
     * @param idPre
     * @return
     */
    private boolean checkRoleIsRepeat(String roleName, Long idPre) {
        // 检查上级菜单是否存在
        if (null != idPre) {
            RbacRole role = rbacRoleDAO.loadById(idPre);
            if (null == role) {
                throw new BaseException(ExceptionEnums.objIsNotExist("上级角色"));
            }
        }

        Map<String, Object> params = new HashMap<>();
        params.put("roleName", roleName);
        if (null != idPre) {
            params.put("idPre", idPre);
        }
        List<RbacRole> list = rbacRoleDAO.list(params);
        // 查询不到结果，则说明 没有重名
        if (null == list || list.size() == 0) {
            return false;
        }
        return true;
    }

    /**
     * 查询一个角色与拥有的权限
     * 查询一个角色
     *
     * @param roleId
     * @return
     */
    @Override
    public RbacRole loadRoleAndPermissions(Long roleId) {
        // 查询角色
        RbacRole role = rbacRoleDAO.loadById(roleId);

        // 查询角色拥有的权限
        List<TreeMenuNodeVO> treeMenuNodeVOS = rolePermissionRelationSV.queryRolePermissionsTree(roleId);
        role.setTreeMenuNodeVOS(treeMenuNodeVOS);

        return role;
    }

    /**
     * 查询所有权限，并标记角色拥有的权限
     *
     * @param roleId 角色 id
     * @return
     */
    @Override
    public List<TreeMenuNodeVO> queryAllPermissionAndMine(Long roleId) {
        if (null == roleId) {
            throw new BaseException(ExceptionEnums.paramIsEmpty("角色ID"));
        }

        // 查询所有权限
        List<RbacPermission> permissionList = permissionSV.queryPermission(PermissionTypeEnum.menu);

        if (null == permissionList || permissionList.size() == 0) {
            return null;
        }
        // 查询角色拥有的所有权限
        List<RbacPermission> rolePermissionList = rolePermissionRelationSV.queryRolePermissions(roleId);
        // 垂直遍历所有权限，并标记角色权限的选中状态
        if (null != rolePermissionList && rolePermissionList.size() > 0) {
            // 遍历所有权限集合，如果是角色拥有的权限，直接标记为选中状态
            permissionList.forEach(permission -> {
                // 如果角色拥有当前权限，则暂标记为选中
                if (rolePermissionList.contains(permission)) {
                    if (YNEnum.getEnum(permission.getRbacPermissionMenu().getIsLeaf()).val) {
                        permission.setCheckbox(CheckboxEnum.all);
                    } else {
                        permission.setCheckbox(CheckboxEnum.part);
                    }
                }
            });
        }

        // 转换权限集合为权限树
        List<TreeMenuNodeVO> treeMenuNodeVOList = TreeMenuNodeVO.permissionListToTree(permissionList);

        // 标记树节点的选择状态为全选
        treeMenuNodeVOList = TreeMenuNodeVO.markTreeMenuNodeCheckAll(treeMenuNodeVOList);

        return treeMenuNodeVOList;
    }

    /**
     * 加载一个对象RbacRole
     *
     * @param id 角色id
     * @return RbacRole
     */
    @Override
    public RbacRole load(Long id) {
        if (id == null) {
            throw new BaseException(ExceptionEnums.paramIsInvalid(""));
        }

        Map<String, Object> param = new HashMap<>();
        param.put("id", id);
        return rbacRoleDAO.load(param);
    }

    /**
     * 加载一个对象RbacRole,(将查询关联数据)
     *
     * @param id 角色id
     * @return RbacRole
     */
    @Override
    public RbacRole get(Long id) {
        if (id == null) {
            throw new BaseException(ExceptionEnums.paramIsInvalid(""));
        }

        Map<String, Object> param = new HashMap<>();
        param.put("id", id);
        return rbacRoleDAO.getDetail(id);
    }

    /**
     * 加载一个对象RbacRole 通过id
     *
     * @param id 角色id
     * @return RbacRole
     */
    @Override
    public RbacRole loadById(Long id) {
        if (id == null) {
            throw new BaseException(ExceptionEnums.paramIsInvalid(""));
        }
        return rbacRoleDAO.loadById(id);
    }


    /**
     * 删除角色
     * 1 删除角色
     * 2 删除角色绑定的权限
     * 3 删除角色与授权用户的关系
     *
     * @param id 角色id
     * @return RbacRole
     */
    @Override
    public void delete(Long id) {
        if (id == null) {
            throw new BaseException(ExceptionEnums.paramIsEmpty("角色id"));
        }

        // 检查角色是否存在
        RbacRole rbacRole = rbacRoleDAO.loadById(id);
        if (null == rbacRole) {
            throw new BaseException(ExceptionEnums.objIsNotExist("角色"));
        }

        // 检查是否 叶子节点（不是叶子 即有下级）
        if (YNEnum.N.equals(YNEnum.getEnum(rbacRole.getIsLeaf()))) {
            throw new BaseException(ExceptionEnums.node_has_children_cant_delete);
        }

        rbacRoleDAO.deleteById(id);

        // 删除角色后，删除角色绑定的所有权限
        rolePermissionRelationDAO.deleteByRoleId(id);

        // 删除角色与授权用户的关系
        adminRoleRelationDAO.deleteByRoleId(id);

        // 变更父级角色的节点状态
        updateParentRoleLeaf(rbacRole.getIdPre());
    }

    /**
     * 变更父级角色的节点状态
     *
     * @param idPre
     */
    private void updateParentRoleLeaf(Long idPre) {
        // 如果角色为根节点，则直接返回
        if (ConstantsRbac.ID_PRE_PRESET - idPre == 0) {
            return;
        }
        Map<String, Object> params = new HashMap<>();
        params.put("idPre", idPre);
        // 查询同级的所有角色
        List<RbacRole> rbacRoles = rbacRoleDAO.list(params);
        // 如果同级角色为空，则修改上级角色为叶子节点
        if (rbacRoles == null || rbacRoles.size() == 0) {
            rbacRoleDAO.updateRoleLeaf(idPre, YNEnum.Y);
        }
    }


    /**
     * 查询RbacRole分页
     *
     * @param rbacRole 对象
     * @param offset   查询开始行
     * @param limit    查询行数
     * @return List<RbacRole>
     */
    @Override
    public List<RbacRole> list(RbacRole rbacRole, int offset, int limit) {
        if (offset < 0) {
            offset = 0;
        }

        if (limit < 0) {
            limit = Page.limit;
        }

        Map<String, Object> map = null;
        if (rbacRole != null) {
            map = JSON.parseObject(JSON.toJSONString(rbacRole, SerializerFeature.WriteDateUseDateFormat));
        } else {
            map = new HashMap<>();
        }
        return rbacRoleDAO.list(map, new RowBounds(offset, limit));
    }

    @Override
    public int count(RbacRole rbacRole) {
        Map<String, Object> map = null;
        if (rbacRole != null) {
            map = JSON.parseObject(JSON.toJSONString(rbacRole, SerializerFeature.WriteDateUseDateFormat));
        } else {
            map = new HashMap<>();
        }
        return rbacRoleDAO.count(map);
    }

    /**
     * 查询所有角色，并标记管理员拥有的角色
     *
     * @param code 管理员编码
     * @return
     */
    @Override
    public List<RbacRole> queryAllRoleAndMarkAdmin(String code) {
        if (StringUtils.isBlank(code)) {
            throw new BaseException(ExceptionEnums.paramIsEmpty("管理员编码"));
        }

        // 查询所有角色(启用的角色)
        Map<String, Object> params = new HashMap<>();
        params.put("state", EnableStateEnum.enable.name());
        List<RbacRole> roleList = rbacRoleDAO.list(params);
        if (null == roleList || roleList.size() == 0) {
            return null;
        }
        // 查询当前管理员拥有的所有角色
        List<Long> adminRoleIdList = adminRoleRelationDAO.listAdminRoleIds(code);
        //垂直遍历所有角色，并标记管理员拥有的角色
        if (null != adminRoleIdList && adminRoleIdList.size() > 0) {
            roleList.forEach(role -> {
                // 如果管理员拥有此角色，则暂标记为选中
                if (adminRoleIdList.contains(role.getId())) {
                    role.setCheckbox(CheckboxEnum.all);
                    /*
                    // 如果支持多级，请开启此注释
                    if (YNEnum.getEnum(role.getIsLeaf()).val) {
                        role.setCheckbox(CheckboxEnum.all);
                    }
                    else {
                        role.setCheckbox(CheckboxEnum.part);
                    }
                    */
                }
            });
        }
        return roleList;
    }
}