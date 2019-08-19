/*
 * ${copyright}
 */
package ${basePackage}.thirdparty.dingtalk.dto;

import lombok.Data;

import java.io.Serializable;

/**
 * @author borong
 */
@Data
public class TextMsgContent implements Serializable {
    private static final long serialVersionUID = 755477811121247932L;
    //消息内容
    private String content;

    public TextMsgContent(String content) {
        this.content = content;
    }
}
