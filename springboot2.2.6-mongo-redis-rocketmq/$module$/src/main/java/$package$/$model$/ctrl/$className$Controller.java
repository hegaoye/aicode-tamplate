/*
 * $copyright$
 */
package $package$.$model$.ctrl;

import $package$.core.entity.Page;
import $package$.core.entity.PageVO;
import $package$.core.entity.R;
import com.alibaba.fastjson.JSON;
import $package$.$model$.entity.$className$;
import $package$.$model$.service.$className$Service;
import $package$.$model$.vo.$className$PageVO;
import $package$.$model$.vo.$className$SaveVO;
import $package$.$model$.vo.$className$VO;
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
@Api(value = "$notes$控制器", description = "$notes$控制器")
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
    @ResponseBody
    public $className$SaveVO build(@ApiParam(name = "创建$className$", value = "传入json格式", required = true)
                                   @RequestBody $className$SaveVO $classNameLower$SaveVO) {
        if (null == $classNameLower$SaveVO) {
            return null;
        }
        $className$ new$className$ = new $className$();
        BeanUtils.copyProperties($classNameLower$SaveVO, new$className$);

        $className$ $className$ = $classNameLower$Service.save(new$className$);
        if (null == $className$) {
            return null;
        }

        $classNameLower$SaveVO = new $className$SaveVO();
        BeanUtils.copyProperties($className$, $classNameLower$SaveVO);
        log.debug(JSON.toJSONString($classNameLower$SaveVO));
        return $classNameLower$SaveVO;
    }


    /**
     * 根据条件查询一条详情
     */
    @ApiOperation(value = "根据条件查询一条详情", notes = "根据条件查询一条详情")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "name", value = "名", paramType = "query"),
            @ApiImplicitParam(name = "status", value = "状态", paramType = "query")
    })
    @GetMapping(value = "/load")
    @ResponseBody
    public $className$VO load(@ApiIgnore $className$VO $className$VO) {
        $className$ $className$ = new $className$();
        BeanUtils.copyProperties($className$VO, $className$);
        $className$ = $classNameLower$Service.load($className$);
        BeanUtils.copyProperties($className$, $className$VO);
        return $className$VO;
    }

    /**
     * 查询$notes$信息集合
     *
     * @return 分页对象
     */
    @ApiOperation(value = "查询$notes$信息集合", notes = "查询$notes$信息集合")
    @ApiImplicitParams({
        @ApiImplicitParam(name = "curPage", value = "当前页", required = true, dataType = "int", paramType = "query"),
        @ApiImplicitParam(name = "pageSize", value = "分页大小", required = true, dataType = "int", paramType = "query"),
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
    public PageVO<$className$PageVO> list(@ApiIgnore $className$PageVO $classNameLower$VO, Integer curPage, Integer pageSize) {
        Page<$className$> page = new Page(pageSize, curPage);

        $className$ $classNameLower$ = new $className$();
        BeanUtils.copyProperties($classNameLower$VO, $classNameLower$);
        PageVO<$className$PageVO> $classNameLower$PageVO = new PageVO<>();
        Long total = $classNameLower$Service.count(queryWrapper);
        PageVO<$className$VO> $classNameLower$VOPageVO = new PageVO<>();
        if (total > 0) {
            List<$className$> $classNameLower$List = $classNameLower$Service.list(queryWrapper, page.genRowStart(), page.getPageSize());
            $classNameLower$VOPageVO.setTotalRow(total.intValue());
            $classNameLower$VOPageVO.setRecords(JSON.parseArray(JSON.toJSONString($classNameLower$List),$className$VO.class));
            log.debug(JSON.toJSONString(page));
        }
        return $classNameLower$VOPageVO;
    }


    /**
     * 修改 $notes$
     *
     * @return R
     */
    @ApiOperation(value = "修改$className$", notes = "修改$className$")
    @PutMapping("/modify")
    @ResponseBody
    public $className$VO modify(@ApiParam(name = "修改$className$", value = "传入json格式", required = true)
                                @RequestBody $className$VO $classNameLower$VO) {
        $className$ new$className$ = new $className$();
        BeanUtils.copyProperties($classNameLower$VO, new$className$);
        new$className$ = $classNameLower$Service.modify(new$className$);
        BeanUtils.copyProperties(new$className$, $classNameLower$VO);
        return $classNameLower$VO;
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
    @ResponseBody
    public R delete(@ApiIgnore $className$VO $classNameLower$VO) {
        $className$ new$className$ = new $className$();
        BeanUtils.copyProperties($classNameLower$VO, new$className$);
        $classNameLower$Service.delete(new$className$.getId());
        return R.success("删除$notes$成功");
    }

}
