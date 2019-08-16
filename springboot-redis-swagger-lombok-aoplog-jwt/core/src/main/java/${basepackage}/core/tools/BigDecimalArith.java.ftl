/*
 * ${copyright}
 */
package ${basePackage}.core.tools;

import java.math.BigDecimal;

/**
 * BigDecimal 运算类
 *
 * @author borong
 * @date 2019/5/17
 */
public class BigDecimalArith {
    // 默认除法运算精度,小数点后多少位
    private static  int DEF_DIV_SCALE = 2;

    /**
     * 比较大小
     */
    public static boolean bigger(BigDecimal v1, BigDecimal v2) {
        if (v1.compareTo(v2) == 1) {
            return true;
        }
        return false;
    }
    
    public static boolean smaller(Long v1, Long v2) {
        if (BigDecimal.valueOf(v1).compareTo(BigDecimal.valueOf(v2)) == -1) {
            return true;
        }
        return false;
    }

    public static boolean smaller(BigDecimal v1, BigDecimal v2) {
        if (v1.compareTo(v2) == -1) {
            return true;
        }
        return false;
    }
    
    public static boolean equals(BigDecimal v1, BigDecimal v2) {
        if (v1.compareTo(v2) == 0) {
            return true;
        }
        return false;
    }

    // ***********Double类型计算方法 begin ****************//
    /**
     * 提供精确的加法运算。
     *
     * @param v1 被加数
     * @param v2 加数
     * @return 两个参数的和
     */
    public static double addDouble(double v1, double v2) {
        String b3 = addString(Double.toString(v1), Double.toString(v2));
        return Float.valueOf(b3);
    }

    /**
     * 提供精确的减法运算。
     *
     * @param v1 被减数
     * @param v2 减数
     * @return 两个参数的差
     */
    public static double subDouble(double v1, double v2) {
        String b3 = subString(Double.toString(v1), Double.toString(v2));
        return Float.valueOf(b3);
    }

    /**
     * 提供精确的乘法运算。
     *
     * @param v1 被乘数
     * @param v2 乘数
     * @return 两个参数的积
     */
    public static double multiDouble(double v1, double v2) {
        String b3 = multiString(Double.toString(v1), Double.toString(v2));
        return Float.valueOf(b3);
    }

    /**
     * 将double类型四舍五入。
     *
     * @param v1 原数
     * @return 银行家四舍五入后的数字
     */
    public static double roundDouble(double v1) {
        String b3 = FiveString(v1);
        return Double.valueOf(b3);
    }
    /**
     * 将double类型四舍五入。
     *
     * @param v1 原数
     * @return 银行家四舍五入后的数字
     */
    public static double roundDouble(double v1,int def_scale) {
        DEF_DIV_SCALE=def_scale;
        String b3 = FiveString(v1);
        return Double.valueOf(b3);
    }

    // ***********Double类型计算方法 end ****************//
    // ***********Float类型计算方法 begin ****************//
    /**
     * 提供精确的加法运算。
     *
     * @param v1 被加数
     * @param v2 加数
     * @return 两个参数的和
     */
    public static Float addFloat(Float v1, Float v2) {
        String b3 = addString(Float.toString(v1), Float.toString(v2));
        return Float.valueOf(b3);
    }

    /**
     * 提供精确的减法运算。
     *
     * @param v1 被减数
     * @param v2 减数
     * @return 两个参数的差
     */
    public static Float subFloat(Float v1, Float v2) {
        String b3 = subString(Float.toString(v1), Float.toString(v2));
        return Float.valueOf(b3);
    }

    /**
     * 提供精确的乘法运算。
     *
     * @param v1 被乘数
     * @param v2 乘数
     * @return 两个参数的积
     */
    public static Float multiFloat(Float v1, Float v2) {
        String b3 = multiString(Float.toString(v1), Float.toString(v2));
        return Float.valueOf(b3);
    }
 /**
     * 将float类型四舍五入。
     *
     * @param v1 原数
     * @return 银行家四舍五入后的数字
     */
    public static Float roundFloat(Float v1) {
        String b3 = FiveString(v1);
        return Float.valueOf(b3);
    }
    /**
     * 将float类型四舍五入。
     *
     * @param v1 原数
     * @return 银行家四舍五入后的数字
     */
    public static Float roundFloat(Float v1,int def_scale) {
        DEF_DIV_SCALE=def_scale;
        String b3 = FiveString(v1);
        return Float.valueOf(b3);
    }

