/*
 * $copyright$
 */
package $package$.$model$.ctrl;

import $package$.$model$.entity.$className$;
import $package$.$model$.service.$className$Service;
import $package$.$model$.vo.$className$PageVO;
import $package$.$model$.vo.$className$SaveVO;
import $package$.$model$.vo.$className$VO;
import $package$.core.exceptions.$className$Exception;
import $package$.core.exceptions.BaseException;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import $package$.core.R;
import com.alibaba.fastjson.JSON;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import io.swagger.annotations.*;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import springfox.documentation.annotations.ApiIgnore;
import java.util.Objects;
import java.util.List;

/**
 * $notes$
 *
 * @author $author$
 */
@RestController
@RequestMapping("/$classNameLower$")
@Slf4j
@Api(value = "$notes$控制器", tags = "$notes$控制器")
public class $className$Controller {
    @Autowired
    private $className$Service $classNameLower$Service;


    /**
     * 创建 $notes$
     *
     * @return R
     */
    @ApiOperation(value = "创建$className$", notes = "创建$className$")
    @PostMapping("/build")
    public $className$SaveVO build(@ApiParam(name = "创建$className$", value = "传入json格式", required = true)
                                   @RequestBody $className$SaveVO $classNameLower$SaveVO) {
        /***
         for(field in fields){
         ***/
        if (StringUtils.isBlank($classNameLower$SaveVO.get$field.upper$())) {
            throw new $className$Exception(BaseException.BaseExceptionEnum.Empty_Param);
        }
        /***}***/

        int count = $classNameLower$Service.count(new LambdaQueryWrapper<$className$>()
                /***
                 for(field in fields){
                 ***/
                .eq($className$::get$field.upper$, $classNameLower$SaveVO.get$field.upper$())
        /***}***/);
        if (count > 0) {
            throw new $className$Exception(BaseException.BaseExceptionEnum.Exists);
        }

        $className$ new$className$ = new $className$();
        BeanUtils.copyProperties($classNameLower$SaveVO, new$className$);

        $classNameLower$Service.save(new$className$);

        $classNameLower$SaveVO = new $className$SaveVO();
        BeanUtils.copyProperties(new$className$, $classNameLower$SaveVO);
        log.debug(JSON.toJSONString($classNameLower$SaveVO));
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
    @ApiOperation(value = "根据条件$pkField.field$查询$notes$一个详情信息", notes = "根据条件$pkField.field$查询$notes$一个详情信息")
    @GetMapping("/load/$pkField.field$/{$pkField.field$}")
    public $className$VO loadBy$pkField.

    upper$(@PathVariable $pkField.fieldType$ $pkField.field$) {
        $className$ $classNameLower$ = $classNameLower$Service.getOne(new LambdaQueryWrapper<$className$>()
                .eq($className$::get$pkField.upper$, $pkField.field$));
        $className$VO $classNameLower$VO = new $className$VO();
        BeanUtils.copyProperties($classNameLower$, $classNameLower$VO);
        log.debug(JSON.toJSONString($classNameLower$VO));
        return $classNameLower$VO;
    }
    /***}}***/

    /**
     * 查询$notes$信息集合
     *
     * @return 分页对象
     */
    @ApiOperation(value = "查询$className$信息集合", notes = "查询$className$信息集合")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "curPage", value = "当前页", required = true, paramType = "query"),
            @ApiImplicitParam(name = "pageSize", value = "分页大小", required = true, paramType = "query"),
            /***
             for(field in fields){
             if(field.checkDate){
             ***/
            @ApiImplicitParam(name = "$field.field$Begin", value = "$field.notes$", paramType = "query"),
            @ApiImplicitParam(name = "$field.field$End", value = "$field.notes$", paramType = "query")/***if(!fieldLP.last){***/,/***}***/
            /***}}***/
    })
    @GetMapping(value = "/list")
    public IPage<$className$PageVO> list(@ApiIgnore $className$PageVO $classNameLower$VO, Integer curPage, Integer pageSize) {
        IPage<$className$> page = new Page<>(curPage, pageSize);
        QueryWrapper<$className$> queryWrapper = new QueryWrapper<>();
        /***
         for(field in fields){
         if(field.checkDate){
         ***/
        if ($classNameLower$VO.get$field.upper$Begin() != null) {
            queryWrapper.lambda().gt($className$::get$field.upper$, $classNameLower$VO.get$field.upper$Begin());
        }
        if ($classNameLower$VO.get$field.upper$End() != null) {
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

            IPage<$className$> $classNameLower$Page = $classNameLower$Service.page(page,queryWrapper);
            List<$className$PageVO> $classNameLower$PageVOList = JSON.parseArray(JSON.toJSONString($classNameLower$Page.getRecords()), $className$PageVO.class);
            IPage<$className$PageVO> iPage = new Page<>();
            iPage.setPages($classNameLower$Page.getPages());
            iPage.setCurrent(curPage);
            iPage.setSize(pageSize);
            iPage.setTotal($classNameLower$Page.getTotal());
            iPage.setRecords($classNameLower$PageVOList);
            log.debug(JSON.toJSONString(iPage));
            return iPage;
        }
        return new Page<>();
    }


    /**
     * 修改 $notes$
     *
     * @return R
     */
    @ApiOperation(value = "修改$className$", notes = "修改$className$")
    @PutMapping("/modify")
    public boolean modify(@ApiParam(name = "修改$className$", value = "传入json格式", required = true)
                          @RequestBody $className$VO $classNameLower$VO) {
        if (Objects.isNull($classNameLower$VO.getId())) {
            throw new $className$Exception(BaseException.BaseExceptionEnum.Ilegal_Param);
        }
        $className$ new$className$ = new $className$();
        BeanUtils.copyProperties($classNameLower$VO, new$className$);
        boolean isUpdated = $classNameLower$Service.update(new$className$, new LambdaQueryWrapper<$className$>()
                .eq($className$::getId, $classNameLower$VO.getId()));
        return isUpdated;
    }


    /**
     * 删除 $notes$
     *
     * @return R
     */
    @ApiOperation(value = "删除$className$", notes = "删除$className$")
    @ApiImplicitParams({
            /***
             for(pkField in pkFields){
             ***/
            @ApiImplicitParam(name = "$pkField.field$", value = "$pkField.notes$", paramType = "query")/***if(!pkFieldLP.last){***/,/***}***/
            /***}***/
    })
    @DeleteMapping("/delete")
    public R delete(@ApiIgnore $className$VO $classNameLower$VO) {
        if (Objects.isNull($classNameLower$VO.getId())) {
            throw new $className$Exception(BaseException.BaseExceptionEnum.Ilegal_Param);
        }
        $className$ new$className$ = new $className$();
        BeanUtils.copyProperties($classNameLower$VO, new$className$);
        $classNameLower$Service.remove(new LambdaQueryWrapper<$className$>()
                .eq($className$::getId, $classNameLower$VO.getId()));
        return R.success("删除成功");
    }

}
