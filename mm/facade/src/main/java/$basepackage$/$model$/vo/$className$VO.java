/**
* $copyright$
 */
package $basepackage$.$model$.vo;

import lombok.Data;

/**
 * $notes$ VO
 *
 * @author $author$
 */
@Data
public class $className$VO implements java.io.Serializable {

    /***
     for(field in fields){
     ***/
    /**
     * 数据库字段:${field.column}  属性显示:${field.notes}
     */
    private ${field.fieldType} ${field.field};
    /***}***/

}
