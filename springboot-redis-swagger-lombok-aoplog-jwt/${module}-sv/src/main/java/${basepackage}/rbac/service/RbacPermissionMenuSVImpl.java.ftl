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
import ${basePackage}.core.enums.EnableStateEnum;
import ${basePackage}.core.enums.PermissionTypeEnum;
import ${basePackage}.core.enums.YNEnum;
import ${basePackage}.core.exceptions.BaseException;
import ${basePackage}.rbac.common.ConstantsRbac;
import ${basePackage}.rbac.dao.RbacPermissionDAO;
import ${basePackage}.rbac.dao.RbacPermissionMenuDAO;
import ${basePackage}.rbac.dao.RbacRolePermissionRelationDAO;
import ${basePackage}.rbac.entity.RbacPermission;
import ${basePackage}.rbac.entity.RbacPermissionMenu;
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

import static ${basePackage}.core.exceptions.BaseException.ExceptionEnums;

@Service("rbacPermissionMenuSV")
@Slf4j
public class RbacPermissionMenuSVImpl extends BaseSVImpl<RbacPermissionMenu, Long> implements RbacPermissionMenuSV {

    @Autowired
    private RbacPermissionMenuDAO rbacPermissionMenuDAO;

    @Autowired
    private RbacPermissionDAO permissionDAO;

    @Autowired
    private RbacRolePermissionRelationDAO rolePermissionRelationDAO;

    @Resource
    private UidGenerator uidGenerator;

    @Override
    protected BaseDAO getBaseDAO() {
        return rbacPermissionMenuDAO;
    }

    /**
     * 添加菜单
     * 检查同级菜单名是否重名
     *
     * @param menuName    必填，菜单名
     * @param menuHref    必填，菜单链接
     * @param idPre       选填，上级菜单id
     * @param menuIcon    选填，菜单图标
     * @param description 选填，描述
     * @param sort        选填，排序；
     * @return RbacPermissionMenu
     */
    @Override
    public RbacPermissionMenu insertMenu(String menuName, String menuHref, Long idPre, String menuIcon, String description, Integer sort) {
        if (StringUtils.isBlank(menuName)) {
            throw new BaseException(ExceptionEnums.paramIsEmpty("菜单名"));
        }
        if (StringUtils.isBlank(menuHref)) {
            throw new BaseException(ExceptionEnums.paramIsEmpty("菜单链接"));
        }
        //1 检查同级菜单名是否有重复
        boolean menuNameIsRepeat = checkMenuIsRepeat(menuName, idPre, null);
        if (menuNameIsRepeat) {
            throw new BaseException(ExceptionEnums.objIsExist(String.format("菜单名：%s", menuName)));
        }

        //2 构造并新增菜单
        RbacPermissionMenu menu = new RbacPermissionMenu(menuName, menuHref, idPre, menuIcon,
                EnableStateEnum.enable, description, sort, new Date());
        // 默认叶子节点
        menu.setIsLeaf(YNEnum.Y.name());
        rbacPermissionMenuDAO.insert(menu);

        // 如果上级菜单id不为空时，更新上级菜单为非叶子节点
        if (null != idPre) {
            rbacPermissionMenuDAO.updateMenuLeaf(idPre, YNEnum.N);
        }
        if (log.isDebugEnabled()) {
            log.debug(">>> menu [{}] >>>", JSON.toJSONString(menu));
        }
        return menu;
    }

    /**
     * 修改菜单信息
     *
     * @param menuId          必填，菜单id
     * @param menuName        选填，菜单名
     * @param menuHref        选填，菜单链接
     * @param menuIcon        选填，菜单图标
     * @param description     选填，描述
     * @param sort            选填，排序；
     * @param newParentMenuId 选填，新的上级菜单ID；如果无上级，请填写0；
     * @return
     */
    @Override
    public RbacPermissionMenu updateMenu(Long menuId, String menuName, String menuHref, String menuIcon, String description, Integer sort, Long newParentMenuId) {
        if (null == menuId) {
            throw new BaseException(ExceptionEnums.paramIsEmpty("菜单ID"));
        }

        RbacPermissionMenu rbacPermissionMenu = rbacPermissionMenuDAO.loadById(menuId);
        if (null == rbacPermissionMenu) {
            throw new BaseException(ExceptionEnums.objIsNotExist("菜单"));
        }

        Date now = new Date();

        // 检查菜单名是否重名，并排除自己
        if (StringUtils.isNotEmpty(menuName)) {
            checkMenuIsRepeat(menuName, rbacPermissionMenu.getIdPre(), rbacPermissionMenu.getId());
            rbacPermissionMenu.setMenuName(menuName);

            /**
             * 修改菜单权限资源中权限名称
             */
            permissionDAO.updateMenuPermissionName(menuId, PermissionTypeEnum.menu, now, menuName);
        }

        if (StringUtils.isNotBlank(menuHref)) {
            rbacPermissionMenu.setMenuHref(menuHref);
        }

        if (StringUtils.isNotBlank(menuIcon)) {
            rbacPermissionMenu.setMenuIcon(menuIcon);
        }

        if (StringUtils.isNotBlank(description)) {
            rbacPermissionMenu.setDescription(description);
        }

        if (null != sort) {
            rbacPermissionMenu.setSort(sort);
        }

        rbacPermissionMenu.setUpdateTime(now);
        // 修改基础菜单权限
        rbacPermissionMenuDAO.update(rbacPermissionMenu);

        // 变更菜单的父级与节点状态
        updateMenuParent(rbacPermissionMenu, newParentMenuId);

        return rbacPermissionMenu;
    }

