/*
 * $copyright$
 */
package $package$.$model$.message;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

/**
 * $model$ 消息体针对 测试业务
 */
@Data
public class $className$Message  implements java.io.Serializable {

    /***
     for(field in fields){
     ***/
    @Schema(description = "$field.notes$")
    private $field.fieldType$ $field.field$;
    /***}***/

}
