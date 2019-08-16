/*
 * ${copyright}
 */
package ${basePackage}.core.tools.area;

import ${basePackage}.core.exceptions.BaseException;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;

/**
 * Created by ${author}
 */
@Slf4j
public class AreaTools {

    /**
     * 区域编码的标准长度
     */
    public final static int AREA_CODE_LENGTH = 12;

    /**
     * 获得行政区域级别
     *
     * @param areaCode
     * @return
     */
    public static int getAreaLevel(String areaCode) {
        if (StringUtils.isEmpty(areaCode)) {
            return 0;
        }
        if (areaCode.length() != AREA_CODE_LENGTH){
            throw new BaseException(BaseException.ExceptionEnums.paramIsEmpty("区域编码[" + areaCode + "]"));
        }
        if (areaCode.lastIndexOf("0000000000") == 2) {
            return 1;
        }
        if (areaCode.lastIndexOf("00000000") == 4) {
            return 2;
        }
        if (areaCode.lastIndexOf("000000") == 6) {
            return 3;
        }
        if (areaCode.lastIndexOf("000") == 9) {
            return 4;
        }
        return 5;
    }


    /**
     * 根据区域编码，获取上级区域编码
     *
     * @param areaCode 区域编码
     * @return 上级区域编码
     */
    public static String getParentAreaCode(String areaCode) {
        String parentAreaCode = "0";
        if (StringUtils.isEmpty(areaCode)) {
            return parentAreaCode;
        }
        return getAreaCodeByLevel(areaCode, getAreaLevel(areaCode) + 1);
    }

    /**
     * 根据传入的区域编码，获取指定级别的区域编码
     *
     * @param areaCode 区域编码
     * @param level    区域级别
     * @return 指定级别的区域编码
     */
    public static String getAreaCodeByLevel(String areaCode, Integer level) {
        if (StringUtils.isBlank(areaCode)) {
            return "";
        }
        if (level == null) {
            return areaCode;
        }
        String aCode = "";
        switch (level) {
            case 1:
                aCode = areaCode.substring(0, 2).concat("0000000000");
                break;
            case 2:
                aCode = areaCode.substring(0, 4).concat("00000000");
                break;
            case 3:
                aCode = areaCode.substring(0, 6).concat("000000");
                break;
            case 4:
                aCode = areaCode.substring(0, 9).concat("000");
                break;
            default:
                aCode = areaCode;
                break;
        }
        return aCode;
    }

    /**
     * 获取区域编码中有效长度的编码
     *
     * @param areaCode 区域编码
     * @return 指定级别的区域编码
     */
    public static String getAreaCodeSub(String areaCode) {
        if (StringUtils.isBlank(areaCode)) {
            return "";
        }
        int level = getAreaLevel(areaCode);
        String aCode = "";
        switch (level) {
            case 1:
                aCode = areaCode.substring(0, 2);
                break;
            case 2:
                aCode = areaCode.substring(0, 4);
                break;
            case 3:
                aCode = areaCode.substring(0, 6);
                break;
            case 4:
                aCode = areaCode.substring(0, 9);
                break;
            default:
                aCode = areaCode;
                break;
        }
        return aCode;
    }
}