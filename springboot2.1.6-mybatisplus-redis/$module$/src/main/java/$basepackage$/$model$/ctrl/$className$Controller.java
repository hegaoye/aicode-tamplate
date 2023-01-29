/*
 * $copyright$
 */
package $package$.$model$.ctrl;

import $package$.$model$.entity.$className$;
import $package$.$model$.service.$className$Service;
import $package$.$model$.vo.$className$PageVO;
import $package$.$model$.vo.$className$SaveVO;
import $package$.$model$.vo.$className$VO;
import $package$.core.entity.Page;
import $package$.core.entity.PageVO;
import $package$.core.entity.R;
import com.alibaba.fastjson.JSON;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import io.swagger.annotations.*;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import springfox.documentation.annotations.ApiIgnore;

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
    @ApiOperation(value = "创建 $notes$", notes = "创建 $notes$")
    @PostMapping("/build")
    @ResponseBody
    public $className$SaveVO build(@ApiParam(name = "创建 $notes$", value = "传入json格式", required = true) @RequestBody $className$SaveVO $classNameLower$SaveVO) {
        if (null == $classNameLower$SaveVO) {
            return null;
        }
        $className$ new$className$ = new $className$();
        BeanUtils.copyProperties($classNameLower$SaveVO, new$className$);

        $className$ $classNameLower$ = $classNameLower$Service.save(new$className$);
        if (null == $classNameLower$) {
            return null;
        }

        $classNameLower$SaveVO = new $className$SaveVO();
        BeanUtils.copyProperties($classNameLower$, $classNameLower$SaveVO);
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
    @ApiOperation(value = "查询$className$一个详情信息", notes = "查询$className$一个详情信息")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "$pkField.field$", value = "账户编码", dataType = "java.lang.String", paramType = "path")
    })
    @GetMapping(value = "/load/$pkField.field$/{$pkField.field$}")
    @ResponseBody
    public $className$VO loadBy$pkField.upper$(@PathVariable $pkField.fieldType$ $pkField.field$) {
        if ($pkField.field$ == null) {
            return null;
        }
        $className$ $classNameLower$ = $classNameLower$Service.loadBy$pkField.upper$($pkField.field$);
        if (null == $classNameLower$) {
            return null;
        }
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
    @ApiOperation(value = "查询$notes$信息集合", notes = "查询$notes$信息集合")
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
    @ResponseBody
    public PageVO<$className$VO> list(@ApiIgnore $className$PageVO $classNameLower$VO, Integer curPage, Integer pageSize) {
        QueryWrapper<$className$> queryWrapper = new QueryWrapper<>();
        /***
         for(field in fields){
          if(field.checkDate){
         ***/
        if ($classNameLower$VO.getCreateTimeBegin() != null) {
            queryWrapper.lambda().gt($className$::getCreateTime, $classNameLower$VO.getCreateTimeBegin());
        }
        if ($classNameLower$VO.getCreateTimeEnd() != null) {
            queryWrapper.lambda().lt($className$::getCreateTime, $classNameLower$VO.getCreateTimeEnd());
        }
        /***
         }
         if(field.checkState){
         ***/
        if ($classNameLower$VO.get$field.upper$() != null) {
            queryWrapper.lambda().eq($className$::get$field.upper$, $classNameLower$VO.get$field.upper$());
        }
        /***}}***/

        int total = $classNameLower$Service.count(queryWrapper);
        Page<$className$> page = new Page<>(pageSize, curPage);
        if (total > 0) {
            List<$className$> $classNameLower$List = $classNameLower$Service.list(queryWrapper, page.genRowStart(), page.getPageSize());
            page.setTotalRow(total);
            page.setRecords($classNameLower$List);
            log.debug(JSON.toJSONString(page));
        }
        return JSON.parseObject(JSON.toJSONString(page),PageVO.class);
    }


    /**
     * 统计 $notes$ 信息数量
     *
     * @return 总条数
     */
    @ApiOperation(value = "统计$className$信息数量", notes = "统计$className$信息数量")
    @ApiImplicitParams({
        /***
         for(field in fields){
         ***/
        @ApiImplicitParam(name = "$field.field$", value = "$field.notes$", paramType = "query")/***if(!fieldLP.last){***/,/***}***/
        /***}***/
    })
    @GetMapping(value = "/count")
    @ResponseBody
    public Integer count(@ApiIgnore $className$PageVO $classNameLower$PageVO) {
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
        if ($classNameLower$PageVO.get$field.upper$() != null) {
            queryWrapper.lambda().eq($className$::get$field.upper$, $classNameLower$PageVO.get$field.upper$());
        }
        /***}}***/
        return $classNameLower$Service.count(queryWrapper);
    }

    /**
     * 修改 $notes$
     *
     * @return R
     */
    @ApiOperation(value = "修改 $notes$", notes = "修改 $notes$")
    @PutMapping("/modify")
    @ResponseBody
    public boolean modify(@ApiParam(name = "创建$classNameLower$", value = "传入json格式", required = true) @RequestBody $className$VO $classNameLower$VO) {
        $className$ new$className$ = new $className$();
        BeanUtils.copyProperties($classNameLower$VO, new$className$);
        boolean isUpdated = $classNameLower$Service.modify(new$className$, /***for(pkField in pkFields){***/$className$::get$pkField.upper$/***if(!pkFieldLP.last){***/,/***}}***/);
        return isUpdated;
    }

    /**
     * 删除 $notes$
     *
     * @return R
     */
    @ApiOperation(value = "删除 $notes$", notes = "删除 $notes$")
    @ApiImplicitParams({
        /***
         for(pkField in pkFields){
        ***/
        @ApiImplicitParam(name = "$pkField.field$", value = "$pkField.notes$", paramType = "query")/***if(!pkFieldLP.last){***/,/***}***/
        /***}***/
    })
    @DeleteMapping("/delete")
    @ResponseBody
    public boolean delete(@ApiIgnore $className$VO $classNameLower$VO) {
        $className$ new$className$ = new $className$();
        BeanUtils.copyProperties($classNameLower$VO, new$className$);
        $classNameLower$Service.delete(new$className$, /***for(pkField in pkFields){***/$className$::get$pkField.upper$/***if(!pkFieldLP.last){***/,/***}}***/);
        return R.success("删除$classNameLower$成功");
    }

}