    // ***********Float类型计算方法 end ****************//
    // ***********String类型计算方法 begin ****************//
    /**
     * 提供精确的加法运算。
     *
     * @param v1 被加数
     * @param v2 加数
     * @return 两个参数的和
     */
    public static String addString(String v1, String v2) {
        BigDecimal b1 = new BigDecimal(v1);
        BigDecimal b2 = new BigDecimal(v2);
        BigDecimal b3 = b1.add(b2);
        return b3.stripTrailingZeros().toPlainString();
    }

    /**
     * 提供精确的减法运算。
     *
     * @param v1 被减数
     * @param v2 减数
     * @return 两个参数的差
     */
    public static String subString(String v1, String v2) {
        BigDecimal b1 = new BigDecimal(v1);
        BigDecimal b2 = new BigDecimal(v2);
        BigDecimal b3 = b1.subtract(b2);
        return b3.stripTrailingZeros().toPlainString();
        
    }

    /**
     * 提供精确的乘法运算。
     *
     * @param v1 被乘数
     * @param v2 乘数
     * @return 两个参数的积
     */
    public static String multiString(String v1, String v2) {
        BigDecimal b1 = new BigDecimal(v1);
        BigDecimal b2 = new BigDecimal(v2);
        BigDecimal b3 = b1.multiply(b2);
        return b3.stripTrailingZeros().toPlainString();
    }
    /**
     * 将String类型四舍五入。
     *
     * @param v1 原数
     * @return 银行家四舍五入后的数字
     */
    public static Float roundString(String v1) {
        String b3 = FiveString(v1);
        return Float.valueOf(b3);
    }
    /**
     * 将String类型四舍五入。
     *
     * @param v1 原数
     * @return 银行家四舍五入后的数字
     */
    public static Float roundString(String v1,int def_scale) {
        DEF_DIV_SCALE=def_scale;
        String b3 = FiveString(v1);
        return Float.valueOf(b3);
    }
    // ***********String类型计算方法 end ****************//

    // ***********BigDecimal类型计算方法 begin ****************//
    /**
     * 提供精确的加法运算。
     *
     * @param v1 被加数
     * @param v2 加数
     * @return 两个参数的和
     */
    public static BigDecimal addBigDecimal(BigDecimal v1, BigDecimal v2) {
        BigDecimal b3 = v1.add(v2);
        return new BigDecimal(b3.stripTrailingZeros().toPlainString());
    }

    /**
     * 提供精确的减法运算。
     *
     * @param v1 被减数
     * @param v2 减数
     * @return 两个参数的差
     */
    public static BigDecimal subBigDecimal(BigDecimal v1, BigDecimal v2) {
        BigDecimal b3 = v1.subtract(v2);
        return new BigDecimal(b3.stripTrailingZeros().toPlainString());
    }

    /**
     * 提供精确的乘法运算。
     *
     * @param v1 被乘数
     * @param v2 乘数
     * @return 两个参数的积
     */
    public static BigDecimal multiBigDecimal(BigDecimal v1, BigDecimal v2) {
        BigDecimal b3 = v1.multiply(v2);
        return new BigDecimal(b3.stripTrailingZeros().toPlainString());
    }

    /**
     * 将BigDecimal类型四舍五入。
     *
     * @param v1 原数
     * @return 银行家四舍五入后的数字
     */
    public static BigDecimal roundBigDecimal(BigDecimal v1) {
        String b3 = FiveString(v1);
        return new BigDecimal(b3);
    }

    /**
     * 将BigDecimal类型四舍五入。
     *
     * @param v1 原数
     * @return 银行家四舍五入后的数字
     */
    public static BigDecimal roundBigDecimal(BigDecimal v1,int def_scale) {
        DEF_DIV_SCALE=def_scale;
        String b3 = FiveString(v1);
        return new BigDecimal(b3);
    }

