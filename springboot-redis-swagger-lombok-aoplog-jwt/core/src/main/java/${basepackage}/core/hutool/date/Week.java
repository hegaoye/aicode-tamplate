package ${basePackage}.core.hutool.date;

import java.util.Calendar;

/**
 * 星期枚举<br>
 * 与Calendar中的星期int值对应
 *
 * @author Looly
 * @see #SUNDAY
 * @see #MONDAY
 * @see #TUESDAY
 * @see #WEDNESDAY
 * @see #THURSDAY
 * @see #FRIDAY
 * @see #SATURDAY
 */
public enum Week {

    /**
     * 周日
     */
    SUNDAY(Calendar.SUNDAY, "周日"),
    /**
     * 周一
     */
    MONDAY(Calendar.MONDAY, "周一"),
    /**
     * 周二
     */
    TUESDAY(Calendar.TUESDAY, "周二"),
    /**
     * 周三
     */
    WEDNESDAY(Calendar.WEDNESDAY, "周三"),
    /**
     * 周四
     */
    THURSDAY(Calendar.THURSDAY, "周四"),
    /**
     * 周五
     */
    FRIDAY(Calendar.FRIDAY, "周五"),
    /**
     * 周六
     */
    SATURDAY(Calendar.SATURDAY, "周六");

    // ---------------------------------------------------------------
    private int value;
    private String weekName;

    private Week(int value) {
        this.value = value;
    }

    private Week(int value, String weekName) {
        this.value = value;
        this.weekName = weekName;
    }

    public int getValue() {
        return this.value;
    }

    public String getWeekName() {
        return this.weekName;
    }

    /**
     * 将 {@link Calendar}星期相关值转换为Week枚举对象<br>
     *
     * @param calendarWeekIntValue Calendar中关于Week的int值
     * @return {@link Week}
     * @see #SUNDAY
     * @see #MONDAY
     * @see #TUESDAY
     * @see #WEDNESDAY
     * @see #THURSDAY
     * @see #FRIDAY
     * @see #SATURDAY
     */
    public static Week of(int calendarWeekIntValue) {
        switch (calendarWeekIntValue) {
            case Calendar.SUNDAY:
                return SUNDAY;
            case Calendar.MONDAY:
                return MONDAY;
            case Calendar.TUESDAY:
                return TUESDAY;
            case Calendar.WEDNESDAY:
                return WEDNESDAY;
            case Calendar.THURSDAY:
                return THURSDAY;
            case Calendar.FRIDAY:
                return FRIDAY;
            case Calendar.SATURDAY:
                return SATURDAY;
            default:
                return null;
        }
    }
}