    /**
     * 检查同级别菜单是否重名
     *
     * @param menuName
     * @param idPre
     * @param excludeId 排除菜单ID
     * @return
     */
    private boolean checkMenuIsRepeat(String menuName, Long idPre, Long excludeId) {
        // 检查上级菜单是否存在，仅检查上级id不为0
        if (null != idPre && idPre - ConstantsRbac.ID_PRE_PRESET > 0) {
            RbacPermissionMenu menu = rbacPermissionMenuDAO.loadById(idPre);
            if (null == menu) {
                throw new BaseException(ExceptionEnums.objIsNotExist("上级菜单"));
            }
        }

        Map<String, Object> params = new HashMap<>();
        params.put("menuName", menuName);
        if (null != idPre) {
            params.put("idPre", idPre);
        } else {
            params.put("idPre", ConstantsRbac.ID_PRE_PRESET);
        }
        RbacPermissionMenu rbacPermissionMenu = rbacPermissionMenuDAO.load(params);
        // 查询不到结果，则说明 没有重名；或者有结果
        if (null == rbacPermissionMenu) {
            return false;
        }
        if (rbacPermissionMenu.getId().compareTo(excludeId) == 0) {
            return false;
        }
        return true;
    }

    /**
     * 变更菜单的父级与节点状态
     * 获得当前菜单对象
     *
     * @param menuId          菜单
     * @param newParentMenuId 新父级菜单的id
     */
    @Override
    public void updateMenuParent(Long menuId, Long newParentMenuId) {
        if (null == menuId || null == newParentMenuId) {
            return;
        }
        // 获得当前菜单对象
        RbacPermissionMenu permissionMenu = rbacPermissionMenuDAO.loadById(menuId);
        // 变更菜单的父级与节点状态
        updateMenuParent(permissionMenu, newParentMenuId);
    }

    /**
     * 变更菜单的父级与节点状态
     * <p>
     * 获取新父级菜单对象
     * <p>
     * 变更新父级菜单的节点状态为非叶子节点
     * 变更当前菜单的父级菜单id
     * 检查并变更菜单原父级菜单的节点状态
     *
     * @param permissionMenu  菜单
     * @param newParentMenuId 新父级菜单的id
     */
    @Override
    public void updateMenuParent(RbacPermissionMenu permissionMenu, Long newParentMenuId) {

        if (null == newParentMenuId) {
            return;
        }

        if (null == permissionMenu) {
            throw new BaseException(ExceptionEnums.paramIsEmpty("菜单"));
        }

        // 当前时间
        Date now = new Date();
        // 暂存菜单原有父级ID
        long oldMenuIdPre = permissionMenu.getIdPre();

        // 如果新旧父级相同，则直接返回
        if (oldMenuIdPre - newParentMenuId == 0) {
            return;
        }

        // 如果新的父级菜单id 为非顶级菜单
        if (ConstantsRbac.ID_PRE_PRESET - newParentMenuId != 0) {
            RbacPermissionMenu newParentMenu = rbacPermissionMenuDAO.loadById(newParentMenuId);
            if (null == newParentMenu) {
                throw new BaseException(ExceptionEnums.objIsNotExist(String.format("父级菜单ID:%s", newParentMenuId)));
            }
            // 当父节点为叶子节点时，变更新父级菜单的节点状态为非叶子节点
            if (YNEnum.getEnum(newParentMenu.getIsLeaf()).val) {
                newParentMenu.setIsLeaf(YNEnum.N.name());
                newParentMenu.setUpdateTime(now);
                rbacPermissionMenuDAO.update(newParentMenu);
            }
        }

        // 变更当前菜单的父级菜单id
        permissionMenu.setIdPre(newParentMenuId);
        permissionMenu.setUpdateTime(now);
        rbacPermissionMenuDAO.update(permissionMenu);

        // 检查并变更菜单原父级菜单的节点状态
        updateParentMenuLeaf(oldMenuIdPre);
    }

