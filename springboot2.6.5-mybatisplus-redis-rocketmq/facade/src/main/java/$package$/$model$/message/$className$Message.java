/*
 * $copyright$
 */
package $package$.$model$.message;

import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

/**
 * $model$ 消息体针对 测试业务
 */
@Data
public class $className$Message  implements java.io.Serializable {

    /***
     for(field in fields){
     ***/
    @ApiModelProperty(value = "$field.notes$")
    private $field.fieldType$ $field.field$;
    /***}***/

}
