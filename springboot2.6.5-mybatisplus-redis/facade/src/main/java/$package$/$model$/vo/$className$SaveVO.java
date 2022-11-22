/**
 * $copyright$
 */
package $package$.$model$.vo;

import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

/**
 * 保存 $notes$ VO
 *
 * @author $author$
 */
@Data
public class $className$SaveVO implements java.io.Serializable {

    /***
     for(field in fields){
     ***/
    /**
     * 数据库字段:$field.column$  属性显示:$field.notes$
     */
    @ApiModelProperty(value = "$field.notes$")
    private $field.fieldType$ $field.field$;
    /***}***/

}
