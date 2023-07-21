/*
 * $copyright$
 */
package $package$.$model$.ctrl;

import $package$.$model$.entity.$className$;
import $package$.$model$.service.$className$Service;
import $package$.$model$.vo.$className$ModifyVO;
import $package$.$model$.vo.$className$SaveVO;
import $package$.core.exceptions.BaseException;
import $package$.core.exceptions.$className$Exception;
import com.alibaba.fastjson2.JSON;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import $package$.$model$.vo.$className$PageVO;
import $package$.$model$.vo.$className$VO;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.Parameters;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Objects;

/**
 * $notes$
 *
 * @author $author$
 */
@RestController
@RequestMapping("/$classNameLower$")
@Slf4j
@Tag(name = "$notes$控制器", description = "$notes$控制器")
public class $className$Controller {
    @Autowired
    private $className$Service $classNameLower$Service;

    /**
     * 创建 $notes$
     */
    @Operation(summary = "创建 $notes$", description = "创建 $notes$")
    @PostMapping("/build")
    public $className$SaveVO build(@RequestBody $className$SaveVO $classNameLower$SaveVO) {

        /***
         for(field in fields){
         ***/
        if (StringUtils.isBlank($classNameLower$SaveVO.get$field.upper$())) {
            throw new $className$Exception(BaseException.BaseExceptionEnum.Empty_Param);
        }
        /***}***/

        int count = $classNameLower$Service.lambdaQuery()
        /***
         for(field in fields){
         ***/
                .eq($className$::get$field.upper$, $classNameLower$SaveVO.get$field.upper$())
        /***}***/
                .count();
        if (count > 0) {
            throw new $className$Exception(BaseException.BaseExceptionEnum.Exists);
        }

        $className$ new$className$ = new $className$();
        BeanUtils.copyProperties($classNameLower$SaveVO, new$className$);

        $classNameLower$Service.save(new$className$);

        $classNameLower$SaveVO = new $className$SaveVO();
        BeanUtils.copyProperties(new$className$, $classNameLower$SaveVO);
        log.debug("创建 $notes$-{}",$classNameLower$SaveVO);
        return $classNameLower$SaveVO;
    }


    /***
     for(pkField in pkFields){
     if(pkField.field!="id"){
     ***/
    /**
     * 根据条件$pkField.field$查询$notes$一个详情信息
     *
     * @param $pkField.field$ $pkField.notes$
     * @return $className$VO
     */
    @Operation(summary = "根据条件$pkField.field$查询$notes$一个详情信息", description = "根据条件$pkField.field$查询$notes$一个详情信息")
    @GetMapping("/load/$pkField.field$/{$pkField.field$}")
    public $className$VO loadBy$pkField.upper$(@PathVariable $pkField.fieldType$ $pkField.field$) {
        $className$ $classNameLower$ = $classNameLower$Service.lambdaQuery()
                .eq($className$::get$pkField.upper$, $pkField.field$)
                .one();
        $className$VO $classNameLower$VO = new $className$VO();
        BeanUtils.copyProperties($classNameLower$, $classNameLower$VO);

        log.debug("根据条件$pkField.field$查询$notes$一个详情信息-{}", $classNameLower$VO);
        return $classNameLower$VO;
    }
    /***}}***/


    /**
     * 查询$notes$信息集合
     *
     * @return 分页对象
     */
    @Operation(summary = "查询$notes$信息集合", description = "查询$notes$信息集合")
    @Parameters( value = {
            @Parameter(name = "curPage", description = "当前页"),
            @Parameter(name = "pageSize", description = "分页大小"),
            /***
             for(field in fields){
             if(field.checkDate){
             ***/
            @Parameter(name = "$field.field$Begin", description = "$field.notes$"),
            @Parameter(name = "$field.field$End", description = "$field.notes$")/***if(!fieldLP.last){***/,/***}***/
            /***}}***/
    })
    @GetMapping(value = "/list")
    public IPage<$className$PageVO> list(@Parameter(hidden = true) $className$PageVO $classNameLower$VO, Integer curPage, Integer pageSize) {
        IPage<$className$> page = new Page<>(curPage, pageSize);
        QueryWrapper<$className$> queryWrapper = new QueryWrapper<>();
        /***
         for(field in fields){
         if(field.checkDate){
         ***/
        if (null != $classNameLower$VO.get$field.upper$Begin()) {
            queryWrapper.lambda().gt($className$::get$field.upper$, $classNameLower$VO.get$field.upper$Begin());
        }
        if (null != $classNameLower$VO.get$field.upper$End()) {
            queryWrapper.lambda().lt($className$::get$field.upper$, $classNameLower$VO.get$field.upper$End());
        }
        /***
         }
         if(field.checkState){
         ***/
        if (StringUtils.isNotBlank($classNameLower$VO.get$field.upper$())) {
            queryWrapper.lambda().eq($className$::get$field.upper$, $classNameLower$VO.get$field.upper$());
        }
        /***}}***/

        int total = $classNameLower$Service.count(queryWrapper);
        if (total > 0) {
            queryWrapper.lambda().orderByDesc($className$::getId);

            IPage<$className$> $classNameLower$Page = $classNameLower$Service.page(page, queryWrapper);
            List<$className$PageVO> $classNameLower$PageVOList = JSON.parseArray(JSON.toJSONString($classNameLower$Page.getRecords()), $className$PageVO.class);

            IPage<$className$PageVO> iPage = new Page<>();
            iPage.setPages($classNameLower$Page.getPages());
            iPage.setCurrent(curPage);
            iPage.setSize(pageSize);
            iPage.setTotal($classNameLower$Page.getTotal());
            iPage.setRecords($classNameLower$PageVOList);
            log.debug("查询$notes$信息集合-{}",iPage);
            return iPage;
        }

        return new Page<>();
    }



    /**
     * 修改 $notes$
     *
     * @return R
     */
    @Operation(summary = "修改 $notes$", description = "修改 $notes$")
    @PutMapping("/modify")
    public boolean modify(@RequestBody $className$ModifyVO $classNameLower$ModifyVO) {
        if (Objects.isNull($classNameLower$ModifyVO.getId())) {
            throw new $className$Exception(BaseException.BaseExceptionEnum.Ilegal_Param);
        }

        $className$ new$className$ = new $className$();
        BeanUtils.copyProperties($classNameLower$ModifyVO, new$className$);

        boolean isUpdated = $classNameLower$Service.update(new$className$, new LambdaQueryWrapper<$className$>()
                .eq($className$::getId, $classNameLower$ModifyVO.getId()));

        return isUpdated;
    }


    /**
     * 删除 $notes$
     *
     * @return R
     */
    @Operation(summary = "删除 $notes$", description = "删除 $notes$")
    @Parameters( value = {
            /***
             for(pkField in pkFields){
             ***/
            @Parameter(name = "$pkField.field$", description = "$pkField.notes$")/***if(!pkFieldLP.last){***/,/***}***/
            /***}***/
    })
    @DeleteMapping("/delete")
    public boolean delete($className$VO $classNameLower$VO) {
        if (Objects.isNull($classNameLower$VO.getId())) {
            throw new $className$Exception(BaseException.BaseExceptionEnum.Ilegal_Param);
        }

        $className$ new$className$ = new $className$();
        BeanUtils.copyProperties($classNameLower$VO, new$className$);
        $classNameLower$Service.lambdaUpdate()
                .eq($className$::getId, $classNameLower$VO.getId())
                .remove();

        return true;
    }

}
