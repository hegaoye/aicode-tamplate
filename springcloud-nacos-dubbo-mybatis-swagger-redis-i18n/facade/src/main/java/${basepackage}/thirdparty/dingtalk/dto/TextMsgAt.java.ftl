/*
 * ${copyright}
 */
package ${basePackage}.thirdparty.dingtalk.dto;

import lombok.Data;

import java.io.Serializable;
import java.util.List;

/**
 * @author borong
 */
@Data
public class TextMsgAt implements Serializable {
    private static final long serialVersionUID = -5148651725417052219L;
    //被@人的手机号
    private List<String> atMobiles;
    //@所有人时:true,否则为:false
    private String isAtAll;

    public TextMsgAt(List<String> atMobiles, String isAtAll) {
        this.atMobiles = atMobiles;
        this.isAtAll = isAtAll;
    }
}
