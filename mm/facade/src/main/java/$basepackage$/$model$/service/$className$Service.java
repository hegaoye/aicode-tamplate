/*
* $copyright$
 */
package $basepackage$.$model$.service;

import $basepackage$.$model$.entity.$className$;
import $basepackage$.core.base.BaseService;
import $basepackage$.$model$.entity.$className$State;

/**
 * 账户
 *
 * @author mm
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
     $className$ loadBy$strutil.toUpperCase(pkField.field)$($pkField.fieldType$ $pkField.field$);
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
    boolean updateStateBy$strutil.toUpperCase(pkField.field)$($pkField.fieldType$ $pkField.field$, $className$State newState, $className$State... oldStates);
    /***}}***/
}
