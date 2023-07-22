/*
 * $copyright$
 */
package $package$.$model$.vo;

import $package$.core.BaseVO;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * $notes$ 分页 对象 VO
 *
 * @author $author$
 */
@Data
@EqualsAndHashCode(callSuper = false)
public class $className$PageVO extends BaseVO implements java.io.Serializable {
    /***
     for(field in fields){
     ***/
    /**
     * 数据库字段:$field.column$  属性显示:$field.notes$
     */
    @Schema(description = "$field.notes$")
    private $field.fieldType$ $field.field$;
    /***}***/
}
