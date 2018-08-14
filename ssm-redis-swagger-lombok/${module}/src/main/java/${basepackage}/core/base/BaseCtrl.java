package ${basePackage}.core.base;

import com.rzhkj.core.exceptions.BaseException;
import com.rzhkj.core.tools.redis.RedisUtils;
import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.annotation.Resource;

/**
 * 基础ctrl
 * Created by shangze on 2018-8-14.
 */
public class BaseCtrl {
    private final static Logger logger = LoggerFactory.getLogger(BaseCtrl.class);
    @Resource
    protected RedisUtils redisUtils;


    /**
     * 判断参数是否为空（空字符串或者空值）
     *
     * @param paraName  参数中文描述
     * @param paraValue 参数值
     */
    protected void isEmpty(String paraName, Object paraValue) {
        if (paraValue == null || StringUtils.isBlank(paraValue.toString().trim())) {
            throw new BaseException(BaseException.ExceptionMessage.PARAM_IS_EMPTY, paraName);
        }
    }
}
