package $package$.core.enums;

/**
 * true/false 枚举
 * Created by $author$ on 2017/6/7.
 */
public enum BetOptionType {
    Mixed_Three,
    Mixed_Six,
    Dragon, Tiger,
    Draw,
    Big, Small,
    Odd, Even,
    Up, Middle, Down,
    Champion_RunnerUp,
    Gold, Wood, Water, Fire, Soil,
    Big_Odd, Big_Even, Small_Odd, Small_Even,
    Straight, Semi_Straight, Leopard, Pair,
    Any_Choose_Five, Any_Choose_Four, Any_Choose_Three, Any_Choose_Two, Any_Choose_One,
    Sum_Top_Three_NumBile, Sum_Last_Three_NumBile;


    //通过值获得性别
    public static BetOptionType getEnum(String name) {
        for (BetOptionType ynEnum : BetOptionType.values()) {
            if (ynEnum.name().equalsIgnoreCase(name)) {
                return ynEnum;
            }
        }
        return null;
    }


}
