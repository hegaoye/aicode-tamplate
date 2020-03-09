/*
 * $copyright$
 */
package $basepackage$.$model$.service;

import $basepackage$.$model$.dao.$className$DAO;
import $basepackage$.$model$.entity.$className$;
import $basepackage$.$model$.entity.$className$State;
import $basepackage$.core.base.BaseDAO;
import $basepackage$.core.base.BaseServiceImpl;
import $basepackage$.core.exceptions.$className$Exception;
import $basepackage$.core.exceptions.BaseException;
import com.baidu.fsg.uid.UidGenerator;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;

/**
 * $notes$
 *
 * @author $author$
 */
@Slf4j
@Service
public class $className$ServiceImpl extends BaseServiceImpl<$className$> implements $className$Service {

    @Autowired
    private $className$DAO $classNameLower$DAO;

    @Autowired
    private UidGenerator uidGenerator;

    @Override
    public BaseDAO getBaseDAO() {
        return $classNameLower$DAO;
    }

    /**
     * 保存
     *
     * @param $classNameLower$ 对象
     * @return $className$
     */
    @Transactional(rollbackFor = BaseException.class)
    @Override
    public $className$ save($className$ $classNameLower$) {
//        $classNameLower$.setCode(String.valueOf(uidGenerator.getUID()));
        /***
        for(field in fields){
            if(field.checkDate){
        ***/
        $classNameLower$.set$strutil.toUpperCase(field.field)$(new Date());
        /***}}***/
        return super.save($classNameLower$);
    }

    /**
     * 加载一个对象$className$ 通过id
     *
     * @param id
     * @return $className$
     */
    @Override
    public $className$ loadById(Long id) {
        return $classNameLower$DAO.selectById(id);
    }

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
    @Override
    public $className$ loadBy$strutil.toUpperCase(pkField.field)$($pkField.fieldType$ $pkField.field$) {
        $className$ $classNameLower$ = $classNameLower$DAO.selectBy$strutil.toUpperCase(pkField.field)$($pkField.field$);
        if (null == $classNameLower$) {
            throw new $className$Exception(BaseException.BaseExceptionEnum.Result_Not_Exist);
        }
        return $classNameLower$;
    }
    /***}}***/



    /**
     * 根据 id 更新 状态
     *
     * @param id        数据id
     * @param newState  新状态
     * @param oldStates 旧状态集合
     */
    @Transactional(rollbackFor = BaseException.class)
    @Override
    public boolean updateStateById(Long id, $className$State newState, $className$State... oldStates) {
        $className$ $classNameLower$ = $classNameLower$DAO.selectById(id);
        if (null == $classNameLower$) {
            throw new $className$Exception(BaseException.BaseExceptionEnum.Result_Not_Exist);
        }

        return $classNameLower$DAO.updateStateById(id, newState, oldStates) > 0 ? true : false;
    }

    /***
      for(pkField in pkFields){
        if(pkField.field!="id"){
    ***/
    /**
     * 根据主键oldStates 共同更新 $className$ 的状态到newState状态
     *
     * @param code      账户编码
     * @param newState  新状态
     * @param oldStates 旧状态集合
     */
    @Transactional(rollbackFor = BaseException.class)
    @Override
    public boolean updateStateBy$strutil.toUpperCase(pkField.field)$($pkField.fieldType$ $pkField.field$, $className$State newState, $className$State... oldStates) {
        $className$ $classNameLower$ = $classNameLower$DAO.selectBy$strutil.toUpperCase(pkField.field)$($pkField.field$);
        if (null == $classNameLower$) {
            throw new $className$Exception(BaseException.BaseExceptionEnum.Result_Not_Exist);
        }

        int updateCount = $classNameLower$DAO.updateStateBy$strutil.toUpperCase(pkField.field)$($pkField.field$, newState, oldStates);
        return updateCount > 0 ? true : false;
    }
    /***}}***/
}
