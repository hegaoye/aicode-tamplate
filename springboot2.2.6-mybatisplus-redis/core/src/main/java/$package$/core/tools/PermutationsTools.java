package $package$.core.tools;

import com.google.common.collect.Sets;
import lombok.extern.slf4j.Slf4j;

import java.util.Arrays;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

@Slf4j
public enum PermutationsTools {
    Instance;

    /**
     * 计算阶乘数，即n! = n * (n-1) * ... * 2 * 1
     */
    private long factorial(int n) {
        long sum = 1;
        while (n > 0) {
            sum = sum * n--;
        }
        return sum;
    }

    /**
     * 排列计算公式A = n!/(n - m)!
     */
    public long arrangement(int m, int n) {
        return m <= n ? factorial(n) / factorial(n - m) : 0;
    }

    /**
     * 排列选择（从列表中选择n个排列）
     *
     * @param dataList 待选列表
     * @param n        选择个数
     */
    public void arrangementSelect(String[] dataList, int n) {
        System.out.println(String.format("A(%d, %d) = %d", dataList.length, n, arrangement(n, dataList.length)));
        arrangementSelect(dataList, new String[n], 0);
    }

    /**
     * 排列选择
     *
     * @param dataList    待选列表
     * @param resultList  前面（resultIndex-1）个的排列结果
     * @param resultIndex 选择索引，从0开始
     */
    private void arrangementSelect(String[] dataList, String[] resultList, int resultIndex) {
        int resultLen = resultList.length;
        if (resultIndex >= resultLen) { // 全部选择完时，输出排列结果
            System.out.println(Arrays.asList(resultList));
            return;
        }

        // 递归选择下一个
        for (int i = 0; i < dataList.length; i++) {
            // 判断待选项是否存在于排列结果中
            boolean exists = false;
            for (int j = 0; j < resultIndex; j++) {
                if (dataList[i].equals(resultList[j])) {
                    exists = true;
                    break;
                }
            }
            if (!exists) { // 排列结果不存在该项，才可选择
                resultList[resultIndex] = dataList[i];
                arrangementSelect(dataList, resultList, resultIndex + 1);
            }
        }
    }

    /**
     * 组合计算公式C<sup>m</sup><sub>n</sub> = n! / (m! * (n - m)!)
     *
     * @param m
     * @param n
     * @return
     */
    public long combination(int m, int n) {
        return m <= n ? factorial(n) / (factorial(m) * factorial((n - m))) : 0;
    }

    /**
     * 组合选择（从列表中选择n个组合）
     *
     * @param dataList 待选列表
     * @param n        组合数n
     */
    public Set<String> combinationSelect(List<String> dataList, int n) {
        String[] dataArray = (String[]) dataList.toArray();
        log.debug(String.format("C(%d, %d) = %d", dataList.size(), n, combination(n, dataList.size())));
        Set<String> set = Sets.newHashSet();
        combinationSelect(dataArray, 0, new String[n], 0, set);
        return set;

    }

    /**
     * 组合选择
     *
     * @param dataList    待选列表
     * @param dataIndex   待选开始索引
     * @param resultList  前面（resultIndex-1）个的组合结果
     * @param resultIndex 选择索引，从0开始
     */
    private void combinationSelect(String[] dataList, int dataIndex, String[] resultList, int resultIndex, Set<String> set) {
        int resultLen = resultList.length;
        int resultCount = resultIndex + 1;
        if (resultCount > resultLen) { // 全部选择完时，输出组合结果
            String resultStr = "";
            for (String result : resultList) {
                resultStr = resultStr + "," + result;
            }
            set.add(resultStr.replaceFirst(",", ""));
            return;
        }

        // 递归选择下一个
        for (int i = dataIndex; i < dataList.length + resultCount - resultLen; i++) {
            resultList[resultIndex] = dataList[i];
            combinationSelect(dataList, i + 1, resultList, resultIndex + 1, set);
        }
    }

    public static void main(String[] args) {
        String[] drawNumbers = {"1", "2", "3", "4", "5", "6", "7", "8", "9", "10"};
        List<String> list = Arrays.asList(drawNumbers);
        List<Integer> i = list.stream().map(s -> Integer.parseInt(s)).collect(Collectors.toList());
        log.debug("{}", JSON.toJSONString(PermutationsTools.Instance.combinationSelect(Arrays.asList(drawNumbers), 2)));
    }
}
