/**
 * $copyright$
 */
package $package$.$model$.vo;


import io.swagger.v3.oas.annotations.media.Schema;
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
    @Schema(description = "数据库字段:$field.column$ $field.notes$")
    private $field.fieldType$ $field.field$;
    /***}***/
}
