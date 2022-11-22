/*
 * $copyright$
 */
package $package$.$model$.message;

import com.alibaba.fastjson2.JSONObject;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

/**
 * $model$ 消息体针对 测试业务
 */
@Data
public class $className$Message extends JSONObject implements java.io.Serializable {

    /***
     for(field in fields){
     ***/
    /**
     * $field.notes$
     */
    @ApiModelProperty(value = "$field.notes$")
    private $field.fieldType$ $field.field$;
    /***}***/

}