    /**
     * 根据id删除菜单
     * <p>
     * 检查是否有下级
     * 删除权限资源，与角色对应的权限关系
     *
     * @param menuId 菜单ID
     * @return RbacPermissionMenu
     */
    @Override
    public void delete(Long menuId) {
        if (menuId == null) {
            throw new BaseException(ExceptionEnums.paramIsEmpty("菜单id"));
        }
        // 检查菜单是否存在
        RbacPermissionMenu permissionMenu = rbacPermissionMenuDAO.loadById(menuId);
        if (null == permissionMenu) {
            throw new BaseException(ExceptionEnums.objIsNotExist("菜单"));
        }

        // 检查是否 叶子节点（不是叶子 即有下级）
        if (YNEnum.N.equals(YNEnum.getEnum(permissionMenu.getIsLeaf()))) {
            throw new BaseException(ExceptionEnums.node_has_children_cant_delete);
        }

        // 删除权限资源，与角色对应的权限关系
        Map<String, Object> param = new HashMap<>();
        param.put("menuId", menuId);
        // 查询出当前菜单所属的权限资源
        List<RbacPermission> permissionList = permissionDAO.list(param);
        if (null != permissionList && permissionList.size() > 0) {
            // 获得所有权限资源的权限id
            List<Long> permissionIds = RbacPermission.listFilterIds(permissionList);

            // 根据权限资源id集 删除角色与菜单权限对应关系
            rolePermissionRelationDAO.deleteByPermissionIds(permissionIds);
        }
        param.remove("menuId");

        // 删除菜单id所属的权限资源
        permissionDAO.deleteByMenuId(menuId);

        // 删除指定id的菜单
        rbacPermissionMenuDAO.deleteById(menuId);

        // 变更父级菜单的节点状态
        updateParentMenuLeaf(permissionMenu.getIdPre());
    }

    /**
     * 变更父级菜单的节点状态
     *
     * @param idPre 父级菜单id
     */
    private void updateParentMenuLeaf(Long idPre) {
        // 如果菜单为根节点，则直接返回
        if (ConstantsRbac.ID_PRE_PRESET - idPre == 0) {
            return;
        }
        Map<String, Object> params = new HashMap<>();
        params.put("idPre", idPre);
        // 查询同级的所有菜单
        List<RbacPermissionMenu> rbacPermissionMenus = rbacPermissionMenuDAO.list(params);
        // 如果同级菜单为空，则修改上级菜单为叶子节点
        if (rbacPermissionMenus == null || rbacPermissionMenus.size() == 0) {
            rbacPermissionMenuDAO.updateMenuLeaf(idPre, YNEnum.Y);
        }
    }

    /**
     * 保存account对象
     *
     * @param entity 实体
     * @throws BaseException
     */
    @Override
    public void save(RbacPermissionMenu entity) throws BaseException {
        entity.setCreateTime(new Date());
        entity.setUpdateTime(new Date());
        super.save(entity);
    }

    /**
     * 加载一个对象RbacPermissionMenu
     *
     * @param id 菜单ID
     * @return RbacPermissionMenu
     */
    @Override
    public RbacPermissionMenu load(Long id) {
        if (id == null) {
            throw new BaseException(ExceptionEnums.paramIsInvalid(""));
        }

        Map<String, Object> param = new HashMap<>();
        param.put("id", id);
        return rbacPermissionMenuDAO.load(param);
    }

    /**
     * 加载一个对象RbacPermissionMenu,(将查询关联数据)
     *
     * @param id 菜单ID
     * @return RbacPermissionMenu
     */
    @Override
    public RbacPermissionMenu get(Long id) {
        if (id == null) {
            throw new BaseException(ExceptionEnums.paramIsInvalid(""));
        }

        Map<String, Object> param = new HashMap<>();
        param.put("id", id);
        return rbacPermissionMenuDAO.getDetail(id);
    }

    /**
     * 加载一个对象RbacPermissionMenu 通过id
     *
     * @param id 菜单ID
     * @return RbacPermissionMenu
     */
    @Override
    public RbacPermissionMenu loadById(Long id) {
        if (id == null) {
            throw new BaseException(ExceptionEnums.paramIsInvalid(""));
        }
        return rbacPermissionMenuDAO.loadById(id);
    }

    /**
     * 查询RbacPermissionMenu分页
     *
     * @param rbacPermissionMenu 对象
     * @param offset             查询开始行
     * @param limit              查询行数
     * @return List<RbacPermissionMenu>
     */
    @Override
    public List<RbacPermissionMenu> list(RbacPermissionMenu rbacPermissionMenu, int offset, int limit) {
        if (offset < 0) {
            offset = 0;
        }

        if (limit < 0) {
            limit = Page.limit;
        }

        Map<String, Object> map = null;
        if (rbacPermissionMenu != null) {
            map = JSON.parseObject(JSON.toJSONString(rbacPermissionMenu, SerializerFeature.WriteDateUseDateFormat));
        } else {
            map = new HashMap<>();
        }
        return rbacPermissionMenuDAO.list(map, new RowBounds(offset, limit));
    }

    @Override
    public int count(RbacPermissionMenu rbacPermissionMenu) {
        Map<String, Object> map = null;
        if (rbacPermissionMenu != null) {
            map = JSON.parseObject(JSON.toJSONString(rbacPermissionMenu, SerializerFeature.WriteDateUseDateFormat));
        } else {
            map = new HashMap<>();
        }
        return rbacPermissionMenuDAO.count(map);
    }
}
