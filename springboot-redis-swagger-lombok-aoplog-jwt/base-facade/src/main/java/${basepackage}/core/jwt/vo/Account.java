package ${basePackage}.core.jwt.vo;

import ${basePackage}.core.enums.RoleTypeEnum;
import lombok.Data;

import java.io.Serializable;

/**
 * Created by borong on 2019/4/30 11:39
 * @author borong
 */
@Data
public class Account <T> implements Serializable {

    private static final long serialVersionUID = -6008319703274201894L;

    //账号id
    private Long id;
    //账号
    private String account;
    //账号对应编码
    private String code;
    //角色类型
    private RoleTypeEnum roleTypeEnum;
    // token
    private String token;

    //扩展对象
    private T object;

    public Account() {
    }

    public Account(Long id, String account, String code, RoleTypeEnum roleTypeEnum) {
        this.id = id;
        this.account = account;
        this.code = code;
        this.roleTypeEnum = roleTypeEnum;
    }

    public Account(String account, String code, RoleTypeEnum roleTypeEnum) {
        this.account = account;
        this.code = code;
        this.roleTypeEnum = roleTypeEnum;
    }

    public Account(String account, String code, RoleTypeEnum roleTypeEnum, T object) {
        this.account = account;
        this.code = code;
        this.roleTypeEnum = roleTypeEnum;
        this.object = object;
    }

    public Account(Long id, String account, String code, RoleTypeEnum roleTypeEnum, T object) {
        this.id = id;
        this.account = account;
        this.code = code;
        this.roleTypeEnum = roleTypeEnum;
        this.object = object;
    }
}
