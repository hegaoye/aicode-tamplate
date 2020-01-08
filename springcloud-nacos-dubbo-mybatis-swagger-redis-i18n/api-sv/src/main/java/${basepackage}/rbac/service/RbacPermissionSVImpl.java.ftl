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
import ${basePackage}.core.exceptions.BaseException;
import ${basePackage}.rbac.dao.RbacPermissionDAO;
import ${basePackage}.rbac.entity.RbacPermission;
import ${basePackage}.rbac.entity.RbacPermissionMenu;
import ${basePackage}.rbac.vo.TreeMenuNodeVO;
import lombok.extern.slf4j.Slf4j;
import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.*;

import static ${basePackage}.core.exceptions.BaseException.ExceptionEnums;

@Service("rbacPermissionSV")
@Slf4j
public class RbacPermissionSVImpl extends BaseSVImpl<RbacPermission, Long> implements RbacPermissionSV {

    @Autowired
    private RbacPermissionDAO rbacPermissionDAO;

    @Autowired
    private RbacPermissionMenuSV menuSV;

    @Resource
    private UidGenerator uidGenerator;

    @Override
    protected BaseDAO getBaseDAO() {
        return rbacPermissionDAO;
    }

    /**
     * 添加菜单权限与资源
     *
     * @param menuName    必填，菜单名
     * @param menuHref    必填，菜单链接
     * @param idPre       选填，上级菜单id
     * @param menuIcon    选填，菜单图标
     * @param description 选填，描述
     * @param sort        选填，排序；默认 1
     * @return RbacPermissionMenu
     */
    @Override
    public RbacPermission insertMenu(String menuName, String menuHref, Long idPre, String menuIcon, String description, Integer sort) {
        // 添加基础权限-菜单
        RbacPermissionMenu menu = menuSV.insertMenu(menuName, menuHref, idPre, menuIcon, description, sort);

        if (null == menu) {
            throw new BaseException(ExceptionEnums.addFailed("菜单权限"));
        }

        // 构造实例化 添加菜单到权限资源
        RbacPermission permission = new RbacPermission(menu.getId(), menu.getMenuName(), PermissionTypeEnum.menu, EnableStateEnum.getEnum(menu.getState()), menu.getDescription(), menu.getSort(), menu.getCreateTime());
        rbacPermissionDAO.insert(permission);

        permission.setRbacPermissionMenu(menu);

        return permission;
    }

    /**
     * 根据权限类型查询所有权限
     *
     * @param permissionTypeEnum 权限类型 [枚举编号：1008](/resources/enum/1008)
     * @return
     */
    @Override
    public List<RbacPermission> queryPermission(PermissionTypeEnum permissionTypeEnum) {
        // 默认仅查询菜单权限资源
        Map<String, Object> params = new HashMap<>();
        if (null != permissionTypeEnum) {
            params.put("type", permissionTypeEnum.name());
        }
        List<RbacPermission> rbacPermissions = rbacPermissionDAO.list(params);

        return rbacPermissions;
    }

    /**
     * 查询权限菜单集合
     *
     * @return
     */
    @Override
    public List<RbacPermissionMenu> queryPermissionMenu() {
        List<RbacPermission> permissionList = queryPermission(PermissionTypeEnum.menu);
        List<RbacPermissionMenu> menuList = new ArrayList<>();
        if (null == permissionList || permissionList.size() == 0) {
            return null;
        }

        permissionList.forEach(permission -> {
            menuList.add(permission.getRbacPermissionMenu());
        });

        return menuList;
    }

    /**
     * 根据权限类型 查询所有权限，返回树结构
     *
     * @param permissionTypeEnum 权限类型 [枚举编号：1008](/resources/enum/1008)
     * @return
     */
    @Override
    public List<TreeMenuNodeVO> queryPermissionTree(PermissionTypeEnum permissionTypeEnum) {
        // 默认仅查询菜单权限资源
        Map<String, Object> params = new HashMap<>();
        params.put("type", PermissionTypeEnum.menu.name());
        List<RbacPermission> rbacPermissions = rbacPermissionDAO.list(params);

        return TreeMenuNodeVO.permissionListToTree(rbacPermissions);
    }

    /**
     * 保存account对象
     *
     * @param entity 实体
     * @throws BaseException
     */
    @Override
    public void save(RbacPermission entity) throws BaseException {
        entity.setCreateTime(new Date());
        entity.setUpdateTime(new Date());
        super.save(entity);
    }

    /**
     * 加载一个对象RbacPermission
     *
     * @param id 权限id
     * @return RbacPermission
     */
    @Override
    public RbacPermission load(Long id) {
        if (id == null) {
            throw new BaseException(ExceptionEnums.paramIsInvalid(""));
        }

        Map<String, Object> param = new HashMap<>();
        param.put("id", id);
        return rbacPermissionDAO.load(param);
    }

    /**
     * 加载一个对象RbacPermission,(将查询关联数据)
     *
     * @param id 权限id
     * @return RbacPermission
     */
    @Override
    public RbacPermission get(Long id) {
        if (id == null) {
            throw new BaseException(ExceptionEnums.paramIsInvalid(""));
        }

        Map<String, Object> param = new HashMap<>();
        param.put("id", id);
        return rbacPermissionDAO.getDetail(id);
    }

    /**
     * 加载一个对象RbacPermission 通过id
     *
     * @param id 权限id
     * @return RbacPermission
     */
    @Override
    public RbacPermission loadById(Long id) {
        if (id == null) {
            throw new BaseException(ExceptionEnums.paramIsInvalid(""));
        }
        return rbacPermissionDAO.loadById(id);
    }


    /**
     * 删除对象RbacPermission
     *
     * @param id 权限id
     * @return RbacPermission
     */
    @Override
    public void delete(Long id) {
        if (id == null) {
            throw new BaseException(ExceptionEnums.paramIsInvalid(""));
        }
        Map<String, Object> param = new HashMap<>();
        param.put("id", id);
        rbacPermissionDAO.delete(param);
    }


    /**
     * 查询RbacPermission分页
     *
     * @param rbacPermission 对象
     * @param offset         查询开始行
     * @param limit          查询行数
     * @return List<RbacPermission>
     */
    @Override
    public List<RbacPermission> list(RbacPermission rbacPermission, int offset, int limit) {
        if (offset < 0) {
            offset = 0;
        }

        if (limit < 0) {
            limit = Page.limit;
        }

        Map<String, Object> map = null;
        if (rbacPermission != null) {
            map = JSON.parseObject(JSON.toJSONString(rbacPermission, SerializerFeature.WriteDateUseDateFormat));
        } else {
            map = new HashMap<>();
        }
        return rbacPermissionDAO.list(map, new RowBounds(offset, limit));
    }

    @Override
    public int count(RbacPermission rbacPermission) {
        Map<String, Object> map = null;
        if (rbacPermission != null) {
            map = JSON.parseObject(JSON.toJSONString(rbacPermission, SerializerFeature.WriteDateUseDateFormat));
        } else {
            map = new HashMap<>();
        }
        return rbacPermissionDAO.count(map);
    }
}