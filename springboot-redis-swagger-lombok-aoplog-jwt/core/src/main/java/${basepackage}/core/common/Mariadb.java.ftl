/*
* ${copyright}
*/
package ${basePackage}.core.common;

import java.io.Serializable;

/**
 * @Author borong
 * @Date 2019/5/31 15:15
 * @Description: Mariadb 类型限制
 */
public class Mariadb implements Serializable {

    private static final long serialVersionUID = 3367400795694430389L;

    /**
     * text 类型最大长度
     */
    public static final int TEXT_MAX_SIZE = 65535;

    /**
     * mediumtext 类型最大长度
     */
    public static final long MEDIUMTEXT_MAX_SIZE = 16777215;

    /**
     * longtext 类型最大长度
     */
    public static final long LONGTEXT_MAX_SIZE = 4294967295L;
}
