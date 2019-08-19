/*
 * ${copyright}
 */
package ${basePackage}.thirdparty.dingtalk.entity;

import ${basePackage}.thirdparty.dingtalk.dto.TextMsgAt;
import ${basePackage}.thirdparty.dingtalk.dto.TextMsgContent;
import lombok.Data;

import java.io.Serializable;

/**
 * @author borong
 */
@Data
public class TextMsg implements Serializable {
    private static final long serialVersionUID = 6692031896349124971L;
    //此消息类型为固定text
    private String msgtype = "text";
    //@内容
    private TextMsgContent text;
    //@对象
    private TextMsgAt at;

    public TextMsg() {
    }

    public TextMsg(TextMsgContent text, TextMsgAt at) {
        this.text = text;
        this.at = at;
    }

    public TextMsg(String msgtype, TextMsgContent text, TextMsgAt at) {
        this.msgtype = msgtype;
        this.text = text;
        this.at = at;
    }
}