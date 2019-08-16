/*
 * ${copyright}
 */
package ${basePackage}.thirdparty.upload.vo;

import lombok.Data;

/**
 * 进度条VO
 */
@Data
public class ProgressVO {
    private Integer currentNum = 1; //当前条数
    private Integer maxNum;         //最大条数
    private Integer errorNum;       //失败条数

    public ProgressVO() {
    }

    public ProgressVO(Integer maxNum) {
        this.maxNum = maxNum;
    }

    public ProgressVO(Integer maxNum, Integer errorNum) {
        this.maxNum = maxNum;
        this.errorNum = errorNum;
    }
}
