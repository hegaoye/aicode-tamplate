/*
* $copyright$
 */
package $package$.$model$.service;

import $package$.$model$.entity.$className$;
import $package$.core.base.BaseService;
import $package$.$model$.entity.$className$State;

/**
 * $notes$
 *
 * @author $author$
 */
public interface $className$Service extends BaseService<$className$> {

    /**
     * 加载一个对象$className$ 通过id
     *
     * @param id
     * @return $className$
     */
    $className$ loadById(java.lang.Long id);

    /***
      for(pkField in pkFields){
        if(pkField.field!="id"){
    ***/
    /**
     * 加载一个对象$className$ 通过code
     *
     * @param code 账户编码
     * @return $className$
     */
     $className$ loadBy$pkField.upper$($pkField.fieldType$ $pkField.field$);
    /***}}***/

    /**
     * 根据主键id,oldStates 共同更新 $className$ 的状态到newState状态
     *
     * @param id
     * @param newState  新状态
     * @param oldStates 旧状态集合
     */
    boolean updateStateById(java.lang.Long id, $className$State newState, $className$State... oldStates);

    /***
     for(pkField in pkFields){
        if(pkField.field!="id"){
    ***/
    /**
     * 根据主键code,oldStates 共同更新 $className$ 的状态到newState状态
     *
     * @param code      账户编码
     * @param newState  新状态
     * @param oldStates 旧状态集合
     */
    boolean updateStateBy$pkField.upper$($pkField.fieldType$ $pkField.field$, $className$State newState, $className$State... oldStates);
    /***}}***/
}
