/**
* $copyright$
 */
package $package$.$model$.vo;

import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

/**
 * $notes$ VO
 *
 * @author $author$
 */
@Data
public class $className$VO  implements java.io.Serializable {

    /***
     for(field in fields){
     ***/
    @ApiModelProperty(value = "数据库字段:$field.column$ $field.notes$")
    private $field.fieldType$ $field.field$;
    /***}***/

}
