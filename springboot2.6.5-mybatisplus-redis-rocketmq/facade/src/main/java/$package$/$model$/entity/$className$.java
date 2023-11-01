/*
 * $copyright$
 */
package $package$.$model$.entity;

import com.baomidou.mybatisplus.annotation.FieldFill;
import com.baomidou.mybatisplus.annotation.TableField;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.*;
import lombok.experimental.Accessors;

/**
 * $notes$ 的实体类
 *
 * @author $author$
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
@EqualsAndHashCode(callSuper = false)
@Accessors(chain = true)
public class $className$ implements java.io.Serializable {
    /***
     for(field in fields){
     ***/
    @ApiModelProperty(value = "数据库字段:$field.column$ $field.notes$")
    private $field.fieldType$ $field.field$;
    /***}***/

}
