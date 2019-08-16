/*
 * ${copyright}
 */
package ${basePackage}.base;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiImplicitParams;
import io.swagger.annotations.ApiOperation;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;
import java.util.Map;

/**
 */
@Controller
@RequestMapping("/resources")
@Api(tags = "EnumCtrl", description = "枚举资源接口")
public class EnumCtrl {
    private final static Logger logger = LoggerFactory.getLogger(EnumCtrl.class);

    /**
     * 枚举汇总
     *
     * @return
     */
    @ApiOperation(value = "枚举汇总", notes = "系统通用枚举 汇总查阅")
    @GetMapping("/enum/codes")
    @ResponseBody
    public List<Map<String, String>> getEnumCodes() {
        List<Map<String, String>> list = EnumFactory.Enums.getEnumsDescs();
        return list;
    }

    /**
     * 通用枚举获取接口
     * 1.检查缓存，不存在就缓存
     * 2.缓存中获取
     *
     * @param code 枚举编码
     * @return
     */
    @ApiOperation(value = "通用枚举获取接口", notes = "系统通用枚举自动获取")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "code", value = "枚举编码", required = true, paramType = "path")
    })
    @GetMapping("/enum/{code}")
    @ResponseBody
    public Map<String, String> commonEnum(@PathVariable Integer code) {
        Map<String, String> map = null;
        try {
            map = EnumFactory.Enums.genMap(code);
            return map;
        } catch (Exception e) {
            logger.info(e.getMessage());
        }
        return map;
    }

}
