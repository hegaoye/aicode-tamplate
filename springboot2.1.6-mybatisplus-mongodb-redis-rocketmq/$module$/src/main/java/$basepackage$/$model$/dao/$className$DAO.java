package $package$.$model$.dao;

import $package$.$model$.dao.mapper.$className$Mapper;
import $package$.$model$.entity.$className$;
import $package$.$model$.entity.$className$State;
import $package$.core.base.BaseDAO;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.UpdateWrapper;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

/**
 * $notes$
 * $className$ DAO
 * 数据服务层
 *
 * @author $author$
 */
@Repository
public class $className$DAO extends BaseDAO<$className$> {


    /**
     * $className$ mapper
     */
    @Autowired
    private $className$Mapper $classNameLower$Mapper;

    @Override
    protected BaseMapper<$className$> getBaseMapper() {
        return $classNameLower$Mapper;
    }


    /**
     * 根据id 查询 一条 $className$ 信息
     *
     * @param id id
     * @return $className$
     */
    public $className$ selectById(Long id) {
        QueryWrapper<$className$> queryWrapper = new QueryWrapper<>();
        queryWrapper.lambda()
                .eq($className$::getId, id);
        $className$ $classNameLower$ = this.selectOne(queryWrapper);
        return $classNameLower$;
    }

    /***
     for(pkField in pkFields){
     if(pkField.field!="id"){
     ***/
    /**
     * 根据 $pkField.field$ 查询 一条 $className$ 信息
     *
     * @param $pkField.field$ $pkField.notes$
     * @return $className$
     */
    public $className$ selectBy$pkField.upper$($pkField.fieldType$ $pkField.field$) {
        QueryWrapper<$className$> queryWrapper = new QueryWrapper<>();
        queryWrapper.lambda()
                .eq($className$::get$pkField.upper$, $pkField.field$);
        $className$ $classNameLower$ = this.selectOne(queryWrapper);
        return $classNameLower$;
    }
    /***}}***/

    /***
     for(pkField in pkFields){
     if(pkField.field=="id" && checkState){
     ***/
    /**
     * 更新 状态根据主键id
     *
     * @param id        id
     * @param newState  新状态
     * @param oldStates 老状态集合
     * @return 条数
     */
    public int updateStateById(Long id, $className$State newState, $className$State... oldStates) {
        UpdateWrapper<$className$> updateWrapper = new UpdateWrapper<>();
        //条件
        updateWrapper.lambda().eq($className$::getId, id);
        int updateCount = this.updateByPk(updateWrapper, newState, oldStates);
        return updateCount;
    }
    /***}}***/

    /***
     for(pkField in pkFields){
     if(pkField.field!="id" && checkState){
     ***/

    /**
     * 更新 状态根据 主键 code
     *
     * @param $pkField.field$  $pkField.notes$
     * @param newState  新状态
     * @param oldStates 老状态集合
     * @return 条数
     */
    public int updateStateBy$pkField.upper$($pkField.fieldType$ $pkField.field$, $className$State newState, $className$State... oldStates) {
        UpdateWrapper<$className$> updateWrapper = new UpdateWrapper<>();
        updateWrapper.lambda().eq($className$::get$pkField.upper$, $pkField.field$);
        int updateCount = this.updateByPk(updateWrapper, newState, oldStates);
        return updateCount;
    }
    /***}}***/


    /***
     if(checkState){
     ***/
    private int updateByPk(UpdateWrapper<$className$> updateWrapper, $className$State newState, $className$State... oldStates) {
        updateWrapper.lambda().set($className$::getState, newState.name());
        if (oldStates != null && oldStates.length > 0) {
            List<String> stateList = Arrays.asList(oldStates).stream()
                    .map($classNameLower$State -> $classNameLower$State.name())
                    .collect(Collectors.toList());
            updateWrapper.lambda().in($className$::getState, stateList);
        }
        int updateCount = $classNameLower$Mapper.update(null, updateWrapper);
        return updateCount;
    }
    /***}***/

}
