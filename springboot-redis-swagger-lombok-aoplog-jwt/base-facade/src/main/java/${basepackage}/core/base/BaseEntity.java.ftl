/*
 * Copyright (c) 2017. 郑州仁中和科技有限公司.保留所有权利.
 *                       http://www.rzhkj.com/
 *      郑州仁中和科技有限公司保留所有代码著作权.如有任何疑问请访问官方网站与我们联系.
 *      代码遵循Apache License2.0开源协议,可放心使用.
 *
 */
package ${basePackage}.core.base;

import java.util.Date;

/**
 * @author ${author}
 */
public class BaseEntity implements java.io.Serializable {

    private static final long serialVersionUID = -7200095849148417467L;

    protected Long id;
    /**
     * 创建时间 yyyy-MM-dd HH:mm:ss
     */
    protected Date createTimeBegin;
    protected Date createTimeEnd;
    /**
     * 更新时间 yyy-MM-dd HH:mm:ss
     */
    protected Date updateTimeBegin;
    protected Date updateTimeEnd;

    //日期格式化
    protected static final String DATE_FORMAT = "yyyy-MM-dd";

    //时间格式化
    protected static final String TIME_FORMAT = "HH:mm:ss";

    //日期时间格式化
    protected static final String DATE_TIME_FORMAT = "yyyy-MM-dd HH:mm:ss";

    //时间戳格式化
    protected static final String TIMESTAMP_FORMAT = "yyyy-MM-dd HH:mm:ss.S";

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Date getCreateTimeBegin() {
        return createTimeBegin;
    }

    public void setCreateTimeBegin(Date createTimeBegin) {
        this.createTimeBegin = createTimeBegin;
    }

    public Date getCreateTimeEnd() {
        return createTimeEnd;
    }

    public void setCreateTimeEnd(Date createTimeEnd) {
        this.createTimeEnd = createTimeEnd;
    }

    public Date getUpdateTimeBegin() {
        return updateTimeBegin;
    }

    public void setUpdateTimeBegin(Date updateTimeBegin) {
        this.updateTimeBegin = updateTimeBegin;
    }

    public Date getUpdateTimeEnd() {
        return updateTimeEnd;
    }

    public void setUpdateTimeEnd(Date updateTimeEnd) {
        this.updateTimeEnd = updateTimeEnd;
    }
}
