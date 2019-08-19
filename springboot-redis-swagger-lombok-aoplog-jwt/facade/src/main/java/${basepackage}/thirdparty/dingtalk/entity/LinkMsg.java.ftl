/*
 * ${copyright}
 */
package ${basePackage}.thirdparty.dingtalk.entity;

import lombok.Data;

import java.io.Serializable;

/**
 * @author borong
 */
@Data
public class LinkMsg implements Serializable {
    private static final long serialVersionUID = -5832704502711274392L;

    private String msgtype = "link";
}