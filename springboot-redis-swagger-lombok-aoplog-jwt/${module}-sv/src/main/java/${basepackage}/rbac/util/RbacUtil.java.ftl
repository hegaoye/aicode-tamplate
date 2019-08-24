/*
 * ${copyright}
 */
package ${basePackage}.rbac.util;

${basePackage}.core.enums.AdminTypeEnum;
${basePackage}.core.exceptions.BaseException;
${basePackage}.rbac.entity.RbacAdmin;
import lombok.extern.slf4j.Slf4j;

/**
 * Copyright 2019 @http://www.rzhkj.com
 *
 * @Author borong
 * @Date 2019/8/23 16:34
 * @Description: 权限系统工具类
 */
@Slf4j
public class RbacUtil {

    //单例模式
    private static RbacUtil instance;

    public static RbacUtil getInstance() {
        if (instance == null) {
            instance = new RbacUtil();
        }
        return instance;
    }

    /**
     * 检查 如果修改对象是超级管理员，仅允许超管自己修改
     * 检查 被修改者数据 仅限超管 与 创建者修改
     *
     * @param editAdmin   被修改者的账号
     * @param editorAdmin 修改人的账号
     */
    public static void checkAdminPermission(RbacAdmin editAdmin, RbacAdmin editorAdmin) {
        // 修改对象为超级管理员
        if (AdminTypeEnum.SUPER.equals(AdminTypeEnum.getEnum(editAdmin.getType()))
                // 超管之外的其它人没有权限
                && !AdminTypeEnum.SUPER.equals(AdminTypeEnum.getEnum(editorAdmin.getType()))) {
            throw new BaseException(BaseException.ExceptionEnums.no_permission);
        }
        // 当修改人不是超级管理员
        if (!AdminTypeEnum.SUPER.equals(AdminTypeEnum.getEnum(editorAdmin.getType()))
                // 修改人不是被修改者的创建者时，不允许修改
                && !editAdmin.getCreatorCode().equals(editorAdmin.getCode())) {
            throw new BaseException(BaseException.ExceptionEnums.no_permission);
        }
    }

    /**
     * 禁止自己修改自己
     *
     * @param code
     * @param editorAdmin
     */
    public static void disableEditMyself(String code, RbacAdmin editorAdmin) {
        // 不允许自己变更自己的状态
        if (code.equalsIgnoreCase(editorAdmin.getCode())) {
            throw new BaseException(BaseException.ExceptionEnums.no_permission);
        }
    }
}
