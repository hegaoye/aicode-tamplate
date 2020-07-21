package $package$.core.tools;

import $package$.core.enums.BetOptionType;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

/**
 * 算法运算工具类
 */
public enum PlayMethodTools {
    Instance;


    /**
     * 判断是否是大数字
     *
     * @param num           备选数字
     * @param bigNumberList 大数字的区间
     * @return true 大 false 小
     */
    public boolean isBigNumber(int num, List<Integer> bigNumberList) {
        if (bigNumberList.contains(num)) {
            return true;
        } else {
            return false;
        }
    }


    /**
     * 判断是否是小数字
     *
     * @param num             备选数字
     * @param smallNumberList 小数字的区间
     * @return true 小 false 大
     */
    public boolean isSmallNumber(int num, List<Integer> smallNumberList) {
        if (smallNumberList.contains(num)) {
            return true;
        } else {
            return false;
        }
    }


    /**
     * 数字求和，判断大小
     *
     * @param bigNumberList 和是大的数字集合
     * @param nums          需要求和的数字数组
     * @return true 大，fase 小
     */
    public boolean isSumBigNumer(List<Integer> bigNumberList, int... nums) {
        int sum = 0;
        for (int num : nums) {
            sum += num;
        }

        return this.isBigNumber(sum, bigNumberList);

    }

    /**
     * 数字求和，判断大小
     *
     * @param smallNumberList 和是小的数字集合
     * @param nums            需要求和的数字数组
     * @return true 小，fase 大
     */
    public boolean isSumSmallNumer(List<Integer> smallNumberList, int... nums) {
        int sum = 0;
        for (int num : nums) {
            sum += num;
        }

        return this.isSmallNumber(sum, smallNumberList);
    }

    /**
     * 判断是否是单，奇
     *
     * @param num           备选数字
     * @param oddNumberList 奇数的集合
     * @return true 单，fase 双
     */
    public boolean isOddNumber(int num, List<Integer> oddNumberList) {
        if (oddNumberList.contains(num)) {
            return true;
        } else {
            return false;
        }
    }

    /**
     * 判断是否是双，偶
     *
     * @param num            备选数字
     * @param evenNumberList 偶数的集合
     * @return true 双，fase 单
     */
    public boolean isEvenNumber(int num, List<Integer> evenNumberList) {
        if (evenNumberList.contains(num)) {
            return true;
        } else {
            return false;
        }
    }


    /**
     * 判断和是单，奇
     *
     * @param oddNumberList 单数集合
     * @param nums          备选数字数组
     * @return true 单，fase 双
     */
    public boolean isSumOddNumber(List<Integer> oddNumberList, int... nums) {
        int sum = 0;
        for (int num : nums) {
            sum += num;
        }
        return this.isOddNumber(sum, oddNumberList);
    }

    /**
     * 判断和是双，偶
     *
     * @param evenNumberList 双数集合
     * @param nums           备选数字数组
     * @return true 双，fase 单
     */
    public boolean isSumEvenNumber(List<Integer> evenNumberList, int... nums) {
        int sum = 0;
        for (int num : nums) {
            sum += num;
        }
        return this.isEvenNumber(sum, evenNumberList);
    }


    /**
     * 判断龙虎和
     *
     * @param firstNumber  第一数字
     * @param secondNumber 第二个数字
     * @return 1 龙，0 和，-1 虎
     */
    public int isDragonTiger(int firstNumber, int secondNumber) {
        if (firstNumber > secondNumber) {
            return 1;
        } else if (firstNumber == secondNumber) {
            return 0;
        } else {
            return -1;
        }
    }

    /**
     * 给定数字以及对比的位置，自动判断龙虎和
     *
     * @param num         数字字符串 如："1，2，3，4，5" 逗号分隔
     * @param firstIndex  第一个数字的位置索引
     * @param secondIndex 第二个数字的位置索引
     * @return 1 龙，0 和，-1 虎
     */
    public int isDragonTiger(String num, int firstIndex, int secondIndex) {
        String[] numArr = num.split(",");
        int firstNumber = Integer.parseInt(numArr[firstIndex - 1]);
        int secondNumber = Integer.parseUnsignedInt(numArr[secondIndex - 1]);
        return this.isDragonTiger(firstNumber, secondNumber);
    }

    /**
     * 计算 豹子，顺子
     *
     * @param firstNumber  第一个数
     * @param secondNumber 第二个数
     * @param thirdNumber  第三个数
     * @return 1 顺子，2 半顺,3 豹子，4 对子，5 杂六
     */
    public BetOptionType leopardStraight(int firstNumber, int secondNumber, int thirdNumber) {
        List<Integer> nums = new ArrayList<>();
        nums.add(firstNumber);
        nums.add(secondNumber);
        nums.add(thirdNumber);
        Collections.sort(nums);
        int firstPlusOne = nums.get(0) + 1;
        int firstPlusTwo = nums.get(0) + 2;
        int secondPlusOne = nums.get(1) + 1;

        if (firstPlusOne == secondNumber && firstPlusTwo == thirdNumber) {
            return BetOptionType.Straight;
        } else if ((firstPlusOne == secondNumber && firstPlusTwo != thirdNumber)
                || (firstPlusOne != secondNumber && secondPlusOne == thirdNumber)) {
            return BetOptionType.Semi_Straight;
        } else if (firstNumber == secondNumber && firstNumber == thirdNumber) {
            return BetOptionType.Leopard;
        } else if ((firstNumber == secondNumber && secondNumber != thirdNumber)
                || (firstNumber != secondNumber && secondNumber == thirdNumber)) {
            return BetOptionType.Pair;
        } else {
            return BetOptionType.Mixed_Six;
        }

    }

    /**
     * 计算 豹子，顺子
     *
     * @param nums        数字字符串 如："1，2，3，4，5" 逗号分隔
     * @param firstIndex  第1个数的索引位置
     * @param secondIndex 第2个数的索引位置
     * @param thirdIndex  第3个数的索引位置
     * @return 1 顺子，2 半顺,3 豹子，4 对子，5 杂六
     */
    public BetOptionType leopardStraight(String nums, int firstIndex, int secondIndex, int thirdIndex) {
        String[] numArr = nums.split(",");
        int firstNumber = Integer.parseInt(numArr[firstIndex - 1]);
        int secondNumber = Integer.parseInt(numArr[secondIndex - 1]);
        int thirdNumber = Integer.parseInt(numArr[thirdIndex - 1]);

        return this.leopardStraight(firstNumber, secondNumber, thirdNumber);
    }

    public static void main(String[] args) {
        System.out.println("12".substring(2 - 1));
    }
}