    /**
     * @param b1 除数
     * @param b2 被除数
     * @param scale 小数位数
     * @param roundingMode 小数模式
     * @return double 小数模式 1、ROUND_CEILING 如果 BigDecimal 是正的，则做 ROUND_UP
     * 操作；如果为负，则做 ROUND_DOWN 操作。 2、ROUND_DOWN 从不在舍弃(即截断)的小数之前增加数字。 3、ROUND_FLOOR
     * 如果 BigDecimal 为正，则作 ROUND_UP ；如果为负，则作 ROUND_DOWN 。 4、ROUND_HALF_DOWN
     * 若舍弃部分> .5，则作 ROUND_UP；否则，作 ROUND_DOWN 。 5、ROUND_HALF_EVEN
     * 如果舍弃部分左边的数字为奇数，则作 ROUND_HALF_UP ；如果它为偶数，则作 ROUND_HALF_DOWN 。
     * 6、ROUND_HALF_UP 若舍弃部分>=.5，则作 ROUND_UP ；否则，作 ROUND_DOWN 。
     * 7、ROUND_UNNECESSARY 该“伪舍入模式”实际是指明所要求的操作必须是精确的，，因此不需要舍入操作。 8、ROUND_UP 总是在非
     * 0 舍弃小数(即截断)之前增加数字。 在计算中出现 721114.0 / 0.93 报错
     * 解决之道：就是给divide设置精确的小数点divide(xxxxx,2, BigDecimal.ROUND_HALF_EVEN)
     * BigDecimal除法运算报错，错误如下： Non-terminating decimal expansion; no exact
     * representable decimal result
     */
    public static double divideDouble(BigDecimal b1, BigDecimal b2, int scale, int roundingMode) {
        return b1.divide(b2, scale, roundingMode).doubleValue();
    }

    /**
     * 同上
     *
     * @param b1 除数
     * @param b2 被除数
     * @param scale 小数位数
     * @param roundingMode 小数模式
     * @return BigDecimal
     */
    public static BigDecimal divide(BigDecimal b1, BigDecimal b2, int scale, int roundingMode) {
        return b1.divide(b2, scale, roundingMode);
    }

    // ***********BigDecimal类型计算方法 end ****************//
    /**
     * 提供精确的精度计算
     */
    private static String FiveString(Object obj) {
        String str = obj.toString();
        Integer pointindex = str.indexOf(".");
        //如果为整数不四舍五入
        if (pointindex == -1) {
            return str;
        }
        //如果小数点后有四位，也不四舍五入
        String pointAfter = str.substring(pointindex);
        //如果小数后的位数在四位之内，则直接返回
        if (pointAfter.length() <= DEF_DIV_SCALE + 1) {
            return str;
        }
        //如果小数点后大于四位， 则进行银行家四舍五入
        //如果小数点后为五位，补为六位。
        if (pointAfter.length() == DEF_DIV_SCALE + 2) {
            pointAfter += "0";
            str += "0";
        }

        //计算
        String pointBeforefour = pointAfter.substring(0, DEF_DIV_SCALE);
        String pointFour = pointAfter.substring(DEF_DIV_SCALE, DEF_DIV_SCALE + 1);
        String pointFive = pointAfter.substring(DEF_DIV_SCALE + 1, DEF_DIV_SCALE + 2);
        String pointSix = pointAfter.substring(DEF_DIV_SCALE + 2, DEF_DIV_SCALE + 3);
        //获取银行家四舍五入后的第四位
        pointFour = BankersRound(pointFour, pointFive, pointSix);
        //返回四位
        String pointBefore = str.substring(0, pointindex);
        //整数部分加上小数点后前三位
        pointBefore = pointBefore + pointBeforefour;;
        //小数点后前三位加上第四位
        Float result = addFloat(Float.valueOf(pointBefore), Float.valueOf(pointFour) /(float)Math.pow(10, DEF_DIV_SCALE));
        return result.toString();
    }

    /**
     * 银行家四舍五入，对于结尾为5的熟，前一位为奇数则进一位，如果为偶数则舍一位。
     * 四舍六入五考虑，五后非零就进一，五后为零看奇偶，五前为偶应舍去，五前为奇要进一
     */
    private static String BankersRound(String fourString, String fiveString, String sixString) {
        
        Integer fourInt = Integer.parseInt(fourString);
        Integer fiveInt = Integer.parseInt(fiveString);
        Integer sixInt = Integer.parseInt(sixString);
        Integer fourMod = fourInt % 2;
        if (fiveInt < DEF_DIV_SCALE + 1) {
            // 四舍，直接返回第四位
            return fourString;
        } else if (fiveInt > DEF_DIV_SCALE + 1) {
            // 六入
            fourInt++;
        } else if (fiveInt == DEF_DIV_SCALE + 1) {
            //四舍六入五考虑，五后非零就进一，五后为零看奇偶，五前为偶应舍去，五前为奇要进一
            if (sixInt != 0) {
                //如果第六位非0
                fourInt++;
            } else {
                if (fourMod > 0) {
                    //如果第四位为奇数,进一
                    fourInt++;
                } else {
                    //第五位舍去
                }
            }
        }
        //直接返回第四位
        return fourInt.toString();
    }
}
